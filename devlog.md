Session times are in Chicago time (CDT, UTC-05:00).

# 10/16/26 - 3:40 p.m. - Project plan: session start

Review the prefix calculator requirements and decide the implementation order, history representation, and approach to division and output formatting.

# 10/16/26 - 4:24 p.m. - Project plan: session end

The project is a prefix calculator in Racket. The plan is to build the expression parser first, then the input loop and history, then test the examples and errors. History will be passed to the loop as a list.

The handout says integer division, but samples 2 and 3 expect fractional results. The implementation will use regular division to match the examples. The handout also requires printing floating point results even though some sample outputs omit .0. We will follow the explicit printing rule.

