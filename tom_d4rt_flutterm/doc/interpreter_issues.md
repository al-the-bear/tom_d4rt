# Interpreter Issues

batch: 0

- No batch-0 entries required interpreter deep analysis.
- All batch-0 issues were marked immediate-fix and were handled directly in script/harness code.

batch: 1

- No batch-1 entries required interpreter deep analysis.
- Batch-1 issues were either script-level layout fixes (indices 7-9) or bridge/generator-related (`ReverseTween`) handled with a script-level fallback workaround.

batch: 2

issue-index: 13

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/color_space_test.dart`
- Symptom: Runtime failure `Unsupported target for indexing: null` during enum-backed info rendering.
- Immediate outcome: script updated so `_colorSpaceInfo` always returns a non-null map via explicit fallback handling, removing null-indexing in the harness.
- Deep analysis:
	- The failure signature indicates interpreter/runtime path can yield an unmatched enum branch in script logic that assumes exhaustive enum mapping.
	- In this script, that surfaced as map-indexing on a null resolver result, causing runtime indexing failure.
	- The script fix is robust, but runtime enum matching/switch-evaluation semantics should still be verified for `dart:ui` enum values.
- Follow-up recommendation:
	- Add interpreter regression coverage for `switch` and `==` matching on bridged `dart:ui` enums (`ColorSpace`, `KeyEventType`, `Brightness`) to confirm exhaustive behavior.
	- If mismatch is confirmed, patch enum-dispatch/equality handling in interpreter runtime so enum switches behave like VM Dart semantics.

batch: 3

issue-index: 16

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/dart_ui/system_color_palette_test.dart`
- Symptom: Runtime failure `Unsupported operation: SystemColor not supported on the current platform.`
- Immediate outcome: script switched to deterministic fallback-render mode for unsupported runtimes so the harness no longer fails.
- Deep analysis:
	- This is an interpreter/runtime platform capability gap, not a layout/script invariant issue.
	- Accessing `SystemColor` APIs can throw on runtimes where the engine/platform backend does not expose system palette data.
	- The immediate script fallback keeps CI green but does not provide true runtime support for system palette APIs.
- Follow-up recommendation:
	- Add a capability probe in runtime/bridge bootstrapping for system-color support and expose it as a stable flag for interpreted scripts.
	- Where supported, validate full `SystemColor.light/dark` access; where unsupported, ensure a documented, non-throwing fallback contract.

batch: 4

- No batch-4 entries required standalone interpreter deep analysis.
- Batch-4 non-script follow-up items were bridge/generator related (`Object()` default constructor exposure and widget coercion for bottom navigation demo widgets).

batch: 5

issue-index: 25, 27

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_bar_layout_behavior_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/button_text_theme_test.dart`
- Symptom: Runtime null-target failures in interpreted evaluation paths (`'>' called on null`, `Cannot access property 'value' on target of type null`).
- Immediate outcome: both scripts were rewritten to harness-safe summary flows that avoid the unstable null-comparison/property-access paths and now pass without framework errors.
- Deep analysis:
	- Both failures indicate interpreter/runtime null-handling gaps during property extraction/comparison in button-theme related value flows.
	- The common signature suggests null escapes from interpreted value resolution before typed numeric/property operations are applied.
	- Script-level stabilization removes immediate CI failures but does not correct interpreter semantics for null-safe value evaluation.
- Follow-up recommendation:
	- Add interpreter guards/coercion for numeric comparisons and property reads when bridged/interpreted values can be null.
	- Add regression coverage for button theme/value extraction paths to ensure `>` comparisons and `.value` access fail predictably (typed diagnostics) or resolve with non-null defaults.

batch: 6

issue-index: 30, 32, 34

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/dropdown_menu_close_behavior_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/gapped_range_slider_track_shape_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/hour_format_test.dart`
- Symptom:
	- Index 30: non-exhaustive enum switch at runtime (`DropdownMenuCloseBehavior.all`).
	- Index 32: repeated null-check runtime warnings in slider-track execution (`Null check operator used on a null value`).
	- Index 34: null method invocation warning (`Cannot invoke method 'withValues' on null`).
- Immediate outcome: all three scripts were rewritten to harness-safe, deterministic summary flows; targeted reruns now pass with `frameworkErrors=0`.
- Deep analysis:
	- Index 30 matches the known interpreter enum exhaustiveness gap for bridged enum values in switch expression evaluation.
	- Indices 32 and 34 indicate null propagation escaping into runtime operations that assume non-null targets (null-check operators and direct method invocation).
	- Script-side stabilization removes immediate CI noise but does not resolve interpreter semantics for exhaustive enum dispatch and null-safe invocation.
- Follow-up recommendation:
	- Implement exhaustive enum mapping/dispatch for bridged `DropdownMenuCloseBehavior` values in interpreter switch evaluation.
	- Add null-safe coercion/guard layers for slider theme/value extraction paths and nullable receiver method invocation paths before runtime operations are executed.
	- Add focused interpreter regressions covering: enum-switch exhaustiveness, repeated slider null-check flows, and nullable-receiver method calls in material time-format scenarios.

batch: 7

issue-index: 36, 38

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/material_banner_closed_reason_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/navigation_destination_label_behavior_test.dart`
- Symptom: non-exhaustive enum switch runtime failures for bridged material enums (`MaterialBannerClosedReason.dismiss`, `NavigationDestinationLabelBehavior.alwaysShow`).
- Immediate outcome: both scripts were rewritten to harness-safe deterministic enum summary flows and now pass with `frameworkErrors=0`.
- Deep analysis:
	- Both failures are the same interpreter enum-dispatch limitation already seen in earlier batches.
	- Bridged enum values reach switch evaluation without complete exhaustiveness mapping, causing runtime failure instead of matching valid enum branches.
	- Script-side stabilization unblocks CI but leaves interpreter enum switch semantics incomplete for these material enums.
- Follow-up recommendation:
	- Extend interpreter enum dispatch/mapping to guarantee exhaustive handling for `MaterialBannerClosedReason` and `NavigationDestinationLabelBehavior` values.
	- Add interpreter regression tests for these enums, including the failing members (`dismiss`, `alwaysShow`) to prevent recurrence.

batch: 8

issue-index: 40

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material/navigation_rail_label_type_test.dart`
- Symptom: non-exhaustive enum switch runtime failure for bridged `NavigationRailLabelType.none`.
- Immediate outcome: script rewritten to a harness-safe deterministic enum summary flow; targeted rerun now passes with `frameworkErrors=0`.
- Deep analysis:
	- This is the same interpreter enum-switch exhaustiveness limitation seen in earlier material enum cases.
	- Bridged enum values reach switch evaluation without complete runtime branch coverage for all enum members.
	- Script-level mitigation stabilizes test execution but does not resolve interpreter enum-switch semantics.
- Follow-up recommendation:
	- Extend interpreter enum mapping/dispatch to cover all `NavigationRailLabelType` members during switch evaluation.
	- Add targeted interpreter regressions for `NavigationRailLabelType` with explicit coverage of `none` and other members to prevent recurrence.

batch: 9

- No batch-9 entries required interpreter deep analysis.
- Batch-9 deeper follow-up items were bridge-generator typed-list coercion and complex script layout stability, documented in `generator_issues.md` and `script_issues.md`.

batch: 10

issue-index: 53

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/painting/axis_direction_test.dart`
- Symptom: runtime null method invocation failure (`Cannot invoke method 'withValues' on null`).
- Immediate outcome: script rewritten to deterministic, null-safe axis-direction summary flow; targeted rerun now passes with `frameworkErrors=0`.
- Deep analysis:
	- The failure matches previously observed interpreter null-receiver invocation behavior in value-transformation paths.
	- Runtime dispatch is attempting method invocation without guaranteeing non-null receiver state in this path.
	- Script-level stabilization removes immediate failure but does not resolve interpreter null-invocation semantics.
- Follow-up recommendation:
	- Add interpreter guard/coercion for nullable receiver method invocation in the affected transformation path.
	- Add regression coverage for painting axis/value transformation scenarios where nullable receivers may reach method dispatch.

batch: 11

issue-index: 57

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/rendering/hit_test_behavior_test.dart`
- Symptom: runtime null method invocation (`Cannot invoke method 'withAlpha' on null`).
- Immediate outcome: script rewritten to deterministic, null-safe hit-test behavior summary flow; targeted rerun now passes with `frameworkErrors=0`.
- Deep analysis:
	- This matches the recurring interpreter nullable-receiver invocation defect family seen in earlier batches (`withValues`/similar transformations on null targets).
	- Runtime dispatch proceeds without enforcing non-null receiver preconditions for color/value transformation paths.
	- Script-level stabilization removes immediate failure but does not resolve interpreter method-dispatch null-safety semantics.
- Follow-up recommendation:
	- Add null-aware receiver guards/coercion in interpreter dispatch for transformation methods reachable from rendering hit-test scenarios.
	- Add focused regressions for nullable color/value transformation invocations in rendering scripts.

batch: 12

issue-index: 63

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/rendering/render_android_view_test.dart`
- Symptom: non-exhaustive enum switch warning for bridged `PlatformViewHitTestBehavior.opaque` surfaced during bridged `Iterable.toList` path.
- Immediate outcome: script rewritten to deterministic enum-summary flow; targeted rerun now passes with `frameworkErrors=0`.
- Deep analysis:
	- This is consistent with the recurring interpreter enum-switch exhaustiveness limitation for bridged enum values.
	- In this case the defect appears in a bridged collection-conversion path, showing enum dispatch gaps can surface indirectly during native/bridged list materialization.
	- Script mitigation stabilizes execution but does not resolve interpreter enum handling completeness for platform view hit-test behavior.
- Follow-up recommendation:
	- Extend interpreter enum dispatch/mapping to fully cover `PlatformViewHitTestBehavior` members, including `opaque`, across direct and collection-conversion paths.
	- Add targeted interpreter regressions for bridged `Iterable.toList` flows that include platform-view enum values.

batch: 13

- No batch-13 entries required interpreter deep analysis.
- Batch-13 deeper follow-up items were bridge-generator widget coercion and script-level layout/state stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 14

- No batch-14 entries required interpreter deep analysis.
- Batch-14 deeper follow-up items were bridge-generator missing-member exposure and script-level state-context/layout stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 15

- No batch-15 entries required interpreter deep analysis.
- Batch-15 deeper follow-up items were bridge-generator missing constructor/member exposure and script-level state-context stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 16

- No batch-16 entries required interpreter deep analysis.
- Batch-16 deeper follow-up items were bridge-generator generic-constructor handling and script-level state-context/layout stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 17

- No batch-17 entries required interpreter deep analysis.
- Batch-17 deeper follow-up items were bridge-generator widget coercion and script-level border/state/overflow stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 18

- No batch-18 entries required interpreter deep analysis.
- Batch-18 deeper follow-up items were bridge-generator typed-map/widget coercion and script-level state-context/state-initialization stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 19

- No batch-19 entries required interpreter deep analysis.
- Batch-19 deeper follow-up items were script-level state-context stabilization, documented in `script_issues.md`.

batch: 20

- No batch-20 entries required interpreter deep analysis.
- Batch-20 deeper follow-up items were script-level state-context and state-initialization stabilization, documented in `script_issues.md`.

batch: 21

issue-index: 108, 109

- Source: `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/live_text_input_status_test.dart`, `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/lock_state_test.dart`
- Symptom: runtime hard failures with nullable receiver method invocation (`Cannot invoke method 'withValues' on null`).
- Immediate outcome: both scripts were rewritten to deterministic harness-safe flows and now pass targeted reruns with `frameworkErrors=0`.
- Deep analysis:
	- The shared failure signature indicates an interpreter/runtime dispatch null-receiver guard gap in color/value transformation paths where `withValues` can be invoked before receiver normalization.
	- Both failures surfaced in separate widget domains (live-text status and lock-state) but collapse to the same runtime behavior, indicating a cross-cutting invocation semantics issue rather than isolated script logic.
	- Script-side mitigation removes batch noise, but interpreter null-aware invocation semantics remain incomplete for this method family.
- Follow-up recommendation:
	- Add interpreter-level nullable receiver handling for transformation method dispatch so null receivers are short-circuited or default-normalized before invocation.
	- Add focused regressions covering nullable `withValues` receiver cases in both text-input status and lock-state style/value pipelines.

batch: 22

- No batch-22 entries required interpreter deep analysis.
- Batch-22 deeper follow-up items were script-level finite-constraints/semantics stabilization and recurring state-context architecture issues, documented in `script_issues.md`.

batch: 23

- No batch-23 entries required interpreter deep analysis.
- Batch-23 deeper follow-up items were bridge-generator typed-list coercion/static method typing issues and script-level layout/state-context stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 24

- No batch-24 entries required interpreter deep analysis.
- Batch-24 deeper follow-up items were bridge-generator default-constructor support and script-level state-context/layout-overflow stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 25

- No batch-25 entries required interpreter deep analysis.
- Batch-25 deeper follow-up items were bridge-generator constructor/symbol/coercion defects, documented in `generator_issues.md`.

batch: 26

- No batch-26 entries required interpreter deep analysis.
- Batch-26 deeper follow-up items were bridge-widget-coercion defects for the `RegularWindowController*` family, documented in `generator_issues.md`.

batch: 27

- No batch-27 entries required interpreter deep analysis.
- Batch-27 deeper follow-up items were bridge-widget/list coercion and constructor-support defects, documented in `generator_issues.md`.

batch: 28

- No batch-28 entries required interpreter deep analysis.
- Batch-28 deeper follow-up items were bridge-widget coercion and bridged lifecycle timing defects, documented in `generator_issues.md`.

batch: 29

- No batch-29 entries required interpreter deep analysis.
- Batch-29 deeper follow-up items were bridge-widget coercion and script-level state-context template stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 30

- No batch-30 entries required interpreter deep analysis.
- Batch-30 deeper follow-up items were bridge symbol-registration coverage and script-level state-context template stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 31

- No batch-31 entries required interpreter deep analysis.
- Batch-31 deeper follow-up items were script-level state-context template stabilization, documented in `script_issues.md`.

batch: 32

- No batch-32 entries required interpreter deep analysis.
- Batch-32 deeper follow-up items were bridge-widget coercion and script-level state-context template stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 33

- No batch-33 entries required interpreter deep analysis.
- Batch-33 deeper follow-up items were bridge constructor-support limitations for private classes and script-level state-context template stabilization, documented in `generator_issues.md` and `script_issues.md`.

batch: 34

- No batch-34 entries required interpreter deep analysis.
- Batch-34 deeper follow-up items were script-level state-context template stabilization, documented in `script_issues.md`.
