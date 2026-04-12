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
