# tom_d4rt examples

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

`tom_d4rt` is the analyzer-based reference interpreter, and this `example/`
tree is the **canonical home (P2) for raw-source interpreter and bridging
samples** — the language-level and native-interop demos that don't need a
Flutter or shell runtime.

## Local samples (canonical for this domain)

| Sample | Demonstrates |
|--------|--------------|
| [`user_guide/`](user_guide) | Step-by-step interpreter usage — `execute`, `eval`, environments, value round-tripping |
| [`bridging_guide/`](bridging_guide) | Exposing native Dart classes/enums to interpreted code via `BridgedClass` |
| [`advanced_bridging/`](advanced_bridging) | Advanced bridge patterns — generics, callbacks, operators, static members |
| [`dart_overview/`](dart_overview) | Broad Dart language-feature coverage exercised by the interpreter |
| `d4rt_example.dart`, `example2.dart` | Minimal single-file entry points |

Run the full set with `dart run example/run_all_examples.dart`.

> The analyzer-free CLI sibling [`tom_d4rt_exec`](../../tom_d4rt_exec/example/README.md)
> runs these same interpreter samples — they differ only by the package
> import line (`package:tom_d4rt_v2/d4rt.dart` →
> `package:tom_d4rt_exec/d4rt.dart`).

## Flutter & shell samples → the other canonical homes (P2)

| Canonical home | Runtime | What it demonstrates |
|----------------|---------|----------------------|
| [`tom_d4rt_flutter_test`](../../tom_d4rt_flutter_test/README.md) | Source-based Flutter (analyzer) | 37 multi-file D4rt Flutter Material sample apps, rendered live |
| [`tom_d4rt_flutter_ast_test`](../../tom_d4rt_flutter_ast_test/README.md) | Analyzer-free Flutter (AST bundles) | 33 of those samples as pre-compiled `AstBundle` JSON |
| [`tom_d4rt_dcli`](../../tom_d4rt_dcli/example/README.md) | DCli shell scripting | File / directory / process / env / colour snippets + multi-file CLI apps |
