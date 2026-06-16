# tom_d4rt_exec examples

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

`tom_d4rt_exec` is the **analyzer-free CLI / embedding entry point**. This
`example/` tree contains two kinds of content:

1. **Interpreter samples** (`user_guide/`, `bridging_guide/`,
   `advanced_bridging/`, `dart_overview/`) — these mirror the canonical
   raw-source samples in [`tom_d4rt/example`](../../tom_d4rt/example/README.md)
   and differ only by the package import line
   (`package:tom_d4rt/d4rt.dart` → `package:tom_d4rt_exec/d4rt.dart`). They
   exist so the analyzer-free runtime is exercised on the same programs.
2. **Generator fixtures** (`d4/`, `example_project/`, `user_reference/`,
   `userbridge_*`, `generate_example_bridges.dart`, `run_all_examples.dart`,
   `test_example_bridges.dart`, `d4_test_scripts/`) — test inputs wired into
   the generator test harnesses, **not** user-facing samples.

## Canonical sample homes (P2)

For the curated, runnable sample corpora, see:

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt/example`](../../tom_d4rt/example/README.md) | Interpreter / bridging (raw source) | Language + native-interop demos this runtime also runs |
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | Analyzer-free Flutter (AST bundles) | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |
