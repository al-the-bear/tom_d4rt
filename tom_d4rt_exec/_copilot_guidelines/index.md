# D4rt Exec Project Guidelines

**Project:** `tom_d4rt_exec`  
**Type:** Dart Package

## Purpose

`tom_d4rt_exec` is the analyzer-free line's parsing front end. It parses source
with the `analyzer`, has `tom_ast_generator` copy that AST 1:1 into the mirror
AST, and hands the result to the interpreter in `tom_d4rt_ast` — which carries
no `analyzer` dependency itself. `execute()` and `eval()` work as they do on
`tom_d4rt`, routed through that copy step.

It is also **the only place script-level conformance can be run against the
analyzer-free line.** `tom_d4rt_ast` has no parser, so a test there can build a
bundle by hand or drive the registry, but cannot run a script; every such test
for that line lives here.

`tom_d4rt` is the separate, analyzer-based reference and is not a dependency of
this package.

## Conformance Testing

This package's `test/` is a PORT of `tom_d4rt/test/` — the same questions asked
of the other interpreter. `test/conformance_drift_test.dart` is the live answer
to how the two corpora compare: it checks them file for file and case for case,
records every sanctioned difference with its reason, and fails when an
unsanctioned one appears.

**No pass/fail counts are quoted here, deliberately.** A number written into a
document goes stale on the next added file, and a stale count under a heading
that reads as current is worse than none — a reader comparing a fresh run
against it concludes something has gone wrong. Run the suite, or read
`conformance_drift_test.dart`, which answers the question the counts were
reaching for and cannot rot.

**What this package measures is the PUBLISHED interpreter** (DGUC6). It resolves
`tom_d4rt_ast` from pub.dev, not by path, so a green suite here certifies the
release rather than the working tree. `_pinnedInterpreterFloors` in the drift
test records which files are waiting on a version that has not shipped, and
`tool/hosted_drift.dart` measures the gap — see [hosted_drift.md](hosted_drift.md).

## Guidelines in this folder

| Document | Purpose |
| -------- | ------- |
| [build.md](build.md) | Build and regeneration commands |
| [documentation.md](documentation.md) | Where documentation for this package lives |
| [example.md](example.md) | Example file conventions |
| [hosted_drift.md](hosted_drift.md) | `tool/hosted_drift.dart` — telling a genuine interpreter bug apart from a stale published copy |
| [testing.md](testing.md) | Test layout and conventions |
| [d4rt_interpreter_vs_d4rt_generator.md](d4rt_interpreter_vs_d4rt_generator.md) | When to reach for the interpreter vs the generator |

## Related Packages

- `tom_d4rt_ast` — the analyzer-free interpreter this package runs scripts on
  (a dependency, resolved from pub.dev)
- `tom_ast_generator` — 1:1 copier, analyzer AST → mirror AST (a dependency)
- `tom_ast_model` — the mirror AST itself: `SAstNode` and its subtypes, zero
  dependencies, serializable. What the copier produces and the interpreter
  consumes
- `tom_d4rt` — the analyzer-based reference interpreter. NOT a dependency; the
  package whose test suite this one ports
- `tom_dcli_exec` — the `dcli` REPL built on this package
- `tom_d4rt_generator` — bridge code generator
