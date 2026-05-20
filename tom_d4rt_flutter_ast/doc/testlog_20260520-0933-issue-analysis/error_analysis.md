# Error Analysis — tom_d4rt_flutter_ast

| Key | Value |
| --- | --- |
| Run ID | `20260520-0933-issue-analysis` |
| Project | `tom_d4rt_flutter_ast` |
| Git revision | `4f04990c` |
| Last commit | `fix(flutter_ast/test): wrap valuelistenablebuilder_test.dart page-root Column in SCV (item 138)` |
| Sweep window | 2026-05-20 09:34 → 11:03 (local) |
| Suites run | 14 (essential, important, secondary, hardly_relevant_1–5, crashing, timeout, blocking, gii, retest, interactive) |

## 1. Headline result

**All 14 suites passed.** Aggregate counts:

| Suite | Pass | Skip | Fail | Wall |
| --- | ---: | ---: | ---: | --- |
| `essential_classes_test` | 108 | 0 | 0 | 4m10s |
| `important_classes_test` | 164 | 0 | 0 | 6m27s |
| `secondary_classes_test` | 653 | 1 | 0 | 28m55s |
| `hardly_relevant_classes_1_test` | 203 | 2 | 0 | 10m38s |
| `hardly_relevant_classes_2_test` | 203 | 0 | 0 | 6m03s |
| `hardly_relevant_classes_3_test` | 201 | 0 | 0 | 7m17s |
| `hardly_relevant_classes_4_test` | 227 | 0 | 0 | 6m56s |
| `hardly_relevant_classes_5_test` | 230 | 0 | 0 | 7m25s |
| `crashing_tests_test` | 4 | 0 | 0 | 0m19s |
| `timeout_tests_test` | 51 | 0 | 0 | 1m54s |
| `blocking_tests_test` | 5 | 0 | 0 | 0m43s |
| `generator_interpreter_issues_test` | 81 | 2 | 0 | 3m08s |
| `generator_interpreter_retest_test` | 53 | 5 | 0 | 2m08s |
| `interactive_tests_test` | 6 | 0 | 0 | 0m39s |
| **TOTAL** | **2189** | **10** | **0** | **86m22s** |

No test failures. Four scripts emitted non-fatal framework-error banners (all four are known-deferred items U14 / U15 / U17 / U18 in `doc/interpreter_unfixable.md`); two of those four scripts also produce visible overflow log lines.

## 2. Cluster A — Test failures

**Status: NONE (CLEAN).** Zero test failures across all 14 suites. Every `testDone` event in the 14 JSON reports resolves to `result=success` or `skipped=true`. No `Some tests failed.` line anywhere.

## 3. Cluster B — Non-fatal framework errors (in-log)

**Status: 4 distinct scripts emit banners, all known-deferred — no new issues.**

Every banner below is documented in `doc/interpreter_unfixable.md` and was already evaluated during the cluster A–I fix sweep (`doc/testlog_20260519-1247-flutter-suites-fixes/framework_error_fix_plan.md`); the host test still records `frameworkErrors=N` in its METRIC line but the runner reports `status=success` and the suite's `expectSuccess(...)` does not fail on a non-zero `frameworkErrors` (it only fails on `status != success`). No regression vs. the 2026-05-19 baseline — this is the steady-state floor.

| # | Script | Host suite | Errors | Symptom | Reference |
| - | --- | --- | ---: | --- | --- |
| 1 | `animation/cubic_test.dart` | `hardly_relevant_classes_1_test` | 1 | `BoxConstraints forces an infinite height.` (synthetic `RenderConstrainedBox` inside a Material widget the script does not own) | `interpreter_unfixable.md` **U14** ; `framework_error_fix_plan.md` item 1 (deferred) |
| 2 | `services/platform_test.dart` | `important_classes_test` | 1 | `BoxConstraints forces an infinite height.` (`_defaultVsThemeCard` Row with `stretch` + Expanded; every script-side P1 variant crashes the test app with transport_error) | `interpreter_unfixable.md` **U18** ; `framework_error_fix_plan.md` item 93 (deferred) |
| 3 | `cupertino/cupertino_nav_segmented_test.dart` | `secondary_classes_test` | 2 | `A RenderFlex overflowed by 2.0 pixels on the right.` × 2 (fires on internal Rows synthesised by bridged Cupertino widgets the script does not own) | `interpreter_unfixable.md` **U15** ; `framework_error_fix_plan.md` item 2 (deferred) |
| 4 | `rendering/render_constraints_transform_box_test.dart` | `secondary_classes_test` **and** `timeout_tests_test` | 1 (per host) | `BoxConstraints(699.6<=w<=349.8, h=182.0; NOT NORMALIZED) is not normalized` at `shifted_box.dart:943` (`kHalveMaxWidth` halves `maxWidth` under tight parent width; P8 fix unmasks 4 deliberate oversized-child overflows in sections 4/7/8) | `interpreter_unfixable.md` **U17** ; `framework_error_fix_plan.md` item 71 (reverted/deferred) |

Total framework-error banners across the 14 AST suites = **5** (= 1 + 1 + 2 + 1, item 4 counted once even though it appears in two host suites because it is the same script run twice).

## 4. Cluster C — Overflow log lines without a separate framework banner

**Status: NONE (CLEAN).** The 2 overflow log lines in `secondary_classes_test.log.txt` are the two `A RenderFlex overflowed by 2.0 pixels on the right.` banners from item 3 above (`cupertino_nav_segmented_test.dart`), already accounted for in Cluster B. No additional overflow lines are present anywhere else (`grep -c 'overflowed by' *.log.txt` returns 0 for every other suite).

## 5. Cluster D — Skipped tests

**Status: 10 skips, all with documented rationale — no investigation needed.**

| # | Suite | Test name | Skip rationale (verbatim from skip:) |
| - | --- | --- | --- |
| 1 | `generator_interpreter_issues_test` | `widgets/android_view_test.dart` | `!Platform.isAndroid ? 'AndroidView only renders on Android' : null` |
| 2 | `generator_interpreter_issues_test` | `widgets/animated_switcher_test.dart` | `W5 (2026-04-28): wedges test app /build for ~60s then "Lost connection to device"; cascades 34 subsequent gii tests. … Likely deep-demo widget tree leaving animation tickers / post-frame callbacks scheduled past teardown.` |
| 3 | `generator_interpreter_retest_test` | `retest: dart_ui/system_color_palette_test.dart` | `Platform.isLinux ? 'SystemColor not supported on Linux' : null` |
| 4 | `generator_interpreter_retest_test` | `retest: widgets/context_action_test.dart` | `W1: script passes in isolation but wedges app /clear afterward, causing cascade of timeouts in the rest of the run.` |
| 5 | `generator_interpreter_retest_test` | `retest: widgets/default_text_editing_shortcuts_test.dart` | `W2: /build hangs 30s, wedges app /clear afterward. Cascades into the rest of the run.` |
| 6 | `generator_interpreter_retest_test` | `retest: widgets/live_text_input_status_test.dart` | `W3: cascade victim of W2 in retest runs. Re-evaluate once W2 is fixed.` |
| 7 | `generator_interpreter_retest_test` | `retest: widgets/lock_state_test.dart` | `W4 (2026-04-28): wedges test app /build with "HttpException: Connection closed before full header was received", then test app process dies and cascades 19 subsequent retests with SocketException: Connection refused.` |
| 8 | `hardly_relevant_classes_1_test` | `dart_ui/image_sampler_slot_test.dart` | `D1 — destabilises the test app for subsequent dart_ui/gestures scripts on Linux. Run via bisect_test.dart instead.` |
| 9 | `hardly_relevant_classes_1_test` | `dart_ui/isolate_name_server_test.dart` | `IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)` |
| 10 | `secondary_classes_test` | `widgets/android_view_test.dart` | `!Platform.isAndroid ? 'AndroidView only renders on Android' : null` |

Skip categories:

- **Platform gating** (Android-only, non-Linux SystemColor): #1, #3, #10 — correct platform-specific behaviour; no action.
- **Interpreter / runtime limitation** (no real isolate infra): #9 — documented limitation, no action.
- **Test-app stability wedges** (W1–W5, D1): #2, #4, #5, #6, #7, #8 — six items pinned to test-app teardown / `/build` / `/clear` wedging. These are tracked in `doc/interpreter_issues.md` under the W1–W5 / D1 labels and re-checked whenever the upstream wedger (W2 / dart_ui teardown ordering) changes.

## 6. Cluster summary

| Cluster | Topic | Status | Action needed |
| --- | --- | --- | --- |
| A | Test failures | **FIXED** (no failures) | none |
| B | Non-fatal framework banners (4 scripts) | **REVERTED / DEFERRED** (all match U14/U15/U17/U18 already documented) | none — every banner is the known steady-state floor; reopening requires a design-level rewrite or excluding the host script from the `frameworkErrors=0` gate, both out-of-scope for the per-item sweep |
| C | Overflow lines without separate banner | **FIXED** (no additional overflow lines) | none |
| D | Skipped tests (10 total) | **DEFERRED** (all documented) | none — W1/W2/W3/W4/W5/D1 are tracked in `interpreter_issues.md`; platform gates are intentional |

## 7. Evidence & artefacts

- Per-suite JSON: `*.result.json` (14 files)
- Per-suite log: `*.log.txt` (14 files, captures both stdout and stderr)
- Metric lines: emitted as `[METRIC] script=… sourceChars=… status=… frameworkErrors=…` in each log; the `frameworkErrors` field is the canonical signal for Cluster B.
- Framework-banner extraction: `grep -B1 -A5 'frameworkErrors=[1-9]' *.log.txt` (5 banners total across 4 distinct scripts).
- Overflow log scan: `grep -c 'overflowed by' *.log.txt` (0 lines outside the cupertino banners).
- Skip extraction: from JSON `testDone events with "skipped":true`.

## 8. Conclusion

Steady-state floor confirmed at:

- 2189 tests passing across 14 suites
- 10 skipped tests (all platform-gated or known-wedging — no new candidates)
- 0 test failures
- 4 distinct scripts emitting 5 non-fatal framework-error banners — every one a documented unfixable (U14, U15, U17, U18)
- 0 additional overflow log lines

No regressions vs. the 2026-05-19 `testlog_20260519-1247-flutter-suites-fixes` baseline. No new fixes required. The post-Cluster-I floor is the current expected state.
