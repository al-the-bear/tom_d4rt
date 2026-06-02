# D4rt Flutter Bridge — Test Issue Analysis

**Analysis ID:** `20260602-0629-issue-analysis`
**Git revision:** `1bc63a42` (branch `main`, both projects)
**Run window:** 2026-06-02 06:32:30 → 09:53:58 CEST (~3 h 21 m, serial)
**Projects analysed:** `tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`
**Result files:** this folder (AST) and the mirror
`tom_d4rt_flutter_test/doc/testlog_20260602-0629-issue-analysis/`

## How the run was performed

- All 14 suites were run **file-by-file, strictly non-concurrent**, and the
  two projects were run sequentially (never in parallel) — the test apps use
  shared local HTTP servers (AST on port 4247, TEST on 4248) and concurrent
  runs corrupt results.
- Each suite: `flutter test test/<suite>.dart --timeout 60s
  --file-reporter json:doc/testlog_<id>/<suite>.result.json`, with stdout
  tee'd to `<suite>.log.txt`.
- Mode: **debug** (`D4RT_PROFILE` unset), so per-script build times are
  ~1.5 s (vs ~4 s in the prior profile-mode sweep).

### Timeout interpretation (important)

- `--timeout 60s` sets **flutter_test's per-test timeout** to 60 s (raised
  from the default 30 s).
- The harness's internal HTTP budgets were **left at default on purpose**:
  `POST /build` = 25 s, `GET /clear` = 5 s (see `_httpBuildTimeout` /
  `_httpClearTimeout` in `test/send_test_runner.dart`). These transport
  budgets are the mechanism that surfaces a wedged test-app event loop as a
  `transport_error`. Raising them to 60 s would **mask** exactly the issues
  this analysis is meant to find. **Every failure below is a transport
  timeout at 25 s (or 5 s for `/clear`) — none is a flutter_test 60 s
  timeout, and none is an assertion/build-logic failure.**

---

## 1. Test result summary (metrics)

| Project | Tests | Passed | Failed | Skipped |
| ------- | ----: | -----: | -----: | ------: |
| `tom_d4rt_flutter_ast`  | 2199 | **2193** | **2** | 4 |
| `tom_d4rt_flutter_test` | 2199 | **2179** | **16** | 4 |

Per-script timing metrics (`[METRIC] script=… httpMs=… status=…
appInterpretEndMs=… appPumpEndMs=…`) are preserved verbatim in every
`<suite>.log.txt`. Transport failures show `status=transport_error
httpStatus=-1` with `httpMs≈25003` (the 25 s build cap) or `clearMs≈5000`.

### Per-suite breakdown — `tom_d4rt_flutter_ast`

| Suite | Passed | Failed | Skipped |
| ----- | -----: | -----: | ------: |
| essential_classes_test | 108 | 0 | 0 |
| important_classes_test | 164 | 0 | 0 |
| secondary_classes_test | 652 | 1 | 1 |
| hardly_relevant_classes_1_test | 204 | 0 | 1 |
| hardly_relevant_classes_2_test | 203 | 0 | 0 |
| hardly_relevant_classes_3_test | 200 | 1 | 0 |
| hardly_relevant_classes_4_test | 227 | 0 | 0 |
| hardly_relevant_classes_5_test | 230 | 0 | 0 |
| crashing_tests_test | 4 | 0 | 0 |
| timeout_tests_test | 51 | 0 | 0 |
| blocking_tests_test | 5 | 0 | 0 |
| generator_interpreter_issues_test | 82 | 0 | 1 |
| generator_interpreter_retest_test | 57 | 0 | 1 |
| interactive_tests_test | 6 | 0 | 0 |

### Per-suite breakdown — `tom_d4rt_flutter_test`

| Suite | Passed | Failed | Skipped |
| ----- | -----: | -----: | ------: |
| essential_classes_test | 105 | 3 | 0 |
| important_classes_test | 162 | 2 | 0 |
| secondary_classes_test | 649 | 4 | 1 |
| hardly_relevant_classes_1_test | 204 | 0 | 1 |
| hardly_relevant_classes_2_test | 201 | 2 | 0 |
| hardly_relevant_classes_3_test | 201 | 0 | 0 |
| hardly_relevant_classes_4_test | 227 | 0 | 0 |
| hardly_relevant_classes_5_test | 229 | 1 | 0 |
| crashing_tests_test | 3 | 1 | 0 |
| timeout_tests_test | 51 | 0 | 0 |
| blocking_tests_test | 3 | 2 | 0 |
| generator_interpreter_issues_test | 82 | 0 | 1 |
| generator_interpreter_retest_test | 57 | 0 | 1 |
| interactive_tests_test | 5 | 1 | 0 |

---

## 2. Failures, file by file

**Common signature:** every failure is
`Bad state: Transport failure … TimeoutException after 0:00:25.000000:
Future not completed` on `POST /build` (one is `0:00:05` on `GET /clear`).
The script's build (or the preceding clear) never completes inside the
test-app budget → the app's Dart event loop is wedged → the harness reports
`transport_error` and arms a recycle for the next test. This is the same
"test-app wedge on a specific large/lifecycle-heavy script" class tracked
in `interpreter_unfixable.md` §U28 — but each wedging script is its own
reproducible interpreter/bridge issue and should be investigated
individually, not written off as environmental.

### 2a. `tom_d4rt_flutter_ast` — 2 failures

| Suite | Failing test (script) | Operation | Budget hit |
| ----- | --------------------- | --------- | ---------- |
| secondary_classes_test | `rendering/selection_registrar_test.dart` | POST /build | 25 s |
| hardly_relevant_classes_3_test | `rendering/persistent_header_show_on_screen_configuration_test.dart` | POST /build | 25 s |

### 2b. `tom_d4rt_flutter_test` — 16 failures

| Suite | Failing test (script) | Operation | Budget hit |
| ----- | --------------------- | --------- | ---------- |
| essential_classes_test | `widgets/appbar_test.dart` | POST /build | 25 s |
| essential_classes_test | `widgets/icon_test.dart` | POST /build | 25 s |
| essential_classes_test | `widgets/singlechildscrollview_test.dart` | POST /build | 25 s |
| important_classes_test | `widgets/customscrollview_test.dart` | POST /build | 25 s |
| important_classes_test | `widgets/transform_full_test.dart` | POST /build | 25 s |
| secondary_classes_test | `animation/animation_max_test.dart` | POST /build | 25 s |
| secondary_classes_test | `cupertino/cupertino_text_magnifier_test.dart` | **GET /clear** | **5 s** |
| secondary_classes_test | `dart_ui/ztmp_path_metrics_access_test.dart` | POST /build | 25 s |
| secondary_classes_test | `dart_ui/semantics_action_test.dart` | POST /build | 25 s |
| hardly_relevant_classes_2_test | `material/selection_area_test.dart` | POST /build | 25 s |
| hardly_relevant_classes_2_test | `material/animated_icon_data_test.dart` | POST /build | 25 s |
| hardly_relevant_classes_5_test | `widgets/popup_window_controller_delegate_test.dart` | POST /build | 25 s |
| crashing_tests_test | `widgets/display_feature_sub_screen_test.dart` (from secondary) | POST /build | 25 s |
| blocking_tests_test | `retest/widgets/context_action_test.dart` (W1) | POST /build | 25 s |
| blocking_tests_test | `retest/widgets/default_text_editing_shortcuts_test.dart` (W2) | POST /build | 25 s |
| interactive_tests_test | `material/showbottomsheet_test.dart` (showBottomSheet static demo) | POST /build | 25 s |

> Note the `cupertino_text_magnifier_test.dart` failure hits the **5 s
> `/clear`** budget, not `/build`: the *previous* script left the app wedged,
> so the clear that precedes this test's build is what times out. It is the
> same root cause (a wedging script) one slot earlier in the suite.

### Recycle activity (event-loop wedges)

The recycle counter is a direct proxy for how often the app's event loop
wedged and had to be force-killed + relaunched:

- **AST:** 3 recycles — in `secondary_classes_test`,
  `hardly_relevant_classes_3_test`, `generator_interpreter_retest_test`.
  (The retest recycle **recovered** — 0 failures in that suite — so the wedge
  there was transient; the other two map onto the 2 failures above.)
- **TEST:** 16 recycles — concentrated in `secondary` (4), `essential` (3),
  `blocking` (2), `hardly_2` (2), `important` (2), and one each in
  `hardly_5`, `interactive`, `generator_interpreter_retest`.

---

## 3. Framework / runtime errors captured **without** a test failure

These were caught by the test app's framework-error hook (red-screen /
post-layout errors) and printed as `⚠️ FRAMEWORK ERROR` even though the
owning `test()` still passed (the build returned a widget; the error fired
later in the lifecycle). They are real interpreter bugs and must be fixed.

| Project | Script | Error |
| ------- | ------ | ----- |
| `tom_d4rt_flutter_test` | `widgets/tree_sliver_test.dart` | `Native error in bridged superclass method 'State.setState': setState() called after dispose(): _InterpretedMultiTickerProviderState#f8273 (lifecycle state: defunct, not mounted, tickers: …)` |
| `tom_d4rt_flutter_test` | `widgets/two_dimensional_child_builder_delegate_test.dart` | Same `setState() called after dispose()` on `_InterpretedMultiTickerProviderState#f8273` |

**Root cause (shared):** the interpreted `MultiTickerProviderStateMixin`
state object calls `setState()` from a ticker/animation callback that fires
**after** the State has been disposed. Native Flutter guards this; the
bridged `State.setState` does not gate on `mounted`/lifecycle, so the call
escapes as a runtime error. Both scripts share the same offending state
hash (`#f8273`), pointing at one bridge defect, not two.

> **Overflow / RenderFlex check:** the run was explicitly scanned for
> `overflowed by …`, `RenderFlex overflowed`, and `RenderBox was not laid
> out`. **None were found** in either project's logs for this revision.

---

## 4. Skipped tests (4 per project) and why

| Script | Suites | Reason (from the `skip:` annotation) | Category |
| ------ | ------ | ------------------------------------ | -------- |
| `widgets/android_view_test.dart` | secondary_classes_test, generator_interpreter_issues_test | `skip: !Platform.isAndroid → 'AndroidView only renders on Android'`. Test host is macOS desktop. | Platform limitation |
| `dart_ui/isolate_name_server_test.dart` | hardly_relevant_classes_1_test | `IsolateNameServer` needs real isolate infra (`Isolate.spawn`, cross-isolate `SendPort`/`ReceivePort`, port registration). The d4rt interpreter only does limited async/await simulation, not real isolates. | Interpreter limitation |
| `retest/dart_ui/system_color_palette_test.dart` | generator_interpreter_retest_test | `skip:` on all desktop platforms. `SystemColor` is only populated on web; on desktop `platformProvidesSystemColors` is false and `.light`/`.dark` throw `UnsupportedError`. The retest variant has the gating workaround reverted. | Platform limitation (web-only API) |

(Each project counts 4 skips because `android_view_test.dart` is skipped in
**two** suites — secondary and generator_interpreter_issues.) None of the
skips indicate a regression; all are deliberate platform/interpreter gates.

---

## 5. Fix TODO list

Process top to bottom. Each item is independently verifiable. Follow the
quest's cluster-fix protocol (reproduce isolated → fix interpreter/bridge →
**mirror tom_d4rt ↔ tom_d4rt_ast** → regenerate bridges → re-verify the
script → run the affected suite serially → commit + push). Keep the 25 s
build budget at default while verifying so a "fix" can't pass by merely
being slow.

### Framework errors (highest priority — silent runtime bugs)

- [ ] **1. Fix `setState() called after dispose()` in bridged
  `MultiTickerProviderStateMixin`.** Gate the bridged `State.setState` (and
  the ticker callback path) on `mounted`/lifecycle so a ticker firing after
  dispose is dropped, matching native Flutter. Reproduce with
  `tom_d4rt_flutter_test` `widgets/tree_sliver_test.dart` and
  `widgets/two_dimensional_child_builder_delegate_test.dart` (same state
  `#f8273`). Verify: both scripts build with **0 framework errors**. Mirror
  the fix into `tom_d4rt_flutter_ast`.

### Transport-error wedges — `tom_d4rt_flutter_test` (16)

- [ ] **2.** `widgets/appbar_test.dart` (essential) — build wedges at 25 s.
- [ ] **3.** `widgets/icon_test.dart` (essential).
- [ ] **4.** `widgets/singlechildscrollview_test.dart` (essential).
- [ ] **5.** `widgets/customscrollview_test.dart` (important).
- [ ] **6.** `widgets/transform_full_test.dart` (important).
- [ ] **7.** `animation/animation_max_test.dart` (secondary).
- [ ] **8.** `cupertino/cupertino_text_magnifier_test.dart` (secondary) —
  fails on the preceding `GET /clear` (5 s); investigate this script **and**
  the one scheduled immediately before it in the suite.
- [ ] **9.** `dart_ui/ztmp_path_metrics_access_test.dart` (secondary).
- [ ] **10.** `dart_ui/semantics_action_test.dart` (secondary).
- [ ] **11.** `material/selection_area_test.dart` (hardly_2).
- [ ] **12.** `material/animated_icon_data_test.dart` (hardly_2).
- [ ] **13.** `widgets/popup_window_controller_delegate_test.dart` (hardly_5).
- [ ] **14.** `widgets/display_feature_sub_screen_test.dart` (crashing suite,
  sourced from secondary).
- [ ] **15.** `retest/widgets/context_action_test.dart` (blocking W1).
- [ ] **16.** `retest/widgets/default_text_editing_shortcuts_test.dart`
  (blocking W2).
- [ ] **17.** `material/showbottomsheet_test.dart` (interactive showBottomSheet
  static demo).

### Transport-error wedges — `tom_d4rt_flutter_ast` (2)

- [ ] **18.** `rendering/selection_registrar_test.dart` (secondary).
- [ ] **19.** `rendering/persistent_header_show_on_screen_configuration_test.dart`
  (hardly_3).

### Cross-cutting

- [ ] **20.** Confirm the **AST vs TEST divergence**: the AST interpreter
  wedges on only 2 scripts where the TEST (source/analyzer) interpreter
  wedges on 16. After fixing items 2–17, re-run both projects and confirm
  the failure sets converge (the AST path is the migration target and is
  currently the *healthier* of the two — understand why, so the TEST-only
  wedges aren't hiding a real interpreter bug the AST path merely tolerates).
- [ ] **21.** Investigate the **transient AST `generator_interpreter_retest`
  recycle** (recovered, 0 failures): identify which script triggered it so it
  doesn't become a flaky failure under load.

---

## Appendix — reproducing a single failing script

```bash
cd tom_ai/d4rt/tom_d4rt_flutter_test   # or _ast
# isolated repro of one wedging script via the runner test, fresh app each time:
flutter test test/secondary_classes_test.dart --timeout 60s \
  --plain-name 'animation_max_test.dart'
# watch the [METRIC] line: status=success + httpMs well under 25000 == fixed.
```
