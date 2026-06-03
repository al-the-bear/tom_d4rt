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
