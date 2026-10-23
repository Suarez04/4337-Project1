# Project 1 - Prefix Calculator

A command-line prefix calculator written in Racket.

## Files

- `calculator.rkt`: expression parser, history, and input loop.
- `tests.rkt`: 32 checks for the evaluator, using only Racket.
- `devlog.md`: development notes with session times.
- `instructions/`: instructor handouts, sample devlog, mode detection code, and sample runs.
- `.gitignore`: ignores generated Racket files and macOS metadata.
- `calculator-progress.rkt`: implementation added in stages.
- `.git/`: local Git repository.

## Running

Racket must be installed. No IDE or third-party libraries are needed.
From this directory:

```sh
racket calculator.rkt
```

Batch mode prints results and errors without prompts:

```sh
racket calculator.rkt -b < instructions/sample-runs/input1.txt
racket calculator.rkt --batch < instructions/sample-runs/input2.txt
```

Enter exactly `quit` to stop. End of input also stops the program.

## Expressions

The operator goes before its arguments. `+ 2 3` gives `5.0`, and
`* + 2 3 4` gives `20.0`. The operators are `+`, `*`, `/`, and unary `-`.
For example, `+ 5 - 2` gives `3.0`. There is no binary subtraction.
Whitespace separates adjacent numbers but is otherwise optional.

Successful results get IDs starting at 1. `$1` refers to the first result,
`$2` to the second, and so on. Errors do not add history entries.
The program prints `Error: Invalid expression` for invalid input.

## Testing and notes for grading

Run the evaluator checks:

```sh
racket tests.rkt
```

Tested with Racket 8.18 on macOS. All 32 evaluator checks passed. All five
provided sample inputs were also checked in both batch modes for result
values, history IDs, and error positions. Interactive prompts, EOF, exact
quit matching, and history after errors were checked separately.
The code has not been run on cs1 or cs2; it uses only standard Racket.

There are two conflicts between the handout and the sample outputs:

- The handout calls `/` integer division, but samples 2 and 3 expect `2.5`
  and `19.5`. This program uses regular division to match the samples.
- The samples print whole numbers without `.0`. The handout explicitly
  requires `real->double-flonum` followed by `display`, so this program
  prints `2.0`, for example. Sample comparisons used numeric values.

The devlog contains development notes with session times.
