# 20260412-0949-issue-analysis Error Analysis

Scope: Batch-0 to Batch-12 (issues 0..64 from `20260412-0949-issue-analysis_test_summary.md`).

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