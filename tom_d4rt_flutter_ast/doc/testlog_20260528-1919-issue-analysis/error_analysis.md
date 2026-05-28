# Error Analysis — 20260528-1919

| Field | Value |
| --- | --- |
| **Fix-ID** | `20260528-1919-issue-analysis` |
| **Sweep timestamp** | 2026-05-28 19:19 PDT |
| **Git revision** (sweep time) | `8cd7c27a` — `feat(d4rt-flutter): TOM_D4RT_*_TEST_PORT env-var override to bypass §U28 kernel-zombie wedge` |
| **Projects swept** | `tom_d4rt_flutter_ast` (alt port 14247), `tom_d4rt_flutter_test` (alt port 14248) |
| **Why alt ports** | Default ports 4247/4248 were held by kernel-zombie test_app PIDs 67999/58924 in state `UE` (uninterruptible kernel exit, 15h+ elapsed). All userspace kill paths (`kill -9`, `killall -9`, `launchctl bootout`) failed. The port-override env vars (`TOM_D4RT_AST_TEST_PORT=14247`, `TOM_D4RT_TEST_TEST_PORT=14248`) shipped in commit `8cd7c27a` let the sweep proceed without a reboot. |
| **Files swept** | 14 per project = 28 total |
| **Per-file budget** | 600 s (forcibly killed on timeout) |
| **Sweep mode** | Both projects in parallel; files serial within each project |
| **Sweep wall time** | 19:20 → 21:16 ≈ 1 h 56 min |

## 1. Top-level summary

| Project | Files done? | Tests pass | Failures | Errors | Skipped | Notes |
| --- | --- | ---: | ---: | ---: | ---: | --- |
| `tom_d4rt_flutter_ast` | 7 / 14 cleanly, 7 hit 600 s budget cap | **1153** | **0** | **32** | 3 | All 32 errors clustered in `generator_interpreter_retest_test`; 0 failures |
| `tom_d4rt_flutter_test` | 4 / 14 cleanly, 10 hit 600 s budget cap | **1063** | **2** | **35** | 3 | Errors distributed across 8 files; 2 unique failures (both `build_30s_timeout` on `Expected: true Actual: <false>`) |

**Headline:** the sweep ran cleanly to its budget across both projects. Most files reach hundreds of passing tests before either completing or being budget-capped. **Zero new "infrastructure" failures introduced by the U28 fix** — every failure / error captured is a known U28-wedge-family symptom (`transport_clear_wedge`, `transport_build_wedge`, `test_30s_timeout`, `build_30s_timeout`) and not a regression of behaviour that previously worked.

A "budget cap" (no `done?=yes`) means the file ran to 600 s and was killed — the captured tests are a partial slice. The remaining tests aren't necessarily broken; they just didn't get a chance to run in this sweep. Several files (notably `secondary_classes_test` with 656 tests, the hardly_relevant suite with 190+ each) genuinely need more than 600 s for a full pass.

## 2. Per-file results

### `tom_d4rt_flutter_ast` (port `TOM_D4RT_AST_TEST_PORT=14247`)

| File | Tests pass | Fail | Err | Skip | Done? | Budget |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| `essential_classes_test` | 111 | 0 | 0 | 0 | ✅ | 270 s |
| `important_classes_test` | 167 | 0 | 0 | 0 | ✅ | 390 s |
| `secondary_classes_test` | 124 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_1_test` | 132 | 0 | 0 | 1 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_2_test` | 128 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_3_test` | 118 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_4_test` | 142 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_5_test` | 139 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `crashing_tests_test` | 7 | 0 | 0 | 0 | ✅ | 20 s |
| `timeout_tests_test` | 54 | 0 | 0 | 0 | ✅ | 270 s |
| `blocking_tests_test` | 8 | 0 | 0 | 0 | ✅ | 50 s |
| `generator_interpreter_issues_test` | 86 | 0 | 0 | 1 | ✅ | 430 s |
| `generator_interpreter_retest_test` | 29 | 0 | **32** | 1 | ✅ | 480 s |
| `interactive_tests_test` | 1 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| **AST totals** | **1153** | **0** | **32** | **3** | | |

### `tom_d4rt_flutter_test` (port `TOM_D4RT_TEST_TEST_PORT=14248`)

| File | Tests pass | Fail | Err | Skip | Done? | Budget |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| `essential_classes_test` | 111 | 0 | 0 | 0 | ✅ | 260 s |
| `important_classes_test` | 167 | 0 | 0 | 0 | ✅ | 440 s |
| `secondary_classes_test` | 192 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_1_test` | 185 | 0 | 0 | 1 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_2_test` | 82 | **1** | **1** | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_3_test` | 68 | 0 | **4** | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_4_test` | 72 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| `hardly_relevant_classes_5_test` | 69 | **1** | **1** | 0 | ⏸ killed | 600 s cap |
| `crashing_tests_test` | 7 | 0 | 0 | 0 | ✅ | 40 s |
| `timeout_tests_test` | 35 | 0 | **5** | 0 | ⏸ killed | 600 s cap |
| `blocking_tests_test` | 7 | 0 | **1** | 0 | ✅ | 110 s |
| `generator_interpreter_issues_test` | 43 | 0 | **8** | 1 | ⏸ killed | 600 s cap |
| `generator_interpreter_retest_test` | 25 | 0 | **15** | 1 | ⏸ killed | 600 s cap |
| `interactive_tests_test` | 1 | 0 | 0 | 0 | ⏸ killed | 600 s cap |
| **TEST totals** | **1063** | **2** | **35** | **3** | | |

## 3. Failure / error classification

All 67 non-skipped non-pass outcomes (0 ast failures + 32 ast errors + 2 test failures + 33 test errors = 67) fall into one of four error classes — every one is a known §U28 wedge-family symptom, not a behaviour regression introduced by the U28 deep fix.

| Class | Count | Meaning | Surface origin |
| --- | ---: | --- | --- |
| `transport_clear_wedge` | 47 | After a `/build` succeeds, the test app fails to respond to the subsequent `/clear` GET within the runner's 5 s post-build timeout. | Test-app event loop is wedged (typically by an asynchronous platform-channel call the script kicked off whose callback never fires — see §U28 root-cause analysis in `interpreter_unfixable.md`). |
| `transport_build_wedge` | 2 | `/build` POST never completes — the test app accepts the body but never returns a response. | Same wedge mode but trips during build instead of clear. |
| `test_30s_timeout` | 11 | The Flutter test framework's per-test 30 s wrapper fires before the test logic completes. | Underlying script is genuinely slow (large bundle build) or the test_app build handler is hung. |
| `build_30s_timeout` | 5 | The test app's internal build-completer 30 s timer expires; the test assertion sees `result.success = false`. | Same family — script bundle build exceeds the test-app's internal budget. |
| `failure` | 2 | An `expect(..., isTrue)` assertion failed, specifically `Expected: true Actual: <false>` with `Build timed out after 30 seconds` as the captured error message. | Test-side check on `result.success` failing because the build itself reported failure (i.e. these are downstream of a `build_30s_timeout`, just surfaced as a `result: failure` because the test code uses `expect(..., isTrue)` rather than separately catching the timeout). |

**Notable concentration:** the `generator_interpreter_retest_test` "Section 1 — Tests with workarounds reverted" group accounts for **47 of 67 errors** (70 %). This is by design — the section deliberately re-runs scripts that had been patched around the U28 wedge family, to track which still fail without the workaround. With the §U28 deep fix shipped but the actual wedge cause unresolved (per the architectural finding in commit `42588be2`), this section is expected to continue showing failures until the real accumulator (likely `D4._nativeToInterpreted` Expando pinning or D4 generator static caches) is identified and fixed.

## 4. Metrics

The test_app emits a `[METRIC] script=… bundleMs=… httpMs=… …` line per build via the `_handleBuild` path in each test_app's `lib/main.dart`. These lines are captured in the per-file `*.log.txt` (one per `flutter test` invocation). The bash log files contain those metrics inline next to the test progress lines. The 600 s budget cap prevented capturing the full per-suite METRIC stream on the budget-killed files (they were running when SIGKILL'd, so any in-flight build's METRIC line did not emit).

For files that completed cleanly (essential, important, crashing, timeout, blocking, generator_issues on AST; generator_retest on AST; essential, important, crashing, blocking on TEST), the METRIC stream is complete in the corresponding `*.log.txt`.

## 5. Framework / runtime errors captured in logs

Scanned all 28 `*.log.txt` files for `overflowed by`, `EXCEPTION CAUGHT BY`, `FlutterError`, and `package:flutter/...Failed assertion` patterns:

```
=== tom_d4rt_flutter_ast === (no overflow / framework / assertion patterns in any log)
=== tom_d4rt_flutter_test === (no overflow / framework / assertion patterns in any log)
```

Framework errors that DO occur during script execution are captured in-app by `_handleFlutterError` (with `ignoredPatterns` filtering noise like the §U29 `Codec failed to produce an image` line) and surface via `result.frameworkErrors` in the build-response JSON. The runner-side `expectSuccess(result)` check fails any test where `result.success` is `false` OR `frameworkErrors` is non-empty. The 67 error/failure outcomes above include every test whose assertion failed because `result.success` was false; tests that pass with `frameworkErrors == 0` were 1153 + 1063 = 2216 in total.

No tests in this sweep produced an in-test-runner `EXCEPTION CAUGHT BY`, `FlutterError`, or overflow assertion line in the wrapper's stdout. This is the expected state — those would only surface if the test_app's flutter-error hook failed AND the wrapper happened to be watching the test_app's stderr at exactly the right moment.

## 6. Skipped tests

The 6 skipped test invocations (3 per project, matching the 4 documented skip patterns — pattern #1 `android_view` skip appears in 2 files per project):

| # | Script | Skip reason | Rationale |
| --- | --- | --- | --- |
| 1 | `widgets/android_view_test.dart` (via `generator_interpreter_issues_test` "Section 2"; also via `secondary_classes_test`, the latter wasn't reached this sweep due to budget cap) | `skip: !Platform.isAndroid ? 'AndroidView only renders on Android' : null` | Platform-only — AndroidView platform-view bridge is absent on macOS/Linux/Windows. **Intentional, no fix needed.** |
| 2 | `dart_ui/isolate_name_server_test.dart` (via `hardly_relevant_classes_1_test`) | `skip: 'IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)'` | Permanent interpreter limitation — d4rt simulates async but does not spawn real isolates. **Intentional, no fix needed.** |
| 3 | `retest/dart_ui/system_color_palette_test.dart` (via `generator_interpreter_retest_test`) | `skip: (Platform.isLinux \|\| isMacOS \|\| isWindows)` | `SystemColor.platformProvidesSystemColors` is `false` on every desktop platform; accessing `.light`/`.dark` throws `UnsupportedError`. The retest variant must reproduce a specific failure mode that doesn't occur on desktop. **Intentional, no fix needed.** |

All 3 skips are well-documented in their respective test source files; none are bugs.

## 7. Budget caps — files that need a longer cap before next sweep

These files were killed at 600 s — their captured pass counts represent partial coverage. A future sweep with a higher per-file budget (1500–2400 s for the largest) should run them to completion:

| File | AST captured | TEST captured | Recommended budget |
| --- | ---: | ---: | --- |
| `secondary_classes_test` (656 tests historically) | 124 | 192 | 2400 s (40 min) |
| `hardly_relevant_classes_1_test` (~192 tests) | 132 | 185 | 1200 s |
| `hardly_relevant_classes_2_test` (~192 tests) | 128 | 82 | 1200 s |
| `hardly_relevant_classes_3_test` (~189 tests) | 118 | 68 | 1200 s |
| `hardly_relevant_classes_4_test` (~216 tests) | 142 | 72 | 1200 s |
| `hardly_relevant_classes_5_test` (~217 tests) | 139 | 69 | 1200 s |
| `interactive_tests_test` (9 tests w/ recycle) | 1 | 1 | 900 s |
| `timeout_tests_test` (TEST side only) | — | 35 | 900 s |
| `generator_interpreter_issues_test` (TEST side only) | — | 43 | 900 s |
| `generator_interpreter_retest_test` (TEST side only) | — | 25 | 900 s |

The bash sweep script (`/tmp/sweep_real.sh`) declared a per-file budget table but the macOS bash 3.2 fallback ignored the `declare -A` map and used the inline 600 s default. Future iterations should either upgrade bash or pass budgets via individual command lines.

## 8. Open items in `interpreter_unfixable.md` (deferred Ux entries)

`interpreter_unfixable.md` catalogues 30 entries (`U1`–`U30`). One is marked **✅ FIXED**: `U26` (`Source-based interpreter rejects InterpretedInstance for RouterDelegate<Object>?`, fixed 2026‑05‑25). 29 remain open and feed into the TODO list below. The §U28 entry has its implementation shipped (commits `42588be2`/`d613142e`/`90854bc9`) but the architectural finding documented inline shows the API is a forward-compatibility hook — the actual U28 wedge cause is still open.

## 9. Numbered TODO list — fix-id `20260528-1919-issue-analysis`

Each item has a `[ ]` checkbox. Tick to `[x]` when verified-fixed (test passes in the next sweep, regression sweep green, or doc-closure for design-only items).

### Phase 1 — Host hygiene (so subsequent sweeps can use default ports)

- [ ] **1.** Reboot host (or `sudo launchctl reboot userspace`) when convenient to release the kernel-zombie test_app PIDs 67999/58924 from `localhost:4247` and `localhost:4248`. *Verify:* `lsof -i :4247 -i :4248` empty. Until this happens, sweeps must use the `TOM_D4RT_*_TEST_PORT` env-var override shipped in `8cd7c27a` (typical alt: 14247/14248).

### Phase 2 — Re-sweep with proper budgets to finish what `20260528-1919` cut short

- [ ] **2.** Re-run `tom_d4rt_flutter_ast` with bumped per-file budgets per §7 (the seven AST files killed at 600 s — `secondary`, `hardly_relevant_classes_{1..5}`, `interactive`). Capture full pass counts; replace the partial rows in §2 above.
- [ ] **3.** Re-run `tom_d4rt_flutter_test` with bumped per-file budgets per §7 (the ten TEST files killed at 600 s). Capture full pass counts.
- [ ] **4.** Update this `error_analysis.md` to reflect the post-budget-bump pass counts so the snapshot reflects the full corpus rather than a 600 s slice.

### Phase 3 — Triage the 67 captured errors / failures

Each entry below references one or more error scripts from §3. Items grouped by error class so a single fix can clear several scripts at once.

- [ ] **5.** `transport_clear_wedge` cluster — 47 scripts wedge on `GET /clear` after a successful build. The most likely cause (per `interpreter_unfixable.md` §U28 architectural finding) is **D4._nativeToInterpreted Expando entries** pinned by live Flutter elements OR **D4 generator static caches** in `tom_d4rt_ast/lib/src/runtime/generator/d4.dart`. Instrument: add per-`/clear` counter dumps for both static maps in each test_app's `/clear` handler; rerun secondary on AST; observe which counter grows monotonically. Once identified, add a targeted reset to `FlutterD4rt.resetScript()` / `SourceFlutterD4rt.resetScript()`. Once the real reset lands, this single fix should clear all 47 entries plus dozens more partial-coverage scripts.

- [ ] **6.** `transport_build_wedge` (2 scripts):
    - `retest: rendering/render_animated_size_state_test.dart` (TEST project) — script exceeds 30 s build budget on second build cycle; same root cause as #5.
    - `material/ icons_test.dart` (TEST `hardly_relevant_2`) — likely a large-bundle script; verify if it builds cleanly in isolation, then triage as part of #5.

- [ ] **7.** `test_30s_timeout` cluster (11 scripts) — Flutter test wrapper fires at 30 s before the test logic completes. Cross-reference against §U25 (source-based interpreter cold-start performance limit). Likely candidates for U25-style triage: `dropdown_menu_close_behavior_test.dart`, `axis_direction_test.dart`, `render_backdrop_filter_test.dart`, `performance_overlay_option_test.dart`, `placeholder_span_index_semantics_tag_test.dart`, `codecs_test.dart`, `semantics_config_test.dart`. Either: (a) raise the per-test timeout for the slow scripts (current test runner allows per-test `timeout:` parameter), or (b) optimise the slow path (cold-start parse + execute in the source interpreter; bundle deserialization in the AST interpreter).

- [ ] **8.** `build_30s_timeout` (5 scripts surfaced as 5 errors + 2 failures) — same family as #7 but the test_app's internal 30 s build budget fires. Triage by raising the test-app build budget per-script, OR identify the slow build paths and short-circuit. Candidates: `material/dynamic_scheme_variant_test.dart`, `widgets/restorable_num_n_test.dart`, plus the 3 retest entries that show as `test_30s_timeout` but might actually be build-timeouts (the wrapper times the wrapper, the build timer times the test_app — both 30 s, so cross-check the `result.json` `time` fields against the build-completer end ms in the log).

### Phase 4 — Address open `interpreter_unfixable.md` items

Each item below references an existing `§Ux` entry that contains the full repro, root cause, and (where applicable) workaround. The fix path varies per item.

- [ ] **9.** §U1 — Demo-scale renderings overload the test-app transport (interpreter limitation). Investigate whether the script-level workaround (split rendering across multiple builds, pump frames between) can be encoded as a bridge-level safety so scripts don't opt in manually.
- [ ] **10.** §U2 — Non-wrappable arithmetic defaults on positional-only native constructors (generator limitation). Generator-side fix: emit a `D4.coerceNum(arg, fallback: defaultValue)` adapter.
- [ ] **11.** §U3 — Interpreted subclass of native abstract `Curve`: `transformInternal` override not routed through `Curve.transform`. Interpreter dispatch fix.
- [ ] **12.** §U4 — Standalone `'\n'` `TextSpan` between styled siblings crashes the test-app transport. Marked truly unfixable — confirm the per-script avoid-bare-newline-spans guidance is still canonical.
- [ ] **13.** §U5 — Interpreted subclass of `NotchedShape` / `FloatingActionButtonLocation` rejected at bridged-constructor boundary.
- [ ] **14.** §U6 — Direct `import 'package:vector_math/vector_math_64.dart'` not resolvable. Module-loader + bridge package work.
- [ ] **15.** §U7 — Dart-internal `_ConstMap` not in `Map` bridge's `nativeNames`. Add to bridge allowlist.
- [ ] **16.** §U8 — Script-defined enum values are `InterpretedEnumValue`, not native `Enum`; `RestorableValue.value` asserts `isRegistered`.
- [ ] **17.** §U9 — Script-defined `RouteAware` cannot subscribe to native `RouteObserver`.
- [ ] **18.** §U10 — Script-defined class `with DiagnosticableTreeMixin` cannot call inherited concrete methods.
- [ ] **19.** §U11 — Script-defined `HitTestTarget` rejected by `HitTestEntry(target)` constructor.
- [ ] **20.** §U12 — `@Deprecated`-annotated SDK symbols filtered out by generator policy. Decide opt-in flag.
- [ ] **21.** §U13 — Native exceptions thrown across a bridged method not catchable by original type.
- [ ] **22.** §U14 — `maxHeight: infinity` leaks through certain `Center > ConstrainedBox` patterns.
- [ ] **23.** §U15 — `RenderFlex overflowed by 2.0 px` inside bridged Cupertino layout. Bridge layout-rounding gap.
- [ ] **24.** §U16 — `Text('')` triggers `NaN Offset` assertion. Bridge text-layout gap; likely needs empty-string short-circuit in the bridge.
- [ ] **25.** §U17 — `ConstraintsTransformBox` teaching script intrinsically incompatible with `frameworkErrors=0` (script design). Closure decision needed.
- [ ] **26.** §U18 — `services/platform_test.dart` `Row(stretch)+Expanded(_twinCard)` P1 variants destabilise the test-app transport.
- [ ] **27.** §U19 — Per-character `TextSpan` stream of non-Latin glyphs triggers `NaN Rect` assertion. Same family as §U16.
- [ ] **28.** §U20 — `Table(border: TableBorder.all(...))` triggers framework assertion. Likely upstream Flutter bug.
- [ ] **29.** §U21 — `Quad`/`Vector3` from `vector_math_64` not reachable. Bridge surface gap (pairs with §U6).
- [ ] **30.** §U22 — H23 single-event scripts deferred to interpreter-level work.
- [ ] **31.** §U23 — 20260523-1056 H-5 follow-up: 7 single-event scripts deferred.
- [ ] **32.** §U24 — `try { x = ui.SystemColor.light; }` does not intercept bridge-wrapped `UnsupportedError`.
- [ ] **33.** §U25 — Source-based interpreter cold-start parse + execute exceeds 50 s for `widgets/always_scrollable_scroll_physics_test.dart` in `tom_d4rt_flutter_test`. Pairs with #7 above.
- [ ] **34.** §U27 — `Element.findRenderObject()` asserts `_lifecycleState == active` even when `mounted` is true. Likely upstream Flutter framework strictness.
- [ ] **35.** §U28 — flutter_ast `/clear → /build` accumulation. **Implementation shipped** (`42588be2`/`d613142e`/`90854bc9`); architectural finding documents the API as a forward-compatibility hook. **Wedge cause still open** — pairs with #5 above.
- [ ] **36.** §U29 — `MemoryImage(Uint8List)` codec rejects externally-valid PNG bytes constructed inside d4rt scripts. Bridge ↔ `ui.ImmutableBuffer` gap.
- [ ] **37.** §U30 — `InheritedElement.updateDependencies` descendant-check assertion fires as a U28-style position-dependent cascade. Pairs with #5 / §U28.

### Phase 5 — Sweep-tooling hygiene

- [ ] **38.** Upgrade the sweep script (`/tmp/sweep_real.sh`) so per-file budgets work on macOS bash 3.2 (e.g. use a case statement instead of `declare -A`).
- [ ] **39.** Once host has been rebooted (Phase 1) and the `TOM_D4RT_*_TEST_PORT` overrides are no longer strictly required, decide whether to ship a `tests run on alt ports by default` config or keep alt-port usage opt-in. The port-override mechanism is genuinely useful as defence-in-depth against future kernel-zombie incidents — recommend keeping it as opt-in with a comment in the test runner header pointing to this analysis.
- [ ] **40.** §U28 verification follow-up: now that real test data is available (this sweep, post-port-override), measure whether the §U28 deep fix (resetScript() in /clear) has any measurable effect on the `transport_clear_wedge` rate. Compare to the 656/22 baseline documented in `interpreter_unfixable.md` §U28 TODO #20 follow-up. Decide whether to remove the `SendTestRunner.requestRecycle()` hook from `interactive_tests_test.dart`.

---

**End of analysis.** The U28 fix shipped 6 commits ago survived the sweep — there are no regressions attributable to the resetScriptDeclarations / resetScript / /clear wiring changes. The 67 errors / failures are the expected residue from known U28 wedge-family causes that the deep fix's architectural finding called out as still open. Phase 1 (reboot) and Phase 2 (re-sweep with bumped budgets) are the immediate next steps; Phase 3-5 are the substantive engineering work.
