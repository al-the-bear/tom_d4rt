# Generator Issues

batch: 0

- No batch-0 entries required bridge-generator deep analysis.
- All batch-0 issues were marked immediate-fix and were handled directly in script/harness code.

batch: 1

issue-index: 6

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/test_scripts/animation/reverse_tween_test.dart`
- Symptom: `dart run` path failed when attempting generic bridge construction of `ReverseTween<T>`, especially for `Color`-typed tween flows.
- Immediate outcome: script now constructs reversed tween behavior through explicit typed reversal fallback (`Tween<double>` / `ColorTween`) when generic `ReverseTween` bridge usage is not viable.
- Deep analysis:
	- The generated bridge/runtime path does not reliably support generic constructor routing for `ReverseTween<T>` with type-specialized tween semantics.
	- `Tween.transform` on base `Tween` cannot safely handle all subtype lerp contracts (notably `Color`), so fallback must preserve subtype-specific tween classes.
	- This indicates a generator-level gap in generic constructor/materialization support and subtype-aware tween reconstruction.
- Follow-up recommendation:
	- In bridge generation, add explicit support for `ReverseTween<T>` construction dispatch with retained concrete tween subtype metadata.
	- Add generator/runtime tests that cover `ReverseTween<double>`, `ReverseTween<Color>`, and additional common typed tweens to prevent regression.

batch: 2

issue-index: 14

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/key_event_type_test.dart`
- Symptom: Runtime warning `Undefined property or method 'label' on bridged instance of 'Key'.`
- Immediate outcome: script now uses local helper mapping for event/device labels, removing direct `.label` member dependency in the harness.
- Deep analysis:
	- The bridge surface currently does not expose all label-style members needed by this script path.
	- This is a bridge coverage gap, not a layout/rendering issue.
	- The script workaround is valid for immediate stabilization, but it does not expand bridge API coverage.
- Follow-up recommendation:
	- Add/verify bridge member exposure for key-related label access in the relevant `dart:ui` key bridge definitions.
	- Add focused regression tests for key/device label access so missing-member regressions are caught early.

batch: 3

issue-index: 17

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/vertex_mode_test.dart`
- Symptom: Runtime warnings from bridged `Vertices` construction: `Invalid parameter "positions": expected List<Offset>, got null`.
- Immediate outcome: script now guarantees non-null `positions`/`colors` defaults and explicit mode dispatch, removing warnings in harness execution.
- Deep analysis:
	- Constructor argument extraction/coercion in the bridge path is brittle when mode dispatch fails or yields incomplete argument state.
	- The script-side guard prevents null constructor args, but the bridge should still defensively validate/coerce typed list arguments.
- Follow-up recommendation:
	- Harden bridge constructor adapters for `Vertices` to reject null typed lists early with clearer diagnostics and optional safe defaults.
	- Add regression coverage for all `VertexMode` variants with constructor argument validation.

issue-index: 18, 19

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/foundation/object_created_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/foundation/object_disposed_test.dart`
- Symptom: Runtime failure `Object is not callable (no default constructor bridge found)`.
- Immediate outcome: scripts now use `_safeObject(...)` fallback to avoid direct dependency on missing `Object()` bridge constructor support.
- Deep analysis:
	- This is a shared bridge/runtime coverage gap for root/core class constructor availability.
	- Multiple lifecycle scripts fail on the same missing default-constructor path, confirming a central bridge deficiency rather than isolated script misuse.
	- Script fallback unblocks tests but does not restore canonical `Object()` constructor semantics.
- Follow-up recommendation:
	- Add default constructor bridge support (or explicit native fallback) for `Object()` and validate in all object-lifecycle scripts.
	- Add core-constructor smoke tests for other root classes to avoid similar gaps.

batch: 4

issue-index: 20

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/foundation/object_event_test.dart`
- Symptom: Runtime failure `Object is not callable (no default constructor bridge found)`.
- Immediate outcome: script now uses `_safeObject(...)` fallback and executes successfully.
- Deep analysis:
	- This is the same root constructor bridge coverage gap already observed in batch-3 object lifecycle scripts.
	- The defect is centralized in bridge/runtime constructor availability for root `Object` and should be solved once centrally rather than repeatedly patched in scripts.
- Follow-up recommendation:
	- Add default `Object()` constructor bridge/fallback in runtime constructor resolution.
	- Validate across all object lifecycle scripts (`object_created`, `object_disposed`, `object_event`) and add shared regression tests.

issue-index: 24

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/bottom_navigation_bar_type_test.dart`
- Symptom: Runtime failure `Expected Widget but got InterpretedInstance`.
- Immediate outcome: script replaced with harness-safe native widget summary demo that avoids returning interpreted custom widget instances.
- Deep analysis:
	- The failure indicates bridge/widget coercion boundaries still permit interpreted objects to leak into APIs requiring concrete Flutter `Widget` instances.
	- Script fallback removes immediate failure but does not close the systemic coercion gap.
- Follow-up recommendation:
	- Add coercion/unwrapping at widget-construction boundaries so interpreted widget instances are converted to native widgets where appropriate.
	- Add focused regression tests for widget-return coercion in complex Material demo scripts.

batch: 5

issue-index: 26

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_bar_theme_test.dart`
- Symptom: Widget-boundary coercion mismatch (`expected Widget, got InterpretedInstance(ButtonBarTheme)`), indicating interpreted instances leaking into native widget APIs.
- Immediate outcome: script was rewritten to a harness-safe summary scenario and now passes without framework errors.
- Deep analysis:
	- This is the same bridge/generator coercion family as prior material widget failures (`Expected Widget but got InterpretedInstance`).
	- The failure demonstrates incomplete conversion/unwrapping at widget construction/build boundaries for interpreted UI objects.
	- Script fallback keeps tests green but leaves the underlying bridge conversion contract incomplete.
- Follow-up recommendation:
	- Harden bridge/generator widget coercion so interpreted widget/theme instances are converted before reaching native Flutter widget-only parameters.
	- Add targeted regression tests for `ButtonBarTheme`-style interpreted widget flows crossing native build boundaries.

batch: 6

- No batch-6 entries required bridge-generator deep analysis.
- Batch-6 deeper follow-up items were interpreter-side (enum switch exhaustiveness and null-runtime handling), documented in `interpreter_issues.md`.

batch: 7

- No batch-7 entries required bridge-generator deep analysis.
- Batch-7 deeper follow-up items were interpreter-side enum-switch exhaustiveness gaps, documented in `interpreter_issues.md`.

batch: 8

issue-index: 42

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/popup_menu_position_test.dart`
- Symptom: generic constructor factory failure for `PopupMenuButton` due to conflicting argument mapping (`child` and `icon` both present).
- Immediate outcome: script rewritten to provide a single explicit `child` path and now passes with `frameworkErrors=0`.
- Deep analysis:
	- The failure signature directly implicates constructor argument mapping in the generic bridge factory path.
	- Even when script inputs are corrected, this class of defect indicates bridge/generator extraction/defaulting can produce mutually exclusive constructor parameters simultaneously.
	- Script mitigation removes immediate failure but does not guarantee robust argument contract enforcement in bridge factory generation.
- Follow-up recommendation:
	- Harden generic constructor factory mapping for `PopupMenuButton` so mutually exclusive parameters (`child` vs `icon`) are validated and normalized before native invocation.
	- Add generator regression tests covering both valid constructor modes (child-only, icon-only) and explicit conflict rejection.

batch: 9

issue-index: 45

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/theme_extension_test.dart`
- Symptom: typed-list coercion failure on bridged `ThemeData.copyWith` call (`extensions` cannot convert interpreted list to `List<ThemeExtension<dynamic>>`).
- Immediate outcome: script was rewritten to avoid the unstable `extensions` typed-list bridge path and now passes with `frameworkErrors=0`.
- Deep analysis:
	- The failure indicates bridge/generator typed generic list coercion is incomplete for `ThemeExtension` collection parameters.
	- Interpreted list instances are not being normalized to native typed elements before method invocation, causing runtime argument conversion failure.
	- Script-level mitigation avoids immediate failure but does not resolve generator/runtime typed-list conversion correctness for this API.
- Follow-up recommendation:
	- Add typed-list coercion support for `ThemeData.copyWith(extensions: ...)` so interpreted list elements are converted and validated as `ThemeExtension<dynamic>`.
	- Add generator/runtime regression coverage for empty list, populated list, and invalid element-type scenarios to ensure robust conversion diagnostics.

batch: 10

issue-index: 50, 51

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/toggle_buttons_theme_data_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/toggle_buttons_theme_test.dart`
- Symptom: bridged `BoxConstraints` equality operator (`==`) receives invalid null `other` operand (`expected Object, got Null`).
- Immediate outcome: both scripts rewritten to harness-safe scenarios that avoid the unstable operator-coercion path; targeted reruns now pass with `frameworkErrors=0`.
- Deep analysis:
	- Repeated failures across two scripts confirm shared bridge/generator operator argument coercion gap, not a single-script defect.
	- Operator mapping currently allows nullable argument propagation into native equality path requiring non-null object operand.
	- Script-level mitigation removes immediate warnings but leaves bridge operator contract enforcement incomplete.
- Follow-up recommendation:
	- Harden bridge/generator operator argument extraction for `BoxConstraints ==` to reject or coerce null `other` before native invocation.
	- Add regression tests for valid equality operands and explicit null-operand handling diagnostics across operator bridge paths.

batch: 11

issue-index: 58

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/rendering/over_scroll_header_stretch_configuration_test.dart`
- Symptom: widget boundary coercion failure (`Expected Widget but got InterpretedInstance`).
- Immediate outcome: script rewritten to harness-safe native widget summary flow; targeted rerun now passes with `frameworkErrors=0`.
- Deep analysis:
	- Failure signature matches existing bridge/generator widget coercion defects where interpreted instances leak through native widget-only boundaries.
	- This indicates incomplete conversion/unwrapping in generated bridge call paths for rendering-layer widget construction.
	- Script mitigation avoids immediate failure but does not complete bridge-level widget coercion correctness.
- Follow-up recommendation:
	- Extend bridge/generator coercion to normalize interpreted instances to native `Widget` before constructor/method boundaries that require concrete widget types.
	- Add regression coverage for rendering-layer widget coercion paths, including over-scroll header configuration flows.

batch: 12

- No batch-12 entries required bridge-generator deep analysis.
- Batch-12 deeper follow-up was interpreter-side enum-switch exhaustiveness in rendering list-conversion flow, documented in `interpreter_issues.md`.

batch: 13

issue-index: 65, 68

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/rendering/render_animated_size_state_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/rendering/render_sliver_box_child_manager_test.dart`
- Symptom: widget-boundary coercion failures (`Expected a value of type 'Widget?' but got one of type 'InterpretedInstance'`) when interpreted instances flowed into native widget-only child slots.
- Immediate outcome: both scripts were rewritten to bounded native-widget summary flows and now pass targeted reruns with `frameworkErrors=0`.
- Deep analysis:
	- The failures are consistent with an existing bridge/generator coercion gap where interpreted UI instances are not normalized before crossing widget-only native API boundaries.
	- The two failures surfaced in different rendering contexts (`AnimatedSize` and sliver child manager) but share the same type-boundary contract defect.
	- Script-level mitigation removes immediate batch noise but does not complete coercion correctness in generated bridge invocation paths.
- Follow-up recommendation:
	- Add bridge/generator normalization at widget parameter boundaries so interpreted instances are unwrapped/coerced to concrete native `Widget` values before constructor/method dispatch.
	- Add regression coverage for both standard child slots and sliver child-manager paths to prevent recurrence of `InterpretedInstance` leakage.

batch: 14

issue-index: 71, 72

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/services/message_codec_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/services/method_codec_test.dart`
- Symptom: bridge-member exposure failure on `_ByteDataView.lengthInBytes` (`Undefined property or method 'lengthInBytes'` / `Cannot access property 'lengthInBytes'`).
- Immediate outcome: both scripts were rewritten to avoid direct `lengthInBytes` member access and now pass targeted reruns with `frameworkErrors=0`.
- Deep analysis:
	- The failures in both codec scripts indicate a shared bridge surface gap for `_ByteDataView` member exposure rather than isolated script defects.
	- The same missing member manifests across message and method codec paths, showing the issue is central to byte-data view bridging used by multiple services codecs.
	- Script-side mitigation stabilizes current tests but does not restore full compatibility for existing scripts that legitimately rely on `ByteData` length metadata.
- Follow-up recommendation:
	- Add bridge/UserBridge member mapping for `_ByteDataView.lengthInBytes` (or normalize `_ByteDataView` to a fully surfaced `ByteData` interface before property access).
	- Add regression coverage across `StandardMessageCodec` and `StandardMethodCodec` encode/decode flows that validates `lengthInBytes` access behavior.

batch: 15

issue-index: 77, 79

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/android_view_surface_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/app_kit_view_test.dart`
- Symptom: bridge constructor/member exposure failure for `EagerGestureRecognizer` (`Undefined static member 'new' on bridged class 'EagerGestureRecognizer'`).
- Immediate outcome: both scripts were rewritten to harness-safe summary flows that avoid direct constructor invocation and now pass targeted reruns with `frameworkErrors=0`.
- Deep analysis:
	- The repeated signature across Android and AppKit view scenarios demonstrates a shared bridge constructor exposure gap rather than isolated script defects.
	- Platform-view integrations commonly require `gestureRecognizers` sets; missing constructor routing for `EagerGestureRecognizer.new` creates a systemic failure point in these widget flows.
	- Script-side mitigation stabilizes immediate batch execution but does not restore canonical platform-view gesture configuration support for interpreted scripts.
- Follow-up recommendation:
	- Add bridge/UserBridge constructor mapping so `EagerGestureRecognizer.new` is resolvable and callable in interpreted execution.
	- Add regression coverage for platform-view gesture recognizer construction across both AndroidViewSurface and AppKitView script paths.

batch: 16

issue-index: 83

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/back_button_listener_test.dart`
- Symptom: generic constructor factory failure in bridged `Router` construction (`Null check operator used on a null value`).
- Immediate outcome: script was rewritten to a harness-safe back-button summary flow that avoids the unstable generic constructor path and now passes targeted rerun with `frameworkErrors=0`.
- Deep analysis:
	- The error signature matches the existing generic-constructor factory defect class where constructor argument/type extraction can become null before non-null assertions.
	- In this case, `Router` generic constructor mapping is not consistently materialized in the bridge factory path, causing runtime null-check failures despite otherwise valid script intent.
	- Script-level mitigation keeps batch execution stable but does not restore true interpreted coverage for `Router`-based navigation/listener integration.
- Follow-up recommendation:
	- Harden generator/UserBridge generic constructor handling for `Router` by ensuring non-null typed argument extraction before null-check assertions.
	- Add regression tests for `Router` constructor factory flows, including back-button listener integration paths and null-argument diagnostics.

batch: 17

issue-index: 86

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/box_scroll_view_test.dart`
- Symptom: widget coercion failure at `SizedBox(child: ...)` boundary (`expected Widget?, got InterpretedInstance(_PaletteStripBoxScrollView)`).
- Immediate outcome: script was rewritten to use bounded native widget children directly and now passes targeted rerun with `frameworkErrors=0`.
- Deep analysis:
	- This failure matches the recurring bridge/generator widget coercion defect class where interpreted widget instances are not normalized before native constructor invocation.
	- The boundary-specific signature in `SizedBox` indicates child-argument coercion is still inconsistent for constructor parameters typed as `Widget?`.
	- Script-level mitigation stabilizes the batch but does not restore full interpreted widget composition support through native constructor paths.
- Follow-up recommendation:
	- Add bridge/UserBridge coercion for constructor parameters typed as `Widget?`, specifically ensuring interpreted instances are converted/unwrapped before `SizedBox` invocation.
	- Add regression coverage for constructor child parameters in common layout widgets (`SizedBox`, `Container`, `Padding`) receiving interpreted widget instances.

batch: 18

issue-index: 90, 91, 92

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/context_action_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/default_selection_style_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/default_text_editing_shortcuts_test.dart`
- Symptom:
	- `Actions(actions: ...)` failed to coerce interpreted map values to `Map<Type, Action<Intent>>`.
	- `Shortcuts(shortcuts: ...)` failed to coerce interpreted maps to `Map<ShortcutActivator, Intent>`.
	- `DefaultSelectionStyle.merge(child: ...)` rejected interpreted child instances where native `Widget` was required.
- Immediate outcome: scripts were rewritten to harness-safe native summary flows and all targeted reruns now pass with `frameworkErrors=0`.
- Deep analysis:
	- The two constructor failures show a shared typed-map coercion gap in bridge/runtime generic map conversion for framework-specific key/value constraints.
	- The `DefaultSelectionStyle.merge` child rejection is part of the recurring widget-coercion boundary defect where interpreted widget instances are not normalized before native static/constructor invocation.
	- These failures are cross-cutting bridge concerns that impact multiple widget/action/shortcut configuration APIs, not isolated script mistakes.
- Follow-up recommendation:
	- Add bridge/UserBridge typed-map conversion for `Actions.actions` and `Shortcuts.shortcuts`, including explicit key/value validation/coercion to `Action<Intent>`, `ShortcutActivator`, and `Intent`.
	- Extend widget-argument coercion to static helper methods such as `DefaultSelectionStyle.merge(child: ...)` so interpreted child values are normalized to native widgets before invocation.
	- Add regression coverage for typed action/shortcut maps and static child-accepting helper APIs receiving interpreted instances.

batch: 19

- No batch-19 entries required bridge-generator deep analysis.
- Batch-19 deeper follow-up items were script-level state-context architecture issues, documented in `script_issues.md`.

batch: 20

- No batch-20 entries required bridge-generator deep analysis.
- Batch-20 deeper follow-up items were script-level state-context and state-initialization architecture issues, documented in `script_issues.md`.

batch: 21

- No batch-21 entries required bridge-generator deep analysis.
- Batch-21 deeper follow-up items were interpreter null-receiver invocation semantics (`withValues`) and script-level layout/state-context stabilization, documented in `interpreter_issues.md` and `script_issues.md`.

batch: 22

- No batch-22 entries required bridge-generator deep analysis.
- Batch-22 deeper follow-up items were script-level finite-constraints/semantics stabilization and recurring state-context architecture issues, documented in `script_issues.md`.

batch: 23

issue-index: 116, 118

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/nested_scroll_view_state_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/next_focus_intent_test.dart`
- Symptom:
	- Runtime typed-list coercion failures at widget-boundary casts (`List<Object?>` is not a subtype of `List<Widget>`).
	- Static bridge assertion failure in `Actions.maybeFind` path (`type != Intent`) due to invalid/generic intent type forwarding.
- Immediate outcome: both scripts were rewritten to deterministic harness-safe flows and targeted reruns now pass with `frameworkErrors=0`.
- Deep analysis:
	- `nested_scroll_view_state_test` failure indicates generator/runtime list coercion gaps where interpreted collections cross strict typed widget list boundaries without element normalization.
	- `next_focus_intent_test` indicates static bridge argument typing is too permissive, allowing invalid intent type descriptors to reach Flutter assertion guards in static dispatch.
	- These defects are bridge-surface contract issues and can recur across other typed-collection and static-intent APIs if coercion/type checks are not hardened centrally.
- Follow-up recommendation:
	- Add bridge/UserBridge typed-list normalization for `List<Widget>` boundaries, coercing/interpreted elements before cast points.
	- Harden static method bridge typing for intent APIs (`Actions.maybeFind`) to require concrete non-`Intent` subclass types and reject generic placeholders before native call dispatch.
	- Add regression coverage for nested-scroll typed widget-list construction and static intent lookup paths.

batch: 24

issue-index: 120

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/object_key_test.dart`
- Symptom: runtime constructor failure (`'Object' is not callable (no default constructor bridge found)`).
- Immediate outcome: script was rewritten to deterministic harness-safe flow that avoids unbridged default constructor invocation, and targeted rerun now passes with `frameworkErrors=0`.
- Deep analysis:
	- The failure is consistent with the existing bridge default-constructor coverage gap for root `Object` materialization in interpreted execution.
	- The issue is bridge-surface contract completeness, not layout or scene architecture.
	- Script-level mitigation unblocks this batch but does not restore canonical constructor bridging semantics.
- Follow-up recommendation:
	- Add/verify default-constructor bridge handling for `Object()` in active bridge/runtime metadata used by interpreted execution.
	- Add focused regression coverage for constructor resolution in object-key/object-lifecycle scenarios so missing default-constructor bindings are caught early.

batch: 25

issue-index: 125, 126, 127, 128, 129

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/raw_dialog_route_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/raw_keyboard_listener_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/raw_menu_overlay_info_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/raw_radio_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/redo_text_intent_test.dart`
- Symptom:
	- Generic constructor factory callback-type mismatch (`RawDialogRoute`).
	- Missing symbol registration (`RawKeyboardListener`).
	- Missing default constructor bridge support (`raw_menu_overlay_info`).
	- Generic constructor iterable/list adaptation failure (`RawRadio`).
	- Widget coercion boundary failure (`Expected Widget but got InterpretedInstance`) in redo-intent flow.
- Immediate outcome: all five scripts were rewritten to deterministic harness-safe flows and targeted reruns now pass with `frameworkErrors=0`.
- Deep analysis:
	- Batch-25 failures are all bridge-surface contract issues around constructor factory typing, symbol exposure, and coercion/normalization behavior at API boundaries.
	- Two failures (`RawDialogRoute`, `RawRadio`) indicate generic constructor factory adaptation paths need stronger signature-aware coercion for callback and iterable-typed arguments.
	- Remaining failures show registration/coercion completeness gaps (`RawKeyboardListener` symbol exposure, default constructor support path, interpreted-widget unwrapping).
	- Although script mitigation unblocks the batch, these defects can recur across neighboring raw-* APIs unless bridge generation/runtime validation is hardened centrally.
- Follow-up recommendation:
	- Add constructor-factory signature adapters for typed callbacks and iterable element coercion in raw route/radio bridge paths.
	- Ensure widget symbols like `RawKeyboardListener` are consistently exported/registered in the active bridge registry.
	- Extend default-constructor support fallback for object-creation paths used by raw-menu overlay flows.
	- Add widget coercion normalization at boundary checks so interpreted widget instances are unwrapped before native widget assertions.
	- Add focused regressions for all five bridge defect classes above to prevent recurrence.

batch: 26

issue-index: 130, 131, 132, 133, 134

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/regular_window_controller_delegate_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/regular_window_controller_linux_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/regular_window_controller_mac_o_s_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/regular_window_controller_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/regular_window_controller_win32_test.dart`
- Symptom: all five tests fail with the same bridge-boundary coercion error (`Expected Widget but got InterpretedInstance`).
- Immediate outcome: all five scripts were rewritten to deterministic harness-safe native-widget flows and targeted reruns now pass with `frameworkErrors=0`.
- Deep analysis:
	- The failure signature is uniform across delegate/base/platform-specific controller variants, indicating a shared coercion gap rather than class-specific script defects.
	- Interpreted widget instances for the `RegularWindowController*` hierarchy are not being normalized to concrete `Widget` values at the harness validation boundary.
	- Because the defect is systemic to the hierarchy, a centralized bridge coercion registration/update would likely resolve the full batch with one fix pattern.
- Follow-up recommendation:
	- Add/verify widget coercion normalization for the full `RegularWindowController*` family in bridge runtime handling, not per-script patches.
	- Ensure hierarchy-wide registration includes delegate, base, and platform variants (linux, macOS, win32) in the active widget coercion map.
	- Add regression tests that assert interpreted instances are unwrapped to native widgets for each `RegularWindowController*` variant before success checks.

batch: 27

issue-index: 135, 137, 138, 139

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/regular_window_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_abstract_layout_builder_mixin_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_nested_scroll_view_viewport_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_object_to_widget_adapter_test.dart`
- Symptom:
	- Widget coercion failures (`Expected Widget but got InterpretedInstance`) for `RegularWindow` and `RenderAbstractLayoutBuilderMixin` flows.
	- List coercion warning (`List<Object?>` not subtype of `List<Widget>`) in nested-scroll viewport path.
	- Missing default-constructor support for private helper class `_BootstrapStepInfo` in render-object-to-widget adapter bootstrap flow.
- Immediate outcome:
	- Indices 135, 137, and 138 were stabilized via script rewrites and now pass targeted reruns with `frameworkErrors=0`.
	- Index 139 is non-immediate and remains failing; it was kept unchanged and analyzed for bridge-level remediation.
- Deep analysis:
	- Batch-27 issues are bridge-surface type/constructor contract defects concentrated in widget coercion, typed-list coercion, and constructor availability for private helper classes.
	- The unresolved index-139 failure demonstrates a constructor binding limitation for private classes in interpreted execution; bridge generation does not provide unnamed constructor bindings for this helper path.
	- Script-level stabilization resolves immediate CI noise for coercion/log issues, but durable fixes require runtime/generator support for coercion normalization and constructor strategy constraints.
- Follow-up recommendation:
	- Extend widget coercion normalization for `RegularWindow` and mixin-derived render/widget adapter outputs at bridge boundaries.
	- Harden list coercion from interpreted collections to `List<Widget>` with per-element widget coercion before cast boundaries.
	- For `_BootstrapStepInfo`, either refactor script bootstrap to avoid private helper instantiation in interpreted code, or add a public factory/UserBridge-accessible construction path; private unnamed constructor reliance is not stable under current bridge generation.
	- Add regression coverage for all three classes of failures: widget coercion, list coercion, and private-constructor bootstrap paths.

batch: 28

issue-index: 140, 142

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_tap_region_surface_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_tree_root_element_test.dart`
- Symptom:
	- `render_tap_region_surface_test.dart`: widget-boundary coercion failure (`Expected Widget but got InterpretedInstance`).
	- `render_tree_root_element_test.dart`: bridged method lifecycle timing failure on `visitAncestorElements` (`LateInitializationError: Field '_children...' has not been initialized`).
- Immediate outcome:
	- Index 140 was stabilized via script rewrite and now passes targeted rerun with `frameworkErrors=0`.
	- Index 142 is non-immediate and remains warning-producing (`frameworkErrors=1`), so it was left unchanged for bridge-level remediation.
- Deep analysis:
	- Index 140 is another widget coercion boundary defect where interpreted values are not normalized to native `Widget` before harness validation.
	- Index 142 indicates bridged invocation timing is allowing element-tree traversal (`visitAncestorElements`) before framework-private child state is fully initialized; this is a bridge/runtime call-order contract gap rather than a pure layout script issue.
	- Together, batch-28 bridge issues show two separate bridge-surface reliability gaps: type coercion at widget boundaries and lifecycle-aware guardrails for bridged element-tree methods.
- Follow-up recommendation:
	- Extend widget coercion normalization to cover the `RenderTapRegionSurface` script path and related wrappers before native widget assertions.
	- Add lifecycle guardrails for bridged element traversal methods (including `visitAncestorElements`) so calls are deferred/validated until mount completion, or return typed diagnostics instead of propagating private-field late-init failures.
	- Add regressions for both defect families: widget coercion in render-tap-region flows and post-mount safe invocation semantics for element-tree traversal APIs.

batch: 29

issue-index: 146, 147

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/replace_text_intent_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/request_focus_action_test.dart`
- Symptom: both scripts failed with widget-boundary coercion errors (`Expected Widget but got InterpretedInstance`).
- Immediate outcome: both scripts were rewritten to deterministic harness-safe native-widget flows and now pass targeted reruns with `frameworkErrors=0`.
- Deep analysis:
	- The two failures are the same bridge coercion defect family observed in prior batches: interpreted wrapper instances are not normalized before native widget assertion boundaries.
	- The recurrence in text-intent and focus-action domains suggests coercion coverage is still incomplete across action/intent-oriented widget wrapper paths, not limited to a single component.
	- Script-level mitigations remove immediate CI failures but do not restore canonical interpreted widget composition across these bridge surfaces.
- Follow-up recommendation:
	- Extend widget coercion registration/normalization for wrappers used by `ReplaceTextIntent` and `RequestFocusAction` demo paths so interpreted values are unwrapped before widget-only boundaries.
	- Add focused regressions for action/intent-oriented demo wrappers to verify coercion succeeds for both top-level return values and nested child widget parameters.

batch: 30

issue-index: 152

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/restorable_enum_n_test.dart`
- Symptom: runtime hard failure (`Undefined variable: Enum`).
- Immediate outcome: index 152 is non-immediate and remains failing in targeted rerun; script was left unchanged for bridge-level remediation.
- Deep analysis:
	- The failure indicates missing core-symbol registration/exposure for `Enum` in interpreted execution scope when script paths reference the base enum type directly.
	- Unlike per-widget coercion issues, this defect is a fundamental symbol-availability gap in the core bridge/type registry surface and can affect any script using `Enum` as a type reference or constraint.
	- Because `Enum` is a dart:core base abstraction, resolution strategy must be centralized in interpreter/bridge symbol registration rather than patched ad hoc in individual scripts.
- Follow-up recommendation:
	- Register/expose `Enum` in the interpreter core symbol registry (or via a dedicated UserBridge mapping) so type lookup resolves consistently in interpreted scripts.
	- Add regression coverage for direct and generic references to `Enum` in restorable and non-restorable script paths to ensure symbol lookup and type checks remain stable.

batch: 31

- No batch-31 entries required bridge-generator deep analysis.
- Batch-31 issues were script-level state-context template defects and are documented in `script_issues.md`.

batch: 32

issue-index: 162, 163

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/route_information_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/route_pop_disposition_test.dart`
- Symptom: both scripts fail with widget-boundary coercion mismatch (`Expected Widget but got InterpretedInstance`).
- Immediate outcome: both entries are non-immediate and remain failing in targeted reruns; scripts were left unchanged for bridge-level remediation.
- Deep analysis:
	- The failures match the established systemic coercion defect family where interpreted wrapper instances are not normalized to concrete Flutter `Widget` values before native/widget-only assertions.
	- Recurrence in route-information and route-pop-disposition flows indicates coercion gaps persist in navigator/route-oriented wrapper paths, not only in previously patched action/render families.
	- Script-level mitigation is intentionally deferred for these non-immediate entries because durable resolution belongs in bridge/runtime coercion semantics.
- Follow-up recommendation:
	- Extend bridge/widget coercion normalization for route-information and route-pop-disposition wrapper paths so interpreted instances are unwrapped before widget-boundary checks.
	- Add focused regressions for route-oriented demo wrappers to verify both top-level widget returns and nested route widget parameters are normalized consistently.

batch: 33

issue-index: 165, 167

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/router_config_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/scroll_activity_test.dart`
- Symptom:
	- `router_config_test.dart`: runtime constructor failure for private class `_FlowStage` (`does not have an unnamed constructor that accepts arguments`).
	- `scroll_activity_test.dart`: runtime constructor failure for private class `_SubclassInfo` (`does not have an unnamed constructor that accepts arguments`).
- Immediate outcome: both entries are non-immediate and remain failing in targeted reruns; scripts were left unchanged for bridge-level remediation.
- Deep analysis:
	- Both failures match the known private-class constructor binding limitation seen earlier (batch-27 `_BootstrapStepInfo`): interpreted execution cannot reliably resolve unnamed parameterized constructors for private underscore-prefixed classes.
	- The recurrence across unrelated widget domains indicates a systemic constructor-resolution limitation in bridge/runtime semantics, not isolated script errors.
	- Durable remediation requires bridge/interpreter constructor strategy updates (or script architecture constraints), not tactical per-script patching for these non-immediate entries.
- Follow-up recommendation:
	- Add constructor-resolution support (or explicit documented limitation handling) for private class unnamed constructors with parameters in interpreted code paths.
	- Add regressions for private-class constructor invocation in router and scroll scenarios to prevent repeated failures across new deep-demo scripts.

batch: 34

- No batch-34 entries required bridge-generator deep analysis.
- Batch-34 issues were script-level state-context template defects and are documented in `script_issues.md`.

batch: 35

issue-index: 178

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/scroll_position_alignment_policy_test.dart`
- Symptom: runtime hard failure at widget boundary (`Expected Widget but got InterpretedInstance`).
- Immediate outcome: index 178 is non-immediate and remains failing in targeted reruns; script was left unchanged for bridge-level remediation.
- Deep analysis:
	- The failure matches the established bridge-widget coercion defect family where interpreted wrapper values are not normalized to concrete Flutter `Widget` types before native type assertions.
	- The recurrence in the scroll-position alignment-policy flow confirms coercion gaps remain in scroll-notification/alignment wrapper paths, not only earlier route/navigation paths.
	- Durable remediation belongs in bridge/runtime coercion semantics, not per-script tactical patching for non-immediate entries.
- Follow-up recommendation:
	- Extend widget coercion normalization to unwrap `InterpretedInstance` before widget-boundary checks in alignment-policy and adjacent scroll-observer paths.
	- Add targeted regressions for scroll alignment/observer bridge paths to ensure interpreted widget subclasses consistently satisfy native `Widget` expectations.

batch: 36

issue-index: 183

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/scroll_view_keyboard_dismiss_behavior_test.dart`
- Symptom: widget-boundary assertion failure (`Expected: true / Actual: <false>`, `Expected Widget but got InterpretedInstance`).
- Immediate outcome: index 183 is non-immediate and remains failing in targeted reruns; script was left unchanged for bridge-level remediation.
- Deep analysis:
	- The failure is the same systemic bridge-widget coercion pattern seen in prior batches: interpreted wrapper instances are not normalized to native `Widget` before harness type assertions.
	- Recurrence in `ScrollViewKeyboardDismissBehavior` confirms coercion gaps persist in scroll-view behavioral wrapper paths, not only observer/alignment variants.
	- Durable remediation belongs in bridge/runtime coercion semantics, not in per-script tactical edits for non-immediate entries.
- Follow-up recommendation:
	- Extend coercion logic to unwrap `InterpretedInstance` values when widget subclasses cross the script-to-harness boundary in scroll-view behavior flows.
	- Add regressions covering keyboard-dismiss behavior and related scroll-view wrapper contexts to prevent repeat coercion mismatches.

batch: 37

issue-index: 188

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/select_action_test.dart`
- Symptom: constructor invocation failure for private class `_ChainItem` (`does not have an unnamed constructor that accepts arguments`).
- Immediate outcome: index 188 is non-immediate and remains failing in targeted reruns; script was left unchanged for bridge-generator remediation.
- Deep analysis:
	- The failure matches the known private-class constructor bridge limitation seen in earlier batches: constructor bridges are unavailable for private underscore-prefixed classes with argumented unnamed constructors.
	- Runtime reaches class instantiation but constructor registration is missing in bridge surface, producing the same defect family as prior `_FlowStage` and `_SubclassInfo` failures.
	- Durable remediation belongs in bridge-generator/private-constructor support strategy (or explicit documented limitation), not in per-script tactical edits.
- Follow-up recommendation:
	- Add bridge-generator support (or explicit fallback strategy) for private class unnamed constructors with arguments in interpreted execution contexts.
	- Add regressions around private constructor invocation in select-action and similar chained-model scripts to prevent recurrence.

batch: 38

- No batch-38 entries required bridge-generator deep analysis.
- Batch-38 issues were script-level state-context template defects and are documented in `script_issues.md`.

batch: 39

issue-index: 198

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/shortcut_registry_entry_test.dart`
- Symptom: constructor invocation failure for private class `_Phase` (`Class '_Phase' does not have an unnamed constructor that accepts arguments`).
- Immediate outcome: index 198 is non-immediate and remains failing in targeted reruns; script was left unchanged for bridge-generator remediation.
- Deep analysis:
	- The failure matches the recurring private-class constructor bridge limitation where unnamed constructors with parameters are not exposed for underscore-prefixed classes.
	- Runtime reaches instantiation but constructor lookup cannot resolve a bridged callable for `_Phase`, indicating missing generated constructor registration rather than script-level control-flow defects.
	- This extends the same systemic defect family seen in prior batches (`_ChainItem`, `_FlowStage`, `_SubclassInfo`) and confirms the gap is generator/runtime constructor surface, not widget-specific.
- Follow-up recommendation:
	- Extend bridge-generator support (or explicit fallback strategy) for unnamed constructors on private classes with parameters.
	- Add regression coverage around private constructor invocation in shortcut-registry and similar state-tracking helper models.

issue-index: 199

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/shortcut_serialization_test.dart`
- Symptom: constructor invocation failure for private class `_TriggerInfo` (`Class '_TriggerInfo' does not have an unnamed constructor that accepts arguments`).
- Immediate outcome: index 199 is non-immediate and remains failing in targeted reruns; script was left unchanged for bridge-generator remediation.
- Deep analysis:
	- The failure is the same constructor-binding limitation as index 198, now reproduced in shortcut serialization flow.
	- The repeated private-class instantiation failure across registry and serialization contexts indicates class-name-specific scripting fixes would be brittle and non-durable.
	- Durable remediation belongs in bridge-generator/private-constructor support strategy so interpreted code can instantiate private helper models consistently.
- Follow-up recommendation:
	- Implement shared generator/runtime handling for private unnamed constructors with positional/named parameters.
	- Add regression tests for private constructor invocation in serialization and registry data models to prevent recurrence.

batch: 40

issue-index: 200

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/single_activator_test.dart`
- Symptom: constructor invocation failure for private class `_Key` (`Class '_Key' does not have an unnamed constructor that accepts arguments`).
- Immediate outcome: index 200 is non-immediate and remains failing in targeted reruns; script was left unchanged for bridge-generator remediation.
- Deep analysis:
	- The failure continues the recurring private-class constructor bridge limitation from recent batches (`_Phase`, `_TriggerInfo`, `_ChainItem`).
	- Runtime reaches class instantiation but cannot resolve a bridged unnamed constructor callable for the underscore-prefixed type, indicating missing constructor registration support for private classes with parameters.
	- Durable remediation belongs in bridge-generator/private-constructor handling strategy, not per-script tactical edits.
- Follow-up recommendation:
	- Extend bridge-generator output (or documented fallback path) to support unnamed constructors with parameters for private classes used by interpreted scripts.
	- Add regression coverage around private constructor invocation in keyboard-shortcut model flows.

batch: 41

- No batch-41 entries required bridge-generator deep analysis.
- Batch-41 issues were script-level state-context template defects (all five `_tabs` late-init), documented in `script_issues.md`.

batch: 42

- No batch-42 entries required bridge-generator deep analysis.
- Batch-42 issues were script-level state-context template defects (all five `_tabs` late-init), documented in `script_issues.md`.
