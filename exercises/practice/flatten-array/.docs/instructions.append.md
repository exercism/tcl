# Append

## "Null" in Tcl

Tcl does not have a `null` or `nil` value.
In practice, the empty string is often used to indicate "no value".
But that can be tricky in situations where an empty string is actually a valid value, for example in a list representing a row of CSV data.

For this exercise, treat the empty string as a null value that is to be discarded.
