## 0.3.0

- Migrate the `TwoDimensionalChildDelegate` proxies to `ScrollCacheExtent`,
  following the Flutter SDK's replacement of the raw cache-extent doubles
  (RCK22). The source twin `tom_d4rt_flutter` took this in its own 1.2.0; this
  release closes the resulting divergence, so both twins again expose the same
  constructor surface to interpreted subclasses.
- Add `ProfilingMetrics` (exported from `tom_d4rt_flutter_ast.dart`) — a single
  compile-time switch mirroring the interpreter's `D4rtProfiler.enabled`, plus
  `snapshot()`, `report()` and `reset()`. The test app and the test drivers now
  read one source of truth for whether D4rt's init-path profiler is compiled
  in. The published default is off, so every profiling branch behind it is
  dead-code-eliminated at zero runtime cost.
- Regenerate all 15 Flutter bridge files under the upgraded Flutter SDK on
  `tom_d4rt_generator` 1.14.0. The visible surface change is that bridged enums
  now carry their static methods — e.g. `KeyboardLockMode.findLockByLogicalKey`
  is callable from interpreted code.

## 0.2.0

- Add `FlutterD4rt.warmup()` — forwards to `D4rtRunner.warmup()` so embedders
  can pay the residual eager warm-up cost (warm-parent `Environment`, stdlib)
  off the first frame instead of stalling the first script build. The
  recommended call site is a post-first-frame callback:
  `WidgetsBinding.instance.addPostFrameCallback((_) => d4rt.warmup())`.
  Idempotent and script-neutral.

## 0.1.1

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 0.1.0

Initial pub.dev release of the analyzer-free Flutter Material bridge runtime —
the AST-driven counterpart to `tom_d4rt_flutter`, specialized for over-the-air
and web delivery (no `analyzer` dependency).

- `FlutterD4rt` — executes D4rt scripts that return Flutter widget trees, built
  on the zero-dependency `tom_d4rt_ast` interpreter (no `analyzer`, no
  `dart:io`). Web-safe: suitable for shipping in a Flutter app that downloads
  pre-compiled `AstBundle` JSON and renders UI on device.
- `build<Widget>(...)` renders from a reconstructed `AstBundle` / `SAstNode`
  tree rather than parsing source on device.
- Full generated Flutter Material bridge surface plus hand-written runtime
  registrations (interface proxies, type relaxers, generic factories) and
  `d4rt_user_bridges/` overrides — kept in sync with the source-based
  `tom_d4rt_flutter`, differing only in the analyzer-free execution path.