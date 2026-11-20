# Instructions append

## The task

Implement two procedures.

- `custom_error_message message` raises an error, and `message` is the error message.
- `handle_error script` runs the given script and returns a string that describes what happened:

  | When the script…                  | return               |
  | --------------------------------- | -------------------- |
  | divides by zero                   | `"division by zero"`    |
  | opens a file that does not exist  | `"file does not exist"` |
  | calls a proc that does not exist  | `"proc does not exist"` |
  | raises any other error            | `"unknown error"`       |
  | succeeds                          | `"success"`             |

## Raising errors

Tcl has two commands for raising an error.

```tcl
error "something went wrong"
throw {MYAPP BADTHING} "something went wrong"
```

`throw` requires an _error code_ as its first argument.
The error code is a list that tells a handler what kind of error happened, so it can respond without parsing the message text.
Its contents are up to you: `{MYAPP BADTHING}` is just an example, and any non-empty list will do.
By convention, it goes from general to specific.
A handler catches it with a matching `try ... trap` pattern (described below), such as `trap {MYAPP BADTHING}`, or `trap {MYAPP}` to catch every `MYAPP` error.
`error` takes an optional error code as its third argument: `error message ?info? ?code?`.

## Handling errors with `catch`

[`catch`][catch] runs a script and returns an integer _completion code_ instead of raising the error:

| code | meaning    |
| ---- | ---------- |
| 0    | `ok`       |
| 1    | `error`    |
| 2    | `return`   |
| 3    | `break`    |
| 4    | `continue` |

```tcl
if {[catch {expr {1 / 0}} result options] == 1} {
    puts "error message: $result"
    puts "error code:    [dict get $options -errorcode]"
}
```
```none
error message: divide by zero
error code:    ARITH DIVZERO {divide by zero}
```

The optional second argument receives the result (or the error message).
The optional third argument receives an _options dictionary_, which has the `-errorcode` and the `-errorinfo` (the stack trace).

Pros:

- It is small and flexible.
- It is short for simple cases, such as `if {[catch {open $f} fh]} {...}`.

Cons:

- You have to check the completion code yourself.
  A careless `if {[catch ...] != 0} { handle error }` treats `return`, `break` and `continue` as errors too.
- Errors you do not handle are swallowed unless you re-raise them yourself.
- There is no built-in way to run cleanup code whether or not the script failed.

## Handling errors with `try`

[`try`][try] runs a script and sends the outcome to the first matching handler.
An optional `finally` clause always runs, which makes it a good place to release resources such as file channels.

```tcl
set fh [open $filename r]
try {
    set data [read $fh]
} on error {msg options} {
    puts "could not read $filename: $msg"
} finally {
    close $fh
}
```

Pros:

- The structure is clear: one handler for each kind of outcome.
- `finally` always runs.
- Outcomes that no handler matches are passed up to the caller unchanged.

Cons:

- It is a little more verbose than `catch` for simple cases.

### `try ... on` versus `try ... trap`

There are two kinds of handler.

`on code {msgVar optionsVar}` matches the _completion code_: `ok`, `error`, `return`, `break` or `continue`.
Every error has the completion code `error`, so `on error` cannot tell a division by zero from a missing file.
You would have to look at the message text, which is brittle: messages are meant for humans and can change between Tcl versions.

```tcl
try {
    expr {$a / $b}
} on error {msg} {
    if {[string match "*divide by zero*" $msg]} { ... }
}
```

`trap pattern {msgVar optionsVar}` matches the _error code_.
The handler matches when the pattern is a prefix of the `-errorcode` list.
This picks out the kind of error reliably.

```tcl
try {
    expr {$a / $b}
} trap {ARITH DIVZERO} {} {
    puts "division by zero"
} trap {} {msg} {
    puts "some other error: $msg"
}
```

An empty pattern, `trap {}`, matches any error.
Handlers are checked in order, so put the catch-all last.

## Finding the error code

Where is `ARITH DIVZERO` documented?
Mostly only in the source code, but Tcl will show it to you.
After an error, the global variable `errorCode` holds the error code of the most recent error:

```none
$ tclsh
% set a 1; set b 0
% expr {$a / $b}
divide by zero
% set errorInfo     ;# this is the stack trace
divide by zero
    while executing
"expr {$a / $b}"
% set errorCode     ;# this is what we're after
ARITH DIVZERO {divide by zero}
```

Inside a program, get it from the options dictionary:

```tcl
try {
    expr {$a / $b}
} on error {msg options} {
    puts [dict get $options -errorcode]
}
```

The last element of an error code is often a human-readable message, or the name of the thing that caused the error.
Leave it out of your `trap` pattern: trap `{ARITH DIVZERO}`, not `{ARITH DIVZERO {divide by zero}}`.

### Some common error codes

This table is not complete.
Use the technique above to find the code for any other error.

| Situation             | Example                  | Error code                    |
| --------------------- | ------------------------ | ----------------------------- |
| Division by zero      | `expr {1 / 0}`           | `ARITH DIVZERO ...`           |
| Math domain error     | `expr {sqrt(-1)}`        | `ARITH DOMAIN ...`            |
| File not found        | `open nosuchfile r`      | `POSIX ENOENT ...`            |
| Permission denied     | `open /root/x w`         | `POSIX EACCES ...`            |
| Unknown command       | `no::such::proc`         | `TCL LOOKUP COMMAND name`     |
| Unknown variable      | `set nosuchvar`          | `TCL LOOKUP VARNAME name`     |
| Wrong number of args  | `string length a b`      | `TCL WRONGARGS`               |
| Invalid dictionary    | `dict size {1 2 3}`      | `TCL VALUE DICTIONARY`        |
| Invalid list          | `llength "a \{b"`        | `TCL VALUE LIST ...`          |

`POSIX` error codes use the operating system's `errno` names, such as `ENOENT`, `EACCES` and `EEXIST`.

## Hint: where the script runs

`handle_error` receives a script from its caller.
If you run it with `try $script`, it is evaluated in the scope of `handle_error`, not of the caller.
To evaluate it where it was written, use [`uplevel`][uplevel]: `try {uplevel 1 $script} ...`.

## Resources

- The Tcl Wiki entry on [Errors management](https://wiki.tcl-lang.org/page/Errors+management).
- Man pages: [`try`][try], [`catch`][catch], [`throw`][throw], [`error`][error], [`return`][return].
- The [`errorCode` variable][errorCode] in the `tclvars` man page.

[try]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/try.htm
[catch]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/catch.htm
[throw]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/throw.htm
[error]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/error.htm
[return]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/return.htm
[uplevel]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/uplevel.htm
[errorCode]: https://www.tcl-lang.org/man/tcl8.6/TclCmd/tclvars.htm#M12
