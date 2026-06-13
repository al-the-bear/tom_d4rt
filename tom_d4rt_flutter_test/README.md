# tom_d4rt_flutter_test

Test & demo application for the [`tom_d4rt_flutter`](../tom_d4rt_flutter) library.

This Flutter app exercises `SourceFlutterD4rt` — the source-based D4rt
interpreter with the full Flutter Material bridge surface — in a real,
interactive runtime. It is **not** a published package; it exists to
demonstrate and manually verify the library on every platform.

## What it does

- **Sample-app runner** — discovers the Dart sample apps under `example/`
  (desktop: live disk tree; iOS / iPadOS / Android: a bundled-asset
  snapshot synced via `tool/sync_samples_to_assets.dart`) and interprets
  each one with `SourceFlutterD4rt`, rendering the result as a live widget.
- **Script playback** — loads and runs individual D4rt test scripts inside
  the Flutter build cycle so the script sees a real `BuildContext`
  (`Theme`, `MediaQuery`, `Navigator`).
- **AI-assisted UI generator** — a panel that prompts an LLM to produce
  Flutter UI source and interprets the result on the fly, showing the
  on-the-fly-update workflow the D4rt ecosystem targets.

## Sample corpus

The `example/` tree holds **37** multi-file D4rt sample apps, snapshotted into
`assets/samples/index.json` by `tool/sync_samples_to_assets.dart`. This is the
canonical raw-source sample home (P2); the analyzer-free sibling
[`tom_d4rt_flutter_ast_test`](../tom_d4rt_flutter_ast_test) mirrors **33** of
them as pre-compiled `AstBundle` JSON.

**33 samples are shared app-for-app** with the AST sibling so the source-based
and bundle-based runtimes can be compared on identical programs. **4 samples
are source-only by design** — they are not ported to AST bundles:

| Source-only sample | Why it stays raw-source only |
|--------------------|------------------------------|
| `profiler_field` | Self-running profiling harness (autorun via `--dart-define=AUTORUN_SAMPLE=…`, `buildProgram`) used to measure the major-GC freeze on the **source-interpreted** render path — the [todo-19 GC analysis](../tom_d4rt/doc/d4rt_limitations.md#lim-10-per-step-allocation-rate-drives-major-gc). A diagnostic tool, not a demo; no analog purpose on the AST path. |
| `profiler_life` | Same — Conway's Life profiling harness for the source path. |
| `particle_field_optimized` | GC-mitigation demo (fixed-timestep governor + `ValueNotifier` incremental render). Its unoptimized twin `particle_field` is in **both** corpora and already validates the AST path; the optimized variant exists to be compared against that twin on the source path. |
| `conway_life_optimized` | Same — the GC-mitigated twin of `conway_life` (which is in both corpora). |

The optimization pattern these demos exercise is documented in the
[`tom_d4rt_flutter` Performance & GC section](../tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md).

## Relationship to the library

| Package | Role |
|---------|------|
| [`tom_d4rt_flutter`](../tom_d4rt_flutter) | The library: `SourceFlutterD4rt`, the generated Flutter bridges, the sample-source loaders, and the bridge conformance test suite + HTTP harness. |
| `tom_d4rt_flutter_test` (this app) | Depends on the library; provides the interactive UI, the `example/` sample corpus, and the sample-specific tests. |

The app depends on the library through a path dependency
(`tom_d4rt_flutter: path: ../tom_d4rt_flutter`) and uses only its public
API (`package:tom_d4rt_flutter/tom_d4rt_flutter.dart`).

## Running

```bash
flutter pub get
flutter run -d macos      # or: -d chrome, an iOS simulator, etc.
```

Helper scripts for simulators live in the project root
(`run_simulator.sh`, `run_iphone.sh`, `run_ipad.sh`).

Before running on mobile, refresh the bundled sample assets:

```bash
dart run tool/sync_samples_to_assets.dart
```

## Tests

The app keeps the **sample-related** tests:

- `test/asset_sample_source_test.dart` — manifest parsing + multi-file
  source resolution for the bundled-asset path.
- `test/sample_apps_in_tester_test.dart` — interpreting/rendering the
  sample corpus under the headless test binding.

```bash
flutter test
```

The library's bridge **conformance** suite and the HTTP test harness live
with the library in `../tom_d4rt_flutter/`.
