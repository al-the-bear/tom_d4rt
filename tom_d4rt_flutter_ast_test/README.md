# tom_d4rt_flutter_ast_test

Analyzer-free D4rt Flutter demo. A sample browser that loads **pre-compiled
`AstBundle` JSON** from assets and renders each one through
[`FlutterD4rt`](../tom_d4rt_flutter_ast) — the zero-analyzer, web-safe runtime.

This is the AST-runtime counterpart to `tom_d4rt_flutter_test` (which compiles
`.dart` source on the device via the analyzer). The whole point here is
**independence from the analyzer and `dart:io`**: the shipped app depends only
on `tom_d4rt_flutter_ast` + `tom_d4rt_ast`, so it builds and runs on the web.

## How it works

```
example/<name>/main.dart  ──(build time)──▶  assets/bundles/<name>.json
        (Dart source)         AstBundler            (AstBundle JSON)

assets/bundles/<name>.json ──(on device)──▶  AstBundle.fromJson ──▶ FlutterD4rt.build ──▶ Widget
```

- **Build time** — `tool/compile_samples_to_bundles.dart` parses each sample
  with the analyzer (`tom_ast_generator`'s `AstBundler`), skipping the
  Flutter libraries that are bridged at runtime, and writes a serialized
  `AstBundle` per sample. It runs under `flutter test` because it needs
  `dart:ui` (to read `FlutterD4rt.interpreter.bridgedLibraryUris`) and
  `dart:io` (to write files) — neither of which ships in the runtime app.
- **Runtime** — `lib/` loads the bundle JSON via `rootBundle`, reconstructs it
  with `AstBundle.fromJson`, and renders it with `FlutterD4rt.build<Widget>` —
  analyzer-free, `dart:io`-free, web-safe.

## Usage

Recompile bundles after adding or editing any sample:

```bash
flutter test tool/compile_samples_to_bundles.dart
```

Run on a target:

```bash
./run_web.sh      # Chrome — the headline web-safety target
./run_macos.sh    # native macOS desktop
./run_ipad.sh     # iPad simulator
./run_iphone.sh   # iPhone simulator
./run_simulator.sh <udid>   # a specific iOS simulator
```

Each `run_*.sh` recompiles the bundles first, then launches the app.

## Samples

Sample sources live in `example/<name>/`. Each is a normal multi-file D4rt
program whose entry point `main.dart` exposes a top-level
`Widget build(BuildContext context)`. Relative imports are followed and
inlined into the bundle; bridged `package:flutter/*` imports are left for the
runtime to resolve natively.

## Layout

| Path | Role |
| ---- | ---- |
| `lib/main.dart` | Sample-browser shell (grid → render page) |
| `lib/src/bundle_source.dart` | Loads the manifest + bundle JSON from assets |
| `lib/src/bundle_app_page.dart` | Renders one bundle via `FlutterD4rt` |
| `tool/compile_samples_to_bundles.dart` | Build-time source→`AstBundle` compiler |
| `example/<name>/` | Sample D4rt programs |
| `assets/bundles/` | Generated bundle JSON + `index.json` manifest |
| `test/render_bundle_test.dart` | Smoke test: a bundle deserializes and renders |
