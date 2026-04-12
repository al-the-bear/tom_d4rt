# 20260412-0949-issue-analysis Error Analysis

Scope: Batch-0 to Batch-4 (issues 0..24 from `20260412-0949-issue-analysis_test_summary.md`).

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