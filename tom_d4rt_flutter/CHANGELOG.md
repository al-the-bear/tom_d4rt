## 1.0.0

Initial release of the source-based Flutter bridge runtime. Monorepo-only
(`publish_to: none`); consumed via path dependency by `tom_d4rt_flutter_test`
and the HTTP harness.

- `SourceFlutterD4rt` — a `tom_d4rt` interpreter pre-loaded with the full
  generated Flutter Material bridge surface (17 generated `*.b.dart` files under
  `lib/src/bridges/`). Feed it raw Dart source; it returns a live `Widget`.
- `build(source, context)` and `buildMultiFile(...)` entry points; rendering
  against **real** Flutter widgets (not mocks).
- Hand-written runtime registrations layered on top of the generated bridges:
  interface proxies, generic type relaxers, and generic constructor factories.
- `d4rt_user_bridges/` — hand-written `D4UserBridge` overrides for classes that
  need bespoke behaviour beyond the generated adapters.
- Sample-source loaders (`SampleProgram`, `SampleSource`, `createSampleSource`,
  `DiskSampleSource`, `AssetSampleSource`, `buildDiskProgram`, …) for loading
  multi-file sample apps.
- Bridge conformance test suite plus the long-lived companion-app HTTP harness
  used to drive the flutter-material corpus.
