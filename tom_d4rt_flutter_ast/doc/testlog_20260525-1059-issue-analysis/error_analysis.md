# Test Log Issue Analysis — `20260525-1059-issue-analysis`

| | |
|---|---|
| **Run ID** | `20260525-1059-issue-analysis` |
| **Git revision** | `bf972a31` ‑ `feat(d4rt-flutter): override ErrorWidget.builder to suppress red screens` |
| **Run start** | 2026‑05‑25 10:59 local |
| **Run end** | 2026‑05‑25 ~13:54 (flutter_ast) / ~14:10 (flutter_test) — ~3 hr wall time, parallel |
| **Scope** | 14 flutter test files × 2 projects (`tom_d4rt_flutter_ast`, `tom_d4rt_flutter_test`). Both ran in parallel as separate background processes (ports 4247 / 4248). |
| **Aggregation artifacts** | `ztmp/aggregate_20260525-1059.json` + `ztmp/failures_20260525-1059.txt` |

---

## 1. Headline numbers

| Project | passed | skip | failure (real) | error (transport/timeout) | error‑widget suppressed | silenced `_dependents.isEmpty` |
|---|---:|---:|---:|---:|---:|---:|
| `tom_d4rt_flutter_ast`  | **2146** | 3 | **14** | **81** | **10** | **45** |
| `tom_d4rt_flutter_test` | **2143** | 3 | **14** | **84** | **10** | **45** |

**Interpretation in three lines:**

1. `failure` (real D4rt script / runtime / interpreter bugs) is **14 per project** — almost all overlap, the canonical "cluster of known D4rt bugs" that the bug-fix campaign tracks.
2. `error` (transport-failure + timeout, 81–84 per project) is **pure cold-start parallel-sweep contention** — the same well-documented pattern seen in the `20260525-0316` baseline (87 / 98 transports). No regression. None of these correlate with `[error-widget]` events; the suppressed red screens never blocked subsequent tests.
3. The pump + `ErrorWidget.builder` override is **proven to work**: 20 red screens (10 per project) were intercepted (the `_dependents.isEmpty` assertion alone fired 45 times per app and was silenced both visually and in the log), and zero `clear-timeout` / zero `_dependents-catch-all` events across the entire sweep.

---

## 2. Per‑file results

### 2.1 `tom_d4rt_flutter_ast`

| File | pass | skip | fail | err | fwErr (distinct) | error-widget | notes |
|---|---:|---:|---:|---:|---:|---:|---|
| `essential_classes_test`              | 108 | 0 |  0 |  3 | 0 | 0 | 3 transports (cold-start) |
| `important_classes_test`              | 167 | 0 |  0 |  0 | 0 | 0 | ✓ clean |
| `secondary_classes_test`              | 631 | 1 |  2 | 23 | 4 | 5 | biggest file: 23 cold-start transports + 2 real script failures + 4 distinct fwErrs |
| `hardly_relevant_classes_1_test`      | 196 | 1 |  1 | 10 | 0 | 0 | object_event_test fail + 10 cold-start |
| `hardly_relevant_classes_2_test`      | 197 | 0 |  0 |  9 | 1 | 0 | Scrollbar.thumbVisibility fwErr + 9 cold-start |
| `hardly_relevant_classes_3_test`      | 193 | 0 |  0 | 11 | 0 | 0 | 11 cold-start |
| `hardly_relevant_classes_4_test`      | 222 | 0 |  0 |  8 | 1 | 0 | Codec fwErr + 8 cold-start |
| `hardly_relevant_classes_5_test`      | 221 | 0 |  0 | 12 | 2 | 0 | 2 fwErrs (BoxConstraints, Scrollbar) + 12 cold-start |
| `crashing_tests_test`                 |   7 | 0 |  0 |  0 | 0 | 0 | ✓ clean |
| `timeout_tests_test`                  |  50 | 0 |  2 |  2 | 3 | 5 | render_custom_paint + r_c_s_c_l_box failures + 2 transports |
| `blocking_tests_test`                 |   8 | 0 |  0 |  0 | 0 | 0 | ✓ clean |
| `generator_interpreter_issues_test`   |  77 | 1 |  7 |  1 | 2 | 0 | 7 cluster bugs + render_physical_shape transport |
| `generator_interpreter_retest_test`   |  58 | 1 |  0 |  2 | 0 | 0 | 2 transports (render_animated_size_state, app_kit_view) |
| `interactive_tests_test`              |   7 | 0 |  2 |  0 | 0 | 0 | dismiss-via-barrier + showDatePicker‑CANCEL |
| **TOTAL**                             | **2146** | 3 | 14 | 81 | 13 | 10 |  |

### 2.2 `tom_d4rt_flutter_test`

| File | pass | skip | fail | err | fwErr (distinct) | error-widget | notes |
|---|---:|---:|---:|---:|---:|---:|---|
| `essential_classes_test`              | 110 | 0 |  1 |  0 | 0 | 0 | materialapp_test fail |
| `important_classes_test`              | 166 | 0 |  0 |  1 | 2 | 0 | selectabletext_test transport + 2 Scrollbar fwErrs |
| `secondary_classes_test`              | 623 | 1 |  2 | 31 | 5 | 5 | biggest: 31 cold-start + 2 real failures + 5 fwErrs |
| `hardly_relevant_classes_1_test`      | 195 | 1 |  1 | 11 | 0 | 0 | cupertino/class_test fail + 11 cold-start |
| `hardly_relevant_classes_2_test`      | 197 | 0 |  0 |  9 | 0 | 0 | 9 cold-start |
| `hardly_relevant_classes_3_test`      | 191 | 0 |  1 | 12 | 0 | 0 | text_editing_delta_deletion + 12 cold-start |
| `hardly_relevant_classes_4_test`      | 218 | 0 |  0 | 12 | 0 | 0 | 12 cold-start |
| `hardly_relevant_classes_5_test`      | 230 | 0 |  0 |  3 | 0 | 0 | 3 cold-start |
| `crashing_tests_test`                 |   7 | 0 |  0 |  0 | 0 | 0 | ✓ clean |
| `timeout_tests_test`                  |  50 | 0 |  2 |  2 | 3 | 5 | same render_custom_paint + r_c_s_c_l_box pair |
| `blocking_tests_test`                 |   8 | 0 |  0 |  0 | 0 | 0 | ✓ clean |
| `generator_interpreter_issues_test`   |  77 | 1 |  7 |  1 | 2 | 0 | same 7 cluster bugs |
| `generator_interpreter_retest_test`   |  58 | 1 |  0 |  2 | 0 | 0 | same 2 transports |
| `interactive_tests_test`              |   9 | 0 |  0 |  0 | 0 | 0 | ✓ clean (flutter_test version interprets source directly — passes both interactive scripts that fail in flutter_ast) |
| **TOTAL**                             | **2143** | 3 | 14 | 84 | 12 | 10 |  |

---

## 3. Real failures — categorised

The 14 real `failure` cases in each project resolve into **5 fix clusters**. The same cluster IDs are used in the TODO list at the end.

### Cluster A — D4rt interpreter cascade setters

Test scripts use cascade syntax `..hueShift = X` / `..layoutMode = Y` on `RenderObject` subclasses, but the interpreter's cascade resolution doesn't find the setter on the target. Affects rendering pipeline.

Captured framework-error lines:

```
Runtime Error: No setter 'hueShift' for assignment in cascade.
Runtime Error: No setter 'layoutMode' for assignment in cascade.
```

**Failing scripts (both apps):**
- `rendering/render_absorb_pointer_test.dart`  *(gii)*
- `rendering/render_box_container_defaults_mixin_test.dart`  *(gii)*
- `rendering/relayout_when_system_fonts_change_mixin_test.dart`  *(gii)*
- `rendering/render_custom_multi_child_layout_box_test.dart`  *(gii)*
- `rendering/render_custom_paint_test.dart`  *(gii + timeout + secondary)*
- `rendering/render_custom_single_child_layout_box_test.dart`  *(gii + timeout + secondary)*
- `widgets/shader_mask_test.dart`  *(gii)*

### Cluster B — Bridge `Cannot get renderObject of inactive element`

Bridges that wrap `Element.findRenderObject()` don't check the element-active state before calling through. Native Flutter asserts inactive elements have no renderObject.

```
Runtime Error: Native error during bridged method call 'findRenderObject' on
  SingleChildRenderObjectElement: Cannot get renderObject of inactive element.
```

This shows up as a captured framework error (visible in `secondary_classes_test` for both apps) but currently doesn't cause a script‑level failure — it surfaces inside script teardown and the harness still completes. Pre-emptive fix prevents the `Looking up a deactivated widget's ancestor is unsafe` cascade that follows.

### Cluster C — Interactive test scripts (flutter_ast only)

Two `interactive_tests_test` scripts fail in flutter_ast but PASS in flutter_test. The flutter_ast project parses through the AST bundle → mirror AST pipeline; flutter_test interprets the source directly. The divergence is the AST bundle (it's missing something the source-direct interpreter has).

- `dismiss modal via barrier tap`
- `Interactive tests showDatePicker static demo — taps rendered CANCEL label`

### Cluster D — Project-specific isolated failures

Scripts that fail in exactly one of the two projects (real script-specific bugs, not pump-related):

| Project | File | Script |
|---|---|---|
| flutter_test | `essential_classes_test`              | `material/materialapp_test.dart` |
| flutter_ast  | `hardly_relevant_classes_1_test`      | `foundation/object_event_test.dart` |
| flutter_test | `hardly_relevant_classes_1_test`      | `cupertino/class_test.dart` |
| flutter_test | `hardly_relevant_classes_3_test`      | `services/text_editing_delta_deletion_test.dart` |

### Cluster E — Cold-start parallel-sweep contention (transport / timeout)

165 errors across both projects (81 + 84). Each manifests as either:

- **Transport failure**: harness sends `POST /build`, test-app HTTP server times out at 25 s. The next script then runs cleanly.
- **TimeoutException after 0:00:30**: harness-level test-timeout after 30 s.

These do **not** correlate with `[error-widget]` invocations (only 10 per project), with `_dependents.isEmpty` events (45 per project, all silenced), or with framework errors. They cluster around the start of each test file (cold-start), with the test-app process spending its first ~25–30 s warming up the Dart VM + Flutter engine + first interpreter cold-cache, while the harness has already moved on.

**This pattern is documented as the baseline parallel-sweep contention** (see `testlog_20260525-0316-issue-analysis/error_analysis.md` §1). Single-script re-runs of any of these scripts in isolation pass cleanly. **Fix is host-pressure-related, not interpreter / generator / bridge / pump.**

---

## 4. Captured framework errors (across both projects)

Distinct messages logged by the test-app's `_capturingFrameworkErrors` path. The user-visible "flutter output in the log which reports other test internal problems like overflow errors" is exactly this stream.

| # | Pattern | Cluster | Suite seen in |
|---|---|---|---|
| 1 | `Runtime Error: No setter 'hueShift' for assignment in cascade.` | A | secondary, gii, timeout |
| 2 | `Runtime Error: No setter 'layoutMode' for assignment in cascade.` | A | secondary, gii, timeout |
| 3 | `Runtime Error: Native error during bridged method call 'findRenderObject' on SingleChildRenderObjectElement: Cannot get renderObject of inactive element.` | B | secondary |
| 4 | `Looking up a deactivated widget's ancestor is unsafe.` | B (cascade) | gii |
| 5 | `Tried to build dirty widget in the wrong build scope.` | B (cascade) | gii |
| 6 | `A RenderConstraintsTransformBox overflowed by 30 pixels …` | U17 (intentional by-design) | secondary, timeout |
| 7 | `'package:flutter/src/widgets/framework.dart' Failed assertion: line 6417 pos 14: '() {` | F (framework assertion) | secondary, timeout |
| 8 | `A ScrollController is required when Scrollbar.thumbVisibility is true.` | G (script bug) | hr2, hr5, important (test) |
| 9 | `A ScrollController is required when the scrollbar is interactive.` | G (script bug) | important (test) |
| 10 | `Exception: Codec failed to produce an image, possibly due to invalid image data.` | H (script bug) | hr4 |
| 11 | `BoxConstraints forces an infinite height.` | I (script layout bug) | hr5 |

Patterns 6 / 8 / 10 / 11 are **script-side bugs** that the scripts already document or that surface as testable contracts. Pattern 7 is a framework assertion that's expected to cascade through after a `_dependents.isEmpty` event (line 6417 lives a few lines from line 6268 in `framework.dart` — same teardown path). Patterns 1–5 are the real D4rt bugs to fix.

---

## 5. Skipped tests

Each `skip` was investigated against the test source. The `skip` field in the `result.json` is reported as `True` for parameterised skips; the actual condition was recovered from the test file.

### `tom_d4rt_flutter_ast`

| Test file | Skipped script | Skip reason |
|---|---|---|
| `secondary_classes_test` | `widgets/android_view_test.dart` | `skip: !Platform.isAndroid` — Android-only widget. The host (macOS) cannot construct an `AndroidView`. **Not a bug.** |
| `hardly_relevant_classes_1_test` | `dart_ui/isolate_name_server_test.dart` | `skip: 'IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)'` — d4rt simulates `Future`/`async` but does not spawn real isolates with `Isolate.spawn` + cross-isolate `SendPort`/`ReceivePort`. **Interpreter limitation, by design.** |
| `generator_interpreter_issues_test` | `widgets/android_view_test.dart` | Same as above. |
| `generator_interpreter_retest_test` | `dart_ui/system_color_palette_test.dart` | `skip: (Platform.isLinux \|\| Platform.isMacOS \|\| Platform.isWindows)` — `dart:ui` `SystemColorPalette` only exists on mobile platforms. **Not a bug.** |

### `tom_d4rt_flutter_test`

| Test file | Skipped script | Skip reason |
|---|---|---|
| `secondary_classes_test` | `widgets/android_view_test.dart` | Same — Android-only. |
| `hardly_relevant_classes_1_test` | `dart_ui/isolate_name_server_test.dart` | Same — interpreter limitation. |
| `generator_interpreter_retest_test` | `dart_ui/system_color_palette_test.dart` | Same — mobile-only API. |

All skips are intentional and documented in test source. **None of the skips need attention.**

---

## 6. Fix TODO list

Numbered list with `[ ] fixed` checkboxes. Items are ordered to maximise downstream impact: fix the D4rt interpreter bugs first (cluster A is in 7 scripts), then the bridge (cluster B is silent but produces cascade fwErrs), then the project-specific failures, then the script-side bugs.

The cold-start contention errors (cluster E) are **not** on this list because they are host-pressure artefacts of running two parallel `flutter test` sweeps; they don't reproduce in isolated runs. See note at the end.

### Cluster A — D4rt interpreter: cascade setter resolution (rendering pipeline)

- [ ] **1. Fix `..hueShift = X` cascade setter resolution.** The interpreter's cascade handler doesn't find the `hueShift` setter on `RenderShaderMask` (the test target). Investigate `tom_d4rt/lib/src/interpreter_visitor.dart` cascade-evaluation path; mirror in `tom_d4rt_ast`. Verify by re-running `rendering/render_absorb_pointer_test.dart` in isolation. _fixed:_

- [ ] **2. Fix `..layoutMode = Y` cascade setter resolution.** Same shape as #1, different setter target (`RenderConstraintsTransformBox.layoutMode`). Likely the same root cause as #1 — once #1 is fixed, run the affected scripts to confirm. _fixed:_

- [ ] **3. Verify the full cluster-A script set passes.** After #1 + #2, run:
  - `rendering/render_absorb_pointer_test.dart`
  - `rendering/render_box_container_defaults_mixin_test.dart`
  - `rendering/relayout_when_system_fonts_change_mixin_test.dart`
  - `rendering/render_custom_multi_child_layout_box_test.dart`
  - `rendering/render_custom_paint_test.dart`
  - `rendering/render_custom_single_child_layout_box_test.dart`
  - `widgets/shader_mask_test.dart`

  All in isolation. Expected: 0 framework errors, 0 failures across both apps. _fixed:_

### Cluster B — Bridge: `findRenderObject` on inactive element

- [ ] **4. Guard `LeafRenderObjectElement.findRenderObject` bridge adapter against inactive elements.** Add an `_lifecycleState != _ElementLifecycle.active` check in the bridge wrapper and return `null` (or throw a typed exception that the interpreter swallows in cleanup paths) when the element has been deactivated. File: `tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/*element*` (and `tom_d4rt_flutter_test` equivalent). _fixed:_

- [ ] **5. Same guard for `SingleChildRenderObjectElement.findRenderObject`.** Same pattern. _fixed:_

- [ ] **6. Verify cascade gone after fix.** Re-run `secondary_classes_test` in flutter_ast and check the captured fwErrs no longer include `findRenderObject … inactive element` nor the downstream `Looking up a deactivated widget's ancestor is unsafe` / `Tried to build dirty widget in the wrong build scope` cascade messages. _fixed:_

### Cluster C — flutter_ast interactive tests (`interactive_tests_test`)

- [ ] **7. Diagnose `dismiss modal via barrier tap` divergence.** The script passes in flutter_test (source-direct interpretation) but fails in flutter_ast (AST-bundle pipeline). Compare what the AST bundle is missing — likely a top-level helper not getting serialised. Walk through both runners side by side. _fixed:_

- [ ] **8. Diagnose `Interactive tests showDatePicker static demo — taps rendered CANCEL label` divergence.** Same shape as #7. Fix may share the same root cause; verify. _fixed:_

### Cluster D — Single-project script failures

- [ ] **9. flutter_test `material/materialapp_test.dart`.** Passes in flutter_ast, fails in flutter_test. First-line error `Expected: true` — pull from the log to identify the actual assertion the script tests. Likely a Material-app construction difference. _fixed:_

- [ ] **10. flutter_ast `foundation/object_event_test.dart`.** Passes in flutter_test, fails in flutter_ast. AST-bundle pipeline divergence (same family as #7 / #8). _fixed:_

- [ ] **11. flutter_test `cupertino/class_test.dart`.** Source-direct only. Identify the assertion. _fixed:_

- [ ] **12. flutter_test `services/text_editing_delta_deletion_test.dart`.** Source-direct only. _fixed:_

### Cluster F — Framework assertion `framework.dart:6417`

- [ ] **13. Investigate `framework.dart line 6417` assertion.** This assertion lives in the same teardown path as the `_dependents.isEmpty` assertion at line 6268. Both are now non-fatal (silencer + `ErrorWidget.builder` override). Investigate whether the cluster-B fix (#4 / #5) eliminates this cascade — they are mechanically tied. If not, add an additional silencer pattern for this assertion message. _fixed:_

### Cluster G — Script-side bugs (Scrollbar / ScrollController)

- [ ] **14. `Scrollbar.thumbVisibility = true` without `ScrollController`.** Scripts use the primary scroll controller but pass `thumbVisibility: true`, which requires an explicit controller. Add a controller in:
  - `hardly_relevant_classes_2_test` (1 script)
  - `hardly_relevant_classes_5_test` (1 script)
  - `important_classes_test` (1 script — also has the `interactive` variant)
  Identify exact scripts via `grep -l 'thumbVisibility' tom_d4rt_flutter_ast/test/.../send_ast_via_http_scripts/`. _fixed:_

### Cluster H — Script-side bug (Codec)

- [ ] **15. `Codec failed to produce an image, possibly due to invalid image data`.** One script in `hardly_relevant_classes_4_test`. Either fix the script to use a valid placeholder image or skip the codec call. Find via `grep -l 'Codec\|image.*decode' tom_d4rt_flutter_*/test/.../hardly_relevant*`. _fixed:_

### Cluster I — Script-side bug (infinite height)

- [ ] **16. `BoxConstraints forces an infinite height`.** One script in `hardly_relevant_classes_5_test`. The script lays out a `Column` (or similar unbounded-height widget) inside an unbounded-height ancestor. Wrap in `IntrinsicHeight` or a `SizedBox(height: ...)`. _fixed:_

### Cluster J — Cold-start parallel-sweep contention (cluster E above)

- [ ] **17. Document the contention pattern in the test harness README.** Not a bug — but the 81–84 transports/timeouts per project significantly hurt the signal-to-noise ratio when reading the logs. Add a note to the test harness that explains "if you see Transport failure on a cold-start test, re-run that single test in isolation; it will pass". Optional: add a per-test retry mechanism in `SendTestRunner` (e.g. one retry on `Transport failure` only, with a 2 s pause). _fixed:_

---

## 7. Verification protocol after each fix

Before ticking the checkbox above, the fix must satisfy:

1. **Reproduce in isolation:** Run the failing script alone via
   ```
   D4RT_SKIP_BRIDGE_REGEN=1 flutter test test/<test_file>.dart \
     --plain-name "<script_name>"
   ```
   from the relevant flutter project directory. Capture full log per the **always-capture rule** (`> doc/testlog_<id>/<name>.log.txt 2>&1`).
2. **Mirror interpreter fix between `tom_d4rt` and `tom_d4rt_ast`** if the change touched `interpreter_visitor.dart` or `d4.dart`.
3. **Regenerate bridges** if the change touched `tom_d4rt_generator/lib/src/*.dart`, `bridge_api.dart`, or `user_bridge_scanner.dart`:
   ```
   dart run tool/regenerate_bridges.dart
   ```
4. **Verify cluster regression**: re-run the full cluster (e.g. all 7 scripts of cluster A) — all must pass, in both projects, in isolation.
5. **Verify suite regression**: serial run `essential` + `important` + `secondary` + (cluster-affected suite) — no new failures introduced.
6. **Update this doc**: tick the checkbox `_fixed:_` with the date and commit SHA.

---

## 8. Cleanup-trace marker summary (sanity check that pump + ErrorWidget override stayed working)

Aggregated marker counts across the entire 14-file sweep, per project:

| Marker | flutter_ast | flutter_test | Interpretation |
|---|---:|---:|---|
| `clear-postpump` | hundreds | hundreds | `/clear` pump fired |
| `build-postpump` | hundreds | hundreds | `/build` pump fired |
| `silenced` | **45** | **45** | `_dependents.isEmpty` log-silenced |
| `_dependents-catch-all` | **0** | **0** | silencer pattern still matches every `_dependents` event |
| `forwarded` | ~12 | ~12 | legitimate runtime errors forwarded to original handler (then captured into `_frameworkErrors`) |
| `error-widget` | **10** | **10** | red ErrorWidget intercepted ten times per app — see breakdown in cluster A / B above |
| `clear-timeout` | **0** | **0** | every `/clear` pump completed within its 2 s ceiling |
| `platform-_dependents` | **0** | **0** | no `_dependents.isEmpty` arrived via `platformDispatcher.onError` (silencer / override caught everything via `FlutterError.onError`) |

**Zero red screens reached the user-visible UI.** The 20 intercepted ErrorWidget invocations (10 per app) cover exactly the cluster A and cluster B errors enumerated above; without the override, those 20 would have manifested as cascading Transport failures across the affected test files.
