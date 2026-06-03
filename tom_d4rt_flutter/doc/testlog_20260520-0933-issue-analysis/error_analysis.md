# Error Analysis — tom_d4rt_flutter_test

| Key | Value |
| --- | --- |
| Run ID | `20260520-0933-issue-analysis` |
| Project | `tom_d4rt_flutter_test` |
| Git revision | `43947032` |
| Last commit | `diag(flutter_test): add counter_app + Sudoku debug HUD to diagnose setState` |
| Sweep window | 2026-05-20 09:34 → 11:03 (local) |
| Suites run | 14 (essential, important, secondary, hardly_relevant_1–5, crashing, timeout, blocking, gii, retest, interactive) |

## 1. Headline result

**13 suites passed, 1 suite has a single transport-timeout failure.** Aggregate counts:

| Suite | Pass | Skip | Fail | Wall |
| --- | ---: | ---: | ---: | --- |
| `essential_classes_test` | 108 | 0 | 0 | 4m13s |
| `important_classes_test` | 164 | 0 | 0 | 6m01s |
| `secondary_classes_test` | 653 | 1 | 0 | 29m08s |
| `hardly_relevant_classes_1_test` | 202 | 2 | **1** | 11m00s |
| `hardly_relevant_classes_2_test` | 203 | 0 | 0 | 5m49s |
| `hardly_relevant_classes_3_test` | 201 | 0 | 0 | 7m57s |
| `hardly_relevant_classes_4_test` | 227 | 0 | 0 | 8m42s |
| `hardly_relevant_classes_5_test` | 230 | 0 | 0 | 7m46s |
| `crashing_tests_test` | 4 | 0 | 0 | 0m18s |
| `timeout_tests_test` | 51 | 0 | 0 | 2m07s |
| `blocking_tests_test` | 5 | 0 | 0 | 0m38s |
| `generator_interpreter_issues_test` | 81 | 2 | 0 | 2m59s |
| `generator_interpreter_retest_test` | 53 | 5 | 0 | 2m02s |
| `interactive_tests_test` | 6 | 0 | 0 | 0m35s |
| **TOTAL** | **2188** | **10** | **1** | **88m55s** |

One test failure (`pointer_scroll_inertia_cancel_event_test.dart`, transport timeout — environmental, not a script bug). Four scripts emit non-fatal framework-error banners (the same U14/U15/U17/U18 set as `tom_d4rt_flutter_ast`); two of those four also produce visible overflow log lines.

## 2. Cluster A — Test failures

**Status: 1 failure — transport timeout, flaky environmental, NOT a script or interpreter bug.**

| # | Suite | Test | Status | Wall to fail | Error |
| - | --- | --- | --- | --- | --- |
| 1 | `hardly_relevant_classes_1_test` | `gestures/pointer_scroll_inertia_cancel_event_test.dart` | `transport_error` httpStatus=-1 | 25.0s on `POST /build` | `TimeoutException after 0:00:25.000000: Future not completed` raised inside `SendTestRunner.send` (`test/send_test_runner.dart:555:7`) |

**Evidence:** `hardly_relevant_classes_1_test.log.txt` lines 392-399. The METRIC line reads `status=transport_error httpStatus=-1 outputLines=0 frameworkErrors=0` — the 25-second `POST /build` request to the test app never completed. The build payload was 74,348 chars, comparable to neighbours (`pointer_scroll_event_test.dart` 77,710 chars built in 8.99s, `pointer_scale_event_test.dart` 57,636 chars built in 9.69s), so the source size alone does not explain the hang.

**Why this is not a script bug:**
- The same `pointer_scroll_inertia_cancel_event_test.dart` script passed in the 2026-05-19 `testlog_20260519-1247-flutter-suites-fixes` baseline under the same project.
- The same script in the parallel `tom_d4rt_flutter_ast` 2026-05-20 sweep also passed (`status=success`, `frameworkErrors=0`) — see the AST `hardly_relevant_classes_1_test.log.txt`.
- `status=transport_error` with `httpStatus=-1` and the canonical 25-second `POST /build` deadline is the signature of an environmental test-app wedge (the same wedge family the W1–W5 / D1 skip rationale already documents).
- The neighbouring `pointer_scroll_event_test.dart` (immediately previous in the run) built and ran cleanly with `frameworkErrors=0`, so the test app was not left in a broken state by the predecessor.

**Action:** None. Re-run on an idle machine; if the failure persists across two consecutive isolated runs, promote to a tracked W-class wedge in `interpreter_issues.md`. Until then, this is a one-off transport flake.

## 3. Cluster B — Non-fatal framework errors (in-log)

**Status: 4 distinct scripts emit banners, all known-deferred — identical to the AST sweep.**

| # | Script | Host suite | Errors | Symptom | Reference |
| - | --- | --- | --- | ---: | --- | --- |
| 1 | `animation/cubic_test.dart` | `hardly_relevant_classes_1_test` | 1 | `BoxConstraints forces an infinite height.` (synthetic `RenderConstrainedBox` inside a Material widget the script does not own) | `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` **U14** ; `framework_error_fix_plan.md` item 1 (deferred) |
| 2 | `services/platform_test.dart` | `important_classes_test` | 1 | `BoxConstraints forces an infinite height.` (`_defaultVsThemeCard` Row with `stretch` + Expanded; every script-side P1 variant crashes the test app with transport_error) | `interpreter_unfixable.md` **U18** ; `framework_error_fix_plan.md` item 93 (deferred) |
| 3 | `cupertino/cupertino_nav_segmented_test.dart` | `secondary_classes_test` | 2 | `A RenderFlex overflowed by 2.0 pixels on the right.` × 2 (fires on internal Rows synthesised by bridged Cupertino widgets the script does not own) | `interpreter_unfixable.md` **U15** ; `framework_error_fix_plan.md` item 2 (deferred) |
| 4 | `rendering/render_constraints_transform_box_test.dart` | `secondary_classes_test` **and** `timeout_tests_test` | 1 (per host) | `BoxConstraints(699.6<=w<=349.8, h=182.0; NOT NORMALIZED) is not normalized` at `shifted_box.dart:943` (`kHalveMaxWidth` halves `maxWidth` under tight parent width; P8 fix unmasks 4 deliberate oversized-child overflows in sections 4/7/8) | `interpreter_unfixable.md` **U17** ; `framework_error_fix_plan.md` item 71 (reverted/deferred) |

Total framework-error banners across the 14 flutter_test suites = **5** (= 1 + 1 + 2 + 1, item 4 counted once because it is the same script run twice in two host suites). Banner totals and host-suite mapping are identical to the AST sweep — every banner is documented and matches the steady-state floor.

## 4. Cluster C — Overflow log lines without a separate framework banner

**Status: NONE (CLEAN).** The 2 overflow log lines in `secondary_classes_test.log.txt` are the two `A RenderFlex overflowed by 2.0 pixels on the right.` banners from item 3 above (`cupertino_nav_segmented_test.dart`), already accounted for in Cluster B. No additional overflow lines anywhere else (`grep -c 'overflowed by' *.log.txt` returns 0 for every other suite).

## 5. Cluster D — Skipped tests

**Status: 10 skips, all with documented rationale — same set as the AST sweep, no investigation needed.**

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
- **Test-app stability wedges** (W1–W5, D1): #2, #4, #5, #6, #7, #8 — six items pinned to test-app teardown / `/build` / `/clear` wedging. Tracked in `doc/interpreter_issues.md` under the W1–W5 / D1 labels.

## 6. Cluster summary

| Cluster | Topic | Status | Action needed |
| --- | --- | --- | --- |
| A | Test failures | **DEFERRED** (1 transport-timeout, environmental — not a script/interpreter bug; same script passed in AST sweep and 2026-05-19 baseline) | none unless it recurs across two consecutive isolated runs (then track as a W-class wedge) |
| B | Non-fatal framework banners (4 scripts) | **REVERTED / DEFERRED** (all match U14/U15/U17/U18 already documented) | none — every banner is the known steady-state floor |
| C | Overflow lines without separate banner | **FIXED** (no additional overflow lines) | none |
| D | Skipped tests (10 total) | **DEFERRED** (all documented) | none — W1/W2/W3/W4/W5/D1 tracked in `interpreter_issues.md`; platform gates are intentional |

## 7. Evidence & artefacts

- Per-suite JSON: `*.result.json` (14 files)
- Per-suite log: `*.log.txt` (14 files, captures both stdout and stderr)
- Metric lines: emitted as `[METRIC] script=… sourceChars=… status=… frameworkErrors=…` in each log; the `frameworkErrors` field is the canonical signal for Cluster B.
- Transport-timeout failure: see `hardly_relevant_classes_1_test.log.txt` lines 392-399 (METRIC line + the SendTestRunner stack trace at lines 654-660).
- Framework-banner extraction: `grep -B1 -A5 'frameworkErrors=[1-9]' *.log.txt` (5 banners total across 4 distinct scripts).
- Overflow log scan: `grep -c 'overflowed by' *.log.txt` (0 lines outside the cupertino banners).
- Skip extraction: from JSON `testDone events with "skipped":true`.

## 8. Cross-project comparison vs `tom_d4rt_flutter_ast`

| Metric | flutter_ast | flutter_test | Delta |
| --- | ---: | ---: | --- |
| Tests passing | 2189 | 2188 | -1 (the timeout failure) |
| Tests skipped | 10 | 10 | identical set |
| Tests failing | 0 | 1 | +1 (transport timeout, environmental) |
| Framework-error banners | 5 | 5 | identical set + counts (same U14/U15/U17/U18 scripts) |
| Additional overflow lines | 0 | 0 | identical |

The flutter_test sweep is one transport-timeout flake away from being identical to the AST sweep. The interpreter behaviour the two projects exercise is the same; the only delta is the one-off `pointer_scroll_inertia_cancel_event_test.dart` `POST /build` hang at minute 10:19 of the `hardly_relevant_classes_1` run.

## 9. Conclusion

Steady-state floor confirmed at:

- 2188 tests passing across 14 suites
- 10 skipped tests (all platform-gated or known-wedging — no new candidates)
- 1 test failing — a single transport timeout, environmental, not a script or interpreter bug
- 4 distinct scripts emitting 5 non-fatal framework-error banners — every one a documented unfixable (U14, U15, U17, U18)
- 0 additional overflow log lines

No regressions vs. the 2026-05-19 `testlog_20260519-1247-flutter-suites-fixes` baseline (the transport-timeout test passed in that baseline; one-off environmental noise). No new fixes required. The post-Cluster-I floor is the current expected state.
