# tom_d4rt_test examples → see the canonical sample homes

`tom_d4rt_test` is a scaffolded **test-harness package** for the D4rt
interpreter ecosystem — reserved for test-suite work, not a runtime you
write sample programs against. It ships no samples of its own.

Runnable D4rt samples live in the three **canonical sample homes** (P2):

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | Analyzer-free Flutter (AST bundles) | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |

For raw-source interpreter and bridging samples, see
[`tom_d4rt/example`](../../tom_d4rt/example/README.md).
