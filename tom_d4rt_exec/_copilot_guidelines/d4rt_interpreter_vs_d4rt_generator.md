# D4rt Interpreter vs Generator Boundary

This guideline is maintained in `tom_d4rt`:

**[`tom_d4rt/_copilot_guidelines/d4rt_interpreter_vs_d4rt_generator.md`](../../tom_d4rt/_copilot_guidelines/d4rt_interpreter_vs_d4rt_generator.md)**

It says which interpreter code is generator support (the `D4` helpers and the
user-bridge annotations that generated bridges call) and which is pure
interpreter logic, and so where a bug belongs: `tom_d4rt_generator/doc/issues.md`
or `tom_d4rt/doc/issues.md`. This package re-exports the analyzer-free
interpreter from `tom_d4rt_ast`, whose files mirror the ones it names.

Keep this file a pointer. It used to be a byte-identical copy of the
`tom_d4rt` one with nothing keeping the two in step.
