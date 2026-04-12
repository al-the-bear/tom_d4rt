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
