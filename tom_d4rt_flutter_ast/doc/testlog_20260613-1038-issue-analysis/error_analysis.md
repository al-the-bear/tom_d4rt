# Issue Analysis — tom_d4rt_flutter_ast

| Field | Value |
| --- | --- |
| **Analysis ID** | `20260613-1038-issue-analysis` |
| **Project** | `tom_d4rt_flutter_ast` (analyzer-free, AST-driven bridge corpus) |
| **Git revision** | `7de9b893a` (tom_d4rt repo) |
| **Run date/time** | 2026-06-13 10:38 CEST |
| **Runner** | `test/run_issue_analysis_tests.sh` (file-by-file, strictly serial) |
| **Logs** | `doc/testlog_20260613-1038-issue-analysis/<base>.log.txt` + `.result.json` |
| **Metrics** | `doc/testlog_20260613-1038-issue-analysis/metrics.txt` (+ per-script `[METRIC]` lines in each log) |
| **Sibling run** | `tom_d4rt_flutter_test` — same ID, see its `error_analysis.md` (clean) |

## Result summary

| Metric | Value |
| --- | --- |
| Test files run | 41 (`flutter_base_01..17`, `flutter_extended_01..24`) |
| Tests passed | **2137** |
| Tests skipped | 4 (intentional — see below) |
| Tests failed | **28**, across 16 files |
| Non-fatal framework errors | 33 (one passing script — see §Framework errors) |

> **Headline:** 27 of the 28 failures are **`Build timed out after 45 seconds`**,
> and in every case the timeout is immediately followed by
> `[recycle] killing wedged test app`. The `buildTimeouts == recycles` count is
> **1:1 in every affected file**. These are not 27 independent logic bugs — they
> are the single long-lived companion app **wedging** on specific heavy scripts
> (transport/stability), so the in-test 45 s build cap trips and the harness has
> to recycle the app for the next script. The remaining 1 failure is a transport
> hiccup (`HttpException: Connection closed`). No assertion/logic mismatches were
> observed in this run.

## Failure taxonomy

| Class | Count | Mechanism |
| --- | --- | --- |
| **A — companion-app wedge / build timeout** | 27 | Script wedges the shared HTTP companion app → in-test build exceeds 45 s → fail + forced `[recycle]`. |
| **B — transport failure** | 1 | `HttpException: Connection closed before full header was received` / `Bad state: Transport failure` (ext_23, `nested_scroll_view_state_test`). |
| **(non-fatal) C — bridge runtime error** | 0 failures / 33 framework errors | `Matrix4.rotationZ` bridge rejects a callback arg (passing script — §Framework errors). |

Proposed fix IDs for follow-up work:

- `FIX-20260613-1038-A` — companion-app wedge / build-timeout stability (class A, 27 failures).
- `FIX-20260613-1038-B` — ext_23 transport flakiness (class B, 1 failure).
- `FIX-20260613-1038-C` — `Matrix4.rotationZ` / `operator *` `NativeFunction` bridge bug (class C, 33 framework errors).

## File-by-file

Each failing entry is `class :: script` where script is the corpus test that failed.

| File | +pass / ~skip / −fail | Failing scripts (class) |
| --- | --- | --- |
| flutter_base_01 | +70 −1 | A :: cupertino/button_test.dart |
| flutter_base_02 | +42 | — clean |
| flutter_base_03 | +52 | — clean |
| flutter_base_04 | +67 −3 | A :: material/component_themes_test.dart · A :: material/datepicker_widgets_test.dart · A :: material/widgetstate_test.dart |
| flutter_base_05 | +64 | — clean |
| flutter_base_06 | +66 | clean **but** 33 framework errors in painting/gradient_transform_test.dart (§C) |
| flutter_base_07 | +62 | — clean |
| flutter_base_08 | +47 −1 | A :: dart_ui/brightness_test.dart |
| flutter_base_09 | +25 −1 | A :: gestures/drag_gesture_recognizer_test.dart |
| flutter_base_10 | +61 | — clean |
| flutter_base_11 | +40 −2 | A :: material/snack_bar_action_test.dart · A :: material/tooltip_visibility_test.dart |
| flutter_base_12 | +59 −2 | A :: rendering/box_hit_test_result_test.dart · A :: rendering/clip_path_layer_test.dart |
| flutter_base_13 | +54 | — clean |
| flutter_base_14 | +34 −2 | A :: services/asset_metadata_test.dart · A :: services/autofill_scope_test.dart |
| flutter_base_15 | +60 ~1 | clean (1 intentional skip) |
| flutter_base_16 | +57 −4 | A :: widgets/overflow_box_test.dart · A :: widgets/page_scroll_physics_test.dart · A :: widgets/page_storage_bucket_test.dart · A :: widgets/page_storage_key_test.dart |
| flutter_base_17 | +51 | — clean |
| flutter_extended_01 | +47 | — clean |
| flutter_extended_02 | +60 ~1 | clean (1 intentional skip) |
| flutter_extended_03 | +53 −1 | A :: dart_ui/transform_engine_layer_test.dart |
| flutter_extended_04 | +46 | — clean |
| flutter_extended_05 | +60 −1 | A :: material/animated_theme_test.dart |
| flutter_extended_06 | +61 | — clean |
| flutter_extended_07 | +46 | — clean |
| flutter_extended_08 | +36 | — clean |
| flutter_extended_09 | +58 −3 | A :: rendering/annotation_entry_test.dart · A :: rendering/class_test.dart · A :: rendering/decoration_position_test.dart |
| flutter_extended_10 | +50 | — clean |
| flutter_extended_11 | +61 | — clean |
| flutter_extended_12 | +30 −1 | A :: services/restoration_bucket_test.dart |
| flutter_extended_13 | +61 | — clean |
| flutter_extended_14 | +61 | — clean |
| flutter_extended_15 | +61 | — clean |
| flutter_extended_16 | +46 −1 | A :: widgets/localizations_resolver_test.dart |
| flutter_extended_17 | +61 | — clean |
| flutter_extended_18 | +59 −2 | A :: widgets/restorable_enum_n_test.dart · A :: widgets/restorable_int_n_test.dart |
| flutter_extended_19 | +61 | — clean |
| flutter_extended_20 | +70 | — clean |
| flutter_extended_21 | +47 | — clean |
| flutter_extended_22 | +42 ~1 | clean (1 intentional skip) |
| flutter_extended_23 | +43 ~1 −2 | **B** :: retest/widgets/nested_scroll_view_state_test.dart (transport) · A :: retest/widgets/object_key_test.dart |
| flutter_extended_24 | +6 −1 | A :: Interactive — showDialog static demo (taps rendered Cancel label) |

## Framework errors (non-fatal) — §C

`painting/gradient_transform_test.dart` (inside the **passing** file `flutter_base_06`)
emitted **33 framework errors** while still reporting `status=success`. Distinct
runtime errors:

- **21×** `Runtime Error: Native error during bridged constructor 'rotationZ' for class 'Matrix4': Argument Error: Invalid parameter "radians": expected double, got NativeFunction`
- **12×** `Runtime Error: Unsupported operator (*) for types double and NativeFunction`

Root cause is a **bridge/interpreter** issue, not a test issue: a `GradientTransform`
script passes a callback/`NativeFunction` where the `Matrix4.rotationZ(double radians)`
bridge (and a `double * x` operator) expects a `double`. The interpreter caught
each occurrence as a framework error rather than crashing the build, so the test
passed — but the rendered transform is wrong. Tracked as `FIX-20260613-1038-C`.

No `RenderFlex overflowed` / layout-overflow framework errors were observed in
this run (searched all 41 logs).

## Skipped tests (intentional — not failures)

- `Skip: AndroidView only renders on Android`
- `Skip: IsolateNameServer is not supported by the d4rt interpreter (requires real Dart isolate infrastructure)`
- `Skip: SystemColor not supported on desktop platforms (web-only API)`

## Recommended next steps

1. **Class A (FIX-…-A):** the dominant signal is companion-app **wedging**, not
   slow interpretation per se — `totalMs` for nearby scripts is well under 45 s
   (e.g. contextmenu `totalMs=16076`). Investigate why specific scripts leave the
   app unresponsive (compare `appInterpretEndMs`/`appPumpEndMs` of a wedged script
   vs a healthy one in the `[METRIC]` lines; check for an interpreter hang or a
   non-returning HTTP handler). The 1:1 recycle correlation is the lead.
2. **Class B (FIX-…-B):** ext_23 is a known-flaky retest file; one transport drop
   on `nested_scroll_view_state_test`. Re-run with `FILES_OVERRIDE="flutter_extended_23_test.dart"`
   to confirm it is non-deterministic vs a hard wedge.
3. **Class C (FIX-…-C):** fix the `Matrix4.rotationZ` / numeric-operator bridge to
   coerce or reject a `NativeFunction` arg with a clear error (mirror the fix in
   `tom_d4rt` and `tom_d4rt_ast` per the quest sync rule).
