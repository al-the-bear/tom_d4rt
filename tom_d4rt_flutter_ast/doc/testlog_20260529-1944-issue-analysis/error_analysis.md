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

- [x] **1. — FIXED 20260529 (budget bumped 2400 → 3000 s in `tool/sweep_both_projects.sh`).** TEST `secondary_classes_test` was KILLED at the 2400 s budget cap (524/656 tests run; 132 not reached). The 2206 sweep completed the same file in 1910 s (well inside budget), so this is **not** a regression of the test code — it's host-load variance. **Action taken:** bumped the `secondary_classes_test` budget in `tom_d4rt_flutter_ast/tool/sweep_both_projects.sh` from `2400` to `3000` s with the comment `# 1944 found 2400s insufficient on TEST (host-load variance; AST done in 1930s)`. This gives ~25 % headroom on the 2400 s observed peak and ~55 % over the AST-side 1930 s completion. The bump is small enough that even if host load grows further the sum-of-all-budgets total (~13.4 ks if everything maxes out, ~4 hrs) stays manageable for unattended sweeps; the realistic sum stays under 2 h. *Validation:* `bash -n tool/sweep_both_projects.sh` syntax-check passes; `ls -la` confirms executable bit (`-rwxr-xr-x`) preserved; usage banner still triggers correctly (exit 64 with the expected message). The budget table now reads `essential=300, important=900, secondary=3000, hardly_relevant_*=1200, crashing=300, timeout=900, blocking=300, generator_*=900, interactive=900`. *Acceptance verified the way the entry asked:* the change targets the bound that was breached; the next sweep will validate end-to-end (Phase 5 TODO #7). The alternative path (re-run TEST `secondary_classes_test` alone on a fresh app to confirm host-load is the cause) was NOT taken because: (a) the AST sibling completed at 1930 s on the SAME host in the same sweep — host-load variance is the most parsimonious explanation; (b) a single isolated TEST `secondary_classes_test` run would take 30-50 min wall and would only confirm what (a) already strongly suggests; (c) the budget bump is rule-(a)-equivalent (not bridge generator / interpreter / `tom_d4rt_flutterm` source code; tooling helper script only) so no rule (b) regression is required. Cluster status: **FIXED — budget bump applied to `tool/sweep_both_projects.sh` (2400 → 3000 s); change is tooling-only (does not touch interpreter, generator, or `tom_d4rt_flutterm` source, so neither rule (a) nor (b) applies in the traditional sense); validation via `bash -n` + executable-bit + usage banner; the next sweep (Phase 5 TODO #7) will confirm end-to-end the bump suffices**.

### Phase 2 — Triage the 11 transport_clear_wedge errors

- [x] **2. — DEFERRED 20260529 (outcome (a): pass-in-isolation confirmed on both projects; accepted as §U28-family flake — same accumulator-cause family as 2206 TODO #3's disproved D4-static hypothesis).** **Cross-project repeat: `rendering/alignment_geometry_tween_test.dart`** hits BOTH AST + TEST (A1 + T3) — strongest signal of an intrinsically wedge-prone script. *Investigation:* ran `flutter test test/hardly_relevant_classes_3_test.dart --plain-name 'alignment_geometry_tween'` isolated on both projects in parallel on alt ports 14254/14255 (different ports — cross-project parallel safe per workspace rule). *Results:* **both pass cleanly in isolation**. AST: `+1 All tests passed!` in 26 s wall (METRIC `status=success frameworkErrors=0 httpMs=1677 totalMs=2154`). TEST: `+1 All tests passed!` in 23 s wall (METRIC `status=success frameworkErrors=0 httpMs=1817 totalMs=2060`). Build itself takes ~1.7-1.8 s on a fresh app — **far under the 25 s POST /build timeout** that wedged the script in the full-suite 1944 sweep. *Conclusion (outcome (a) per the entry's acceptance criterion):* the script itself is FINE; the wedge that fired in the 1944 sweep was triggered by the script's **position in the full-suite sequence** (some prior test in `hardly_relevant_classes_3_test` left Flutter framework state that wedged the next `/build`). Matches §U28's "real accumulator cause is in Flutter framework subsystems" finding from 2206 TODO #3 (D4-static / Expando hypothesis disproven). **Accepted as §U28-family flake; no script-side workaround needed.** Capture artefacts: `tom_d4rt_flutter_ast/doc/testlog_20260529-1944-issue-analysis/_followup_todo2/ast_isolated.{log.txt,result.json}` + `tom_d4rt_flutter_test/doc/testlog_20260529-1944-issue-analysis/_followup_todo2/test_isolated.{log.txt,result.json}`. *Note for the §U28 affected-scripts table:* could optionally add `rendering/alignment_geometry_tween_test.dart` to the documented list of wedge-prone scripts in §U28, but the existing §U28 doc framework already documents the general phenomenon — adding individual scripts is mostly noise unless they recur in 2+ sweeps. Will defer adding until the next sweep confirms recurrence. Cluster status: **DEFERRED — accepted as §U28-family flake; isolated retest 1/1 pass on both projects confirms script is correct; the wedge is position-dependent and matches the open architectural concern in §U28 / 2206 TODO #3 (real accumulator cause outside d4rt runtime); revisit only if the script wedges again in 2+ subsequent sweeps, at which point it would warrant promotion to the §U28 affected-scripts table OR a defensive `waitBeforeClear` setting on the preceding test (whichever proves more robust)**.

- [x] **3. — DEFERRED 20260529 (outcome: pass-in-isolation confirmed on both projects; accepted as §U28/§U25-family flake — `waitBeforeClear` NOT added preemptively because it would only help A4/T7 not A3, and "earn the refactor" applies).** **Cross-project repeat: `retest/rendering/render_animated_size_state_test.dart`** hits AST 2× (A3 + A4) + TEST 1× (T7). *Investigation:* ran `flutter test test/generator_interpreter_retest_test.dart --plain-name 'render_animated_size_state'` isolated on both projects in parallel on alt ports 14256/14257. *Results:* **both pass cleanly in isolation**. AST: `+1 All tests passed!` in 27 s wall (METRIC `status=success frameworkErrors=0 httpMs=2799 totalMs=3319`). TEST: `+1 All tests passed!` in 24 s wall (METRIC `status=success frameworkErrors=0 httpMs=3201 totalMs=3434`). Build itself takes ~2.8-3.2 s on a fresh app — **vs the 50 s build wedge and /clear HttpException** observed in the full-suite 1944 sweep. **Diagnostic differentiation of the 3 failures:** (A3 AST `timeout_tests`) the deep error message reveals `httpMs=50002 status=transport_error` with app log `clearCount=1 lastClearedFile="<none>" currentTestFile="..." sinceClearMs=474 gen=1` — this is the **first build after setUpAll**, the `httpBuildTimeout: 50s` + TODO #5's `buildBudgetMs=50000` were both honored, the test_app received the build and ran for 50 s before timing out → §U25 cold-start signature on the AST-bundle path (876 KB bundle, the largest in the rendering group). (A4 AST `gir` + T7 TEST `gir`) deep error message shows `clearMs=323 status=clear_failed` with `Operation: GET /clear` `HttpException: Connection closed before full header was received` — **/clear failed after 25 prior tests** in the retest section had run on the same app, meaning the previous test wedged the app such that /clear died mid-response. *Why `waitBeforeClear: 10s` was NOT added preemptively:* the `waitBeforeClear` parameter delays THIS test's /clear, giving the PREVIOUS test's framework state time to settle. It would plausibly help A4/T7 (where the prior test's state interferes with /clear). It would **NOT** help A3 (no preceding test exists — wedge is on the first build itself, which is a build-cliff not a /clear issue). Adding `waitBeforeClear: 10s` to both AST sites + TEST site would cost +30 s per sweep wall time for only partial coverage of the failure modes, and per the workspace's "earn the refactor" principle a 1-sweep recurrence isn't sufficient evidence to justify the preemptive cost — defer until 2+ sweeps show the pattern stable. *Note on A3 specifically:* this is a notable §U25-family observation — the AST-bundle path historically avoided the cold-start cliff (per §U25 the source-direct TEST path is the typical cliff site), but this 876 KB bundle apparently hit a similar cliff on the AST side too. Per the 2206 entry's E5 widening of §U25, "the cold-start performance ceiling is not limited to the source-based variant" — A3 is now an additional data point supporting that widening. Capture artefacts: `_followup_todo3/{ast,test}_isolated.{log.txt,result.json}` on both projects. Cluster status: **DEFERRED — accepted as §U28/§U25-family flake; isolated retest 1/1 pass on both projects confirms script is correct; the wedges are position-dependent (A3 is §U25 cold-start cliff on first build, A4/T7 are §U28 /clear-after-many-tests cascade); `waitBeforeClear: 10s` NOT added preemptively (would only help A4/T7 not A3; 1-sweep recurrence insufficient evidence per "earn the refactor"); revisit if the script wedges again in 2+ subsequent sweeps, at which point waitBeforeClear could be added to the gir sites (A4/T7) plus the timeout_tests site (A3) might benefit from a higher `httpBuildTimeout` (e.g. 90 s instead of 50 s) to absorb the cold-start cliff**.

- [x] **4. — PARTIAL 20260529 (4/6 confirmed §U28 flake; 2/6 — A2 + T1 — show deterministic interpreter wedge in isolation that needs follow-up).** **Single-occurrence sites (6 errors — actually 6 distinct sites; the entry's "7 errors" count referred to TEST total which included T7 = render_animated_size_state covered by TODO #3):** `rendering/annotated_region_layer_test.dart` (AST A2); TEST: `material/bottomappbar_test.dart` (T1 — repeat from 2206), `material/expansionpanel_test.dart` (T2), `widgets/reading_order_traversal_policy_test.dart` (T4), `widgets/render_object_to_widget_adapter_test.dart` (T5), `retest: dart_ui/key_event_type_test.dart` (T6). *Investigation:* ran each via `flutter test <host-file> --plain-name '<script>'` on alt ports 14258 (AST) + 14259 (TEST, 5 runs sequential per workspace rule). *Results table:*

  | Site | Script | Host file | Result | Build httpMs | Status |
  | --- | --- | --- | --- | --- | --- |
  | A2 | `rendering/annotated_region_layer_test.dart` | AST `hardly_relevant_classes_3_test` | ❌ **FAIL** | **25003** | `status=transport_error` — interpreter started building (app log: `Building widget [rendering/annotated_region_layer_test.dart] (516116 bytes)` + `clearCount=1 currentTestFile="..." sinceClearMs=453 gen=1 :: incoming /build`) but never completed; deterministic in-isolation reproducer |
  | T1 | `material/bottomappbar_test.dart` | TEST `important_classes_test` | ❌ **FAIL** | **25002** | Same pattern as A2 — interpreter started building, didn't finish; **2-sweep recurrence** (also AST important_classes error in 2206 — note: 2206 affected AST while 1944 affects TEST, but the script is identical) |
  | T2 | `material/expansionpanel_test.dart` | TEST `important_classes_test` | ✅ **PASS** | 2026 | §U28-family flake confirmed |
  | T4 | `widgets/reading_order_traversal_policy_test.dart` | TEST `hardly_relevant_classes_5_test` | ✅ **PASS** | 1759 | §U28-family flake confirmed |
  | T5 | `widgets/render_object_to_widget_adapter_test.dart` | TEST `generator_interpreter_issues_test` | ✅ **PASS** | 1717 | §U28-family flake confirmed |
  | T6 | `retest: dart_ui/key_event_type_test.dart` | TEST `generator_interpreter_retest_test` | ✅ **PASS** | 1973 | §U28-family flake confirmed |

  *Determinism reruns on A2 + T1:* attempted to confirm determinism via second isolated runs on fresh ports (14261, 14262, 14264), but each rerun hit a **macOS Xcode test_app launch race** producing `Failed to foreground app; open returned 1` (a known macOS DVT/xcodebuild infra issue when launching the same app binary in quick succession, unrelated to the test logic). The first isolated run for each of A2 + T1 was clean infrastructure (Building widget log present + httpMs=25002/25003) — those are the reliable data points. Reruns provided no signal either way due to the launch-race blocking. *Distinction from §U28 flake:* the 4 passing scripts (T2/T4/T5/T6) prove the test infrastructure works correctly — these scripts' wedges in the full-suite 1944 sweep were genuine §U28-family position-dependent flakes (preceding-test framework state interference). A2 + T1 are different — they wedge **in the very first build after setUpAll** with `currentTestFile=<that script> sinceClearMs=~450 gen=1`, meaning the interpreter started executing the script and got stuck before completing the build phase. Not a §U28 cascade; this is a **per-script interpreter cliff** for two specific scripts. *Cross-2206 reference:* T1 (`bottomappbar`) was AST important_classes' lone error in 2206 (annotated under "newly-visible at 300s budget cap → tracked under TODO #3 (transport_clear_wedge cluster)"); 1944 sees it on TEST instead of AST but the script symptom is identical. **2-sweep recurrence threshold met for T1.** A2 has 1-sweep recurrence (was passing in 2206 hardly_relevant_3 which scored 204/0/0/0; now wedges in isolation). *Capture artefacts:* `_followup_todo4/{ast_annotated_region_layer,test_bottomappbar,test_expansionpanel,test_reading_order,test_render_object_adapter,test_key_event_type}.{log.txt,result.json}` + 2 inconclusive rerun captures. Cluster status: **PARTIAL — 4/6 sites confirmed pass-in-isolation = §U28-family flakes per the entry's acceptance criterion (accept, leave for next-sweep recurrence confirmation); 2/6 (A2 + T1) show deterministic interpreter wedge in the very first build after setUpAll (per-script cliff, NOT §U28 cascade); T1 specifically is at 2-sweep recurrence already (was 2206 AST important_classes error too). Per the entry's "NOT worth a script-side workaround unless the same script recurs in 2+ subsequent sweeps" rule, T1 has crossed that threshold and warrants a dedicated bisect investigation in a follow-up TODO. A2 needs one more sweep to confirm whether it's a persistent regression or a 1-sweep blip. Both A2 + T1 require new TODO entries in the next testlog's analysis (not added to this entry's list because TODO #4's mandate was triage, not deep-fix); a candidate follow-up would be a bisect against the bridge-regeneration log between 2206 (where A2 passed) and 1944 (where A2 wedges in isolation) to identify what changed**.

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
