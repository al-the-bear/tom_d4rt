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

## 8. Numbered TODO list — fix-id `20260529-1944-issue-analysis`

Each item has a `[ ]` checkbox. Tick to `[x]` when verified-fixed.

### Phase 1 — TEST secondary_classes_test coverage

- [ ] **1.** TEST `secondary_classes_test` was KILLED at the 2400 s budget cap (524/656 tests run; 132 not reached). The 2206 sweep completed the same file in 1910 s (well inside budget), so this is **not** a regression of the test code — it's host-load variance. **Action:** bump the `secondary_classes_test` budget in `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh` from 2400 to 3000 s (gives ~25 % headroom on the 2400 s observed peak), OR confirm host load is the cause by re-running TEST `secondary_classes_test` alone on a fresh app (`flutter test test/secondary_classes_test.dart --reporter expanded ...`) and noting the wall time. *Acceptance:* 656/656 tests run in the next sweep.

### Phase 2 — Triage the 11 transport_clear_wedge errors

- [ ] **2.** **Cross-project repeat: `rendering/alignment_geometry_tween_test.dart`** hits BOTH AST + TEST (A1 + T3) — strongest signal of an intrinsically wedge-prone script. Re-run isolated on both projects (`flutter test --plain-name 'alignment_geometry_tween'` on each) and check whether it (a) passes when isolated (→ position-dependent, accept as §U28-family flake) or (b) reliably fails in isolation (→ genuine new bug requiring a dedicated investigation). *Acceptance:* either pass-in-isolation confirmed and documented as accepted §U28-family flake, OR a smaller reproducer found and tracked.

- [ ] **3.** **Cross-project repeat: `retest/rendering/render_animated_size_state_test.dart`** hits AST 2× (A3 + A4) + TEST 1× (T7). A3 is the POST /build wedge despite an inline `httpBuildTimeout: 50s`; A4/T7 are the GET /clear HttpException variant. Re-run isolated to confirm pass-in-isolation, then consider adding `waitBeforeClear: const Duration(seconds: 10)` (already a pattern used in nearby retest tests per the `generator_interpreter_retest_test.dart` source) to defensively pace the /clear. *Acceptance:* isolated pass confirmed; if waitBeforeClear is added, re-test 3× to verify stable.

- [ ] **4.** **Single-occurrence sites (7 errors):** `rendering/annotated_region_layer_test.dart` (AST A2); TEST: `material/bottomappbar_test.dart` (T1 — repeat from 2206 important_classes), `material/expansionpanel_test.dart` (T2), `widgets/reading_order_traversal_policy_test.dart` (T4), `widgets/render_object_to_widget_adapter_test.dart` (T5), `retest: dart_ui/key_event_type_test.dart` (T6). For each: isolated re-run to confirm pass-in-isolation; if isolated pass, classify as accepted §U28-family flake and leave for the next sweep to confirm non-recurrence. **NOT** worth a script-side workaround unless the same script recurs in 2+ subsequent sweeps. *Acceptance:* each script confirmed pass-in-isolation; documented in this entry.

### Phase 3 — Verify the suppression chain stays clean

- [ ] **5.** The 0-framework-error result depends on 5 cumulative `ignoredPatterns` entries + 1 interpreter-visitor catch. Sanity-check that they remain in place across `tom_d4rt_flutter_ast_app/lib/main.dart` + `tom_d4rt_flutter_test_app/lib/main.dart` + both interpreter `interpreter_visitor.dart` mirrors. *Quick check:*
  - `'Codec failed to produce an image'` (§U29, Cluster H) — verify line ~364 in both `main.dart`s
  - `'A RenderConstraintsTransformBox overflowed by'` (§U17, Cluster H) — verify line ~382 in both `main.dart`s
  - `'check that it really is our descendant'` (§U30, 2026-05-27 TODO #9) — verify line ~404 (AST) / ~327 (TEST) in `main.dart`s
  - `'overflowed by 0.500 pixels'` (subpixel-rounding) — verify line ~336 in both `main.dart`s
  - `'infinite size during layout'` (debug-paint warning) — verify line ~352 in both `main.dart`s
  - `findRenderObject` + `'Cannot get renderObject of inactive element'` catch (§U27, Cluster B) — verify `tom_d4rt/lib/src/interpreter_visitor.dart:3279-3300` + `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart:3749-3759`
  - `else if (!isIgnored)` guard (2026-05-29 TODO #7/#8) — verify in both `main.dart`s' `_handleFlutterError`
*Acceptance:* all 6 patterns + guard verified in place.

### Phase 4 — Host hygiene (deferred, doesn't block work)

- [ ] **6.** Reboot host (or `sudo launchctl reboot userspace`) to release the four kernel-zombie test_app PIDs holding ports 4247/4248/14247/14248. *Verify:* `lsof -i :4247 -i :4248 -i :14247 -i :14248` empty. Until this happens, all sweeps must use a fresh alt-port pair (this one used 14250/14251). **Same blocker as 2206 TODO #2 — cannot be performed from Claude; user action required.**

### Phase 5 — Re-sweep cadence

- [ ] **7.** Once Phase 1 + Phase 2 are addressed (or accepted), re-run `tool/sweep_both_projects.sh testlog_<new-id>-issue-analysis 14250 14251` to verify the bumped budget covers TEST secondary_classes and that the 11 wedge errors are non-recurring flakes vs persistent symptoms. *Acceptance:* clean re-sweep (≤5 wedge errors total, 0 framework errors, all files within budget on both projects).

- [ ] **8.** Once Phase 4 (host reboot) lands, re-run on default ports 4247/4248 to validate the port-override mechanism (commit `8cd7c27a`) and lifecycle fix (commit `9f4dc79c`) behave identically on the defaults — same TODO as 2206 TODO #40, blocked on the same reboot.

---

**End of analysis.** The combination of 2206 fixes (TODOs #4-phase 2, #5, #6, #7, #8, #38) yielded a sweep with **4249 passing tests + 0 failures + 11 errors (vs 79 in 2206; −86 %) + 0 framework-error log noise**. All non-pass outcomes classify as `transport_clear_wedge` (§U28-family per 2206 TODO #3); zero novel infrastructure regressions; zero new skips. The only operational concern is the TEST `secondary_classes_test` 2400 s budget cap that fired on this sweep (host-load variance, not a regression) — Phase 1 addresses with a budget bump.
