# 20260412-0949-issue-analysis Error Analysis

Scope: Batch-0 to Batch-68 (issues 0..344 from `20260412-0949-issue-analysis_test_summary.md`).

## Batch-0

### Index 0

- Index: 0
- testname: `(setUpAll)` in `test/essential_classes_test.dart`
- category: `TEST-HARNESS-LOG-ONLY`
- immediate fix possible: `yes`
- description: Non-failing setup output is classified as an issue because Batch indexing includes tests with any non-metric log output.
- detailed analysis what the problem is: The logged message (`Bridge regeneration skipped: all bridge outputs are up-to-date`) is operational and expected. It is not a runtime, bridge, generator, interpreter, or Flutter framework failure. This is a logging-classification problem in the test harness/reporting pipeline.
- fix description (if clear): Mark this exact setup message as informational in the issue indexer (or filter it from issue extraction), while still keeping it in raw logs for traceability.
- need for deeper analysis?: `no`
- batch number: `0`

### Index 1

- Index: 1
- testname: `cupertino/controls_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 5 errors: negative minimum height constraints, `_RenderEditableCustomPaint` not laid out, and semantics lifecycle assertion.
- detailed analysis what the problem is: This is primarily a script-level widget composition issue, not a plain assertion failure in the test harness. The error chain (`negative minimum height` -> `RenderBox was not laid out` -> semantics assertion) indicates invalid layout constraints around editable/text input render objects. This does not match known bridge or interpreter limitations; it is consistent with Flutter layout misuse in the script setup.
- fix description (if clear): Rework the script's editable/control layout to guarantee bounded and non-negative height constraints (for example, explicit `SizedBox`/`ConstrainedBox` bounds, avoiding conflicting nested constraints in form rows). Add assertions in the script that no framework errors are collected from the test runner.
- need for deeper analysis?: `yes` (only if warnings remain after script constraint cleanup)
- batch number: `0`

### Index 2

- Index: 2
- testname: `cupertino/form_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 17 errors with the same pattern as Index 1, indicating repeated invalid constraints around editable render objects.
- detailed analysis what the problem is: High count and repeated identical messages indicate multiple widgets in this script are built under bad constraints. This is still script-level behavior (layout contract violations) and not a bridge/generator/interpreter defect. The repeated failures suggest one shared construction pattern in the form test is applied multiple times.
- fix description (if clear): Extract and fix the common Cupertino form field builder used in this script; enforce positive min-height and bounded width/height for editable nodes. Add a post-run check in the script to fail if framework error lines are produced.
- need for deeper analysis?: `yes` (if common builder fix does not eliminate all warnings)
- batch number: `0`

### Index 3

- Index: 3
- testname: `cupertino/textfield_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 13 errors (negative min-height constraints, render object not laid out, semantics assertion).
- detailed analysis what the problem is: Same root signature as Index 1 and 2, strongly suggesting a shared text-field composition approach causing invalid constraints in one or more states of the scenario. No signal here that this is due to bridge registration gaps, generator defects, or interpreter type-casting limitations.
- fix description (if clear): Align text field test scaffolding with Flutter constraint requirements (explicit parent constraints, avoid unconstrained editable descendants). Consolidate with the same layout helper fix used for controls/form scripts to remove duplicated failure patterns.
- need for deeper analysis?: `yes` (only if errors persist after shared layout helper correction)
- batch number: `0`

### Index 4

- Index: 4
- testname: `rendering/viewport_test.dart`
- category: `TEST-SCRIPT-OVERFLOW`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted repeated overflow warnings (`A RenderFlex overflowed by 20 pixels on the right.`).
- detailed analysis what the problem is: Overflow warnings indicate the scripted viewport demo composes child layout wider than available width. This is a script layout scenario issue and is not categorized as interpreter/bridge/generator failure. Because the test still passes, this must be treated as a quality issue in the test scenario rather than a hard runtime failure.
- fix description (if clear): Constrain child width in the viewport scenario (`Expanded`/`Flexible`, wrapping, responsive constraints, or horizontal scroll strategy) so render overflow is eliminated. Add guard checks to flag overflow warnings as failures when running the script.
- need for deeper analysis?: `no`
- batch number: `0`

## Batch-0 Classification Summary

- Bridge issue classification: no direct bridge registration gap identified in Batch-0.
- Generator issue classification: no generator defect signal identified in Batch-0.
- Interpreter issue classification: no direct interpreter limitation signature identified in Batch-0 (for example, no non-exhaustive switch, no generic callback cast mismatch, no missing bridged method/runtime signature tied to known interpreter docs).
- Primary problem class for Batch-0: test script and harness quality (layout constraint misuse, overflow handling, and informational setup log classification).

## Batch-1

### Index 5

- Index: 5
- testname: `(setUpAll)` in `test/hardly_relevant_classes_1_test.dart`
- category: `TEST-HARNESS-LOG-ONLY`
- immediate fix possible: `yes`
- description: Non-failing setup output is indexed as an issue because the summary includes all non-metric log output entries.
- detailed analysis what the problem is: The message (`Bridge regeneration skipped: all bridge outputs are up-to-date`) is expected operational status output and not an error. This is a report-classification issue and should not be treated as a runtime/test defect.
- fix description (if clear): Keep message in raw log, but treat it as informational and exclude it from issue indexing.
- need for deeper analysis?: `no`
- batch number: `1`

### Index 6

- Index: 6
- testname: `animation/reverse_tween_test.dart`
- category: `BRIDGE-GENERIC-CONSTRUCTOR-FACTORY (needs correction)`
- immediate fix possible: `yes`
- description: Plain test failure (`Expected: true, Actual: false`) with runtime error `Error in generic constructor factory for 'ReverseTween': Null check operator used on a null value`.
- detailed analysis what the problem is: This is consistent with previously documented generic constructor factory limitations in the bridge/interpreter pipeline (`ReverseTween<T>` path). The failure is not a layout warning and not a flaky assertion. The test expectation is valid; runtime factory resolution for generic types is currently incorrect, causing null-check crashes during interpreted generic constructor handling.
- fix description (if clear): Implement a focused UserBridge override for `ReverseTween` generic constructor handling (type-parameter-aware extraction/casting) and align generator behavior for generic factory constructors. Keep the test as-is and mark the underlying bridge/generator path as needs correction.
- need for deeper analysis?: `yes` (for generator-side generalization beyond `ReverseTween`)
- batch number: `1`

### Index 7

- Index: 7
- testname: `cupertino/cupertino_desktop_text_selection_controls_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 errors (`negative minimum height`, `_RenderEditableCustomPaint` layout failure, semantics assertion).
- detailed analysis what the problem is: This is the same Cupertino editable-layout warning chain as Batch-0 and indicates script composition with invalid constraints. There is no signature of bridge/generator/interpreter type-resolution failure here.
- fix description (if clear): Correct script layout constraints for editable controls (bounded/positive constraints and stable parent sizing). Add script-level guard to fail when framework errors are present so warnings are not silently accepted.
- need for deeper analysis?: `no`
- batch number: `1`

### Index 8

- Index: 8
- testname: `cupertino/cupertino_focus_halo_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 errors with the same editable-constraint signature as Index 7.
- detailed analysis what the problem is: The issue pattern is script-level Flutter layout misuse around editable rendering pipeline and semantics update timing after failed layout. No indicator of interpreter non-exhaustive switch or bridge method absence.
- fix description (if clear): Rework focus-halo scenario scaffold constraints and editable host sizing; validate by rerun that framework warning count is zero.
- need for deeper analysis?: `no`
- batch number: `1`

### Index 9

- Index: 9
- testname: `cupertino/cupertino_text_selection_handle_controls_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 11 errors, repeating the same negative-height and not-laid-out sequence.
- detailed analysis what the problem is: High repetition indicates the same layout defect is triggered across multiple states/interactions in this script. This is a test-script quality problem; no direct evidence of bridge/generator/interpreter core limitation for this specific issue.
- fix description (if clear): Consolidate with Cupertino text-selection constraint fixes, enforce bounded editable layout in all interaction states, and fail the script when any framework error line is produced.
- need for deeper analysis?: `yes` (only if warnings remain after shared layout fix)
- batch number: `1`

## Batch-1 Classification Summary

- Missing/stray status for Batch-1 scripts: none missing, none stray.
- Bridge/generator/interpreter classification: one direct bridge/generator generic-constructor issue (`ReverseTween<T>` factory path) and no Batch-1 non-exhaustive-switch signature.
- Test script issue classification: three Cupertino scripts with framework layout/semantics warnings that require script correction so warning output is removed.

## Batch-2

### Index 10

- Index: 10
- testname: `cupertino/inherited_cupertino_theme_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 errors (`negative minimum height`, `_RenderEditableCustomPaint` not laid out, semantics assertion).
- detailed analysis what the problem is: The warning signature is the same recurring Cupertino editable-layout issue seen in Batch-0/Batch-1. This points to script-level constraint composition problems rather than bridge/generator/interpreter core defects.
- fix description (if clear): Refactor the script's editable/form widget constraints to enforce bounded, non-negative layout constraints and fail the test on any framework error lines.
- need for deeper analysis?: `no`
- batch number: `2`

### Index 11

- Index: 11
- testname: `cupertino/overlay_visibility_mode_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 7 errors with repeated negative-height and not-laid-out render object messages.
- detailed analysis what the problem is: Repetition across interactions indicates the script repeatedly enters invalid editable layout states. This remains a script/harness quality problem; there is no non-exhaustive-switch or generic-factory signature in this issue.
- fix description (if clear): Consolidate with the shared Cupertino constraint fix path (bounded editable host, stable parent constraints), then validate zero framework warnings.
- need for deeper analysis?: `yes` (only if warnings persist after shared constraint fix)
- batch number: `2`

### Index 12

- Index: 12
- testname: `dart_ui/blur_style_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 4 overflow warnings (`RenderFlex overflowed by 2.0 pixels on the bottom`).
- detailed analysis what the problem is: This is a test-script layout sizing problem in the blur-style demo composition and not a hard interpreter failure. The script currently allows bottom overflow under test viewport constraints.
- fix description (if clear): Adjust demo layout sizing (`Expanded`/`Flexible`, constrained heights, scroll fallback) so no overflow is produced in the test viewport.
- need for deeper analysis?: `no`
- batch number: `2`

### Index 13

- Index: 13
- testname: `dart_ui/color_space_test.dart`
- category: `INTERPRETER-INDEXING-NULL (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Unsupported target for indexing: null` (assertion expected success).
- detailed analysis what the problem is: This matches previously documented interpreter behavior for `color_space_test.dart` and indicates an interpreter/runtime evaluation gap around indexed access/target resolution (likely enum/value resolution path). The test expectation is valid and should remain; runtime behavior needs correction.
- fix description (if clear): Implement interpreter-side guard/fix for null index targets in this evaluation path, and/or add explicit UserBridge handling for the affected `ColorSpace` access pattern to guarantee non-null index targets before evaluation.
- need for deeper analysis?: `yes`
- batch number: `2`

### Index 14

- Index: 14
- testname: `dart_ui/key_event_type_test.dart`
- category: `BRIDGE-MISSING-MEMBER (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted runtime warning: `Undefined property or method 'label' on bridged instance of 'Key'.`
- detailed analysis what the problem is: The script accesses a key member (`label`) that is not currently exposed in the bridged `Key` API surface. This is a bridge coverage gap (member not registered/exposed), not a layout issue.
- fix description (if clear): Add/override bridge support for the missing `Key.label` member via UserBridge/custom bridge definition and add a focused regression script to lock this behavior.
- need for deeper analysis?: `yes` (to verify all key-related member mappings)
- batch number: `2`

## Batch-2 Classification Summary

- Missing/stray status for Batch-2 scripts: none missing, none stray.
- Test-script issue classification: three non-failing scripts emit framework warnings and need script correction (`inherited_cupertino_theme`, `overlay_visibility_mode`, `blur_style`).
- Bridge/generator/interpreter classification: one interpreter indexing target issue (`color_space_test`) and one bridge missing-member issue (`key_event_type_test`).
- Known non-exhaustive switch signature in Batch-2: not detected in this batch.

## Batch-3

### Index 15

- Index: 15
- testname: `dart_ui/placeholder_alignment_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure from `WidgetSpan` constructor assertion requiring baseline when specific placeholder alignments are used.
- detailed analysis what the problem is: The failure is triggered by script-level constructor argument contract violation (`baseline` missing for baseline-related alignment). This is not a non-exhaustive-switch issue and not a generic constructor factory failure.
- fix description (if clear): Update script to provide `baseline: TextBaseline.alphabetic` when using baseline-dependent placeholder alignment values, or use a non-baseline alignment mode.
- need for deeper analysis?: `no`
- batch number: `3`

### Index 16

- Index: 16
- testname: `dart_ui/system_color_palette_test.dart`
- category: `INTERPRETER-PLATFORM-LIMITATION (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Unsupported operation: SystemColor not supported on the current platform.`
- detailed analysis what the problem is: This is a known platform/engine support limitation for system color APIs under the current execution environment. The test expectation should be platform-aware instead of assuming universal support.
- fix description (if clear): Add platform capability guard/workaround in the script (skip or alternate assertion when system colors are unsupported), and optionally document/extend interpreter support path for platforms where this API should be available.
- need for deeper analysis?: `yes` (for broader platform support strategy)
- batch number: `3`

### Index 17

- Index: 17
- testname: `dart_ui/vertex_mode_test.dart`
- category: `BRIDGE-CONSTRUCTOR-ARG-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted runtime warnings from `Vertices` constructor: `positions` expected `List<Offset>`, got null.
- detailed analysis what the problem is: The warning indicates constructor argument extraction/coercion for bridged `Vertices` is not robust for this invocation path. This aligns with existing bridge issue notes for `Vertices` parameter handling.
- fix description (if clear): Add/adjust UserBridge override for `Vertices` constructor argument extraction (explicit non-null and typed list coercion), and tighten script inputs to ensure `positions` is always populated with valid `List<Offset>`.
- need for deeper analysis?: `yes`
- batch number: `3`

### Index 18

- Index: 18
- testname: `foundation/object_created_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: 'Object' is not callable (no default constructor bridge found).`
- detailed analysis what the problem is: The script attempts to instantiate `Object()`, but bridge/runtime does not expose a callable default constructor for `Object`. This is a bridge coverage/generator gap for a core type.
- fix description (if clear): Add default constructor bridge handling for `Object` (or special-case native fallback for `Object()`), then keep test expectation unchanged.
- need for deeper analysis?: `yes` (to validate behavior for all root/core class constructors)
- batch number: `3`

### Index 19

- Index: 19
- testname: `foundation/object_disposed_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with the same `Object` constructor bridge gap as Index 18.
- detailed analysis what the problem is: The same root defect is exercised by a second script path, confirming this is not an isolated test mistake but a shared bridge/runtime constructor availability problem.
- fix description (if clear): Resolve at bridge/runtime layer once (default constructor support for `Object`) and rerun both object lifecycle tests.
- need for deeper analysis?: `yes`
- batch number: `3`

## Batch-3 Classification Summary

- Missing/stray status for Batch-3 scripts: none missing, none stray.
- Test-script issue classification: one script constructor-argument misuse (`placeholder_alignment_test`) and one platform-guard issue (`system_color_palette_test`).
- Bridge/generator/interpreter classification: one `Vertices` constructor argument-coercion bridge issue and one shared missing `Object` default-constructor bridge issue (affecting two tests).
- Known non-exhaustive switch signature in Batch-3: not detected in this batch.

## Batch-4

### Index 20

- Index: 20
- testname: `foundation/object_event_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: 'Object' is not callable (no default constructor bridge found).`
- detailed analysis what the problem is: This is the same root constructor-bridge gap already observed in Batch-3 for `Object` instantiation. The failure confirms the issue affects multiple object lifecycle scripts and should be fixed centrally in bridge/runtime behavior.
- fix description (if clear): Add default constructor support/fallback for `Object` in bridge/runtime resolution and rerun object lifecycle tests (`object_created`, `object_disposed`, `object_event`).
- need for deeper analysis?: `yes`
- batch number: `4`

### Index 21

- Index: 21
- testname: `foundation/target_platform_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with native constructor error for `Text`: `Invalid parameter "data": expected String, got Null`.
- detailed analysis what the problem is: The failing path attempts to construct `Text` with a null `data` argument. This is primarily a script/test construction contract issue (non-null string required), not a non-exhaustive-switch case.
- fix description (if clear): Ensure the script always passes a non-null string to `Text` (fallback/default value before constructor call) and keep the assertion logic unchanged.
- need for deeper analysis?: `no`
- batch number: `4`

### Index 22

- Index: 22
- testname: `gestures/class_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure from `DragEndDetails` constructor assertion about inconsistent `primaryVelocity` versus 2D velocity vector.
- detailed analysis what the problem is: The test script passes argument combinations that violate Flutter's constructor invariants for `DragEndDetails` (`primaryVelocity` must align with exactly one axis or be null).
- fix description (if clear): Adjust script input generation so `primaryVelocity` is null or axis-consistent with `velocity.pixelsPerSecond`; add explicit constructor invariant checks in the test setup.
- need for deeper analysis?: `no`
- batch number: `4`

### Index 23

- Index: 23
- testname: `(setUpAll)` in `test/hardly_relevant_classes_2_test.dart`
- category: `TEST-HARNESS-LOG-ONLY`
- immediate fix possible: `yes`
- description: Non-failing setup output is indexed as an issue due to current non-metric log extraction behavior.
- detailed analysis what the problem is: The bridge-regeneration skipped message is operational and expected, not a runtime or script defect.
- fix description (if clear): Treat this setup message as informational and exclude it from issue indexing while retaining it in raw logs.
- need for deeper analysis?: `no`
- batch number: `4`

### Index 24

- Index: 24
- testname: `material/bottom_navigation_bar_type_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The bridge/interpreter path returns an interpreted object where a concrete `Widget` is required. This is a known coercion gap also seen in other material/widget tests.
- fix description (if clear): Add bridge coercion handling to unwrap/convert `InterpretedInstance` to native `Widget` at the relevant boundary (constructor/method return path), and add a focused regression script for this pattern.
- need for deeper analysis?: `yes`
- batch number: `4`

## Batch-4 Classification Summary

- Missing/stray status for Batch-4 scripts: none missing, none stray.
- Test-script issue classification: two constructor-contract issues in script inputs (`target_platform_test`, `gestures/class_test`).
- Bridge/generator/interpreter classification: one shared missing `Object` default-constructor bridge issue and one widget coercion gap (`Expected Widget but got InterpretedInstance`).
- Known non-exhaustive switch signature in Batch-4: not detected in this batch.

## Batch-5

### Index 25

- Index: 25
- testname: `material/button_bar_layout_behavior_test.dart`
- category: `INTERPRETER-NULL-TARGET-COMPARISON (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `NoSuchMethodError: The method '>' was called on null.`
- detailed analysis what the problem is: The runtime attempts a numeric comparison (`>`) on a null target. In this suite context, this points to a null value escaping from interpreted/bridged enum or property extraction before comparison, rather than a Flutter layout warning. The test expectation (`Expected: true`) is structurally valid, so this should be treated as a runtime handling defect.
- fix description (if clear): Add null-safe coercion/guards before numeric comparison in the affected interpretation path and verify the related button-bar enum/value bridge extraction so a valid numeric value is always produced (or fail with a clear typed error).
- need for deeper analysis?: `yes`
- batch number: `5`

### Index 26

- Index: 26
- testname: `material/button_bar_theme_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 2 errors: `Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme)`.
- detailed analysis what the problem is: This is a bridge coercion mismatch at a widget boundary. A bridged/interpreted object is being passed where a concrete Flutter `Widget` is required. This is the same family as prior widget coercion failures and should not remain as warning-only output.
- fix description (if clear): Add/adjust bridge conversion so `InterpretedInstance(ButtonBarTheme)` is unwrapped or converted into the native widget/type expected by the receiving API, and make the test fail on framework warnings until this is resolved.
- need for deeper analysis?: `yes`
- batch number: `5`

### Index 27

- Index: 27
- testname: `material/button_text_theme_test.dart`
- category: `INTERPRETER-NULL-PROPERTY-ACCESS (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Cannot access property 'value' on target of type null.`
- detailed analysis what the problem is: The interpreted execution path dereferences `.value` on a null object. This is consistent with missing null-safety/coercion in enum/property extraction, and aligns with the Batch-5 button-theme null-target failure family.
- fix description (if clear): Introduce null-safe property extraction and typed fallback handling in the affected interpreter/bridge path; verify that button text/theme values are always initialized before property access.
- need for deeper analysis?: `yes`
- batch number: `5`

### Index 28

- Index: 28
- testname: `material/collapse_mode_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure from native `Text` constructor validation: `Invalid parameter "data": expected String, got Null`.
- detailed analysis what the problem is: The test path constructs `Text` with a null `data` argument. This is a script/input contract violation first, not a non-exhaustive switch issue.
- fix description (if clear): Ensure non-null string data is passed to `Text` in all branches of the collapse-mode script (default/fallback label before constructor invocation).
- need for deeper analysis?: `no`
- batch number: `5`

### Index 29

- Index: 29
- testname: `material/drawer_controller_state_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 overflow warnings (`RenderFlex overflowed by 46/29/12 pixels on the right`).
- detailed analysis what the problem is: This is a script-level layout sizing issue in the drawer-controller scenario. It is not a plain runtime assertion failure, but these framework warnings still indicate an invalid visual/layout state that should be eliminated.
- fix description (if clear): Rework horizontal layout constraints in the script (`Expanded`/`Flexible`/width constraints or scroll strategy) so no RenderFlex overflow warnings are emitted under the test viewport.
- need for deeper analysis?: `no`
- batch number: `5`

## Batch-5 Classification Summary

- Missing/stray status for Batch-5 scripts: none missing, none stray.
- Test-script issue classification: one constructor-argument contract issue (`collapse_mode_test`) and one layout overflow warning issue (`drawer_controller_state_test`).
- Bridge/generator/interpreter classification: one widget coercion mismatch (`button_bar_theme_test`) and two null-target runtime handling issues in button-theme flows (`button_bar_layout_behavior_test`, `button_text_theme_test`).
- Known non-exhaustive switch signature in Batch-5: not detected in this batch.

## Batch-6

### Index 30

- Index: 30
- testname: `material/dropdown_menu_close_behavior_test.dart`
- category: `INTERPRETER-NON-EXHAUSTIVE-SWITCH (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Switch expression was not exhaustive for value: DropdownMenuCloseBehavior.all (DropdownMenuCloseBehavior)`.
- detailed analysis what the problem is: This directly matches a known interpreter limitation pattern where enum switch handling is not exhaustive at runtime for bridged values. The assertion failure is caused by runtime evaluation behavior, not by a Flutter layout warning or a clearly invalid test expectation.
- fix description (if clear): Add a workaround in script logic (avoid relying on non-exhaustive switch path) and implement interpreter-side exhaustive enum handling for `DropdownMenuCloseBehavior` values via bridge/runtime mapping updates.
- need for deeper analysis?: `yes`
- batch number: `6`

### Index 31

- Index: 31
- testname: `material/end_drawer_button_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 8 errors about infinite-size layout (`RenderParagraph`, `RenderFlex`, `RenderPadding`, `RenderDecoratedBox`).
- detailed analysis what the problem is: The script composes widgets in a layout context that permits unbounded/infinite constraints, causing downstream render objects to request infinite size. This is a script-level layout/scaffold issue and should be treated as a failing quality condition even though the test result is success.
- fix description (if clear): Constrain the end-drawer scenario with bounded parent sizes (for example `SizedBox`/`ConstrainedBox` and explicit width limits for drawer content), then enforce zero framework errors as pass criteria.
- need for deeper analysis?: `no`
- batch number: `6`

### Index 32

- Index: 32
- testname: `material/gapped_range_slider_track_shape_test.dart`
- category: `INTERPRETER-NULL-CHECK-RUNTIME (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 18 repeated runtime warnings: `Null check operator used on a null value`.
- detailed analysis what the problem is: Repeated null-check crashes during script execution indicate null propagation through interpreter/bridge paths used by slider track-shape logic. This is not a simple visual overflow warning; it points to missing null-safe coercion/defaulting in runtime handling of slider theme inputs.
- fix description (if clear): Add null-safe extraction/coercion for the relevant slider track-shape inputs in bridge/runtime paths and ensure script data initialization avoids null before null-check operators are applied.
- need for deeper analysis?: `yes`
- batch number: `6`

### Index 33

- Index: 33
- testname: `material/gapped_slider_track_shape_test.dart`
- category: `TEST-SCRIPT-THEME-CONTRACT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 28 assertion errors: `'sliderTheme.trackGap != null': is not true`.
- detailed analysis what the problem is: The scenario invokes slider painting/track-shape paths without satisfying required theme contract fields (`trackGap`). This is primarily a script/theme setup issue; the test currently exercises invalid configuration repeatedly.
- fix description (if clear): Update the script to provide a valid `SliderThemeData.trackGap` (or use configuration paths that guarantee it) before invoking gapped slider track-shape rendering; keep warning output as failure criteria.
- need for deeper analysis?: `no`
- batch number: `6`

### Index 34

- Index: 34
- testname: `material/hour_format_test.dart`
- category: `INTERPRETER-NULL-METHOD-INVOCATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted runtime warning: `Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation.`
- detailed analysis what the problem is: A method call is attempted on a null object in the interpreted execution path, indicating missing null-aware handling for value transformations in this hour-format flow.
- fix description (if clear): Add null-aware method invocation/guarding in the relevant script/runtime path and ensure non-null defaults are prepared before calling `withValues`.
- need for deeper analysis?: `yes`
- batch number: `6`

## Batch-6 Classification Summary

- Missing/stray status for Batch-6 scripts: none missing, none stray.
- Test-script issue classification: two script-side configuration/layout issues (`end_drawer_button_test`, `gapped_slider_track_shape_test`).
- Bridge/generator/interpreter classification: one known non-exhaustive enum switch limitation (`dropdown_menu_close_behavior_test`) and two null-runtime handling issues (`gapped_range_slider_track_shape_test`, `hour_format_test`).
- Known non-exhaustive switch signature in Batch-6: detected in `dropdown_menu_close_behavior_test`.

## Batch-7

### Index 35

- Index: 35
- testname: `material/list_tile_title_alignment_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 overflow warnings (`RenderFlex overflowed by 1.00 pixels on the bottom`).
- detailed analysis what the problem is: This is a script-level layout sizing problem where list-tile title alignment scenarios slightly exceed vertical constraints. The test result is success, but the warning output indicates an invalid layout state that should be removed.
- fix description (if clear): Adjust vertical constraints/padding in the scenario (for example tighter text scale/line-height handling, bounded parent height, or scroll wrapping) and enforce zero framework warnings as pass criteria.
- need for deeper analysis?: `no`
- batch number: `7`

### Index 36

- Index: 36
- testname: `material/material_banner_closed_reason_test.dart`
- category: `INTERPRETER-NON-EXHAUSTIVE-SWITCH (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Switch expression was not exhaustive for value: MaterialBannerClosedReason.dismiss (MaterialBannerClosedReason)`.
- detailed analysis what the problem is: This matches the known interpreter enum-switch limitation pattern already seen in other batches. The assertion failure is caused by non-exhaustive runtime switch handling for bridged enum values, not by a clearly invalid test assertion.
- fix description (if clear): Add script workaround for unsupported enum-switch path and implement interpreter-side exhaustive enum handling for `MaterialBannerClosedReason` through bridge/runtime updates.
- need for deeper analysis?: `yes`
- batch number: `7`

### Index 37

- Index: 37
- testname: `material/menu_accelerator_callback_binding_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 12 infinite-size layout errors across `RenderParagraph`, `RenderFlex`, `RenderPadding`, and `RenderDecoratedBox`.
- detailed analysis what the problem is: The script uses a menu layout composition that allows unbounded dimensions, causing repeated infinite-size render errors in descendant widgets. This is a test script scaffold/constraint issue and should be corrected even though the test did not fail.
- fix description (if clear): Constrain the menu accelerator scenario with bounded container sizes and explicit layout limits, then treat any framework warning output as failure to prevent regressions.
- need for deeper analysis?: `no`
- batch number: `7`

### Index 38

- Index: 38
- testname: `material/navigation_destination_label_behavior_test.dart`
- category: `INTERPRETER-NON-EXHAUSTIVE-SWITCH (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Switch expression was not exhaustive for value: NavigationDestinationLabelBehavior.alwaysShow (NavigationDestinationLabelBehavior)`.
- detailed analysis what the problem is: This is another direct hit of the known non-exhaustive interpreter switch behavior for material enums. The failing expectation is likely valid; runtime enum handling needs to support all mapped values.
- fix description (if clear): Extend interpreter/bridge enum switch support for `NavigationDestinationLabelBehavior` values (including `alwaysShow`) and keep a script-level guard/workaround until runtime support is complete.
- need for deeper analysis?: `yes`
- batch number: `7`

### Index 39

- Index: 39
- testname: `material/navigation_drawer_theme_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 overflow warnings (`RenderFlex overflowed by 29 pixels on the bottom`).
- detailed analysis what the problem is: The navigation drawer theme scenario is rendering with insufficient vertical space for one or more composed children. This is script-level layout sizing and not a bridge/interpreter hard failure, but should still be corrected to remove warnings.
- fix description (if clear): Rework drawer theme demo layout constraints (bounded heights, flexible child sizing, or scroll handling) so no RenderFlex overflow warnings are emitted.
- need for deeper analysis?: `no`
- batch number: `7`

## Batch-7 Classification Summary

- Missing/stray status for Batch-7 scripts: none missing, none stray.
- Test-script issue classification: three layout-constraint/overflow warning issues (`list_tile_title_alignment_test`, `menu_accelerator_callback_binding_test`, `navigation_drawer_theme_test`).
- Bridge/generator/interpreter classification: two known non-exhaustive enum switch failures (`material_banner_closed_reason_test`, `navigation_destination_label_behavior_test`).
- Known non-exhaustive switch signature in Batch-7: detected in `material_banner_closed_reason_test` and `navigation_destination_label_behavior_test`.

## Batch-8

### Index 40

- Index: 40
- testname: `material/navigation_rail_label_type_test.dart`
- category: `INTERPRETER-NON-EXHAUSTIVE-SWITCH (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Switch expression was not exhaustive for value: NavigationRailLabelType.none (NavigationRailLabelType)`.
- detailed analysis what the problem is: This is the same known enum-switch exhaustiveness limitation seen in prior batches, now triggered for `NavigationRailLabelType`. The test expectation is likely correct; runtime enum switch handling is incomplete.
- fix description (if clear): Add a short-term script workaround and implement interpreter/bridge exhaustive enum handling for all `NavigationRailLabelType` values.
- need for deeper analysis?: `yes`
- batch number: `8`

### Index 41

- Index: 41
- testname: `material/paginated_data_table_state_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 36 errors including infinite width constraints and repeated `RenderBox was not laid out` assertions.
- detailed analysis what the problem is: The scenario is building paginated table widgets under invalid/unbounded layout constraints, causing cascading render/layout failures and semantics assertions. This is a script scaffold/layout-contract problem rather than a plain interpreter switch failure.
- fix description (if clear): Rework the script scaffold to provide bounded width/height constraints for paginated table containers (and nested scroll/viewport structure), then enforce zero framework errors as pass criteria.
- need for deeper analysis?: `no`
- batch number: `8`

### Index 42

- Index: 42
- testname: `material/popup_menu_position_test.dart`
- category: `BRIDGE-GENERIC-CONSTRUCTOR-FACTORY-CONTRACT (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with generic constructor factory error for `PopupMenuButton`: assertion `'!(child != null && icon != null)'` failed.
- detailed analysis what the problem is: The failure originates in the generic constructor factory path and indicates conflicting constructor argument mapping for `PopupMenuButton` (both `child` and `icon` becoming non-null). This can come from script input or bridge argument extraction/defaulting behavior; the generic factory path itself is explicitly implicated.
- fix description (if clear): Verify script constructor usage first, then adjust UserBridge/generator constructor argument mapping so only one of `child` or `icon` is populated in the native call path.
- need for deeper analysis?: `yes`
- batch number: `8`

### Index 43

- Index: 43
- testname: `material/progress_indicator_test.dart`
- category: `TEST-SCRIPT-VALUE-TYPE-CONTRACT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted value-contract warning: progress bar values must be numeric (`value: "67%"`, `minValue: "0"`, `maxValue: "100"`).
- detailed analysis what the problem is: The scenario sends string-formatted values into a path expecting numeric values for progress semantics/metrics. This is a test-script data typing contract issue.
- fix description (if clear): Provide numeric values (`double`/`num`) for progress, min, and max fields rather than formatted strings, and keep warning output as failure criteria.
- need for deeper analysis?: `no`
- batch number: `8`

### Index 44

- Index: 44
- testname: `material/refresh_progress_indicator_test.dart`
- category: `TEST-SCRIPT-VALUE-TYPE-CONTRACT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted the same value-contract warning (`value: "50%"` string, numeric values expected).
- detailed analysis what the problem is: This mirrors Index 43 and confirms a shared script data formatting pattern that violates expected numeric progress semantics.
- fix description (if clear): Align refresh progress inputs with numeric value types (`num`/`double`) and remove percent-string formatting in the tested path.
- need for deeper analysis?: `no`
- batch number: `8`

## Batch-8 Classification Summary

- Missing/stray status for Batch-8 scripts: none missing, none stray.
- Test-script issue classification: one layout-constraint cascade (`paginated_data_table_state_test`) and two progress value-type contract issues (`progress_indicator_test`, `refresh_progress_indicator_test`).
- Bridge/generator/interpreter classification: one known non-exhaustive enum switch issue (`navigation_rail_label_type_test`) and one generic-constructor argument mapping/contract issue (`popup_menu_position_test`).
- Known non-exhaustive switch signature in Batch-8: detected in `navigation_rail_label_type_test`.

## Batch-9

### Index 45

- Index: 45
- testname: `material/theme_extension_test.dart`
- category: `BRIDGE-LIST-TYPE-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports `ThemeData.copyWith` bridge conversion failure: cannot convert interpreted `List` to `List<ThemeExtension<dynamic>>`.
- detailed analysis what the problem is: This indicates a bridge/runtime typed-list coercion gap for generic collection parameters in bridged method calls. The failure is not from test logic alone; it reflects missing conversion from interpreted list elements to native `ThemeExtension`-typed entries.
- fix description (if clear): Add UserBridge/generator conversion logic for `ThemeData.copyWith(extensions: ...)` so interpreted lists are mapped to `List<ThemeExtension<dynamic>>` with element-type validation.
- need for deeper analysis?: `yes`
- batch number: `9`

### Index 46

- Index: 46
- testname: `material/theme_mode_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 17 errors about infinite-size layout across paragraph/padding/flex/decorated/constrained boxes.
- detailed analysis what the problem is: The script layout composition allows unbounded constraints in one or more subtrees, causing repeated infinite-size render errors. This is a test-script scaffold/layout-contract issue that should be corrected despite success status.
- fix description (if clear): Bound the scenario containers and nested layout widgets with explicit constraints and ensure no framework warnings are emitted.
- need for deeper analysis?: `no`
- batch number: `9`

### Index 47

- Index: 47
- testname: `material/thumb_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 17 infinite-size layout errors with the same signature as `theme_mode_test`.
- detailed analysis what the problem is: This shows the same unbounded-constraint scaffold pattern in the thumb scenario. No direct bridge switch signature appears; root cause is script layout bounds.
- fix description (if clear): Reuse the bounded-container/layout fix pattern from `theme_mode_test` in thumb scenario and fail on any framework warning output.
- need for deeper analysis?: `no`
- batch number: `9`

### Index 48

- Index: 48
- testname: `material/time_of_day_format_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 47 errors, predominantly infinite-size layout assertions.
- detailed analysis what the problem is: Large-volume repeated layout errors indicate broad unbounded layout flow in this time-format scenario. This is script-level composition quality debt rather than a single bridge runtime crash.
- fix description (if clear): Refactor the test scaffold to enforce bounded dimensions for each interactive section and verify all render/layout warnings are eliminated.
- need for deeper analysis?: `yes`
- batch number: `9`

### Index 49

- Index: 49
- testname: `material/time_picker_entry_mode_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 32 infinite-size layout errors similar to adjacent time/theme tests.
- detailed analysis what the problem is: Same recurring pattern of unbounded layout constraints in script composition affecting time picker entry mode rendering paths. This should be treated as script correction work, not ignored as warning-only output.
- fix description (if clear): Apply the same bounded-layout scaffold corrections used for other Batch-9 material scripts and enforce zero-warning policy.
- need for deeper analysis?: `no`
- batch number: `9`

## Batch-9 Classification Summary

- Missing/stray status for Batch-9 scripts: none missing, none stray.
- Test-script issue classification: four layout-constraint warning groups (`theme_mode_test`, `thumb_test`, `time_of_day_format_test`, `time_picker_entry_mode_test`).
- Bridge/generator/interpreter classification: one typed-list bridge coercion issue in `ThemeData.copyWith` extensions handling (`theme_extension_test`).
- Known non-exhaustive switch signature in Batch-9: not detected in this batch.

## Batch-10

### Index 50

- Index: 50
- testname: `material/toggle_buttons_theme_data_test.dart`
- category: `BRIDGE-OPERATOR-ARG-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning indicates bridged operator `==` on `BoxConstraints` received invalid parameter `other` as null.
- detailed analysis what the problem is: This is a bridge/runtime operator argument coercion issue where null is propagated into a path expecting a non-null object for equality checks. It is not primarily a layout warning.
- fix description (if clear): Add null-safe guard/coercion in the `BoxConstraints` bridged equality operator path and ensure script inputs avoid null `other` operands.
- need for deeper analysis?: `yes`
- batch number: `10`

### Index 51

- Index: 51
- testname: `material/toggle_buttons_theme_test.dart`
- category: `BRIDGE-OPERATOR-ARG-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted the same `BoxConstraints ==` null-operand runtime warning as Index 50.
- detailed analysis what the problem is: Same root defect as Index 50, confirming a shared bridge/runtime handling gap rather than a one-off script issue.
- fix description (if clear): Fix bridged equality operator argument handling once and rerun both toggle-buttons theme tests.
- need for deeper analysis?: `yes`
- batch number: `10`

### Index 52

- Index: 52
- testname: `material/tooltip_state_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but warning shows native `Tooltip` constructor assertion failure requiring exactly one of `message` or `richMessage`.
- detailed analysis what the problem is: The script is constructing `Tooltip` with invalid constructor argument combination (both null or both non-null). This is primarily script-side argument-contract misuse.
- fix description (if clear): Update script construction logic to provide exactly one of `message` or `richMessage`, and treat any constructor assertion output as failure.
- need for deeper analysis?: `no`
- batch number: `10`

### Index 53

- Index: 53
- testname: `painting/axis_direction_test.dart`
- category: `INTERPRETER-NULL-METHOD-INVOCATION (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation.`
- detailed analysis what the problem is: The interpreted path calls `withValues` on a null target, matching previously seen null-method-invocation runtime behavior in related tests.
- fix description (if clear): Add null-aware method invocation/guarding in the affected path and ensure required objects are non-null before transformation calls.
- need for deeper analysis?: `yes`
- batch number: `10`

### Index 54

- Index: 54
- testname: `painting/axis_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted 3 RenderFlex overflow warnings (right and bottom overflows).
- detailed analysis what the problem is: Script layout sizing in the axis demo exceeds available space in some states. This is a test-script layout quality issue and should be corrected to remove warning output.
- fix description (if clear): Constrain or adapt axis demo layout (bounded sizes, flexible wrapping, scroll fallback) so no RenderFlex overflow warnings remain.
- need for deeper analysis?: `no`
- batch number: `10`

## Batch-10 Classification Summary

- Missing/stray status for Batch-10 scripts: none missing, none stray.
- Test-script issue classification: one constructor-argument contract issue (`tooltip_state_test`) and one overflow/layout issue (`axis_test`).
- Bridge/generator/interpreter classification: two `BoxConstraints` operator argument-coercion issues (`toggle_buttons_theme_data_test`, `toggle_buttons_theme_test`) and one null-method-invocation issue (`axis_direction_test`).
- Known non-exhaustive switch signature in Batch-10: not detected in this batch.

## Batch-11

### Index 55

- Index: 55
- testname: `(setUpAll)` in `test/hardly_relevant_classes_3_test.dart`
- category: `TEST-HARNESS-LOG-ONLY`
- immediate fix possible: `yes`
- description: Non-failing setup output is indexed as an issue because batch extraction includes operational log messages.
- detailed analysis what the problem is: The log (`Bridge regeneration skipped: all bridge outputs are up-to-date`) is expected setup telemetry and not a bridge/generator/interpreter failure. This is a reporting-classification issue in the issue extraction process.
- fix description (if clear): Keep the setup log for traceability but mark this exact message as informational so it is excluded from issue indexing.
- need for deeper analysis?: `no`
- batch number: `11`

### Index 56

- Index: 56
- testname: `rendering/floating_header_snap_configuration_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted an overflow warning (`RenderFlex overflowed by 2.0 pixels on the bottom`).
- detailed analysis what the problem is: This is a script-level layout sizing issue in the floating-header scenario where content slightly exceeds vertical constraints. It is not a bridge registration, generator, or interpreter-language limitation.
- fix description (if clear): Adjust layout bounds in the script (bounded parent height, flexible children, or scroll fallback) and enforce zero framework warning output.
- need for deeper analysis?: `no`
- batch number: `11`

### Index 57

- Index: 57
- testname: `rendering/hit_test_behavior_test.dart`
- category: `INTERPRETER-NULL-METHOD-INVOCATION (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Runtime Error: Cannot invoke method 'withAlpha' on null. Use '?.' for null-aware method invocation.`
- detailed analysis what the problem is: The interpreted execution path attempts to call `withAlpha` on a null target, matching known null-method-invocation runtime behavior seen in other batches. The assertion failure reflects runtime null handling gaps rather than a test-only formatting warning.
- fix description (if clear): Add null-aware invocation/guards in the affected interpreter or bridge conversion path and ensure values are initialized before color transformation calls.
- need for deeper analysis?: `yes`
- batch number: `11`

### Index 58

- Index: 58
- testname: `rendering/over_scroll_header_stretch_configuration_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: This indicates a bridge coercion mismatch at a widget boundary where an interpreted object is passed through instead of a native Flutter `Widget`. This pattern matches prior widget coercion defects and is typically resolved with bridge conversion overrides/UserBridge handling.
- fix description (if clear): Add/adjust bridge conversion so interpreted instances are unwrapped/coerced to native `Widget` at the receiving constructor/method boundary; retain the test expectation and add regression coverage.
- need for deeper analysis?: `yes`
- batch number: `11`

### Index 59

- Index: 59
- testname: `rendering/pipeline_manifold_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted runtime warning: undefined `_manifold` caused by `LateInitializationError` (late variable accessed before assignment).
- detailed analysis what the problem is: The scenario path reaches `_manifold` usage before initialization, indicating script state/order-of-operations debt. Because this surfaces as warning output in a success result, it should be treated as script correctness debt rather than ignored harness noise.
- fix description (if clear): Ensure `_manifold` is assigned on all execution paths before access, or refactor to nullable/state-guarded access with explicit initialization checks.
- need for deeper analysis?: `no`
- batch number: `11`

## Batch-11 Classification Summary

- Missing/stray status for Batch-11 scripts: none missing, none stray.
- Test-script issue classification: one harness-log classification item (`setUpAll`), one overflow warning (`floating_header_snap_configuration_test`), and one late-initialization/state-order issue (`pipeline_manifold_test`).
- Bridge/generator/interpreter classification: one bridge widget-coercion mismatch (`over_scroll_header_stretch_configuration_test`) and one interpreter null-method-invocation failure (`hit_test_behavior_test`).
- Known non-exhaustive switch signature in Batch-11: not detected in this batch.

## Batch-12

### Index 60

- Index: 60
- testname: `rendering/placeholder_span_index_semantics_tag_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted runtime warning: undefined `_manifold` due to `LateInitializationError` (late variable accessed before assignment).
- detailed analysis what the problem is: The script reaches `_manifold` usage before initialization in at least one path. This is script-level state sequencing debt and not a direct bridge/generator/interpreter type-cast issue.
- fix description (if clear): Initialize `_manifold` before all dependent operations, or gate access behind explicit initialized-state checks.
- need for deeper analysis?: `no`
- batch number: `12`

### Index 61

- Index: 61
- testname: `rendering/platform_view_render_box_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted runtime warning: undefined `_controller` caused by `LateInitializationError`.
- detailed analysis what the problem is: The script accesses a late-bound controller before assignment. This is a scenario initialization-order problem and should be corrected even though the test result is success.
- fix description (if clear): Ensure `_controller` is assigned on every setup path before it is used; add guard assertions to fail fast on uninitialized state.
- need for deeper analysis?: `no`
- batch number: `12`

### Index 62

- Index: 62
- testname: `rendering/render_abstract_viewport_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted overflow warning (`RenderFlex overflowed by 70 pixels on the right`).
- detailed analysis what the problem is: The scripted viewport/layout composition exceeds horizontal constraints significantly. This is a script-level layout contract issue and not an interpreter limitation signature.
- fix description (if clear): Constrain horizontal layout (use `Expanded`/`Flexible`, width constraints, or scroll strategy) and enforce zero framework warnings.
- need for deeper analysis?: `no`
- batch number: `12`

### Index 63

- Index: 63
- testname: `rendering/render_android_view_test.dart`
- category: `INTERPRETER-NON-EXHAUSTIVE-SWITCH (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted runtime warning during bridged `Iterable.toList`: switch expression not exhaustive for `PlatformViewHitTestBehavior.opaque`.
- detailed analysis what the problem is: This matches a known interpreter limitation pattern where enum-switch handling is incomplete for bridged values. In this case it surfaces inside native/bridged list conversion path and should be treated as runtime handling debt, not harmless script noise.
- fix description (if clear): Add interpreter/bridge exhaustive enum handling for all `PlatformViewHitTestBehavior` values (including `opaque`), and keep a script-level workaround only if runtime fix cannot be delivered immediately.
- need for deeper analysis?: `yes`
- batch number: `12`

### Index 64

- Index: 64
- testname: `rendering/render_animated_opacity_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but framework emitted runtime warning: undefined `_curvedAnimation` due to `LateInitializationError`.
- detailed analysis what the problem is: The script references a late-bound animation object before it is initialized in one or more execution branches. This is script state orchestration debt and not a bridge registration gap.
- fix description (if clear): Initialize `_curvedAnimation` during setup before use and add explicit initialization-path assertions.
- need for deeper analysis?: `no`
- batch number: `12`

## Batch-12 Classification Summary

- Missing/stray status for Batch-12 scripts: none missing, none stray.
- Test-script issue classification: three state-initialization warning issues (`placeholder_span_index_semantics_tag_test`, `platform_view_render_box_test`, `render_animated_opacity_mixin_test`) and one overflow issue (`render_abstract_viewport_test`).
- Bridge/generator/interpreter classification: one known interpreter non-exhaustive switch issue (`render_android_view_test`) in bridged list-conversion flow.
- Known non-exhaustive switch signature in Batch-12: detected in `render_android_view_test` for `PlatformViewHitTestBehavior.opaque`.

## Batch-13

### Index 65

- Index: 65
- testname: `rendering/render_animated_size_state_test.dart`
- category: `BRIDGE-WIDGET-COERCION + TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted two framework errors: bridged `ConstrainedBox` child argument type mismatch (`Widget?` expected, got `InterpretedInstance(_MeasureBox)`) and a `RenderFlex` bottom overflow.
- detailed analysis what the problem is: This issue contains two defects: (1) a bridge coercion gap at constructor argument boundary where interpreted widget instances are not converted to native `Widget`; and (2) script layout sizing that still overflows slightly. The test assertion itself is not failing, but warning output confirms runtime and layout debt.
- fix description (if clear): Add bridge/UserBridge conversion for `ConstrainedBox(child: ...)` widget arguments to coerce interpreted instances to native widgets, and adjust scenario layout bounds to eliminate overflow warnings.
- need for deeper analysis?: `yes`
- batch number: `13`

### Index 66

- Index: 66
- testname: `rendering/render_clip_r_superellipse_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but repeated native constructor errors show `Text` received null `data` where `String` is required.
- detailed analysis what the problem is: This is a script input-contract problem where one or more code paths pass null into `Text(data: ...)`. Repetition indicates shared helper/state path reuse rather than a one-off instance.
- fix description (if clear): Ensure all `Text` constructor invocations in the scenario provide non-null string values (default/fallback labels where needed) and fail fast if null data would be passed.
- need for deeper analysis?: `no`
- batch number: `13`

### Index 67

- Index: 67
- testname: `rendering/render_editable_painter_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted the recurring editable layout chain: negative minimum height, `_RenderEditableCustomPaint` not laid out, and semantics assertion failure.
- detailed analysis what the problem is: This matches known script-side invalid constraint composition around editable render objects and is not a bridge/generator defect signal by itself. It is a recurrent framework-layout warning pattern seen in earlier batches.
- fix description (if clear): Rework editable host constraints to always provide bounded non-negative dimensions and validate zero framework warnings in the script.
- need for deeper analysis?: `no`
- batch number: `13`

### Index 68

- Index: 68
- testname: `rendering/render_sliver_box_child_manager_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted repeated type-cast errors: `InterpretedInstance` is not a subtype of `Widget?`.
- detailed analysis what the problem is: This is a direct bridge conversion gap where interpreted objects are flowing into widget-typed fields without proper coercion/unwrapping. The high repetition suggests a shared child-building path used multiple times.
- fix description (if clear): Add/adjust bridge conversion in the sliver child manager path so interpreted instances are converted to native `Widget` before assignment/cast.
- need for deeper analysis?: `yes`
- batch number: `13`

### Index 69

- Index: 69
- testname: `rendering/render_sliver_floating_pinned_persistent_header_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined variable `widget` (`Undefined property 'widget' on _PrimerSceneState`).
- detailed analysis what the problem is: The script uses a state/context access pattern where `widget` is referenced outside a valid State context or on an object that does not expose that property in interpreted execution.
- fix description (if clear): Refactor the script to pass required configuration explicitly instead of implicit `widget` access on `_PrimerSceneState`, and add guards for state-context availability.
- need for deeper analysis?: `yes`
- batch number: `13`

## Batch-13 Classification Summary

- Missing/stray status for Batch-13 scripts: none missing, none stray.
- Test-script issue classification: one constructor-arg contract issue (`render_clip_r_superellipse_test`), one editable layout-constraints issue (`render_editable_painter_test`), one state-context variable resolution issue (`render_sliver_floating_pinned_persistent_header_test`), and one additional overflow warning coupled with bridge defect in `render_animated_size_state_test`.
- Bridge/generator/interpreter classification: two widget coercion issues (`render_animated_size_state_test`, `render_sliver_box_child_manager_test`).
- Known non-exhaustive switch signature in Batch-13: not detected in this batch.

## Batch-14

### Index 70

- Index: 70
- testname: `rendering/render_ui_kit_view_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined variable `widget` (`Undefined property 'widget' on _PrimerSceneState`).
- detailed analysis what the problem is: This mirrors the same state-context access problem seen in adjacent rendering scripts where `widget` is referenced on a state object/path that does not expose it in interpreted execution.
- fix description (if clear): Refactor scenario data flow to pass required values explicitly instead of implicit `widget` access, and assert valid state context before reads.
- need for deeper analysis?: `yes`
- batch number: `14`

### Index 71

- Index: 71
- testname: `services/message_codec_test.dart`
- category: `BRIDGE-MISSING-MEMBER (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Undefined property or method 'lengthInBytes' on _ByteDataView`.
- detailed analysis what the problem is: The codec path expects `lengthInBytes` to be available on the bridged byte-data view object, but bridge/runtime exposure is incomplete for this member.
- fix description (if clear): Add bridge support/UserBridge override so `_ByteDataView.lengthInBytes` is exposed and typed correctly in message codec execution paths.
- need for deeper analysis?: `yes`
- batch number: `14`

### Index 72

- Index: 72
- testname: `services/method_codec_test.dart`
- category: `BRIDGE-MISSING-MEMBER (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure with `Cannot access property 'lengthInBytes' on target of type _ByteDataView`.
- detailed analysis what the problem is: This is the same root bridge-member exposure/coercion gap as Index 71, confirmed by a second codec path.
- fix description (if clear): Resolve `_ByteDataView.lengthInBytes` bridge exposure centrally and re-run both message and method codec tests.
- need for deeper analysis?: `yes`
- batch number: `14`

### Index 73

- Index: 73
- testname: `services/raw_key_up_event_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted 15 framework layout errors about infinite size across paragraph/padding/flex/decorated/constrained boxes.
- detailed analysis what the problem is: The script composes a subtree under unbounded constraints, repeatedly triggering infinite-size layout assertions. This is a script scaffold/layout-contract issue rather than a bridge/generator defect.
- fix description (if clear): Constrain parent/container sizes in the raw-key-up scenario, ensure bounded layout for descendants, and enforce zero framework warning output.
- need for deeper analysis?: `no`
- batch number: `14`

### Index 74

- Index: 74
- testname: `(setUpAll)` in `test/hardly_relevant_classes_4_test.dart`
- category: `TEST-HARNESS-LOG-ONLY`
- immediate fix possible: `yes`
- description: Non-failing setup output is indexed as an issue due to log extraction rules.
- detailed analysis what the problem is: The bridge-regeneration skipped message is expected setup telemetry and not an actual runtime/script defect.
- fix description (if clear): Keep this output in raw logs but classify it as informational so it is excluded from issue indexing.
- need for deeper analysis?: `no`
- batch number: `14`

## Batch-14 Classification Summary

- Missing/stray status for Batch-14 scripts: none missing, none stray.
- Test-script issue classification: one state-context issue (`render_ui_kit_view_test`), one large unbounded-layout issue (`raw_key_up_event_test`), and one harness-log classification item (`setUpAll` in `hardly_relevant_classes_4_test.dart`).
- Bridge/generator/interpreter classification: shared bridge missing-member issue for `_ByteDataView.lengthInBytes` affecting `message_codec_test` and `method_codec_test`.
- Known non-exhaustive switch signature in Batch-14: not detected in this batch.

## Batch-15

### Index 75

- Index: 75
- testname: `widgets/action_listener_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined `_dispatcher` due to late initialization before assignment.
- detailed analysis what the problem is: The scenario accesses a late-bound dispatcher before initialization, indicating script setup ordering debt.
- fix description (if clear): Initialize `_dispatcher` in all setup paths before use and add guard assertions for initialized state.
- need for deeper analysis?: `no`
- batch number: `15`

### Index 76

- Index: 76
- testname: `widgets/align_transition_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined `_alignmentAnimation` due to late initialization before assignment.
- detailed analysis what the problem is: This is another script state-order issue where animation state is consumed before initialization.
- fix description (if clear): Ensure `_alignmentAnimation` is initialized before widget build/use paths and enforce initialization checks.
- need for deeper analysis?: `no`
- batch number: `15`

### Index 77

- Index: 77
- testname: `widgets/android_view_surface_test.dart`
- category: `BRIDGE-MISSING-CONSTRUCTOR-MEMBER (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning: `Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.`
- detailed analysis what the problem is: Constructor/static-member bridge exposure for `EagerGestureRecognizer` is incomplete, so scripted constructor invocation cannot resolve the expected entry point.
- fix description (if clear): Add bridge/UserBridge constructor mapping so `EagerGestureRecognizer` constructor (`new`) is exposed and callable in interpreted execution.
- need for deeper analysis?: `yes`
- batch number: `15`

### Index 78

- Index: 78
- testname: `widgets/animated_positioned_directional_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined variable `context` (`Undefined property 'context' on _AnimatedPositionedDirectionalDemoState`).
- detailed analysis what the problem is: The script relies on implicit state/context access where `context` is unavailable on the object path being used in interpreted execution.
- fix description (if clear): Refactor the demo script to pass context-dependent values explicitly and avoid property lookups on incompatible state objects.
- need for deeper analysis?: `yes`
- batch number: `15`

### Index 79

- Index: 79
- testname: `widgets/app_kit_view_test.dart`
- category: `BRIDGE-MISSING-CONSTRUCTOR-MEMBER (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning repeats `Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.`
- detailed analysis what the problem is: Same bridge constructor/member exposure gap as Index 77, now triggered through app-kit view scenario path.
- fix description (if clear): Resolve `EagerGestureRecognizer` constructor bridge support once and re-run both `android_view_surface_test` and `app_kit_view_test`.
- need for deeper analysis?: `yes`
- batch number: `15`

## Batch-15 Classification Summary

- Missing/stray status for Batch-15 scripts: none missing, none stray.
- Test-script issue classification: two state-initialization issues (`action_listener_test`, `align_transition_test`) and one state-context access issue (`animated_positioned_directional_test`).
- Bridge/generator/interpreter classification: shared missing constructor/member bridge exposure for `EagerGestureRecognizer` affecting `android_view_surface_test` and `app_kit_view_test`.
- Known non-exhaustive switch signature in Batch-15: not detected in this batch.

## Batch-16

### Index 80

- Index: 80
- testname: `widgets/autocomplete_highlighted_option_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined variable `widget` (`Undefined property 'widget' on _HighlightLaneState`).
- detailed analysis what the problem is: The script accesses `widget` on a state/object path where that property is not available in interpreted execution context.
- fix description (if clear): Refactor state/context handling to pass needed values explicitly and avoid implicit `widget` property access on incompatible objects.
- need for deeper analysis?: `yes`
- batch number: `16`

### Index 81

- Index: 81
- testname: `widgets/autofill_group_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined variable `widget` (`Undefined property 'widget' on _AutofillLaneState`).
- detailed analysis what the problem is: Same state-context access pattern as Index 80, confirming script paths relying on unavailable `widget` access during interpreted execution.
- fix description (if clear): Apply the same explicit data/context passing pattern and remove implicit `widget` property reads from this state path.
- need for deeper analysis?: `yes`
- batch number: `16`

### Index 82

- Index: 82
- testname: `widgets/automatic_keep_alive_client_mixin_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted 51 framework errors about infinite-size layout across multiple render object types.
- detailed analysis what the problem is: The scenario composes a large subtree under unbounded constraints, causing cascading infinite-size assertions (`RenderParagraph`, `RenderPadding`, `RenderFlex`, `RenderDecoratedBox`, `RenderConstrainedBox`, `_RenderColoredBox`). This is a script scaffold/layout-contract issue.
- fix description (if clear): Constrain parent/container dimensions for all branches in the automatic-keep-alive scenario and enforce zero framework warning output.
- need for deeper analysis?: `no`
- batch number: `16`

### Index 83

- Index: 83
- testname: `widgets/back_button_listener_test.dart`
- category: `BRIDGE-GENERIC-CONSTRUCTOR-FACTORY (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning shows generic constructor factory error for `Router`: null-check operator used on a null value.
- detailed analysis what the problem is: This matches the known generic-constructor factory failure class where type extraction/constructor argument mapping is incomplete in bridge/runtime factory handling.
- fix description (if clear): Add/adjust UserBridge or generator-side generic constructor factory handling for `Router`, ensuring non-null typed extraction before null-checks.
- need for deeper analysis?: `yes`
- batch number: `16`

### Index 84

- Index: 84
- testname: `widgets/backdrop_group_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports undefined variable `setState` (`Undefined property 'setState' on _BackdropGroupDeepDemoState`).
- detailed analysis what the problem is: The script is calling `setState` through an object path that does not expose state lifecycle methods in this interpreted context.
- fix description (if clear): Rework state update flow to invoke updates from a valid `State` context or use explicit callback/state handlers instead of direct property lookup.
- need for deeper analysis?: `yes`
- batch number: `16`

## Batch-16 Classification Summary

- Missing/stray status for Batch-16 scripts: none missing, none stray.
- Test-script issue classification: three state-context access issues (`autocomplete_highlighted_option_test`, `autofill_group_state_test`, `backdrop_group_test`) and one major layout-constraints issue (`automatic_keep_alive_client_mixin_test`).
- Bridge/generator/interpreter classification: one generic-constructor factory issue in `Router` handling (`back_button_listener_test`).
- Known non-exhaustive switch signature in Batch-16: not detected in this batch.

## Batch-17

### Index 85

- Index: 85
- testname: `widgets/border_tween_test.dart`
- category: `TEST-SCRIPT-BORDER-CONTRACT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted border assertions: borderRadius requires uniform border colors and hairline borders cannot use non-zero borderRadius.
- detailed analysis what the problem is: The scenario constructs border combinations that violate Flutter border painting invariants (non-uniform `BorderSide.color` with rounded radius, and hairline border with radius). This is a script input-contract problem.
- fix description (if clear): Adjust test/demo border inputs to use uniform colors when radius is applied and avoid hairline `BorderSide(width: 0.0)` with non-zero borderRadius.
- need for deeper analysis?: `no`
- batch number: `17`

### Index 86

- Index: 86
- testname: `widgets/box_scroll_view_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but bridged `SizedBox` constructor rejected `child` because `Widget?` was expected and `InterpretedInstance(_PaletteStripBoxScrollView)` was provided.
- detailed analysis what the problem is: This is a bridge coercion gap at constructor argument boundary where interpreted widget instances are not converted/unwrapped to native Flutter `Widget`.
- fix description (if clear): Add bridge/UserBridge coercion for `SizedBox(child: ...)` argument handling so interpreted widget instances are converted to native widgets before constructor invocation.
- need for deeper analysis?: `yes`
- batch number: `17`

### Index 87

- Index: 87
- testname: `widgets/clip_r_superellipse_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning shows late variable `_pulse` accessed before assignment.
- detailed analysis what the problem is: The script accesses animation/state variable `_pulse` before initialization in one or more execution branches.
- fix description (if clear): Ensure `_pulse` is initialized in all setup paths before use and add explicit initialized-state checks.
- need for deeper analysis?: `no`
- batch number: `17`

### Index 88

- Index: 88
- testname: `widgets/constrained_layout_builder_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted repeated `RenderFlex` overflow warnings (multiple bottom/right overflow amounts).
- detailed analysis what the problem is: Layout variants in the constrained-layout-builder scenario exceed available viewport constraints, causing recurring overflow in multiple states.
- fix description (if clear): Rework sizing and responsive constraints for each layout branch (bounded heights/widths, `Flexible`/`Expanded`, or scroll fallback) and enforce zero overflow warnings.
- need for deeper analysis?: `no`
- batch number: `17`

### Index 89

- Index: 89
- testname: `widgets/constraints_transform_box_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted multiple `RenderConstraintsTransformBox` overflow warnings on several sides.
- detailed analysis what the problem is: The transformed constraints in the scenario push render bounds beyond available region in several configurations, indicating script-side sizing/transform mismatch.
- fix description (if clear): Tune transform and constraint parameters to keep transformed child bounds within viewport/container limits, and fail script when overflow warnings occur.
- need for deeper analysis?: `no`
- batch number: `17`

## Batch-17 Classification Summary

- Missing/stray status for Batch-17 scripts: none missing, none stray.
- Test-script issue classification: one border-contract issue (`border_tween_test`), one state-initialization issue (`clip_r_superellipse_test`), and two overflow groups (`constrained_layout_builder_test`, `constraints_transform_box_test`).
- Bridge/generator/interpreter classification: one widget coercion issue in `SizedBox` child handling (`box_scroll_view_test`).
- Known non-exhaustive switch signature in Batch-17: not detected in this batch.

## Batch-18

### Index 90

- Index: 90
- testname: `widgets/context_action_test.dart`
- category: `BRIDGE-MAP-TYPE-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Plain failure in `Actions` constructor because interpreted map values cannot be converted to `Map<Type, Action<Intent>>`.
- detailed analysis what the problem is: This is a typed-map coercion gap in bridge/runtime argument conversion for generic map values (`Action<Intent>`), not a script layout warning.
- fix description (if clear): Add bridge/UserBridge conversion for `Actions(actions: ...)` map entries so interpreted values are converted/validated as `Action<Intent>` before native constructor invocation.
- need for deeper analysis?: `yes`
- batch number: `18`

### Index 91

- Index: 91
- testname: `widgets/default_selection_style_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT + BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted repeated `widget` undefined-property warnings plus `DefaultSelectionStyle.merge` child parameter type mismatch (`expected Widget`, got interpreted instances).
- detailed analysis what the problem is: Two defects co-exist: (1) script state-context property access (`widget`) on incompatible state path, and (2) bridge coercion gap for `child` widget arguments in static `DefaultSelectionStyle.merge` call paths.
- fix description (if clear): Refactor script to avoid implicit `widget` property reads and add bridge conversion for `DefaultSelectionStyle.merge(child: ...)` so interpreted children coerce to native widgets.
- need for deeper analysis?: `yes`
- batch number: `18`

### Index 92

- Index: 92
- testname: `widgets/default_text_editing_shortcuts_test.dart`
- category: `BRIDGE-MAP-TYPE-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but repeated `Shortcuts` constructor failures report inability to convert interpreted map to `Map<ShortcutActivator, Intent>`.
- detailed analysis what the problem is: This is another typed-map coercion deficiency in bridge conversion logic for generic key/value map types used by shortcut configuration.
- fix description (if clear): Add bridge/generator conversion for `Shortcuts(shortcuts: ...)` map keys and values to correctly materialize `ShortcutActivator` and `Intent` types.
- need for deeper analysis?: `yes`
- batch number: `18`

### Index 93

- Index: 93
- testname: `widgets/default_text_style_transition_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but runtime warning reports late variable `_heroStyle` accessed before assignment.
- detailed analysis what the problem is: The style variable initialization order is incorrect in at least one script path, producing late-init runtime warnings despite successful test completion.
- fix description (if clear): Initialize `_heroStyle` before any reads in all branches and add explicit initialized-state checks in the script.
- need for deeper analysis?: `no`
- batch number: `18`

### Index 94

- Index: 94
- testname: `widgets/draggable_scrollable_actuator_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted six runtime warnings where `widget` is undefined across multiple scene-state classes.
- detailed analysis what the problem is: The scenario repeatedly uses implicit `widget` property access on state/object paths that do not expose it in interpreted execution, indicating a shared script pattern issue.
- fix description (if clear): Replace implicit `widget` property accesses with explicit constructor/state fields or pass required values through callbacks/parameters for each affected scene state.
- need for deeper analysis?: `yes`
- batch number: `18`

## Batch-18 Classification Summary

- Missing/stray status for Batch-18 scripts: none missing, none stray.
- Test-script issue classification: one state-initialization issue (`default_text_style_transition_test`) and two state-context issue groups (`default_selection_style_test`, `draggable_scrollable_actuator_test`).
- Bridge/generator/interpreter classification: map-type coercion issues in `Actions`/`Shortcuts` constructor paths (`context_action_test`, `default_text_editing_shortcuts_test`) and widget-coercion gap in `DefaultSelectionStyle.merge` (`default_selection_style_test`).
- Known non-exhaustive switch signature in Batch-18: not detected in this batch.

## Batch-19

### Index 95

- Index: 95
- testname: `widgets/expansible_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings where `widget` is undefined across scene-state classes.
- detailed analysis what the problem is: The deep-demo scenario accesses `widget` via state/object paths that do not expose that property in interpreted execution, causing repeated undefined-property warnings.
- fix description (if clear): Refactor scene state code to pass required values explicitly (constructor fields/callbacks) rather than implicit `widget` property lookups.
- need for deeper analysis?: `yes`
- batch number: `19`

### Index 96

- Index: 96
- testname: `widgets/flex_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted four runtime warnings for undefined `widget` on multiple flex demo scene states.
- detailed analysis what the problem is: Same state-context access pattern as Index 95, indicating script architecture relying on unavailable implicit state properties.
- fix description (if clear): Apply the same explicit state/data wiring pattern for all flex scene states and remove direct `widget` property reads on incompatible objects.
- need for deeper analysis?: `yes`
- batch number: `19`

### Index 97

- Index: 97
- testname: `widgets/fractional_translation_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted four runtime warnings for undefined `widget` across comparison/hit-test/clip/practical scene states.
- detailed analysis what the problem is: Repeated undefined-property warnings confirm the same script-level state-context pattern issue across multiple scene modules.
- fix description (if clear): Replace implicit `widget` access with explicit props or captured values in each scene state lifecycle.
- need for deeper analysis?: `yes`
- batch number: `19`

### Index 98

- Index: 98
- testname: `widgets/hero_controller_scope_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across hero controller scope scene states.
- detailed analysis what the problem is: The demo’s state objects depend on implicit `widget` lookup not available in interpreted path, producing repetitive warning-only failures.
- fix description (if clear): Refactor hero scope scenes to use explicit field/config passing and avoid direct `widget` property reads.
- need for deeper analysis?: `yes`
- batch number: `19`

### Index 99

- Index: 99
- testname: `widgets/hero_controller_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across observer/tween/diversion/controller/practical hero scene states.
- detailed analysis what the problem is: Same root state-context resolution issue as indices 95-98, replicated in hero controller variants.
- fix description (if clear): Apply shared deep-demo state-context fix pattern and add guard assertions to fail when undefined-state property access occurs.
- need for deeper analysis?: `yes`
- batch number: `19`

## Batch-19 Classification Summary

- Missing/stray status for Batch-19 scripts: none missing, none stray.
- Test-script issue classification: five state-context access issue groups (`expansible_test`, `flex_test`, `fractional_translation_test`, `hero_controller_scope_test`, `hero_controller_test`).
- Bridge/generator/interpreter classification: no direct new bridge/generator/interpreter signature beyond the repeated script state-context property resolution pattern.
- Known non-exhaustive switch signature in Batch-19: not detected in this batch.

## Batch-20

### Index 100

- Index: 100
- testname: `widgets/icon_data_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across icon-data deep-demo scene states.
- detailed analysis what the problem is: Scene state classes (`_CodePointComposerSceneState`, `_EqualityHashSceneState`, `_DirectionalitySceneState`, `_FamilyFallbackSceneState`, `_PracticalRegistrySceneState`) access `widget` through paths not resolved in interpreted execution.
- fix description (if clear): Move required config/data into explicit fields passed to each scene state and remove implicit `widget` property lookups.
- need for deeper analysis?: `yes`
- batch number: `20`

### Index 101

- Index: 101
- testname: `widgets/icon_theme_data_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across icon-theme scene states.
- detailed analysis what the problem is: Runtime logs show undefined `widget` on `_FundamentalsSceneState`, `_MergeAndCopySceneState`, `_LerpSceneState`, `_PrecedenceSceneState`, and `_PracticalDashboardSceneState`, indicating repeated state-context misuse.
- fix description (if clear): Refactor scenes to consume explicit constructor parameters/captured values rather than implicit `widget` property access.
- need for deeper analysis?: `yes`
- batch number: `20`

### Index 102

- Index: 102
- testname: `widgets/ignore_baseline_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted six runtime warnings for undefined `widget` across baseline/comparison/flex/rhythm/practical scenes.
- detailed analysis what the problem is: The same undefined-property pattern appears on `_BaselinePrimerSceneState`, `_ComparisonSceneState`, `_NestedFlexSceneState`, `_RhythmStudioSceneState`, `_StressMatrixSceneState`, and `_PracticalSceneState`.
- fix description (if clear): Apply the deep-demo state wiring fix consistently across all ignore-baseline scenes and add guard checks against unresolved state properties.
- need for deeper analysis?: `yes`
- batch number: `20`

### Index 103

- Index: 103
- testname: `widgets/image_icon_test.dart`
- category: `TEST-SCRIPT-STATE-INITIALIZATION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted one runtime warning where late variable `_bundleFuture` was accessed before assignment.
- detailed analysis what the problem is: The scene flow reads `_bundleFuture` before initialization completes, triggering `LateInitializationError` under interpreted execution timing.
- fix description (if clear): Initialize `_bundleFuture` eagerly (or nullable + guarded access) before any read path and enforce setup ordering in scene lifecycle.
- need for deeper analysis?: `yes`
- batch number: `20`

### Index 104

- Index: 104
- testname: `widgets/img_element_platform_view_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across source/layout/hit-test/fallback/practical scenes.
- detailed analysis what the problem is: Undefined-property warnings on `_SourceStudioSceneState`, `_LayoutMatrixSceneState`, `_LayerHitTestSceneState`, `_FallbackDiagnosticsSceneState`, and `_PracticalBoardSceneState` show recurring unresolved state-context access.
- fix description (if clear): Replace implicit `widget` reads with explicit scene configuration injection and shared helper accessors.
- need for deeper analysis?: `yes`
- batch number: `20`

## Batch-20 Classification Summary

- Missing/stray status for Batch-20 scripts: none missing, none stray.
- Test-script issue classification: four state-context access issue groups (`icon_data_test`, `icon_theme_data_test`, `ignore_baseline_test`, `img_element_platform_view_test`) and one state-initialization issue (`image_icon_test`).
- Bridge/generator/interpreter classification: no new bridge/generator signature beyond recurring deep-demo state-context property resolution and one script-level late-initialization ordering defect.
- Known non-exhaustive switch signature in Batch-20: not detected in this batch.

## Batch-21

### Index 105

- Index: 105
- testname: `widgets/keep_alive_handle_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted 27 framework/layout errors (unbounded width constraints and repeated `RenderBox was not laid out` assertions).
- detailed analysis what the problem is: The demo composes flex-based rows in a horizontally unconstrained viewport path; this produces cascading layout failures (`hasSize` assertions) and semantics/layout invalid state while still reporting success.
- fix description (if clear): Constrain horizontal size explicitly (e.g., `SizedBox`/`ConstrainedBox`), avoid `Expanded/Flexible` in unbounded axis contexts, and add a guard assertion that fails the test when framework layout errors are logged.
- need for deeper analysis?: `yes`
- batch number: `21`

### Index 106

- Index: 106
- testname: `widgets/keyboard_listener_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across keyboard-listener scene states.
- detailed analysis what the problem is: Scene states (`_FocusArenaSceneState`, `_KeyStreamAnalyzerSceneState`, `_ShortcutConsoleSceneState`, `_BoundaryLabSceneState`, `_PracticalWorkspaceSceneState`) rely on implicit `widget` access paths unresolved in interpreted execution.
- fix description (if clear): Refactor scene state objects to receive explicit configuration values and remove implicit `widget` property lookups.
- need for deeper analysis?: `yes`
- batch number: `21`

### Index 107

- Index: 107
- testname: `widgets/layout_id_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across layout-id scene states.
- detailed analysis what the problem is: Runtime logs show the same unresolved state-context pattern on `_FundamentalsSceneState`, `_PatternGallerySceneState`, `_ConstraintLabSceneState`, `_ResponsiveSceneState`, and `_PracticalWorkspaceSceneState`.
- fix description (if clear): Apply the shared deep-demo state wiring approach with explicit constructor fields/captured references instead of `widget` property reads.
- need for deeper analysis?: `yes`
- batch number: `21`

### Index 108

- Index: 108
- testname: `widgets/live_text_input_status_test.dart`
- category: `BRIDGE-NULL-RECEIVER-METHOD-INVOCATION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with runtime error `Cannot invoke method 'withValues' on null`.
- detailed analysis what the problem is: A color/value transformation path calls `withValues` on a nullable receiver under interpreted/bridged execution, causing a hard failure before expected assertions complete.
- fix description (if clear): Introduce null-safe receiver handling in the affected script path and add bridge-side/custom-cast safeguards so nullable color values are normalized before invoking `withValues`.
- need for deeper analysis?: `yes`
- batch number: `21`

### Index 109

- Index: 109
- testname: `widgets/lock_state_test.dart`
- category: `BRIDGE-NULL-RECEIVER-METHOD-INVOCATION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with the same runtime error: `Cannot invoke method 'withValues' on null`.
- detailed analysis what the problem is: The lock-state flow hits the same nullable receiver invocation defect as Index 108, indicating a shared conversion/normalization gap in the live-text/lock-state value pipeline.
- fix description (if clear): Reuse the Batch-21 null-receiver mitigation: enforce non-null defaults or null-aware invocation before `withValues`, and validate in bridge/custom conversion hooks.
- need for deeper analysis?: `yes`
- batch number: `21`

## Batch-21 Classification Summary

- Missing/stray status for Batch-21 scripts: none missing, none stray.
- Test-script issue classification: one layout-constraints warning cluster (`keep_alive_handle_test`) and two state-context warning groups (`keyboard_listener_test`, `layout_id_test`).
- Bridge/generator/interpreter classification: two null-receiver method-invocation failures (`live_text_input_status_test`, `lock_state_test`) likely requiring script null-guarding plus bridge/custom-cast normalization for `withValues` receiver values.
- Known non-exhaustive switch signature in Batch-21: not detected in this batch.

## Batch-22

### Index 110

- Index: 110
- testname: `widgets/logical_key_set_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted 13 framework/layout warnings including repeated infinite-size layout errors and non-finite semantics rect assertion.
- detailed analysis what the problem is: Logical-key-set scene composition triggers unbounded-layout chains (`RenderParagraph`/`RenderPadding`/`RenderFlex`/`RenderTable`) that propagate invalid geometry into semantics (`SemanticsNode` non-finite rect), indicating missing finite constraints in the demo layout path.
- fix description (if clear): Apply explicit finite constraints for key-set demo containers, remove unbounded flex combinations, and add fail-fast assertions when non-finite layout/semantics diagnostics are emitted.
- need for deeper analysis?: `yes`
- batch number: `22`

### Index 111

- Index: 111
- testname: `widgets/lookup_boundary_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across lookup-boundary scenes.
- detailed analysis what the problem is: Scene states (`_BoundaryVisibilitySceneState`, `_InheritedScopeSceneState`, `_StateLookupSceneState`, `_TraversalRenderSceneState`, `_PracticalSandboxSceneState`) rely on implicit `widget` access not resolved in interpreted execution.
- fix description (if clear): Refactor scenes to pass required values explicitly and remove implicit `widget` property reads.
- need for deeper analysis?: `yes`
- batch number: `22`

### Index 112

- Index: 112
- testname: `widgets/matrix_transition_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across matrix-transition scenes.
- detailed analysis what the problem is: Runtime warnings on `_FundamentalsSceneState`, `_WorkshopSceneState`, `_AlignmentFilterSceneState`, `_KeyframeSceneState`, and `_PracticalSceneState` match the recurring deep-demo state-context resolution defect.
- fix description (if clear): Use explicit scene config injection/captured references instead of implicit `widget` property access paths.
- need for deeper analysis?: `yes`
- batch number: `22`

### Index 113

- Index: 113
- testname: `widgets/meta_data_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across metadata scenes.
- detailed analysis what the problem is: Undefined-property warnings on `_FundamentalsSceneState`, `_OverlapBehaviorSceneState`, `_HoverInspectorSceneState`, `_CatalogSceneState`, and `_PracticalSceneState` indicate the same unresolved state-context pattern.
- fix description (if clear): Apply the shared deep-demo state-context remediation by wiring explicit fields into scene state objects.
- need for deeper analysis?: `yes`
- batch number: `22`

### Index 114

- Index: 114
- testname: `widgets/modal_barrier_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across modal-barrier scenes.
- detailed analysis what the problem is: Scene states (`_FundamentalsSceneState`, `_BlockingLabSceneState`, `_WorkflowStageSceneState`, `_MatrixSceneState`, `_PracticalSceneState`) access unresolved `widget` paths in interpreted execution.
- fix description (if clear): Replace implicit `widget` lookups with explicit scene configuration passing and helper accessors.
- need for deeper analysis?: `yes`
- batch number: `22`

## Batch-22 Classification Summary

- Missing/stray status for Batch-22 scripts: none missing, none stray.
- Test-script issue classification: one layout-constraints/semantics warning cluster (`logical_key_set_test`) and four state-context warning groups (`lookup_boundary_test`, `matrix_transition_test`, `meta_data_test`, `modal_barrier_test`).
- Bridge/generator/interpreter classification: no new direct bridge/generator/interpreter signature beyond recurring deep-demo state-context property-resolution pattern; primary additional defect is script-side finite-constraints layout handling.
- Known non-exhaustive switch signature in Batch-22: not detected in this batch.

## Batch-23

### Index 115

- Index: 115
- testname: `widgets/navigator_pop_handler_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across navigator-pop-handler scenes.
- detailed analysis what the problem is: Scene states (`_FundamentalsSceneState`, `_ComparisonSceneState`, `_ResultSceneState`, `_WorkflowSceneState`, `_PracticalSceneState`) access `widget` via unresolved state-context paths in interpreted execution.
- fix description (if clear): Replace implicit `widget` lookups with explicit scene configuration fields and shared helper accessors.
- need for deeper analysis?: `yes`
- batch number: `23`

### Index 116

- Index: 116
- testname: `widgets/nested_scroll_view_state_test.dart`
- category: `BRIDGE-LIST-TYPE-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted three runtime cast errors: `List<Object?>` is not a subtype of `List<Widget>`.
- detailed analysis what the problem is: Nested-scroll state flow passes interpreted list values through a typed widget-list boundary without coercion, causing runtime cast failures in header/body composition.
- fix description (if clear): Add bridge/custom cast normalization for list element coercion to `Widget` and enforce typed list construction in the script before crossing bridge boundaries.
- need for deeper analysis?: `yes`
- batch number: `23`

### Index 117

- Index: 117
- testname: `widgets/nested_scroll_view_viewport_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across viewport/coordinator/overlap scenes.
- detailed analysis what the problem is: `_ViewportAnatomySceneState`, `_CoordinatorSceneState`, `_OverlapComparisonSceneState`, `_AnchorClipSceneState`, and `_PracticalSceneState` use unresolved implicit `widget` access.
- fix description (if clear): Apply the shared deep-demo state-context remediation pattern with explicit scene wiring.
- need for deeper analysis?: `yes`
- batch number: `23`

### Index 118

- Index: 118
- testname: `widgets/next_focus_intent_test.dart`
- category: `BRIDGE-STATIC-METHOD-ASSERTION (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted a native bridge assertion during static call `Actions.maybeFind` (`type != Intent`).
- detailed analysis what the problem is: The bridged static invocation path forwards an invalid or too-generic intent type into `Actions.maybeFind`, tripping framework assertion guards for intent lookup.
- fix description (if clear): Tighten static bridge argument typing for intent classes and add script-side validation to ensure a concrete non-`Intent` subclass type is passed.
- need for deeper analysis?: `yes`
- batch number: `23`

### Index 119

- Index: 119
- testname: `widgets/notifiable_element_mixin_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted 13 layout warnings with repeated infinite-size render-object failures.
- detailed analysis what the problem is: Notifiable-element scene composition enters unbounded layout paths (`RenderParagraph`/`RenderPositionedBox`/`RenderFlex`/`RenderPadding`) that cascade into repeated infinite-size diagnostics.
- fix description (if clear): Introduce explicit finite constraints in demo containers, avoid unbounded flex compositions, and fail test runs when framework layout warnings are reported.
- need for deeper analysis?: `yes`
- batch number: `23`

## Batch-23 Classification Summary

- Missing/stray status for Batch-23 scripts: none missing, none stray.
- Test-script issue classification: two state-context warning groups (`navigator_pop_handler_test`, `nested_scroll_view_viewport_test`) and one layout-constraints warning cluster (`notifiable_element_mixin_test`).
- Bridge/generator/interpreter classification: one list-type coercion failure (`nested_scroll_view_state_test`) and one bridged static method assertion path (`next_focus_intent_test`), both candidates for custom cast/UserBridge hardening.
- Known non-exhaustive switch signature in Batch-23: not detected in this batch.

## Batch-24

### Index 120

- Index: 120
- testname: `widgets/object_key_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with runtime error `'Object' is not callable (no default constructor bridge found)`.
- detailed analysis what the problem is: The object-key scenario reaches a path that requires callable default-constructor bridging for `Object`, but bridge metadata does not provide a usable constructor entry in interpreted execution.
- fix description (if clear): Reuse/extend default-constructor bridge handling for `Object` in the relevant bridge layer and ensure the script path does not attempt unbridged constructor invocation.
- need for deeper analysis?: `yes`
- batch number: `24`

### Index 121

- Index: 121
- testname: `widgets/orientation_builder_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across orientation scenes.
- detailed analysis what the problem is: `_FundamentalsSceneState`, `_AdaptiveShellSceneState`, `_ViewportLabSceneState`, `_ReflowSceneState`, and `_PracticalSceneState` all rely on implicit `widget` access unresolved in interpreted execution.
- fix description (if clear): Apply explicit scene configuration wiring and remove implicit `widget` property reads.
- need for deeper analysis?: `yes`
- batch number: `24`

### Index 122

- Index: 122
- testname: `widgets/overlay_child_location_test.dart`
- category: `TEST-SCRIPT-LAYOUT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted a `RenderFlex overflowed by 8.6 pixels on the right` warning.
- detailed analysis what the problem is: The overlay-child location demo has a constrained horizontal layout case where flex distribution exceeds available width, causing overflow diagnostics despite overall test success.
- fix description (if clear): Adjust row/flex sizing with explicit width constraints or wrapping behavior and add assertion guards that fail on overflow logs.
- need for deeper analysis?: `yes`
- batch number: `24`

### Index 123

- Index: 123
- testname: `widgets/overlay_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted five runtime warnings for undefined `widget` across overlay-state scenes.
- detailed analysis what the problem is: `_EntryManagementSceneState`, `_RearrangeSceneState`, `_AccessSceneState`, `_PropertiesSceneState`, and `_PracticalSceneState` use unresolved implicit `widget` property access.
- fix description (if clear): Refactor scene state objects to consume explicit constructor/state values rather than `widget` property lookups.
- need for deeper analysis?: `yes`
- batch number: `24`

### Index 124

- Index: 124
- testname: `(setUpAll) [test/hardly_relevant_classes_5_test.dart]`
- category: `TEST-HARNESS-LOG-ONLY (informational)`
- immediate fix possible: `no`
- description: Non-error informational log reported bridge regeneration was skipped because outputs are up to date.
- detailed analysis what the problem is: This message is operational status output from bridge generation checks, not a test failure or runtime warning; it indicates normal incremental behavior.
- fix description (if clear): No functional fix required; optionally route this message to debug-level output if cleaner test logs are desired.
- need for deeper analysis?: `no`
- batch number: `24`

## Batch-24 Classification Summary

- Missing/stray status for Batch-24 entries: none missing, none stray.
- Test-script issue classification: two state-context warning groups (`orientation_builder_test`, `overlay_state_test`) and one layout-overflow warning group (`overlay_child_location_test`).
- Bridge/generator/interpreter classification: one missing default-constructor bridge support failure (`object_key_test`); no new non-exhaustive switch signature in this batch.
- Harness/log-only classification: one informational setup log (`setUpAll` in `hardly_relevant_classes_5_test.dart`) with no functional defect.
- Known non-exhaustive switch signature in Batch-24: not detected in this batch.

## Batch-25

### Index 125

- Index: 125
- testname: `widgets/raw_dialog_route_test.dart`
- category: `BRIDGE-GENERIC-CONSTRUCTOR-FACTORY (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted runtime error from generic constructor factory for `RawDialogRoute` due to incompatible callback type.
- detailed analysis what the problem is: Bridge conversion passes an `InterpretedFunction` where `RawDialogRoute` expects a typed transition-builder callback `((BuildContext, Animation<double>, Animation<double>) => Widget)?`, causing runtime type mismatch.
- fix description (if clear): Add callback signature coercion in bridge/custom factory mapping for `RawDialogRoute` and validate function-type adaptation before constructor invocation.
- need for deeper analysis?: `yes`
- batch number: `25`

### Index 126

- Index: 126
- testname: `widgets/raw_keyboard_listener_test.dart`
- category: `BRIDGE-MISSING-SYMBOL-REGISTRATION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Undefined variable: RawKeyboardListener`.
- detailed analysis what the problem is: The runtime could not resolve `RawKeyboardListener` symbol in interpreted context, indicating missing or incomplete bridge/class registration/export path.
- fix description (if clear): Ensure `RawKeyboardListener` is exposed by the widget bridge set and available in script import/registry resolution paths.
- need for deeper analysis?: `yes`
- batch number: `25`

### Index 127

- Index: 127
- testname: `widgets/raw_menu_overlay_info_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with runtime error `'Object' is not callable (no default constructor bridge found)`.
- detailed analysis what the problem is: The raw-menu-overlay flow reaches an object-construction path that depends on default constructor bridging not currently available for the involved base object path.
- fix description (if clear): Reuse default-constructor bridge support pattern for object creation in this widget flow and avoid unbridged direct constructor calls.
- need for deeper analysis?: `yes`
- batch number: `25`

### Index 128

- Index: 128
- testname: `widgets/raw_radio_test.dart`
- category: `BRIDGE-GENERIC-CONSTRUCTOR-FACTORY (needs correction)`
- immediate fix possible: `yes`
- description: Test passed, but emitted native runtime error while bridging `Iterable.toList` through generic constructor factory for `RawRadio`.
- detailed analysis what the problem is: Constructor generic adaptation for `RawRadio` fails during iterable/list conversion in bridged method flow, indicating incomplete generic factory typing/casting for this path.
- fix description (if clear): Harden generic factory coercion for `RawRadio` constructor arguments and iterable element typing before `toList` conversion.
- need for deeper analysis?: `yes`
- batch number: `25`

### Index 129

- Index: 129
- testname: `widgets/redo_text_intent_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: Redo-intent scenario returns an interpreted object where a concrete `Widget` is required, showing unresolved widget coercion/conversion at bridge boundary.
- fix description (if clear): Apply widget coercion mapping (interpreted-instance to `Widget`) for this intent/action rendering path and add guard assertions in script setup.
- need for deeper analysis?: `yes`
- batch number: `25`

## Batch-25 Classification Summary

- Missing/stray status for Batch-25 scripts: none missing, none stray.
- Test-script issue classification: no standalone script-only warning class in this batch; failures are dominated by bridge/type-resolution/coercion defects.
- Bridge/generator/interpreter classification: two generic-constructor-factory issues (`raw_dialog_route_test`, `raw_radio_test`), one missing symbol registration (`raw_keyboard_listener_test`), one missing default-constructor support path (`raw_menu_overlay_info_test`), and one widget coercion defect (`redo_text_intent_test`).

## Batch-26

### Index 130

- Index: 130
- testname: `widgets/regular_window_controller_delegate_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The test script creates a `RegularWindowControllerDelegate` widget and pumps it, but the interpreter returns an `InterpretedInstance` instead of a concrete `Widget`. The bridge does not coerce interpreted widget instances back to their native Flutter `Widget` type when the test harness validates the result via `result.success`.
- fix description (if clear): Add widget coercion mapping for `RegularWindowControllerDelegate` at the bridge boundary so `InterpretedInstance` wrapping a Widget subclass is unwrapped to a proper `Widget` before the test assertion. Ensure the bridge `$RegularWindowControllerDelegate` type is registered with the widget coercion handler.
- need for deeper analysis?: `yes`
- batch number: `26`

### Index 131

- Index: 131
- testname: `widgets/regular_window_controller_linux_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: Same widget coercion gap as Index 130 — the Linux-specific `RegularWindowControllerLinux` widget is constructed in the interpreter but returned as `InterpretedInstance` rather than a proper `Widget`. The bridge lacks the coercion path for this platform-specific controller variant.
- fix description (if clear): Register `RegularWindowControllerLinux` in the bridge widget coercion handler so that the interpreted result is unwrapped to a native `Widget`.
- need for deeper analysis?: `yes`
- batch number: `26`

### Index 132

- Index: 132
- testname: `widgets/regular_window_controller_mac_o_s_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: Same pattern as Indices 130–131. The macOS variant `RegularWindowControllerMacOS` is interpreted but the bridge does not coerce the instance back to a `Widget` type. The test expects `result.success == true` which requires widget detection.
- fix description (if clear): Register `RegularWindowControllerMacOS` in the widget coercion handler.
- need for deeper analysis?: `yes`
- batch number: `26`

### Index 133

- Index: 133
- testname: `widgets/regular_window_controller_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The base `RegularWindowController` widget test fails with the same coercion gap. The bridge produces an `InterpretedInstance` wrapping the controller widget, but the harness cannot recognize it as a `Widget` for the success assertion.
- fix description (if clear): Register `RegularWindowController` in the widget coercion handler so the interpreted object is unwrapped.
- need for deeper analysis?: `yes`
- batch number: `26`

### Index 134

- Index: 134
- testname: `widgets/regular_window_controller_win32_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The Win32 variant `RegularWindowControllerWin32` test shows the identical widget coercion defect. All five `RegularWindowController*` tests in this batch share the same root cause — the bridge does not unwrap `InterpretedInstance` to a native `Widget` for these controller classes.
- fix description (if clear): Register `RegularWindowControllerWin32` in the widget coercion handler. A batch fix registering all `RegularWindowController*` variants at once would resolve all five issues simultaneously.
- need for deeper analysis?: `yes`
- batch number: `26`

## Batch-26 Classification Summary

- Missing/stray status for Batch-26 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: no standalone script-only warnings in this batch; all five failures are bridge-level coercion defects.
- Bridge/generator/interpreter classification: all five issues are `BRIDGE-WIDGET-COERCION` — the `RegularWindowController*` family (delegate, linux, macOS, base, win32) all fail identically because the interpreter returns `InterpretedInstance` where a concrete `Widget` is expected. A single coercion-handler registration covering the `RegularWindowController` hierarchy would resolve the entire batch.

## Batch-27

### Index 135

- Index: 135
- testname: `widgets/regular_window_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The `RegularWindow` widget is constructed inside the interpreter but returned as an `InterpretedInstance` rather than a concrete `Widget`. Same coercion gap as the `RegularWindowController*` family in Batch-26, now affecting the base `RegularWindow` class itself.
- fix description (if clear): Register `RegularWindow` in the widget coercion handler so interpretated instances are unwrapped to native `Widget` type.
- need for deeper analysis?: `yes`
- batch number: `27`

### Index 136

- Index: 136
- testname: `widgets/relative_positioned_transition_test.dart`
- category: `TEST-SCRIPT-LAYOUT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but produces 4 framework error logs: `A RenderFlex overflowed by 4.0 pixels on the bottom`.
- detailed analysis what the problem is: The test script creates a layout scenario with `RelativePositionedTransition` that causes RenderFlex overflow during animation. The test does not fail because the overflow is caught as a non-fatal framework error, but the log output indicates the demo layout constraints are too tight for the content at certain animation phases.
- fix description (if clear): Adjust the test script's container constraints (increase height or reduce child content) to prevent the 4.0-pixel bottom overflow. Alternatively, wrap the overflowing Flex in a `SingleChildScrollView` or increase the parent's `maxHeight`.
- need for deeper analysis?: `no`
- batch number: `27`

### Index 137

- Index: 137
- testname: `widgets/render_abstract_layout_builder_mixin_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The deep demo (1215 lines) for `RenderAbstractLayoutBuilderMixin` constructs a widget tree in the interpreter, but the mixin's widget result is returned as `InterpretedInstance` instead of a concrete `Widget`. The bridge does not coerce mixin-based render objects back to their widget representation.
- fix description (if clear): Register `RenderAbstractLayoutBuilderMixin` and its associated widget wrappers in the widget coercion handler, or add a UserBridge that maps the mixin's interpreted output to a `Widget`.
- need for deeper analysis?: `yes`
- batch number: `27`

### Index 138

- Index: 138
- testname: `widgets/render_nested_scroll_view_viewport_test.dart`
- category: `BRIDGE-LIST-TYPE-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast`.
- detailed analysis what the problem is: The interpreter produces a `List<Object?>` when the `RenderNestedScrollViewViewport` constructor or child builder expects a `List<Widget>`. The bridge does not automatically coerce generic list types with `Object?` elements to the expected `List<Widget>` target type. This is the same `BRIDGE-LIST-TYPE-COERCION` pattern seen in earlier batches (e.g., Batch-23 Index 117).
- fix description (if clear): Add a list coercion handler that casts `List<Object?>` to `List<Widget>` when the target parameter type is `List<Widget>`. Each element should be individually coerced through the widget coercion handler.
- need for deeper analysis?: `no`
- batch number: `27`

### Index 139

- Index: 139
- testname: `widgets/render_object_to_widget_adapter_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT (needs correction)`
- immediate fix possible: `no`
- description: Test failed with `Class '_BootstrapStepInfo' does not have an unnamed constructor that accepts arguments`.
- detailed analysis what the problem is: The deep demo (1255 lines) for `RenderObjectToWidgetAdapter` uses a private class `_BootstrapStepInfo` in its bootstrap lab. The interpreter cannot find an unnamed constructor for `_BootstrapStepInfo` that accepts arguments because private-class constructors are not bridged automatically. The bridge generator does not produce constructor bindings for private classes.
- fix description (if clear): Either make `_BootstrapStepInfo` a public class in the test script, or add a custom UserBridge that provides a factory for the private helper class. Alternatively, refactor the test to avoid private-class instantiation in interpreted code.
- need for deeper analysis?: `yes`
- batch number: `27`

## Batch-27 Classification Summary

- Missing/stray status for Batch-27 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: one layout-overflow log issue (`relative_positioned_transition_test` — RenderFlex overflow 4px, needs script constraint fix) and one list-type coercion log issue (`render_nested_scroll_view_viewport_test` — List<Object?> to List<Widget>).
- Bridge/generator/interpreter classification: two widget coercion defects (`regular_window_test`, `render_abstract_layout_builder_mixin_test`), one list-type coercion issue (`render_nested_scroll_view_viewport_test`), and one missing default-constructor support for private class `_BootstrapStepInfo` (`render_object_to_widget_adapter_test`).

## Batch-28

### Index 140

- Index: 140
- testname: `widgets/render_tap_region_surface_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The deep demo (1145 lines) for `RenderTapRegionSurface` constructs a widget tree with TapRegionRegistry and hit-test scenarios, but the interpreter returns the widget as `InterpretedInstance` instead of a concrete `Widget`. The bridge does not coerce `RenderTapRegionSurface` (or its wrapping widget) back to the native `Widget` type.
- fix description (if clear): Register `RenderTapRegionSurface` and its related widget wrappers in the widget coercion handler so interpreted instances are unwrapped to native `Widget` type.
- need for deeper analysis?: `yes`
- batch number: `28`

### Index 141

- Index: 141
- testname: `widgets/render_tap_region_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: The deep-visual demo references a `_tabController` late variable that is declared but never initialized before being accessed in the interpreted script execution. The script likely has a `State.initState()` callback that should assign the tab controller, but the interpreter does not call the state lifecycle method in the correct order or the assignment path is not bridged.
- fix description (if clear): Ensure `_tabController` is initialized before use — either move the initialization from a lifecycle callback to the constructor/declaration, or verify the `initState` bridge path invokes properly. Alternatively, add a null guard or replace the late field with a nullable field plus null-check.
- need for deeper analysis?: `no`
- batch number: `28`

### Index 142

- Index: 142
- testname: `widgets/render_tree_root_element_test.dart`
- category: `BRIDGE-NULL-RECEIVER-METHOD-INVOCATION (needs correction)`
- immediate fix possible: `no`
- description: Test passes but logs: `Native error during bridged method call 'visitAncestorElements' on StatelessElement: LateInitializationError: Field '_children@24042623' has not been initialized.`
- detailed analysis what the problem is: The test calls `visitAncestorElements` on a `StatelessElement`, but the element's internal `_children` field (a framework-private late field) has not been initialized at the point of the call. This happens because the element tree is not fully mounted when the interpreted code traverses it. The bridge invokes the native method, which throws a `LateInitializationError` on the uninitialized private field.
- fix description (if clear): Defer the `visitAncestorElements` call until after the element tree is fully built and mounted (e.g., inside `WidgetsBinding.instance.addPostFrameCallback`). Alternatively, wrap the call in a try-catch in the test script to handle the case where the tree is not yet ready.
- need for deeper analysis?: `yes`
- batch number: `28`

### Index 143

- Index: 143
- testname: `widgets/render_two_dimensional_viewport_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same pattern as Index 141 — the deep-visual demo for `RenderTwoDimensionalViewport` references a `_tabController` late variable that is not initialized before access. The state lifecycle bridge does not call `initState` properly or the assignment is not reflected in the interpreter's variable scope.
- fix description (if clear): Same fix as Index 141 — initialize `_tabController` in the constructor/declaration or guard with null-check. This is likely a shared tab-controller initialization pattern across multiple deep-visual demos.
- need for deeper analysis?: `no`
- batch number: `28`

### Index 144

- Index: 144
- testname: `widgets/render_web_image_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same pattern as Indices 141 and 143 — the deep-visual demo for `RenderWebImage` references a `_tabController` late variable that is not initialized. Three of the five Batch-28 issues share this identical `_tabController` late-init pattern, indicating a systematic issue in the deep-visual demo template used for these scripts.
- fix description (if clear): Same fix as Indices 141/143. A template-level fix initializing `_tabController` inline or in the constructor body would resolve all three scripts at once.
- need for deeper analysis?: `no`
- batch number: `28`

## Batch-28 Classification Summary

- Missing/stray status for Batch-28 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three `_tabController` late-initialization errors (`render_tap_region_test`, `render_two_dimensional_viewport_test`, `render_web_image_test`) — these are deep-visual demo template issues, fixable by adjusting the tab-controller setup pattern.
- Bridge/generator/interpreter classification: one widget coercion defect (`render_tap_region_surface_test`), and one `visitAncestorElements` bridge call hitting uninitialized `_children` field (`render_tree_root_element_test` — BRIDGE-NULL-RECEIVER-METHOD-INVOCATION).

## Batch-29

### Index 145

- Index: 145
- testname: `widgets/repeat_mode_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: The deep-visual demo for `RepeatMode` references a `_tabController` late variable that is not initialized before access. This is the same systematic deep-visual demo template issue seen in Batch-28 (Indices 141, 143, 144). The state lifecycle bridge does not call `initState` in the correct order or the assignment is skipped.
- fix description (if clear): Initialize `_tabController` inline at declaration or in the constructor body instead of relying on `initState`. Template-level fix across all affected deep-visual demos.
- need for deeper analysis?: `no`
- batch number: `29`

### Index 146

- Index: 146
- testname: `widgets/replace_text_intent_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The deep demo (1625 lines) for `ReplaceTextIntent` constructs a widget tree with interactive text field scenarios, but the interpreter returns the top-level widget as `InterpretedInstance` instead of a concrete `Widget`. The bridge does not coerce `ReplaceTextIntent`-related widget wrappers back to native `Widget` type.
- fix description (if clear): Register the widget wrappers used in the `ReplaceTextIntent` demo in the widget coercion handler so interpreted instances are unwrapped to native `Widget`.
- need for deeper analysis?: `yes`
- batch number: `29`

### Index 147

- Index: 147
- testname: `widgets/request_focus_action_test.dart`
- category: `BRIDGE-WIDGET-COERCION (needs correction)`
- immediate fix possible: `yes`
- description: Test failed with `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: The deep demo (1367 lines) for `RequestFocusAction` constructs a focus ring grid and multi-node form, but the interpreter returns the widget as `InterpretedInstance`. Same coercion gap as Index 146 — the bridge does not unwrap interpreted widget instances for action/focus-related demo widgets.
- fix description (if clear): Register `RequestFocusAction` demo widget wrappers in the widget coercion handler.
- need for deeper analysis?: `yes`
- batch number: `29`

### Index 148

- Index: 148
- testname: `widgets/request_focus_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init pattern as Index 145. The deep-visual demo for `RequestFocusIntent` references an uninitialized late field. Part of the systematic template issue.
- fix description (if clear): Same template-level fix — initialize `_tabController` at declaration or in constructor.
- need for deeper analysis?: `no`
- batch number: `29`

### Index 149

- Index: 149
- testname: `widgets/restorable_bool_n_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init pattern as Indices 145 and 148. The deep-visual demo for `RestorableBoolN` uses the same template with the uninitialized late field. Three of the five Batch-29 issues share this pattern, continuing the trend from Batch-28.
- fix description (if clear): Same template-level fix. A bulk find-and-replace across all deep-visual demos changing `late TabController _tabController;` to an inline-initialized or nullable pattern would resolve all occurrences.
- need for deeper analysis?: `no`
- batch number: `29`

## Batch-29 Classification Summary

- Missing/stray status for Batch-29 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three `_tabController` late-initialization errors (`repeat_mode_test`, `request_focus_intent_test`, `restorable_bool_n_test`) — continuing the deep-visual demo template pattern from Batch-28.
- Bridge/generator/interpreter classification: two widget coercion defects (`replace_text_intent_test`, `request_focus_action_test`).

## Batch-30

### Index 150

- Index: 150
- testname: `widgets/restorable_date_time_n_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init deep-visual demo template issue seen across Batches 28-29. The `RestorableDateTimeN` demo declares a late `_tabController` that is never initialized before access in the interpreted execution path.
- fix description (if clear): Template-level fix — initialize `_tabController` at declaration or in constructor body. Part of the bulk fix for all deep-visual demos.
- need for deeper analysis?: `no`
- batch number: `30`

### Index 151

- Index: 151
- testname: `widgets/restorable_double_n_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RestorableDoubleN` deep-visual demo has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 150.
- need for deeper analysis?: `no`
- batch number: `30`

### Index 152

- Index: 152
- testname: `widgets/restorable_enum_n_test.dart`
- category: `BRIDGE-MISSING-SYMBOL-REGISTRATION (needs correction)`
- immediate fix possible: `no`
- description: Test failed with `Undefined variable: Enum`.
- detailed analysis what the problem is: The deep demo (1359 lines) for `RestorableEnumN` references the Dart core `Enum` type, but the interpreter does not have `Enum` registered as a known symbol. The `Enum` class is a dart:core abstract type that serves as the base for all enums; the bridge generator does not automatically register it because it is a special compiler-handled type. The test script likely uses `Enum` in a type check or generic constraint that the interpreter cannot resolve.
- fix description (if clear): Register `Enum` as a known symbol in the interpreter's core type registry or add a UserBridge that maps `Enum` to the dart:core `Enum` base class. Alternatively, refactor the test script to avoid direct `Enum` type references and use concrete enum types instead.
- need for deeper analysis?: `yes`
- batch number: `30`

### Index 153

- Index: 153
- testname: `widgets/restorable_int_n_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RestorableIntN` deep demo (1498 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Indices 150-151.
- need for deeper analysis?: `no`
- batch number: `30`

### Index 154

- Index: 154
- testname: `widgets/restorable_listenable_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RestorableListenable` deep-visual demo (2045 lines) has the identical uninitialized late field. Four of the five Batch-30 issues share this pattern, confirming the systematic template defect across all deep-visual demos.
- fix description (if clear): Same template-level fix. The `_tabController` late-init issue now spans Batches 28-30 (10+ demos total).
- need for deeper analysis?: `no`
- batch number: `30`

## Batch-30 Classification Summary

- Missing/stray status for Batch-30 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: four `_tabController` late-initialization errors (`restorable_date_time_n_test`, `restorable_double_n_test`, `restorable_int_n_test`, `restorable_listenable_test`) — continuing the deep-visual demo template pattern from Batches 28-29.
- Bridge/generator/interpreter classification: one `BRIDGE-MISSING-SYMBOL-REGISTRATION` for the dart:core `Enum` type (`restorable_enum_n_test`) — the interpreter does not have `Enum` registered as a known variable.

## Batch-31

### Index 155

- Index: 155
- testname: `widgets/restorable_num_n_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern seen since Batch-28. The `RestorableNumN` deep-visual demo (2083 lines, DeepOrange/Cyan palette) declares `late TabController _tabController` but accesses it before `initState` assigns it.
- fix description (if clear): Initialize `_tabController` at declaration or move initialization to the constructor body so it is available before `build()` runs.
- need for deeper analysis?: `no`
- batch number: `31`

### Index 156

- Index: 156
- testname: `widgets/restorable_num_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RestorableNum` deep-visual demo (1859 lines, Green/Purple palette) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 155.
- need for deeper analysis?: `no`
- batch number: `31`

### Index 157

- Index: 157
- testname: `widgets/restorable_route_future_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RestorableRouteFuture` deep-visual demo (1675 lines, Indigo/Teal palette) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 155.
- need for deeper analysis?: `no`
- batch number: `31`

### Index 158

- Index: 158
- testname: `widgets/restorable_string_n_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RestorableStringN` deep-visual demo (1858 lines, Red 400/LightGreen A200 palette) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 155.
- need for deeper analysis?: `no`
- batch number: `31`

### Index 159

- Index: 159
- testname: `widgets/root_element_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. The `RootElementMixin` deep-visual demo (1554 lines, Teal 600/Pink A100 palette) has the identical uninitialized late field. All five Batch-31 issues are the same systematic template defect, continuing the pattern from Batches 28-30.
- fix description (if clear): Same template-level fix. The `_tabController` late-init issue now spans Batches 28-31 (15+ demos total).
- need for deeper analysis?: `no`
- batch number: `31`

## Batch-31 Classification Summary

- Missing/stray status for Batch-31 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabController` late-initialization errors (`restorable_num_n_test`, `restorable_num_test`, `restorable_route_future_test`, `restorable_string_n_test`, `root_element_mixin_test`) — continuing the deep-visual demo template pattern from Batches 28-30.
- Bridge/generator/interpreter classification: none. All five issues are test-script-level template defects, no bridge or interpreter issues in this batch.

## Batch-32

### Index 160

- Index: 160
- testname: `widgets/root_render_object_element_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern seen since Batch-28. The script was created on 2026-04-10 and lacks proper `_tabController` initialization before first access.
- fix description (if clear): Initialize `_tabController` at declaration or move initialization to the constructor body so it is available before `build()` runs.
- need for deeper analysis?: `no`
- batch number: `32`

### Index 161

- Index: 161
- testname: `widgets/route_information_reporting_type_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Variant of the late-init template pattern — this script uses `_tabs` instead of `_tabController` as the late variable name, but the root cause is identical: a `late` field is accessed before `initState` assigns it. The script was created on 2026-04-10.
- fix description (if clear): Same template-level fix: initialize `_tabs` at declaration or in the constructor body.
- need for deeper analysis?: `no`
- batch number: `32`

### Index 162

- Index: 162
- testname: `widgets/route_information_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no`
- description: Test fails with: `Expected: true / Actual: <false> / Expected Widget but got InterpretedInstance`. Stack trace points to `test/hardly_relevant_classes_5_test.dart:552`.
- detailed analysis what the problem is: The deep demo script (1750 lines, RouteInformation class with URI anatomy, Navigator 2.0 role, Builder with live URI preview) constructs a widget tree in the interpreter. The bridge returns an `InterpretedInstance` instead of a native `Widget` subclass. The `is Widget` type check fails because the interpreter's runtime type system does not automatically coerce `InterpretedInstance` wrappers to their bridged Flutter counterparts.
- fix description (if clear): Requires bridge-level coercion fix — either a custom `UserBridge` for the widget hierarchy or a general `InterpretedInstance`-to-`Widget` coercion layer in the test harness.
- need for deeper analysis?: `yes — same systemic widget coercion issue seen in Batches 4, 11, 13, 17, 23, 26`
- batch number: `32`

### Index 163

- Index: 163
- testname: `widgets/route_pop_disposition_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no`
- description: Test fails with: `Expected: true / Actual: <false> / Expected Widget but got InterpretedInstance`. Stack trace points to `test/hardly_relevant_classes_5_test.dart:566`.
- detailed analysis what the problem is: The deep demo script (1642 lines, 3 dispositions, pop simulation, decision flow, nested navigator scenario) constructs a widget tree in the interpreter. Same `InterpretedInstance`-to-`Widget` coercion failure. The `is Widget` type check at line 566 receives an `InterpretedInstance` wrapper instead of a native `Widget`.
- fix description (if clear): Same bridge-level coercion fix as Index 162.
- need for deeper analysis?: `yes — same systemic widget coercion issue`
- batch number: `32`

### Index 164

- Index: 164
- testname: `widgets/route_transition_record_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init variant as Index 161. The script was created on 2026-04-10 and uses `_tabs` (not `_tabController`) as the late field name, but the pattern is identical.
- fix description (if clear): Same template-level fix: initialize `_tabs` at declaration or in the constructor body.
- need for deeper analysis?: `no`
- batch number: `32`

## Batch-32 Classification Summary

- Missing/stray status for Batch-32 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three late-initialization errors — one `_tabController` (`root_render_object_element_test`) and two `_tabs` (`route_information_reporting_type_test`, `route_transition_record_test`). The `_tabs` variant is a new late-init variable name but the same root cause as the `_tabController` pattern.
- Bridge/generator/interpreter classification: two `BRIDGE-WIDGET-COERCION` failures (`route_information_test`, `route_pop_disposition_test`) — the interpreter returns `InterpretedInstance` where native `Widget` is expected, causing `is Widget` type checks to fail.

## Batch-33

### Index 165

- Index: 165
- testname: `widgets/router_config_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no`
- description: Test fails with: `Runtime Error: Class '_FlowStage' does not have an unnamed constructor that accepts arguments.` Stack trace at `test/hardly_relevant_classes_5_test.dart:580`.
- detailed analysis what the problem is: The test script defines a private class `_FlowStage` with constructor arguments that the interpreter cannot resolve. The bridge does not support unnamed constructors on private (underscore-prefixed) classes defined in interpreted code. This is the same pattern seen in Batch-27 (Index 139, `_BootstrapStepInfo`) — private classes with parameterized constructors are not handled by the bridge generator.
- fix description (if clear): Requires bridge-level support for private class constructors in interpreted code, or refactoring the test script to avoid private classes with constructor arguments.
- need for deeper analysis?: `yes — same private-class constructor pattern as Batch-27`
- batch number: `33`

### Index 166

- Index: 166
- testname: `widgets/scroll_activity_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init variant seen since Batch-32. The script was created on 2026-04-10 and uses `_tabs` as the late field name that is accessed before `initState` assigns it.
- fix description (if clear): Initialize `_tabs` at declaration or in the constructor body.
- need for deeper analysis?: `no`
- batch number: `33`

### Index 167

- Index: 167
- testname: `widgets/scroll_activity_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no`
- description: Test fails with: `Runtime Error: Class '_SubclassInfo' does not have an unnamed constructor that accepts arguments.` Stack trace at `test/hardly_relevant_classes_5_test.dart:594`.
- detailed analysis what the problem is: Same private-class constructor pattern as Index 165. The test script defines `_SubclassInfo` with constructor arguments that the interpreter cannot resolve. The bridge does not handle unnamed constructors on private classes defined in interpreted code.
- fix description (if clear): Same as Index 165 — bridge-level fix or test script refactoring.
- need for deeper analysis?: `yes — same private-class constructor pattern`
- batch number: `33`

### Index 168

- Index: 168
- testname: `widgets/scroll_context_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init variant. The script was created on 2026-04-10.
- fix description (if clear): Same template-level fix: initialize `_tabs` at declaration or in the constructor body.
- need for deeper analysis?: `no`
- batch number: `33`

### Index 169

- Index: 169
- testname: `widgets/scroll_deceleration_rate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init variant. The script was created on 2026-04-10. All three late-init issues in Batch-33 use the `_tabs` variant.
- fix description (if clear): Same template-level fix.
- need for deeper analysis?: `no`
- batch number: `33`

## Batch-33 Classification Summary

- Missing/stray status for Batch-33 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three `_tabs` late-initialization errors (`scroll_activity_delegate_test`, `scroll_context_test`, `scroll_deceleration_rate_test`) — continuing the late-init template pattern.
- Bridge/generator/interpreter classification: two `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT` failures (`router_config_test` with `_FlowStage`, `scroll_activity_test` with `_SubclassInfo`) — the interpreter cannot resolve unnamed constructors on private classes defined in interpreted code. Same pattern as Batch-27's `_BootstrapStepInfo`.

## Batch-34

### Index 170

- Index: 170
- testname: `widgets/scroll_drag_controller_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern seen since Batch-32. The script was created on 2026-04-10 and uses `_tabs` as the late field that is accessed before `initState` assigns it.
- fix description (if clear): Initialize `_tabs` at declaration or in the constructor body.
- need for deeper analysis?: `no`
- batch number: `34`

### Index 171

- Index: 171
- testname: `widgets/scroll_end_notification_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `ScrollEndNotification` deep demo (992 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 170.
- need for deeper analysis?: `no`
- batch number: `34`

### Index 172

- Index: 172
- testname: `widgets/scroll_hold_controller_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `ScrollHoldController` deep demo (1046 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 170.
- need for deeper analysis?: `no`
- batch number: `34`

### Index 173

- Index: 173
- testname: `widgets/scroll_increment_details_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `ScrollIncrementDetails` deep demo (1098 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 170.
- need for deeper analysis?: `no`
- batch number: `34`

### Index 174

- Index: 174
- testname: `widgets/scroll_increment_type_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `ScrollIncrementType` deep demo (1168 lines) has the identical uninitialized late field. All five Batch-34 issues are the same `_tabs` late-init variant, continuing the pattern from Batches 32-33.
- fix description (if clear): Same template-level fix. The `_tabs`/`_tabController` late-init issue now spans Batches 28-34 (25+ demos total).
- need for deeper analysis?: `no`
- batch number: `34`

## Batch-34 Classification Summary

- Missing/stray status for Batch-34 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`scroll_drag_controller_test`, `scroll_end_notification_test`, `scroll_hold_controller_test`, `scroll_increment_details_test`, `scroll_increment_type_test`) — continuing the late-init template pattern from Batches 32-33.
- Bridge/generator/interpreter classification: none. All five issues are test-script-level template defects, no bridge or interpreter issues in this batch.

## Batch-35

### Index 175

- Index: 175
- testname: `widgets/scroll_metrics_notification_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template defect, now using the `_tabCtrl` variable name variant (first seen in Batch-35). The `ScrollMetricsNotification` deep demo has an uninitialized late field in its demo state class.
- fix description (if clear): Initialize `_tabCtrl` in `initState()` or replace with a non-late field. Same template-level fix as previous batches but for the `_tabCtrl` variant.
- need for deeper analysis?: `no`
- batch number: `35`

### Index 176

- Index: 176
- testname: `widgets/scroll_notification_observer_state_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no`
- description: Test fails with `Expected Widget but got InterpretedInstance`. The bridge does not coerce `InterpretedInstance` to `Widget` when the interpreter returns a widget subclass instance.
- detailed analysis what the problem is: The `ScrollNotificationObserverState` deep demo constructs a widget tree where the interpreter returns an `InterpretedInstance` wrapping a `Widget`. The test framework's `expect(..., isA<Widget>())` check fails because the bridge layer does not unwrap or coerce the instance to its native type.
- fix description (if clear): Add widget coercion logic in the bridge layer to unwrap `InterpretedInstance` to `Widget` when the underlying value is a widget subclass.
- need for deeper analysis?: `yes — bridge coercion pattern needs to handle ScrollNotificationObserverState context`
- batch number: `35`

### Index 177

- Index: 177
- testname: `widgets/scroll_notification_observer_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `ScrollNotificationObserver` deep demo has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 175.
- need for deeper analysis?: `no`
- batch number: `35`

### Index 178

- Index: 178
- testname: `widgets/scroll_position_alignment_policy_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no`
- description: Test fails with `Expected Widget but got InterpretedInstance`. Widget coercion failure in ScrollPositionAlignmentPolicy context.
- detailed analysis what the problem is: The deep demo (1207 lines) constructs alignment policy comparisons. The interpreter returns a widget instance as `InterpretedInstance` but the test expectation requires a native `Widget` type.
- fix description (if clear): Same bridge-level widget coercion fix as Index 176.
- need for deeper analysis?: `yes — same coercion pattern as Index 176`
- batch number: `35`

### Index 179

- Index: 179
- testname: `widgets/scroll_position_with_single_context_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `ScrollPositionWithSingleContext` deep demo has the identical uninitialized late field. All three `_tabCtrl` late-init issues in Batch-35 are the same template defect.
- fix description (if clear): Same template-level fix. The `_tabCtrl` variant joins the `_tabController`/`_tabs` late-init issue family spanning Batches 28-35.
- need for deeper analysis?: `no`
- batch number: `35`

## Batch-35 Classification Summary

- Missing/stray status for Batch-35 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three `_tabCtrl` late-initialization errors (`scroll_metrics_notification_test`, `scroll_notification_observer_test`, `scroll_position_with_single_context_test`) — new `_tabCtrl` variant name, same underlying template defect.
- Bridge/generator/interpreter classification: two BRIDGE-WIDGET-COERCION failures (`scroll_notification_observer_state_test`, `scroll_position_alignment_policy_test`) — `InterpretedInstance` not coerced to `Widget`.

## Batch-36

### Index 180

- Index: 180
- testname: `widgets/scroll_start_notification_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern continuing from Batch-35. The `ScrollStartNotification` deep demo (1230 lines) has an uninitialized late `_tabCtrl` field in its demo state class.
- fix description (if clear): Initialize `_tabCtrl` in `initState()` or replace with a non-late field. Same template-level fix as Batches 28-35.
- need for deeper analysis?: `no`
- batch number: `36`

### Index 181

- Index: 181
- testname: `widgets/scroll_to_document_boundary_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `ScrollToDocumentBoundaryIntent` deep demo (1380 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 180.
- need for deeper analysis?: `no`
- batch number: `36`

### Index 182

- Index: 182
- testname: `widgets/scroll_update_notification_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `ScrollUpdateNotification` deep demo (1403 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 180.
- need for deeper analysis?: `no`
- batch number: `36`

### Index 183

- Index: 183
- testname: `widgets/scroll_view_keyboard_dismiss_behavior_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no`
- description: Test fails with `Expected: true / Actual: <false> — Expected Widget but got InterpretedInstance`. The bridge does not coerce `InterpretedInstance` to `Widget` when the interpreter returns a widget subclass instance.
- detailed analysis what the problem is: The `ScrollViewKeyboardDismissBehavior` deep demo (1554 lines) constructs a widget tree with enum-driven behavior variants. The test at line 713 in `hardly_relevant_classes_5_test.dart` calls `expect(result, isTrue)` after a widget type check, but the bridge layer returns an `InterpretedInstance` instead of a native `Widget`, causing the type check to fail. Stack trace confirms the failure originates in the main test harness, not in the demo script itself.
- fix description (if clear): Add widget coercion logic in the bridge layer to unwrap `InterpretedInstance` to `Widget` when the underlying value is a widget subclass. Same pattern as Batch-35 BRIDGE-WIDGET-COERCION issues (indices 176, 178).
- need for deeper analysis?: `yes — bridge coercion pattern needs to handle ScrollViewKeyboardDismissBehavior context`
- batch number: `36`

### Index 184

- Index: 184
- testname: `widgets/scroll_view_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `ScrollView` demo script has the identical uninitialized late field. All four `_tabCtrl` late-init issues in Batch-36 are the same template defect, continuing the pattern from Batches 35 and earlier.
- fix description (if clear): Same template-level fix. The `_tabCtrl`/`_tabs`/`_tabController` late-init issue now spans Batches 28-36 (30+ demos total).
- need for deeper analysis?: `no`
- batch number: `36`

## Batch-36 Classification Summary

- Missing/stray status for Batch-36 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: four `_tabCtrl` late-initialization errors (`scroll_start_notification_test`, `scroll_to_document_boundary_intent_test`, `scroll_update_notification_test`, `scroll_view_test`) — continuing the `_tabCtrl` late-init template pattern from Batch-35.
- Bridge/generator/interpreter classification: one BRIDGE-WIDGET-COERCION failure (`scroll_view_keyboard_dismiss_behavior_test`) — `InterpretedInstance` not coerced to `Widget`. Same coercion pattern as Batch-35 indices 176 and 178.

## Batch-37

### Index 185

- Index: 185
- testname: `widgets/scrollable_details_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern continuing from Batches 35-36. The `ScrollableDetails` deep demo (1686 lines) has an uninitialized late `_tabCtrl` field in its demo state class.
- fix description (if clear): Initialize `_tabCtrl` in `initState()` or replace with a non-late field. Same template-level fix as Batches 28-36.
- need for deeper analysis?: `no`
- batch number: `37`

### Index 186

- Index: 186
- testname: `widgets/scrollbar_orientation_test.dart`
- category: `BRIDGE-MISSING-STATE-WIDGET-ACCESSOR`
- immediate fix possible: `no`
- description: Test passes but logs 4 errors: `Undefined property 'widget' on _OrientedPanelState.` The interpreter does not resolve the inherited `widget` getter on a `State<T>` subclass.
- detailed analysis what the problem is: The `ScrollbarOrientation` deep demo (824 lines) defines a private `_OrientedPanelState` class extending `State<_OrientedPanel>`. The interpreter cannot resolve `this.widget` (the inherited getter from `State<T>`) on the private State subclass, because the bridge layer does not synthesize the `widget` accessor for interpreted State subclasses. This is distinct from the `_tabCtrl` late-init issue — it is a bridge/interpreter limitation where inherited getters from generic superclasses are not available on private subclasses.
- fix description (if clear): The bridge generator or interpreter needs to synthesize the `widget` getter for State subclasses, or a UserBridge must be added to expose it. This requires interpreter-level support for inherited generic accessors.
- need for deeper analysis?: `yes — interpreter needs to resolve inherited getters from generic superclasses on private State subclasses`
- batch number: `37`

### Index 187

- Index: 187
- testname: `widgets/scrollbar_painter_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `ScrollbarPainter` demo script has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 185.
- need for deeper analysis?: `no`
- batch number: `37`

### Index 188

- Index: 188
- testname: `widgets/select_action_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no`
- description: Test fails with `Class '_ChainItem' does not have an unnamed constructor that accepts arguments.` The interpreter cannot instantiate the private class `_ChainItem` because its constructor is not registered in the bridge.
- detailed analysis what the problem is: The `SelectAction` deep demo (1629 lines) defines a private `_ChainItem` class with a constructor that takes arguments. The bridge generator does not generate constructor bridges for private classes, so the interpreter fails when trying to instantiate `_ChainItem(...)`. Stack trace confirms the failure at test line 746 in `hardly_relevant_classes_5_test.dart`. This is the same category as Batch-33 issues (indices 168, 169) where `_FlowStage` and `_SubclassInfo` had the same problem.
- fix description (if clear): Either make `_ChainItem` public, add a UserBridge for its constructor, or enhance the bridge generator to support private class constructors. Same pattern as Batch-33 BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT.
- need for deeper analysis?: `yes — private class constructor support needs bridge generator enhancement`
- batch number: `37`

### Index 189

- Index: 189
- testname: `widgets/select_all_text_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `SelectAllTextIntent` deep demo (1479 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix. The `_tabCtrl`/`_tabs`/`_tabController` late-init issue now spans Batches 28-37.
- need for deeper analysis?: `no`
- batch number: `37`

## Batch-37 Classification Summary

- Missing/stray status for Batch-37 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three `_tabCtrl` late-initialization errors (`scrollable_details_test`, `scrollbar_painter_test`, `select_all_text_intent_test`) — continuing the `_tabCtrl` late-init template pattern.
- Bridge/generator/interpreter classification: one BRIDGE-MISSING-STATE-WIDGET-ACCESSOR (`scrollbar_orientation_test`) — inherited `widget` getter not resolved on private `_OrientedPanelState`; one BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT (`select_action_test`) — private `_ChainItem` constructor not bridged.

## Batch-38

### Index 190

- Index: 190
- testname: `widgets/select_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern continuing from Batches 35-37. The `SelectIntent` deep demo (1545 lines) has an uninitialized late `_tabCtrl` field in its demo state class.
- fix description (if clear): Initialize `_tabCtrl` in `initState()` or replace with a non-late field. Same template-level fix as Batches 28-37.
- need for deeper analysis?: `no`
- batch number: `38`

### Index 191

- Index: 191
- testname: `widgets/selectable_region_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `SelectableRegionState` deep demo (1526 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 190.
- need for deeper analysis?: `no`
- batch number: `38`

### Index 192

- Index: 192
- testname: `widgets/selection_container_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `SelectionContainerDelegate` deep demo (1589 lines) has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 190.
- need for deeper analysis?: `no`
- batch number: `38`

### Index 193

- Index: 193
- testname: `widgets/selection_details_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `SelectionDetails` demo script has the identical uninitialized late field.
- fix description (if clear): Same template-level fix as Index 190.
- need for deeper analysis?: `no`
- batch number: `38`

### Index 194

- Index: 194
- testname: `widgets/semantics_gesture_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern. The `SemanticsGestureDelegate` demo script has the identical uninitialized late field. All five Batch-38 issues are the same `_tabCtrl` late-init variant.
- fix description (if clear): Same template-level fix. The `_tabCtrl`/`_tabs`/`_tabController` late-init issue now spans Batches 28-38 (35+ demos total).
- need for deeper analysis?: `no`
- batch number: `38`

## Batch-38 Classification Summary

- Missing/stray status for Batch-38 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabCtrl` late-initialization errors (`select_intent_test`, `selectable_region_state_test`, `selection_container_delegate_test`, `selection_details_test`, `semantics_gesture_delegate_test`) — continuing the `_tabCtrl` late-init template pattern from Batches 35-37.
- Bridge/generator/interpreter classification: none. All five issues are test-script-level template defects, no bridge or interpreter issues in this batch.

---

# Batch-39 (Issues 195-199)

### Index 195

- Index: 195
- testname: `widgets/shortcut_activator_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern as previous batches. The `ShortcutActivator` demo script references a `_tabCtrl` field that is never initialized.
- fix description (if clear): Same template-level fix — ensure `_tabCtrl` is initialized in `initState()` or replaced with proper state setup.
- need for deeper analysis?: `no`
- batch number: `39`

### Index 196

- Index: 196
- testname: `widgets/shortcut_manager_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _loggingManager (LateInitializationError: Late variable '_loggingManager' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: New late-init variant — `_loggingManager` instead of `_tabCtrl`/`_tabs`. The `ShortcutManager` demo script declares a `late` field `_loggingManager` that is never assigned before use. Same root cause (template-generated state class with uninitialized late field) but different variable name.
- fix description (if clear): Initialize `_loggingManager` in `initState()` or remove the late field if unused.
- need for deeper analysis?: `no`
- batch number: `39`

### Index 197

- Index: 197
- testname: `widgets/shortcut_map_property_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabCtrl (LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabCtrl` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 195.
- need for deeper analysis?: `no`
- batch number: `39`

### Index 198

- Index: 198
- testname: `widgets/shortcut_registry_entry_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_Phase' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: The test instantiates a private class `_Phase` whose constructor is not bridged by the D4rt generator. The bridge does not generate unnamed constructor support for private classes with positional/named parameters. This is the same category as previous BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT issues (Batches 37, 39).
- fix description (if clear): The D4rt bridge generator needs to support unnamed constructors for private classes, or a UserBridge / custom factory must be registered.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `39`

### Index 199

- Index: 199
- testname: `widgets/shortcut_serialization_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_TriggerInfo' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Same as Index 198 — private class `_TriggerInfo` constructor not bridged. The bridge generator lacks support for constructing private classes with positional arguments.
- fix description (if clear): Same generator enhancement as Index 198.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `39`

## Batch-39 Classification Summary

- Missing/stray status for Batch-39 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three late-initialization errors — two `_tabCtrl` (`shortcut_activator_test`, `shortcut_map_property_test`) and one new variant `_loggingManager` (`shortcut_manager_test`).
- Bridge/generator/interpreter classification: two BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures (`shortcut_registry_entry_test` — `_Phase`, `shortcut_serialization_test` — `_TriggerInfo`). Both require generator enhancement for private class constructors.

---

# Batch-40 (Issues 200-204)

### Index 200

- Index: 200
- testname: `widgets/single_activator_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_Key' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Private class `_Key` constructor is not bridged. Same category as Batch-39 indices 198-199. The D4rt bridge generator does not generate constructors for private classes.
- fix description (if clear): Generator enhancement for private class constructor support, or register a custom UserBridge/factory.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `40`

### Index 201

- Index: 201
- testname: `widgets/size_changed_layout_notification_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template pattern, `_tabs` variant (continuing from Batches 32-34).
- fix description (if clear): Same template-level fix — initialize `_tabs` in `initState()`.
- need for deeper analysis?: `no`
- batch number: `40`

### Index 202

- Index: 202
- testname: `widgets/sliver_animated_grid_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init pattern.
- fix description (if clear): Same template-level fix as Index 201.
- need for deeper analysis?: `no`
- batch number: `40`

### Index 203

- Index: 203
- testname: `widgets/sliver_animated_list_state_test.dart`
- category: `BRIDGE-MISSING-STATE-WIDGET-ACCESSOR`
- immediate fix possible: `no — requires bridge enhancement`
- description: Test passes but logs: `Undefined variable: setState (Original error: Undefined property 'setState' on _InteractivePageState.)`.
- detailed analysis what the problem is: The bridge does not resolve inherited `setState` on the private class `_InteractivePageState`. This extends the BRIDGE-MISSING-STATE-WIDGET-ACCESSOR category introduced in Batch-37 (Index 186, `widget` getter) to include `setState` as another inherited member not resolved on private State subclasses.
- fix description (if clear): The bridge generator needs to resolve inherited members (`setState`, `widget`) on private State subclasses.
- need for deeper analysis?: `yes — bridge enhancement needed`
- batch number: `40`

### Index 204

- Index: 204
- testname: `widgets/sliver_child_builder_delegate_test.dart`
- category: `BRIDGE-MISSING-STATE-WIDGET-ACCESSOR`
- immediate fix possible: `no — requires bridge enhancement`
- description: Test passes but logs: `Undefined variable: setState (Original error: Undefined property 'setState' on _InteractivePageState.)`.
- detailed analysis what the problem is: Same as Index 203 — `setState` not resolved on `_InteractivePageState`.
- fix description (if clear): Same bridge enhancement as Index 203.
- need for deeper analysis?: `yes — bridge enhancement needed`
- batch number: `40`

## Batch-40 Classification Summary

- Missing/stray status for Batch-40 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: two `_tabs` late-initialization errors (`size_changed_layout_notification_test`, `sliver_animated_grid_state_test`).
- Bridge/generator/interpreter classification: one BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT (`single_activator_test` — `_Key`), two BRIDGE-MISSING-STATE-WIDGET-ACCESSOR (`sliver_animated_list_state_test`, `sliver_child_builder_delegate_test` — `setState` on `_InteractivePageState`).

---

# Batch-41 (Issues 205-209)

### Index 205

- Index: 205
- testname: `widgets/sliver_child_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern continuing from Batches 32-34 and 40. The `SliverChildDelegate` demo script references a `_tabs` field that is never initialized in `initState()`.
- fix description (if clear): Same template-level fix — initialize `_tabs` in `initState()` or replace with proper state setup.
- need for deeper analysis?: `no`
- batch number: `41`

### Index 206

- Index: 206
- testname: `widgets/sliver_multi_box_adaptor_element_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 205.
- need for deeper analysis?: `no`
- batch number: `41`

### Index 207

- Index: 207
- testname: `widgets/sliver_multi_box_adaptor_widget_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 205.
- need for deeper analysis?: `no`
- batch number: `41`

### Index 208

- Index: 208
- testname: `widgets/sliver_reorderable_list_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 205.
- need for deeper analysis?: `no`
- batch number: `41`

### Index 209

- Index: 209
- testname: `widgets/slotted_container_render_object_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. All five Batch-41 issues are the same `_tabs` late-init variant.
- fix description (if clear): Same template-level fix. The `_tabs`/`_tabCtrl`/`_tabController`/`_loggingManager` late-init issue now spans Batches 28-41 (40+ demos total).
- need for deeper analysis?: `no`
- batch number: `41`

## Batch-41 Classification Summary

- Missing/stray status for Batch-41 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`sliver_child_delegate_test`, `sliver_multi_box_adaptor_element_test`, `sliver_multi_box_adaptor_widget_test`, `sliver_reorderable_list_state_test`, `slotted_container_render_object_mixin_test`) — continuing the `_tabs` late-init template pattern from Batches 32-34 and 40.
- Bridge/generator/interpreter classification: none. All five issues are test-script-level template defects, no bridge or interpreter issues in this batch.

---

# Batch-42 (Issues 210-214)

### Index 210

- Index: 210
- testname: `widgets/slotted_multi_child_render_object_widget_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern continuing from previous batches. The `SlottedMultiChildRenderObjectWidgetMixin` demo script references a `_tabs` field that is never initialized in `initState()`.
- fix description (if clear): Same template-level fix — initialize `_tabs` in `initState()` or replace with proper state setup.
- need for deeper analysis?: `no`
- batch number: `42`

### Index 211

- Index: 211
- testname: `widgets/slotted_multi_child_render_object_widget_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 210.
- need for deeper analysis?: `no`
- batch number: `42`

### Index 212

- Index: 212
- testname: `widgets/slotted_render_object_element_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 210.
- need for deeper analysis?: `no`
- batch number: `42`

### Index 213

- Index: 213
- testname: `widgets/snapshot_mode_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 210.
- need for deeper analysis?: `no`
- batch number: `42`

### Index 214

- Index: 214
- testname: `widgets/standard_component_type_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. All five Batch-42 issues are the same `_tabs` late-init variant.
- fix description (if clear): Same template-level fix. The `_tabs`/`_tabCtrl`/`_tabController`/`_loggingManager` late-init issue now spans Batches 28-42 (45+ demos total).
- need for deeper analysis?: `no`
- batch number: `42`

## Batch-42 Classification Summary

- Missing/stray status for Batch-42 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`slotted_multi_child_render_object_widget_mixin_test`, `slotted_multi_child_render_object_widget_test`, `slotted_render_object_element_test`, `snapshot_mode_test`, `standard_component_type_test`) — continuing the `_tabs` late-init template pattern.
- Bridge/generator/interpreter classification: none. All five issues are test-script-level template defects, no bridge or interpreter issues in this batch.

---

# Batch-43 (Issues 215-219)

### Index 215

- Index: 215
- testname: `widgets/static_selection_container_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern continuing from previous batches. The `StaticSelectionContainerDelegate` demo script references a `_tabs` field that is never initialized in `initState()`.
- fix description (if clear): Same template-level fix — initialize `_tabs` in `initState()` or replace with proper state setup.
- need for deeper analysis?: `no`
- batch number: `43`

### Index 216

- Index: 216
- testname: `widgets/text_selection_gesture_detector_builder_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern.
- fix description (if clear): Same template-level fix as Index 215.
- need for deeper analysis?: `no`
- batch number: `43`

### Index 217

- Index: 217
- testname: `widgets/toolbar_items_parent_data_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_TimelineStep' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Private class `_TimelineStep` constructor is not bridged. The D4rt bridge generator does not generate unnamed constructor support for private classes with positional/named parameters. Same category as previous BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT issues (Batches 37, 39, 40).
- fix description (if clear): Generator enhancement for private class constructor support, or register a custom UserBridge/factory.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `43`

### Index 218

- Index: 218
- testname: `widgets/toolbar_options_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_LegacyToolbarProfile' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Same as Index 217 — private class `_LegacyToolbarProfile` constructor not bridged.
- fix description (if clear): Same generator enhancement as Index 217.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `43`

### Index 219

- Index: 219
- testname: `widgets/tooltip_position_context_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_CaseDefinition' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Same as Index 217 — private class `_CaseDefinition` constructor not bridged.
- fix description (if clear): Same generator enhancement as Index 217.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `43`

## Batch-43 Classification Summary

- Missing/stray status for Batch-43 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: two `_tabs` late-initialization errors (`static_selection_container_delegate_test`, `text_selection_gesture_detector_builder_delegate_test`).
- Bridge/generator/interpreter classification: three BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures (`toolbar_items_parent_data_test` — `_TimelineStep`, `toolbar_options_test` — `_LegacyToolbarProfile`, `tooltip_position_context_test` — `_CaseDefinition`). All three require generator enhancement for private class constructors.

---

# Batch-44 (Issues 220-224)

### Index 220

- Index: 220
- testname: `widgets/tooltip_window_controller_delegate_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_PolicyPreset' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Private class `_PolicyPreset` constructor is not bridged. Same category as previous BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT issues. The D4rt bridge generator does not generate unnamed constructor support for private classes with positional/named parameters.
- fix description (if clear): Generator enhancement for private class constructor support, or register a custom UserBridge/factory.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `44`

### Index 221

- Index: 221
- testname: `widgets/tooltip_window_controller_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_Pattern' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Same as Index 220 — private class `_Pattern` constructor not bridged.
- fix description (if clear): Same generator enhancement as Index 220.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `44`

### Index 222

- Index: 222
- testname: `widgets/tooltip_window_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template pattern, `_tabController` variant (returning to the original variant name from Batches 28-31). The `TooltipWindow` demo script references a `_tabController` field that is never initialized.
- fix description (if clear): Same template-level fix — initialize `_tabController` in `initState()`.
- need for deeper analysis?: `no`
- batch number: `44`

### Index 223

- Index: 223
- testname: `widgets/transition_delegate_test.dart`
- category: `BRIDGE-MISSING-STATE-WIDGET-ACCESSOR + BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires bridge enhancements`
- description: Test passes but logs two errors: (1) `Undefined variable: setState (Undefined property 'setState' on _DefaultDemoPageState.)` and (2) `Native error during default bridged constructor for 'Navigator': Argument Error: Invalid parameter "transitionDelegate": expected TransitionDelegate<dynamic>, got InterpretedInstance`.
- detailed analysis what the problem is: Two distinct bridge issues in the same script. First: `setState` is not resolved on `_DefaultDemoPageState` — same BRIDGE-MISSING-STATE-WIDGET-ACCESSOR pattern as Batch-40 (indices 203-204). Second: the `TransitionDelegate` custom subclass created by the interpreter is passed as an `InterpretedInstance` to the `Navigator` constructor, which expects a `TransitionDelegate<dynamic>` — this is a BRIDGE-WIDGET-COERCION issue where the bridge cannot coerce the interpreted instance to the expected native type.
- fix description (if clear): (1) Bridge generator needs to resolve inherited `setState` on private State subclasses. (2) A UserBridge or type coercion handler for `TransitionDelegate` is needed so interpreted subclass instances are properly wrapped for native consumption.
- need for deeper analysis?: `yes — both bridge enhancements needed`
- batch number: `44`

### Index 224

- Index: 224
- testname: `widgets/transpose_characters_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern as Index 222.
- fix description (if clear): Same template-level fix as Index 222.
- need for deeper analysis?: `no`
- batch number: `44`

## Batch-44 Classification Summary

- Missing/stray status for Batch-44 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: two `_tabController` late-initialization errors (`tooltip_window_test`, `transpose_characters_intent_test`).
- Bridge/generator/interpreter classification: two BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures (`tooltip_window_controller_delegate_test` — `_PolicyPreset`, `tooltip_window_controller_test` — `_Pattern`). One combined BRIDGE-MISSING-STATE-WIDGET-ACCESSOR + BRIDGE-WIDGET-COERCION issue (`transition_delegate_test` — `setState` on `_DefaultDemoPageState` plus `TransitionDelegate` coercion failure).

---

# Batch-45 (Issues 225-229)

### Index 225

- Index: 225
- testname: `widgets/traversal_direction_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_PolicyProfile' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Private class `_PolicyProfile` constructor is not bridged. Same category as previous BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT issues. The D4rt bridge generator does not generate unnamed constructor support for private classes with positional/named parameters.
- fix description (if clear): Generator enhancement for private class constructor support, or register a custom UserBridge/factory.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `45`

### Index 226

- Index: 226
- testname: `widgets/traversal_edge_behavior_test.dart`
- category: `BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT`
- immediate fix possible: `no — requires bridge/generator enhancement`
- description: Test fails with: `Class '_Playbook' does not have an unnamed constructor that accepts arguments.`
- detailed analysis what the problem is: Same as Index 225 — private class `_Playbook` constructor not bridged.
- fix description (if clear): Same generator enhancement as Index 225.
- need for deeper analysis?: `yes — generator enhancement needed`
- batch number: `45`

### Index 227

- Index: 227
- testname: `widgets/tree_sliver_state_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template pattern, `_tabController` variant. The `TreeSliverStateMixin` demo script references a `_tabController` field that is never initialized.
- fix description (if clear): Same template-level fix — initialize `_tabController` in `initState()`.
- need for deeper analysis?: `no`
- batch number: `45`

### Index 228

- Index: 228
- testname: `widgets/two_dimensional_child_builder_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template pattern, `_tabs` variant.
- fix description (if clear): Same template-level fix — initialize `_tabs` in `initState()`.
- need for deeper analysis?: `no`
- batch number: `45`

### Index 229

- Index: 229
- testname: `widgets/two_dimensional_child_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabController` late-init template pattern. All three TEST-SCRIPT-STATE-CONTEXT issues in this batch are the same root cause with mixed variable names (`_tabController` and `_tabs`).
- fix description (if clear): Same template-level fix. The late-init issue now spans Batches 28-45 (50+ demos total).
- need for deeper analysis?: `no`
- batch number: `45`

## Batch-45 Classification Summary

- Missing/stray status for Batch-45 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three late-initialization errors — two `_tabController` (`tree_sliver_state_mixin_test`, `two_dimensional_child_delegate_test`) and one `_tabs` (`two_dimensional_child_builder_delegate_test`).
- Bridge/generator/interpreter classification: two BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT failures (`traversal_direction_test` — `_PolicyProfile`, `traversal_edge_behavior_test` — `_Playbook`). Both require generator enhancement for private class constructors.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-46 (Issues 230-234)

### Index 230

- Index: 230
- testname: `widgets/two_dimensional_child_list_delegate_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `TwoDimensionalChildListDelegate` demo script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `46`

### Index 231

- Index: 231
- testname: `widgets/two_dimensional_child_manager_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 230.
- fix description (if clear): Same template-level fix as Index 230.
- need for deeper analysis?: `no`
- batch number: `46`

### Index 232

- Index: 232
- testname: `widgets/two_dimensional_scrollable_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 230.
- fix description (if clear): Same template-level fix as Index 230.
- need for deeper analysis?: `no`
- batch number: `46`

### Index 233

- Index: 233
- testname: `widgets/two_dimensional_viewport_parent_data_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabController (LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template defect with the `_tabController` variable-name variant.
- fix description (if clear): Initialize `_tabController` in `initState()` and ensure any dependent setup runs after initialization.
- need for deeper analysis?: `no`
- batch number: `46`

### Index 234

- Index: 234
- testname: `widgets/undo_history_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 230. All five Batch-46 issues are late-init state-context defects with mixed variable names (`_tabs` and `_tabController`).
- fix description (if clear): Same template-level fix. The late-init issue now spans Batches 28-46 (55+ demos total).
- need for deeper analysis?: `no`
- batch number: `46`

## Batch-46 Classification Summary

- Missing/stray status for Batch-46 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five late-initialization errors — four `_tabs` (`two_dimensional_child_list_delegate_test`, `two_dimensional_child_manager_test`, `two_dimensional_scrollable_state_test`, `undo_history_state_test`) and one `_tabController` (`two_dimensional_viewport_parent_data_test`).
- Bridge/generator/interpreter classification: none in this batch. All five issues are test-script template defects.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-47 (Issues 235-239)

### Index 235

- Index: 235
- testname: `widgets/undo_history_value_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `UndoHistoryValue` demo script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `47`

### Index 236

- Index: 236
- testname: `widgets/undo_text_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 235.
- fix description (if clear): Same template-level fix as Index 235.
- need for deeper analysis?: `no`
- batch number: `47`

### Index 237

- Index: 237
- testname: `widgets/unfocus_disposition_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 235.
- fix description (if clear): Same template-level fix as Index 235.
- need for deeper analysis?: `no`
- batch number: `47`

### Index 238

- Index: 238
- testname: `widgets/update_selection_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 235.
- fix description (if clear): Same template-level fix as Index 235.
- need for deeper analysis?: `no`
- batch number: `47`

### Index 239

- Index: 239
- testname: `widgets/user_scroll_notification_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 235. All five Batch-47 issues are the same `_tabs` late-init variant.
- fix description (if clear): Same template-level fix. The late-init issue now spans Batches 28-47 (60+ demos total).
- need for deeper analysis?: `no`
- batch number: `47`

## Batch-47 Classification Summary

- Missing/stray status for Batch-47 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`undo_history_value_test`, `undo_text_intent_test`, `unfocus_disposition_test`, `update_selection_intent_test`, `user_scroll_notification_test`).
- Bridge/generator/interpreter classification: none in this batch. All five issues are test-script template defects.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-48 (Issues 240-244)

### Index 240

- Index: 240
- testname: `widgets/viewport_element_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `ViewportElementMixin` demo script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `48`

### Index 241

- Index: 241
- testname: `widgets/viewport_notification_mixin_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 240.
- fix description (if clear): Same template-level fix as Index 240.
- need for deeper analysis?: `no`
- batch number: `48`

### Index 242

- Index: 242
- testname: `widgets/void_callback_action_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 240.
- fix description (if clear): Same template-level fix as Index 240.
- need for deeper analysis?: `no`
- batch number: `48`

### Index 243

- Index: 243
- testname: `widgets/void_callback_intent_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 240.
- fix description (if clear): Same template-level fix as Index 240.
- need for deeper analysis?: `no`
- batch number: `48`

### Index 244

- Index: 244
- testname: `widgets/weak_map_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 240. All five Batch-48 issues are the same `_tabs` late-init variant.
- fix description (if clear): Same template-level fix. The late-init issue now spans Batches 28-48 (65+ demos total).
- need for deeper analysis?: `no`
- batch number: `48`

## Batch-48 Classification Summary

- Missing/stray status for Batch-48 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`viewport_element_mixin_test`, `viewport_notification_mixin_test`, `void_callback_action_test`, `void_callback_intent_test`, `weak_map_test`).
- Bridge/generator/interpreter classification: none in this batch. All five issues are test-script template defects.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-49 (Issues 245-249)

### Index 245

- Index: 245
- testname: `widgets/web_browser_detection_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `WebBrowserDetection` demo script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `49`

### Index 246

- Index: 246
- testname: `widgets/widget_inspector_service_extensions_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 245.
- fix description (if clear): Same template-level fix as Index 245.
- need for deeper analysis?: `no`
- batch number: `49`

### Index 247

- Index: 247
- testname: `widgets/widget_inspector_service_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 245.
- fix description (if clear): Same template-level fix as Index 245.
- need for deeper analysis?: `no`
- batch number: `49`

### Index 248

- Index: 248
- testname: `widgets/widget_order_traversal_policy_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 245.
- fix description (if clear): Same template-level fix as Index 245.
- need for deeper analysis?: `no`
- batch number: `49`

### Index 249

- Index: 249
- testname: `widgets/widget_state_border_side_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 245. All five Batch-49 issues are the same `_tabs` late-init variant.
- fix description (if clear): Same template-level fix. The late-init issue now spans Batches 28-49 (70+ demos total).
- need for deeper analysis?: `no`
- batch number: `49`

## Batch-49 Classification Summary

- Missing/stray status for Batch-49 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`web_browser_detection_test`, `widget_inspector_service_extensions_test`, `widget_inspector_service_test`, `widget_order_traversal_policy_test`, `widget_state_border_side_test`).
- Bridge/generator/interpreter classification: none in this batch. All five issues are test-script template defects.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-50 (Issues 250-254)

### Index 250

- Index: 250
- testname: `widgets/widget_state_color_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `WidgetStateColor` demo script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `50`

### Index 251

- Index: 251
- testname: `widgets/widget_state_mapper_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 250.
- fix description (if clear): Same template-level fix as Index 250.
- need for deeper analysis?: `no`
- batch number: `50`

### Index 252

- Index: 252
- testname: `widgets/widget_state_mouse_cursor_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 250.
- fix description (if clear): Same template-level fix as Index 250.
- need for deeper analysis?: `no`
- batch number: `50`

### Index 253

- Index: 253
- testname: `widgets/widget_state_outlined_border_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 250.
- fix description (if clear): Same template-level fix as Index 250.
- need for deeper analysis?: `no`
- batch number: `50`

### Index 254

- Index: 254
- testname: `widgets/widget_state_property_all_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 250. All five Batch-50 issues are the same `_tabs` late-init variant.
- fix description (if clear): Same template-level fix. The late-init issue now spans Batches 28-50 (75+ demos total).
- need for deeper analysis?: `no`
- batch number: `50`

## Batch-50 Classification Summary

- Missing/stray status for Batch-50 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: five `_tabs` late-initialization errors (`widget_state_color_test`, `widget_state_mapper_test`, `widget_state_mouse_cursor_test`, `widget_state_outlined_border_test`, `widget_state_property_all_test`).
- Bridge/generator/interpreter classification: none in this batch. All five issues are test-script template defects.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-51 (Issues 255-259)

### Index 255

- Index: 255
- testname: `widgets/widget_state_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern. The `WidgetState` demo script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `51`

### Index 256

- Index: 256
- testname: `widgets/widget_state_text_style_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 255.
- fix description (if clear): Same template-level fix as Index 255.
- need for deeper analysis?: `no`
- batch number: `51`

### Index 257

- Index: 257
- testname: `widgets/widget_states_constraint_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template defect as Index 255.
- fix description (if clear): Same template-level fix as Index 255.
- need for deeper analysis?: `no`
- batch number: `51`

### Index 258

- Index: 258
- testname: `widgets/window_positioner_anchor_test.dart`
- category: `BRIDGE-GENERIC-TYPE-COERCION`
- immediate fix possible: `no — requires bridge/generic-factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'ValueNotifier': type 'int' is not a subtype of type 'double' in type cast`.
- detailed analysis what the problem is: The generic constructor factory path for `ValueNotifier<double>` is performing a strict runtime cast and receives an `int` value from interpreted execution. This indicates missing numeric coercion (or missing type adaptation) in the bridge's generic constructor handling, causing cast failure in otherwise valid scenario flows for this demo.
- fix description (if clear): Add bridge-side generic numeric coercion/adaptation for constructor arguments (e.g., `int` to `double` where appropriate), or normalize numeric literals in the generated script path before invoking the generic constructor.
- need for deeper analysis?: `yes — bridge generic factory path`
- batch number: `51`

### Index 259

- Index: 259
- testname: `widgets/window_positioner_constraint_adjustment_test.dart`
- category: `BRIDGE-GENERIC-TYPE-COERCION`
- immediate fix possible: `no — requires bridge/generic-factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'ValueNotifier': type 'int' is not a subtype of type 'double' in type cast`.
- detailed analysis what the problem is: Same as Index 258. The generic constructor factory for `ValueNotifier` fails type coercion when handling numeric argument types.
- fix description (if clear): Same bridge-side generic coercion enhancement as Index 258.
- need for deeper analysis?: `yes — bridge generic factory path`
- batch number: `51`

## Batch-51 Classification Summary

- Missing/stray status for Batch-51 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: three `_tabs` late-initialization errors (`widget_state_test`, `widget_state_text_style_test`, `widget_states_constraint_test`).
- Bridge/generator/interpreter classification: two `BRIDGE-GENERIC-TYPE-COERCION` failures (`window_positioner_anchor_test`, `window_positioner_constraint_adjustment_test`) in generic constructor factory handling for `ValueNotifier<double>`.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-52 (Issues 260-264)

### Index 260

- Index: 260
- testname: `widgets/window_positioner_test.dart`
- category: `BRIDGE-GENERIC-TYPE-COERCION`
- immediate fix possible: `no — requires bridge/generic-factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'ValueNotifier': type 'int' is not a subtype of type 'double' in type cast`.
- detailed analysis what the problem is: Same generic constructor factory issue as Batch-51. The `ValueNotifier<double>` construction path receives an `int` from interpreted execution and performs a strict cast instead of numeric adaptation.
- fix description (if clear): Add bridge-side numeric coercion/adaptation in generic constructor factory handling (e.g., permit `int` to `double` conversion when target type is `double`) or normalize numeric literals before generic constructor dispatch.
- need for deeper analysis?: `yes — bridge generic factory path`
- batch number: `52`

### Index 261

- Index: 261
- testname: `widgets/window_scope_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires widget coercion enhancement`
- description: Test passes but logs: `type 'InterpretedInstance' is not a subtype of type 'Widget' in type cast`.
- detailed analysis what the problem is: A script-created/interpreted widget instance is being passed through a native path expecting a concrete `Widget`, but the bridge fails to coerce/wrap `InterpretedInstance` into an accepted widget representation.
- fix description (if clear): Extend widget coercion/UserBridge logic for this path so interpreted widget instances are converted to native-compatible `Widget` values.
- need for deeper analysis?: `yes — widget coercion path`
- batch number: `52`

### Index 262

- Index: 262
- testname: `widgets/windowing_owner_linux_test.dart`
- category: `BRIDGE-GENERIC-TYPE-COERCION`
- immediate fix possible: `no — requires bridge/generic-factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'ValueNotifier': type 'int' is not a subtype of type 'double' in type cast`.
- detailed analysis what the problem is: Same as Index 260 — generic constructor factory for `ValueNotifier<double>` fails numeric type adaptation.
- fix description (if clear): Same generic numeric coercion enhancement as Index 260.
- need for deeper analysis?: `yes — bridge generic factory path`
- batch number: `52`

### Index 263

- Index: 263
- testname: `widgets/windowing_owner_mac_o_s_test.dart`
- category: `BRIDGE-GENERIC-TYPE-COERCION`
- immediate fix possible: `no — requires bridge/generic-factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'ValueNotifier': type 'int' is not a subtype of type 'double' in type cast`.
- detailed analysis what the problem is: Same as Index 260 — generic constructor factory for `ValueNotifier<double>` fails numeric type adaptation.
- fix description (if clear): Same generic numeric coercion enhancement as Index 260.
- need for deeper analysis?: `yes — bridge generic factory path`
- batch number: `52`

### Index 264

- Index: 264
- testname: `widgets/windowing_owner_test.dart`
- category: `BRIDGE-GENERIC-TYPE-COERCION`
- immediate fix possible: `no — requires bridge/generic-factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'ValueNotifier': type 'int' is not a subtype of type 'double' in type cast`.
- detailed analysis what the problem is: Same as Index 260 — generic constructor factory for `ValueNotifier<double>` fails numeric type adaptation.
- fix description (if clear): Same generic numeric coercion enhancement as Index 260.
- need for deeper analysis?: `yes — bridge generic factory path`
- batch number: `52`

## Batch-52 Classification Summary

- Missing/stray status for Batch-52 scripts: none missing, none stray. All five scripts exist and are referenced by their test suite.
- Test-script issue classification: none in this batch.
- Bridge/generator/interpreter classification: four `BRIDGE-GENERIC-TYPE-COERCION` failures (`window_positioner_test`, `windowing_owner_linux_test`, `windowing_owner_mac_o_s_test`, `windowing_owner_test`) and one `BRIDGE-WIDGET-COERCION` issue (`window_scope_test`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-53 (Issues 265-269)

### Index 265

- Index: 265
- testname: `widgets/windowing_owner_win32_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _tabs (LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same `_tabs` late-init template pattern recurring across earlier batches. The script references a `late` `_tabs` field before initialization.
- fix description (if clear): Initialize `_tabs` in `initState()` or remove/replace the late field with initialized state setup.
- need for deeper analysis?: `no`
- batch number: `53`

### Index 266

- Index: 266
- testname: `(setUpAll)`
- category: `TEST-HARNESS-INFO (no correction needed)`
- immediate fix possible: `not applicable`
- description: Informational log only: `Bridge regeneration skipped: all bridge outputs are up-to-date...`.
- detailed analysis what the problem is: This is not a runtime/interpreter failure; it is a normal build/cache status message from setup in `important_classes_test.dart`.
- fix description (if clear): No fix required.
- need for deeper analysis?: `no`
- batch number: `53`

### Index 267

- Index: 267
- testname: `widgets/slidetransition_test.dart`
- category: `BRIDGE-MISSING-METHOD-DISPATCH`
- immediate fix possible: `no — requires bridge/runtime enhancement`
- description: Test passes but logs: `NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments`.
- detailed analysis what the problem is: The interpreter/bridge wrapper for relaxed animation values (`$RelaxedAnimation<Offset>`) does not expose `Animation` listener APIs (`addListener`) expected by `SlideTransition` flow. This is a method dispatch gap on a wrapped animation type.
- fix description (if clear): Extend bridge/runtime wrapper for relaxed animation objects to forward `addListener`/`removeListener` and related `Listenable` behavior.
- need for deeper analysis?: `yes — animation wrapper dispatch path`
- batch number: `53`

### Index 268

- Index: 268
- testname: `widgets/sliverlist_test.dart`
- category: `TEST-SCRIPT-WIDGET-LIFECYCLE (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs framework assertion + `Duplicate GlobalKey detected in widget tree`.
- detailed analysis what the problem is: The generated demo/test script appears to reuse a `GlobalKey` across simultaneously active widget subtrees, causing framework lifecycle assertion failures (`element._lifecycleState == _ElementLifecycle.active`) and duplicate-key truncation behavior.
- fix description (if clear): Update demo/test script to ensure unique key ownership per mounted subtree and avoid key reuse across active branches.
- need for deeper analysis?: `no`
- batch number: `53`

### Index 269

- Index: 269
- testname: `widgets/nestedscrollview_test.dart`
- category: `BRIDGE-WIDGET-LIST-COERCION`
- immediate fix possible: `no — requires bridge coercion enhancement`
- description: Test passes but logs repeated casts: `type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast`.
- detailed analysis what the problem is: The bridge path handling child collections in `NestedScrollView` is producing/interpreting a generic object list that is not coerced to `List<Widget>`. This is a list-element widget coercion gap (similar family to prior list coercion issues).
- fix description (if clear): Add coercion for interpreted `List<Object?>` into typed `List<Widget>` where widget collection APIs are expected.
- need for deeper analysis?: `yes — widget list coercion path`
- batch number: `53`

## Batch-53 Classification Summary

- Missing/stray status for Batch-53 scripts: none missing, none stray. All four script files are present and referenced; index 266 is setup-level informational output from `important_classes_test.dart`.
- Test-script issue classification: one `_tabs` late-init defect (`windowing_owner_win32_test`) and one widget lifecycle/key misuse defect (`sliverlist_test`).
- Bridge/generator/interpreter classification: one `BRIDGE-MISSING-METHOD-DISPATCH` (`slidetransition_test` addListener on relaxed animation wrapper) and one `BRIDGE-WIDGET-LIST-COERCION` (`nestedscrollview_test` list cast to `List<Widget>`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-54 (Issues 270-274)

### Index 270

- Index: 270
- testname: `material/refreshindicator_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs a cascade beginning with `RenderFlex children have non-zero flex but incoming height constraints are unbounded`, followed by multiple `RenderBox was not laid out` assertions and semantics/layout assertions.
- detailed analysis what the problem is: The generated test scene composes a flex-based child in an unbounded-height parent context (likely inside scroll/view structures) without constraining layout, triggering a chain of render/layout failures and semantics assertion fallout.
- fix description (if clear): Adjust test/demo composition to provide bounded height constraints for flex children (e.g., wrap with `Expanded` within bounded parent, constrain via `SizedBox`, or restructure scroll/flex nesting).
- need for deeper analysis?: `no`
- batch number: `54`

### Index 271

- Index: 271
- testname: `material/timeofday_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `RenderBox was not laid out: RenderTransform ... 'hasSize'`.
- detailed analysis what the problem is: Likely residual layout instability in the same important-classes run context, with transform/render object accessing size before layout completion.
- fix description (if clear): Ensure the tested widget tree reaches a stable layout phase with bounded constraints before transform-dependent operations/assertions.
- need for deeper analysis?: `no`
- batch number: `54`

### Index 272

- Index: 272
- testname: `material/showdialog_test.dart`
- category: `TEST-SCRIPT-INTENTIONAL-SKIP`
- immediate fix possible: `not needed`
- description: `Skip: Shows popup dialog requiring user interaction`.
- detailed analysis what the problem is: Intentional skip for interaction-dependent scenario; this is expected and not a runtime/interpreter defect.
- fix description (if clear): No fix required unless automation strategy for interaction is introduced.
- need for deeper analysis?: `no`
- batch number: `54`

### Index 273

- Index: 273
- testname: `material/showbottomsheet_test.dart`
- category: `TEST-SCRIPT-INTENTIONAL-SKIP`
- immediate fix possible: `not needed`
- description: `Skip: Shows bottom sheet requiring user interaction`.
- detailed analysis what the problem is: Intentional skip for interaction-dependent scenario; expected behavior.
- fix description (if clear): No fix required unless interaction automation is added.
- need for deeper analysis?: `no`
- batch number: `54`

### Index 274

- Index: 274
- testname: `material/showmenu_test.dart`
- category: `TEST-SCRIPT-INTENTIONAL-SKIP`
- immediate fix possible: `not needed`
- description: `Skip: Shows popup menu requiring user interaction`.
- detailed analysis what the problem is: Intentional skip for interaction-dependent scenario; expected behavior.
- fix description (if clear): No fix required unless interaction automation is added.
- need for deeper analysis?: `no`
- batch number: `54`

## Batch-54 Classification Summary

- Missing/stray status for Batch-54 scripts: none missing, none stray. All referenced material scripts are present and listed in the status report.
- Test-script issue classification: two layout-constraint/lifecycle rendering defects (`refreshindicator_test`, `timeofday_test`) and three intentional interactive skips (`showdialog_test`, `showbottomsheet_test`, `showmenu_test`).
- Bridge/generator/interpreter classification: none identified in this batch.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-55 (Issues 275-279)

### Index 275

- Index: 275
- testname: `material/showdatepicker_test.dart`
- category: `TEST-SCRIPT-INTENTIONAL-SKIP`
- immediate fix possible: `not needed`
- description: `Skip: Shows date picker requiring user interaction`.
- detailed analysis what the problem is: Intentional skip for interaction-dependent scenario; expected behavior.
- fix description (if clear): No fix required unless interaction automation is added.
- need for deeper analysis?: `no`
- batch number: `55`

### Index 276

- Index: 276
- testname: `material/showtimepicker_test.dart`
- category: `TEST-SCRIPT-INTENTIONAL-SKIP`
- immediate fix possible: `not needed`
- description: `Skip: Shows time picker requiring user interaction`.
- detailed analysis what the problem is: Intentional skip for interaction-dependent scenario; expected behavior.
- fix description (if clear): No fix required unless interaction automation is added.
- need for deeper analysis?: `no`
- batch number: `55`

### Index 277

- Index: 277
- testname: `widgets/actions_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs: `Undefined variable: _dispatcher (LateInitializationError: Late variable '_dispatcher' without initializer is accessed before being assigned.)`.
- detailed analysis what the problem is: Same late-init template family as prior batches, with `_dispatcher` as the variable variant. The script references a `late` field before initialization.
- fix description (if clear): Initialize `_dispatcher` in setup/init path before first read, or replace with non-late initialized field.
- need for deeper analysis?: `no`
- batch number: `55`

### Index 278

- Index: 278
- testname: `animation/tweensequence_test.dart`
- category: `BRIDGE-GENERIC-CONSTRUCTOR-NULL-HANDLING`
- immediate fix possible: `no — requires generic factory enhancement`
- description: Test fails with: `Error in generic constructor factory for 'TweenSequenceItem': Null check operator used on a null value`.
- detailed analysis what the problem is: Generic constructor factory path for `TweenSequenceItem` dereferences a nullable value with `!` during construction, indicating missing null-safety handling in bridge factory argument processing.
- fix description (if clear): Harden generic constructor factory null handling for `TweenSequenceItem` (and similar generic animation items), validating/normalizing nullable fields before forced casts.
- need for deeper analysis?: `yes — generic constructor factory`
- batch number: `55`

### Index 279

- Index: 279
- testname: `services/codecs_test.dart`
- category: `BRIDGE-SDK-SYMBOL-RESOLUTION`
- immediate fix possible: `no — requires symbol exposure/import bridging`
- description: Test fails with: `Runtime Error: Undefined variable: ByteData`.
- detailed analysis what the problem is: `ByteData` symbol from `dart:typed_data` is not resolved in interpreted runtime path for this services script, indicating missing SDK symbol registration/import exposure in bridge/interpreter context.
- fix description (if clear): Ensure `ByteData` (and typed_data symbols) are exposed/resolved in the runtime bridge symbol table for script execution.
- need for deeper analysis?: `yes — SDK symbol mapping path`
- batch number: `55`

## Batch-55 Classification Summary

- Missing/stray status for Batch-55 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: one late-init state-context defect (`actions_test`) and two intentional interaction skips (`showdatepicker_test`, `showtimepicker_test`).
- Bridge/generator/interpreter classification: one `BRIDGE-GENERIC-CONSTRUCTOR-NULL-HANDLING` issue (`tweensequence_test`) and one `BRIDGE-SDK-SYMBOL-RESOLUTION` issue (`codecs_test` ByteData unresolved).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-56 (Issues 280-284)

### Index 280

- Index: 280
- testname: `services/channels_test.dart`
- category: `BRIDGE-CALLBACK-TYPE-COERCION`
- immediate fix possible: `no — requires bridge callback adaptation`
- description: Test fails with: `Runtime Error: Native error during bridged method call 'setMessageHandler' on BasicMessageChannel: type '(dynamic) => Future<dynamic>' is not a subtype of type '((String?) => Future<String>)?' of 'handler'`.
- detailed analysis what the problem is: The bridge/runtime method adapter for `BasicMessageChannel.setMessageHandler` forwards an untyped interpreted callback `(dynamic) => Future<dynamic>` into a native API that expects a strictly typed nullable callback for `String` payloads. The mismatch is in function signature and generic/nullability adaptation during method-call bridging.
- fix description (if clear): Add callback-signature coercion in the `BasicMessageChannel` bridge path so interpreted handlers are wrapped/adapted to the target typed signature `String? -> Future<String?>` (including nullable input/output handling) before calling native `setMessageHandler`.
- need for deeper analysis?: `yes — services callback bridging path`
- batch number: `56`

### Index 281

- Index: 281
- testname: `(setUpAll)`
- category: `TEST-HARNESS-INFO (no correction needed)`
- immediate fix possible: `not applicable`
- description: Informational log only: `Bridge regeneration skipped: all bridge outputs are up-to-date...`.
- detailed analysis what the problem is: This is an operational setup/caching message from `secondary_classes_test.dart`, not a runtime failure and not a bridge/interpreter defect.
- fix description (if clear): No functional fix required; optionally demote/filter this message in issue extraction if cleaner reports are desired.
- need for deeper analysis?: `no`
- batch number: `56`

### Index 282

- Index: 282
- testname: `cupertino/cupertino_secondary_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs framework errors: negative minimum height constraints, `_RenderEditableCustomPaint` not laid out, and semantics/layout assertions.
- detailed analysis what the problem is: The test script builds editable Cupertino content under invalid constraints, leading to a render/layout assertion cascade. The signature matches known script composition/constraint issues, not a bridge/generator/interpreter limitation.
- fix description (if clear): Rework script widget composition to enforce bounded, non-negative constraints for editable/render objects (for example, constrain form rows/scroll regions with explicit size rules) and assert zero framework errors in the test harness.
- need for deeper analysis?: `no`
- batch number: `56`

### Index 283

- Index: 283
- testname: `cupertino/cupertino_form_scroll_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs framework errors: negative minimum height constraints, `_RenderEditableCustomPaint` not laid out, `RenderFlex` overflow, and semantics/layout assertions.
- detailed analysis what the problem is: Same layout-contract defect family as Index 282 with additional overflow symptoms, indicating the script's scroll/form composition allows invalid/unstable constraints during render.
- fix description (if clear): Refactor the demo layout to provide bounded height/width for editable descendants and flex children; remove overflow-prone nesting patterns and keep post-layout assertions clean.
- need for deeper analysis?: `no`
- batch number: `56`

### Index 284

- Index: 284
- testname: `cupertino/cupertino_controls_advanced_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs framework errors: negative minimum height constraints, `_RenderEditableCustomPaint` not laid out, `RenderFlex` overflow, and semantics/layout assertions.
- detailed analysis what the problem is: Repeats the same Cupertino layout-constraint failure signature as indices 282-283, pointing to test-script UI composition issues rather than runtime bridge/interpreter failures.
- fix description (if clear): Apply the same constraint-hardening changes used for related Cupertino scripts (bounded containers, corrected flex/scroll nesting, stable layout before assertions).
- need for deeper analysis?: `no`
- batch number: `56`

## Batch-56 Classification Summary

- Missing/stray status for Batch-56 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: three layout-constraint defects requiring script correction (`cupertino_secondary_test`, `cupertino_form_scroll_test`, `cupertino_controls_advanced_test`).
- Bridge/generator/interpreter classification: one `BRIDGE-CALLBACK-TYPE-COERCION` failure (`services/channels_test` `BasicMessageChannel.setMessageHandler` callback signature mismatch).
- Harness/log-only classification: one setup informational output (`setUpAll` in `secondary_classes_test.dart`) with no functional defect.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-57 (Issues 285-289)

### Index 285

- Index: 285
- testname: `cupertino/cupertino_sections_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs framework errors: repeated negative minimum-height constraints, `_RenderEditableCustomPaint` not laid out, and semantics/layout assertions.
- detailed analysis what the problem is: The script composes editable Cupertino content under invalid constraints, producing the same render/layout assertion cascade seen in adjacent batches. This signature indicates script-level layout contract violations, not a bridge/generator/interpreter failure.
- fix description (if clear): Adjust layout composition to enforce bounded, non-negative constraints for editable descendants and validate the scenario with zero framework errors in the test log.
- need for deeper analysis?: `no`
- batch number: `57`

### Index 286

- Index: 286
- testname: `cupertino/cupertino_tabbar_scaffold_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs many framework errors: repeated negative minimum-height constraints, multiple `_RenderEditableCustomPaint` layout assertions, and semantics/layout assertion failure.
- detailed analysis what the problem is: Same layout-constraint defect family as Index 285, with higher multiplicity due more affected widget paths in the tab scaffold scenario. No direct signal of runtime bridge/interpreter limitation.
- fix description (if clear): Refactor script layout around tab/content sections to provide stable bounded constraints for editable/render objects and remove assertion-producing nesting patterns.
- need for deeper analysis?: `no`
- batch number: `57`

### Index 287

- Index: 287
- testname: `material/button_types_test.dart`
- category: `TEST-SCRIPT-DEPRECATED-API-SKIP`
- immediate fix possible: `yes`
- description: Skipped with log: `Uses deprecated Flutter API: ButtonBar`.
- detailed analysis what the problem is: This is an intentional compatibility skip because the script depends on deprecated API usage. It is not a bridge/generator/interpreter failure.
- fix description (if clear): Migrate the script away from deprecated `ButtonBar` usage (for example to current button layout widgets) and re-enable execution; until migrated, keep explicit skip classification.
- need for deeper analysis?: `no`
- batch number: `57`

### Index 288

- Index: 288
- testname: `material/toggle_segmented_test.dart`
- category: `TEST-SCRIPT-DEPRECATED-API-SKIP`
- immediate fix possible: `yes`
- description: Skipped with log: `Uses deprecated Flutter API: ButtonBar`.
- detailed analysis what the problem is: Same deprecated-API skip pattern as Index 287. This is intentional script gating, not runtime bridge/interpreter breakage.
- fix description (if clear): Replace deprecated `ButtonBar` usage with supported widgets and remove skip once migration is complete.
- need for deeper analysis?: `no`
- batch number: `57`

### Index 289

- Index: 289
- testname: `material/button_styles_misc_test.dart`
- category: `TEST-SCRIPT-DEPRECATED-API-SKIP`
- immediate fix possible: `yes`
- description: Skipped with log: `Uses deprecated Flutter API: ButtonBarThemeData`.
- detailed analysis what the problem is: Intentional skip due deprecated Flutter API dependency in script. Not a bridge/generator/interpreter issue.
- fix description (if clear): Migrate from deprecated `ButtonBarThemeData` usage to current theming approach and re-enable the test script.
- need for deeper analysis?: `no`
- batch number: `57`

## Batch-57 Classification Summary

- Missing/stray status for Batch-57 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: two layout-constraint defects (`cupertino_sections_test`, `cupertino_tabbar_scaffold_test`) and three intentional deprecated-API skips (`button_types_test`, `toggle_segmented_test`, `button_styles_misc_test`).
- Bridge/generator/interpreter classification: none identified in this batch.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-58 (Issues 290-294)

### Index 290

- Index: 290
- testname: `semantics/semantics_config_test.dart`
- category: `BRIDGE-CALLBACK-TYPE-COERCION`
- immediate fix possible: `no — requires callback bridge adaptation`
- description: Test fails with: `type 'InterpretedFunction' is not a subtype of type '(() => void)?'`.
- detailed analysis what the problem is: The semantics config path expects a nullable native zero-argument callback `VoidCallback?`, but runtime bridge dispatch passes an uncoerced `InterpretedFunction`. This is the same callback-signature adaptation class as prior `setMessageHandler` mismatch issues, now on the semantics callback boundary.
- fix description (if clear): Add bridge callback coercion for nullable `VoidCallback` parameters so interpreted functions are wrapped into native callable adapters before invocation/assignment.
- need for deeper analysis?: `yes — callback adaptation path in semantics bridge/runtime`
- batch number: `58`

### Index 291

- Index: 291
- testname: `widgets/gesture_detector_adv_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated runtime errors: `Undefined variable: widget` on multiple scene `State` classes.
- detailed analysis what the problem is: The script references implicit `widget` state context in several scene states where generated/interpreted access path is unresolved in this scenario, producing non-failing runtime warnings. This matches the recurring state-context defect pattern already seen across earlier batches.
- fix description (if clear): Refactor affected scene states to pass required values explicitly (constructor fields/callbacks) or ensure state context access is valid before use; eliminate runtime warning output in success runs.
- need for deeper analysis?: `no`
- batch number: `58`

### Index 292

- Index: 292
- testname: `widgets/layout_builder_adv_test.dart`
- category: `BRIDGE-MISSING-METHOD-DISPATCH + TEST-SCRIPT-LAYOUT-CONSTRAINT`
- immediate fix possible: `no — mixed bridge and script fixes required`
- description: Test passes but logs runtime and framework errors including `Undefined variable: layoutChild` on `TestMultiChildLayoutDelegate`, multiple infinite-size layout assertions, NaN rect assertion, and semantics/layout assertion.
- detailed analysis what the problem is: This issue combines a bridge/runtime dispatch gap (`layoutChild` unresolved on delegate) with unstable test-script layout composition (infinite constraints and downstream render assertions). The unresolved delegate method indicates missing method dispatch exposure for the delegate path, while the remaining errors indicate constraint misuse in the demo tree.
- fix description (if clear): (1) Add/repair delegate method dispatch exposure for `layoutChild` in bridge/runtime handling. (2) Rework layout-builder demo composition to avoid infinite constraints and NaN geometry paths, then assert no framework errors.
- need for deeper analysis?: `yes — mixed bridge dispatch and layout composition path`
- batch number: `58`

### Index 293

- Index: 293
- testname: `widgets/platform_menu_widgets_test.dart`
- category: `TEST-SCRIPT-DEPRECATED-API-SKIP`
- immediate fix possible: `yes`
- description: Skipped with log: `Uses deprecated Flutter API: RawKeyboardListener`.
- detailed analysis what the problem is: Intentional deprecated-API skip; this is not a bridge/generator/interpreter failure.
- fix description (if clear): Migrate script away from `RawKeyboardListener` to supported keyboard/input APIs, then remove skip.
- need for deeper analysis?: `no`
- batch number: `58`

### Index 294

- Index: 294
- testname: `widgets/scroll_position_types_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs unbounded-height flex constraint error and semantics/layout assertion.
- detailed analysis what the problem is: The script builds flex content under unconstrained vertical layout, creating the standard unbounded `RenderFlex` failure signature and follow-on semantics assertion.
- fix description (if clear): Constrain vertical layout bounds for flex content (or restructure flex/scroll nesting) and verify the test run emits no framework errors.
- need for deeper analysis?: `no`
- batch number: `58`

## Batch-58 Classification Summary

- Missing/stray status for Batch-58 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: one state-context warning group (`gesture_detector_adv_test`), one layout-constraint issue (`scroll_position_types_test`), one mixed bridge+layout issue (`layout_builder_adv_test`), and one deprecated-API skip (`platform_menu_widgets_test`).
- Bridge/generator/interpreter classification: one `BRIDGE-CALLBACK-TYPE-COERCION` failure (`semantics_config_test`) and one `BRIDGE-MISSING-METHOD-DISPATCH` component in `layout_builder_adv_test`.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-59 (Issues 295-299)

### Index 295

- Index: 295
- testname: `widgets/scroll_controllers_types_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs a long render/layout assertion cascade beginning with unbounded-height flex constraints and multiple `RenderBox was not laid out` failures.
- detailed analysis what the problem is: The script builds flex/scroll content under unconstrained vertical layout, causing repeated downstream layout failures and semantics assertions. This matches recurring script-level layout-constraint defects, not a bridge/runtime signature.
- fix description (if clear): Constrain vertical layout bounds for flex children and simplify nested scroll/flex composition so render objects receive finite constraints before assertions.
- need for deeper analysis?: `no`
- batch number: `59`

### Index 296

- Index: 296
- testname: `cupertino/cupertino_text_selection_controls_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated negative minimum-height constraints and `_RenderEditableCustomPaint` layout assertions.
- detailed analysis what the problem is: Same Cupertino editable-layout constraint failure family seen in previous batches; invalid constraints propagate into repeated render/layout assertion failures.
- fix description (if clear): Rework the script UI composition around editable controls to ensure bounded, non-negative constraints and stable layout before semantics checks.
- need for deeper analysis?: `no`
- batch number: `59`

### Index 297

- Index: 297
- testname: `dart_ui/ztmp_path_metrics_access_test.dart`
- category: `TEST-SCRIPT-ASSERTION-PRECONDITION (needs correction)`
- immediate fix possible: `yes`
- description: Test fails with: `Bad state: No element`.
- detailed analysis what the problem is: The test accesses an element from an empty sequence (likely first path metric) without guarding for empty results. This is a test-script precondition/assertion defect unless proven otherwise by deeper runtime instrumentation.
- fix description (if clear): Ensure the script builds a path/fixture that guarantees at least one metric before element access, or add explicit empty-check guards with deterministic assertions.
- need for deeper analysis?: `yes — verify fixture construction vs runtime behavior`
- batch number: `59`

### Index 298

- Index: 298
- testname: `dart_ui/scene_test.dart`
- category: `TEST-SCRIPT-MATH-CONTRACT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs assertion from `dart:ui/math.dart` (`... is not true`).
- detailed analysis what the problem is: A math/geometry precondition in the scene demo is violated during execution (invalid numeric state/transform input), yielding framework assertion output in an otherwise passing run.
- fix description (if clear): Validate and clamp geometry/transform inputs used by the scene test path so math preconditions remain valid throughout the scenario.
- need for deeper analysis?: `no`
- batch number: `59`

### Index 299

- Index: 299
- testname: `dart_ui/semantics_action_event_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs two horizontal `RenderFlex overflowed` warnings.
- detailed analysis what the problem is: The scripted UI composes content wider than available horizontal bounds in at least two states; this is a script layout/overflow quality issue.
- fix description (if clear): Add responsive constraints/wrapping or adjust row layout to prevent horizontal overflow in all tested states.
- need for deeper analysis?: `no`
- batch number: `59`

## Batch-59 Classification Summary

- Missing/stray status for Batch-59 scripts: none missing, none stray. All referenced scripts are present on disk; `ztmp_path_metrics_access_test.dart` was added to the status report list for tracking completeness.
- Test-script issue classification: two layout-constraint defects (`scroll_controllers_types_test`, `cupertino_text_selection_controls_test`), one assertion-precondition failure (`ztmp_path_metrics_access_test`), one math-contract assertion warning (`scene_test`), and one overflow warning (`semantics_action_event_test`).
- Bridge/generator/interpreter classification: none conclusively identified in this batch.
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-60 (Issues 300-304)

### Index 300

- Index: 300
- testname: `dart_ui/string_attribute_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs bottom overflow: `A RenderFlex overflowed by 4.0 pixels on the bottom.`
- detailed analysis what the problem is: Scripted layout exceeds available vertical space in at least one state. This is a test-scene composition issue, not a bridge/runtime failure.
- fix description (if clear): Constrain vertical layout or reduce child sizing so the RenderFlex remains within bounds across all scene states.
- need for deeper analysis?: `no`
- batch number: `60`

### Index 301

- Index: 301
- testname: `dart_ui/target_image_size_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated bottom overflow (`RenderFlex overflowed by 16 pixels on the bottom`).
- detailed analysis what the problem is: Same overflow family as Index 300 with repeated occurrences, indicating fixed-size content exceeds constrained viewport height in multiple states.
- fix description (if clear): Rework scene sizing/responsiveness and constrain vertical content to prevent repeated overflow warnings.
- need for deeper analysis?: `no`
- batch number: `60`

### Index 302

- Index: 302
- testname: `gestures/vertical_multi_drag_gesture_recognizer_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated runtime warnings: `Undefined variable: widget` on `_VerticalTrackState`.
- detailed analysis what the problem is: Recurring state-context access defect where the script relies on implicit `widget` access path that is unresolved in interpreted execution for this scene state.
- fix description (if clear): Replace implicit `widget` reads with explicit state fields/constructor parameters or ensure valid state-context access before use.
- need for deeper analysis?: `no`
- batch number: `60`

### Index 303

- Index: 303
- testname: `material/scaffold_messenger_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires bridge coercion enhancement`
- description: Test fails with: `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: Interpreter returns an `InterpretedInstance` where native code path asserts `Widget`. This matches established widget-coercion bridge gap patterns from earlier batches.
- fix description (if clear): Extend widget coercion bridge handling for this ScaffoldMessenger path so interpreted widget instances are unwrapped/coerced to native `Widget` before assertion boundary.
- need for deeper analysis?: `yes — bridge widget coercion path`
- batch number: `60`

### Index 304

- Index: 304
- testname: `material/text_button_theme_data_test.dart`
- category: `TEST-SCRIPT-NULL-RECEIVER (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs runtime error: `Cannot invoke method 'toStringAsFixed' on null. Use '?.' for null-aware method invocation.`
- detailed analysis what the problem is: Script executes numeric formatting on a nullable value without null guarding, producing runtime warning output in a success run.
- fix description (if clear): Add null-aware formatting (`?.`) or explicit null defaulting before `toStringAsFixed` call in the test scene.
- need for deeper analysis?: `no`
- batch number: `60`

## Batch-60 Classification Summary

- Missing/stray status for Batch-60 scripts: none missing, none stray. All referenced scripts are present and already listed in the status report.
- Test-script issue classification: two overflow issues (`string_attribute_test`, `target_image_size_test`), one state-context warning group (`vertical_multi_drag_gesture_recognizer_test`), and one null-receiver warning (`text_button_theme_data_test`).
- Bridge/generator/interpreter classification: one `BRIDGE-WIDGET-COERCION` failure (`scaffold_messenger_test`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-61 (Issues 305-309)

### Index 305

- Index: 305
- testname: `material/text_selection_toolbar_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs infinite-size layout assertions (`RenderCustomSingleChildLayoutBox`, `RenderPadding`, `RenderTransform`) and a semantics/layout assertion.
- detailed analysis what the problem is: Script composes toolbar layout in an unconstrained sizing context, triggering infinite-size render-object assertions and follow-on semantics failures.
- fix description (if clear): Constrain toolbar scene layout with finite bounds and avoid unconstrained parent chains before semantics checks.
- need for deeper analysis?: `no`
- batch number: `61`

### Index 306

- Index: 306
- testname: `material/text_selection_toolbar_text_button_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs the same infinite-size layout assertion pattern and semantics/layout assertion as Index 305.
- detailed analysis what the problem is: Same layout-contract defect family as Index 305 in a sibling toolbar-text-button scenario.
- fix description (if clear): Apply the same finite-constraint layout hardening and scene-structure cleanup as Index 305.
- need for deeper analysis?: `no`
- batch number: `61`

### Index 307

- Index: 307
- testname: `painting/decoration_image_painter_test.dart`
- category: `TEST-SCRIPT-CONSTRUCTOR-ARGS (needs correction)`
- immediate fix possible: `yes`
- description: Test fails with native constructor error for `Text`: `Invalid parameter \"data\": expected String, got Null`.
- detailed analysis what the problem is: The script path passes null into `Text` data argument, violating non-null constructor contract. Although surfaced through bridge constructor dispatch, this pattern is script argument misuse unless proven otherwise by deeper runtime tracing.
- fix description (if clear): Ensure non-null fallback/default string is supplied before `Text` construction in the test scene.
- need for deeper analysis?: `no`
- batch number: `61`

### Index 308

- Index: 308
- testname: `painting/image_info_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs bottom RenderFlex overflows (27 px and 58 px).
- detailed analysis what the problem is: Scripted UI layout exceeds vertical bounds in multiple states, producing overflow warnings.
- fix description (if clear): Add responsive/flexible vertical constraints and reduce fixed-height pressure in the affected scene blocks.
- need for deeper analysis?: `no`
- batch number: `61`

### Index 309

- Index: 309
- testname: `rendering/box_hit_test_result_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires bridge coercion enhancement`
- description: Test fails with: `Expected Widget but got InterpretedInstance`.
- detailed analysis what the problem is: Runtime returns `InterpretedInstance` where native assertion path expects concrete `Widget`, matching the recurring widget-coercion bridge gap pattern.
- fix description (if clear): Extend widget coercion handling for this rendering path to unwrap/coerce interpreted widget instances to native `Widget` before assertion boundaries.
- need for deeper analysis?: `yes — bridge widget coercion path`
- batch number: `61`

## Batch-61 Classification Summary

- Missing/stray status for Batch-61 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: two layout-constraint defects (`text_selection_toolbar_test`, `text_selection_toolbar_text_button_test`), one constructor-arg misuse (`decoration_image_painter_test`), and one overflow warning (`image_info_test`).
- Bridge/generator/interpreter classification: one `BRIDGE-WIDGET-COERCION` failure (`box_hit_test_result_test`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-62 (Issues 310-314)

### Index 310

- Index: 310
- testname: `rendering/custom_painter_semantics_test.dart`
- category: `BRIDGE-CALLBACK-TYPE-COERCION + TEST-SCRIPT-OVERFLOW`
- immediate fix possible: `no — mixed bridge and script fixes required`
- description: Test passes but logs callback signature mismatch for `semanticsBuilder` plus a bottom overflow warning.
- detailed analysis what the problem is: The bridge constructor path expects `((Size) => List<CustomPainterSemantics>)?` but receives an unadapted `InterpretedFunction`. In parallel, the scene has minor layout overflow. This combines callback adaptation gap and script layout quality issue.
- fix description (if clear): (1) Add callback-signature coercion for `semanticsBuilder` function type in bridge constructor adaptation. (2) Tighten scene layout to eliminate overflow warning output.
- need for deeper analysis?: `yes — callback adaptation path`
- batch number: `62`

### Index 311

- Index: 311
- testname: `rendering/platform_view_layer_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs horizontal RenderFlex overflows (53 px and 70 px).
- detailed analysis what the problem is: Scripted layout exceeds horizontal bounds in multiple states; this is a layout composition issue rather than bridge/runtime failure.
- fix description (if clear): Add responsive width constraints/wrapping and reduce fixed-width pressure in affected rows.
- need for deeper analysis?: `no`
- batch number: `62`

### Index 312

- Index: 312
- testname: `rendering/relayout_when_system_fonts_change_mixin_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires bridge coercion enhancement`
- description: Test passes but logs `Positioned.fill` constructor error: expected `Widget` child, got `InterpretedInstance(_RelayoutHostWidget)`.
- detailed analysis what the problem is: Widget child argument is not coerced from interpreted instance to native `Widget` in bridged constructor path, matching recurring widget coercion gap pattern.
- fix description (if clear): Extend constructor-arg widget coercion for `Positioned.fill` child parameter to unwrap interpreted widget instances before native invocation.
- need for deeper analysis?: `yes — widget coercion path in constructor bridging`
- batch number: `62`

### Index 313

- Index: 313
- testname: `rendering/render_absorb_pointer_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires bridge coercion enhancement`
- description: Test passes but logs the same `Positioned.fill` child coercion error (`expected Widget, got InterpretedInstance(_AbsorbGateHost)`).
- detailed analysis what the problem is: Same widget child coercion gap as Index 312 in a sibling rendering scenario, indicating shared constructor adaptation defect.
- fix description (if clear): Reuse `Positioned.fill` child widget coercion fix from Index 312; this should resolve both cases.
- need for deeper analysis?: `yes — shared constructor bridge path`
- batch number: `62`

### Index 314

- Index: 314
- testname: `rendering/render_aligning_shifted_box_test.dart`
- category: `BRIDGE-MISSING-MEMBER`
- immediate fix possible: `no — requires bridge/member exposure`
- description: Test passes but logs runtime error in `Iterable.toList` flow: `Undefined property or method 'characters' on bridged instance of 'String'.`
- detailed analysis what the problem is: The runtime bridge for `String` does not expose the `characters` member used by this script path (likely extension/member resolution gap), causing downstream method-call failure.
- fix description (if clear): Add member exposure/bridge support for `String.characters` access path (or equivalent bridging for required extension behavior) before `toList` evaluation.
- need for deeper analysis?: `yes — String member/extension bridge mapping`
- batch number: `62`

## Batch-62 Classification Summary

- Missing/stray status for Batch-62 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: one overflow-only issue (`platform_view_layer_test`) and one mixed overflow issue paired with callback coercion (`custom_painter_semantics_test`).
- Bridge/generator/interpreter classification: one callback coercion issue (`custom_painter_semantics_test`), two widget coercion issues (`relayout_when_system_fonts_change_mixin_test`, `render_absorb_pointer_test`), and one missing member exposure issue (`render_aligning_shifted_box_test` for `String.characters`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-63 (Issues 315-319)

### Index 315

- Index: 315
- testname: `rendering/render_animated_opacity_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs late-init state access (`_controller`) before assignment.
- detailed analysis what the problem is: The script lifecycle/state setup accesses `_controller` before initialization, producing `LateInitializationError` surfaced as framework log output. This is test-script state-context sequencing, not a bridge/generator failure.
- fix description (if clear): Ensure `_controller` is initialized during setup (`initState`/pre-pump path) before any listener/build path reads it; add guard assertions to prevent uninitialized access.
- need for deeper analysis?: `no`
- batch number: `63`

### Index 316

- Index: 316
- testname: `rendering/render_block_semantics_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated bottom RenderFlex overflow (`56 px`).
- detailed analysis what the problem is: Scripted layout exceeds vertical constraints in the test scene, generating framework overflow errors despite pass status.
- fix description (if clear): Rebalance vertical layout constraints (flex/scroll/sizing adjustments) to eliminate overflow warnings.
- need for deeper analysis?: `no`
- batch number: `63`

### Index 317

- Index: 317
- testname: `rendering/render_box_container_defaults_mixin_test.dart`
- category: `BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — requires bridge coercion enhancement`
- description: Test passes but logs constructor/parameter coercion failure: expected `Widget`, got `InterpretedInstance(_DefaultsContainer)`.
- detailed analysis what the problem is: Bridge invocation path does not coerce interpreted widget instances to native `Widget` for this build parameter path, matching recurring widget coercion gaps.
- fix description (if clear): Extend bridge argument coercion for widget-typed build parameters to unwrap/coerce interpreted widget instances before native call boundaries.
- need for deeper analysis?: `yes — widget coercion path`
- batch number: `63`

### Index 318

- Index: 318
- testname: `rendering/render_custom_multi_child_layout_box_test.dart`
- category: `BRIDGE-DELEGATE-TYPE-COERCION`
- immediate fix possible: `no — requires bridge delegate coercion`
- description: Test passes but logs constructor failure for `CustomMultiChildLayout`: expected `MultiChildLayoutDelegate`, got interpreted delegate instance.
- detailed analysis what the problem is: Default bridged constructor path does not adapt interpreted delegate objects to native `MultiChildLayoutDelegate`, causing runtime type rejection.
- fix description (if clear): Add bridge adaptation for `MultiChildLayoutDelegate`-typed constructor arguments (explicit adapter/custom bridge mapping for interpreted delegate instances).
- need for deeper analysis?: `yes — delegate adaptation path`
- batch number: `63`

### Index 319

- Index: 319
- testname: `rendering/render_custom_paint_test.dart`
- category: `BRIDGE-MIXIN-TARGET-COERCION + TEST-SCRIPT-ASSERTION-PRECONDITION`
- immediate fix possible: `no — mixed bridge and script fixes required`
- description: Test passes but logs invalid bridged `mounted` mixin target plus `Bad state: No element`.
- detailed analysis what the problem is: Primary failure is bridge-side mixin target mismatch (`mounted` getter expects `SingleTickerProviderStateMixin` target but receives interpreted instance). Secondary `Bad state: No element` indicates script assertions/state queries occur after the bridge error path destabilizes expected collections.
- fix description (if clear): (1) Add mixin target coercion/dispatch support for `SingleTickerProviderStateMixin`-bound getter path (`mounted`). (2) Harden test assertions to avoid `No element` on empty collections after runtime errors.
- need for deeper analysis?: `yes — mixin getter dispatch/coercion path`
- batch number: `63`

## Batch-63 Classification Summary

- Missing/stray status for Batch-63 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: one state-context initialization issue (`render_animated_opacity_test`) and one overflow issue (`render_block_semantics_test`).
- Bridge/generator/interpreter classification: one widget coercion issue (`render_box_container_defaults_mixin_test`), one delegate type coercion issue (`render_custom_multi_child_layout_box_test`), and one mixin target coercion issue with follow-on assertion instability (`render_custom_paint_test`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-64 (Issues 320-324)

### Index 320

- Index: 320
- testname: `rendering/render_custom_single_child_layout_box_test.dart`
- category: `BRIDGE-DELEGATE-TYPE-COERCION`
- immediate fix possible: `no — requires bridge delegate coercion`
- description: Test passes but logs constructor failure for `CustomSingleChildLayout`: expected `SingleChildLayoutDelegate`, got interpreted delegate instance.
- detailed analysis what the problem is: Bridged constructor path does not adapt interpreted delegate objects to native `SingleChildLayoutDelegate`, causing runtime type rejection.
- fix description (if clear): Add bridge adaptation for `SingleChildLayoutDelegate`-typed constructor arguments (custom adapter/user-bridge mapping for interpreted delegate instances).
- need for deeper analysis?: `yes — delegate adaptation path`
- batch number: `64`

### Index 321

- Index: 321
- testname: `rendering/render_editable_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs negative min-height constraints for editable render path plus not-laid-out and semantics assertions.
- detailed analysis what the problem is: Scripted scene produces invalid constraints for `_RenderEditableCustomPaint`, cascading into missing layout size and semantics assertion failures. This matches script-level layout contract violations, not a bridge/interpreter limitation.
- fix description (if clear): Rework editable scene constraints to enforce bounded, non-negative sizes (explicit `SizedBox`/`ConstrainedBox`, avoid conflicting nested constraints) and ensure no framework errors are emitted.
- need for deeper analysis?: `no`
- batch number: `64`

### Index 322

- Index: 322
- testname: `rendering/render_ignore_pointer_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs a bottom RenderFlex overflow (4 px).
- detailed analysis what the problem is: Minor layout overflow in scripted UI state indicates insufficient vertical space budgeting.
- fix description (if clear): Adjust vertical constraints/flex distribution or wrap overflow-prone sections to remove warning output.
- need for deeper analysis?: `no`
- batch number: `64`

### Index 323

- Index: 323
- testname: `rendering/render_physical_shape_test.dart`
- category: `BRIDGE-CLIPPER-TYPE-COERCION`
- immediate fix possible: `no — requires bridge clipper coercion`
- description: Test passes but logs constructor failure for `PhysicalShape`: expected `CustomClipper<Path>`, got interpreted `_BevelClipper`.
- detailed analysis what the problem is: Bridge constructor dispatch does not coerce interpreted clipper implementations to native `CustomClipper<Path>` for `clipper` parameter, causing runtime argument rejection.
- fix description (if clear): Extend constructor arg coercion for `CustomClipper<Path>` to adapt interpreted clipper instances at native boundary.
- need for deeper analysis?: `yes — clipper coercion path`
- batch number: `64`

### Index 324

- Index: 324
- testname: `rendering/render_shader_mask_test.dart`
- category: `TEST-SCRIPT-INDEX-BOUNDS (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated runtime `Index out of range: 3` errors.
- detailed analysis what the problem is: Script runtime logic indexes into a collection with insufficient length under one or more scenario branches, producing repeated bounds errors. Current evidence points to script-side indexing/precondition handling rather than a known interpreter limitation.
- fix description (if clear): Guard index access by validating collection length, or construct deterministic test data with required element count before index-based reads.
- need for deeper analysis?: `yes — confirm all indexed collections in script branches`
- batch number: `64`

## Batch-64 Classification Summary

- Missing/stray status for Batch-64 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: two layout/overflow defects (`render_editable_test`, `render_ignore_pointer_test`) and one index-bounds defect (`render_shader_mask_test`).
- Bridge/generator/interpreter classification: one delegate coercion issue (`render_custom_single_child_layout_box_test`) and one clipper coercion issue (`render_physical_shape_test`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-65 (Issues 325-329)

### Index 325

- Index: 325
- testname: `rendering/render_shrink_wrapping_viewport_test.dart`
- category: `BRIDGE-SUPER-CONSTRUCTOR-RESOLUTION`
- immediate fix possible: `no — requires bridge/generator constructor mapping update`
- description: Test passes but logs constructor failure for `_SizeReporter`: bridged superclass `SingleChildRenderObjectWidget` has no constructor named `''`.
- detailed analysis what the problem is: The interpreted class constructor dispatch to bridged superclass is unresolved for unnamed/default constructor mapping, indicating a bridge/generator constructor-lookup gap for this inheritance path.
- fix description (if clear): Add explicit constructor mapping/alias for the default `SingleChildRenderObjectWidget` constructor in bridge definitions used by interpreted subclasses, and verify superclass constructor forwarding for `_SizeReporter`-like patterns.
- need for deeper analysis?: `yes — superclass constructor bridge path`
- batch number: `65`

### Index 326

- Index: 326
- testname: `rendering/render_sliver_pinned_persistent_header_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated bottom RenderFlex overflow (3 px).
- detailed analysis what the problem is: Scripted scene has small but repeated layout overflow in pinned sliver header states, producing framework warnings despite pass status.
- fix description (if clear): Adjust scene constraints/spacing and flex distribution for pinned header layout to eliminate overflow output.
- need for deeper analysis?: `no`
- batch number: `65`

### Index 327

- Index: 327
- testname: `rendering/sliver_hit_test_result_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs multiple overflow directions (bottom and right).
- detailed analysis what the problem is: The test layout exceeds available bounds in multiple axes under one or more branches; this is a script composition issue, not a bridge failure.
- fix description (if clear): Rework layout container constraints and responsive sizing in hit-test demo scenes to stay within viewport bounds in all branches.
- need for deeper analysis?: `no`
- batch number: `65`

### Index 328

- Index: 328
- testname: `rendering/sliver_layout_dimensions_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated bottom overflow (4 px).
- detailed analysis what the problem is: Scripted sliver layout dimension scene slightly exceeds vertical constraints in repeated states.
- fix description (if clear): Tighten vertical sizing/spacing and ensure sliver test harness viewport provides adequate constrained height for all test branches.
- need for deeper analysis?: `no`
- batch number: `65`

### Index 329

- Index: 329
- testname: `widgets/android_view_test.dart`
- category: `BRIDGE-STATIC-MEMBER-EXPOSURE`
- immediate fix possible: `no — requires bridge static-member support`
- description: Test passes but logs: undefined static member `new` on bridged class `EagerGestureRecognizer`.
- detailed analysis what the problem is: Bridge static-member/constructor-tearoff exposure is incomplete for `EagerGestureRecognizer.new`, so constructor tearoff lookup fails at runtime.
- fix description (if clear): Extend bridge static member exposure to support constructor tearoffs (`.new`) for this recognizer class (or adapt call sites to supported constructor invocation path until bridge support lands).
- need for deeper analysis?: `yes — static member/constructor tearoff bridging`
- batch number: `65`

## Batch-65 Classification Summary

- Missing/stray status for Batch-65 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: three overflow/layout defects (`render_sliver_pinned_persistent_header_test`, `sliver_hit_test_result_test`, `sliver_layout_dimensions_test`).
- Bridge/generator/interpreter classification: one superclass constructor resolution issue (`render_shrink_wrapping_viewport_test`) and one static member exposure issue (`android_view_test` with `EagerGestureRecognizer.new`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-66 (Issues 330-334)

### Index 330

- Index: 330
- testname: `widgets/animated_cross_fade_test.dart`
- category: `BRIDGE-MISSING-INSTANCE-METHOD`
- immediate fix possible: `no — requires bridge method/extension exposure`
- description: Test passes but logs missing `whereType` on bridged `List` during extension lookup.
- detailed analysis what the problem is: Runtime bridge for `List`/iterable extension path does not expose `whereType`, so calls that rely on this typed filtering method fail at runtime.
- fix description (if clear): Add bridge support for `whereType` on the relevant iterable/list path (or adapter route to equivalent filtering behavior with correct generic typing).
- need for deeper analysis?: `yes — iterable extension/method bridging`
- batch number: `66`

### Index 331

- Index: 331
- testname: `widgets/animated_fractionally_sized_box_test.dart`
- category: `TEST-SCRIPT-OVERFLOW (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs a bottom RenderFlex overflow (8 px).
- detailed analysis what the problem is: Script layout exceeds vertical constraints in at least one branch/state, producing framework overflow output despite success status.
- fix description (if clear): Adjust vertical constraints/flex behavior in the scripted scene to remove overflow warnings.
- need for deeper analysis?: `no`
- batch number: `66`

### Index 332

- Index: 332
- testname: `widgets/animated_switcher_test.dart`
- category: `BRIDGE-MISSING-INSTANCE-METHOD`
- immediate fix possible: `no — requires bridge method/extension exposure`
- description: Test passes but logs the same missing `whereType` method on bridged `List`.
- detailed analysis what the problem is: Same bridge method exposure gap as Index 330, now in a second widget scenario, indicating shared runtime mapping defect.
- fix description (if clear): Reuse the `List`/iterable `whereType` bridge exposure fix identified for Index 330.
- need for deeper analysis?: `yes — shared iterable method bridge path`
- batch number: `66`

### Index 333

- Index: 333
- testname: `widgets/autofill_group_test.dart`
- category: `BRIDGE-STATE-PROPERTY-EXPOSURE`
- immediate fix possible: `no — requires state property bridge support`
- description: Test passes but logs undefined `widget` property on `_AutofillGroupLaneState`.
- detailed analysis what the problem is: Interpreted `State` subclass access to inherited `widget` property is not being resolved/exposed correctly by bridge runtime, causing repeated runtime property lookup failures.
- fix description (if clear): Extend state-object property exposure to include inherited `State.widget` resolution for interpreted subclasses.
- need for deeper analysis?: `yes — state inheritance property resolution`
- batch number: `66`

### Index 334

- Index: 334
- testname: `widgets/backdrop_filter_test.dart`
- category: `BRIDGE-MISSING-INSTANCE-METHOD`
- immediate fix possible: `no — requires bridge method/extension exposure`
- description: Test passes but logs missing `whereType` on bridged `List` during extension lookup.
- detailed analysis what the problem is: Same `whereType` bridge gap as Index 330 and 332, demonstrating repeated failure across multiple widget scenarios.
- fix description (if clear): Apply shared bridge fix for iterable/list `whereType` method exposure with correct generic behavior.
- need for deeper analysis?: `yes — shared iterable method bridge path`
- batch number: `66`

## Batch-66 Classification Summary

- Missing/stray status for Batch-66 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: one overflow/layout defect (`animated_fractionally_sized_box_test`).
- Bridge/generator/interpreter classification: three missing-method bridge issues (`animated_cross_fade_test`, `animated_switcher_test`, `backdrop_filter_test` for `List.whereType`) and one state-property exposure issue (`autofill_group_test` for inherited `widget`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-67 (Issues 335-339)

### Index 335

- Index: 335
- testname: `widgets/color_filtered_test.dart`
- category: `TEST-SCRIPT-LAYOUT-CONSTRAINTS (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs unbounded flex/layout assertions, multiple not-laid-out render objects, and follow-on null-check failures.
- detailed analysis what the problem is: The scripted scene builds flex content under unbounded height constraints, triggering a cascade (`non-zero flex in unbounded height` -> `RenderBox was not laid out` -> downstream null-check failures). This aligns with script-level layout composition faults rather than a bridge/generator defect.
- fix description (if clear): Constrain vertical layout (bounded parent for flex widgets, avoid conflicting unbounded columns/slivers), then rerun to ensure downstream null-check errors disappear with valid layout state.
- need for deeper analysis?: `yes — verify all downstream null-checks are secondary to layout`
- batch number: `67`

### Index 336

- Index: 336
- testname: `widgets/composited_transform_follower_test.dart`
- category: `BRIDGE-STATE-PROPERTY-EXPOSURE`
- immediate fix possible: `no — requires bridge state-property support`
- description: Test passes but logs undefined inherited `widget` property on `_LinkPrimerState`.
- detailed analysis what the problem is: Interpreted `State` subclass property resolution for inherited `State.widget` is missing in this path, matching the state-property bridge gap pattern seen in Batch-66.
- fix description (if clear): Extend state-object property exposure to consistently resolve inherited `State.widget` on interpreted subclasses used by widget test scenes.
- need for deeper analysis?: `yes — shared state inheritance property resolution`
- batch number: `67`

### Index 337

- Index: 337
- testname: `widgets/default_asset_bundle_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs late-init access to `_oceanBundle` before assignment.
- detailed analysis what the problem is: Script state initialization/order is incorrect for `_oceanBundle` lifecycle, causing `LateInitializationError` surfaced as runtime warning.
- fix description (if clear): Initialize `_oceanBundle` before any read path (setup/initState/pre-pump) and guard access until assignment is guaranteed.
- need for deeper analysis?: `no`
- batch number: `67`

### Index 338

- Index: 338
- testname: `widgets/dual_transition_builder_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs repeated late-init access for `_controller`, `_dualController`, and `_detailController`.
- detailed analysis what the problem is: Multiple controller fields are read before initialization across scene branches, indicating script lifecycle sequencing defects.
- fix description (if clear): Ensure all controllers are initialized prior to usage in every branch (centralized setup/initState) and enforce branch-safe checks before access.
- need for deeper analysis?: `no`
- batch number: `67`

### Index 339

- Index: 339
- testname: `widgets/fade_in_image_test.dart`
- category: `TEST-SCRIPT-STATE-CONTEXT (needs correction)`
- immediate fix possible: `yes`
- description: Test passes but logs late-init access for `_imagesFuture` before assignment.
- detailed analysis what the problem is: Script reads `_imagesFuture` before it is initialized, producing `LateInitializationError` and noisy runtime output.
- fix description (if clear): Assign `_imagesFuture` during deterministic setup before first read and add guard/assertion to prevent uninitialized access.
- need for deeper analysis?: `no`
- batch number: `67`

## Batch-67 Classification Summary

- Missing/stray status for Batch-67 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: one major layout-constraints defect (`color_filtered_test`) and three state-context initialization defects (`default_asset_bundle_test`, `dual_transition_builder_test`, `fade_in_image_test`).
- Bridge/generator/interpreter classification: one state-property exposure issue (`composited_transform_follower_test` for inherited `State.widget`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.

---

# Batch-68 (Issues 340-344)

### Index 340

- Index: 340
- testname: `widgets/fixed_extent_metrics_test.dart`
- category: `BRIDGE-TYPE-CAST-FAILURE`
- immediate fix possible: `no — requires bridge/interpreter cast-path correction`
- description: Test fails (`result status: failure`) with runtime cast failure on `as` involving `SNamedType`, causing expectation mismatch.
- detailed analysis what the problem is: This is a plain test failure, and the error indicates bridge/interpreter type-cast mismatch rather than a script assertion typo. The failing cast (`Instance of 'SNamedType'`) suggests runtime type-shape incompatibility in the bridged/inferred type path used by this metrics scenario.
- fix description (if clear): Investigate and correct cast compatibility for the affected `SNamedType` bridge/interpreter mapping path, then re-run the failing assertion to confirm semantic correctness.
- need for deeper analysis?: `yes — cast/inference bridge path`
- batch number: `68`

### Index 341

- Index: 341
- testname: `widgets/glowing_overscroll_indicator_test.dart`
- category: `BRIDGE-OPERATOR-COERCION + BRIDGE-STATE-PROPERTY-EXPOSURE + BRIDGE-WIDGET-COERCION`
- immediate fix possible: `no — mixed bridge fixes required`
- description: Test passes but logs mixed bridge errors: `Color` operator `==` parameter mismatch, multiple inherited `widget` property misses, and `InterpretedInstance` to `Widget?` cast failures.
- detailed analysis what the problem is: This scenario exercises several bridge gaps concurrently: operator coercion for `Color == other`, inherited `State.widget` property resolution, and widget-typed cast/coercion boundaries. Failures are bridge/runtime adaptation issues rather than script-only defects.
- fix description (if clear): (1) add `Color` operator coercion for `other` parameter, (2) ensure inherited `State.widget` exposure on interpreted state subclasses, and (3) harden widget coercion for `Widget?` cast boundaries.
- need for deeper analysis?: `yes — multi-path bridge adaptation`
- batch number: `68`

### Index 342

- Index: 342
- testname: `widgets/html_element_view_test.dart`
- category: `BRIDGE-STATE-PROPERTY-EXPOSURE`
- immediate fix possible: `no — requires bridge state-property support`
- description: Test passes but logs repeated undefined inherited `widget` property across multiple scene states.
- detailed analysis what the problem is: Repeated `Undefined property 'widget'` on interpreted state classes indicates unresolved inherited `State.widget` exposure in this widget flow.
- fix description (if clear): Reuse/extend the inherited `State.widget` bridge-property resolution fix so all scene state subclasses resolve correctly.
- need for deeper analysis?: `yes — shared state inheritance property resolution`
- batch number: `68`

### Index 343

- Index: 343
- testname: `widgets/image_filtered_test.dart`
- category: `BRIDGE-STATE-PROPERTY-EXPOSURE`
- immediate fix possible: `no — requires bridge state-property support`
- description: Test passes but logs repeated undefined inherited `widget` property across all deep-demo scene states.
- detailed analysis what the problem is: Same inherited `State.widget` exposure gap as Index 342, now reproduced across multiple scene variants in image filtering flows.
- fix description (if clear): Apply shared inherited `State.widget` exposure fix for interpreted state subclasses used in multi-scene deep demos.
- need for deeper analysis?: `yes — shared state inheritance property resolution`
- batch number: `68`

### Index 344

- Index: 344
- testname: `widgets/indexed_stack_test.dart`
- category: `BRIDGE-STATE-PROPERTY-EXPOSURE`
- immediate fix possible: `no — requires bridge state-property support`
- description: Test passes but logs repeated undefined inherited `widget` property across indexed-stack scene states.
- detailed analysis what the problem is: Same bridge runtime property-resolution defect (`State.widget`) affecting interpreted state classes in this scenario.
- fix description (if clear): Reuse the generalized inherited `State.widget` bridge-property fix from Index 342/343.
- need for deeper analysis?: `yes — shared state inheritance property resolution`
- batch number: `68`

## Batch-68 Classification Summary

- Missing/stray status for Batch-68 scripts: none missing, none stray. All referenced scripts are present and listed in the status report.
- Test-script issue classification: none primary; issue 340 is a plain failing test but currently indicates bridge/interpreter cast mismatch rather than script logic defect.
- Bridge/generator/interpreter classification: one cast failure (`fixed_extent_metrics_test`), one mixed operator/state/widget coercion cluster (`glowing_overscroll_indicator_test`), and three state-property exposure issues (`html_element_view_test`, `image_filtered_test`, `indexed_stack_test`).
- Known non-exhaustive switch signature in Batch-25: not detected in this batch.