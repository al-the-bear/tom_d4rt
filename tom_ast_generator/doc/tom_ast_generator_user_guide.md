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
patterns, command-line options — lives in
[astgen_build_yaml.md](astgen_build_yaml.md); the README's "astgen CLI"
section has the quick-start.

## The resolving check

Bundling parses; it does not resolve. A bundle can therefore carry a program
Dart rejects - a name the script never imported, a type mismatch, a missing
member - and the interpreter will run what it can of it. The resolving check
resolves the bundle's modules with the analyzer first and refuses such a
program. It is opt-in; without it bundling is unchanged.

```dart
final bundler = AstBundler(
  bridgedLibraries: runner.bridgedLibraryUris.toSet(),
  explicitSources: sources,            // e.g. collected via package_config.json
  fileAccessValidator: (_) => false,   // no file reads by the bundler
  declarationStubs: {
    // Libraries that exist only at run time: the resolver checks against
    // them; they are never bundled.
    'package:my_app/host.dart':
        'Map<String, int> sameMap() => throw UnimplementedError();',
  },
  config: const AstBundlerConfig(resolve: true),
);
try {
  final bundle = await bundler.createFromSource(source, sourcePath: entry);
  print(bundler.lastResolveReport!.summary);
} on AstResolveException catch (e) {
  for (final error in e.report.errors) {
    print(error); // package:my_app/main.dart:3:9: error: ... (undefined_...)
  }
}
```

- **Where the sources come from.** From `explicitSources` (and the modules
  the bundler reads) - the sources are analyzer overlays in a virtual package
  configuration, and nothing is written to disk - or from a project
  (`createFromFile`, `projectRoot`), whose `.dart_tool/package_config.json`
  supplies the imported packages.
- **What the analyzer reads.** The Dart SDK, and in a project the packages its
  configuration names. `fileAccessValidator` governs the bundler's own reads,
  not the analyzer's.
- **The Dart SDK** is found without configuration: `AstBundlerConfig.sdkPath`,
  else `DART_SDK`, else the `dart` on `PATH`, else the `flutter` on `PATH`
  (`<flutter>/bin/cache/dart-sdk`), else the SDK of the running Dart VM. When
  nothing is found, `DartSdkNotFoundException` lists every place searched.
- **Runtime-only libraries.** An import of a library in `bridgedLibraries`
  that has neither source nor stub cannot resolve; that import and the names
  it would supply are left out and counted (`ResolveReport.filtered`) instead
  of failing the check. Any other error in the same module is still reported.
  Give a stub to have such a library checked against.
- **Cost.** About 0.2-0.6 s for a plain script; a Flutter script takes 3-4 s
  for the first in a process. Bundle at build time, not per request.
- **Many scripts.** `AstResolver.checkFiles` resolves files of one project in
  one analysis context, so the analyzer starts once.
  `dart run tool/resolve_check.dart --project <root> <folder>...` does that
  from the command line; the twins' corpus is checked with it
  (`tom_d4rt_flutter_ast/test/run_corpus_check.sh`).
- **`astgen --resolve`** checks each entrypoint before converting it, with
  `--dart-sdk`, `--stubs <folder>` (`<folder>/<package>/<path>` declares
  `package:<package>/<path>`) and `--runtime-library <uri>`.

### The static facts table

With the check on, the bundler also records the static types the runtime
cannot see in the syntax: the receiver type and type arguments of each
extension call, and the inferred type arguments of generic calls, instance
creations and untyped collection literals. It returns a `ResolvedAstBundle`,
whose JSON (and `toBytes`) carries them under the optional `facts` key.
Readers that do not know the key ignore it. `AstBundlerConfig(staticFacts: false)`
leaves the table out. Layout, stamp and sizes:
[resolved_bundles.md](resolved_bundles.md).

### Stubs from bridge signatures

A stub only declares what a script may call; bodies can throw. For a host API
bridged with `d4rtgen`, the generator already knows every bridged signature -
the class, its constructors and members with their parameter and return
types - so it could emit a declaration-only Dart library per bridged library
(`external` members, or bodies that throw) to pass as `declarationStubs` or
put in an `astgen --stubs` folder. It does not do that yet; until it does,
write the stubs for the functions a script uses by hand. For a host API that
already exists as Dart source (a typed interface whose implementation the
host registers), that source can serve as its own stub.

## Limitations

See [tom_ast_generator_limitations.md](tom_ast_generator_limitations.md) for
this package's deltas (it inherits the interpreter's limitations only
indirectly, through the bundles it produces).
