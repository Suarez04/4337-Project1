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

