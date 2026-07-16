# A template module
#
# Copyright (C) 2018-2019 Lawrence Woodman <lwoodman@vlifesystems.com>
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#

package require Tcl 8.6-

namespace eval ornament {
  namespace export {[a-z]*}
  namespace ensemble create
  # The normal number of safe interpreters ready for use
  variable BASE_NUM_INTERPS 10
}

# Inspired by: http://wiki.tcl.tk/18455
# Compiles the template into a script
proc ornament::compile {tpl {var _OUT}} {
  set cfg {
    commandChar "!"
    backslashSubst false
    commandSubst false
    variableSubst false
  }

  set script ""
  set lines [split $tpl "\n"]
  set lineNum 1
  set lastLineNum [expr {[llength $lines]}]

  foreach line $lines {
    set commandChar [dict get $cfg commandChar]
    # A template command consists of $commandChar followed by another character
    # or is the only character on a line
    if {[string index $line 0] eq $commandChar} {
      switch -regexp [string range $line 1 end] [list \
        {^#.*$}  - \
        "^$commandChar\\s*$" - \
        {^\s*$}  {} \
        {^\\.*$} {append script "[string range $line 2 end] "} \
        "^$commandChar.*$"  - \
        {^ .*$}  {append script "[string range $line 2 end]\n"} \
        {^\*.*$} {set cfg [ProcessCfg $cfg [string range $line 2 end]]} \
        default {
          return -code error \
            "unrecognized template command '[string range $line 0 1]' at start of line number: $lineNum"
        } \
      ]
    } else {
      set substOptions [MakeSubstOptions $cfg]
      if {$lineNum != $lastLineNum} {
        append script \
          "append $var \"\[" [list subst {*}$substOptions $line] "]\n\"\n"
      } else {
        # This stops you from getting an extra newline at the end
        append script \
          "append $var \"\[" [list subst {*}$substOptions $line] "]\"\n"
      }
    }
    incr lineNum
  }
  return $script
}


# Runs the compiled template script with the supplied cmds and vars in dicts
proc ornament::run {script {cmds {}} {vars {}}} {
  set safeInterp [GetInterp]
  try {
    dict for {templateCmdName cmdInvokation} $cmds {
      $safeInterp alias $templateCmdName {*}$cmdInvokation $safeInterp
    }
    dict for {varName value} $vars {
      $safeInterp eval [list set $varName $value]
    }
    return [$safeInterp eval $script]
  } on error {result options} {
    return -code error $result
  } finally {
    FreeInterp $safeInterp
  }
}

proc ornament::Init {} {
  variable safeInterps
  variable safeAliases
  variable BASE_NUM_INTERPS
  for {set i 0} {$i < $BASE_NUM_INTERPS} {incr i} {
    NewInterp
  }
  lassign [dict keys $safeInterps] firstInterp
  # The initial aliases are recorded as they can be useful for things
  # such as clock
  foreach aliasToken [$firstInterp aliases] {
    dict set safeAliases $aliasToken [$firstInterp alias $aliasToken]
  }
}

proc ornament::ResetInterp {interpName} {
  variable safeAliases
  $interpName eval {unset {*}[info vars]}
  foreach aliasToken [$interpName aliases] {
    $interpName alias $aliasToken {}
  }
  dict for {aliasToken target} $safeAliases {
    $interpName alias $aliasToken {*}$target
  }
}

# Returns a safe interpreter
proc ornament::GetInterp {} {
  variable safeInterps
  dict for {name inUse} $safeInterps {
    if {!$inUse} {
      dict set safeInterps $name true
      ResetInterp $name
      return $name
    }
  }
  set safeInterp [NewInterp]
  dict set safeInterps $safeInterp true
  return $safeInterp
}

proc ornament::NewInterp {} {
  variable safeInterps
  set interpName [namespace which [interp create -safe]]
  $interpName eval {unset {*}[info vars]}
  dict set safeInterps $interpName false
  return $interpName
}

# Call when finished with an interpreter to mark it as no longer
# being used
proc ornament::FreeInterp {interpName} {
  variable BASE_NUM_INTERPS
  variable safeInterps
  dict set safeInterps $interpName false
  dict for {name inUse} $safeInterps {
    if {$inUse} {
      return
    }
  }
  set names [dict keys $safeInterps]
  if {[llength $names] > $BASE_NUM_INTERPS} {
    set excessNames [lrange $names $BASE_NUM_INTERPS end]
    foreach name $excessNames {
      dict unset safeInterps $name
      interp delete [namespace tail $name]
    }
  }
}

proc ornament::ProcessCfg {cfg newCfgString} {
  if {[llength $newCfgString] % 2 != 0} {
    return -code error "invalid config string"
  }
  dict for {f v} $newCfgString {
    switch $f {
      commandChar {
        set validCommandChars {! % @ ~}
        if {[lsearch -exact $validCommandChars $v] == -1} {
          return -code error -level 2 "invalid config commandChar value: $v"
        }
      }
      backslashSubst {
        if {![string is boolean -strict $v]} {
          return -code error -level 2 "invalid config backslashSubst value: $v"
        }
      }
      commandSubst {
        if {![string is boolean -strict $v]} {
          return -code error -level 2 "invalid config commandSubst value: $v"
        }
      }
      variableSubst {
        if {![string is boolean -strict $v]} {
          return -code error -level 2 "invalid config variableSubst value: $v"
        }
      }
      default {
        return -code error -level 2 "invalid config field: $f"
      }
    }
    dict set cfg $f $v
  }
  return $cfg
}

proc ornament::MakeSubstOptions {cfg} {
  set substOptions [list]
  set map [dict create \
    backslashSubst -nobackslashes \
    commandSubst -nocommands \
    variableSubst -novariables \
  ]
  foreach {configName substOption} $map {
    if {![dict get $cfg $configName]} {
      lappend substOptions $substOption
    }
  }
  return $substOptions
}

namespace eval ornament {Init}
