## 1.0.0

Initial release of the analyzer-free Flutter demo app — the AST-runtime
counterpart to `tom_d4rt_flutter_test`. Monorepo-only (`publish_to: none`).

- **Sample browser** — loads pre-compiled `AstBundle` JSON from assets and
  renders each through `FlutterD4rt` (the zero-analyzer, `dart:io`-free,
  web-safe runtime).
- **Build-time compilation** — `tool/compile_samples_to_bundles.dart` parses
  each `example/<name>/main.dart` with the analyzer (`tom_ast_generator`'s
  `AstBundler`), skipping the Flutter libraries bridged at runtime, and writes
  a serialized `AstBundle` to `assets/bundles/<name>.json`. Runs under
  `flutter test` (needs `dart:ui` + `dart:io`).
- **Runtime** — loads bundle JSON via `rootBundle`, reconstructs it with
  `AstBundle.fromJson`, and renders with `FlutterD4rt.build<Widget>` — no
  analyzer, no `dart:io`, web-safe.
- Compiled AST-bundle sample corpus under `assets/bundles/`.
