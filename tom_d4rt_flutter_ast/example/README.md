# tom_d4rt_flutter_ast examples → see tom_d4rt_flutter_ast_test

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

`tom_d4rt_flutter_ast` is the **analyzer-free Flutter Material bridge
library** — execute pre-compiled D4rt scripts that return live Flutter
widget trees without an app-store republish. Its samples are not duplicated
here; the canonical home for this library's samples (P2) is its own test &
demo app, **[`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md)**,
which mirrors **33** of the source-based samples as pre-compiled
`AstBundle` JSON and renders them on this analyzer-free runtime.

The three **canonical sample homes** (P2):

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | **Analyzer-free Flutter (this library)** | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |

For the bridge surface and the `AstBundle` execution API, see this package's
`README.md` and `test/`.
