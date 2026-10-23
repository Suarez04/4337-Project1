Session times are in Chicago time (CDT, UTC-05:00).

# 10/16/26 - 3:40 p.m. - Project plan: session start

Review the prefix calculator requirements and decide the implementation order, history representation, and approach to division and output formatting.

# 10/16/26 - 4:24 p.m. - Project plan: session end

The project is a prefix calculator in Racket. The plan is to build the expression parser first, then the input loop and history, then test the examples and errors. History will be passed to the loop as a list.

The handout says integer division, but samples 2 and 3 expect fractional results. The implementation will use regular division to match the examples. The handout also requires printing floating point results even though some sample outputs omit .0. We will follow the explicit printing rule.

# 10/17/26 - 4:20 p.m. - Parser: session start

Implement the recursive expression parser, including numbers, history references, unary negation, binary operators, and rejection of trailing input.

# 10/17/26 - 6:37 p.m. - Parser: session end

Implemented recursive parsing for numbers, history references, unary negation, and the three binary operators. Each parser returns the value and unused input, which lets nested expressions work without mutable parser state. The top-level evaluator rejects trailing input. Runtime testing is still pending while a local Racket runtime is obtained.

# 10/22/26 - 3:15 p.m. - Input and history: session start

Add interactive and batch modes, pass history through the input loop, keep errors from changing history, and handle quit and EOF.

# 10/22/26 - 5:06 p.m. - Input and history: session end

Added the interactive loop and the -b/--batch options using the supplied mode detection approach. The loop passes the history list recursively. Only successful expressions are added, and errors leave the history unchanged. EOF exits as well as quit, so redirected files end cleanly. Results use real->double-flonum and display as required. Next step is to run sample inputs and targeted invalid expressions.

# 10/23/26 - 2:10 p.m. - Validation: session start

Write evaluator checks covering nested expressions, history lookup, fractional values, whitespace, and invalid input. Prepare command-line sample checks.

# 10/23/26 - 3:12 p.m. - Validation: session end

Added evaluator checks for nested expressions, fractional results from the examples, oldest/newest history lookup, decimals, whitespace, invalid references, missing operands, division by zero, and trailing input. These tests are in tests.rkt and do not require third-party packages. The sample runs also need to be checked through the command-line interface, including whether errors consume history IDs.

