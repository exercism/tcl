# Exercism Tcl Track

![build status](https://travis-ci.org/exercism/tcl.svg?branch=main)

Exercism exercises in [Tcl](https://www.tcl-lang.org/).

## Setup

Tcl installation is described in the [INSTALLATION](docs/INSTALLATION.md) document.

## Contributing

Please read the [CONTRIBUTING](CONTRIBUTING.md) doc.

## Exercise Tests

At the most basic level, Exercism is all about the tests. You can read more about how we think about test suites in [the Exercism documentation](https://exercism.org/docs/using/solving-exercises/tdd).

Tcl test files use the [`tcltest`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/tcltest.htm) core package. Here are two excellent introductory overviews:

* [Getting started with tcltest](https://web.archive.org/web/20080617153002/www.tclscripting.com/articles/apr06/article1.html)
* [Getting Started with tcltest](https://wuhrr.wordpress.com/2011/03/28/getting-started-with-tcltest/) (goes more in-depth)


## Opening an Issue

If you plan to make significant or breaking changes, please [create a topic on the forum](https://forum.exercism.org/c/programming/tcl/117) so we can discuss it first.

## Submitting a Pull Request

Pull requests should be focused on a single exercise, issue, or conceptually cohesive change. Please refer to Exercism's [pull request guidelines](https://exercism.org/docs/building/github/contributors-pull-request-guide).

Please follow the coding standards for Tcl. (_TODO: reference one..._)

### Verifying Your Change

Before submitting your pull request, you'll want to verify the changes in two ways:

* Run all the tests for the Tcl exercises
* Run an Exercism-specific linter to verify the track

All the tests for Tcl exercises can be run from the top level of the repo with

```sh
$ bin/check_exercise_versions
# ensure you have committed your code before running the following:
$ bin/test_all_exercises
```

Note that the `test_all_exercises` script will **overwrite** the `"slug".tcl` and then check it out again from git when the test is complete. If you have not committed your code, you risk losing that template file.

To run the linter, use the [`configlet`](https://exercism.org/docs/building/configlet) tool:
```sh
$ path/to/configlet lint .
```

## Contributing a New Exercise

Please see the documentation about [adding new exercises](https://exercism.org/docs/building/tracks/practice-exercises/add).

Note that:

- Each exercise must stand on its own. Do not reference files outside the exercise directory. They will not be included when the user fetches the exercise.
- Exercises should use only the Tcl core libraries.
- Exercises must conform to the Exercism-wide standards described in [the documentation](https://exercism.org/docs/building/tracks/practice-exercises).
- Each exercise should have a test suite, an example solution and a template file for the real implementation. Use the `canonical-data.json` file for the exercise from the [problem-specifications](https://github.com/exercism/problem-specifications) repo to guide your test implementation.
- The CI build expects files to be named using the following convention: 

        exercises/
        └── hello-world/            # (dir name == "slug" name)
            ├── .meta
            │   ├── hints.md        # (optional)
            │   └── version         # (required)
            ├── example.tcl
            ├── hello-world.tcl     # "slug".tcl
            ├── hello-world.test    # "slug".test
            └── README.md           # (generated)

- use `configlet generate . --only $slug` to generate the README file. The contents of `.meta/hints.md` will be incorporated into the README if you need to add Tcl-specific information.
- Please do not commit any configuration files or directories inside the exercise.
- Be sure to reference the new exercise at the appropriate place in the `config.json` file.
    - Core exercises are placed at the top of the config file, in the order we want them to occur.
    - Side exercises (that are unlocked when a core exercise is completed) are placed below, grouped and ordered by their parent core exercise.
