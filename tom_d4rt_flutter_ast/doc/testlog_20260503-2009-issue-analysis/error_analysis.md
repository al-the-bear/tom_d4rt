# Error Analysis — testlog 20260503-2009-issue-analysis (tom_d4rt_flutter_ast)

- Baseline ID: `20260503-2009-issue-analysis`
- Revision: `eadebb6c3fc9d93c51a2b673ab9faba8dee1d3b5` (branch `main`)
- Run timestamp: 2026-05-03 20:09 CEST
- Driver: `_run_testlog_20260503-2009.sh` (serial, `D4RT_SKIP_BRIDGE_REGEN=1`, port 4242 shared)
- Project: `tom_d4rt_flutter_ast`

## Suite Results

| File | Pass | Skip | Fail | Wall | Status |
|------|-----:|-----:|-----:|-----:|--------|
| essential_classes_test.dart | 107 | 0 | **1** | 03:14 | ❌ failure |
| important_classes_test.dart | 164 | 0 | 0 | 04:52 | ✅ |
| secondary_classes_test.dart | 652 | 1 | **1** | 19:23 | ❌ failure |
| hardly_relevant_classes_1_test.dart | 202 | 2 | **1** | 05:31 | ❌ failure |
| hardly_relevant_classes_2_test.dart | 203 | 0 | 0 | 06:20 | ✅ |
| hardly_relevant_classes_3_test.dart | 199 | 0 | **2** | 06:54 | ❌ failure |
| hardly_relevant_classes_4_test.dart | 225 | 0 | **2** | 07:10 | ❌ failure |
| hardly_relevant_classes_5_test.dart | 229 | 0 | **1** | 07:27 | ❌ failure |
| crashing_tests_test.dart | 4 | 0 | 0 | 00:19 | ✅ |
| timeout_tests_test.dart | 51 | 0 | 0 | 01:55 | ✅ |
| blocking_tests_test.dart | 5 | 0 | 0 | 00:43 | ✅ |
| generator_interpreter_issues_test.dart | 80 | 2 | **1** | 02:54 | ❌ failure |
| generator_interpreter_retest_test.dart | 53 | 5 | 0 | 01:53 | ✅ |
| interactive_tests_test.dart | 6 | 0 | 0 | 00:35 | ✅ |
| **Total** | **2180** | **10** | **9** | ~75 min | 8 of 14 files clean |

> **Comparison vs prior `20260503-0948-issue-analysis` baseline:** failure counts unchanged file-by-file (essential −1, secondary −1, hardly_1 −1, hardly_3 −2, hardly_4 −2, hardly_5 −1, gii −1). No new regressions, no new fixes since the earlier run on the same revision.

---

## Hard Failures — File by File

### essential_classes_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 22 | `cupertino/ textfield_test.dart` | `Native error during default bridged constructor for 'CupertinoTextField': 'package:flutter/src/cupertino/text_field.dart': Failed assertion: line 320 pos 10: '(maxLines == null) || (minLines == null) || (maxLines >= minLines)': minLines can't be greater than maxLines` |

Cause: deep-demo script constructs `CupertinoTextField` with `minLines > maxLines`. Fix is in the **script**, not the bridge — Cupertino raises the assertion natively. Targeted retest only.

### secondary_classes_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 211 | `dart_ui/ individual string_attribute_test.dart` | `Bad state: Transport failure … POST /build?filename=dart_ui%2Fstring_attribute_test.dart … HttpException: Connection closed before full header was received` |

Cause: introduced by Batch-4 deep-demo rewrite — the script grew to ~85 KB source / ~968 KB bundle JSON, and the `/build` endpoint loses the connection during transfer. Hosting/transport failure, not an interpreter or bridge defect. Tracked as deferred follow-up: shrink the deep-demo script, or raise the SendTestRunner read-timeout.

### hardly_relevant_classes_1_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 47 | `cupertino/ cupertino_text_selection_handle_controls_test.dart` | Same `(maxLines == null) || (minLines == null) || (maxLines >= minLines)` Cupertino assertion (CupertinoTextField is constructed with minLines > maxLines). |

Script-only fix.

### hardly_relevant_classes_3_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 159 | `services/ message_codec_test.dart` | `Native error during bridged method call 'encodeMessage' on StandardMessageCodec: Invalid argument: Instance of 'BridgedInstance<Object>'` |
| 160 | `services/ method_codec_test.dart` | `Native error during bridged method call 'decodeEnvelope' on StandardMethodCodec: PlatformException(BOOT_FAIL, unable to start, {attempt: 1}, null)` |

Cluster: `StandardMessageCodec.encodeMessage` rejects unwrapped `BridgedInstance<Object>` arguments — script passes `Object` payloads that the codec adapter does not unwrap before serialization. `StandardMethodCodec.decodeEnvelope` raises a (script-authored) `PlatformException(BOOT_FAIL …)` that propagates as a hard failure rather than being caught — likely a script-only adjustment (the test should `expect(() => …, throwsA(isA<PlatformException>()))`).

### hardly_relevant_classes_4_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 32  | `widgets/ automatic_keep_alive_client_mixin_test.dart` | `TimeoutException after 0:00:30.000000: Test timed out after 30 seconds.` followed by `Bad state: Transport failure while running … POST /build … TimeoutException after 0:00:25.000000: Future not completed` |
| 154 | `widgets/ i_o_s_system_context_menu_item_cut_test.dart`  | `Positional arguments cannot follow named arguments.` |

Cluster A: `automatic_keep_alive_client_mixin_test` wedges the test app for 25 s during build, then the test reporter times out at 30 s. Looks like the script triggers an infinite frame pump or unbounded async work — script-side bug.

Cluster B: `i_o_s_system_context_menu_item_cut_test` — interpreter reports `Positional arguments cannot follow named arguments`. Almost certainly script-side argument ordering: D4rt's parser/runtime is being given a positional arg after a named one in some constructor or factory call inside the deep-demo. Single-script fix; verify with individual rerun only.

### hardly_relevant_classes_5_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 41 | `widgets/ regular_window_test.dart` | `Cannot instantiate abstract class 'RegularWindowController'.` |

Script attempts to construct an abstract bridged class. Script must be reworked to use a concrete subclass (`RegularWindowControllerMacOS` etc.) or a fake user-bridge subclass.

### generator_interpreter_issues_test.dart

| testID | Test name | Error |
|-------:|-----------|-------|
| 31 | `Section 2 - Bridge Generator Issues (80) widgets/windowing_owner_mac_o_s_test.dart` | 11× `Native error during default bridged constructor for 'AnimatedBuilder': Argument Error: Invalid parameter "animation": expected Listenable, got InterpretedInstance(RegularWindowControllerMacOS)` |

This is the **priority-1 InterpretedInstance coercion cluster** flagged in the 0948 baseline: `RegularWindowControllerMacOS` is a user-bridged subclass of `RegularWindowController` (which `extends Listenable`), but the `AnimatedBuilder` constructor adapter still receives the raw `InterpretedInstance` and refuses it because the relaxer/proxy pipeline doesn't unwrap interpreted subclasses of bridged abstract `Listenable`s for typed Flutter parameters. Same root cause surfaces below as a framework-error block in `hardly_relevant_classes_5`.

---

## Framework-Error Blocks (non-failing)

These are emitted by `SendTestRunner` (`frameworkErrors=N` in metric lines) for tests that returned 200 OK but produced widget-tree exceptions. They do **not** count as failures, but they are surfaced for triage.

| Suite | Script | Count | First-line cause |
|-------|--------|------:|------------------|
| hardly_relevant_classes_2 | material/theme_extension_test.dart | 1 | `Undefined property or method 'surfaceTint' on bridged instance of 'ThemeExtension'.` |
| hardly_relevant_classes_4 | widgets/backdrop_group_test.dart | 1 | `A RenderFlex overflowed by 25 pixels on the bottom.` (layout warning) |
| hardly_relevant_classes_4 | widgets/drag_target_details_test.dart | 5 | `Index out of range: 5` (script indexing into a length-5 list) |
| hardly_relevant_classes_5 | widgets/regular_window_controller_test.dart | 1 | `LateInitializationError: Late variable '_primary' without initializer is accessed before being assigned.` |
| hardly_relevant_classes_5 | widgets/route_transition_record_test.dart | 1 | `Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation.` |
| hardly_relevant_classes_5 | widgets/snapshot_mode_test.dart | 1 | `Native error during default bridged constructor for 'Scaffold': Argument Error: Invalid parameter "appBar": expected PreferredSizeWidget?, got _InterpretedStatelessWidget` (priority-1 cluster) |
| hardly_relevant_classes_5 | widgets/windowing_owner_mac_o_s_test.dart | 11 | Same `AnimatedBuilder` Listenable mismatch as the gii failure (counted twice — gii suite + this suite). |
| generator_interpreter_issues | widgets/windowing_owner_mac_o_s_test.dart | 11 | (counted in failures table) |
| secondary_classes | dart_ui/scene_test.dart | 8 | `A borderRadius can only be given on borders with uniform colors.` (script passes non-uniform `BorderSide.color`) |
| secondary_classes | dart_ui/semantics_action_event_test.dart | 1 | `A RenderFlex overflowed by 7.1 pixels on the right.` |
| secondary_classes | gestures/vertical_multi_drag_gesture_recognizer_test.dart | 1 | `A RenderFlex overflowed by 22 pixels on the bottom.` |
| secondary_classes | material/text_selection_toolbar_test.dart | 2 | `RenderCustomSingleChildLayoutBox object was given an infinite size during layout.` |
| secondary_classes | painting/decoration_image_painter_test.dart | 27 | `RenderConstrainedOverflowBox object was given an infinite size during layout.` (largest cluster; 27 layout exceptions per build) |
| secondary_classes | rendering/render_animated_opacity_test.dart | 1 | `BoxConstraints forces an infinite height.` |
| secondary_classes | rendering/render_ignore_pointer_test.dart | 6 | `BoxConstraints forces an infinite height.` |
| secondary_classes | rendering/render_shader_mask_test.dart | 1 | `A RenderFlex overflowed by 74 pixels on the bottom.` |
| secondary_classes | widgets/animated_fractionally_sized_box_test.dart | 1 | `BoxConstraints forces an infinite height.` |

Total framework-error blocks: **~80** across 16 distinct scripts. Most are layout-overflow warnings caused by deep-demo content rendering at the test-host's small viewport — cosmetic, not interpreter bugs.

---

## Skipped Tests (`-`)

| Suite | Skipped count | Notes |
|-------|--------------:|-------|
| generator_interpreter_issues | 2 | Section 2 - Interpreter Issues subset (intentionally skipped, documented in retest suite). |
| generator_interpreter_retest | 5 | Tests covering work-in-progress fixes, gated by `// ignore`. |
| hardly_relevant_classes_1 | 2 | Pre-existing skips. |
| secondary_classes | 1 | string_attribute_test routed to a separate retry queue (see hard failure 211). |

---

## Failure Clusters (root-cause grouping)

| Cluster | Hard-failing scripts | Framework-error scripts | Diagnosis | Owner |
|---------|----------------------|-------------------------|-----------|-------|
| **C1 — Cupertino minLines/maxLines assertion** | essential/cupertino/textfield, hardly_1/cupertino/cupertino_text_selection_handle_controls | — | Deep-demo script generates `CupertinoTextField` with `minLines > maxLines`. | script |
| **C2 — InterpretedInstance not coerced for typed Flutter param (priority 1)** | gii/widgets/windowing_owner_mac_o_s | hardly_5/widgets/windowing_owner_mac_o_s (11), hardly_5/widgets/snapshot_mode (Scaffold appBar 1) | User subclasses of bridged abstract `Listenable` / `PreferredSizeWidget` reach typed Flutter constructors as raw `InterpretedInstance`s. Relaxer/proxy pipeline must unwrap interpreted subclasses of these abstracts. | bridge generator + interpreter |
| **C3 — Codec rejects BridgedInstance** | hardly_3/services/message_codec, hardly_3/services/method_codec | — | StandardMessageCodec/StandardMethodCodec adapters need to unwrap `BridgedInstance<Object>` payloads before native encode/decode. | bridge handler |
| **C4 — Abstract-class instantiation** | hardly_5/widgets/regular_window | hardly_5/widgets/regular_window_controller (LateInitializationError 1) | Scripts construct an abstract bridged base directly. | script |
| **C5 — Argument-order syntax error in script** | hardly_4/widgets/i_o_s_system_context_menu_item_cut | — | Deep-demo emits positional after named. | script |
| **C6 — Script timeout (infinite work)** | hardly_4/widgets/automatic_keep_alive_client_mixin | — | Test wedges build endpoint for 25 s; needs throttled or deterministic test loop. | script |
| **C7 — Transport failure on huge bundle** | secondary/dart_ui/string_attribute | — | 968 KB bundle exceeds local HTTP read window. | infra (script size *or* runner timeout) |
| **C8 — Layout-overflow / infinite-size warnings** | — | 16 scripts, ~63 framework errors | Deep-demo content overflows the test viewport. Cosmetic; suppressible by scoping the demo to a `MediaQuery`/`SizedBox` of a fixed size. | script |
| **C9 — Missing bridge member** | — | hardly_2/material/theme_extension (`surfaceTint`) | Bridge for `ThemeExtension` does not expose `surfaceTint`. | bridge generator |
| **C10 — Null-aware regression** | — | hardly_5/widgets/route_transition_record (`withValues` on null) | Script invokes `Color.withValues` without null check; could be a generator omission of the `?.` callsite or simply a script bug. | script (likely) |

---

## Metric Rollup

- Total `[METRIC]` lines: ~2200 across the 14 result.json files.
- Slowest single build (`secondary_classes_test`): `12787 ms total` (`widgets/inherited_theme_test.dart`-class scripts in the 1.4–1.5 MB bundle range).
- Largest bundles (deep-demo scripts):
  - `widgets/widget_state_test.dart` — 1.83 MB JSON
  - `widgets/widget_state_mapper_test.dart` — 1.61 MB JSON
  - `widgets/inherited_notifier_test.dart` — 1.55 MB JSON
  - `widgets/weak_map_test.dart` — 1.51 MB JSON
  - `widgets/gesture_detector_adv_test.dart` — 1.47 MB JSON
- All bundle transfers succeeded with `httpStatus=200` except `dart_ui/string_attribute_test.dart` (transport failure on 968 KB bundle).

---

## Comparison vs `20260503-0948-issue-analysis`

Same revision (`eadebb6…`), same script set, same numbers per file. No regressions, no fixes between the two runs — this is a confirmation pass before resuming the priority-1 InterpretedInstance coercion task.

| Suite | 0948 fail | 2009 fail | Δ |
|-------|----------:|----------:|---|
| essential | 1 | 1 | 0 |
| secondary | 1 | 1 | 0 |
| hardly_1 | 1 | 1 | 0 |
| hardly_3 | 2 | 2 | 0 |
| hardly_4 | 2 | 2 | 0 |
| hardly_5 | 1 | 1 | 0 |
| gii | 1 | 1 | 0 |

---

## Suggested Next Steps

1. **Resume cluster C2** (priority-1 InterpretedInstance coercion). Investigate the proxy/relaxer pipeline in `tom_d4rt_generator/lib/src/{proxy,relaxer}_generator.dart` for unwrapping interpreted subclasses of bridged abstracts whose surface includes a `Listenable` / `PreferredSizeWidget` typed parameter. Mirror any fix in `tom_d4rt` ↔ `tom_d4rt_ast`.
2. **Cluster C3 (codec unwrapping)** — fix the `StandardMessageCodec` bridge handler (or the generator's argument-coercion emit for `Object`-typed codec args) so `BridgedInstance<Object>` is unwrapped before the native encode call.
3. **Cluster C9 (`surfaceTint`)** — investigate why the `ThemeExtension` bridge does not expose `surfaceTint`. Possibly a `import show/hide` mismatch in `buildkit.yaml`.
4. **Script-only fixes (C1, C4, C5)** — straightforward deep-demo rewrites; safe to ship script-by-script with individual retests.
5. **Defer C6, C7, C8, C10** — out of scope for the current bridge/interpreter campaign; track in `interpreter_unfixable.md` or a script-cleanup follow-up.
