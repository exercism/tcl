## The Tcl `apply` command

The test cases may look confusing. You are expected to implement this: 
```tcl
set myList {alpha beta gamma delta}
listOps::filter $myList {{word} {expr {[string length $word] == 4}}
```
Why does that last argument have so many braces?

Recall that the `proc` command is defined as:
```tcl
proc procName argList body
```

Tcl has an `apply` command:
```tcl
apply func ?arg1 arg2 ...?
```
this "func" is a two element list `{argList body}` that is essentially an
anonymous proc (or "lambda"). The `apply` command invokes that anonymous
proc, passing it the arguments it needs.

As an example, these are equivalent:
```tcl
# using proc
proc myReverse {str} {return [string reverse $str]}
puts [myReverse "Hello, World!"]

# using apply
puts [apply {{str} {string reverse $str}} "Hello, World!"]

# or, store the func in a variable
set func {{str} {string reverse $str}}
puts [apply $func "Hello, World!"]
```
Using `apply` makes it simpler to pass around blocks of code.

Ref: [`apply`](https://tcl.tk/man/tcl8.6/TclCmd/apply.htm),
[`proc`](https://tcl.tk/man/tcl8.6/TclCmd/proc.htm).
