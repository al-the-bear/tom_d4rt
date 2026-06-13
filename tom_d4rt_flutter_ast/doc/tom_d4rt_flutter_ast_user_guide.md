# tom_d4rt_flutter_ast — User Guide (differences from `tom_d4rt_flutter`)

`tom_d4rt_flutter_ast` is the **analyzer-free** twin of `tom_d4rt_flutter`.
It renders the same Flutter Material bridge surface from the same script
corpus, but runs on the zero-dependency `tom_d4rt_ast` interpreter and
executes **pre-compiled `AstBundle`s** instead of parsing Dart source on the
device. That makes it the strategic building block for **over-the-air UI
updates**: ship widget code as an `AstBundle`, execute it at runtime, render
the result — no app-store cycle.

> **This guide is differences-only (policy P1).** Everything shared with the
> source-based runtime — the bridge surface, registration order, the
> `D4.unwrapAs<T>` result routing, `resetScript()`, performance/GC
> characteristics, and the known-limits catalogue — is documented once in the
> base guide. Read it first:
> - **Base Flutter-runtime guide** →
>   [`tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md`](../../tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md).
> - The analyzer-free interpreter core →
>   [`tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md`](../../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md).
> - How an `AstBundle` is produced →
>   [`tom_ast_generator/doc/tom_ast_generator_user_guide.md`](../../tom_ast_generator/doc/tom_ast_generator_user_guide.md).
> - The extension-hook contract (shared with the base) →
>   [`tom_d4rt_ast/doc/extension_registration.md`](../../tom_d4rt_ast/doc/extension_registration.md).

This package declares `publish_to: 'none'` — monorepo-only, consumed via path
dependency by `tom_d4rt_flutter_ast_test` and the AST HTTP harness.

---

## 1. What differs at a glance

| Aspect | `tom_d4rt_flutter` (base) | `tom_d4rt_flutter_ast` (this) |
|--------|--------------------------|-------------------------------|
| Entry class | `SourceFlutterD4rt` | **`FlutterD4rt`** |
| Underlying interpreter | `tom_d4rt` (analyzer-based) | `tom_d4rt_ast` `D4rtRunner` (**no `analyzer`, no `dart:io`**) |
| Script input | raw Dart **source string** | pre-compiled **`AstBundle`** (`SAstNode` tree) |
| Parse step | on device, per `build` | offline — `createBundleFromSource` once, reuse the bundle |
| Async API | sync only (`build`/`execute`) | sync **and** async (`buildAsync`/`executeAsync`) |
| Platform reach | desktop / mobile | desktop / mobile **+ web** (dart2js, dart2wasm) |
| Multi-file programs | `buildMultiFile`/`buildProgram` (disk/asset resolution) | the bundle already embeds every transitive source — no resolver |
| Exception type | `SourceFlutterD4rtException` | `FlutterD4rtException` |
| Strategic role | conformance harness, source-direct dev loop | **over-the-air UI**, web shipping |

Everything else — the 13 library barrels, the proxy/relaxer/user-bridge
machinery, the five-step registration sequence — is identical and lives in
the base guide.

---

## 2. The `FlutterD4rt` runner

Same two-constructor shape as the base, wrapping a `tom_d4rt_ast` runner
(`D4rtRunner`, aliased `D4rt`) rather than the analyzer-based interpreter:

```dart
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

final d4rt = FlutterD4rt();                       // fresh runner, all bridges
final d4rt2 = FlutterD4rt.withInterpreter(base);  // wrap an existing D4rt
```

`interpreter` exposes the underlying `D4rt`. The registration body
(`_registerBridges`) follows the **same order** as the base
(`registerRelaxers` → `registerD4rtRuntimeExtensions` →
`FlutterMaterialBridges.register` → deferred `registerExtensions` →
`finalizeBridges`) — see the base guide §4 for why the order matters.

### Execution entry points — bundle-driven, sync **and** async

All four route through `D4rt.executeBundleAs<T>` /
`executeBundleAsAsync<T>` (which apply `D4.unwrapAs<T>`), so callers get a
native `T`; an unwrap mismatch surfaces as `FlutterD4rtException`.

| Method | Calls | Notes |
|--------|-------|-------|
| `build<T>(bundle, [context])` | `build` | Sync. Passes `context` first when provided. |
| `buildAsync<T>(bundle, [context])` | `build` | Async — for entry functions returning `Future`, or when called outside a `build` method. |
| `execute<T>(bundle, {name, positionalArgs, namedArgs})` | arbitrary `name` (default `main`) | Sync generic escape hatch. |
| `executeAsync<T>(bundle, {…})` | arbitrary `name` | Async escape hatch. |

The async pair is the **net-new surface** versus the base — the source
runtime is sync-only.

`resetScript()` forwards to `D4rt.resetScriptDeclarations()`, same parity
role as the base; the AST runner already builds a fresh `Environment` per
`executeBundle`, so it is a forward-compatibility hook rather than a wedge
fix (see the `interpreter_unfixable.md` §U28 note in this project's `doc/`).

---

## 3. Bundles instead of source

The defining difference: this runtime never parses Dart on the device. An
`AstBundle` is built **off-device / at build time** — that compile step uses
the `analyzer` and therefore cannot run on web or on the rendering device —
then the bundle is executed on device as many times as needed:

```dart
// BUILD TIME (host / server): compile source to a bundle with the
// tom_ast_generator AstBundler. `bridgedLibraries` tells the bundler which
// imports to leave for the bridge layer rather than inline.
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;

final bundler = AstBundler(bridgedLibraries: d4rt.interpreter.bridgedLibraryUris);
final bundle = await bundler.createFromSource('''
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const Center(child: Text('Hello from D4rt!'));
}
''');
final bytes = bundle.toBytes(); // ship this

// RUNTIME (device, incl. web): reconstruct the downloaded bundle and render —
// no analyzer involved.
final shipped = AstBundle.fromBytes(downloadedBytes); // or AstBundle.fromJson
final widget = d4rt.build<Widget>(shipped, context);
```

> The convenience one-shot `createBundleFromSource(...)` lives on
> `tom_d4rt_exec`'s `D4rt`, **not** on the `tom_d4rt_ast` runner that
> `FlutterD4rt.interpreter` exposes — that runner is analyzer-free by design.
> For in-process compilation use `tom_d4rt_exec`; for the web/over-the-air
> path use the `AstBundler` above and ship the serialized bundle.

The bundle embeds **every transitively-imported source**, so there is no
on-device import resolution and no filesystem access — which is exactly why
the base runtime's `buildMultiFile`/`buildProgram` disk/asset resolvers have
no equivalent here. See the
[`tom_ast_generator` guide](../../tom_ast_generator/doc/tom_ast_generator_user_guide.md)
for how bundles are built and serialized.

---

## 4. Web fit

Because the package depends only on `tom_d4rt_ast` (zero deps; no `analyzer`,
no `dart:io`), it compiles for web. The sample app ships both targets:

```bash
cd ../tom_d4rt_flutter_ast_test
./run_web.sh    # dart2js
./run_wasm.sh   # dart2wasm (see script header for current status)
```

The analyzer-based base runtime cannot run on web (the `analyzer` package and
`dart:io` are not web-compatible) — over-the-air UI on web is unique to this
twin.

---

## 5. Limits & samples

The bridge-adapter limits and per-case script workarounds are **shared** with
the base runtime — see
[`tom_d4rt_flutter_ast_limitations.md`](tom_d4rt_flutter_ast_limitations.md)
for the AST-specific deltas (bundle/version alignment, web) and its backlinks
to the Flutter base limits and the canonical
[`tom_d4rt/doc/d4rt_limitations.md`](../../tom_d4rt/doc/d4rt_limitations.md).

The 33 example apps live in the companion **`tom_d4rt_flutter_ast_test`**
project (`tom_d4rt_flutter_ast_test/example/`), compiled to `AstBundle`s and
mirrored app-for-app with the source-direct sibling
(`tom_d4rt_flutter_test/example/`). Recompile sample bundles after editing a
sample with `flutter test tool/compile_samples_to_bundles.dart`. The bridge
conformance suite shares the same corpus and the same **serial-`flutter test`
rule** as the base (one local HTTP server — never run suites in parallel).
