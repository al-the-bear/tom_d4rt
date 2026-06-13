# tom_ast_generator User Guide

> **Differences-only guide (P1).** `tom_ast_generator` does **not** run any
> Dart code — it has no interpreter, no bridges, and no permission sandbox.
> It is the *host-side* tool that turns Dart **source** into a serializable
> mirror AST that the analyzer-free runtime can interpret later. For the
> execution model, language semantics, bridge registration, and permissions
> read the base guides and treat them as authoritative:
>
> - [tom_d4rt User Guide](../../tom_d4rt/doc/d4rt_user_guide.md) — interpreter
>   execution model, `execute`/`eval`, bridge registration, permissions.
> - [tom_d4rt_ast User Guide](../../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md)
>   — the analyzer-free runtime that **consumes** the bundles produced here.
> - [tom_d4rt_exec User Guide](../../tom_d4rt_exec/doc/tom_d4rt_exec_user_guide.md)
>   — the CLI entry point that wraps this converter + the runtime.
>
> This guide documents only what is **specific to this package**: its place in
> the pipeline, the 1:1 copy + bundle emission, and how to tell it apart from
> the *bridge* generator.

## Role in the pipeline — the one analyzer-dependent step

`tom_ast_generator` is the **only** package in the analyzer-free stack that
depends on the `analyzer` package. It exists to confine that dependency to a
single build/CI-time step, so everything downstream can ship without it:

```
Dart source                       ← author writes this
   │  analyzer (host/CI only)         ← THIS package's only heavy dep
   ▼
analyzer.CompilationUnit
   │  AstConverter.convertCompilationUnit()   ← 1:1 node-for-node copy
   ▼
SCompilationUnit (mirror AST, tom_ast_model)
   │  AstBundler.createFromFile() / createFromSource()  ← + recursive imports
   ▼
AstBundle  →  toJson() / toBytes()
   │  ship as a Flutter asset / write to disk
   ▼
tom_d4rt_ast (device, NO analyzer)   ← interprets the bundle
```

The converter is a **pure structural mapper**: one mirror node per analyzer
node, one field per field, offsets and lengths preserved, nothing lost.
Unknown node types become a placeholder `_SUnknownNode` rather than throwing,
so partial conversion always succeeds.

## "Generator" vs "generator" — pick the right tool

The single most common confusion in this family is the two packages with
"generator" in the name. They do unrelated jobs:

| | `tom_ast_generator` (this) | `tom_d4rt_generator` |
|---|---|---|
| **Input** | Dart **source** to be *interpreted* | Dart **library** to be *bridged* |
| **Output** | `SAstNode` mirror AST / `AstBundle` JSON | `*.b.dart` `BridgedClass` registrations |
| **Purpose** | Let the analyzer-free runtime run *your script* | Expose *native Dart classes* to interpreted code |
| **Runtime cost** | Build/CI-time (analyzer) | Build/CI-time (analyzer) |
| **Consumed by** | `tom_d4rt_ast` interpreter | the interpreter's bridge registry |
| **CLI** | `astgen` | `d4rtgen` |

Use **`tom_ast_generator`** when you have a `.dart` script you want to *run*
on a device that cannot ship the analyzer. Use **`tom_d4rt_generator`** when
you have a native Dart/Flutter API you want interpreted code to be able to
*call*. A typical Flutter app uses **both**: `d4rtgen` produces the bridges
for the Flutter API once, and `astgen` bundles each shippable script.

## When to bundle vs. parse at runtime

| Situation | Use |
|-----------|-----|
| Host/CLI/server execution where the analyzer is available | Skip bundling — `tom_d4rt_exec` parses source directly. |
| Flutter / web / on-device, or hot-swappable scripts | Bundle here, ship the JSON, interpret with `tom_d4rt_ast`. |
| Tight startup even on a host | Pre-bundle to eliminate the parse step at run time. |

If your target *can* ship the analyzer, you usually do not need this package at
all — `tom_d4rt` (source-direct) or `tom_d4rt_exec` is simpler. This package
earns its place specifically when the analyzer must be kept out of the runtime.

## Bundle emission

The two emit paths produce the same self-contained `AstBundle` — a map of
URI → `SCompilationUnit` plus the entry-point URI — built by recursively
following imports and parts:

```dart
import 'package:tom_ast_generator/tom_ast_generator.dart';

Future<void> main() async {
  final bundler = AstBundler(
    // URIs handled by native bridges at runtime are skipped, not inlined.
    bridgedLibraries: {'package:flutter/material.dart'},
    // packageName / projectRoot auto-detected from pubspec when omitted.
  );

  final bundle = await bundler.createFromFile('lib/scripts/screen.dart');

  // JSON for a Flutter asset (human-diffable):
  final json = bundle.toJson();
  // Or compact bytes for size-sensitive shipping:
  final bytes = bundle.toBytes();
}
```

`dart:*` libraries and anything listed in `bridgedLibraries` are **skipped**
(resolved by the runtime's stdlib / native bridges); same-package and relative
imports are pulled from disk; an unbridged foreign `package:` import is an
error. Circular imports are handled via a visited-URI set, with
`maxImportDepth` (default 64) as a final guard. A `fileAccessValidator`
callback can gate every disk read to honour D4rt's `FilesystemPermission`
sandbox. The resulting bundle is reconstructed downstream with
`AstBundle.fromJson()` / `fromBytes()` — with no analyzer present. See the
[tom_d4rt_ast User Guide](../../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md)
for the loader surface and how the runtime executes a bundle.

## Batch conversion — the `astgen` CLI

For converting many files across a workspace, the `astgen` CLI emits
`.ast.yaml` files driven by an `astgen:` section in `buildkit.yaml`. It builds
on the shared `tom_build_base` navigation (project discovery, `--scan`,
`--recursive`, `--dry-run`, `--verbose`). The full configuration reference —
output path formats, `preserve_structure`, `include_sourcemap`, exclusion
patterns — lives in
[astgen_build_yaml.md](astgen_build_yaml.md) and
[tom_build_configuration_and_cli.md](tom_build_configuration_and_cli.md); the
README's "astgen CLI" section has the quick-start.

## Limitations

See [tom_ast_generator_limitations.md](tom_ast_generator_limitations.md) for
this package's deltas (it inherits the interpreter's limitations only
indirectly, through the bundles it produces).
