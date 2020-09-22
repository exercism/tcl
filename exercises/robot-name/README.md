# Robot Name

Manage robot factory settings.

When a robot comes off the factory floor, it has no name.

The first time you turn on a robot, a random name is generated in the format
of two uppercase letters followed by three digits, such as RX837 or BC811.

Every once in a while we need to reset a robot to its factory settings,
which means that its name gets wiped. The next time you ask, that robot will
respond with a new random name.

The names must be random: they should not follow a predictable sequence.
Using random names means a risk of collisions. Your solution must ensure that
every existing robot has a unique name.


## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.

## Running the tests
To run the test suite, execute one of the following commands:

```bash
tclsh robot-name.test            # Will stop testing after the first failure.
RUN_ALL=1 tclsh robot-name.test  # Will run all tests and report all failures.
```

## Feedback, Issues, Pull Requests
The [exercism/tcl](https://github.com/exercism/tcl) repository on GitHub is
the home for all of the Tcl exercises on Exercism.

If you have feedback about an exercise, or want to help implementing a new
one, head over there and create an issue.  We'll do our best to help you!

## Source

A debugging session with Paul Blackwell at gSchool.

