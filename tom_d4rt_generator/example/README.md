# tom_d4rt_generator examples → see the canonical sample homes

`tom_d4rt_generator` is the **D4rt bridge generator**. The contents of this
`example/` tree (`dart_overview/`, `d4/`, `example_project/`,
`user_reference/`, `userbridge_*`, `generate_example_bridges.dart`,
`run_all_examples.dart`, `test_example_bridges.dart`, `d4_test_scripts/`)
are **generator test fixtures** wired into the test harnesses — inputs that
exercise bridge generation, **not** user-facing samples. The generator's
primary downstream consumer is the Flutter-material bridge package and its
test corpus.

For curated, runnable D4rt samples, see the three **canonical sample
homes** (P2):

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | Analyzer-free Flutter (AST bundles) | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |

Raw-source interpreter and bridging samples live in
[`tom_d4rt/example`](../../tom_d4rt/example/README.md).
