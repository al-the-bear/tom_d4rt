# tom_d4rt_ast examples → see the canonical sample homes

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

`tom_d4rt_ast` is the **analyzer-free interpreter runtime** that executes
pre-compiled `SAstNode` / `AstBundle` trees. Its end-to-end showcase is the
analyzer-free Flutter test app **[`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md)**,
which downloads bundled AST JSON and renders live widget trees on this
runtime — exactly the on-the-fly-update workflow the package targets.

Runnable D4rt samples live in the three **canonical sample homes** (P2):

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | **Analyzer-free Flutter (this runtime)** | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |

For the interpreter API itself (`D4rtRunner`, `executeBundleAs<T>`,
`registerExtensions`, `finalizeBridges`), see this package's `README.md`,
`doc/extension_registration.md`, and `test/`.
