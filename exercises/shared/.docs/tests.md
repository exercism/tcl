# Tests

Each exercise contains a test file.
Because Exercism promotes [Test-Driven Development][tdd], the tests *are* the requirements.
Make sure to read the tests to understand how your code will be invoked, and what output is expected.

To run the test suite:
```bash
tclsh exercise.test
```

## Skipped tests

Solving an exercise means making all its tests pass. By default, only one
test (the first one) is executed when you run the tests. This is
intentional, as it allows you to focus on just making that one test pass.
Once it passes, you can enable the next test by commenting out or removing
the `skip` command preceding it.

Alternately, to run all the tests regardless of their "skipped" status:
```bash
RUN_ALL=1 tclsh exercise.test
```

[tdd]: https://exercism.org/docs/using/solving-exercises/tdd
