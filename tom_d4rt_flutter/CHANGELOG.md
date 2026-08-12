## 1.2.0

- Add `ProfilingMetrics` (exported from `tom_d4rt_flutter.dart`) — a single
  compile-time switch mirroring the interpreter's `D4rtProfiler.enabled`, plus
  `snapshot()`, `report()` and `reset()`. The test app and the test drivers now
  read one source of truth for whether D4rt's init-path profiler is compiled
  in. The published default is off, so every profiling branch behind it is
  dead-code-eliminated at zero runtime cost.
- Migrate the `TwoDimensionalChildDelegate` proxies to `ScrollCacheExtent`,
  following the Flutter SDK's replacement of the raw cache-extent doubles
  (RCK22).
- Regenerate all 15 Flutter bridge files under the upgraded Flutter SDK on
  `tom_d4rt_generator` 1.14.0. The visible surface change is that bridged enums
  now carry their static methods — e.g. `KeyboardLockMode.findLockByLogicalKey`
  is callable from interpreted code.
- Fix the `idle_timeout` watchdog in the test harness on Linux (RCK22).

## 1.1.0

- Add `SourceFlutterD4rt.warmup()` — forwards to `D4rt.warmup()` so embedders
  can pay the residual eager warm-up cost (warm-parent `Environment`, stdlib,
  and the analyzer parser front-end) off the first frame instead of stalling
  the first script build. The recommended call site is a post-first-frame
  callback: `WidgetsBinding.instance.addPostFrameCallback((_) => d4rt.warmup())`.
  Idempotent and script-neutral.

## 1.0.1

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.0.0

Initial pub.dev release of the source-based Flutter bridge runtime — the
recommended way to run D4rt scripts that return Flutter widget trees.

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