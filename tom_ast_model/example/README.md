# tom_ast_model examples → see the canonical sample homes

`tom_ast_model` is a zero-dependency **AST data model** — a serializable
mirror of the Dart analyzer's node hierarchy. It is infrastructure consumed
by the interpreter and generator, not a runtime you write programs against,
so it ships no sample programs of its own.

Runnable D4rt samples live in the three **canonical sample homes** (P2):

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | Analyzer-free Flutter (AST bundles) | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |

For the model's own API surface (constructing, serializing, and diffing
`SAstNode` trees), see this package's `README.md` and `test/`.
