# Error Analysis — 20260529-1944

| Field | Value |
| --- | --- |
| **Fix-ID** | `20260529-1944-issue-analysis` |
| **Sweep timestamp** | 2026-05-29 19:44:52 → 21:36:58 CEST (1 h 52 min wall) |
| **Git revision** (sweep time) | `0515871f` — `docs(d4rt-flutter): close 2206 TODO #40 — DEFERRED, blocked on TODO #2 host reboot` |
| **Projects swept** | `tom_d4rt_flutter_ast` (alt port 14250), `tom_d4rt_flutter_test` (alt port 14251) |
| **Why alt ports** | Defaults 4247/4248 + previous alts 14247/14248 still held by four kernel-zombie test_app processes in state `UE` (per 2206 TODO #2; user reboot still pending). |
| **Driver script** | `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh` (the 2206 TODO #39 promotion's **first end-to-end run** — verified working) |
| **Files swept** | 14 per project = 28 total |
| **Per-file budget** | Per `sweep_both_projects.sh` table (essential 300, important 900, secondary 2400, hardly_relevant_* 1200, crashing 300, timeout 900, blocking 300, generator_* 900, interactive 900). |
| **Sweep mode** | Both projects parallel (different ports); files serial within each project. |

## 1. Top-level summary

| Project | Tests pass | Failures | Errors | Skipped | Files done? | Pass rate (non-skip) |
| --- | ---: | ---: | ---: | ---: | --- | ---: |
| `tom_d4rt_flutter_ast` | **2191** | **0** | **4** | **4** | 14/14 ✅ | **99.8 %** |
| `tom_d4rt_flutter_test` | **2058** | **0** | **7** | **4** | 13/14 (secondary_classes_test KILLED at 2400 s budget — 524/656 tests run) | **99.7 %** of completed |
| **Combined** | **4249** | **0** | **11** | **8** | 27/28 cleanly | **99.7 %** |

**Headline:** the sweep produced **0 failures, 11 errors, 0 framework-error log noise** across 4249 passing tests on 2026-05-29's HEAD. This is a **dramatic improvement** over the 2206 baseline (which had 1 fail + 79 err) — see comparison below. The 11 residual errors all classify as `transport_clear_wedge` (§U28 family per the 2206 doc — root cause outside d4rt runtime per the disproved D4-static/Expando hypothesis in 2206 TODO #3). All 8 skips are intentional and identical to the 2206 set.

**Major comparison vs 2206 sweep:**

| Metric | 2206 sweep | 1944 sweep | Δ |
| --- | ---: | ---: | --- |
| AST pass | 2184 | 2191 | +7 |
| TEST pass | 2125 | 2058 | -67 (TEST secondary_classes KILLED — 132 tests not run) |
| AST failures | 1 | **0** | **−1 (clean)** |
| AST errors | 20 | **4** | **−16 (−80 %)** |
| TEST errors | 59 | **7** | **−52 (−88 %)** |
| Combined errors | 79 | **11** | **−68 (−86 %)** |
| Framework-error log hits | 5 (§U17 ×2 TEST + §U29 ×3 TEST) | **0** | **−5 (clean)** |
| Skipped | 8 | 8 | unchanged |

**What changed between 2206 and 1944 (a single day):**

- **2206 TODO #4 phase 2** bumped 24 test_30s_timeout sites with `_slowTestTimeout = 60s` + `_verySlowTestTimeout = 120s` → eliminated 48 `test_30s_timeout` errors from the 2206 baseline.
- **2206 TODO #7+#8** added `else if (!isIgnored)` guard in `_handleFlutterError` → eliminated all 5 captured framework-error log events (§U17 + §U29 + §U30 noise) from the 2206 baseline.
- **2206 TODO #5** added per-request `?buildBudgetMs=N` to test_apps' `/build` handler → eliminated the `build_30s_timeout` cluster (the AST `app_kit_view_test` failure).
- **2206 TODO #6** added `@Timeout(Duration(seconds: 240))` library annotation to TEST `interactive_tests_test.dart` → eliminated the TEST `setUpAll` timeout.
- **2206 TODO #38** removed `requestRecycle()` hook from AST `interactive_tests_test.dart` → 130 s → **40 s** wall time per the 2206 TODO #38 close + verified here at 40 s once more.

## 2. Per-file results

### `tom_d4rt_flutter_ast` (port `TOM_D4RT_AST_TEST_PORT=14250`)

| File | Pass | Fail | Err | Skip | Done? | Budget / Used |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| `essential_classes_test` | 108 | 0 | 0 | 0 | ✅ | 300 / 270 s |
| `important_classes_test` | 164 | 0 | 0 | 0 | ✅ | 900 / 380 s |
| `secondary_classes_test` | 653 | 0 | 0 | 1 | ✅ | 2400 / 1930 s |
| `hardly_relevant_classes_1_test` | 204 | 0 | 0 | 1 | ✅ | 1200 / 630 s |
| `hardly_relevant_classes_2_test` | 203 | 0 | 0 | 0 | ✅ | 1200 / 370 s |
| `hardly_relevant_classes_3_test` | 199 | 0 | **2** | 0 | ✅ | 1200 / 550 s |
| `hardly_relevant_classes_4_test` | 227 | 0 | 0 | 0 | ✅ | 1200 / 410 s |
| `hardly_relevant_classes_5_test` | 230 | 0 | 0 | 0 | ✅ | 1200 / 460 s |
| `crashing_tests_test` | 4 | 0 | 0 | 0 | ✅ | 300 / 30 s |
| `timeout_tests_test` | 50 | 0 | **1** | 0 | ✅ | 900 / 200 s |
| `blocking_tests_test` | 5 | 0 | 0 | 0 | ✅ | 300 / 50 s |
| `generator_interpreter_issues_test` | 82 | 0 | 0 | 1 | ✅ | 900 / 230 s |
| `generator_interpreter_retest_test` | 56 | 0 | **1** | 1 | ✅ | 900 / 190 s |
| `interactive_tests_test` | 6 | 0 | 0 | 0 | ✅ | 900 / **40 s** (was 130 s with recycle pre-TODO #38) |
| **AST totals** | **2191** | **0** | **4** | **4** | | |

### `tom_d4rt_flutter_test` (port `TOM_D4RT_TEST_TEST_PORT=14251`)

| File | Pass | Fail | Err | Skip | Done? | Budget / Used |
| --- | ---: | ---: | ---: | ---: | --- | --- |
| `essential_classes_test` | 108 | 0 | 0 | 0 | ✅ | 300 / 270 s |
| `important_classes_test` | 162 | 0 | **2** | 0 | ✅ | 900 / 520 s |
| `secondary_classes_test` | 523 | 0 | 0 | 1 | ⚠️ **KILLED at 2400 s budget** (524/656 tests run; 132 untouched) | 2400 / 2400 s |
| `hardly_relevant_classes_1_test` | 204 | 0 | 0 | 1 | ✅ | 1200 / 620 s |
| `hardly_relevant_classes_2_test` | 203 | 0 | 0 | 0 | ✅ | 1200 / 400 s |
| `hardly_relevant_classes_3_test` | 200 | 0 | **1** | 0 | ✅ | 1200 / 500 s |
| `hardly_relevant_classes_4_test` | 227 | 0 | 0 | 0 | ✅ | 1200 / 530 s |
| `hardly_relevant_classes_5_test` | 229 | 0 | **1** | 0 | ✅ | 1200 / 520 s |
| `crashing_tests_test` | 4 | 0 | 0 | 0 | ✅ | 300 / 20 s |
| `timeout_tests_test` | 51 | 0 | 0 | 0 | ✅ | 900 / 230 s |
| `blocking_tests_test` | 5 | 0 | 0 | 0 | ✅ | 300 / 40 s |
| `generator_interpreter_issues_test` | 81 | 0 | **1** | 1 | ✅ | 900 / 210 s |
| `generator_interpreter_retest_test` | 55 | 0 | **2** | 1 | ✅ | 900 / 220 s |
| `interactive_tests_test` | 6 | 0 | 0 | 0 | ✅ | 900 / **40 s** |
| **TEST totals** | **2058** | **0** | **7** | **4** | | |

## 3. Error classification — the 11 transport_clear_wedge cases

All 11 errors fit the `transport_clear_wedge` pattern documented in 2206 §3 (POST /build TimeoutException at 25 s, or GET /clear HttpException). **No new error class** appeared.

### AST (4 errors)

| # | File | Failing test (script) | Operation | Notes |
| --- | --- | --- | --- | --- |
| A1 | `hardly_relevant_classes_3_test` | `rendering/alignment_geometry_tween_test.dart` | POST /build TimeoutException 25s | NEW symptom — not in 2206 baseline |
| A2 | `hardly_relevant_classes_3_test` | `rendering/annotated_region_layer_test.dart` | POST /build TimeoutException 25s | NEW symptom — not in 2206 baseline |
| A3 | `timeout_tests_test` | `retest: rendering/render_animated_size_state_test.dart` | POST /build TimeoutException 25s | NEW symptom; despite the 50s `httpBuildTimeout` set inline at line 257 the post-/clear was wedged before the call ever made it past 25s |
| A4 | `generator_interpreter_retest_test` | `retest: rendering/render_animated_size_state_test.dart` | GET /clear HttpException ("Connection closed before full header was received") | NEW symptom; same script as A3 — clears were wedged at the *connection* level not the request level |

### TEST (7 errors)

| # | File | Failing test (script) | Operation | Notes |
| --- | --- | --- | --- | --- |
| T1 | `important_classes_test` | `material/bottomappbar_test.dart` | POST /build TimeoutException 25s | Repeat from 2206 baseline (AST important_classes); now also on TEST |
| T2 | `important_classes_test` | `material/expansionpanel_test.dart` | POST /build TimeoutException 25s | NEW symptom |
| T3 | `hardly_relevant_classes_3_test` | `rendering/alignment_geometry_tween_test.dart` | POST /build TimeoutException 25s | Same script as A1 (both projects hit it) |
| T4 | `hardly_relevant_classes_5_test` | `widgets/reading_order_traversal_policy_test.dart` | POST /build TimeoutException 25s | NEW symptom |
| T5 | `generator_interpreter_issues_test` | `widgets/render_object_to_widget_adapter_test.dart` | POST /build TimeoutException 25s | NEW symptom |
| T6 | `generator_interpreter_retest_test` | `retest: dart_ui/key_event_type_test.dart` | POST /build TimeoutException 25s | NEW symptom |
| T7 | `generator_interpreter_retest_test` | `retest: rendering/render_animated_size_state_test.dart` | GET /clear HttpException | Mirrors A4 on TEST |

**Cross-project repeat scripts** (genuine wedge candidates):

| Script | AST hit | TEST hit |
| --- | --- | --- |
| `rendering/alignment_geometry_tween_test.dart` | A1 | T3 |
| `retest: rendering/render_animated_size_state_test.dart` | A3 + A4 | T7 |

These 2 scripts triggered the wedge **on both projects in the same sweep**, suggesting they are intrinsically more wedge-prone than the other 7 single-occurrence sites.

## 4. Framework errors captured in `*.log.txt` (user-requested "flutter output … overflow errors")

Scanned all 28 log files on both projects for `EXCEPTION CAUGHT BY`, `overflowed by`, `FlutterError` patterns:

```
=== tom_d4rt_flutter_ast ===
  (no matches)
=== tom_d4rt_flutter_test ===
  (no matches)
```

**Zero framework-error noise across all 28 log files** — the cumulative effect of:
1. 2026-05-25 Cluster H ignoredPatterns entry `'Codec failed to produce an image'` (§U29)
2. 2026-05-25 Cluster B interpreter-visitor `findRenderObject` catch (§U27)
3. 2026-05-25 Cluster C `requestRecycle()` mechanism (§U28 operational)
4. 2026-05-27 TODO #9 ignoredPatterns entry `'check that it really is our descendant'` (§U30)
5. **2026-05-29 TODO #7/#8 `else if (!isIgnored)` guard** in `_handleFlutterError` — closed the stdout/stderr leak that the prior `ignoredPatterns` entries silenced from `_frameworkErrors` but did not stop from reaching `_originalFlutterErrorHandler`

is holding up perfectly. No `RenderConstraintsTransformBox overflowed`, no `Codec failed`, no `check that it really is our descendant`, no `Offset argument contained a NaN value`, no `Rect argument contained a NaN value`, no `BoxConstraints forces an infinite height`, no `'rows.isEmpty || ... rows.last <= rect.height'` hits anywhere.

## 5. Metrics

Per-build METRIC lines are in each `*.log.txt`. Aggregate summary not extracted in this pass; future sweeps could add a `make_metrics_summary.py` step.

Wall-time breakdown (driver log):

| Project | Total wall | Per-file used (sum) | Headline |
| --- | --- | --- | --- |
| AST | 19:44:52 → 21:24:02 = 1 h 39 min | sum = 5800 s ≈ 1 h 37 min | finished cleanly; 14/14 files within budget |
| TEST | 19:44:52 → 21:36:58 = 1 h 52 min | sum = 6520 s ≈ 1 h 49 min | 13/14 within budget; secondary_classes hit the 2400 s cap (was 1910 s in 2206 — 26 % slower this time, suggesting host-load variance more than a regression) |

## 6. Skipped tests

8 total skipped invocations (4 per project) — **identical to the 2206 sweep**. Skip reasons extracted from each test's `Skip:` print event:

| # | Script | Host suite(s) | Skip reason | Rationale |
| --- | --- | --- | --- | --- |
| 1 | `widgets/android_view_test.dart` | `secondary_classes_test` + `generator_interpreter_issues_test` | `AndroidView only renders on Android` | Platform-only. **Intentional, no fix.** |
| 2 | `dart_ui/isolate_name_server_test.dart` | `hardly_relevant_classes_1_test` | `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)` | Permanent interpreter limitation. **Intentional, no fix.** |
| 3 | `retest/dart_ui/system_color_palette_test.dart` | `generator_interpreter_retest_test` | `SystemColor not supported on desktop platforms (web-only API)` | Desktop-platform skip (§U24 workaround per 2206 TODO #32 — same logic on both projects). **Intentional, no fix.** |

Same 3 rationales × 2 projects + 1 extra duplication on `android_view_test` (counted in both `secondary_classes` and `gii` on each project) = 8 explicit skips. All documented in the test source files; no new skips to investigate.

## 7. Open items in `interpreter_unfixable.md`

`interpreter_unfixable.md` catalogues 30 entries (U1–U30). FIXED markers so far: **U7, U15, U17, U26, U27, U29, U30** (FIXED in 2206 baseline; observable side fully closed). 23 entries remain open as architectural concerns but none produce observable failure in the 1944 sweep:

- **U28** (`/clear → /build` accumulation): operational `requestRecycle()` workaround was even removed from AST per 2206 TODO #38 and the AST `interactive_tests_test` still passes 6/6 in 40 s — confirming the cliff self-resolved.
- The 11 `transport_clear_wedge` errors in §3 above are still §U28-family in shape (same `TimeoutException after 0:00:25.000000` fingerprint as the 2206 TODO #3 investigation traced) but the real accumulator cause was disproven on the d4rt side and is suspected to live in Flutter framework subsystems (per 2206 TODO #3's negative finding).

## 8. Numbered TODO list — fix-id `20260529-1944-issue-analysis` (REWRITTEN 20260530)

**Replaces the original Phase 1–5 list (items #1–#8, all closed by 20260529-2353).** The 1944 sweep snapshotted 4249 passing + 0 fail + 11 err + 0 framework-error log noise — but per the 2026-05-30 review the user reframed three categories of bugs that the previous closure accepted too leniently:

1. **Framework errors** (`overflow by`, NaN Rect/Offset, codec failures, descendant assertions, infinite size during layout, etc.) are bugs. They must be fixed by **adapting the script**, not by suppressing the display via `ignoredPatterns`. The only exception is the rare case of intentionally testing the assertion machinery itself.
2. **Tests causing the test_app to stop** are bugs. The `requestRecycle()` recovery mechanism (commit `9f4dc79c`) helps the suite continue but is not a goal — the underlying breakdown must be fixed. The actual culprit may be a test that ran **before** the visibly failing test.
3. **Tests taking longer than 30 s** are bugs. Flutter tests should each take ≤10 s. Any `_slowTestTimeout = 60s` / `_verySlowTestTimeout = 120s` / `Timeout(Duration(seconds: 60+))` / `@Timeout(Duration(seconds: 240))` wrapper is a workaround for an underlying performance bug, not a fix.

**Goal:** all tests pass within <30 s each, with no test_app breakdowns, and with the `ignoredPatterns` chain emptied (or shrunk to exception-only entries).

**Numbering scheme (revised 20260530):** each phase uses a single Arabic counter that runs from 1 to x for individual TODO items (A.1, A.2, …; B.1, B.2, …; C.1, C.2, …). Subsection **headlines** use lower-case Roman numerals (A.i, A.ii, …; B.i, …; C.i, …) so they don't share the numbering space with the items. Iterate items by ascending Arabic number within each phase.

The list below enumerates every test affected by one or more of these three categories so they can be processed one by one. Each item carries `[ ]` for tracking.

### Phase A — Framework errors: scripts to rewrite so the suppressed error stops firing

The 8 distinct `ignoredPatterns` entries / interpreter catches each correspond to one or more real bugs. The right fix is to rewrite the affected script(s) so the underlying error stops firing, then remove the corresponding `ignoredPatterns` entry / catch. Items A.3 / A.4 / A.5 / A.6 / A.7 start as **single enumeration tasks** — each will likely spawn additional follow-up Arabic-numbered items (A.9, A.10, …) once the suppression is temporarily removed and each affected script is identified.

#### A.i — `'Codec failed to produce an image'` (§U29 family — `tom_d4rt_flutter_ast_app/lib/main.dart:364` + TEST `main.dart:310`)
- [ ] **A.1** `widgets/image_icon_test.dart` — rewrite to use a working `ImageProvider` (`AssetImage` with a bundled PNG, or replace `ImageIcon` with `Icon` for non-image visuals) so the bridge codec path doesn't reject the inline Uint8List bytes. Remove the `'Codec failed to produce an image'` entry from both test_apps' `ignoredPatterns` list once this clears. The bridge path that corrupts inline PNG bytes (`Uint8List.fromList(<int>[…])` → `MemoryImage._bytes` → `ImmutableBuffer.fromUint8List` → C++ codec) is documented in §U29 as an interpreter ↔ ui.ImmutableBuffer bridge gap — but fixing the script first is the rule.

#### A.ii — `'A RenderConstraintsTransformBox overflowed by'` (§U17 family — both `main.dart`s line 382 / 318)
- [ ] **A.2** `rendering/render_constraints_transform_box_test.dart` — rewrite Sections 4 / 7 / 8 (the live overflow demos) to use `OverflowBox` (which legitimately doesn't emit the banner) or replace the live render with annotated `BoxConstraints` diagrams + static schematics. The kHalveMaxWidth normalize fix (correctness) already shipped in 2206 TODO #21; the remaining work is the sections 4/7/8 rewrite. Remove the `'A RenderConstraintsTransformBox overflowed by'` `ignoredPatterns` entry once this clears.

#### A.iii — `'check that it really is our descendant'` (§U30 family — both `main.dart`s line 404 / 327)
- [ ] **A.3** Identify which scripts trigger the `InheritedElement.updateDependencies` descendant-check assertion (`framework.dart:6417`). The 2026-05-27 §U30 doc names the `rendering/render_constraints_transform_box_test.dart` → `rendering/render_custom_multi_child_layout_box_test.dart` adjacency observed in the 20260526-1401 sweep. To find the actual culprit (which may be the script that REGISTERS the stale dependent on Theme/MediaQuery, not the script that SEES the failed assertion), temporarily remove the `'check that it really is our descendant'` `ignoredPatterns` entry, re-run the full sweep, and identify each script that emits the assertion. Each becomes its own future Arabic-numbered item appended to Phase A (A.9, A.10, …). Per §U30 "Real fix" instrument `Element.deactivate` + `InheritedElement.updateDependencies` to trace which dependent fails and which Element registered it. Fix the culprit script's lifecycle (or fix the interpreter's interpreted-Element deactivation path) so the dependent set stays valid across `/build` cycles. Restore the suppression only for genuinely-exception-only cases.

#### A.iv — `'overflowed by 0.500 pixels'` (subpixel-rounding family — both `main.dart`s line 336 / 286)
- [ ] **A.4** Temporarily remove the `'overflowed by 0.500 pixels'` entry from both test_apps' `ignoredPatterns`, re-run the full sweep, and enumerate every script that emits the 0.500-pixel overflow banner. Each becomes its own future Arabic-numbered item appended to Phase A. The 0.500-pixel overflow is a subpixel-rounding error from the desktop test surface's non-integer device pixel ratio — fix the layout in each affected script so the children's sum doesn't round 0.5 px over the parent height (typical fixes: explicit `mainAxisSize: MainAxisSize.min` on the Column, `SizedBox(height: parentHeight.floor())`, `Padding(EdgeInsets.only(bottom: 0.5))` to give back the rounded pixel). Restore the suppression entry only if a residual demonstrably cannot be fixed.

#### A.v — `'infinite size during layout'` (debug-paint warning family — both `main.dart`s line 352 / 302)
- [ ] **A.5** Temporarily remove the `'infinite size during layout'` entry, re-sweep, and enumerate affected scripts. Each becomes a future Arabic-numbered item appended to Phase A. The warning fires when a render object resolves to an unbounded constraint (e.g. `Column` inside `SingleChildScrollView` without a bounded height ancestor). Fix the layout in each script using `IntrinsicHeight`, `SingleChildScrollView`, explicit `height`, etc. — the same pattern that 2206 TODOs #22 + #28 closed for `cubic_test` and `editable_text_misc_test`.

#### A.vi — `'parentDataDirty'` + `'parentData is set up correctly'` (lines 317-318 of both `main.dart`s — pre-existing baseline suppression)
- [ ] **A.6** Temporarily remove both entries from `ignoredPatterns`, re-sweep, and enumerate affected scripts. The framework fires these when a layout-children parentData wiring is wrong (e.g. forgot to call `child.parentData = ParentData()` in a custom layout). Fix the parentData wiring in each affected script's custom render object. Each newly-identified script becomes a future Arabic-numbered item appended to Phase A.

#### A.vii — `'_RenderEditableCustomPaint'` first-frame cascade + `"'hasSize'"` + `"'!childSemantics.renderObject._needsLayout'"` (lines 319-324 of both `main.dart`s — pre-existing baseline suppression)
- [ ] **A.7** Temporarily remove all 3 entries, re-sweep, and enumerate affected scripts. Each becomes a future Arabic-numbered item appended to Phase A. The cascade typically traces back to a `TextEditingValue` or `EditableText` setup that runs before the painter's first layout pass. Fix each script so the painter is laid out before the first frame asks for `hasSize` or the semantics layer asks for `_needsLayout`.

#### A.viii — Interpreter-visitor `findRenderObject` catch (§U27 family — `tom_d4rt/lib/src/interpreter_visitor.dart:3298-3300` + `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart:3757-3759`)
- [ ] **A.8** Identify every script that calls `findRenderObject()` and currently relies on the interpreter's `return null` catch for `'Cannot get renderObject of inactive element'` (e.g. `rendering/render_absorb_pointer_test.dart` per §U27). Rewrite each to use a working lifecycle (the script-wanted "is Element still active" check has no public Dart API per §U27; the right path is to ensure the script only calls `findRenderObject()` from contexts where the element is guaranteed-active — e.g. inside a `LayoutBuilder` callback or after `WidgetsBinding.instance.addPostFrameCallback`). Each newly-identified script becomes a future Arabic-numbered item appended to Phase A. Remove the catch from both interpreters once all scripts are clean.

### Phase B — Tests causing test_app to stop: each failure (and possibly its predecessor) must be fixed

Each of the 11 transport_clear_wedge errors observed in the 1944 sweep represents a test that took the app down (either via the failing test itself or — more often per the 2206 TODO #3 investigation — via the test that ran **before** it leaving framework state that wedged the next `/build` or `/clear`). The fix is to: (a) reproduce in isolation (the prior TODOs #2/#3/#4 already did this for several); (b) if it doesn't fail in isolation, find the predecessor culprit by binary search of the prior tests in the same file; (c) fix the predecessor (or the failing test if it fails in isolation). The `requestRecycle()` recovery mechanism is **diagnostic**, not a fix — it helps subsequent tests run but the underlying breakdown remains.

#### B.i — Deterministic per-script interpreter wedges (fail-in-isolation; the script itself is the bug)
- [ ] **B.1** `material/bottomappbar_test.dart` (TEST `important_classes_test`) — 2-sweep recurrence (2206 + 1944). Per 1944 TODO #4 PARTIAL, this script wedges in the very first build after setUpAll with `httpMs=25002`, `Building widget [...] (39 KB)` log present, build never completes. Bisect against bridge regenerations between commits where the script previously passed and where it now wedges. Fix the per-script interpreter cliff (the build pipeline starts but doesn't finish — likely a specific bridge call hangs deterministically for this script's widget shape).
- [ ] **B.2** `rendering/annotated_region_layer_test.dart` (AST `hardly_relevant_classes_3_test`) — 1-sweep regression. Same first-build wedge pattern as **B.1** (`httpMs=25003`, 516 KB bundle, app log confirms `Building widget` started). Investigate alongside **B.1**; likely same family.

#### B.ii — Position-dependent §U28 wedges (pass-in-isolation; predecessor is the real culprit)

For each: identify the test that ran **before** the failure and fix THAT one. The `requestRecycle()` recovery is NOT the fix — the underlying predecessor bug is what must be addressed.

- [ ] **B.3** `rendering/alignment_geometry_tween_test.dart` (AST + TEST `hardly_relevant_classes_3_test`, A1 + T3) — both projects in same sweep, strong wedge signal. 1944 TODO #2 confirmed pass-in-isolation. Binary-search the prior tests in `hardly_relevant_classes_3_test` to find the culprit. Fix the culprit's lifecycle cleanup (it leaves Flutter framework state — most plausibly `ImageCache` / `RouteObserver` / `Ticker` / `addPostFrameCallback` queue — that wedges the next `/build`).
- [ ] **B.4** `retest/rendering/render_animated_size_state_test.dart` (AST `timeout_tests_test` A3 + AST `gir` A4 + TEST `gir` T7) — 3 sites. 1944 TODO #3 confirmed pass-in-isolation. **A3** specifically wedged in the first build with §U25 cold-start signature on AST-bundle path (876 KB bundle, the largest in the rendering group) — fix the §U25 cold-start root cause (per §U25 "Real fix": interpreter perf work to pre-warm the d4rt parser / declaration visitor / Environment OR a test-app `/warmup` endpoint that pre-walks a dummy script during `setUpAll`). **A4 + T7** are /clear-after-25-tests cascades — find the predecessor (25th test in gir retest section) that wedges the next /clear; fix that predecessor's lifecycle cleanup.
- [ ] **B.5** `material/expansionpanel_test.dart` (TEST `important_classes_test`, T2) — 1944 TODO #4 confirmed pass-in-isolation. Find + fix the predecessor test in `important_classes_test`.
- [ ] **B.6** `widgets/reading_order_traversal_policy_test.dart` (TEST `hardly_relevant_classes_5_test`, T4) — 1944 TODO #4 confirmed pass-in-isolation. Find + fix predecessor in `hardly_relevant_classes_5_test`.
- [ ] **B.7** `widgets/render_object_to_widget_adapter_test.dart` (TEST `generator_interpreter_issues_test`, T5) — 1944 TODO #4 confirmed pass-in-isolation. Find + fix predecessor in TEST `gii`.
- [ ] **B.8** `retest: dart_ui/key_event_type_test.dart` (TEST `generator_interpreter_retest_test`, T6) — 1944 TODO #4 confirmed pass-in-isolation. Find + fix predecessor in TEST `gir`.

#### B.iii — Whole-file budget breaches (the test suite as a whole is too slow)
- [ ] **B.9** TEST `secondary_classes_test` — 1944 was KILLED at 2400 s with 132 / 656 tests not reached. The 1944 TODO #1 bumped the budget to 3000 s but that's masking the real bug: too many slow tests in the same file. Per Phase C, identify every >30 s test in `secondary_classes_test` and fix each; the file should then complete in well under the original 2400 s budget — and the budget can be brought back down (or removed entirely). **Closing C.3 also addresses this entry.**

### Phase C — Tests taking >30 s: each test with a 60 s / 120 s / 240 s timeout wrapper must be sped up to ≤ 30 s (ideally ≤ 10 s)

The 1944 codebase has **201 test entries** across the two projects carrying a `_slowTestTimeout = Timeout(Duration(seconds: 60))`, `_verySlowTestTimeout = Timeout(Duration(seconds: 120))`, inline `Timeout(Duration(seconds: 60))`, or `@Timeout(Duration(seconds: 240))` (library-level on TEST `interactive_tests_test`). Each is a workaround for a slow test, not a fix. The fix is to identify why the test is slow (cold-start parse, large bundle, many `/build` cycles, etc.) and reduce the work to fit ≤ 10 s.

The list below groups by host file. Each file gets one numbered TODO; closing the TODO requires removing every `>30s` timeout wrapper from that file and confirming the file's tests still pass within 30 s (ideally 10 s) each.

#### C.i — AST + TEST `essential_classes_test` (6 + 6 slow tests, all 60 s)
- [ ] **C.1** Affected scripts: `icons_test.dart` (2 sites), `route_test.dart` (3 sites), `theme_test.dart` (1 site). Fix the underlying slowness so each test runs ≤ 10 s. Remove all 6 `Timeout(60s)` wrappers in `essential_classes_test.dart` on both projects.

#### C.ii — AST + TEST `important_classes_test` (1 + 1 slow tests, all 60 s)
- [ ] **C.2** `bottomappbar_test.dart` (1 site each, line 67) — also tracked under **B.1** (deterministic wedge). Removing the timeout wrapper depends on the B.1 fix.

#### C.iii — AST `secondary_classes_test` (16 slow tests) + TEST same (15 slow tests, mostly identical)

Affected scripts (deduped): `data_table_theme_data_test.dart` (5 sites), `render_custom_multi_child_layout_box_test.dart` (2 sites), `render_fractionally_sized_overflow_box_test.dart`, `render_proxy_box_mixin_test.dart`, `font_loader_test.dart`, `undo_manager_test.dart` (AST only), `content_insertion_configuration_test.dart`, `page_scroll_physics_test.dart`, `raw_magnifier_test.dart`, `scrollable_test.dart`, `sliver_safe_area_test.dart`.
- [ ] **C.3** Fix each so it runs ≤ 10 s; remove the corresponding `Timeout(60s)` wrappers. **Closing this entry also addresses B.9** (secondary_classes whole-file budget breach).

#### C.iv — AST `hardly_relevant_classes_1_test` (5 slow tests) + TEST same (6 slow tests)

Scripts: `draggable_details_test.dart`, `extend_selection_to_next_word_boundary_intent_test.dart`, `overlay_portal_controller_test.dart` (AST only), `overscroll_indicator_notification_test.dart`, `inspector_button_test.dart` (TEST only), `overflow_bar_alignment_test.dart` (TEST only).
- [ ] **C.4** Fix each ≤ 10 s; remove wrappers.

#### C.v — AST + TEST `hardly_relevant_classes_2_test` (6 + 6 slow tests, all 60 s)

Scripts: `durations_test.dart`, `handle_thumb_shape_test.dart`, `popup_menu_position_test.dart`, `slider_interaction_test.dart`, `vertical_divider_test.dart`, `network_image_load_exception_test.dart`.
- [ ] **C.5** Fix each ≤ 10 s; remove wrappers.

#### C.vi — AST `hardly_relevant_classes_3_test` (7 slow tests) + TEST same (7 slow tests)

Scripts: `hit_test_behavior_test.dart`, `render_animated_size_state_test.dart` (related to **B.4**'s retest variant), `sliver_logical_container_parent_data_test.dart`, `android_pointer_properties_test.dart`, `key_up_event_test.dart`, `raw_key_event_data_fuchsia_test.dart`, `text_capitalization_test.dart` + TEST adds `raw_image_test.dart`, `regular_window_controller_win32_test.dart`.
- [ ] **C.6** Fix each ≤ 10 s; remove wrappers.

#### C.vii — AST `hardly_relevant_classes_4_test` (3 slow tests) + TEST same (3 slow tests, mostly distinct from C.iv)

AST scripts: `overlay_portal_controller_test.dart` (line 1528, also in **C.4**), `overscroll_indicator_notification_test.dart` (line 1572). TEST scripts: `inspector_button_test.dart`, `overflow_bar_alignment_test.dart` (both also in **C.4**).
- [ ] **C.7** Fix each ≤ 10 s; remove wrappers.

#### C.viii — AST `hardly_relevant_classes_5_test` (~14 slow tests) + TEST same (~16 slow tests)

AST scripts: `raw_keyboard_listener_test.dart`, `relative_rect_tween_test.dart`, `repeating_animation_builder_test.dart`, `restorable_listenable_test.dart`, `scroll_increment_type_test.dart`, `selectable_region_selection_status_scope_test.dart`, `selectable_region_state_test.dart`, `slotted_container_render_object_mixin_test.dart`, `transition_delegate_test.dart`, `tree_sliver_node_test.dart` (2 sites), `two_dimensional_scrollable_state_test.dart`, `unmanaged_restoration_scope_test.dart`, `web_browser_detection_test.dart`. TEST adds: `scroll_activity_delegate_test.dart`, `scroll_to_document_boundary_intent_test.dart`, `semantics_debugger_test.dart`, `static_selection_container_delegate_test.dart`, `two_dimensional_child_list_delegate_test.dart`, `user_scroll_notification_test.dart`, `widget_state_property_all_test.dart`.
- [ ] **C.8** Fix each ≤ 10 s; remove wrappers.

#### C.ix — AST `generator_interpreter_issues_test` (4 slow tests) + TEST same (7 slow tests)

AST scripts: `rendering/render_custom_multi_child_layout_box_test.dart` (2 sites), `widgets/animated_cross_fade_test.dart`, `widgets/html_element_view_test.dart`. TEST adds: `rendering/custom_painter_semantics_test.dart`, `widgets/overflow_box_test.dart`, `widgets/scrollbar_orientation_test.dart`.
- [ ] **C.9** Fix each ≤ 10 s; remove wrappers.

#### C.x — AST `generator_interpreter_retest_test` (11 slow tests) + TEST same (22 slow tests, including 4 `_verySlowTestTimeout = 120 s` sites)

AST retest scripts: `rendering/render_android_view_test.dart` (3 sites), `widgets/android_view_surface_test.dart` (2 sites), `widgets/default_selection_style_test.dart` (2 sites). TEST adds the long list from 2206 TODO #4 phase 2: `material/popup_menu_position`, `services/method_codec`, `widgets/back_button_listener` (60 s + 120 s sites), `widgets/default_text_editing_shortcuts`, `widgets/nested_scroll_view_state`, `widgets/object_key`, `widgets/raw_keyboard_listener`, `widgets/raw_radio`, `widgets/regular_window_controller_{delegate,mac_o_s,win32}`, `widgets/render_abstract_layout_builder_mixin`, `widgets/render_tap_region_surface`, `widgets/request_focus_action`. TEST also has 4 `_verySlowTestTimeout = 120 s` sites: `render_sliver_box_child_manager`, `app_kit_view` (also touched by **B.4** in the timeout_tests file), `box_scroll_view`, `live_text_input_status`.
- [ ] **C.10** Fix each ≤ 10 s; remove all `60 s` and `120 s` wrappers. The retest section's scripts are deliberately the "workarounds reverted" versions — many of these are slow because the workaround the original script applied was for a real perf issue. Some retests may need to be retired as duplicate coverage if the original `dart_ui/widgets/` script already covers the same API.

#### C.xi — AST + TEST `timeout_tests_test` (8 + 10 slow tests, all 60 s — including the `'app is running'` setUp sentinel test)

Scripts: `'app is running'` (setUp synthetic test), `render_custom_multi_child_layout_box_test.dart` (also in **C.9**), `retest/widgets/android_view_surface_test.dart` (also in **C.10**), `retest: services/message_codec_test.dart` (TEST only), `scrollbar_orientation_test.dart` (also in **C.9**), `sliver_animated_grid_test.dart`.
- [ ] **C.11** Fix each ≤ 10 s; remove wrappers.

#### C.xii — AST + TEST `interactive_tests_test` (6 + 6 slow tests, all **90 s**)

Each of the 6 interactive tests has a 90 s wrapper. These are the static-demo `showDialog`/`showBottomSheet`/`showMenu`/`showDatePicker`/`showTimePicker` + their dismiss tests. Per 2206 TODO #38, the AST builds finish in 1.8-2.5 s once §U28 self-resolved.
- [ ] **C.12** Bring each interactive test down to ≤ 30 s wall (ideally ≤ 10 s). The 90 s wrapper was for the `requestRecycle()` overhead — now that the recycle is removed from AST per 2206 TODO #38, the 90 s should be droppable to 30 s or less. Verify by individual retest; if still > 30 s, investigate why the interactive demo is slow.

#### C.xiii — TEST `interactive_tests_test` library-level `@Timeout(Duration(seconds: 240))`
- [ ] **C.13** The TEST `interactive_tests_test.dart` carries a library-level `@Timeout(Duration(seconds: 240))` (per 2206 TODO #6). This was added because `package:test` defaults `setUpAll` to 30 s, and the file's `SendTestRunner.setUp(timeout: 180s)` couldn't complete inside that wrapper. The real fix is to bring `SendTestRunner.setUp` itself down to ≤ 30 s so the library-level annotation can be reduced to the package default (30 s) or removed entirely.

### Goal-tracker

Once all entries in Phases A (A.1–A.8 plus any A.9, A.10, … spawned by A.3-A.7 enumeration work), B (B.1–B.9), and C (C.1–C.13) are closed:
- **All `ignoredPatterns` entries in both test_apps' `main.dart` removed** (or shrunk to demonstrable exception-only).
- **All 11 transport_clear_wedge errors from 1944 stopped recurring** (verified by next sweep).
- **All 201 `>30s` timeout wrappers removed**; each test runs ≤ 10 s wall.
- **`tool/sweep_both_projects.sh` budgets shrink** to the actual realistic worst cases (likely halving total sweep time from ~2 h to ~1 h).
- **Final invariant:** *"all tests passed within less than 30 seconds each and without test app breakdowns."*

---

**End of analysis.** The 1944 sweep snapshotted 4249 passing + 0 fail + 11 err + 0 framework-error log noise — but per the 2026-05-30 review, the apparent "0 framework errors" and "11 acceptable §U28-family flakes" both mask underlying bugs that have been worked around rather than fixed. The new TODO list above enumerates 8 Category A pattern-groups (items A.1–A.8; A.3-A.7 will spawn additional A.9, A.10, … items once the corresponding `ignoredPatterns` entries are removed and affected scripts are identified), 9 Category B test_app-stop sites (B.1–B.9), and 13 Category C file-groups covering 201 slow tests across both projects (C.1–C.13). Working through them one by one is what gets the test corpus to "all tests pass < 30 s each, no test_app breakdowns."
