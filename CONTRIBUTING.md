# How to contribute to the Exercism Tcl track

## **Do you want to report a bug?**

- **Ensure the bug was not already reported** by searching the [forum][forum].

- If you're unable to find an open conversation addressing the problem, [open a new one][forum-new-topic].
  Be sure to include a **title and clear description**, as much relevant information as possible, and (when possible) a **code sample**.

## **Do you want to fix a bug?**

- **Ensure that the bug is reported (see above).**
  Only start fixing the bug when there is agreement on whether (and how) it should be fixed.

- Fix the bug and [submit a Pull Request][pr-guide] to this repository.

- Ensure the PR description clearly describes the problem and solution.
  Include a link to the bug's corresponding forum conversation.

- Before submitting, please read the [Contributors Pull Request Guide][pr-guide] and [Pull Request Guide][pr-other-guide].

## **Do you intend to add a new feature or change an existing one?**

- **Ensure that the feature or change is discussed on the [forum][forum].**
  Only start adding the feature or change when there is agreement on whether (and how) it should be added or changed.

- Fork the exercism/tcl repo, add the feature or change in your clone, and [submit a Pull Request][pr-guide] to this repository.

- Ensure the PR description clearly describes the problem and solution.
  Include a link to the bug's corresponding forum conversation.

- Before submitting, please read the [Contributors Pull Request Guide][pr-guide] and [Pull Request Guide][pr-other-guide].

## **Do you want to add an exercise?**

- **Ensure that someone else isn't already adding it**
    - start with [notes on unimplemented exercises][exercise-list].
    - also search the [forum][forum] and the repository's [issues][gh-issues] and [pull requests][gh-pulls].

- If nobody is yet adding the exercise, [open a conversation on the forum][forum] and indicate you would like to add it.

### Creating a new Practice Exercise

1. Run the scaffolding script from the repo root:

    ```sh
    bin/add-practice-exercise <slug>
    ```

    Optionally specify a difficulty (1–10) and/or your GitHub username:

    ```sh
    bin/add-practice-exercise -d 5 -a your-github-username <slug>
    ```

    This fetches the latest `configlet` and runs `configlet create`, which:

    - Creates the exercise directory `exercises/practice/<slug>/`
    - Populates `.meta/config.json` (with your username as author)
    - Populates `.meta/tests.toml` with all UUID entries from the canonical data
    - Creates stub files for `<slug>.tcl`, `<slug>.test`, and `.meta/example.tcl`
    - Adds the exercise entry to the track's `config.json`

1. Write the test suite in `<slug>.test`.

   The canonical data is in the [problem-specifications][prob-specs] repository
   and is also available locally in `canonical-data/<slug>.json` (fetched automatically
   by the generator, see below).

   Review the canonical data and decide if any test cases should be excluded.
   If so, add `include = false` to those entries in `.meta/tests.toml`:

    ```toml
    [<uuid>]
    description = "some test case description"
    include = false
    ```

   Decide whether to use the test generator or write the test suite by hand:

    - If **writing by hand**:
        - Use the canonical data to create the tests.
        - Remember: this track uses TDD, so the first test is live and all the rest are preceded
          by a `skip` call.

    - If **using the generator**:

        1. Copy `lib/generator.tmpl` as a starting point for `.meta/generator.tmpl` and edit it.
           See the [Generator template](#generator-template) section below for details.

        1. Run the generator and review the new test suite:

            ```sh
            bin/generate-tests exercises/practice/<slug>
            ```

            Loop back to the previous step as needed.

1. Create `testHelpers.tcl` in the exercise directory.

   The `skip` and `cleanupTests` overrides are required in every exercise.
   Copy only the optional custom matchers you need from `lib/testHelpers.tcl`.
   See an existing exercise for an example.

1. Create the example solution in `.meta/example.tcl`.

1. Verify the example solution passes the tests:

    ```sh
    bin/test_one_exercise exercises/practice/<slug>
    ```

1. Create the stub solution in `<slug>.tcl`.
   Provide a stub for every procedure being tested.
   The stub should `throw` a `NOT_IMPLEMENTED` error:

    ```tcl
    proc myProc {args} {
        throw {NOT_IMPLEMENTED} "Implement this procedure."
    }
    ```

   See other exercises for examples.

1. Update the `difficulty` for the exercise in the track's `config.json` if needed.

1. Lint and format the track:

    ```sh
    bin/configlet lint
    bin/configlet fmt
    ```

---

## Generator template

The test generator (`bin/generate-tests`) uses the [Ornament][ornament] templating engine.
Templates live at `.meta/generator.tmpl` within each exercise.

`lib/generator.tmpl` provides a working skeleton you can copy and adapt.

### Ornament syntax

Lines beginning with `!` are Tcl code; all other lines are literal output.
Enable variable and command substitution at the top of every template:

```
!* variableSubst true
!* commandSubst true
```

### Variables available in the template

| Variable | Contents |
|---|---|
| `$header` | Standard test file preamble (package requires, `source` calls, timestamp) |
| `$footer` | `cleanupTests` |
| `$slug` | The exercise slug (e.g. `raindrops`) |
| `$cases` | A list of dicts; each dict is one test case from the canonical data |

Each case dict contains at minimum: `uuid`, `description`, `property`, `input`, `expected`, and `group`.

### Helper commands available in the template

| Command | Description |
|---|---|
| `testTitle $case` | Returns a properly-quoted test title combining the group and description |
| `tclString $str` | Returns a Tcl-quoted string literal, with `$` and `[` escaped |
| `asList $list ?options?` | Formats a Tcl list; supports `-strings`, `-lists`, `-multiline`, `-indent` |
| `pdict $dict ?options?` | Pretty-prints a dict with indentation; supports `-indent` |

### Minimal template example

```
!* variableSubst true
!* commandSubst true
$header

! set i 0
! foreach case $cases {
!   set test_id "${slug}-[incr i]"
!   if {$i > 1} {
skip $test_id
!   }
test $test_id [testTitle $case] -body {
    [dict get $case property] [dict get $case input number]
} -returnCodes ok -result [dict get $case expected]

! }

$footer
```

---

## Test helpers

Every exercise includes a `testHelpers.tcl` file.
The `skip` and `cleanupTests` overrides are required in every exercise's `testHelpers.tcl`.
Copy only the custom matchers your exercise actually needs from `lib/testHelpers.tcl`.

The available custom matchers for use with `-match` in `tcltest` are:

| Matcher | Usage |
|---|---|
| `dictionary` | Deep equality of two dicts |
| `boolean` | Compares boolean values regardless of their string representation (`yes`/`true`/`1` etc.) |
| `orderedLists` | Element-wise equality of two lists (not string equality) |
| `unorderedLists` | Same elements, any order |
| `listOfLists` | Recursive element-wise equality |
| `inList` | The actual value is one of several acceptable values |
| `float` | Approximate floating-point equality (epsilon `1e-6`) |

Example usage:

```tcl
test myexercise-1 "approximate result" -body {
    myProc 1.0
} -match float -result 3.14159
```

---

## Running all exercises

```sh
bin/test_all_exercises
```

To test a single exercise:

```sh
bin/test_one_exercise exercises/practice/<slug>
```

To find exercises that do not yet have a generator template:

```sh
bin/missing-templates
```

---

## Linting

Use the [`configlet`][configlet] tool to lint and format the track:

```sh
bin/fetch-configlet     # download the latest configlet binary
bin/configlet lint
bin/configlet fmt
```

---

[forum]: https://forum.exercism.org/c/programming/tcl
[forum-new-topic]: https://forum.exercism.org/new-topic?category=tcl
[pr-guide]: https://exercism.org/docs/building/github/contributors-pull-request-guide
[pr-other-guide]: https://exercism.org/docs/community/being-a-good-community-member/pull-requests
[exercise-list]: ./notes-on-unimplemented-exercises.md
[gh-issues]: https://github.com/exercism/tcl/issues
[gh-pulls]: https://github.com/exercism/tcl/pulls
[ornament]: https://techtinkering.com/articles/introducing-ornament-a-tcl-template-module/
[prob-specs]: https://github.com/exercism/problem-specifications
[configlet]: https://exercism.org/docs/building/configlet
