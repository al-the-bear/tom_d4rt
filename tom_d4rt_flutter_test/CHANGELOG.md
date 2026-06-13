## 1.0.0

Initial release of the test & demo application for `tom_d4rt_flutter`.
Monorepo-only (`publish_to: none`); not a published package — it exists to
demonstrate and manually verify `SourceFlutterD4rt` on every platform.

- **Sample-app runner** — discovers the Dart sample apps under `example/`
  (desktop: live disk tree; mobile: a bundled-asset snapshot synced via
  `tool/sync_samples_to_assets.dart`) and renders each through
  `SourceFlutterD4rt`.
- **Script playback** — runs individual D4rt test scripts inside the Flutter
  build cycle so scripts see a real `BuildContext` (`Theme`, `MediaQuery`,
  `Navigator`).
- **AI-assisted UI generator** — prompts an LLM for Flutter UI source and
  interprets the result on the fly, demonstrating the on-the-fly-update
  workflow the D4rt ecosystem targets.
- Raw-source Flutter sample corpus under `example/`, indexed at
  `assets/samples/index.json`.
