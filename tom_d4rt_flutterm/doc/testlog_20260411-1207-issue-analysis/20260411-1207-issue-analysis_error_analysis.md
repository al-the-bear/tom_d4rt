# Error Analysis: 20260411-1207-issue-analysis

Generated: 2026-04-11

## Run Metadata

| Field | Value |
|-------|-------|
| Run ID | `20260411-1207-issue-analysis` |
| Revision | `4ce8091c` |
| Suites | 8 (essential, important, secondary, hr1-hr5) |
| Batches | 2 (Batch 0: suites 0-4, Batch 1: suites 5-7) |
| Total Issues | 551 |
| Categories | 29 |
| Missing Scripts | 0 |
| Stray Scripts | 15 |

## Executive Summary

### Issue Distribution by Group

| Group | Count | % | Top Categories |
|-------|------:|--:|----------------|
| Transport Issues | 251 | 45.6% | TRANSPORT-CASCADE (249), TRANSPORT-ERROR (2) |
| Script Issues | 116 | 21.1% | SCRIPT-LATEINIT (106), SCRIPT-TIMEOUT (9), SCRIPT-GLOBALKEY (1) |
| Bridge/Generator Issues | 84 | 15.2% | BRIDGE-INTERPRETED-INSTANCE (28), BRIDGE-MISSING-CONSTRUCTOR (15), BRIDGE-NATIVE-ERROR (11) |
| Interpreter Issues | 33 | 6.0% | INTERPRETER-STATE-ACCESS (17), INTERPRETER-NULL-INVOKE (4), INTERPRETER-SWITCH (4) |
| Framework Noise | 67 | 12.2% | FW-LAYOUT-CONSTRAINT (30), FW-LAYOUT-OVERFLOW (27), FW-ASSERTION (4) |

### Key Findings

1. **Transport cascades dominate (45%)**:  249 tests failed due to cascade effects from 2 transport errors. Fixing the 2 transport errors would eliminate ~45% of all issues.
2. **Script late-init issues (19%)**:  106 scripts use `late` variables that the D4rt interpreter cannot resolve. Refactoring scripts to avoid `late` fields or use nullable + null-check patterns would fix these.
3. **Bridge gaps (15%)**:  84 issues from missing constructors, type mismatches, or InterpretedInstance returns. These need bridge generator improvements or UserBridge overrides.
4. **Framework noise (12%)**:  67 issues are layout constraint errors, overflow, or framework assertions. Most are non-critical and can be fixed by adjusting script layout constraints.
5. **Interpreter issues (6%)**:  33 issues from State property access, generic inference, switch expressions, or null handling. Some have known workarounds.

### Category Reference

| Category | Count | Immediate Fix | Description |
|----------|------:|---------------|-------------|
| `TRANSPORT-CASCADE` | 249 | No - fix upstream transport error first | Cascade: earlier transport error caused downstream failures |
| `SCRIPT-LATEINIT` | 106 | Yes - refactor script to avoid late fields or use nullable + null-check | Script uses late variables; interpreter cannot resolve late initialization |
| `FW-LAYOUT-CONSTRAINT` | 30 | Maybe - fix layout in script | Layout constraint error (framework noise) |
| `BRIDGE-INTERPRETED-INSTANCE` | 28 | Yes - fix bridge type resolution or add UserBridge | Bridge returns InterpretedInstance instead of typed widget |
| `FW-LAYOUT-OVERFLOW` | 27 | Maybe - adjust script layout constraints | Layout overflow or unbounded flex (framework noise) |
| `INTERPRETER-STATE-ACCESS` | 17 | Maybe - add explicit getter in script or UserBridge override | Interpreter cannot resolve State/Delegate/Controller property access |
| `BRIDGE-MISSING-CONSTRUCTOR` | 15 | Yes - add constructor to bridge generator | Bridge missing constructor for class |
| `BRIDGE-NATIVE-ERROR` | 11 | Maybe - add UserBridge override for method | Native error during bridged method call |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 9 | Yes - add UserBridge generic constructor override | Bridge generic constructor factory error |
| `SCRIPT-TIMEOUT` | 9 | Yes - simplify script or add timeout handling | Build timed out (script too complex or has infinite loop) |
| `BRIDGE-MISSING-TYPE` | 6 | Yes - add to bridge generator or UserBridge | Bridge missing type/class definition |
| `BRIDGE-MISSING-METHOD` | 4 | Yes - add method to bridge or UserBridge override | Bridge missing method implementation |
| `FW-ASSERTION` | 4 | Maybe - investigate assertion context | Flutter framework assertion failure |
| `INTERPRETER-NULL-INVOKE` | 4 | Maybe - check null safety in script | Method invocation on null |
| `BRIDGE-NOT-CALLABLE` | 4 | Yes - add constructor to bridge | Bridge missing constructor (type is not callable) |
| `INTERPRETER-SWITCH` | 4 | Yes - add default/wildcard case in script | Non-exhaustive switch expression |
| `FW-OTHER` | 4 | Needs investigation | Uncategorized framework error |
| `BRIDGE-TYPE-MISMATCH-FW` | 3 | Yes - add D4.coerceList/coerceMap or UserBridge | Type mismatch in framework error (bridge coercion gap) |
| `INTERPRETER-GENERIC-INFERENCE` | 2 | Yes - add explicit type annotations in script | Known issue #1: generic type inference (List<Object?> vs List<Widget>) |
| `BRIDGE-TYPE-MISMATCH` | 2 | Yes - add D4.coerceList/coerceMap or UserBridge | Type mismatch (bridge type coercion gap) |
| `TRANSPORT-ERROR` | 2 | No - infrastructure issue | Transport error (HTTP failure) |
| `INTERPRETER-UNSUPPORTED` | 2 | Maybe - platform-specific or missing bridge | Unsupported operation in interpreter |
| `FW-PROGRESS-BAR` | 2 | Yes - fix script progress bar value | Progress bar invalid value (framework noise) |
| `BRIDGE-MISSING-PROPERTY` | 2 | Yes - add to bridge generator or UserBridge | Bridge missing property/method on native class |
| `SCRIPT-GLOBALKEY` | 1 | Yes - fix script to use unique keys | Duplicate GlobalKey in script widget tree |
| `INTERPRETER-BAD-STATE` | 1 | Needs investigation | Bad state error |
| `INTERPRETER-UNDEFINED` | 1 | Maybe - check bridge coverage or script patterns | Interpreter cannot resolve variable/property |
| `INTERPRETER-INDEX-ERROR` | 1 | Yes - fix script bounds checking | Index out of range error |
| `INTERPRETER-NULL-ACCESS` | 1 | Maybe - check script null safety patterns | Null property access in interpreter |

### Known D4rt Limitations Affecting Tests

| ID | Limitation | Impact on Tests | Workaround |
|------|-----------|-----------------|------------|
| #1 | Generic type inference (`List<Object?>` vs `List<Widget>`) | 2 FW errors | Add explicit type annotations |
| #2 | `int.roundToDouble()` not bridged | Minor | Use `.toDouble()` instead |
| Bug-79 | Non-exhaustive switch on sealed subclass | 4 failures (FIXED in interpreter) | Add default/wildcard case in script |
| Lim-3 | Isolates not supported | Scripts using isolates will fail | Remove isolate usage from scripts |
| Bug-14 | Records not supported | Minor | Avoid Dart 3 records in scripts |

### Stray Test Scripts (15)

These scripts exist on disk but are not referenced by any test suite:

| Package | Script | Action Needed |
|---------|--------|---------------|
| dart_ui | `display_feature_test.dart` | Add to appropriate suite or remove |
| dart_ui | `point_mode_test.dart` | Add to appropriate suite or remove |
| material | `button_styles_misc_test.dart` | Add to appropriate suite or remove |
| material | `button_types_test.dart` | Add to appropriate suite or remove |
| material | `list_tile_style_test.dart` | Add to appropriate suite or remove |
| material | `showbottomsheet_test.dart` | Add to appropriate suite or remove |
| material | `showdatepicker_test.dart` | Add to appropriate suite or remove |
| material | `showdialog_test.dart` | Add to appropriate suite or remove |
| material | `showmenu_test.dart` | Add to appropriate suite or remove |
| material | `showtimepicker_test.dart` | Add to appropriate suite or remove |
| material | `stepper_state_test.dart` | Add to appropriate suite or remove |
| material | `toggle_segmented_test.dart` | Add to appropriate suite or remove |
| rendering | `child_layout_helper_test.dart` | Add to appropriate suite or remove |
| rendering | `diagnostics_debug_creator_test.dart` | Add to appropriate suite or remove |
| widgets | `platform_menu_widgets_test.dart` | Add to appropriate suite or remove |

---

## Batch 0 — Detailed Analysis

| Metric | Value |
|--------|-------|
| Total Issues | 265 |
| Failures | 179 |
| FW-Error-Only | 86 |
| Top Category | TRANSPORT-CASCADE (144) |

### Batch 0 Category Distribution

| Category | Count |
|----------|------:|
| `TRANSPORT-CASCADE` | 144 |
| `FW-LAYOUT-CONSTRAINT` | 27 |
| `FW-LAYOUT-OVERFLOW` | 22 |
| `BRIDGE-INTERPRETED-INSTANCE` | 9 |
| `SCRIPT-TIMEOUT` | 9 |
| `BRIDGE-NATIVE-ERROR` | 7 |
| `INTERPRETER-STATE-ACCESS` | 6 |
| `BRIDGE-MISSING-METHOD` | 4 |
| `FW-ASSERTION` | 4 |
| `INTERPRETER-SWITCH` | 4 |
| `SCRIPT-LATEINIT` | 3 |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 3 |
| `INTERPRETER-NULL-INVOKE` | 3 |
| `BRIDGE-NOT-CALLABLE` | 3 |
| `BRIDGE-MISSING-TYPE` | 2 |
| `BRIDGE-TYPE-MISMATCH` | 2 |
| `INTERPRETER-UNSUPPORTED` | 2 |
| `FW-PROGRESS-BAR` | 2 |
| `SCRIPT-GLOBALKEY` | 1 |
| `INTERPRETER-GENERIC-INFERENCE` | 1 |
| `INTERPRETER-BAD-STATE` | 1 |
| `INTERPRETER-UNDEFINED` | 1 |
| `INTERPRETER-INDEX-ERROR` | 1 |
| `BRIDGE-MISSING-CONSTRUCTOR` | 1 |
| `TRANSPORT-ERROR` | 1 |
| `INTERPRETER-NULL-ACCESS` | 1 |
| `FW-OTHER` | 1 |

### Suite: essential_classes_test

**4 issues** — Top: `FW-LAYOUT-CONSTRAINT` (3), `FW-LAYOUT-OVERFLOW` (1)

#### [1] cupertino/controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 1 |
| **Test Name** | `cupertino/controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [2] cupertino/form_test.dart

| Field | Value |
|-------|-------|
| **Index** | 2 |
| **Test Name** | `cupertino/form_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [3] cupertino/textfield_test.dart

| Field | Value |
|-------|-------|
| **Index** | 3 |
| **Test Name** | `cupertino/textfield_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [4] rendering/viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 4 |
| **Test Name** | `rendering/viewport_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 20 pixels on the right.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

### Suite: hardly_relevant_classes_1_test

**16 issues** — Top: `FW-LAYOUT-CONSTRAINT` (5), `BRIDGE-NATIVE-ERROR` (4), `BRIDGE-NOT-CALLABLE` (3)

#### [212] animation/reverse_tween_test.dart

| Field | Value |
|-------|-------|
| **Index** | 212 |
| **Test Name** | `animation/reverse_tween_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 0 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [213] cupertino/cupertino_desktop_text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 213 |
| **Test Name** | `cupertino/cupertino_desktop_text_selection_controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [214] cupertino/cupertino_focus_halo_test.dart

| Field | Value |
|-------|-------|
| **Index** | 214 |
| **Test Name** | `cupertino/cupertino_focus_halo_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [215] cupertino/cupertino_text_selection_handle_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 215 |
| **Test Name** | `cupertino/cupertino_text_selection_handle_controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [216] cupertino/inherited_cupertino_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 216 |
| **Test Name** | `cupertino/inherited_cupertino_theme_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [217] cupertino/overlay_visibility_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 217 |
| **Test Name** | `cupertino/overlay_visibility_mode_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [218] dart_ui/blur_style_test.dart

| Field | Value |
|-------|-------|
| **Index** | 218 |
| **Test Name** | `dart_ui/blur_style_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 2.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [219] dart_ui/color_space_test.dart

| Field | Value |
|-------|-------|
| **Index** | 219 |
| **Test Name** | `dart_ui/color_space_test.dart` |
| **Category** | `INTERPRETER-UNSUPPORTED` |
| **Immediate Fix Possible** | Maybe - platform-specific or missing bridge |
| **Description** | Unsupported operation in interpreter |
| **Batch** | 0 |

**Detailed Analysis:** Unsupported operation in the interpreter. This may be a platform-specific operation or a language feature not yet implemented in D4rt. Detail: Expected: true

**Fix Description:** Remove or replace the unsupported operation with an equivalent supported alternative.

**Needs Deeper Analysis:** Yes - determine if platform-specific

#### [220] dart_ui/placeholder_alignment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 220 |
| **Test Name** | `dart_ui/placeholder_alignment_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override for method |
| **Description** | Native error during bridged method call |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Expected: true

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [221] dart_ui/system_color_palette_test.dart

| Field | Value |
|-------|-------|
| **Index** | 221 |
| **Test Name** | `dart_ui/system_color_palette_test.dart` |
| **Category** | `INTERPRETER-UNSUPPORTED` |
| **Immediate Fix Possible** | Maybe - platform-specific or missing bridge |
| **Description** | Unsupported operation in interpreter |
| **Batch** | 0 |

**Detailed Analysis:** Unsupported operation in the interpreter. This may be a platform-specific operation or a language feature not yet implemented in D4rt. Detail: Expected: true

**Fix Description:** Remove or replace the unsupported operation with an equivalent supported alternative.

**Needs Deeper Analysis:** Yes - determine if platform-specific

#### [222] dart_ui/vertex_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 222 |
| **Test Name** | `dart_ui/vertex_mode_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override |
| **Description** | Native error during bridged constructor/method |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Runtime Error: Native error during default bridged constructor for 'Vertices': Argument Error: Invalid parameter "positions": expected List<Offset>, got null

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [223] foundation/object_created_test.dart

| Field | Value |
|-------|-------|
| **Index** | 223 |
| **Test Name** | `foundation/object_created_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes - add constructor to bridge |
| **Description** | Bridge missing constructor (type is not callable) |
| **Batch** | 0 |

**Detailed Analysis:** The bridge has the type registered but it is not callable (no constructor factory). When the script tries to instantiate it with `TypeName(...)`, the interpreter sees a non-callable object. A constructor factory needs to be added. Detail: Expected: true

**Fix Description:** Register a constructor factory for this type in the bridge generator.

**Needs Deeper Analysis:** No - add constructor factory

#### [224] foundation/object_disposed_test.dart

| Field | Value |
|-------|-------|
| **Index** | 224 |
| **Test Name** | `foundation/object_disposed_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes - add constructor to bridge |
| **Description** | Bridge missing constructor (type is not callable) |
| **Batch** | 0 |

**Detailed Analysis:** The bridge has the type registered but it is not callable (no constructor factory). When the script tries to instantiate it with `TypeName(...)`, the interpreter sees a non-callable object. A constructor factory needs to be added. Detail: Expected: true

**Fix Description:** Register a constructor factory for this type in the bridge generator.

**Needs Deeper Analysis:** No - add constructor factory

#### [225] foundation/object_event_test.dart

| Field | Value |
|-------|-------|
| **Index** | 225 |
| **Test Name** | `foundation/object_event_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes - add constructor to bridge |
| **Description** | Bridge missing constructor (type is not callable) |
| **Batch** | 0 |

**Detailed Analysis:** The bridge has the type registered but it is not callable (no constructor factory). When the script tries to instantiate it with `TypeName(...)`, the interpreter sees a non-callable object. A constructor factory needs to be added. Detail: Expected: true

**Fix Description:** Register a constructor factory for this type in the bridge generator.

**Needs Deeper Analysis:** No - add constructor factory

#### [226] foundation/target_platform_test.dart

| Field | Value |
|-------|-------|
| **Index** | 226 |
| **Test Name** | `foundation/target_platform_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override for method |
| **Description** | Native error during bridged method call |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Expected: true

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [227] gestures/class_test.dart

| Field | Value |
|-------|-------|
| **Index** | 227 |
| **Test Name** | `gestures/class_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override for method |
| **Description** | Native error during bridged method call |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Expected: true

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

### Suite: hardly_relevant_classes_2_test

**38 issues** — Top: `SCRIPT-TIMEOUT` (9), `FW-LAYOUT-CONSTRAINT` (9), `FW-LAYOUT-OVERFLOW` (4)

#### [228] material/autocomplete_test.dart

| Field | Value |
|-------|-------|
| **Index** | 228 |
| **Test Name** | `material/autocomplete_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [229] material/back_button_icon_test.dart

| Field | Value |
|-------|-------|
| **Index** | 229 |
| **Test Name** | `material/back_button_icon_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [230] material/back_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 230 |
| **Test Name** | `material/back_button_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [231] material/bottom_navigation_bar_landscape_layout_test.dart

| Field | Value |
|-------|-------|
| **Index** | 231 |
| **Test Name** | `material/bottom_navigation_bar_landscape_layout_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [232] material/bottom_navigation_bar_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 232 |
| **Test Name** | `material/bottom_navigation_bar_theme_data_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [233] material/bottom_navigation_bar_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 233 |
| **Test Name** | `material/bottom_navigation_bar_theme_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [234] material/bottom_navigation_bar_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 234 |
| **Test Name** | `material/bottom_navigation_bar_type_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [235] material/button_bar_layout_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 235 |
| **Test Name** | `material/button_bar_layout_behavior_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [236] material/button_bar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 236 |
| **Test Name** | `material/button_bar_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Yes - simplify script or add timeout handling |
| **Description** | Build timed out (script too complex or has infinite loop) |
| **Batch** | 0 |

**Detailed Analysis:** The D4rt build (AST compilation + interpretation) timed out after 10 seconds. This indicates the script is either too complex for the interpreter, contains patterns that cause exponential processing time, or has an infinite loop in its initialization. Detail: Expected: true

**Fix Description:** Simplify the script: reduce widget tree depth, remove complex initializations, or split into smaller demo components. Consider if the script has an unintended infinite loop.

**Needs Deeper Analysis:** Maybe - check for infinite loops vs complexity

#### [237] material/button_bar_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 237 |
| **Test Name** | `material/button_bar_theme_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme)

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [238] material/button_text_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 238 |
| **Test Name** | `material/button_text_theme_test.dart` |
| **Category** | `INTERPRETER-NULL-ACCESS` |
| **Immediate Fix Possible** | Maybe - check script null safety patterns |
| **Description** | Null property access in interpreter |
| **Batch** | 0 |

**Detailed Analysis:** Null property access: the interpreter tried to read a property on a null target. This may indicate a script null-safety issue or an interpreter evaluation order problem. Detail: Expected: true

**Fix Description:** Review script null-safety patterns. Add null checks before property access or use null-aware operators.

**Needs Deeper Analysis:** Yes - determine null source

#### [239] material/collapse_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 239 |
| **Test Name** | `material/collapse_mode_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override for method |
| **Description** | Native error during bridged method call |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Expected: true

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [240] material/drawer_controller_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 240 |
| **Test Name** | `material/drawer_controller_state_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 46 pixels on the right.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [241] material/dropdown_menu_close_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 241 |
| **Test Name** | `material/dropdown_menu_close_behavior_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes - add default/wildcard case in script |
| **Description** | Non-exhaustive switch expression |
| **Batch** | 0 |

**Detailed Analysis:** Non-exhaustive switch expression (Bug-79, now FIXED in interpreter). If this still occurs, the script's switch expression likely has enum values or sealed subtypes that the interpreter's exhaustiveness checker flags. Add a `default` or `_` wildcard case. Detail: Expected: true

**Fix Description:** Add a `default` or `_ =>` wildcard case to the switch expression in the script.

**Needs Deeper Analysis:** No - add default case

#### [242] material/end_drawer_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 242 |
| **Test Name** | `material/end_drawer_button_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [243] material/gapped_range_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 243 |
| **Test Name** | `material/gapped_range_slider_track_shape_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Batch** | 0 |

**Detailed Analysis:** Uncategorized framework error. Needs further investigation to determine root cause. Detail: Null check operator used on a null value

**Fix Description:** Requires deeper investigation to determine the root cause and appropriate fix.

**Needs Deeper Analysis:** Yes - uncategorized

#### [244] material/gapped_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 244 |
| **Test Name** | `material/gapped_slider_track_shape_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe - investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Batch** | 0 |

**Detailed Analysis:** Flutter framework assertion failure. The Flutter framework detected an internal inconsistency during widget tree processing. May indicate a script issue or a framework-level timing problem. Detail: 'package:flutter/src/material/slider_parts.dart': Failed assertion: line 1080 pos 12: 'sliderTheme.trackGap != null': is not true.

**Fix Description:** Investigate the assertion context and determine if the script triggers an invalid state in the Flutter framework.

**Needs Deeper Analysis:** Yes - investigate assertion context

#### [245] material/hour_format_test.dart

| Field | Value |
|-------|-------|
| **Index** | 245 |
| **Test Name** | `material/hour_format_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe - check null safety in script |
| **Description** | Method invocation on null |
| **Batch** | 0 |

**Detailed Analysis:** Method invocation on null: the interpreter tried to call a method on a null receiver. This typically indicates the script expected a non-null value from a bridge call that returned null. Check null safety patterns in the script. Detail: Runtime Error: Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation.

**Fix Description:** Add null checks in the script before method invocations, or investigate why the bridge returns null.

**Needs Deeper Analysis:** Yes - determine why bridge returns null

#### [246] material/list_tile_title_alignment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 246 |
| **Test Name** | `material/list_tile_title_alignment_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 1.00 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [247] material/material_banner_closed_reason_test.dart

| Field | Value |
|-------|-------|
| **Index** | 247 |
| **Test Name** | `material/material_banner_closed_reason_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes - add default/wildcard case in script |
| **Description** | Non-exhaustive switch expression |
| **Batch** | 0 |

**Detailed Analysis:** Non-exhaustive switch expression (Bug-79, now FIXED in interpreter). If this still occurs, the script's switch expression likely has enum values or sealed subtypes that the interpreter's exhaustiveness checker flags. Add a `default` or `_` wildcard case. Detail: Expected: true

**Fix Description:** Add a `default` or `_ =>` wildcard case to the switch expression in the script.

**Needs Deeper Analysis:** No - add default case

#### [248] material/menu_accelerator_callback_binding_test.dart

| Field | Value |
|-------|-------|
| **Index** | 248 |
| **Test Name** | `material/menu_accelerator_callback_binding_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [249] material/navigation_destination_label_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 249 |
| **Test Name** | `material/navigation_destination_label_behavior_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes - add default/wildcard case in script |
| **Description** | Non-exhaustive switch expression |
| **Batch** | 0 |

**Detailed Analysis:** Non-exhaustive switch expression (Bug-79, now FIXED in interpreter). If this still occurs, the script's switch expression likely has enum values or sealed subtypes that the interpreter's exhaustiveness checker flags. Add a `default` or `_` wildcard case. Detail: Expected: true

**Fix Description:** Add a `default` or `_ =>` wildcard case to the switch expression in the script.

**Needs Deeper Analysis:** No - add default case

#### [250] material/navigation_drawer_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 250 |
| **Test Name** | `material/navigation_drawer_theme_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 29 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [251] material/navigation_rail_label_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 251 |
| **Test Name** | `material/navigation_rail_label_type_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes - add default/wildcard case in script |
| **Description** | Non-exhaustive switch expression |
| **Batch** | 0 |

**Detailed Analysis:** Non-exhaustive switch expression (Bug-79, now FIXED in interpreter). If this still occurs, the script's switch expression likely has enum values or sealed subtypes that the interpreter's exhaustiveness checker flags. Add a `default` or `_` wildcard case. Detail: Expected: true

**Fix Description:** Add a `default` or `_ =>` wildcard case to the switch expression in the script.

**Needs Deeper Analysis:** No - add default case

#### [252] material/paginated_data_table_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 252 |
| **Test Name** | `material/paginated_data_table_state_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints forces an infinite width.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [253] material/popup_menu_position_test.dart

| Field | Value |
|-------|-------|
| **Index** | 253 |
| **Test Name** | `material/popup_menu_position_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 0 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [254] material/progress_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 254 |
| **Test Name** | `material/progress_indicator_test.dart` |
| **Category** | `FW-PROGRESS-BAR` |
| **Immediate Fix Possible** | Yes - fix script progress bar value |
| **Description** | Progress bar invalid value (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Invalid progress bar value error. The script passed non-numeric or out-of-range values to a progress indicator widget. Fix the script's progress value. Detail: Progress bar value, minValue, and maxValue must be valid numbers. value: "67%", minValue: "0", maxValue: "100"

**Fix Description:** Fix the progress bar value in the script to be a valid number between minValue and maxValue.

**Needs Deeper Analysis:** No - fix value in script

#### [255] material/refresh_progress_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 255 |
| **Test Name** | `material/refresh_progress_indicator_test.dart` |
| **Category** | `FW-PROGRESS-BAR` |
| **Immediate Fix Possible** | Yes - fix script progress bar value |
| **Description** | Progress bar invalid value (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Invalid progress bar value error. The script passed non-numeric or out-of-range values to a progress indicator widget. Fix the script's progress value. Detail: Progress bar value, minValue, and maxValue must be valid numbers. value: "50%", minValue: "0", maxValue: "100"

**Fix Description:** Fix the progress bar value in the script to be a valid number between minValue and maxValue.

**Needs Deeper Analysis:** No - fix value in script

#### [256] material/theme_extension_test.dart

| Field | Value |
|-------|-------|
| **Index** | 256 |
| **Test Name** | `material/theme_extension_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override |
| **Description** | Native error during bridged constructor/method |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Runtime Error: Native error during bridged method call 'copyWith' on ThemeData: Argument Error: Invalid parameter "extensions": cannot convert List to List<ThemeExtension<dynamic>> - type 'Interpreted…

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [257] material/theme_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 257 |
| **Test Name** | `material/theme_mode_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [258] material/thumb_test.dart

| Field | Value |
|-------|-------|
| **Index** | 258 |
| **Test Name** | `material/thumb_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [259] material/time_of_day_format_test.dart

| Field | Value |
|-------|-------|
| **Index** | 259 |
| **Test Name** | `material/time_of_day_format_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [260] material/time_picker_entry_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 260 |
| **Test Name** | `material/time_picker_entry_mode_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [261] material/toggle_buttons_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 261 |
| **Test Name** | `material/toggle_buttons_theme_data_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [262] material/toggle_buttons_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 262 |
| **Test Name** | `material/toggle_buttons_theme_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [263] material/tooltip_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 263 |
| **Test Name** | `material/tooltip_state_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe - investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Batch** | 0 |

**Detailed Analysis:** Flutter framework assertion failure. The Flutter framework detected an internal inconsistency during widget tree processing. May indicate a script issue or a framework-level timing problem. Detail: Runtime Error: Native error during default bridged constructor for 'Tooltip': 'package:flutter/src/material/tooltip.dart': Failed assertion: line 140 pos 10: '(message == null) != (richMessage == null…

**Fix Description:** Investigate the assertion context and determine if the script triggers an invalid state in the Flutter framework.

**Needs Deeper Analysis:** Yes - investigate assertion context

#### [264] painting/axis_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 264 |
| **Test Name** | `painting/axis_direction_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe - check null safety in script |
| **Description** | Method invocation on null |
| **Batch** | 0 |

**Detailed Analysis:** Method invocation on null: the interpreter tried to call a method on a null receiver. This typically indicates the script expected a non-null value from a bridge call that returned null. Check null safety patterns in the script. Detail: Expected: true

**Fix Description:** Add null checks in the script before method invocations, or investigate why the bridge returns null.

**Needs Deeper Analysis:** Yes - determine why bridge returns null

#### [265] painting/axis_test.dart

| Field | Value |
|-------|-------|
| **Index** | 265 |
| **Test Name** | `painting/axis_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 56 pixels on the right.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

### Suite: important_classes_test

**10 issues** — Top: `BRIDGE-MISSING-METHOD` (1), `SCRIPT-GLOBALKEY` (1), `FW-ASSERTION` (1)

#### [5] widgets/slidetransition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 5 |
| **Test Name** | `widgets/slidetransition_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes - add method to bridge or UserBridge override |
| **Description** | Bridge missing method implementation |
| **Batch** | 0 |

**Detailed Analysis:** A method or instance method on a bridged class is not implemented in the bridge. The interpreter finds no matching method and raises NoSuchMethodError. The method needs to be added to the bridge or overridden via UserBridge. Detail: NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments.

**Fix Description:** Add the method to the bridge generator output or create a UserBridge `overrideMethodXxx` override.

**Needs Deeper Analysis:** No - add to bridge or UserBridge

#### [6] widgets/sliverlist_test.dart

| Field | Value |
|-------|-------|
| **Index** | 6 |
| **Test Name** | `widgets/sliverlist_test.dart` |
| **Category** | `SCRIPT-GLOBALKEY` |
| **Immediate Fix Possible** | Yes - fix script to use unique keys |
| **Description** | Duplicate GlobalKey in script widget tree |
| **Batch** | 0 |

**Detailed Analysis:** The test script creates duplicate GlobalKey instances in the widget tree, which Flutter does not allow. This is a script-side error. Detail: 'package:flutter/src/widgets/framework.dart': Failed assertion: line 2134 pos 12: 'element._lifecycleState == _ElementLifecycle.active': is not true.

**Fix Description:** Fix the script to use unique GlobalKey instances for each widget, or use ValueKey/ObjectKey instead.

**Needs Deeper Analysis:** No - straightforward fix

#### [7] widgets/table_test.dart

| Field | Value |
|-------|-------|
| **Index** | 7 |
| **Test Name** | `widgets/table_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe - investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Batch** | 0 |

**Detailed Analysis:** Flutter framework assertion failure. The Flutter framework detected an internal inconsistency during widget tree processing. May indicate a script issue or a framework-level timing problem. Detail: 'package:flutter/src/widgets/framework.dart': Failed assertion: line 2168 pos 12: '_elements.contains(element)': is not true.

**Fix Description:** Investigate the assertion context and determine if the script triggers an invalid state in the Flutter framework.

**Needs Deeper Analysis:** Yes - investigate assertion context

#### [8] widgets/nestedscrollview_test.dart

| Field | Value |
|-------|-------|
| **Index** | 8 |
| **Test Name** | `widgets/nestedscrollview_test.dart` |
| **Category** | `INTERPRETER-GENERIC-INFERENCE` |
| **Immediate Fix Possible** | Yes - add explicit type annotations in script |
| **Description** | Known issue #1: generic type inference (List<Object?> vs List<Widget>) |
| **Batch** | 0 |

**Detailed Analysis:** Known D4rt issue #1: generic type inference produces `List<Object?>` instead of the expected specific type (e.g., `List<Widget>`). The interpreter's type inference system doesn't fully propagate generic type parameters. Workaround: add explicit type annotations in the script (e.g., `<Widget>[...]` instead of `[...]`). Detail: type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast

**Fix Description:** Add explicit type annotations in the script where generic lists/maps are constructed (e.g., `<Widget>[child1, child2]` instead of `[child1, child2]`).

**Needs Deeper Analysis:** No - known issue #1, add type annotations

#### [9] material/refreshindicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 9 |
| **Test Name** | `material/refreshindicator_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: RenderFlex children have non-zero flex but incoming height constraints are unbounded.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [10] material/animatedicon_test.dart

| Field | Value |
|-------|-------|
| **Index** | 10 |
| **Test Name** | `material/animatedicon_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderBox was not laid out: RenderTransform#b351d

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [11] widgets/actions_test.dart

| Field | Value |
|-------|-------|
| **Index** | 11 |
| **Test Name** | `widgets/actions_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 0 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _dispatcher (Original error: LateInitializationError: Late variable '_dispatcher' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [12] animation/tweensequence_test.dart

| Field | Value |
|-------|-------|
| **Index** | 12 |
| **Test Name** | `animation/tweensequence_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 0 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [13] services/codecs_test.dart

| Field | Value |
|-------|-------|
| **Index** | 13 |
| **Test Name** | `services/codecs_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing type/class definition |
| **Batch** | 0 |

**Detailed Analysis:** A type or class referenced in the script is not registered in the bridge. The interpreter cannot resolve it as a variable/constructor. This type needs to be added to the bridge generator configuration or a UserBridge. Detail: Expected: true

**Fix Description:** Add the missing type to the bridge generator configuration (flutterm_config.yaml) or create a UserBridge class for it.

**Needs Deeper Analysis:** No - add to bridge config

#### [14] services/channels_test.dart

| Field | Value |
|-------|-------|
| **Index** | 14 |
| **Test Name** | `services/channels_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH` |
| **Immediate Fix Possible** | Yes - add D4.coerceList/coerceMap or UserBridge |
| **Description** | Type mismatch (bridge type coercion gap) |
| **Batch** | 0 |

**Detailed Analysis:** Type mismatch: the D4rt interpreter produces a value of one type but the native Flutter code expects another (e.g., `InterpretedFunction` vs `void Function()`). Type coercion helpers (`D4.coerceList<T>()`, `D4.coerceMap<K,V>()`) or a UserBridge override are needed. Detail: Expected: true

**Fix Description:** Add type coercion using `D4.coerceList<T>()` or `D4.coerceMap<K,V>()`, or add a UserBridge with explicit type casting.

**Needs Deeper Analysis:** Maybe - determine exact coercion needed

### Suite: secondary_classes_test

**197 issues** — Top: `TRANSPORT-CASCADE` (144), `FW-LAYOUT-OVERFLOW` (15), `FW-LAYOUT-CONSTRAINT` (9)

#### [15] cupertino/cupertino_secondary_test.dart

| Field | Value |
|-------|-------|
| **Index** | 15 |
| **Test Name** | `cupertino/cupertino_secondary_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [16] cupertino/cupertino_form_scroll_test.dart

| Field | Value |
|-------|-------|
| **Index** | 16 |
| **Test Name** | `cupertino/cupertino_form_scroll_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [17] cupertino/cupertino_controls_advanced_test.dart

| Field | Value |
|-------|-------|
| **Index** | 17 |
| **Test Name** | `cupertino/cupertino_controls_advanced_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [18] cupertino/cupertino_sections_test.dart

| Field | Value |
|-------|-------|
| **Index** | 18 |
| **Test Name** | `cupertino/cupertino_sections_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [19] cupertino/cupertino_tabbar_scaffold_test.dart

| Field | Value |
|-------|-------|
| **Index** | 19 |
| **Test Name** | `cupertino/cupertino_tabbar_scaffold_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [20] semantics/semantics_config_test.dart

| Field | Value |
|-------|-------|
| **Index** | 20 |
| **Test Name** | `semantics/semantics_config_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH` |
| **Immediate Fix Possible** | Yes - add D4.coerceList/coerceMap or UserBridge |
| **Description** | Type mismatch (bridge type coercion gap) |
| **Batch** | 0 |

**Detailed Analysis:** Type mismatch: the D4rt interpreter produces a value of one type but the native Flutter code expects another (e.g., `InterpretedFunction` vs `void Function()`). Type coercion helpers (`D4.coerceList<T>()`, `D4.coerceMap<K,V>()`) or a UserBridge override are needed. Detail: Expected: true

**Fix Description:** Add type coercion using `D4.coerceList<T>()` or `D4.coerceMap<K,V>()`, or add a UserBridge with explicit type casting.

**Needs Deeper Analysis:** Maybe - determine exact coercion needed

#### [21] widgets/gesture_detector_adv_test.dart

| Field | Value |
|-------|-------|
| **Index** | 21 |
| **Test Name** | `widgets/gesture_detector_adv_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ArenaSceneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [22] widgets/layout_builder_adv_test.dart

| Field | Value |
|-------|-------|
| **Index** | 22 |
| **Test Name** | `widgets/layout_builder_adv_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [23] widgets/scroll_position_types_test.dart

| Field | Value |
|-------|-------|
| **Index** | 23 |
| **Test Name** | `widgets/scroll_position_types_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: RenderFlex children have non-zero flex but incoming height constraints are unbounded.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [24] widgets/scroll_controllers_types_test.dart

| Field | Value |
|-------|-------|
| **Index** | 24 |
| **Test Name** | `widgets/scroll_controllers_types_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: RenderFlex children have non-zero flex but incoming height constraints are unbounded.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [25] cupertino/cupertino_text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 25 |
| **Test Name** | `cupertino/cupertino_text_selection_controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [26] dart_ui/ztmp_path_metrics_access_test.dart

| Field | Value |
|-------|-------|
| **Index** | 26 |
| **Test Name** | `dart_ui/ztmp_path_metrics_access_test.dart` |
| **Category** | `INTERPRETER-BAD-STATE` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Bad state error |
| **Batch** | 0 |

**Detailed Analysis:** Bad state error in the interpreter. An internal state inconsistency occurred during interpretation. Detail: Expected: true

**Fix Description:** Investigate the specific bad state error context. May require script restructuring.

**Needs Deeper Analysis:** Yes - investigate internal state

#### [27] dart_ui/scene_test.dart

| Field | Value |
|-------|-------|
| **Index** | 27 |
| **Test Name** | `dart_ui/scene_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe - investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Batch** | 0 |

**Detailed Analysis:** Flutter framework assertion failure. The Flutter framework detected an internal inconsistency during widget tree processing. May indicate a script issue or a framework-level timing problem. Detail: 'dart:ui/math.dart': Failed assertion: line 14 pos 10: '<optimized out>': is not true.

**Fix Description:** Investigate the assertion context and determine if the script triggers an invalid state in the Flutter framework.

**Needs Deeper Analysis:** Yes - investigate assertion context

#### [28] dart_ui/semantics_action_event_test.dart

| Field | Value |
|-------|-------|
| **Index** | 28 |
| **Test Name** | `dart_ui/semantics_action_event_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 24 pixels on the right.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [29] dart_ui/string_attribute_test.dart

| Field | Value |
|-------|-------|
| **Index** | 29 |
| **Test Name** | `dart_ui/string_attribute_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 4.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [30] dart_ui/target_image_size_test.dart

| Field | Value |
|-------|-------|
| **Index** | 30 |
| **Test Name** | `dart_ui/target_image_size_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 16 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [31] gestures/vertical_multi_drag_gesture_recognizer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 31 |
| **Test Name** | `gestures/vertical_multi_drag_gesture_recognizer_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _VerticalTrackState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [32] material/scaffold_messenger_test.dart

| Field | Value |
|-------|-------|
| **Index** | 32 |
| **Test Name** | `material/scaffold_messenger_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [33] material/text_button_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 33 |
| **Test Name** | `material/text_button_theme_data_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe - check null safety in script |
| **Description** | Method invocation on null |
| **Batch** | 0 |

**Detailed Analysis:** Method invocation on null: the interpreter tried to call a method on a null receiver. This typically indicates the script expected a non-null value from a bridge call that returned null. Check null safety patterns in the script. Detail: Runtime Error: Cannot invoke method 'toStringAsFixed' on null. Use '?.' for null-aware method invocation.

**Fix Description:** Add null checks in the script before method invocations, or investigate why the bridge returns null.

**Needs Deeper Analysis:** Yes - determine why bridge returns null

#### [34] material/text_selection_toolbar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 34 |
| **Test Name** | `material/text_selection_toolbar_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderCustomSingleChildLayoutBox object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [35] material/text_selection_toolbar_text_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 35 |
| **Test Name** | `material/text_selection_toolbar_text_button_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderCustomSingleChildLayoutBox object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [36] painting/decoration_image_painter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 36 |
| **Test Name** | `painting/decoration_image_painter_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override for method |
| **Description** | Native error during bridged method call |
| **Batch** | 0 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Expected: true

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [37] painting/image_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 37 |
| **Test Name** | `painting/image_info_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 27 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [38] rendering/box_hit_test_result_test.dart

| Field | Value |
|-------|-------|
| **Index** | 38 |
| **Test Name** | `rendering/box_hit_test_result_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [39] rendering/custom_painter_semantics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 39 |
| **Test Name** | `rendering/custom_painter_semantics_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: Argument Error: Invalid parameter "semanticsBuilder": expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [40] rendering/platform_view_layer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 40 |
| **Test Name** | `rendering/platform_view_layer_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 53 pixels on the right.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [41] rendering/relayout_when_system_fonts_change_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 41 |
| **Test Name** | `rendering/relayout_when_system_fonts_change_mixin_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_RelayoutHostWidget)

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [42] rendering/render_absorb_pointer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 42 |
| **Test Name** | `rendering/render_absorb_pointer_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_AbsorbGateHost)

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [43] rendering/render_aligning_shifted_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 43 |
| **Test Name** | `rendering/render_aligning_shifted_box_test.dart` |
| **Category** | `INTERPRETER-UNDEFINED` |
| **Immediate Fix Possible** | Maybe - check bridge coverage or script patterns |
| **Description** | Interpreter cannot resolve variable/property |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve a variable or property. This may be a missing bridge type, a scope resolution issue, or an unimplemented language feature. Detail: Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Undefined property or method 'characters' on bridged instance of 'String'.

**Fix Description:** Check bridge coverage for the referenced type/variable. If it's a dart:core type, it may need explicit registration.

**Needs Deeper Analysis:** Maybe - check if bridge gap or scope issue

#### [44] rendering/render_animated_opacity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 44 |
| **Test Name** | `rendering/render_animated_opacity_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 0 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _controller (Original error: LateInitializationError: Late variable '_controller' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [45] rendering/render_block_semantics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 45 |
| **Test Name** | `rendering/render_block_semantics_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 56 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [46] rendering/render_box_container_defaults_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 46 |
| **Test Name** | `rendering/render_box_container_defaults_mixin_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_DefaultsContainer)

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [47] rendering/render_custom_multi_child_layout_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 47 |
| **Test Name** | `rendering/render_custom_multi_child_layout_box_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Runtime Error: Native error during default bridged constructor for 'CustomMultiChildLayout': Argument Error: Invalid parameter "delegate": expected MultiChildLayoutDelegate, got InterpretedInstance(_D…

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [48] rendering/render_custom_paint_test.dart

| Field | Value |
|-------|-------|
| **Index** | 48 |
| **Test Name** | `rendering/render_custom_paint_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: mounted (Original error: Native error in bridged mixin getter 'mounted': Argument Error: Invalid target: expected SingleTickerProviderStateMixin, got InterpretedInst…

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [49] rendering/render_custom_single_child_layout_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 49 |
| **Test Name** | `rendering/render_custom_single_child_layout_box_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Runtime Error: Native error during default bridged constructor for 'CustomSingleChildLayout': Argument Error: Invalid parameter "delegate": expected SingleChildLayoutDelegate, got InterpretedInstance(…

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [50] rendering/render_editable_test.dart

| Field | Value |
|-------|-------|
| **Index** | 50 |
| **Test Name** | `rendering/render_editable_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [51] rendering/render_ignore_pointer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 51 |
| **Test Name** | `rendering/render_ignore_pointer_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 4.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [52] rendering/render_physical_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 52 |
| **Test Name** | `rendering/render_physical_shape_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 0 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Runtime Error: Native error during default bridged constructor for 'PhysicalShape': Argument Error: Invalid parameter "clipper": expected CustomClipper<Path>, got InterpretedInstance(_BevelClipper)

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [53] rendering/render_shader_mask_test.dart

| Field | Value |
|-------|-------|
| **Index** | 53 |
| **Test Name** | `rendering/render_shader_mask_test.dart` |
| **Category** | `INTERPRETER-INDEX-ERROR` |
| **Immediate Fix Possible** | Yes - fix script bounds checking |
| **Description** | Index out of range error |
| **Batch** | 0 |

**Detailed Analysis:** Index out of range error. The script (or a bridged method) accessed a list/array with an invalid index. Fix bounds checking in the script. Detail: Runtime Error: Index out of range: 3

**Fix Description:** Add bounds checking in the script before list indexing operations.

**Needs Deeper Analysis:** No - fix bounds checking

#### [54] rendering/render_shrink_wrapping_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 54 |
| **Test Name** | `rendering/render_shrink_wrapping_viewport_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 0 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Runtime Error: Error during constructor execution for class '_SizeReporter': Bridged superclass 'SingleChildRenderObjectWidget' does not have a constructor named ''. Check bridge definition.

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [55] rendering/render_sliver_pinned_persistent_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 55 |
| **Test Name** | `rendering/render_sliver_pinned_persistent_header_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 3.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [56] rendering/sliver_hit_test_result_test.dart

| Field | Value |
|-------|-------|
| **Index** | 56 |
| **Test Name** | `rendering/sliver_hit_test_result_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 4.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [57] rendering/sliver_layout_dimensions_test.dart

| Field | Value |
|-------|-------|
| **Index** | 57 |
| **Test Name** | `rendering/sliver_layout_dimensions_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 4.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [58] widgets/android_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 58 |
| **Test Name** | `widgets/android_view_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing type/class definition |
| **Batch** | 0 |

**Detailed Analysis:** A type or class referenced in the script is not registered in the bridge. The interpreter cannot resolve it as a variable/constructor. This type needs to be added to the bridge generator configuration or a UserBridge. Detail: Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.

**Fix Description:** Add the missing type to the bridge generator configuration (flutterm_config.yaml) or create a UserBridge class for it.

**Needs Deeper Analysis:** No - add to bridge config

#### [59] widgets/animated_cross_fade_test.dart

| Field | Value |
|-------|-------|
| **Index** | 59 |
| **Test Name** | `widgets/animated_cross_fade_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes - add method to bridge or UserBridge override |
| **Description** | Bridge missing method implementation |
| **Batch** | 0 |

**Detailed Analysis:** A method or instance method on a bridged class is not implemented in the bridge. The interpreter finds no matching method and raises NoSuchMethodError. The method needs to be added to the bridge or overridden via UserBridge. Detail: Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.

**Fix Description:** Add the method to the bridge generator output or create a UserBridge `overrideMethodXxx` override.

**Needs Deeper Analysis:** No - add to bridge or UserBridge

#### [60] widgets/animated_fractionally_sized_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 60 |
| **Test Name** | `widgets/animated_fractionally_sized_box_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 8.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [61] widgets/animated_switcher_test.dart

| Field | Value |
|-------|-------|
| **Index** | 61 |
| **Test Name** | `widgets/animated_switcher_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes - add method to bridge or UserBridge override |
| **Description** | Bridge missing method implementation |
| **Batch** | 0 |

**Detailed Analysis:** A method or instance method on a bridged class is not implemented in the bridge. The interpreter finds no matching method and raises NoSuchMethodError. The method needs to be added to the bridge or overridden via UserBridge. Detail: Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.

**Fix Description:** Add the method to the bridge generator output or create a UserBridge `overrideMethodXxx` override.

**Needs Deeper Analysis:** No - add to bridge or UserBridge

#### [62] widgets/autofill_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 62 |
| **Test Name** | `widgets/autofill_group_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillGroupLaneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [63] widgets/backdrop_filter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 63 |
| **Test Name** | `widgets/backdrop_filter_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes - add method to bridge or UserBridge override |
| **Description** | Bridge missing method implementation |
| **Batch** | 0 |

**Detailed Analysis:** A method or instance method on a bridged class is not implemented in the bridge. The interpreter finds no matching method and raises NoSuchMethodError. The method needs to be added to the bridge or overridden via UserBridge. Detail: Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.

**Fix Description:** Add the method to the bridge generator output or create a UserBridge `overrideMethodXxx` override.

**Needs Deeper Analysis:** No - add to bridge or UserBridge

#### [64] widgets/color_filtered_test.dart

| Field | Value |
|-------|-------|
| **Index** | 64 |
| **Test Name** | `widgets/color_filtered_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 0 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: RenderFlex children have non-zero flex but incoming height constraints are unbounded.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [65] widgets/composited_transform_follower_test.dart

| Field | Value |
|-------|-------|
| **Index** | 65 |
| **Test Name** | `widgets/composited_transform_follower_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 0 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _LinkPrimerState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [66] widgets/default_asset_bundle_test.dart

| Field | Value |
|-------|-------|
| **Index** | 66 |
| **Test Name** | `widgets/default_asset_bundle_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 0 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _oceanBundle (Original error: LateInitializationError: Late variable '_oceanBundle' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [67] widgets/directionality_test.dart

| Field | Value |
|-------|-------|
| **Index** | 67 |
| **Test Name** | `widgets/directionality_test.dart` |
| **Category** | `TRANSPORT-ERROR` |
| **Immediate Fix Possible** | No - infrastructure issue |
| **Description** | Transport error (HTTP failure) |
| **Batch** | 0 |

**Detailed Analysis:** HTTP transport failure when sending test script `widgets/directionality_test.dart` to the D4rt Flutter app. The test runner could not establish communication with the running app, likely due to a timeout or connection reset. Error: Bad state: Transport failure while running "widgets/directionality_test.dart"

**Fix Description:** Investigate HTTP transport layer. Check app startup timing, port availability, and connection timeout settings. May need to increase initial connection wait time.

**Needs Deeper Analysis:** Yes - investigate transport layer

#### [68] widgets/display_feature_sub_screen_test.dart

| Field | Value |
|-------|-------|
| **Index** | 68 |
| **Test Name** | `widgets/display_feature_sub_screen_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [69] widgets/dual_transition_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 69 |
| **Test Name** | `widgets/dual_transition_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [70] widgets/editable_text_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 70 |
| **Test Name** | `widgets/editable_text_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [71] widgets/element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 71 |
| **Test Name** | `widgets/element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [72] widgets/fade_in_image_test.dart

| Field | Value |
|-------|-------|
| **Index** | 72 |
| **Test Name** | `widgets/fade_in_image_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [73] widgets/fixed_extent_metrics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 73 |
| **Test Name** | `widgets/fixed_extent_metrics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [74] widgets/fixed_extent_scroll_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 74 |
| **Test Name** | `widgets/fixed_extent_scroll_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [75] widgets/fixed_extent_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 75 |
| **Test Name** | `widgets/fixed_extent_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [76] widgets/glowing_overscroll_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 76 |
| **Test Name** | `widgets/glowing_overscroll_indicator_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [77] widgets/html_element_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 77 |
| **Test Name** | `widgets/html_element_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [78] widgets/image_filtered_test.dart

| Field | Value |
|-------|-------|
| **Index** | 78 |
| **Test Name** | `widgets/image_filtered_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [79] widgets/implicitly_animated_widget_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 79 |
| **Test Name** | `widgets/implicitly_animated_widget_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [80] widgets/implicitly_animated_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 80 |
| **Test Name** | `widgets/implicitly_animated_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [81] widgets/indexed_stack_test.dart

| Field | Value |
|-------|-------|
| **Index** | 81 |
| **Test Name** | `widgets/indexed_stack_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [82] widgets/inherited_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 82 |
| **Test Name** | `widgets/inherited_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [83] widgets/inherited_notifier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 83 |
| **Test Name** | `widgets/inherited_notifier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [84] widgets/inherited_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 84 |
| **Test Name** | `widgets/inherited_theme_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [85] widgets/inherited_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 85 |
| **Test Name** | `widgets/inherited_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [86] widgets/leaf_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 86 |
| **Test Name** | `widgets/leaf_render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [87] widgets/leaf_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 87 |
| **Test Name** | `widgets/leaf_render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [88] widgets/list_wheel_child_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 88 |
| **Test Name** | `widgets/list_wheel_child_builder_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [89] widgets/list_wheel_child_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 89 |
| **Test Name** | `widgets/list_wheel_child_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [90] widgets/list_wheel_child_list_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 90 |
| **Test Name** | `widgets/list_wheel_child_list_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [91] widgets/list_wheel_child_looping_list_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 91 |
| **Test Name** | `widgets/list_wheel_child_looping_list_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [92] widgets/list_wheel_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 92 |
| **Test Name** | `widgets/list_wheel_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [93] widgets/list_wheel_scroll_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 93 |
| **Test Name** | `widgets/list_wheel_scroll_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [94] widgets/list_wheel_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 94 |
| **Test Name** | `widgets/list_wheel_viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [95] widgets/magnifier_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 95 |
| **Test Name** | `widgets/magnifier_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [96] widgets/magnifier_decoration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 96 |
| **Test Name** | `widgets/magnifier_decoration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [97] widgets/magnifier_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 97 |
| **Test Name** | `widgets/magnifier_info_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [98] widgets/multi_child_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 98 |
| **Test Name** | `widgets/multi_child_render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [99] widgets/multi_child_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 99 |
| **Test Name** | `widgets/multi_child_render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [100] widgets/navigation_toolbar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 100 |
| **Test Name** | `widgets/navigation_toolbar_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [101] widgets/never_scrollable_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 101 |
| **Test Name** | `widgets/never_scrollable_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [102] widgets/overflow_bar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 102 |
| **Test Name** | `widgets/overflow_bar_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [103] widgets/overflow_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 103 |
| **Test Name** | `widgets/overflow_box_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [104] widgets/page_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 104 |
| **Test Name** | `widgets/page_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [105] widgets/page_storage_bucket_test.dart

| Field | Value |
|-------|-------|
| **Index** | 105 |
| **Test Name** | `widgets/page_storage_bucket_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [106] widgets/page_storage_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 106 |
| **Test Name** | `widgets/page_storage_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [107] widgets/page_storage_test.dart

| Field | Value |
|-------|-------|
| **Index** | 107 |
| **Test Name** | `widgets/page_storage_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [108] widgets/parent_data_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 108 |
| **Test Name** | `widgets/parent_data_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [109] widgets/parent_data_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 109 |
| **Test Name** | `widgets/parent_data_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [110] widgets/performance_overlay_test.dart

| Field | Value |
|-------|-------|
| **Index** | 110 |
| **Test Name** | `widgets/performance_overlay_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [111] widgets/physical_model_test.dart

| Field | Value |
|-------|-------|
| **Index** | 111 |
| **Test Name** | `widgets/physical_model_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [112] widgets/physical_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 112 |
| **Test Name** | `widgets/physical_shape_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [113] widgets/pinned_header_sliver_test.dart

| Field | Value |
|-------|-------|
| **Index** | 113 |
| **Test Name** | `widgets/pinned_header_sliver_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [114] widgets/platform_menu_bar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 114 |
| **Test Name** | `widgets/platform_menu_bar_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [115] widgets/platform_menu_item_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 115 |
| **Test Name** | `widgets/platform_menu_item_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [116] widgets/platform_menu_item_test.dart

| Field | Value |
|-------|-------|
| **Index** | 116 |
| **Test Name** | `widgets/platform_menu_item_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [117] widgets/platform_menu_test.dart

| Field | Value |
|-------|-------|
| **Index** | 117 |
| **Test Name** | `widgets/platform_menu_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [118] widgets/platform_provided_menu_item_test.dart

| Field | Value |
|-------|-------|
| **Index** | 118 |
| **Test Name** | `widgets/platform_provided_menu_item_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [119] widgets/platform_view_link_test.dart

| Field | Value |
|-------|-------|
| **Index** | 119 |
| **Test Name** | `widgets/platform_view_link_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [120] widgets/platform_view_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 120 |
| **Test Name** | `widgets/platform_view_surface_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [121] widgets/pop_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 121 |
| **Test Name** | `widgets/pop_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [122] widgets/positioned_directional_test.dart

| Field | Value |
|-------|-------|
| **Index** | 122 |
| **Test Name** | `widgets/positioned_directional_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [123] widgets/primary_scroll_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 123 |
| **Test Name** | `widgets/primary_scroll_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [124] widgets/proxy_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 124 |
| **Test Name** | `widgets/proxy_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [125] widgets/proxy_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 125 |
| **Test Name** | `widgets/proxy_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [126] widgets/radio_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 126 |
| **Test Name** | `widgets/radio_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [127] widgets/range_maintaining_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 127 |
| **Test Name** | `widgets/range_maintaining_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [128] widgets/raw_magnifier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 128 |
| **Test Name** | `widgets/raw_magnifier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [129] widgets/raw_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 129 |
| **Test Name** | `widgets/raw_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [130] widgets/render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 130 |
| **Test Name** | `widgets/render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [131] widgets/render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 131 |
| **Test Name** | `widgets/render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [132] widgets/restorable_bool_test.dart

| Field | Value |
|-------|-------|
| **Index** | 132 |
| **Test Name** | `widgets/restorable_bool_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [133] widgets/restorable_date_time_test.dart

| Field | Value |
|-------|-------|
| **Index** | 133 |
| **Test Name** | `widgets/restorable_date_time_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [134] widgets/restorable_double_test.dart

| Field | Value |
|-------|-------|
| **Index** | 134 |
| **Test Name** | `widgets/restorable_double_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [135] widgets/restorable_enum_test.dart

| Field | Value |
|-------|-------|
| **Index** | 135 |
| **Test Name** | `widgets/restorable_enum_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [136] widgets/restorable_int_test.dart

| Field | Value |
|-------|-------|
| **Index** | 136 |
| **Test Name** | `widgets/restorable_int_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [137] widgets/restorable_property_test.dart

| Field | Value |
|-------|-------|
| **Index** | 137 |
| **Test Name** | `widgets/restorable_property_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [138] widgets/restorable_string_test.dart

| Field | Value |
|-------|-------|
| **Index** | 138 |
| **Test Name** | `widgets/restorable_string_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [139] widgets/restorable_text_editing_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 139 |
| **Test Name** | `widgets/restorable_text_editing_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [140] widgets/restorable_value_test.dart

| Field | Value |
|-------|-------|
| **Index** | 140 |
| **Test Name** | `widgets/restorable_value_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [141] widgets/restoration_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 141 |
| **Test Name** | `widgets/restoration_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [142] widgets/root_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 142 |
| **Test Name** | `widgets/root_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [143] widgets/root_restoration_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 143 |
| **Test Name** | `widgets/root_restoration_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [144] widgets/root_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 144 |
| **Test Name** | `widgets/root_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [145] widgets/scroll_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 145 |
| **Test Name** | `widgets/scroll_action_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [146] widgets/scroll_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 146 |
| **Test Name** | `widgets/scroll_configuration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [147] widgets/scroll_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 147 |
| **Test Name** | `widgets/scroll_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [148] widgets/scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 148 |
| **Test Name** | `widgets/scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [149] widgets/scroll_position_test.dart

| Field | Value |
|-------|-------|
| **Index** | 149 |
| **Test Name** | `widgets/scroll_position_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [150] widgets/scrollable_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 150 |
| **Test Name** | `widgets/scrollable_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [151] widgets/scrollable_test.dart

| Field | Value |
|-------|-------|
| **Index** | 151 |
| **Test Name** | `widgets/scrollable_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [152] widgets/selectable_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 152 |
| **Test Name** | `widgets/selectable_region_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [153] widgets/selection_container_test.dart

| Field | Value |
|-------|-------|
| **Index** | 153 |
| **Test Name** | `widgets/selection_container_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [154] widgets/selection_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 154 |
| **Test Name** | `widgets/selection_listener_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [155] widgets/selection_overlay_test.dart

| Field | Value |
|-------|-------|
| **Index** | 155 |
| **Test Name** | `widgets/selection_overlay_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [156] widgets/shader_mask_test.dart

| Field | Value |
|-------|-------|
| **Index** | 156 |
| **Test Name** | `widgets/shader_mask_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [157] widgets/shared_app_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 157 |
| **Test Name** | `widgets/shared_app_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [158] widgets/shrink_wrapping_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 158 |
| **Test Name** | `widgets/shrink_wrapping_viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [159] widgets/single_child_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 159 |
| **Test Name** | `widgets/single_child_render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [160] widgets/single_child_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 160 |
| **Test Name** | `widgets/single_child_render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [161] widgets/single_ticker_provider_state_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 161 |
| **Test Name** | `widgets/single_ticker_provider_state_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [162] widgets/sliver_animated_grid_test.dart

| Field | Value |
|-------|-------|
| **Index** | 162 |
| **Test Name** | `widgets/sliver_animated_grid_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [163] widgets/sliver_animated_list_test.dart

| Field | Value |
|-------|-------|
| **Index** | 163 |
| **Test Name** | `widgets/sliver_animated_list_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [164] widgets/sliver_animated_opacity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 164 |
| **Test Name** | `widgets/sliver_animated_opacity_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [165] widgets/sliver_constrained_cross_axis_test.dart

| Field | Value |
|-------|-------|
| **Index** | 165 |
| **Test Name** | `widgets/sliver_constrained_cross_axis_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [166] widgets/sliver_cross_axis_expanded_test.dart

| Field | Value |
|-------|-------|
| **Index** | 166 |
| **Test Name** | `widgets/sliver_cross_axis_expanded_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [167] widgets/sliver_cross_axis_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 167 |
| **Test Name** | `widgets/sliver_cross_axis_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [168] widgets/sliver_floating_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 168 |
| **Test Name** | `widgets/sliver_floating_header_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [169] widgets/sliver_ignore_pointer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 169 |
| **Test Name** | `widgets/sliver_ignore_pointer_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [170] widgets/sliver_layout_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 170 |
| **Test Name** | `widgets/sliver_layout_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [171] widgets/sliver_main_axis_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 171 |
| **Test Name** | `widgets/sliver_main_axis_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [172] widgets/sliver_offstage_test.dart

| Field | Value |
|-------|-------|
| **Index** | 172 |
| **Test Name** | `widgets/sliver_offstage_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [173] widgets/sliver_prototype_extent_list_test.dart

| Field | Value |
|-------|-------|
| **Index** | 173 |
| **Test Name** | `widgets/sliver_prototype_extent_list_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [174] widgets/sliver_reorderable_list_test.dart

| Field | Value |
|-------|-------|
| **Index** | 174 |
| **Test Name** | `widgets/sliver_reorderable_list_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [175] widgets/sliver_resizing_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 175 |
| **Test Name** | `widgets/sliver_resizing_header_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [176] widgets/sliver_safe_area_test.dart

| Field | Value |
|-------|-------|
| **Index** | 176 |
| **Test Name** | `widgets/sliver_safe_area_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [177] widgets/sliver_semantics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 177 |
| **Test Name** | `widgets/sliver_semantics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [178] widgets/sliver_visibility_test.dart

| Field | Value |
|-------|-------|
| **Index** | 178 |
| **Test Name** | `widgets/sliver_visibility_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [179] widgets/spacer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 179 |
| **Test Name** | `widgets/spacer_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [180] widgets/spell_check_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 180 |
| **Test Name** | `widgets/spell_check_configuration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [181] widgets/stateful_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 181 |
| **Test Name** | `widgets/stateful_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [182] widgets/stateless_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 182 |
| **Test Name** | `widgets/stateless_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [183] widgets/stretching_overscroll_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 183 |
| **Test Name** | `widgets/stretching_overscroll_indicator_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [184] widgets/table_cell_test.dart

| Field | Value |
|-------|-------|
| **Index** | 184 |
| **Test Name** | `widgets/table_cell_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [185] widgets/table_row_test.dart

| Field | Value |
|-------|-------|
| **Index** | 185 |
| **Test Name** | `widgets/table_row_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [186] widgets/tap_region_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 186 |
| **Test Name** | `widgets/tap_region_surface_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [187] widgets/tap_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 187 |
| **Test Name** | `widgets/tap_region_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [188] widgets/text_field_tap_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 188 |
| **Test Name** | `widgets/text_field_tap_region_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [189] widgets/text_magnifier_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 189 |
| **Test Name** | `widgets/text_magnifier_configuration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [190] widgets/text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 190 |
| **Test Name** | `widgets/text_selection_controls_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [191] widgets/text_selection_gesture_detector_test.dart

| Field | Value |
|-------|-------|
| **Index** | 191 |
| **Test Name** | `widgets/text_selection_gesture_detector_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [192] widgets/text_selection_overlay_test.dart

| Field | Value |
|-------|-------|
| **Index** | 192 |
| **Test Name** | `widgets/text_selection_overlay_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [193] widgets/text_selection_toolbar_anchors_test.dart

| Field | Value |
|-------|-------|
| **Index** | 193 |
| **Test Name** | `widgets/text_selection_toolbar_anchors_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [194] widgets/ticker_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 194 |
| **Test Name** | `widgets/ticker_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [195] widgets/ticker_provider_state_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 195 |
| **Test Name** | `widgets/ticker_provider_state_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [196] widgets/title_test.dart

| Field | Value |
|-------|-------|
| **Index** | 196 |
| **Test Name** | `widgets/title_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [197] widgets/tooltip_trigger_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 197 |
| **Test Name** | `widgets/tooltip_trigger_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [198] widgets/tween_animation_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 198 |
| **Test Name** | `widgets/tween_animation_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [199] widgets/ui_kit_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 199 |
| **Test Name** | `widgets/ui_kit_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [200] widgets/undo_history_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 200 |
| **Test Name** | `widgets/undo_history_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [201] widgets/view_anchor_test.dart

| Field | Value |
|-------|-------|
| **Index** | 201 |
| **Test Name** | `widgets/view_anchor_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [202] widgets/view_collection_test.dart

| Field | Value |
|-------|-------|
| **Index** | 202 |
| **Test Name** | `widgets/view_collection_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [203] widgets/view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 203 |
| **Test Name** | `widgets/view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [204] widgets/viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 204 |
| **Test Name** | `widgets/viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [205] widgets/widget_inspector_test.dart

| Field | Value |
|-------|-------|
| **Index** | 205 |
| **Test Name** | `widgets/widget_inspector_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [206] widgets/widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 206 |
| **Test Name** | `widgets/widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [207] widgets/widgets_app_test.dart

| Field | Value |
|-------|-------|
| **Index** | 207 |
| **Test Name** | `widgets/widgets_app_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [208] widgets/widgets_binding_observer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 208 |
| **Test Name** | `widgets/widgets_binding_observer_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [209] widgets/widgets_binding_test.dart

| Field | Value |
|-------|-------|
| **Index** | 209 |
| **Test Name** | `widgets/widgets_binding_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [210] widgets/widgets_flutter_binding_test.dart

| Field | Value |
|-------|-------|
| **Index** | 210 |
| **Test Name** | `widgets/widgets_flutter_binding_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [211] widgets/will_pop_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 211 |
| **Test Name** | `widgets/will_pop_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 0 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error


---

## Batch 1 — Detailed Analysis

| Metric | Value |
|--------|-------|
| Total Issues | 286 |
| Failures | 150 |
| FW-Error-Only | 136 |
| Top Category | TRANSPORT-CASCADE (105) |

### Batch 1 Category Distribution

| Category | Count |
|----------|------:|
| `TRANSPORT-CASCADE` | 105 |
| `SCRIPT-LATEINIT` | 103 |
| `BRIDGE-INTERPRETED-INSTANCE` | 19 |
| `BRIDGE-MISSING-CONSTRUCTOR` | 14 |
| `INTERPRETER-STATE-ACCESS` | 11 |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 6 |
| `FW-LAYOUT-OVERFLOW` | 5 |
| `BRIDGE-NATIVE-ERROR` | 4 |
| `BRIDGE-MISSING-TYPE` | 4 |
| `FW-LAYOUT-CONSTRAINT` | 3 |
| `BRIDGE-TYPE-MISMATCH-FW` | 3 |
| `FW-OTHER` | 3 |
| `BRIDGE-MISSING-PROPERTY` | 2 |
| `INTERPRETER-NULL-INVOKE` | 1 |
| `TRANSPORT-ERROR` | 1 |
| `BRIDGE-NOT-CALLABLE` | 1 |
| `INTERPRETER-GENERIC-INFERENCE` | 1 |

### Suite: hardly_relevant_classes_3_test

**18 issues** — Top: `SCRIPT-LATEINIT` (4), `FW-LAYOUT-OVERFLOW` (3), `BRIDGE-NATIVE-ERROR` (2)

#### [266] rendering/floating_header_snap_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 266 |
| **Test Name** | `rendering/floating_header_snap_configuration_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 2.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [267] rendering/hit_test_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 267 |
| **Test Name** | `rendering/hit_test_behavior_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe - check null safety in script |
| **Description** | Method invocation on null |
| **Batch** | 1 |

**Detailed Analysis:** Method invocation on null: the interpreter tried to call a method on a null receiver. This typically indicates the script expected a non-null value from a bridge call that returned null. Check null safety patterns in the script. Detail: Expected: true

**Fix Description:** Add null checks in the script before method invocations, or investigate why the bridge returns null.

**Needs Deeper Analysis:** Yes - determine why bridge returns null

#### [268] rendering/over_scroll_header_stretch_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 268 |
| **Test Name** | `rendering/over_scroll_header_stretch_configuration_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [269] rendering/pipeline_manifold_test.dart

| Field | Value |
|-------|-------|
| **Index** | 269 |
| **Test Name** | `rendering/pipeline_manifold_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _manifold (Original error: LateInitializationError: Late variable '_manifold' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [270] rendering/placeholder_span_index_semantics_tag_test.dart

| Field | Value |
|-------|-------|
| **Index** | 270 |
| **Test Name** | `rendering/placeholder_span_index_semantics_tag_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tags (Original error: LateInitializationError: Late variable '_tags' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [271] rendering/platform_view_render_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 271 |
| **Test Name** | `rendering/platform_view_render_box_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _controller (Original error: LateInitializationError: Late variable '_controller' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [272] rendering/render_abstract_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 272 |
| **Test Name** | `rendering/render_abstract_viewport_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 70 pixels on the right.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [273] rendering/render_android_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 273 |
| **Test Name** | `rendering/render_android_view_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override |
| **Description** | Native error during bridged constructor/method |
| **Batch** | 1 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Switch expression was not exhaustive for value: PlatformViewHitTestBehavior.opaque (PlatformViewHitTestBehav…

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [274] rendering/render_animated_opacity_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 274 |
| **Test Name** | `rendering/render_animated_opacity_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _curvedAnimation (Original error: LateInitializationError: Late variable '_curvedAnimation' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [275] rendering/render_animated_size_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 275 |
| **Test Name** | `rendering/render_animated_size_state_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: Runtime Error: Native error during default bridged constructor for 'ConstrainedBox': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_MeasureBox)

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [276] rendering/render_clip_r_superellipse_test.dart

| Field | Value |
|-------|-------|
| **Index** | 276 |
| **Test Name** | `rendering/render_clip_r_superellipse_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override |
| **Description** | Native error during bridged constructor/method |
| **Batch** | 1 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [277] rendering/render_editable_painter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 277 |
| **Test Name** | `rendering/render_editable_painter_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: BoxConstraints has a negative minimum height.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [278] rendering/render_sliver_box_child_manager_test.dart

| Field | Value |
|-------|-------|
| **Index** | 278 |
| **Test Name** | `rendering/render_sliver_box_child_manager_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH-FW` |
| **Immediate Fix Possible** | Yes - add D4.coerceList/coerceMap or UserBridge |
| **Description** | Type mismatch in framework error (bridge coercion gap) |
| **Batch** | 1 |

**Detailed Analysis:** Type mismatch surfaced as a Flutter framework error (not a test failure). The bridge produced a type that Flutter's widget tree couldn't consume (e.g., `List<Object?>` instead of `List<Widget>`). This is typically the generic inference issue (#1). Detail: type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast

**Fix Description:** Add explicit type annotations in the script (e.g., `<Widget>[...]`) or add type coercion in a UserBridge.

**Needs Deeper Analysis:** No - known generic inference issue

#### [279] rendering/render_sliver_floating_pinned_persistent_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 279 |
| **Test Name** | `rendering/render_sliver_floating_pinned_persistent_header_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PrimerSceneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [280] rendering/render_ui_kit_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 280 |
| **Test Name** | `rendering/render_ui_kit_view_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PrimerSceneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [281] services/message_codec_test.dart

| Field | Value |
|-------|-------|
| **Index** | 281 |
| **Test Name** | `services/message_codec_test.dart` |
| **Category** | `BRIDGE-MISSING-PROPERTY` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing property/method on native class |
| **Batch** | 1 |

**Detailed Analysis:** A property on a native/bridged class is not accessible through the bridge. The interpreter cannot find the getter/setter. The property needs to be added to the bridge generator or overridden via UserBridge. Detail: Expected: true

**Fix Description:** Add the property to the bridge generator output or create a UserBridge `overrideGetterXxx`/`overrideSetterXxx` override.

**Needs Deeper Analysis:** No - add to bridge or UserBridge

#### [282] services/method_codec_test.dart

| Field | Value |
|-------|-------|
| **Index** | 282 |
| **Test Name** | `services/method_codec_test.dart` |
| **Category** | `BRIDGE-MISSING-PROPERTY` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing property on native class |
| **Batch** | 1 |

**Detailed Analysis:** A property on a native/bridged class is not accessible through the bridge. The interpreter cannot find the getter/setter. The property needs to be added to the bridge generator or overridden via UserBridge. Detail: Expected: true

**Fix Description:** Add the property to the bridge generator output or create a UserBridge `overrideGetterXxx`/`overrideSetterXxx` override.

**Needs Deeper Analysis:** No - add to bridge or UserBridge

#### [283] services/raw_key_up_event_test.dart

| Field | Value |
|-------|-------|
| **Index** | 283 |
| **Test Name** | `services/raw_key_up_event_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

### Suite: hardly_relevant_classes_4_test

**127 issues** — Top: `TRANSPORT-CASCADE` (105), `INTERPRETER-STATE-ACCESS` (7), `SCRIPT-LATEINIT` (4)

#### [284] widgets/action_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 284 |
| **Test Name** | `widgets/action_listener_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _dispatcher (Original error: LateInitializationError: Late variable '_dispatcher' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [285] widgets/align_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 285 |
| **Test Name** | `widgets/align_transition_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _alignmentAnimation (Original error: LateInitializationError: Late variable '_alignmentAnimation' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [286] widgets/android_view_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 286 |
| **Test Name** | `widgets/android_view_surface_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing type/class definition |
| **Batch** | 1 |

**Detailed Analysis:** A type or class referenced in the script is not registered in the bridge. The interpreter cannot resolve it as a variable/constructor. This type needs to be added to the bridge generator configuration or a UserBridge. Detail: Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.

**Fix Description:** Add the missing type to the bridge generator configuration (flutterm_config.yaml) or create a UserBridge class for it.

**Needs Deeper Analysis:** No - add to bridge config

#### [287] widgets/animated_positioned_directional_test.dart

| Field | Value |
|-------|-------|
| **Index** | 287 |
| **Test Name** | `widgets/animated_positioned_directional_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: context (Original error: Undefined property 'context' on _AnimatedPositionedDirectionalDemoState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [288] widgets/app_kit_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 288 |
| **Test Name** | `widgets/app_kit_view_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing type/class definition |
| **Batch** | 1 |

**Detailed Analysis:** A type or class referenced in the script is not registered in the bridge. The interpreter cannot resolve it as a variable/constructor. This type needs to be added to the bridge generator configuration or a UserBridge. Detail: Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'.

**Fix Description:** Add the missing type to the bridge generator configuration (flutterm_config.yaml) or create a UserBridge class for it.

**Needs Deeper Analysis:** No - add to bridge config

#### [289] widgets/autocomplete_highlighted_option_test.dart

| Field | Value |
|-------|-------|
| **Index** | 289 |
| **Test Name** | `widgets/autocomplete_highlighted_option_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _HighlightLaneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [290] widgets/autofill_group_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 290 |
| **Test Name** | `widgets/autofill_group_state_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillLaneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [291] widgets/automatic_keep_alive_client_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 291 |
| **Test Name** | `widgets/automatic_keep_alive_client_mixin_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe - fix layout in script |
| **Description** | Layout constraint error (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout constraint error during test execution. `BoxConstraints` violation (negative min height, infinite size), `hasSize` assertion, or similar layout errors. These are framework noise from the test rendering pipeline and often relate to how the script constructs its widget tree. Detail: RenderParagraph object was given an infinite size during layout.

**Fix Description:** Review the script's widget tree for constraint violations. Ensure `SizedBox`, `ConstrainedBox`, or `MediaQuery` provides valid constraints.

**Needs Deeper Analysis:** No - constraint adjustment

#### [292] widgets/back_button_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 292 |
| **Test Name** | `widgets/back_button_listener_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Batch** | 1 |

**Detailed Analysis:** Uncategorized framework error. Needs further investigation to determine root cause. Detail: Runtime Error: Error in generic constructor factory for 'Router': Null check operator used on a null value

**Fix Description:** Requires deeper investigation to determine the root cause and appropriate fix.

**Needs Deeper Analysis:** Yes - uncategorized

#### [293] widgets/backdrop_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 293 |
| **Test Name** | `widgets/backdrop_group_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _BackdropGroupDeepDemoState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [294] widgets/border_tween_test.dart

| Field | Value |
|-------|-------|
| **Index** | 294 |
| **Test Name** | `widgets/border_tween_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Batch** | 1 |

**Detailed Analysis:** Uncategorized framework error. Needs further investigation to determine root cause. Detail: A borderRadius can only be given on borders with uniform colors.

**Fix Description:** Requires deeper investigation to determine the root cause and appropriate fix.

**Needs Deeper Analysis:** Yes - uncategorized

#### [295] widgets/box_scroll_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 295 |
| **Test Name** | `widgets/box_scroll_view_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed object |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Runtime Error: Native error during default bridged constructor for 'SizedBox': Argument Error: Invalid parameter "child": expected Widget?, got InterpretedInstance(_PaletteStripBoxScrollView)

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [296] widgets/clip_r_superellipse_test.dart

| Field | Value |
|-------|-------|
| **Index** | 296 |
| **Test Name** | `widgets/clip_r_superellipse_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _pulse (Original error: LateInitializationError: Late variable '_pulse' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [297] widgets/constrained_layout_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 297 |
| **Test Name** | `widgets/constrained_layout_builder_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 14 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [298] widgets/constraints_transform_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 298 |
| **Test Name** | `widgets/constraints_transform_box_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Batch** | 1 |

**Detailed Analysis:** Uncategorized framework error. Needs further investigation to determine root cause. Detail: A RenderConstraintsTransformBox overflowed by 11 pixels on the left, 8.5 pixels on the top, 8.5 pixels on the bottom, and 11 pixels on the right.

**Fix Description:** Requires deeper investigation to determine the root cause and appropriate fix.

**Needs Deeper Analysis:** Yes - uncategorized

#### [299] widgets/context_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 299 |
| **Test Name** | `widgets/context_action_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [300] widgets/default_selection_style_test.dart

| Field | Value |
|-------|-------|
| **Index** | 300 |
| **Test Name** | `widgets/default_selection_style_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ZonePanelState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [301] widgets/default_text_editing_shortcuts_test.dart

| Field | Value |
|-------|-------|
| **Index** | 301 |
| **Test Name** | `widgets/default_text_editing_shortcuts_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override |
| **Description** | Native error during bridged constructor/method |
| **Batch** | 1 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to Map<ShortcutActivator, Intent> - type 'InterpretedI…

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [302] widgets/default_text_style_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 302 |
| **Test Name** | `widgets/default_text_style_transition_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _heroStyle (Original error: LateInitializationError: Late variable '_heroStyle' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [303] widgets/draggable_scrollable_actuator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 303 |
| **Test Name** | `widgets/draggable_scrollable_actuator_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _SingleActuatorSceneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [304] widgets/expansible_test.dart

| Field | Value |
|-------|-------|
| **Index** | 304 |
| **Test Name** | `widgets/expansible_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ControllerApiSceneState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [305] widgets/extend_selection_to_line_break_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 305 |
| **Test Name** | `widgets/extend_selection_to_line_break_intent_test.dart` |
| **Category** | `TRANSPORT-ERROR` |
| **Immediate Fix Possible** | No - infrastructure issue |
| **Description** | Transport error (HTTP failure) |
| **Batch** | 1 |

**Detailed Analysis:** HTTP transport failure when sending test script `widgets/extend_selection_to_line_break_intent_test.dart` to the D4rt Flutter app. The test runner could not establish communication with the running app, likely due to a timeout or connection reset. Error: Bad state: Transport failure while running "widgets/extend_selection_to_line_break_intent_test.dart"

**Fix Description:** Investigate HTTP transport layer. Check app startup timing, port availability, and connection timeout settings. May need to increase initial connection wait time.

**Needs Deeper Analysis:** Yes - investigate transport layer

#### [306] widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 306 |
| **Test Name** | `widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [307] widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 307 |
| **Test Name** | `widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [308] widgets/extend_selection_to_next_word_boundary_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 308 |
| **Test Name** | `widgets/extend_selection_to_next_word_boundary_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [309] widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 309 |
| **Test Name** | `widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [310] widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 310 |
| **Test Name** | `widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [311] widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 311 |
| **Test Name** | `widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [312] widgets/feedback_test.dart

| Field | Value |
|-------|-------|
| **Index** | 312 |
| **Test Name** | `widgets/feedback_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [313] widgets/fixed_scroll_metrics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 313 |
| **Test Name** | `widgets/fixed_scroll_metrics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [314] widgets/flex_test.dart

| Field | Value |
|-------|-------|
| **Index** | 314 |
| **Test Name** | `widgets/flex_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [315] widgets/floating_header_snap_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 315 |
| **Test Name** | `widgets/floating_header_snap_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [316] widgets/focus_attachment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 316 |
| **Test Name** | `widgets/focus_attachment_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [317] widgets/focus_highlight_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 317 |
| **Test Name** | `widgets/focus_highlight_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [318] widgets/focus_highlight_strategy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 318 |
| **Test Name** | `widgets/focus_highlight_strategy_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [319] widgets/focus_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 319 |
| **Test Name** | `widgets/focus_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [320] widgets/focus_scope_node_test.dart

| Field | Value |
|-------|-------|
| **Index** | 320 |
| **Test Name** | `widgets/focus_scope_node_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [321] widgets/focus_traversal_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 321 |
| **Test Name** | `widgets/focus_traversal_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [322] widgets/fractional_translation_test.dart

| Field | Value |
|-------|-------|
| **Index** | 322 |
| **Test Name** | `widgets/fractional_translation_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [323] widgets/gesture_recognizer_factory_test.dart

| Field | Value |
|-------|-------|
| **Index** | 323 |
| **Test Name** | `widgets/gesture_recognizer_factory_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [324] widgets/gesture_recognizer_factory_with_handlers_test.dart

| Field | Value |
|-------|-------|
| **Index** | 324 |
| **Test Name** | `widgets/gesture_recognizer_factory_with_handlers_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [325] widgets/global_object_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 325 |
| **Test Name** | `widgets/global_object_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [326] widgets/hero_controller_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 326 |
| **Test Name** | `widgets/hero_controller_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [327] widgets/hero_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 327 |
| **Test Name** | `widgets/hero_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [328] widgets/hero_flight_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 328 |
| **Test Name** | `widgets/hero_flight_direction_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [329] widgets/hold_scroll_activity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 329 |
| **Test Name** | `widgets/hold_scroll_activity_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [330] widgets/i_o_s_system_context_menu_item_copy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 330 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_copy_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [331] widgets/i_o_s_system_context_menu_item_custom_test.dart

| Field | Value |
|-------|-------|
| **Index** | 331 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_custom_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [332] widgets/i_o_s_system_context_menu_item_cut_test.dart

| Field | Value |
|-------|-------|
| **Index** | 332 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_cut_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [333] widgets/i_o_s_system_context_menu_item_live_text_test.dart

| Field | Value |
|-------|-------|
| **Index** | 333 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_live_text_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [334] widgets/i_o_s_system_context_menu_item_look_up_test.dart

| Field | Value |
|-------|-------|
| **Index** | 334 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_look_up_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [335] widgets/i_o_s_system_context_menu_item_paste_test.dart

| Field | Value |
|-------|-------|
| **Index** | 335 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_paste_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [336] widgets/i_o_s_system_context_menu_item_search_web_test.dart

| Field | Value |
|-------|-------|
| **Index** | 336 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_search_web_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [337] widgets/i_o_s_system_context_menu_item_select_all_test.dart

| Field | Value |
|-------|-------|
| **Index** | 337 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_select_all_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [338] widgets/i_o_s_system_context_menu_item_share_test.dart

| Field | Value |
|-------|-------|
| **Index** | 338 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_share_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [339] widgets/i_o_s_system_context_menu_item_test.dart

| Field | Value |
|-------|-------|
| **Index** | 339 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [340] widgets/icon_data_property_test.dart

| Field | Value |
|-------|-------|
| **Index** | 340 |
| **Test Name** | `widgets/icon_data_property_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [341] widgets/icon_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 341 |
| **Test Name** | `widgets/icon_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [342] widgets/icon_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 342 |
| **Test Name** | `widgets/icon_theme_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [343] widgets/idle_scroll_activity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 343 |
| **Test Name** | `widgets/idle_scroll_activity_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [344] widgets/ignore_baseline_test.dart

| Field | Value |
|-------|-------|
| **Index** | 344 |
| **Test Name** | `widgets/ignore_baseline_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [345] widgets/image_icon_test.dart

| Field | Value |
|-------|-------|
| **Index** | 345 |
| **Test Name** | `widgets/image_icon_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [346] widgets/img_element_platform_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 346 |
| **Test Name** | `widgets/img_element_platform_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [347] widgets/indexed_slot_test.dart

| Field | Value |
|-------|-------|
| **Index** | 347 |
| **Test Name** | `widgets/indexed_slot_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [348] widgets/inherited_model_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 348 |
| **Test Name** | `widgets/inherited_model_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [349] widgets/inspector_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 349 |
| **Test Name** | `widgets/inspector_button_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [350] widgets/inspector_button_variant_test.dart

| Field | Value |
|-------|-------|
| **Index** | 350 |
| **Test Name** | `widgets/inspector_button_variant_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [351] widgets/inspector_reference_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 351 |
| **Test Name** | `widgets/inspector_reference_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [352] widgets/inspector_selection_test.dart

| Field | Value |
|-------|-------|
| **Index** | 352 |
| **Test Name** | `widgets/inspector_selection_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [353] widgets/inspector_serialization_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 353 |
| **Test Name** | `widgets/inspector_serialization_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [354] widgets/keep_alive_handle_test.dart

| Field | Value |
|-------|-------|
| **Index** | 354 |
| **Test Name** | `widgets/keep_alive_handle_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [355] widgets/keep_alive_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 355 |
| **Test Name** | `widgets/keep_alive_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [356] widgets/key_event_result_test.dart

| Field | Value |
|-------|-------|
| **Index** | 356 |
| **Test Name** | `widgets/key_event_result_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [357] widgets/key_set_test.dart

| Field | Value |
|-------|-------|
| **Index** | 357 |
| **Test Name** | `widgets/key_set_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [358] widgets/keyboard_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 358 |
| **Test Name** | `widgets/keyboard_listener_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [359] widgets/labeled_global_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 359 |
| **Test Name** | `widgets/labeled_global_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [360] widgets/layout_id_test.dart

| Field | Value |
|-------|-------|
| **Index** | 360 |
| **Test Name** | `widgets/layout_id_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [361] widgets/lexical_focus_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 361 |
| **Test Name** | `widgets/lexical_focus_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [362] widgets/live_text_input_status_notifier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 362 |
| **Test Name** | `widgets/live_text_input_status_notifier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [363] widgets/live_text_input_status_test.dart

| Field | Value |
|-------|-------|
| **Index** | 363 |
| **Test Name** | `widgets/live_text_input_status_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [364] widgets/local_history_entry_test.dart

| Field | Value |
|-------|-------|
| **Index** | 364 |
| **Test Name** | `widgets/local_history_entry_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [365] widgets/localizations_resolver_test.dart

| Field | Value |
|-------|-------|
| **Index** | 365 |
| **Test Name** | `widgets/localizations_resolver_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [366] widgets/lock_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 366 |
| **Test Name** | `widgets/lock_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [367] widgets/logical_key_set_test.dart

| Field | Value |
|-------|-------|
| **Index** | 367 |
| **Test Name** | `widgets/logical_key_set_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [368] widgets/lookup_boundary_test.dart

| Field | Value |
|-------|-------|
| **Index** | 368 |
| **Test Name** | `widgets/lookup_boundary_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [369] widgets/matrix4_tween_test.dart

| Field | Value |
|-------|-------|
| **Index** | 369 |
| **Test Name** | `widgets/matrix4_tween_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [370] widgets/matrix_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 370 |
| **Test Name** | `widgets/matrix_transition_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [371] widgets/menu_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 371 |
| **Test Name** | `widgets/menu_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [372] widgets/menu_serializable_shortcut_test.dart

| Field | Value |
|-------|-------|
| **Index** | 372 |
| **Test Name** | `widgets/menu_serializable_shortcut_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [373] widgets/meta_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 373 |
| **Test Name** | `widgets/meta_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [374] widgets/modal_barrier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 374 |
| **Test Name** | `widgets/modal_barrier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [375] widgets/multi_selectable_selection_container_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 375 |
| **Test Name** | `widgets/multi_selectable_selection_container_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [376] widgets/navigation_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 376 |
| **Test Name** | `widgets/navigation_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [377] widgets/navigation_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 377 |
| **Test Name** | `widgets/navigation_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [378] widgets/navigator_pop_handler_test.dart

| Field | Value |
|-------|-------|
| **Index** | 378 |
| **Test Name** | `widgets/navigator_pop_handler_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [379] widgets/nested_scroll_view_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 379 |
| **Test Name** | `widgets/nested_scroll_view_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [380] widgets/nested_scroll_view_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 380 |
| **Test Name** | `widgets/nested_scroll_view_viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [381] widgets/next_focus_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 381 |
| **Test Name** | `widgets/next_focus_action_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [382] widgets/next_focus_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 382 |
| **Test Name** | `widgets/next_focus_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [383] widgets/notifiable_element_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 383 |
| **Test Name** | `widgets/notifiable_element_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [384] widgets/notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 384 |
| **Test Name** | `widgets/notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [385] widgets/numeric_focus_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 385 |
| **Test Name** | `widgets/numeric_focus_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [386] widgets/object_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 386 |
| **Test Name** | `widgets/object_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [387] widgets/options_view_open_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 387 |
| **Test Name** | `widgets/options_view_open_direction_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [388] widgets/ordered_traversal_policy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 388 |
| **Test Name** | `widgets/ordered_traversal_policy_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [389] widgets/orientation_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 389 |
| **Test Name** | `widgets/orientation_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [390] widgets/orientation_test.dart

| Field | Value |
|-------|-------|
| **Index** | 390 |
| **Test Name** | `widgets/orientation_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [391] widgets/overflow_bar_alignment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 391 |
| **Test Name** | `widgets/overflow_bar_alignment_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [392] widgets/overlay_child_layout_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 392 |
| **Test Name** | `widgets/overlay_child_layout_info_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [393] widgets/overlay_child_location_test.dart

| Field | Value |
|-------|-------|
| **Index** | 393 |
| **Test Name** | `widgets/overlay_child_location_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [394] widgets/overlay_portal_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 394 |
| **Test Name** | `widgets/overlay_portal_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [395] widgets/overlay_portal_test.dart

| Field | Value |
|-------|-------|
| **Index** | 395 |
| **Test Name** | `widgets/overlay_portal_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [396] widgets/overlay_route_test.dart

| Field | Value |
|-------|-------|
| **Index** | 396 |
| **Test Name** | `widgets/overlay_route_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [397] widgets/overlay_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 397 |
| **Test Name** | `widgets/overlay_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [398] widgets/overscroll_indicator_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 398 |
| **Test Name** | `widgets/overscroll_indicator_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [399] widgets/overscroll_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 399 |
| **Test Name** | `widgets/overscroll_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [400] widgets/page_metrics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 400 |
| **Test Name** | `widgets/page_metrics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [401] widgets/page_route_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 401 |
| **Test Name** | `widgets/page_route_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [402] widgets/page_test.dart

| Field | Value |
|-------|-------|
| **Index** | 402 |
| **Test Name** | `widgets/page_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [403] widgets/pan_axis_test.dart

| Field | Value |
|-------|-------|
| **Index** | 403 |
| **Test Name** | `widgets/pan_axis_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [404] widgets/paste_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 404 |
| **Test Name** | `widgets/paste_text_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [405] widgets/platform_menu_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 405 |
| **Test Name** | `widgets/platform_menu_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [406] widgets/platform_provided_menu_item_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 406 |
| **Test Name** | `widgets/platform_provided_menu_item_type_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [407] widgets/platform_route_information_provider_test.dart

| Field | Value |
|-------|-------|
| **Index** | 407 |
| **Test Name** | `widgets/platform_route_information_provider_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [408] widgets/platform_selectable_region_context_menu_test.dart

| Field | Value |
|-------|-------|
| **Index** | 408 |
| **Test Name** | `widgets/platform_selectable_region_context_menu_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [409] widgets/platform_view_creation_params_test.dart

| Field | Value |
|-------|-------|
| **Index** | 409 |
| **Test Name** | `widgets/platform_view_creation_params_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

#### [410] widgets/pop_entry_test.dart

| Field | Value |
|-------|-------|
| **Index** | 410 |
| **Test Name** | `widgets/pop_entry_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No - fix upstream transport error first |
| **Description** | Cascade: earlier transport error caused downstream failures |
| **Batch** | 1 |

**Detailed Analysis:** This test failed because an earlier test in the same suite had a transport error. When one test fails with a transport error, the clear-state mechanism fails, causing all subsequent tests to fail with "clear_failed" status. The root cause is NOT in this test script. Fix the upstream transport error to resolve this cascade.

**Fix Description:** No fix needed for this test. Fix the upstream transport error in this suite to prevent the cascade.

**Needs Deeper Analysis:** No - fix upstream transport error

### Suite: hardly_relevant_classes_5_test

**141 issues** — Top: `SCRIPT-LATEINIT` (95), `BRIDGE-INTERPRETED-INSTANCE` (16), `BRIDGE-MISSING-CONSTRUCTOR` (14)

#### [411] widgets/raw_dialog_route_test.dart

| Field | Value |
|-------|-------|
| **Index** | 411 |
| **Test Name** | `widgets/raw_dialog_route_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH-FW` |
| **Immediate Fix Possible** | Yes - add D4.coerceList/coerceMap or UserBridge |
| **Description** | Type mismatch in framework error (bridge coercion gap) |
| **Batch** | 1 |

**Detailed Analysis:** Type mismatch surfaced as a Flutter framework error (not a test failure). The bridge produced a type that Flutter's widget tree couldn't consume (e.g., `List<Object?>` instead of `List<Widget>`). This is typically the generic inference issue (#1). Detail: Runtime Error: Error in generic constructor factory for 'RawDialogRoute': type 'InterpretedFunction' is not a subtype of type '((BuildContext, Animation<double>, Animation<double>) => Widget)?' in typ…

**Fix Description:** Add explicit type annotations in the script (e.g., `<Widget>[...]`) or add type coercion in a UserBridge.

**Needs Deeper Analysis:** No - known generic inference issue

#### [412] widgets/raw_keyboard_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 412 |
| **Test Name** | `widgets/raw_keyboard_listener_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing type/class definition |
| **Batch** | 1 |

**Detailed Analysis:** A type or class referenced in the script is not registered in the bridge. The interpreter cannot resolve it as a variable/constructor. This type needs to be added to the bridge generator configuration or a UserBridge. Detail: Expected: true

**Fix Description:** Add the missing type to the bridge generator configuration (flutterm_config.yaml) or create a UserBridge class for it.

**Needs Deeper Analysis:** No - add to bridge config

#### [413] widgets/raw_menu_overlay_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 413 |
| **Test Name** | `widgets/raw_menu_overlay_info_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes - add constructor to bridge |
| **Description** | Bridge missing constructor (type is not callable) |
| **Batch** | 1 |

**Detailed Analysis:** The bridge has the type registered but it is not callable (no constructor factory). When the script tries to instantiate it with `TypeName(...)`, the interpreter sees a non-callable object. A constructor factory needs to be added. Detail: Expected: true

**Fix Description:** Register a constructor factory for this type in the bridge generator.

**Needs Deeper Analysis:** No - add constructor factory

#### [414] widgets/raw_radio_test.dart

| Field | Value |
|-------|-------|
| **Index** | 414 |
| **Test Name** | `widgets/raw_radio_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe - add UserBridge override |
| **Description** | Native error during bridged constructor/method |
| **Batch** | 1 |

**Detailed Analysis:** A native Dart error occurred during execution of a bridged constructor or method. The bridge correctly dispatched the call, but the Flutter-side implementation threw an error (often due to invalid arguments or type mismatches). A UserBridge override may be needed to validate/transform arguments before the native call. Detail: Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Error in generic constructor factory for 'RawRadio': 'package:flutter/src/widgets/raw_radio.dart': Failed as…

**Fix Description:** Add a UserBridge override that validates/transforms arguments before passing to the native constructor/method. Check Flutter API docs for parameter requirements.

**Needs Deeper Analysis:** Yes - investigate native error cause

#### [415] widgets/redo_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 415 |
| **Test Name** | `widgets/redo_text_intent_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [416] widgets/regular_window_controller_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 416 |
| **Test Name** | `widgets/regular_window_controller_delegate_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [417] widgets/regular_window_controller_linux_test.dart

| Field | Value |
|-------|-------|
| **Index** | 417 |
| **Test Name** | `widgets/regular_window_controller_linux_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [418] widgets/regular_window_controller_mac_o_s_test.dart

| Field | Value |
|-------|-------|
| **Index** | 418 |
| **Test Name** | `widgets/regular_window_controller_mac_o_s_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [419] widgets/regular_window_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 419 |
| **Test Name** | `widgets/regular_window_controller_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [420] widgets/regular_window_controller_win32_test.dart

| Field | Value |
|-------|-------|
| **Index** | 420 |
| **Test Name** | `widgets/regular_window_controller_win32_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [421] widgets/regular_window_test.dart

| Field | Value |
|-------|-------|
| **Index** | 421 |
| **Test Name** | `widgets/regular_window_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [422] widgets/relative_positioned_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 422 |
| **Test Name** | `widgets/relative_positioned_transition_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe - adjust script layout constraints |
| **Description** | Layout overflow or unbounded flex (framework noise) |
| **Batch** | 1 |

**Detailed Analysis:** Flutter layout overflow during test execution. A `RenderFlex` overflowed or received unbounded constraints. This is framework noise that doesn't affect test pass/fail but indicates the script layout could be improved (e.g., wrapping content in `SingleChildScrollView` or `Expanded`). Detail: A RenderFlex overflowed by 4.0 pixels on the bottom.

**Fix Description:** Wrap overflow-prone content in `SingleChildScrollView`, `Expanded`, or `Flexible`. Add `overflow: TextOverflow.ellipsis` where appropriate.

**Needs Deeper Analysis:** No - layout adjustment

#### [423] widgets/render_abstract_layout_builder_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 423 |
| **Test Name** | `widgets/render_abstract_layout_builder_mixin_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [424] widgets/render_nested_scroll_view_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 424 |
| **Test Name** | `widgets/render_nested_scroll_view_viewport_test.dart` |
| **Category** | `INTERPRETER-GENERIC-INFERENCE` |
| **Immediate Fix Possible** | Yes - add explicit type annotations in script |
| **Description** | Known issue #1: generic type inference (List<Object?> vs List<Widget>) |
| **Batch** | 1 |

**Detailed Analysis:** Known D4rt issue #1: generic type inference produces `List<Object?>` instead of the expected specific type (e.g., `List<Widget>`). The interpreter's type inference system doesn't fully propagate generic type parameters. Workaround: add explicit type annotations in the script (e.g., `<Widget>[...]` instead of `[...]`). Detail: type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast

**Fix Description:** Add explicit type annotations in the script where generic lists/maps are constructed (e.g., `<Widget>[child1, child2]` instead of `[child1, child2]`).

**Needs Deeper Analysis:** No - known issue #1, add type annotations

#### [425] widgets/render_object_to_widget_adapter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 425 |
| **Test Name** | `widgets/render_object_to_widget_adapter_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [426] widgets/render_tap_region_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 426 |
| **Test Name** | `widgets/render_tap_region_surface_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [427] widgets/render_tap_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 427 |
| **Test Name** | `widgets/render_tap_region_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [428] widgets/render_tree_root_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 428 |
| **Test Name** | `widgets/render_tree_root_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Native error during bridged method call 'visitAncestorElements' on StatelessElement: LateInitializationError: Field '_children@24042623' has not been initialized.

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [429] widgets/render_two_dimensional_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 429 |
| **Test Name** | `widgets/render_two_dimensional_viewport_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [430] widgets/render_web_image_test.dart

| Field | Value |
|-------|-------|
| **Index** | 430 |
| **Test Name** | `widgets/render_web_image_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [431] widgets/repeat_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 431 |
| **Test Name** | `widgets/repeat_mode_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [432] widgets/replace_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 432 |
| **Test Name** | `widgets/replace_text_intent_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [433] widgets/request_focus_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 433 |
| **Test Name** | `widgets/request_focus_action_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [434] widgets/request_focus_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 434 |
| **Test Name** | `widgets/request_focus_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [435] widgets/restorable_bool_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 435 |
| **Test Name** | `widgets/restorable_bool_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [436] widgets/restorable_date_time_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 436 |
| **Test Name** | `widgets/restorable_date_time_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [437] widgets/restorable_double_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 437 |
| **Test Name** | `widgets/restorable_double_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [438] widgets/restorable_enum_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 438 |
| **Test Name** | `widgets/restorable_enum_n_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes - add to bridge generator or UserBridge |
| **Description** | Bridge missing type/class definition |
| **Batch** | 1 |

**Detailed Analysis:** A type or class referenced in the script is not registered in the bridge. The interpreter cannot resolve it as a variable/constructor. This type needs to be added to the bridge generator configuration or a UserBridge. Detail: Expected: true

**Fix Description:** Add the missing type to the bridge generator configuration (flutterm_config.yaml) or create a UserBridge class for it.

**Needs Deeper Analysis:** No - add to bridge config

#### [439] widgets/restorable_int_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 439 |
| **Test Name** | `widgets/restorable_int_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [440] widgets/restorable_listenable_test.dart

| Field | Value |
|-------|-------|
| **Index** | 440 |
| **Test Name** | `widgets/restorable_listenable_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [441] widgets/restorable_num_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 441 |
| **Test Name** | `widgets/restorable_num_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [442] widgets/restorable_num_test.dart

| Field | Value |
|-------|-------|
| **Index** | 442 |
| **Test Name** | `widgets/restorable_num_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [443] widgets/restorable_route_future_test.dart

| Field | Value |
|-------|-------|
| **Index** | 443 |
| **Test Name** | `widgets/restorable_route_future_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [444] widgets/restorable_string_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 444 |
| **Test Name** | `widgets/restorable_string_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [445] widgets/root_element_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 445 |
| **Test Name** | `widgets/root_element_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [446] widgets/root_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 446 |
| **Test Name** | `widgets/root_render_object_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [447] widgets/route_information_reporting_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 447 |
| **Test Name** | `widgets/route_information_reporting_type_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [448] widgets/route_information_test.dart

| Field | Value |
|-------|-------|
| **Index** | 448 |
| **Test Name** | `widgets/route_information_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [449] widgets/route_pop_disposition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 449 |
| **Test Name** | `widgets/route_pop_disposition_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [450] widgets/route_transition_record_test.dart

| Field | Value |
|-------|-------|
| **Index** | 450 |
| **Test Name** | `widgets/route_transition_record_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [451] widgets/router_config_test.dart

| Field | Value |
|-------|-------|
| **Index** | 451 |
| **Test Name** | `widgets/router_config_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [452] widgets/scroll_activity_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 452 |
| **Test Name** | `widgets/scroll_activity_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [453] widgets/scroll_activity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 453 |
| **Test Name** | `widgets/scroll_activity_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [454] widgets/scroll_context_test.dart

| Field | Value |
|-------|-------|
| **Index** | 454 |
| **Test Name** | `widgets/scroll_context_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [455] widgets/scroll_deceleration_rate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 455 |
| **Test Name** | `widgets/scroll_deceleration_rate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [456] widgets/scroll_drag_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 456 |
| **Test Name** | `widgets/scroll_drag_controller_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [457] widgets/scroll_end_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 457 |
| **Test Name** | `widgets/scroll_end_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [458] widgets/scroll_hold_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 458 |
| **Test Name** | `widgets/scroll_hold_controller_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [459] widgets/scroll_increment_details_test.dart

| Field | Value |
|-------|-------|
| **Index** | 459 |
| **Test Name** | `widgets/scroll_increment_details_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [460] widgets/scroll_increment_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 460 |
| **Test Name** | `widgets/scroll_increment_type_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [461] widgets/scroll_metrics_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 461 |
| **Test Name** | `widgets/scroll_metrics_notification_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [462] widgets/scroll_notification_observer_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 462 |
| **Test Name** | `widgets/scroll_notification_observer_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [463] widgets/scroll_notification_observer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 463 |
| **Test Name** | `widgets/scroll_notification_observer_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [464] widgets/scroll_position_alignment_policy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 464 |
| **Test Name** | `widgets/scroll_position_alignment_policy_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [465] widgets/scroll_position_with_single_context_test.dart

| Field | Value |
|-------|-------|
| **Index** | 465 |
| **Test Name** | `widgets/scroll_position_with_single_context_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [466] widgets/scroll_start_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 466 |
| **Test Name** | `widgets/scroll_start_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [467] widgets/scroll_to_document_boundary_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 467 |
| **Test Name** | `widgets/scroll_to_document_boundary_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [468] widgets/scroll_update_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 468 |
| **Test Name** | `widgets/scroll_update_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [469] widgets/scroll_view_keyboard_dismiss_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 469 |
| **Test Name** | `widgets/scroll_view_keyboard_dismiss_behavior_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes - fix bridge type resolution or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of typed widget |
| **Batch** | 1 |

**Detailed Analysis:** The bridge returns an `InterpretedInstance` instead of the expected typed widget or object. The test assertion `Expected Widget but got InterpretedInstance` indicates the bridge type resolution system did not properly wrap or cast the D4rt-interpreted object back to a Flutter-native type. A UserBridge with proper type casting is needed. Detail: Expected: true

**Fix Description:** Add a UserBridge for the affected class with proper type casting in `overrideConstructor` or `overrideMethodXxx` to return the correct native type.

**Needs Deeper Analysis:** Maybe - need to identify which bridge type resolution fails

#### [470] widgets/scroll_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 470 |
| **Test Name** | `widgets/scroll_view_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [471] widgets/scrollable_details_test.dart

| Field | Value |
|-------|-------|
| **Index** | 471 |
| **Test Name** | `widgets/scrollable_details_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [472] widgets/scrollbar_orientation_test.dart

| Field | Value |
|-------|-------|
| **Index** | 472 |
| **Test Name** | `widgets/scrollbar_orientation_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _OrientedPanelState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [473] widgets/scrollbar_painter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 473 |
| **Test Name** | `widgets/scrollbar_painter_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [474] widgets/select_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 474 |
| **Test Name** | `widgets/select_action_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [475] widgets/select_all_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 475 |
| **Test Name** | `widgets/select_all_text_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [476] widgets/select_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 476 |
| **Test Name** | `widgets/select_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [477] widgets/selectable_region_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 477 |
| **Test Name** | `widgets/selectable_region_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [478] widgets/selection_container_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 478 |
| **Test Name** | `widgets/selection_container_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [479] widgets/selection_details_test.dart

| Field | Value |
|-------|-------|
| **Index** | 479 |
| **Test Name** | `widgets/selection_details_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [480] widgets/semantics_gesture_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 480 |
| **Test Name** | `widgets/semantics_gesture_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [481] widgets/shortcut_activator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 481 |
| **Test Name** | `widgets/shortcut_activator_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [482] widgets/shortcut_manager_test.dart

| Field | Value |
|-------|-------|
| **Index** | 482 |
| **Test Name** | `widgets/shortcut_manager_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _loggingManager (Original error: LateInitializationError: Late variable '_loggingManager' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [483] widgets/shortcut_map_property_test.dart

| Field | Value |
|-------|-------|
| **Index** | 483 |
| **Test Name** | `widgets/shortcut_map_property_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [484] widgets/shortcut_registry_entry_test.dart

| Field | Value |
|-------|-------|
| **Index** | 484 |
| **Test Name** | `widgets/shortcut_registry_entry_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [485] widgets/shortcut_serialization_test.dart

| Field | Value |
|-------|-------|
| **Index** | 485 |
| **Test Name** | `widgets/shortcut_serialization_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [486] widgets/single_activator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 486 |
| **Test Name** | `widgets/single_activator_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [487] widgets/size_changed_layout_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 487 |
| **Test Name** | `widgets/size_changed_layout_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [488] widgets/sliver_animated_grid_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 488 |
| **Test Name** | `widgets/sliver_animated_grid_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [489] widgets/sliver_animated_list_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 489 |
| **Test Name** | `widgets/sliver_animated_list_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [490] widgets/sliver_child_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 490 |
| **Test Name** | `widgets/sliver_child_builder_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [491] widgets/sliver_child_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 491 |
| **Test Name** | `widgets/sliver_child_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [492] widgets/sliver_multi_box_adaptor_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 492 |
| **Test Name** | `widgets/sliver_multi_box_adaptor_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [493] widgets/sliver_multi_box_adaptor_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 493 |
| **Test Name** | `widgets/sliver_multi_box_adaptor_widget_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [494] widgets/sliver_reorderable_list_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 494 |
| **Test Name** | `widgets/sliver_reorderable_list_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [495] widgets/slotted_container_render_object_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 495 |
| **Test Name** | `widgets/slotted_container_render_object_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [496] widgets/slotted_multi_child_render_object_widget_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 496 |
| **Test Name** | `widgets/slotted_multi_child_render_object_widget_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [497] widgets/slotted_multi_child_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 497 |
| **Test Name** | `widgets/slotted_multi_child_render_object_widget_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [498] widgets/slotted_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 498 |
| **Test Name** | `widgets/slotted_render_object_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [499] widgets/snapshot_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 499 |
| **Test Name** | `widgets/snapshot_mode_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [500] widgets/standard_component_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 500 |
| **Test Name** | `widgets/standard_component_type_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [501] widgets/static_selection_container_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 501 |
| **Test Name** | `widgets/static_selection_container_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [502] widgets/text_selection_gesture_detector_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 502 |
| **Test Name** | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [503] widgets/toolbar_items_parent_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 503 |
| **Test Name** | `widgets/toolbar_items_parent_data_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [504] widgets/toolbar_options_test.dart

| Field | Value |
|-------|-------|
| **Index** | 504 |
| **Test Name** | `widgets/toolbar_options_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [505] widgets/tooltip_position_context_test.dart

| Field | Value |
|-------|-------|
| **Index** | 505 |
| **Test Name** | `widgets/tooltip_position_context_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [506] widgets/tooltip_window_controller_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 506 |
| **Test Name** | `widgets/tooltip_window_controller_delegate_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [507] widgets/tooltip_window_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 507 |
| **Test Name** | `widgets/tooltip_window_controller_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [508] widgets/tooltip_window_test.dart

| Field | Value |
|-------|-------|
| **Index** | 508 |
| **Test Name** | `widgets/tooltip_window_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [509] widgets/transition_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 509 |
| **Test Name** | `widgets/transition_delegate_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe - add explicit getter in script or UserBridge override |
| **Description** | Interpreter cannot resolve State/Delegate/Controller property access |
| **Batch** | 1 |

**Detailed Analysis:** The interpreter cannot resolve property access on State/Delegate/Controller subclasses. When the script accesses `this.widget`, `this.controller`, or similar inherited State properties, the interpreter raises "Undefined variable/property" because it doesn't have the D4rt-side representation of the State mixin properties. An explicit getter override in the script or a UserBridge for the State class is needed. Detail: Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _DefaultDemoPageState.)

**Fix Description:** Add explicit getter methods in the script's State subclass (e.g., `Widget get myWidget => widget;`) or add a UserBridge for the State class.

**Needs Deeper Analysis:** Maybe - determine if script or interpreter fix needed

#### [510] widgets/transpose_characters_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 510 |
| **Test Name** | `widgets/transpose_characters_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [511] widgets/traversal_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 511 |
| **Test Name** | `widgets/traversal_direction_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [512] widgets/traversal_edge_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 512 |
| **Test Name** | `widgets/traversal_edge_behavior_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Batch** | 1 |

**Detailed Analysis:** A class exists in the bridge but its constructor is either missing or does not accept the provided arguments. The bridge generator did not emit a constructor factory for this class/constructor variant. Detail: Expected: true

**Fix Description:** Add the constructor variant to the bridge generator configuration or create a UserBridge `overrideConstructor`.

**Needs Deeper Analysis:** No - add constructor to bridge

#### [513] widgets/tree_sliver_state_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 513 |
| **Test Name** | `widgets/tree_sliver_state_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [514] widgets/two_dimensional_child_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 514 |
| **Test Name** | `widgets/two_dimensional_child_builder_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [515] widgets/two_dimensional_child_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 515 |
| **Test Name** | `widgets/two_dimensional_child_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [516] widgets/two_dimensional_child_list_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 516 |
| **Test Name** | `widgets/two_dimensional_child_list_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [517] widgets/two_dimensional_child_manager_test.dart

| Field | Value |
|-------|-------|
| **Index** | 517 |
| **Test Name** | `widgets/two_dimensional_child_manager_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [518] widgets/two_dimensional_scrollable_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 518 |
| **Test Name** | `widgets/two_dimensional_scrollable_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [519] widgets/two_dimensional_viewport_parent_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 519 |
| **Test Name** | `widgets/two_dimensional_viewport_parent_data_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [520] widgets/undo_history_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 520 |
| **Test Name** | `widgets/undo_history_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [521] widgets/undo_history_value_test.dart

| Field | Value |
|-------|-------|
| **Index** | 521 |
| **Test Name** | `widgets/undo_history_value_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [522] widgets/undo_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 522 |
| **Test Name** | `widgets/undo_text_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [523] widgets/unfocus_disposition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 523 |
| **Test Name** | `widgets/unfocus_disposition_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [524] widgets/update_selection_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 524 |
| **Test Name** | `widgets/update_selection_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [525] widgets/user_scroll_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 525 |
| **Test Name** | `widgets/user_scroll_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [526] widgets/viewport_element_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 526 |
| **Test Name** | `widgets/viewport_element_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [527] widgets/viewport_notification_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 527 |
| **Test Name** | `widgets/viewport_notification_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [528] widgets/void_callback_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 528 |
| **Test Name** | `widgets/void_callback_action_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [529] widgets/void_callback_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 529 |
| **Test Name** | `widgets/void_callback_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [530] widgets/weak_map_test.dart

| Field | Value |
|-------|-------|
| **Index** | 530 |
| **Test Name** | `widgets/weak_map_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [531] widgets/web_browser_detection_test.dart

| Field | Value |
|-------|-------|
| **Index** | 531 |
| **Test Name** | `widgets/web_browser_detection_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [532] widgets/widget_inspector_service_extensions_test.dart

| Field | Value |
|-------|-------|
| **Index** | 532 |
| **Test Name** | `widgets/widget_inspector_service_extensions_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [533] widgets/widget_inspector_service_test.dart

| Field | Value |
|-------|-------|
| **Index** | 533 |
| **Test Name** | `widgets/widget_inspector_service_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [534] widgets/widget_order_traversal_policy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 534 |
| **Test Name** | `widgets/widget_order_traversal_policy_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [535] widgets/widget_state_border_side_test.dart

| Field | Value |
|-------|-------|
| **Index** | 535 |
| **Test Name** | `widgets/widget_state_border_side_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [536] widgets/widget_state_color_test.dart

| Field | Value |
|-------|-------|
| **Index** | 536 |
| **Test Name** | `widgets/widget_state_color_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [537] widgets/widget_state_mapper_test.dart

| Field | Value |
|-------|-------|
| **Index** | 537 |
| **Test Name** | `widgets/widget_state_mapper_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [538] widgets/widget_state_mouse_cursor_test.dart

| Field | Value |
|-------|-------|
| **Index** | 538 |
| **Test Name** | `widgets/widget_state_mouse_cursor_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [539] widgets/widget_state_outlined_border_test.dart

| Field | Value |
|-------|-------|
| **Index** | 539 |
| **Test Name** | `widgets/widget_state_outlined_border_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [540] widgets/widget_state_property_all_test.dart

| Field | Value |
|-------|-------|
| **Index** | 540 |
| **Test Name** | `widgets/widget_state_property_all_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [541] widgets/widget_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 541 |
| **Test Name** | `widgets/widget_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [542] widgets/widget_state_text_style_test.dart

| Field | Value |
|-------|-------|
| **Index** | 542 |
| **Test Name** | `widgets/widget_state_text_style_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [543] widgets/widget_states_constraint_test.dart

| Field | Value |
|-------|-------|
| **Index** | 543 |
| **Test Name** | `widgets/widget_states_constraint_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

#### [544] widgets/window_positioner_anchor_test.dart

| Field | Value |
|-------|-------|
| **Index** | 544 |
| **Test Name** | `widgets/window_positioner_anchor_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 1 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [545] widgets/window_positioner_constraint_adjustment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 545 |
| **Test Name** | `widgets/window_positioner_constraint_adjustment_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 1 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [546] widgets/window_positioner_test.dart

| Field | Value |
|-------|-------|
| **Index** | 546 |
| **Test Name** | `widgets/window_positioner_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 1 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [547] widgets/window_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 547 |
| **Test Name** | `widgets/window_scope_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH-FW` |
| **Immediate Fix Possible** | Yes - add D4.coerceList/coerceMap or UserBridge |
| **Description** | Type mismatch in framework error (bridge coercion gap) |
| **Batch** | 1 |

**Detailed Analysis:** Type mismatch surfaced as a Flutter framework error (not a test failure). The bridge produced a type that Flutter's widget tree couldn't consume (e.g., `List<Object?>` instead of `List<Widget>`). This is typically the generic inference issue (#1). Detail: type 'InterpretedInstance' is not a subtype of type 'Widget' in type cast

**Fix Description:** Add explicit type annotations in the script (e.g., `<Widget>[...]`) or add type coercion in a UserBridge.

**Needs Deeper Analysis:** No - known generic inference issue

#### [548] widgets/windowing_owner_linux_test.dart

| Field | Value |
|-------|-------|
| **Index** | 548 |
| **Test Name** | `widgets/windowing_owner_linux_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 1 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [549] widgets/windowing_owner_mac_o_s_test.dart

| Field | Value |
|-------|-------|
| **Index** | 549 |
| **Test Name** | `widgets/windowing_owner_mac_o_s_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 1 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [550] widgets/windowing_owner_test.dart

| Field | Value |
|-------|-------|
| **Index** | 550 |
| **Test Name** | `widgets/windowing_owner_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes - add UserBridge generic constructor override |
| **Description** | Bridge generic constructor factory error |
| **Batch** | 1 |

**Detailed Analysis:** The bridge generic constructor factory failed. When the bridge tries to instantiate a generic class (e.g., `Tween<T>`), it cannot resolve the type parameter correctly, resulting in a null check failure. A UserBridge `overrideConstructor` method is needed to handle generic type parameters explicitly. Detail: Expected: true

**Fix Description:** Add a UserBridge `overrideConstructor` that handles generic type parameters explicitly, constructing the correct typed instance.

**Needs Deeper Analysis:** No - known UserBridge pattern

#### [551] widgets/windowing_owner_win32_test.dart

| Field | Value |
|-------|-------|
| **Index** | 551 |
| **Test Name** | `widgets/windowing_owner_win32_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | Yes - refactor script to avoid late fields or use nullable + null-check |
| **Description** | Script uses late variables; interpreter cannot resolve late initialization |
| **Batch** | 1 |

**Detailed Analysis:** The test script uses `late` variable declarations which the D4rt interpreter cannot properly initialize. The interpreter raises `LateInitializationError` or `Undefined variable` for late fields accessed before assignment. Detail: Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being assigned.)

**Fix Description:** Refactor script to replace `late` variable declarations with nullable variables + null-check patterns, or initialize variables in the constructor/initState.

**Needs Deeper Analysis:** No - straightforward refactoring

