# Error Analysis — 20260528-1404

| Field | Value |
| --- | --- |
| **Fix-ID** | `20260528-1404-issue-analysis` |
| **Sweep timestamp** | 2026-05-28 14:04 PDT |
| **Git revision** (sweep time) | `90854bc9` — `test(d4rt-ast): §U28 / TODO #14 — pin "no over-clearing" risk with 3 new cases` |
| **Projects swept** | `tom_d4rt_flutter_ast` (port 4247), `tom_d4rt_flutter_test` (port 4248) |
| **Files swept** | 14 per project = 28 total |
| **Per-file budget** | 60 s (forcibly killed on timeout) |
| **Sweep mode** | Both projects in parallel; files serial within each project |
| **Outcome** | 0 tests executed across the entire sweep — every `(setUpAll)` block hung at the `D4RT_PROFILE` banner |

## 1. Top-level summary

**The sweep produced zero useful test results.** Every one of the 28 `flutter test` invocations (14 files × 2 projects) hit the identical wedge signature:

1. Test file loaded (`testStart` for the implicit loading test → `testDone success`).
2. `(setUpAll)` started.
3. The flutter test runner printed its `[D4RT_PROFILE] Dart VM Service` + `[D4RT_PROFILE] Flutter DevTools` banner (Dart VM came up).
4. Then radio silence — `setUpAll` never returned. Each invocation was killed at the 60 s budget cap.

This is the same wedge mode previously documented under TODO #10 / #11 of `testlog_20260526-1401-issue-analysis/error_analysis.md` and §U28 of `interpreter_unfixable.md`: the test-app process from prior `flutter test` runs is stuck in **kernel state `UE`** (uninterruptible kernel wait + exit attempted), holding the LISTEN socket on the test port, refusing every userspace signal — `kill -9`, `pgrep -f | xargs kill -9`, `killall -9 <binary>`, `launchctl bootout`. The new `setUpAll`-spawned test app cannot bind to the port, so it never responds to `/health`, so the runner's `_startTestApp` deadline loop ages out.

Concretely, at sweep time:

```
$ lsof -i :4247 -i :4248
COMMAND     PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
tom_d4rt_ 58924 alexiskyaw   14u  IPv4 0xc23bb013d5b0d614  0t0  TCP localhost:4248 (LISTEN)
tom_d4rt_ 67999 alexiskyaw    3u  IPv4 0x13b7a512ed4e71bc  0t0  TCP localhost:4247 (LISTEN)

$ ps -p 67999 -o pid,state,etime    # ast project test_app
  PID STAT  ELAPSED
67999 UE   09:51:43

$ ps -p 58924 -o pid,state,etime    # test project test_app
  PID STAT  ELAPSED
58924 UE   10:59:25
```

Both zombie processes have been in `UE` for ~10 hours. They will only clear with a host reboot (or `sudo launchctl reboot userspace`).

**Until the host is recovered, no live regression evidence can be produced.** This sweep captures the wedge signature and proves the blocker — it cannot capture failing assertions, framework errors, transport errors, or skipped-test outcomes because no test ran.

## 2. Per-file results

Both projects, all 14 files: **blocked at setUpAll**. Identical signature, identical root cause. Tabulated for completeness.

### `tom_d4rt_flutter_ast` (port 4247 — held by zombie PID 67999, state `UE`)

| File | Setup outcome | Tests executed | Failures / framework errors captured |
| --- | --- | --- | --- |
| `essential_classes_test` | setUpAll wedged at D4RT_PROFILE banner | 0 / 108 | none captured |
| `important_classes_test` | setUpAll wedged | 0 / unknown | none captured |
| `secondary_classes_test` | setUpAll wedged | 0 / 656 | none captured |
| `hardly_relevant_classes_1_test` | setUpAll wedged | 0 / 192 | none captured |
| `hardly_relevant_classes_2_test` | setUpAll wedged | 0 / 192 | none captured |
| `hardly_relevant_classes_3_test` | setUpAll wedged | 0 / 189 | none captured |
| `hardly_relevant_classes_4_test` | setUpAll wedged | 0 / 216 | none captured |
| `hardly_relevant_classes_5_test` | setUpAll wedged | 0 / 217 | none captured |
| `crashing_tests_test` | setUpAll wedged | 0 | none captured |
| `timeout_tests_test` | setUpAll wedged | 0 | none captured |
| `blocking_tests_test` | setUpAll wedged | 0 | none captured |
| `generator_interpreter_issues_test` | setUpAll wedged | 0 | none captured |
| `generator_interpreter_retest_test` | setUpAll wedged | 0 | none captured |
| `interactive_tests_test` | setUpAll wedged | 0 / 9 | none captured |

### `tom_d4rt_flutter_test` (port 4248 — held by zombie PID 58924, state `UE`)

| File | Setup outcome | Tests executed | Failures / framework errors captured |
| --- | --- | --- | --- |
| `essential_classes_test` | setUpAll wedged at D4RT_PROFILE banner | 0 / 108 | none captured |
| `important_classes_test` | setUpAll wedged | 0 / unknown | none captured |
| `secondary_classes_test` | setUpAll wedged | 0 / ~650 | none captured |
| `hardly_relevant_classes_1_test` | setUpAll wedged | 0 / 192 | none captured |
| `hardly_relevant_classes_2_test` | setUpAll wedged | 0 / 192 | none captured |
| `hardly_relevant_classes_3_test` | setUpAll wedged | 0 / 189 | none captured |
| `hardly_relevant_classes_4_test` | setUpAll wedged | 0 / 216 | none captured |
| `hardly_relevant_classes_5_test` | setUpAll wedged | 0 / 217 | none captured |
| `crashing_tests_test` | setUpAll wedged | 0 | none captured |
| `timeout_tests_test` | setUpAll wedged | 0 | none captured |
| `blocking_tests_test` | setUpAll wedged | 0 | none captured |
| `generator_interpreter_issues_test` | setUpAll wedged | 0 | none captured |
| `generator_interpreter_retest_test` | setUpAll wedged | 0 | none captured |
| `interactive_tests_test` | setUpAll wedged | 0 | none captured |

Sample `result.json` truncation point (all 28 follow the same shape — `testStart` for the implicit loader test, `testStart` for `(setUpAll)`, then a stream of D4RT_PROFILE print events from t≈25–53 s, then file truncates at the kill):

```jsonc
{"protocolVersion":"0.1.1","runnerVersion":null,"pid":65092,"type":"start","time":0}
{"suite":{"id":0,"platform":"vm","path":"…/essential_classes_test.dart"},"type":"suite","time":0}
{"test":{"id":1,"name":"loading …/essential_classes_test.dart",…},"type":"testStart","time":0}
{"count":1,"time":2,"type":"allSuites"}
{"testID":1,"result":"success","skipped":false,"hidden":true,"type":"testDone","time":3301}
{"group":{"id":2,"suiteID":0,"parentID":null,"name":"","metadata":{"skip":false,…},"testCount":108,…},"type":"group","time":3302}
{"test":{"id":3,"name":"(setUpAll)","suiteID":0,…},"type":"testStart","time":3303}
{"testID":3,"messageType":"print","message":"[D4RT_PROFILE] Dart VM Service: http://127.0.0.1:…/", "type":"print","time":32481}
// truncated — no further events, no testDone for the (setUpAll)
```

## 3. Metrics

The `[METRIC]` lines emitted by the test-app build handler (referenced in §1 of the prior testlog's `error_analysis.md`) were **not captured** because no test ever reached `_handleBuild` — `setUpAll` couldn't even establish HTTP contact with the test app. Per-suite metrics will be available only after host recovery.

## 4. Framework errors

**None captured.** Framework errors are captured by the test app's `FlutterError.onError` hook, which is only installed after the test app's `runApp` runs. Since no test app reached `runApp` (binding-bound by the wedged port), the hook never fired.

## 5. Skipped tests

The four skip patterns visible in the test sources (independent of execution):

| # | Skip pattern | Files | Rationale |
| --- | --- | --- | --- |
| 1 | `widgets/android_view_test.dart` — `skip: !Platform.isAndroid` | `secondary_classes_test.dart:3623`, `generator_interpreter_issues_test.dart:440` (both projects) | `AndroidView` only renders on Android; on macOS/Linux/Windows the platform-view bridge is absent. Source: `skip: !Platform.isAndroid ? 'AndroidView only renders on Android' : null` |
| 2 | `dart_ui/isolate_name_server_test.dart` | `hardly_relevant_classes_1_test.dart:629` (both projects) | `IsolateNameServer` requires real Dart isolate infrastructure (`Isolate.spawn`, cross-isolate `SendPort`/`ReceivePort`); d4rt only simulates async, no real isolate execution. Permanent interpreter limitation. |
| 3 | `retest/dart_ui/system_color_palette_test.dart` — `skip: Platform.isLinux \|\| isMacOS \|\| isWindows` | `generator_interpreter_retest_test.dart:74` (both projects) | `SystemColor.platformProvidesSystemColors` is `false` on every desktop platform; accessing `.light`/`.dark` throws `UnsupportedError`. The non-retest variant of the script already gates on this; the retest version uses an unconditional `skip` because it must reproduce a specific failure mode that doesn't occur on desktop. |

**Total skip count across both projects:** 4 distinct test cases × 2 projects = **8 skipped test invocations**, each with a clear platform-only or interpreter-limitation rationale. None of these need fixing — they are intentional, well-documented skips.

## 6. Root cause — kernel-zombie test_app processes

Same as the established TODO #10/#11 mode from `testlog_20260526-1401-issue-analysis/error_analysis.md`:

| Field | Value |
| --- | --- |
| PID (ast) | 67999 |
| PID (test) | 58924 |
| State | `UE` — Uninterruptible kernel wait + Exit attempted |
| PPID | 1 (launchd, after parent `flutter run` died) |
| `WCHAN` | empty (kernel call has no sleep address) |
| Elapsed | 9 h 51 m (ast), 10 h 59 m (test) |
| Recovery options tried in this session | `kill -9 <pid>` (failed), `pgrep -f \| xargs kill -9` (failed), `killall -9 <binary>` (failed), `sudo -n killall -9` (requires interactive password), `launchctl bootout gui/…` (returned `5: Input/output error` — kernel-level I/O failure on the wedged process) |
| Only known recovery | Host reboot or `sudo launchctl reboot userspace` |

This mode is unrecoverable from inside the session. **The sweep cannot produce real test data until the host is rebooted.**

## 7. Open items in `interpreter_unfixable.md`

`interpreter_unfixable.md` currently catalogues 30 entries (U1 – U30). One is marked **✅ FIXED**: U26 (`Source-based interpreter rejects InterpretedInstance for RouterDelegate<Object>?`, fixed 2026‑05‑25). 29 remain open and feed into the TODO list below.

## 8. Numbered TODO list — fix-id `20260528-1404-issue-analysis`

Each item has a `[ ]` checkbox. Tick to `[x]` when the work lands a verified fix (test passes, regression sweep green, or doc closure for design-only items).

### Phase 0 — Host recovery (blocking everything else)

- [ ] **1.** Reboot the host (or `sudo launchctl reboot userspace`) to release ports 4247 and 4248 from kernel-zombies PIDs 67999/58924. *Verify:* `lsof -i :4247 -i :4248` returns empty.

### Phase 1 — Re-establish the regression baseline (depends on #1)

- [ ] **2.** Re-run the full 14-file sweep on `tom_d4rt_flutter_ast` (essential → important → secondary → hardly_relevant_1–5 → crashing → timeout → blocking → generator_interpreter_issues → generator_interpreter_retest → interactive). *Capture:* `doc/testlog_20260528-1404-issue-analysis/<file>.result.json` + `<file>.log.txt`, overwriting the wedged-evidence captures from this analysis.
- [ ] **3.** Re-run the full 14-file sweep on `tom_d4rt_flutter_test` (same file list). *Capture:* same shape in that project's testlog folder.
- [ ] **4.** Re-tally pass/fail/skip counts per file in this `error_analysis.md` — replace the "0 / N" rows in §2 with real numbers, append a Failures column.
- [ ] **5.** Add a "Framework-error tally" section to §4 listing every `[FRAMEWORK_ERROR]` line captured in the new log.txt files (grouped by file, with script attribution where the build handler's METRIC stream identifies the originating script).
- [ ] **6.** Audit `transport_error` and `clear_failed` counts in the new logs — confirm `tom_d4rt_flutter_ast`'s secondary sweep wedge rate (baseline: 22 / 656) and whether the §U28 deep fix (shipped in `42588be2`/`d613142e`/`90854bc9`) measurably changes that number. Update `interpreter_unfixable.md` §U28 with the post-fix wedge rate.

### Phase 2 — Verify the §U28 deep fix's behavioural effect (depends on #6)

- [ ] **7.** If the §U28 wedge rate dropped materially (e.g. to ≤ 5 / 656): remove the `SendTestRunner.requestRecycle()` `setUp` hook from `tom_d4rt_flutter_ast/test/interactive_tests_test.dart` and rerun `interactive_tests_test` to confirm it stays green without the per-test recycle.
- [ ] **8.** If the §U28 wedge rate is unchanged: leave `requestRecycle()` in place, and open a follow-up issue to investigate the **actual** accumulator (most-suspect candidates from the §U28 architectural finding: `D4._nativeToInterpreted` Expando entries pinned by live Flutter Elements; D4 generator static caches in `tom_d4rt_ast/lib/src/runtime/generator/d4.dart`; Flutter framework state — ImageCache, Ticker registrations, RouteObserver).

### Phase 3 — Address open interpreter / bridge limitations from `interpreter_unfixable.md`

Each item below references an existing `§Ux` entry that already contains a documented repro, root cause, and (where applicable) workaround. The fix path varies per item — some are interpreter work, some are bridge generator work, some are documented-as-unfixable and just need a final closure decision.

- [ ] **9.** §U1 — Demo-scale renderings overload the test-app transport (interpreter limitation). Investigate whether the script-level workaround (split rendering across multiple builds, pump frames between) can be encoded as a bridge-level safety so scripts don't have to opt in manually.
- [ ] **10.** §U2 — Non-wrappable arithmetic defaults on positional-only native constructors (generator limitation). Generator-side fix: emit a `D4.coerceNum(arg, fallback: defaultValue)` adapter for positional-only constructors whose default expression contains arithmetic.
- [ ] **11.** §U3 — Interpreted subclass of native abstract `Curve`: `transformInternal` override not routed through `Curve.transform`. Interpreter dispatch fix.
- [ ] **12.** §U4 — Standalone `'\n'` `TextSpan` between two styled siblings crashes the test-app transport. Marked **truly unfixable** — confirm whether the per-script workaround (avoid bare-newline spans) is still the canonical guidance.
- [ ] **13.** §U5 — Interpreted subclass of `NotchedShape` / `FloatingActionButtonLocation` rejected at bridged-constructor boundary. Generator + interpreter abstract-class subclass path.
- [ ] **14.** §U6 — Direct `import 'package:vector_math/vector_math_64.dart'` not resolvable. Module-loader work, plus potentially adding the package as a bridged dep.
- [ ] **15.** §U7 — Dart-internal `_ConstMap` not in `Map` bridge's `nativeNames`. Add `_ConstMap` (and likely `_ImmutableMap`, `_HashMap`, etc.) to the bridge's `nativeNames` allowlist.
- [ ] **16.** §U8 — Script-defined enum values are `InterpretedEnumValue`, not native `Enum`; `RestorableValue.value` asserts `isRegistered`. Interpreter + bridge work.
- [ ] **17.** §U9 — Script-defined `RouteAware` cannot subscribe to native `RouteObserver`. Interpreter subclass-callback routing.
- [ ] **18.** §U10 — Script-defined class `with DiagnosticableTreeMixin` cannot call inherited concrete methods. Mixin inheritance fix.
- [ ] **19.** §U11 — Script-defined `HitTestTarget` rejected by `HitTestEntry(target)` constructor. Interpreter subclass-of-bridged-interface.
- [ ] **20.** §U12 — `@Deprecated`-annotated SDK symbols filtered out by generator policy. Decide whether to add an opt-in flag to expose deprecated symbols for scripts that need them.
- [ ] **21.** §U13 — Native exceptions thrown across a bridged method not catchable by original type. Interpreter exception-routing fix.
- [ ] **22.** §U14 — `maxHeight: infinity` leaks through `Center > ConstrainedBox` inside `SingleChildScrollView` (and analogous `Expanded`-inside-`Column.min`-inside-`GridView.count`). Bridge/interpreter constraints-propagation gap.
- [ ] **23.** §U15 — `RenderFlex overflowed by 2.0 px on the right` inside bridged Cupertino layout. Bridge layout-rounding gap.
- [ ] **24.** §U16 — `Text('')` triggers `NaN Offset` assertion in `dart:ui` paragraph painting. Bridge/interpreter text-layout gap. Likely needs to short-circuit empty-string `Text` in the bridge.
- [ ] **25.** §U17 — `ConstraintsTransformBox` teaching script intrinsically incompatible with `frameworkErrors=0` (script design). Closure: confirm with the script's author whether the framework-error noise is acceptable or whether the demo's intent can be rewritten.
- [ ] **26.** §U18 — `services/platform_test.dart` `Row(stretch)+Expanded(_twinCard)` P1 variants destabilise the test-app transport. Interpreter/bridge limitation.
- [ ] **27.** §U19 — Per-character `TextSpan` stream of non-Latin glyphs triggers `NaN Rect` assertion in `dart:ui` painting. Same family as §U16; likely shared fix.
- [ ] **28.** §U20 — `Table(border: TableBorder.all(...))` triggers framework assertion in `table_border.dart:289`. Likely a framework bug; needs upstream-vs-bridge triage.
- [ ] **29.** §U21 — `Quad` / `Vector3` from `vector_math_64` not reachable from interpreted scripts. Bridge surface gap (pairs with §U6).
- [ ] **30.** §U22 — H23 single-event scripts deferred to interpreter-level work. Triage each script's specific failure mode.
- [ ] **31.** §U23 — 20260523-1056 H-5 follow-up: 7 single-event scripts deferred (small layout-rounding overflows + bridge SDK assertion).
- [ ] **32.** §U24 — `try { x = ui.SystemColor.light; }` does not intercept bridge-wrapped `UnsupportedError`. Bridge exception-routing fix.
- [ ] **33.** §U25 — Source-based interpreter cold-start parse + execute exceeds 50 s for `widgets/always_scrollable_scroll_physics_test.dart` in `tom_d4rt_flutter_test`. Source-interpreter performance work.
- [ ] **34.** §U27 — `Element.findRenderObject()` asserts `_lifecycleState == active` even when `mounted` is true. Likely upstream Flutter framework strictness; needs guard in interpreter callbacks.
- [ ] **35.** §U28 — flutter_ast accumulates state across `/clear → /build` cycles. **Implementation shipped** in commits `42588be2` + `d613142e` + `90854bc9` (resetScriptDeclarations API, /clear wiring, 7-case unit suite). **Verification pending** items #6/#7 above — leave this todo open until the live wedge-rate measurement closes it.
- [ ] **36.** §U29 — `MemoryImage(Uint8List)` codec rejects externally-valid PNG bytes constructed inside d4rt scripts. Bridge ↔ `ui.ImmutableBuffer` gap; needs a focused diagnostic test in `tom_d4rt_ast/test/`.
- [ ] **37.** §U30 — `InheritedElement.updateDependencies` descendant-check assertion (`framework.dart:6417`) fires as a U28-style position-dependent cascade in larger suites. Related to §U28 wedge family; revisit after #6/#7 with the post-fix data.

### Phase 4 — Cluster J / scope hygiene

- [ ] **38.** Confirm `interactive_tests_test.dart` time budget (currently 90 s per test, 180 s for setUpAll per quest TODO #11) still matches actual runtimes post-§U28 fix; tighten if wedges drop, leave if not.
- [ ] **39.** Verify the `D4RT_SKIP_BRIDGE_REGEN` env var continues to be respected after recent send_test_runner.dart changes (probe runs in this analysis didn't exercise the regen path; we set it explicitly via env, but the regen-staleness check inside `_ensureBridgesRegenerated` should still pass through cleanly).

---

**End of analysis.** Until item #1 lands, items #2 onward cannot make progress. The 28 evidence files in this folder are preserved as proof of the wedge mode; once the host is recovered, items #2/#3 will overwrite them with real captures.
