# Error Analysis: 20260411-1207-issue-analysis

Generated: 2026-04-11 (regenerated with batches-of-5 and proper fix descriptions)

## Run Metadata

| Field | Value |
|-------|-------|
| Run ID | `20260411-1207-issue-analysis` |
| Revision | `4ce8091c` |
| Suites | 8 (essential, important, secondary, hr1-hr5) |
| Test Suite Batches | 2 (Batch 0: suites 0-4, Batch 1: suites 5-7) |
| Total Issues | 551 |
| Categories | 29 |
| Document Batches | 111 (groups of 5 issues each) |
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

### Key Findings — Proper Fixes Required

1. **Transport cascades (45%)**: Fix the 2 root transport errors in the HTTP test runner layer. All 249 cascades resolve automatically.
2. **`late` variable support (19%)**: Implement `late` field semantics in the D4rt interpreter — track initialization state, execute initializer on first access.
3. **Bridge gaps (15%)**: Fix the bridge generator to emit missing constructors, handle return-type coercion (unwrap InterpretedInstance), and add proper generic constructor factories.
4. **Layout handling (12%)**: Fix the interpreter's constraint propagation and flex layout resolution to match native Flutter behavior.
5. **Interpreter fixes (6%)**: Fix State property resolution through mixin chains, improve generic type inference (Issue #1), and verify Bug-79 switch fix covers all edge cases.

### Category Reference

| Category | Count | Proper Fix |
|----------|------:|------------|
| `TRANSPORT-CASCADE` | 249 | Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2... |
| `SCRIPT-LATEINIT` | 106 | Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and ex... |
| `FW-LAYOUT-CONSTRAINT` | 30 | Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate const... |
| `BRIDGE-INTERPRETED-INSTANCE` | 28 | Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper... |
| `FW-LAYOUT-OVERFLOW` | 27 | Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive pr... |
| `INTERPRETER-STATE-ACCESS` | 17 | Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inher... |
| `BRIDGE-MISSING-CONSTRUCTOR` | 15 | Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the construc... |
| `BRIDGE-NATIVE-ERROR` | 11 | Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in... |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 9 | Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge ge... |
| `SCRIPT-TIMEOUT` | 9 | Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpret... |
| `BRIDGE-MISSING-TYPE` | 6 | Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file. |
| `BRIDGE-MISSING-METHOD` | 4 | Add the missing method to the bridge class definition. Update the bridge generator to emit the method, or add a UserBrid... |
| `FW-ASSERTION` | 4 | Investigate and fix the specific Flutter assertion trigger. The interpreter's widget lifecycle management may need adjus... |
| `INTERPRETER-NULL-INVOKE` | 4 | Fix the interpreter's null-safety checking for method invocations. Add proper null-check propagation before method dispa... |
| `BRIDGE-NOT-CALLABLE` | 4 | Add the missing constructor to the bridge so the type becomes callable. Update bridge generator to emit constructors for... |
| `INTERPRETER-SWITCH` | 4 | Fix the interpreter's switch expression exhaustiveness checking to handle sealed class hierarchies and enum values corre... |
| `FW-OTHER` | 4 | Investigate the specific framework error and fix the root cause in the interpreter or bridge layer. |
| `BRIDGE-TYPE-MISMATCH-FW` | 3 | Fix the bridge generator's type coercion to handle framework collection types. Add `D4.coerceList<T>()` / `D4.coerceMap<... |
| `INTERPRETER-GENERIC-INFERENCE` | 2 | Fix the interpreter's generic type inference (Issue #1) so that `List<Widget>` is inferred instead of `List<Object?>`. I... |
| `BRIDGE-TYPE-MISMATCH` | 2 | Fix the bridge generator's return-type coercion for the specific type mismatch. Add proper type mapping in the bridge ge... |
| `TRANSPORT-ERROR` | 2 | Fix the HTTP transport layer to handle the specific failure mode. Debug the server-side test runner endpoint to identify... |
| `INTERPRETER-UNSUPPORTED` | 2 | Implement the missing operation in the interpreter or add the required bridge support. |
| `FW-PROGRESS-BAR` | 2 | Fix the test script's progress bar value to be within [0.0, 1.0]. This is a script value error. |
| `BRIDGE-MISSING-PROPERTY` | 2 | Add the missing property to the bridge class definition. Update the bridge generator to emit the getter/setter. |
| `SCRIPT-GLOBALKEY` | 1 | Fix the test script to use unique GlobalKey instances per widget. This is a script bug, not an interpreter issue. |
| `INTERPRETER-BAD-STATE` | 1 | Investigate and fix the specific bad-state trigger in the interpreter's execution model. |
| `INTERPRETER-UNDEFINED` | 1 | Fix the interpreter's variable/property resolution for the specific undefined symbol. Check bridge coverage. |
| `INTERPRETER-INDEX-ERROR` | 1 | Fix the interpreter's bounds checking for indexed access. The interpreter should match Dart's RangeError semantics. |
| `INTERPRETER-NULL-ACCESS` | 1 | Fix the interpreter's null-safety propagation for property access chains. |

### Known D4rt Limitations Affecting Tests

| ID | Limitation | Impact | Proper Fix |
|------|-----------|--------|------------|
| #1 | Generic type inference (`List<Object?>` vs `List<Widget>`) | 2 FW errors | Fix interpreter's type constraint solver to infer correct generic types |
| #2 | `int.roundToDouble()` not bridged | Minor | Add `roundToDouble()` to the `int` bridge class |
| Bug-79 | Non-exhaustive switch on sealed subclass | 4 failures (**FIXED**) | Already fixed in interpreter. Verify remaining edge cases |
| Lim-3 | Isolates not supported | Scripts using isolates fail | Implement isolate support in interpreter (long-term) or add bridge for common isolate patterns |
| Bug-14 | Records not supported | Minor | Implement Dart 3 record support in interpreter |

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

## Batch-0

Issues 1–5 of 551

#### Issue 1: cupertino/controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 1 |
| **Test Name** | `cupertino/controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `essential_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/controls_test.dart` triggered 5 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 2: cupertino/form_test.dart

| Field | Value |
|-------|-------|
| **Index** | 2 |
| **Test Name** | `cupertino/form_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `essential_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/form_test.dart` triggered 17 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 3: cupertino/textfield_test.dart

| Field | Value |
|-------|-------|
| **Index** | 3 |
| **Test Name** | `cupertino/textfield_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `essential_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/textfield_test.dart` triggered 13 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 4: rendering/viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 4 |
| **Test Name** | `rendering/viewport_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `essential_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/viewport_test.dart` triggered 4 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 5: widgets/slidetransition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 5 |
| **Test Name** | `widgets/slidetransition_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes — add method to bridge generator |
| **Description** | Bridge missing method implementation |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/slidetransition_test.dart` calls a method that is not emitted in the bridge class. The bridge generator must add this method.

**Fix Description (Proper Fix):**

Add the missing method to the bridge class definition. Update the bridge generator to emit the method, or add a UserBridge override.

**Needs Deeper Analysis:** No — add method to bridge generator

---

## Batch-1

Issues 6–10 of 551

#### Issue 6: widgets/sliverlist_test.dart

| Field | Value |
|-------|-------|
| **Index** | 6 |
| **Test Name** | `widgets/sliverlist_test.dart` |
| **Category** | `SCRIPT-GLOBALKEY` |
| **Immediate Fix Possible** | Yes — fix script to use unique GlobalKeys |
| **Description** | Script bug: duplicate GlobalKey |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliverlist_test.dart` creates duplicate GlobalKey instances in the widget tree. This is a script-level bug that also fails in native Flutter.

**Fix Description (Proper Fix):**

Fix the test script to use unique GlobalKey instances per widget. This is a script bug, not an interpreter issue.

**Needs Deeper Analysis:** No — script bug, straightforward fix

#### Issue 7: widgets/table_test.dart

| Field | Value |
|-------|-------|
| **Index** | 7 |
| **Test Name** | `widgets/table_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe — investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/table_test.dart` triggered a Flutter framework assertion. The interpreter's widget lifecycle or state management violates a framework invariant.

**Fix Description (Proper Fix):**

Investigate and fix the specific Flutter assertion trigger. The interpreter's widget lifecycle management may need adjustment to satisfy framework invariants.

**Needs Deeper Analysis:** Yes — investigate specific assertion

#### Issue 8: widgets/nestedscrollview_test.dart

| Field | Value |
|-------|-------|
| **Index** | 8 |
| **Test Name** | `widgets/nestedscrollview_test.dart` |
| **Category** | `INTERPRETER-GENERIC-INFERENCE` |
| **Immediate Fix Possible** | No — requires type solver improvement (Issue #1) |
| **Description** | Generic type inference Issue #1 (`List<Object?>` vs `List<Widget>`) |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/nestedscrollview_test.dart` fails due to generic type inference (Issue #1): the interpreter infers `List<Object?>` instead of `List<Widget>`. The interpreter's type constraint solver must be improved.

**Fix Description (Proper Fix):**

Fix the interpreter's generic type inference (Issue #1) so that `List<Widget>` is inferred instead of `List<Object?>`. Improve the type constraint solver in the interpreter.

**Needs Deeper Analysis:** Yes — Issue #1, type solver improvement

#### Issue 9: material/refreshindicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 9 |
| **Test Name** | `material/refreshindicator_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/refreshindicator_test.dart` triggered 13 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 10: material/animatedicon_test.dart

| Field | Value |
|-------|-------|
| **Index** | 10 |
| **Test Name** | `material/animatedicon_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/animatedicon_test.dart` triggered 1 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-2

Issues 11–15 of 551

#### Issue 11: widgets/actions_test.dart

| Field | Value |
|-------|-------|
| **Index** | 11 |
| **Test Name** | `widgets/actions_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/actions_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_dispatcher` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 12: animation/tweensequence_test.dart

| Field | Value |
|-------|-------|
| **Index** | 12 |
| **Test Name** | `animation/tweensequence_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `animation/tweensequence_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 13: services/codecs_test.dart

| Field | Value |
|-------|-------|
| **Index** | 13 |
| **Test Name** | `services/codecs_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes — add type to bridge generator configuration |
| **Description** | Bridge missing type/class definition |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `services/codecs_test.dart` references a type that has no bridge definition. The type must be added to the bridge generator's module configuration.

**Fix Description (Proper Fix):**

Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file.

**Needs Deeper Analysis:** No — add type to bridge configuration

#### Issue 14: services/channels_test.dart

| Field | Value |
|-------|-------|
| **Index** | 14 |
| **Test Name** | `services/channels_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH` |
| **Immediate Fix Possible** | Yes — fix bridge type mapping |
| **Description** | Type mismatch (bridge type mapping gap) |
| **Suite Batch** | 0 |
| **Suite** | `important_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `services/channels_test.dart` fails due to a type mismatch in a bridge return value or argument. The bridge generator's type mapping is incomplete for this type.

**Fix Description (Proper Fix):**

Fix the bridge generator's return-type coercion for the specific type mismatch. Add proper type mapping in the bridge generator.

**Needs Deeper Analysis:** No — fix bridge type mapping

#### Issue 15: cupertino/cupertino_secondary_test.dart

| Field | Value |
|-------|-------|
| **Index** | 15 |
| **Test Name** | `cupertino/cupertino_secondary_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_secondary_test.dart` triggered 3 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-3

Issues 16–20 of 551

#### Issue 16: cupertino/cupertino_form_scroll_test.dart

| Field | Value |
|-------|-------|
| **Index** | 16 |
| **Test Name** | `cupertino/cupertino_form_scroll_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_form_scroll_test.dart` triggered 4 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 17: cupertino/cupertino_controls_advanced_test.dart

| Field | Value |
|-------|-------|
| **Index** | 17 |
| **Test Name** | `cupertino/cupertino_controls_advanced_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_controls_advanced_test.dart` triggered 4 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 18: cupertino/cupertino_sections_test.dart

| Field | Value |
|-------|-------|
| **Index** | 18 |
| **Test Name** | `cupertino/cupertino_sections_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_sections_test.dart` triggered 5 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 19: cupertino/cupertino_tabbar_scaffold_test.dart

| Field | Value |
|-------|-------|
| **Index** | 19 |
| **Test Name** | `cupertino/cupertino_tabbar_scaffold_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_tabbar_scaffold_test.dart` triggered 9 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 20: semantics/semantics_config_test.dart

| Field | Value |
|-------|-------|
| **Index** | 20 |
| **Test Name** | `semantics/semantics_config_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH` |
| **Immediate Fix Possible** | Yes — fix bridge type mapping |
| **Description** | Type mismatch (bridge type mapping gap) |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `semantics/semantics_config_test.dart` fails due to a type mismatch in a bridge return value or argument. The bridge generator's type mapping is incomplete for this type.

**Fix Description (Proper Fix):**

Fix the bridge generator's return-type coercion for the specific type mismatch. Add proper type mapping in the bridge generator.

**Needs Deeper Analysis:** No — fix bridge type mapping

---

## Batch-4

Issues 21–25 of 551

#### Issue 21: widgets/gesture_detector_adv_test.dart

| Field | Value |
|-------|-------|
| **Index** | 21 |
| **Test Name** | `widgets/gesture_detector_adv_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/gesture_detector_adv_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 22: widgets/layout_builder_adv_test.dart

| Field | Value |
|-------|-------|
| **Index** | 22 |
| **Test Name** | `widgets/layout_builder_adv_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/layout_builder_adv_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 23: widgets/scroll_position_types_test.dart

| Field | Value |
|-------|-------|
| **Index** | 23 |
| **Test Name** | `widgets/scroll_position_types_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_position_types_test.dart` triggered 13 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 24: widgets/scroll_controllers_types_test.dart

| Field | Value |
|-------|-------|
| **Index** | 24 |
| **Test Name** | `widgets/scroll_controllers_types_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_controllers_types_test.dart` triggered 13 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 25: cupertino/cupertino_text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 25 |
| **Test Name** | `cupertino/cupertino_text_selection_controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_text_selection_controls_test.dart` triggered 9 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-5

Issues 26–30 of 551

#### Issue 26: dart_ui/ztmp_path_metrics_access_test.dart

| Field | Value |
|-------|-------|
| **Index** | 26 |
| **Test Name** | `dart_ui/ztmp_path_metrics_access_test.dart` |
| **Category** | `INTERPRETER-BAD-STATE` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Bad state error in interpreter |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/ztmp_path_metrics_access_test.dart` triggers a bad-state error in the interpreter. The interpreter's execution state machine has an edge case.

**Fix Description (Proper Fix):**

Investigate and fix the specific bad-state trigger in the interpreter's execution model.

**Needs Deeper Analysis:** Yes — interpreter state machine investigation

#### Issue 27: dart_ui/scene_test.dart

| Field | Value |
|-------|-------|
| **Index** | 27 |
| **Test Name** | `dart_ui/scene_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe — investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/scene_test.dart` triggered a Flutter framework assertion. The interpreter's widget lifecycle or state management violates a framework invariant.

**Fix Description (Proper Fix):**

Investigate and fix the specific Flutter assertion trigger. The interpreter's widget lifecycle management may need adjustment to satisfy framework invariants.

**Needs Deeper Analysis:** Yes — investigate specific assertion

#### Issue 28: dart_ui/semantics_action_event_test.dart

| Field | Value |
|-------|-------|
| **Index** | 28 |
| **Test Name** | `dart_ui/semantics_action_event_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/semantics_action_event_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 29: dart_ui/string_attribute_test.dart

| Field | Value |
|-------|-------|
| **Index** | 29 |
| **Test Name** | `dart_ui/string_attribute_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/string_attribute_test.dart` triggered 1 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 30: dart_ui/target_image_size_test.dart

| Field | Value |
|-------|-------|
| **Index** | 30 |
| **Test Name** | `dart_ui/target_image_size_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/target_image_size_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-6

Issues 31–35 of 551

#### Issue 31: gestures/vertical_multi_drag_gesture_recognizer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 31 |
| **Test Name** | `gestures/vertical_multi_drag_gesture_recognizer_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `gestures/vertical_multi_drag_gesture_recognizer_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 32: material/scaffold_messenger_test.dart

| Field | Value |
|-------|-------|
| **Index** | 32 |
| **Test Name** | `material/scaffold_messenger_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/scaffold_messenger_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 33: material/text_button_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 33 |
| **Test Name** | `material/text_button_theme_data_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe — fix null-check before dispatch |
| **Description** | Method invocation on null — interpreter null-check gap |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/text_button_theme_data_test.dart` invokes a method on null. The interpreter's null-safety check before method dispatch is missing.

**Fix Description (Proper Fix):**

Fix the interpreter's null-safety checking for method invocations. Add proper null-check propagation before method dispatch.

**Needs Deeper Analysis:** Maybe — check script null safety

#### Issue 34: material/text_selection_toolbar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 34 |
| **Test Name** | `material/text_selection_toolbar_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/text_selection_toolbar_test.dart` triggered 4 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 35: material/text_selection_toolbar_text_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 35 |
| **Test Name** | `material/text_selection_toolbar_text_button_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/text_selection_toolbar_text_button_test.dart` triggered 4 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-7

Issues 36–40 of 551

#### Issue 36: painting/decoration_image_painter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 36 |
| **Test Name** | `painting/decoration_image_painter_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `painting/decoration_image_painter_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 37: painting/image_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 37 |
| **Test Name** | `painting/image_info_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `painting/image_info_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 38: rendering/box_hit_test_result_test.dart

| Field | Value |
|-------|-------|
| **Index** | 38 |
| **Test Name** | `rendering/box_hit_test_result_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/box_hit_test_result_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 39: rendering/custom_painter_semantics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 39 |
| **Test Name** | `rendering/custom_painter_semantics_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/custom_painter_semantics_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 40: rendering/platform_view_layer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 40 |
| **Test Name** | `rendering/platform_view_layer_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/platform_view_layer_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-8

Issues 41–45 of 551

#### Issue 41: rendering/relayout_when_system_fonts_change_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 41 |
| **Test Name** | `rendering/relayout_when_system_fonts_change_mixin_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/relayout_when_system_fonts_change_mixin_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 42: rendering/render_absorb_pointer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 42 |
| **Test Name** | `rendering/render_absorb_pointer_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_absorb_pointer_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 43: rendering/render_aligning_shifted_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 43 |
| **Test Name** | `rendering/render_aligning_shifted_box_test.dart` |
| **Category** | `INTERPRETER-UNDEFINED` |
| **Immediate Fix Possible** | Maybe — check bridge coverage |
| **Description** | Interpreter cannot resolve variable/property |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_aligning_shifted_box_test.dart` references a variable or property the interpreter cannot resolve. Check bridge coverage for this symbol.

**Fix Description (Proper Fix):**

Fix the interpreter's variable/property resolution for the specific undefined symbol. Check bridge coverage.

**Needs Deeper Analysis:** Maybe — check bridge coverage

#### Issue 44: rendering/render_animated_opacity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 44 |
| **Test Name** | `rendering/render_animated_opacity_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_animated_opacity_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_controller` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 45: rendering/render_block_semantics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 45 |
| **Test Name** | `rendering/render_block_semantics_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_block_semantics_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-9

Issues 46–50 of 551

#### Issue 46: rendering/render_box_container_defaults_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 46 |
| **Test Name** | `rendering/render_box_container_defaults_mixin_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_box_container_defaults_mixin_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 47: rendering/render_custom_multi_child_layout_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 47 |
| **Test Name** | `rendering/render_custom_multi_child_layout_box_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_custom_multi_child_layout_box_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 48: rendering/render_custom_paint_test.dart

| Field | Value |
|-------|-------|
| **Index** | 48 |
| **Test Name** | `rendering/render_custom_paint_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_custom_paint_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 49: rendering/render_custom_single_child_layout_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 49 |
| **Test Name** | `rendering/render_custom_single_child_layout_box_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_custom_single_child_layout_box_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 50: rendering/render_editable_test.dart

| Field | Value |
|-------|-------|
| **Index** | 50 |
| **Test Name** | `rendering/render_editable_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_editable_test.dart` triggered 3 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-10

Issues 51–55 of 551

#### Issue 51: rendering/render_ignore_pointer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 51 |
| **Test Name** | `rendering/render_ignore_pointer_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_ignore_pointer_test.dart` triggered 1 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 52: rendering/render_physical_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 52 |
| **Test Name** | `rendering/render_physical_shape_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_physical_shape_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 53: rendering/render_shader_mask_test.dart

| Field | Value |
|-------|-------|
| **Index** | 53 |
| **Test Name** | `rendering/render_shader_mask_test.dart` |
| **Category** | `INTERPRETER-INDEX-ERROR` |
| **Immediate Fix Possible** | Yes — fix bounds checking |
| **Description** | Index out of range error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_shader_mask_test.dart` triggers an index-out-of-range error. The script or interpreter has a bounds-checking issue.

**Fix Description (Proper Fix):**

Fix the interpreter's bounds checking for indexed access. The interpreter should match Dart's RangeError semantics.

**Needs Deeper Analysis:** No — bounds checking fix

#### Issue 54: rendering/render_shrink_wrapping_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 54 |
| **Test Name** | `rendering/render_shrink_wrapping_viewport_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_shrink_wrapping_viewport_test.dart` fails because the bridge for `execution` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 55: rendering/render_sliver_pinned_persistent_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 55 |
| **Test Name** | `rendering/render_sliver_pinned_persistent_header_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_sliver_pinned_persistent_header_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-11

Issues 56–60 of 551

#### Issue 56: rendering/sliver_hit_test_result_test.dart

| Field | Value |
|-------|-------|
| **Index** | 56 |
| **Test Name** | `rendering/sliver_hit_test_result_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/sliver_hit_test_result_test.dart` triggered 3 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 57: rendering/sliver_layout_dimensions_test.dart

| Field | Value |
|-------|-------|
| **Index** | 57 |
| **Test Name** | `rendering/sliver_layout_dimensions_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/sliver_layout_dimensions_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 58: widgets/android_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 58 |
| **Test Name** | `widgets/android_view_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes — add type to bridge generator configuration |
| **Description** | Bridge missing type/class definition |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/android_view_test.dart` references a type that has no bridge definition. The type must be added to the bridge generator's module configuration.

**Fix Description (Proper Fix):**

Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file.

**Needs Deeper Analysis:** No — add type to bridge configuration

#### Issue 59: widgets/animated_cross_fade_test.dart

| Field | Value |
|-------|-------|
| **Index** | 59 |
| **Test Name** | `widgets/animated_cross_fade_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes — add method to bridge generator |
| **Description** | Bridge missing method implementation |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/animated_cross_fade_test.dart` calls a method that is not emitted in the bridge class. The bridge generator must add this method.

**Fix Description (Proper Fix):**

Add the missing method to the bridge class definition. Update the bridge generator to emit the method, or add a UserBridge override.

**Needs Deeper Analysis:** No — add method to bridge generator

#### Issue 60: widgets/animated_fractionally_sized_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 60 |
| **Test Name** | `widgets/animated_fractionally_sized_box_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/animated_fractionally_sized_box_test.dart` triggered 1 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-12

Issues 61–65 of 551

#### Issue 61: widgets/animated_switcher_test.dart

| Field | Value |
|-------|-------|
| **Index** | 61 |
| **Test Name** | `widgets/animated_switcher_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes — add method to bridge generator |
| **Description** | Bridge missing method implementation |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/animated_switcher_test.dart` calls a method that is not emitted in the bridge class. The bridge generator must add this method.

**Fix Description (Proper Fix):**

Add the missing method to the bridge class definition. Update the bridge generator to emit the method, or add a UserBridge override.

**Needs Deeper Analysis:** No — add method to bridge generator

#### Issue 62: widgets/autofill_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 62 |
| **Test Name** | `widgets/autofill_group_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/autofill_group_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 63: widgets/backdrop_filter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 63 |
| **Test Name** | `widgets/backdrop_filter_test.dart` |
| **Category** | `BRIDGE-MISSING-METHOD` |
| **Immediate Fix Possible** | Yes — add method to bridge generator |
| **Description** | Bridge missing method implementation |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/backdrop_filter_test.dart` calls a method that is not emitted in the bridge class. The bridge generator must add this method.

**Fix Description (Proper Fix):**

Add the missing method to the bridge class definition. Update the bridge generator to emit the method, or add a UserBridge override.

**Needs Deeper Analysis:** No — add method to bridge generator

#### Issue 64: widgets/color_filtered_test.dart

| Field | Value |
|-------|-------|
| **Index** | 64 |
| **Test Name** | `widgets/color_filtered_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/color_filtered_test.dart` triggered 9 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 65: widgets/composited_transform_follower_test.dart

| Field | Value |
|-------|-------|
| **Index** | 65 |
| **Test Name** | `widgets/composited_transform_follower_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/composited_transform_follower_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

---

## Batch-13

Issues 66–70 of 551

#### Issue 66: widgets/default_asset_bundle_test.dart

| Field | Value |
|-------|-------|
| **Index** | 66 |
| **Test Name** | `widgets/default_asset_bundle_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/default_asset_bundle_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_oceanBundle` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 67: widgets/directionality_test.dart

| Field | Value |
|-------|-------|
| **Index** | 67 |
| **Test Name** | `widgets/directionality_test.dart` |
| **Category** | `TRANSPORT-ERROR` |
| **Immediate Fix Possible** | No — requires transport layer debugging |
| **Description** | Direct HTTP transport failure |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | transport_error (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/directionality_test.dart` encountered a direct transport/HTTP error. This is an infrastructure-level failure in the test runner's HTTP endpoint. Debug the server-side handler.

**Fix Description (Proper Fix):**

Fix the HTTP transport layer to handle the specific failure mode. Debug the server-side test runner endpoint to identify why the request fails.

**Needs Deeper Analysis:** Yes — debug HTTP transport layer

#### Issue 68: widgets/display_feature_sub_screen_test.dart

| Field | Value |
|-------|-------|
| **Index** | 68 |
| **Test Name** | `widgets/display_feature_sub_screen_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/display_feature_sub_screen_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 69: widgets/dual_transition_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 69 |
| **Test Name** | `widgets/dual_transition_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/dual_transition_builder_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 70: widgets/editable_text_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 70 |
| **Test Name** | `widgets/editable_text_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/editable_text_state_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-14

Issues 71–75 of 551

#### Issue 71: widgets/element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 71 |
| **Test Name** | `widgets/element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 72: widgets/fade_in_image_test.dart

| Field | Value |
|-------|-------|
| **Index** | 72 |
| **Test Name** | `widgets/fade_in_image_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/fade_in_image_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 73: widgets/fixed_extent_metrics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 73 |
| **Test Name** | `widgets/fixed_extent_metrics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/fixed_extent_metrics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 74: widgets/fixed_extent_scroll_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 74 |
| **Test Name** | `widgets/fixed_extent_scroll_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/fixed_extent_scroll_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 75: widgets/fixed_extent_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 75 |
| **Test Name** | `widgets/fixed_extent_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/fixed_extent_scroll_physics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-15

Issues 76–80 of 551

#### Issue 76: widgets/glowing_overscroll_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 76 |
| **Test Name** | `widgets/glowing_overscroll_indicator_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/glowing_overscroll_indicator_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 77: widgets/html_element_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 77 |
| **Test Name** | `widgets/html_element_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/html_element_view_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 78: widgets/image_filtered_test.dart

| Field | Value |
|-------|-------|
| **Index** | 78 |
| **Test Name** | `widgets/image_filtered_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/image_filtered_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 79: widgets/implicitly_animated_widget_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 79 |
| **Test Name** | `widgets/implicitly_animated_widget_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/implicitly_animated_widget_state_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 80: widgets/implicitly_animated_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 80 |
| **Test Name** | `widgets/implicitly_animated_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/implicitly_animated_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-16

Issues 81–85 of 551

#### Issue 81: widgets/indexed_stack_test.dart

| Field | Value |
|-------|-------|
| **Index** | 81 |
| **Test Name** | `widgets/indexed_stack_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/indexed_stack_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 82: widgets/inherited_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 82 |
| **Test Name** | `widgets/inherited_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inherited_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 83: widgets/inherited_notifier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 83 |
| **Test Name** | `widgets/inherited_notifier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inherited_notifier_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 84: widgets/inherited_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 84 |
| **Test Name** | `widgets/inherited_theme_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inherited_theme_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 85: widgets/inherited_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 85 |
| **Test Name** | `widgets/inherited_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inherited_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-17

Issues 86–90 of 551

#### Issue 86: widgets/leaf_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 86 |
| **Test Name** | `widgets/leaf_render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/leaf_render_object_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 87: widgets/leaf_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 87 |
| **Test Name** | `widgets/leaf_render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/leaf_render_object_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 88: widgets/list_wheel_child_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 88 |
| **Test Name** | `widgets/list_wheel_child_builder_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_child_builder_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 89: widgets/list_wheel_child_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 89 |
| **Test Name** | `widgets/list_wheel_child_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_child_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 90: widgets/list_wheel_child_list_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 90 |
| **Test Name** | `widgets/list_wheel_child_list_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_child_list_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-18

Issues 91–95 of 551

#### Issue 91: widgets/list_wheel_child_looping_list_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 91 |
| **Test Name** | `widgets/list_wheel_child_looping_list_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_child_looping_list_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 92: widgets/list_wheel_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 92 |
| **Test Name** | `widgets/list_wheel_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 93: widgets/list_wheel_scroll_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 93 |
| **Test Name** | `widgets/list_wheel_scroll_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_scroll_view_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 94: widgets/list_wheel_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 94 |
| **Test Name** | `widgets/list_wheel_viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/list_wheel_viewport_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 95: widgets/magnifier_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 95 |
| **Test Name** | `widgets/magnifier_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/magnifier_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-19

Issues 96–100 of 551

#### Issue 96: widgets/magnifier_decoration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 96 |
| **Test Name** | `widgets/magnifier_decoration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/magnifier_decoration_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 97: widgets/magnifier_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 97 |
| **Test Name** | `widgets/magnifier_info_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/magnifier_info_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 98: widgets/multi_child_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 98 |
| **Test Name** | `widgets/multi_child_render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/multi_child_render_object_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 99: widgets/multi_child_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 99 |
| **Test Name** | `widgets/multi_child_render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/multi_child_render_object_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 100: widgets/navigation_toolbar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 100 |
| **Test Name** | `widgets/navigation_toolbar_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/navigation_toolbar_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-20

Issues 101–105 of 551

#### Issue 101: widgets/never_scrollable_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 101 |
| **Test Name** | `widgets/never_scrollable_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/never_scrollable_scroll_physics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 102: widgets/overflow_bar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 102 |
| **Test Name** | `widgets/overflow_bar_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overflow_bar_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 103: widgets/overflow_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 103 |
| **Test Name** | `widgets/overflow_box_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overflow_box_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 104: widgets/page_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 104 |
| **Test Name** | `widgets/page_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_scroll_physics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 105: widgets/page_storage_bucket_test.dart

| Field | Value |
|-------|-------|
| **Index** | 105 |
| **Test Name** | `widgets/page_storage_bucket_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_storage_bucket_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-21

Issues 106–110 of 551

#### Issue 106: widgets/page_storage_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 106 |
| **Test Name** | `widgets/page_storage_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_storage_key_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 107: widgets/page_storage_test.dart

| Field | Value |
|-------|-------|
| **Index** | 107 |
| **Test Name** | `widgets/page_storage_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_storage_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 108: widgets/parent_data_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 108 |
| **Test Name** | `widgets/parent_data_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/parent_data_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 109: widgets/parent_data_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 109 |
| **Test Name** | `widgets/parent_data_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/parent_data_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 110: widgets/performance_overlay_test.dart

| Field | Value |
|-------|-------|
| **Index** | 110 |
| **Test Name** | `widgets/performance_overlay_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/performance_overlay_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-22

Issues 111–115 of 551

#### Issue 111: widgets/physical_model_test.dart

| Field | Value |
|-------|-------|
| **Index** | 111 |
| **Test Name** | `widgets/physical_model_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/physical_model_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 112: widgets/physical_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 112 |
| **Test Name** | `widgets/physical_shape_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/physical_shape_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 113: widgets/pinned_header_sliver_test.dart

| Field | Value |
|-------|-------|
| **Index** | 113 |
| **Test Name** | `widgets/pinned_header_sliver_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/pinned_header_sliver_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 114: widgets/platform_menu_bar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 114 |
| **Test Name** | `widgets/platform_menu_bar_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_menu_bar_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 115: widgets/platform_menu_item_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 115 |
| **Test Name** | `widgets/platform_menu_item_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_menu_item_group_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-23

Issues 116–120 of 551

#### Issue 116: widgets/platform_menu_item_test.dart

| Field | Value |
|-------|-------|
| **Index** | 116 |
| **Test Name** | `widgets/platform_menu_item_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_menu_item_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 117: widgets/platform_menu_test.dart

| Field | Value |
|-------|-------|
| **Index** | 117 |
| **Test Name** | `widgets/platform_menu_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_menu_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 118: widgets/platform_provided_menu_item_test.dart

| Field | Value |
|-------|-------|
| **Index** | 118 |
| **Test Name** | `widgets/platform_provided_menu_item_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_provided_menu_item_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 119: widgets/platform_view_link_test.dart

| Field | Value |
|-------|-------|
| **Index** | 119 |
| **Test Name** | `widgets/platform_view_link_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_view_link_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 120: widgets/platform_view_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 120 |
| **Test Name** | `widgets/platform_view_surface_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_view_surface_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-24

Issues 121–125 of 551

#### Issue 121: widgets/pop_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 121 |
| **Test Name** | `widgets/pop_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/pop_scope_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 122: widgets/positioned_directional_test.dart

| Field | Value |
|-------|-------|
| **Index** | 122 |
| **Test Name** | `widgets/positioned_directional_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/positioned_directional_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 123: widgets/primary_scroll_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 123 |
| **Test Name** | `widgets/primary_scroll_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/primary_scroll_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 124: widgets/proxy_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 124 |
| **Test Name** | `widgets/proxy_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/proxy_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 125: widgets/proxy_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 125 |
| **Test Name** | `widgets/proxy_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/proxy_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-25

Issues 126–130 of 551

#### Issue 126: widgets/radio_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 126 |
| **Test Name** | `widgets/radio_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/radio_group_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 127: widgets/range_maintaining_scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 127 |
| **Test Name** | `widgets/range_maintaining_scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/range_maintaining_scroll_physics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 128: widgets/raw_magnifier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 128 |
| **Test Name** | `widgets/raw_magnifier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/raw_magnifier_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 129: widgets/raw_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 129 |
| **Test Name** | `widgets/raw_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/raw_view_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 130: widgets/render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 130 |
| **Test Name** | `widgets/render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_object_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-26

Issues 131–135 of 551

#### Issue 131: widgets/render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 131 |
| **Test Name** | `widgets/render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_object_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 132: widgets/restorable_bool_test.dart

| Field | Value |
|-------|-------|
| **Index** | 132 |
| **Test Name** | `widgets/restorable_bool_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_bool_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 133: widgets/restorable_date_time_test.dart

| Field | Value |
|-------|-------|
| **Index** | 133 |
| **Test Name** | `widgets/restorable_date_time_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_date_time_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 134: widgets/restorable_double_test.dart

| Field | Value |
|-------|-------|
| **Index** | 134 |
| **Test Name** | `widgets/restorable_double_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_double_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 135: widgets/restorable_enum_test.dart

| Field | Value |
|-------|-------|
| **Index** | 135 |
| **Test Name** | `widgets/restorable_enum_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_enum_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-27

Issues 136–140 of 551

#### Issue 136: widgets/restorable_int_test.dart

| Field | Value |
|-------|-------|
| **Index** | 136 |
| **Test Name** | `widgets/restorable_int_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_int_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 137: widgets/restorable_property_test.dart

| Field | Value |
|-------|-------|
| **Index** | 137 |
| **Test Name** | `widgets/restorable_property_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_property_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 138: widgets/restorable_string_test.dart

| Field | Value |
|-------|-------|
| **Index** | 138 |
| **Test Name** | `widgets/restorable_string_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_string_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 139: widgets/restorable_text_editing_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 139 |
| **Test Name** | `widgets/restorable_text_editing_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_text_editing_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 140: widgets/restorable_value_test.dart

| Field | Value |
|-------|-------|
| **Index** | 140 |
| **Test Name** | `widgets/restorable_value_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_value_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-28

Issues 141–145 of 551

#### Issue 141: widgets/restoration_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 141 |
| **Test Name** | `widgets/restoration_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restoration_mixin_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 142: widgets/root_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 142 |
| **Test Name** | `widgets/root_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/root_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 143: widgets/root_restoration_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 143 |
| **Test Name** | `widgets/root_restoration_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/root_restoration_scope_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 144: widgets/root_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 144 |
| **Test Name** | `widgets/root_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/root_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 145: widgets/scroll_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 145 |
| **Test Name** | `widgets/scroll_action_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_action_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-29

Issues 146–150 of 551

#### Issue 146: widgets/scroll_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 146 |
| **Test Name** | `widgets/scroll_configuration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_configuration_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 147: widgets/scroll_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 147 |
| **Test Name** | `widgets/scroll_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 148: widgets/scroll_physics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 148 |
| **Test Name** | `widgets/scroll_physics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_physics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 149: widgets/scroll_position_test.dart

| Field | Value |
|-------|-------|
| **Index** | 149 |
| **Test Name** | `widgets/scroll_position_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_position_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 150: widgets/scrollable_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 150 |
| **Test Name** | `widgets/scrollable_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scrollable_state_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-30

Issues 151–155 of 551

#### Issue 151: widgets/scrollable_test.dart

| Field | Value |
|-------|-------|
| **Index** | 151 |
| **Test Name** | `widgets/scrollable_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scrollable_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 152: widgets/selectable_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 152 |
| **Test Name** | `widgets/selectable_region_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selectable_region_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 153: widgets/selection_container_test.dart

| Field | Value |
|-------|-------|
| **Index** | 153 |
| **Test Name** | `widgets/selection_container_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selection_container_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 154: widgets/selection_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 154 |
| **Test Name** | `widgets/selection_listener_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selection_listener_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 155: widgets/selection_overlay_test.dart

| Field | Value |
|-------|-------|
| **Index** | 155 |
| **Test Name** | `widgets/selection_overlay_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selection_overlay_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-31

Issues 156–160 of 551

#### Issue 156: widgets/shader_mask_test.dart

| Field | Value |
|-------|-------|
| **Index** | 156 |
| **Test Name** | `widgets/shader_mask_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shader_mask_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 157: widgets/shared_app_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 157 |
| **Test Name** | `widgets/shared_app_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shared_app_data_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 158: widgets/shrink_wrapping_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 158 |
| **Test Name** | `widgets/shrink_wrapping_viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shrink_wrapping_viewport_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 159: widgets/single_child_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 159 |
| **Test Name** | `widgets/single_child_render_object_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/single_child_render_object_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 160: widgets/single_child_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 160 |
| **Test Name** | `widgets/single_child_render_object_widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/single_child_render_object_widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-32

Issues 161–165 of 551

#### Issue 161: widgets/single_ticker_provider_state_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 161 |
| **Test Name** | `widgets/single_ticker_provider_state_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/single_ticker_provider_state_mixin_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 162: widgets/sliver_animated_grid_test.dart

| Field | Value |
|-------|-------|
| **Index** | 162 |
| **Test Name** | `widgets/sliver_animated_grid_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_animated_grid_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 163: widgets/sliver_animated_list_test.dart

| Field | Value |
|-------|-------|
| **Index** | 163 |
| **Test Name** | `widgets/sliver_animated_list_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_animated_list_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 164: widgets/sliver_animated_opacity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 164 |
| **Test Name** | `widgets/sliver_animated_opacity_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_animated_opacity_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 165: widgets/sliver_constrained_cross_axis_test.dart

| Field | Value |
|-------|-------|
| **Index** | 165 |
| **Test Name** | `widgets/sliver_constrained_cross_axis_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_constrained_cross_axis_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-33

Issues 166–170 of 551

#### Issue 166: widgets/sliver_cross_axis_expanded_test.dart

| Field | Value |
|-------|-------|
| **Index** | 166 |
| **Test Name** | `widgets/sliver_cross_axis_expanded_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_cross_axis_expanded_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 167: widgets/sliver_cross_axis_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 167 |
| **Test Name** | `widgets/sliver_cross_axis_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_cross_axis_group_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 168: widgets/sliver_floating_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 168 |
| **Test Name** | `widgets/sliver_floating_header_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_floating_header_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 169: widgets/sliver_ignore_pointer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 169 |
| **Test Name** | `widgets/sliver_ignore_pointer_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_ignore_pointer_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 170: widgets/sliver_layout_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 170 |
| **Test Name** | `widgets/sliver_layout_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_layout_builder_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-34

Issues 171–175 of 551

#### Issue 171: widgets/sliver_main_axis_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 171 |
| **Test Name** | `widgets/sliver_main_axis_group_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_main_axis_group_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 172: widgets/sliver_offstage_test.dart

| Field | Value |
|-------|-------|
| **Index** | 172 |
| **Test Name** | `widgets/sliver_offstage_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_offstage_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 173: widgets/sliver_prototype_extent_list_test.dart

| Field | Value |
|-------|-------|
| **Index** | 173 |
| **Test Name** | `widgets/sliver_prototype_extent_list_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_prototype_extent_list_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 174: widgets/sliver_reorderable_list_test.dart

| Field | Value |
|-------|-------|
| **Index** | 174 |
| **Test Name** | `widgets/sliver_reorderable_list_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_reorderable_list_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 175: widgets/sliver_resizing_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 175 |
| **Test Name** | `widgets/sliver_resizing_header_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_resizing_header_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-35

Issues 176–180 of 551

#### Issue 176: widgets/sliver_safe_area_test.dart

| Field | Value |
|-------|-------|
| **Index** | 176 |
| **Test Name** | `widgets/sliver_safe_area_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_safe_area_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 177: widgets/sliver_semantics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 177 |
| **Test Name** | `widgets/sliver_semantics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_semantics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 178: widgets/sliver_visibility_test.dart

| Field | Value |
|-------|-------|
| **Index** | 178 |
| **Test Name** | `widgets/sliver_visibility_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_visibility_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 179: widgets/spacer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 179 |
| **Test Name** | `widgets/spacer_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/spacer_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 180: widgets/spell_check_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 180 |
| **Test Name** | `widgets/spell_check_configuration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/spell_check_configuration_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-36

Issues 181–185 of 551

#### Issue 181: widgets/stateful_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 181 |
| **Test Name** | `widgets/stateful_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/stateful_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 182: widgets/stateless_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 182 |
| **Test Name** | `widgets/stateless_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/stateless_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 183: widgets/stretching_overscroll_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 183 |
| **Test Name** | `widgets/stretching_overscroll_indicator_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/stretching_overscroll_indicator_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 184: widgets/table_cell_test.dart

| Field | Value |
|-------|-------|
| **Index** | 184 |
| **Test Name** | `widgets/table_cell_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/table_cell_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 185: widgets/table_row_test.dart

| Field | Value |
|-------|-------|
| **Index** | 185 |
| **Test Name** | `widgets/table_row_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/table_row_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-37

Issues 186–190 of 551

#### Issue 186: widgets/tap_region_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 186 |
| **Test Name** | `widgets/tap_region_surface_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tap_region_surface_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 187: widgets/tap_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 187 |
| **Test Name** | `widgets/tap_region_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tap_region_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 188: widgets/text_field_tap_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 188 |
| **Test Name** | `widgets/text_field_tap_region_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_field_tap_region_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 189: widgets/text_magnifier_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 189 |
| **Test Name** | `widgets/text_magnifier_configuration_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_magnifier_configuration_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 190: widgets/text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 190 |
| **Test Name** | `widgets/text_selection_controls_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_selection_controls_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-38

Issues 191–195 of 551

#### Issue 191: widgets/text_selection_gesture_detector_test.dart

| Field | Value |
|-------|-------|
| **Index** | 191 |
| **Test Name** | `widgets/text_selection_gesture_detector_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_selection_gesture_detector_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 192: widgets/text_selection_overlay_test.dart

| Field | Value |
|-------|-------|
| **Index** | 192 |
| **Test Name** | `widgets/text_selection_overlay_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_selection_overlay_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 193: widgets/text_selection_toolbar_anchors_test.dart

| Field | Value |
|-------|-------|
| **Index** | 193 |
| **Test Name** | `widgets/text_selection_toolbar_anchors_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_selection_toolbar_anchors_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 194: widgets/ticker_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 194 |
| **Test Name** | `widgets/ticker_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/ticker_mode_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 195: widgets/ticker_provider_state_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 195 |
| **Test Name** | `widgets/ticker_provider_state_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/ticker_provider_state_mixin_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-39

Issues 196–200 of 551

#### Issue 196: widgets/title_test.dart

| Field | Value |
|-------|-------|
| **Index** | 196 |
| **Test Name** | `widgets/title_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/title_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 197: widgets/tooltip_trigger_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 197 |
| **Test Name** | `widgets/tooltip_trigger_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tooltip_trigger_mode_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 198: widgets/tween_animation_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 198 |
| **Test Name** | `widgets/tween_animation_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tween_animation_builder_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 199: widgets/ui_kit_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 199 |
| **Test Name** | `widgets/ui_kit_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/ui_kit_view_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 200: widgets/undo_history_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 200 |
| **Test Name** | `widgets/undo_history_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/undo_history_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-40

Issues 201–205 of 551

#### Issue 201: widgets/view_anchor_test.dart

| Field | Value |
|-------|-------|
| **Index** | 201 |
| **Test Name** | `widgets/view_anchor_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/view_anchor_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 202: widgets/view_collection_test.dart

| Field | Value |
|-------|-------|
| **Index** | 202 |
| **Test Name** | `widgets/view_collection_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/view_collection_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 203: widgets/view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 203 |
| **Test Name** | `widgets/view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/view_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 204: widgets/viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 204 |
| **Test Name** | `widgets/viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/viewport_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 205: widgets/widget_inspector_test.dart

| Field | Value |
|-------|-------|
| **Index** | 205 |
| **Test Name** | `widgets/widget_inspector_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_inspector_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-41

Issues 206–210 of 551

#### Issue 206: widgets/widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 206 |
| **Test Name** | `widgets/widget_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 207: widgets/widgets_app_test.dart

| Field | Value |
|-------|-------|
| **Index** | 207 |
| **Test Name** | `widgets/widgets_app_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widgets_app_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 208: widgets/widgets_binding_observer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 208 |
| **Test Name** | `widgets/widgets_binding_observer_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widgets_binding_observer_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 209: widgets/widgets_binding_test.dart

| Field | Value |
|-------|-------|
| **Index** | 209 |
| **Test Name** | `widgets/widgets_binding_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widgets_binding_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 210: widgets/widgets_flutter_binding_test.dart

| Field | Value |
|-------|-------|
| **Index** | 210 |
| **Test Name** | `widgets/widgets_flutter_binding_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widgets_flutter_binding_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-42

Issues 211–215 of 551

#### Issue 211: widgets/will_pop_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 211 |
| **Test Name** | `widgets/will_pop_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 0 |
| **Suite** | `secondary_classes_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/will_pop_scope_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 212: animation/reverse_tween_test.dart

| Field | Value |
|-------|-------|
| **Index** | 212 |
| **Test Name** | `animation/reverse_tween_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `animation/reverse_tween_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 213: cupertino/cupertino_desktop_text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 213 |
| **Test Name** | `cupertino/cupertino_desktop_text_selection_controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_desktop_text_selection_controls_test.dart` triggered 3 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 214: cupertino/cupertino_focus_halo_test.dart

| Field | Value |
|-------|-------|
| **Index** | 214 |
| **Test Name** | `cupertino/cupertino_focus_halo_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_focus_halo_test.dart` triggered 3 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 215: cupertino/cupertino_text_selection_handle_controls_test.dart

| Field | Value |
|-------|-------|
| **Index** | 215 |
| **Test Name** | `cupertino/cupertino_text_selection_handle_controls_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/cupertino_text_selection_handle_controls_test.dart` triggered 11 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-43

Issues 216–220 of 551

#### Issue 216: cupertino/inherited_cupertino_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 216 |
| **Test Name** | `cupertino/inherited_cupertino_theme_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/inherited_cupertino_theme_test.dart` triggered 3 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 217: cupertino/overlay_visibility_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 217 |
| **Test Name** | `cupertino/overlay_visibility_mode_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `cupertino/overlay_visibility_mode_test.dart` triggered 7 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 218: dart_ui/blur_style_test.dart

| Field | Value |
|-------|-------|
| **Index** | 218 |
| **Test Name** | `dart_ui/blur_style_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/blur_style_test.dart` triggered 4 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 219: dart_ui/color_space_test.dart

| Field | Value |
|-------|-------|
| **Index** | 219 |
| **Test Name** | `dart_ui/color_space_test.dart` |
| **Category** | `INTERPRETER-UNSUPPORTED` |
| **Immediate Fix Possible** | No — requires implementation effort |
| **Description** | Unsupported operation in interpreter |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/color_space_test.dart` uses an operation not yet supported by the interpreter (e.g., platform-specific API, isolates). The interpreter or bridge layer needs this operation implemented.

**Fix Description (Proper Fix):**

Implement the missing operation in the interpreter or add the required bridge support.

**Needs Deeper Analysis:** Yes — evaluate implementation scope

#### Issue 220: dart_ui/placeholder_alignment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 220 |
| **Test Name** | `dart_ui/placeholder_alignment_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/placeholder_alignment_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

---

## Batch-44

Issues 221–225 of 551

#### Issue 221: dart_ui/system_color_palette_test.dart

| Field | Value |
|-------|-------|
| **Index** | 221 |
| **Test Name** | `dart_ui/system_color_palette_test.dart` |
| **Category** | `INTERPRETER-UNSUPPORTED` |
| **Immediate Fix Possible** | No — requires implementation effort |
| **Description** | Unsupported operation in interpreter |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/system_color_palette_test.dart` uses an operation not yet supported by the interpreter (e.g., platform-specific API, isolates). The interpreter or bridge layer needs this operation implemented.

**Fix Description (Proper Fix):**

Implement the missing operation in the interpreter or add the required bridge support.

**Needs Deeper Analysis:** Yes — evaluate implementation scope

#### Issue 222: dart_ui/vertex_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 222 |
| **Test Name** | `dart_ui/vertex_mode_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `dart_ui/vertex_mode_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 223: foundation/object_created_test.dart

| Field | Value |
|-------|-------|
| **Index** | 223 |
| **Test Name** | `foundation/object_created_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes — add constructor to bridge |
| **Description** | Bridge missing constructor (type not callable) |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `foundation/object_created_test.dart` tries to construct a type that has no callable constructor in its bridge. The bridge generator must emit a constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge so the type becomes callable. Update bridge generator to emit constructors for this class.

**Needs Deeper Analysis:** No — add constructor to bridge

#### Issue 224: foundation/object_disposed_test.dart

| Field | Value |
|-------|-------|
| **Index** | 224 |
| **Test Name** | `foundation/object_disposed_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes — add constructor to bridge |
| **Description** | Bridge missing constructor (type not callable) |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `foundation/object_disposed_test.dart` tries to construct a type that has no callable constructor in its bridge. The bridge generator must emit a constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge so the type becomes callable. Update bridge generator to emit constructors for this class.

**Needs Deeper Analysis:** No — add constructor to bridge

#### Issue 225: foundation/object_event_test.dart

| Field | Value |
|-------|-------|
| **Index** | 225 |
| **Test Name** | `foundation/object_event_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes — add constructor to bridge |
| **Description** | Bridge missing constructor (type not callable) |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `foundation/object_event_test.dart` tries to construct a type that has no callable constructor in its bridge. The bridge generator must emit a constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge so the type becomes callable. Update bridge generator to emit constructors for this class.

**Needs Deeper Analysis:** No — add constructor to bridge

---

## Batch-45

Issues 226–230 of 551

#### Issue 226: foundation/target_platform_test.dart

| Field | Value |
|-------|-------|
| **Index** | 226 |
| **Test Name** | `foundation/target_platform_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `foundation/target_platform_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 227: gestures/class_test.dart

| Field | Value |
|-------|-------|
| **Index** | 227 |
| **Test Name** | `gestures/class_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_1_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `gestures/class_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 228: material/autocomplete_test.dart

| Field | Value |
|-------|-------|
| **Index** | 228 |
| **Test Name** | `material/autocomplete_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/autocomplete_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 229: material/back_button_icon_test.dart

| Field | Value |
|-------|-------|
| **Index** | 229 |
| **Test Name** | `material/back_button_icon_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/back_button_icon_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 230: material/back_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 230 |
| **Test Name** | `material/back_button_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/back_button_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

---

## Batch-46

Issues 231–235 of 551

#### Issue 231: material/bottom_navigation_bar_landscape_layout_test.dart

| Field | Value |
|-------|-------|
| **Index** | 231 |
| **Test Name** | `material/bottom_navigation_bar_landscape_layout_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/bottom_navigation_bar_landscape_layout_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 232: material/bottom_navigation_bar_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 232 |
| **Test Name** | `material/bottom_navigation_bar_theme_data_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/bottom_navigation_bar_theme_data_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 233: material/bottom_navigation_bar_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 233 |
| **Test Name** | `material/bottom_navigation_bar_theme_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/bottom_navigation_bar_theme_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 234: material/bottom_navigation_bar_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 234 |
| **Test Name** | `material/bottom_navigation_bar_type_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/bottom_navigation_bar_type_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 235: material/button_bar_layout_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 235 |
| **Test Name** | `material/button_bar_layout_behavior_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/button_bar_layout_behavior_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

---

## Batch-47

Issues 236–240 of 551

#### Issue 236: material/button_bar_test.dart

| Field | Value |
|-------|-------|
| **Index** | 236 |
| **Test Name** | `material/button_bar_test.dart` |
| **Category** | `SCRIPT-TIMEOUT` |
| **Immediate Fix Possible** | Maybe — profile interpreter to identify bottleneck |
| **Description** | Build timeout — interpreter performance or infinite loop |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/button_bar_test.dart` timed out during execution. Either the script has a performance-critical path that the interpreter handles slowly, or it contains an infinite loop under interpretation. Profile the interpreter execution to identify the bottleneck.

**Fix Description (Proper Fix):**

Investigate and fix the specific script performance issue or infinite loop. If the script is correct, increase interpreter execution budget or optimize the hot path in the interpreter.

**Needs Deeper Analysis:** Yes — profile interpreter execution

#### Issue 237: material/button_bar_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 237 |
| **Test Name** | `material/button_bar_theme_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/button_bar_theme_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 238: material/button_text_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 238 |
| **Test Name** | `material/button_text_theme_test.dart` |
| **Category** | `INTERPRETER-NULL-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix null propagation |
| **Description** | Null property access — interpreter null-safety gap |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/button_text_theme_test.dart` accesses a property on null. The interpreter's null-safety propagation is incomplete.

**Fix Description (Proper Fix):**

Fix the interpreter's null-safety propagation for property access chains.

**Needs Deeper Analysis:** Maybe — check null propagation

#### Issue 239: material/collapse_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 239 |
| **Test Name** | `material/collapse_mode_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/collapse_mode_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 240: material/drawer_controller_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 240 |
| **Test Name** | `material/drawer_controller_state_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/drawer_controller_state_test.dart` triggered 3 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-48

Issues 241–245 of 551

#### Issue 241: material/dropdown_menu_close_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 241 |
| **Test Name** | `material/dropdown_menu_close_behavior_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes — Bug-79 FIXED, verify edge cases |
| **Description** | Non-exhaustive switch expression — Bug-79 FIXED, edge case |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/dropdown_menu_close_behavior_test.dart` uses a switch expression that the interpreter considers non-exhaustive. Bug-79 is FIXED; verify this is a remaining edge case.

**Fix Description (Proper Fix):**

Fix the interpreter's switch expression exhaustiveness checking to handle sealed class hierarchies and enum values correctly. Bug-79 is already FIXED; verify remaining cases.

**Needs Deeper Analysis:** No — Bug-79 FIXED, verify edge cases

#### Issue 242: material/end_drawer_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 242 |
| **Test Name** | `material/end_drawer_button_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/end_drawer_button_test.dart` triggered 8 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 243: material/gapped_range_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 243 |
| **Test Name** | `material/gapped_range_slider_track_shape_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/gapped_range_slider_track_shape_test.dart` triggered an uncategorized framework error. Requires individual investigation of the specific error context.

**Fix Description (Proper Fix):**

Investigate the specific framework error and fix the root cause in the interpreter or bridge layer.

**Needs Deeper Analysis:** Yes — individual investigation needed

#### Issue 244: material/gapped_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Index** | 244 |
| **Test Name** | `material/gapped_slider_track_shape_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe — investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/gapped_slider_track_shape_test.dart` triggered a Flutter framework assertion. The interpreter's widget lifecycle or state management violates a framework invariant.

**Fix Description (Proper Fix):**

Investigate and fix the specific Flutter assertion trigger. The interpreter's widget lifecycle management may need adjustment to satisfy framework invariants.

**Needs Deeper Analysis:** Yes — investigate specific assertion

#### Issue 245: material/hour_format_test.dart

| Field | Value |
|-------|-------|
| **Index** | 245 |
| **Test Name** | `material/hour_format_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe — fix null-check before dispatch |
| **Description** | Method invocation on null — interpreter null-check gap |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/hour_format_test.dart` invokes a method on null. The interpreter's null-safety check before method dispatch is missing.

**Fix Description (Proper Fix):**

Fix the interpreter's null-safety checking for method invocations. Add proper null-check propagation before method dispatch.

**Needs Deeper Analysis:** Maybe — check script null safety

---

## Batch-49

Issues 246–250 of 551

#### Issue 246: material/list_tile_title_alignment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 246 |
| **Test Name** | `material/list_tile_title_alignment_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/list_tile_title_alignment_test.dart` triggered 3 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 247: material/material_banner_closed_reason_test.dart

| Field | Value |
|-------|-------|
| **Index** | 247 |
| **Test Name** | `material/material_banner_closed_reason_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes — Bug-79 FIXED, verify edge cases |
| **Description** | Non-exhaustive switch expression — Bug-79 FIXED, edge case |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/material_banner_closed_reason_test.dart` uses a switch expression that the interpreter considers non-exhaustive. Bug-79 is FIXED; verify this is a remaining edge case.

**Fix Description (Proper Fix):**

Fix the interpreter's switch expression exhaustiveness checking to handle sealed class hierarchies and enum values correctly. Bug-79 is already FIXED; verify remaining cases.

**Needs Deeper Analysis:** No — Bug-79 FIXED, verify edge cases

#### Issue 248: material/menu_accelerator_callback_binding_test.dart

| Field | Value |
|-------|-------|
| **Index** | 248 |
| **Test Name** | `material/menu_accelerator_callback_binding_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/menu_accelerator_callback_binding_test.dart` triggered 12 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 249: material/navigation_destination_label_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 249 |
| **Test Name** | `material/navigation_destination_label_behavior_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes — Bug-79 FIXED, verify edge cases |
| **Description** | Non-exhaustive switch expression — Bug-79 FIXED, edge case |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/navigation_destination_label_behavior_test.dart` uses a switch expression that the interpreter considers non-exhaustive. Bug-79 is FIXED; verify this is a remaining edge case.

**Fix Description (Proper Fix):**

Fix the interpreter's switch expression exhaustiveness checking to handle sealed class hierarchies and enum values correctly. Bug-79 is already FIXED; verify remaining cases.

**Needs Deeper Analysis:** No — Bug-79 FIXED, verify edge cases

#### Issue 250: material/navigation_drawer_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 250 |
| **Test Name** | `material/navigation_drawer_theme_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/navigation_drawer_theme_test.dart` triggered 3 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-50

Issues 251–255 of 551

#### Issue 251: material/navigation_rail_label_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 251 |
| **Test Name** | `material/navigation_rail_label_type_test.dart` |
| **Category** | `INTERPRETER-SWITCH` |
| **Immediate Fix Possible** | Yes — Bug-79 FIXED, verify edge cases |
| **Description** | Non-exhaustive switch expression — Bug-79 FIXED, edge case |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/navigation_rail_label_type_test.dart` uses a switch expression that the interpreter considers non-exhaustive. Bug-79 is FIXED; verify this is a remaining edge case.

**Fix Description (Proper Fix):**

Fix the interpreter's switch expression exhaustiveness checking to handle sealed class hierarchies and enum values correctly. Bug-79 is already FIXED; verify remaining cases.

**Needs Deeper Analysis:** No — Bug-79 FIXED, verify edge cases

#### Issue 252: material/paginated_data_table_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 252 |
| **Test Name** | `material/paginated_data_table_state_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/paginated_data_table_state_test.dart` triggered 36 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 253: material/popup_menu_position_test.dart

| Field | Value |
|-------|-------|
| **Index** | 253 |
| **Test Name** | `material/popup_menu_position_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/popup_menu_position_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 254: material/progress_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 254 |
| **Test Name** | `material/progress_indicator_test.dart` |
| **Category** | `FW-PROGRESS-BAR` |
| **Immediate Fix Possible** | Yes — fix script value |
| **Description** | Script passes invalid progress bar value |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/progress_indicator_test.dart` passes an invalid value to a progress indicator. The script needs a value clamped to [0.0, 1.0].

**Fix Description (Proper Fix):**

Fix the test script's progress bar value to be within [0.0, 1.0]. This is a script value error.

**Needs Deeper Analysis:** No — script value fix

#### Issue 255: material/refresh_progress_indicator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 255 |
| **Test Name** | `material/refresh_progress_indicator_test.dart` |
| **Category** | `FW-PROGRESS-BAR` |
| **Immediate Fix Possible** | Yes — fix script value |
| **Description** | Script passes invalid progress bar value |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/refresh_progress_indicator_test.dart` passes an invalid value to a progress indicator. The script needs a value clamped to [0.0, 1.0].

**Fix Description (Proper Fix):**

Fix the test script's progress bar value to be within [0.0, 1.0]. This is a script value error.

**Needs Deeper Analysis:** No — script value fix

---

## Batch-51

Issues 256–260 of 551

#### Issue 256: material/theme_extension_test.dart

| Field | Value |
|-------|-------|
| **Index** | 256 |
| **Test Name** | `material/theme_extension_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/theme_extension_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 257: material/theme_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 257 |
| **Test Name** | `material/theme_mode_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/theme_mode_test.dart` triggered 17 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 258: material/thumb_test.dart

| Field | Value |
|-------|-------|
| **Index** | 258 |
| **Test Name** | `material/thumb_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/thumb_test.dart` triggered 17 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 259: material/time_of_day_format_test.dart

| Field | Value |
|-------|-------|
| **Index** | 259 |
| **Test Name** | `material/time_of_day_format_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/time_of_day_format_test.dart` triggered 47 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 260: material/time_picker_entry_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 260 |
| **Test Name** | `material/time_picker_entry_mode_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/time_picker_entry_mode_test.dart` triggered 32 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

---

## Batch-52

Issues 261–265 of 551

#### Issue 261: material/toggle_buttons_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 261 |
| **Test Name** | `material/toggle_buttons_theme_data_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/toggle_buttons_theme_data_test.dart` triggered 1 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 262: material/toggle_buttons_theme_test.dart

| Field | Value |
|-------|-------|
| **Index** | 262 |
| **Test Name** | `material/toggle_buttons_theme_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/toggle_buttons_theme_test.dart` triggered 1 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 263: material/tooltip_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 263 |
| **Test Name** | `material/tooltip_state_test.dart` |
| **Category** | `FW-ASSERTION` |
| **Immediate Fix Possible** | Maybe — investigate assertion context |
| **Description** | Flutter framework assertion failure |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `material/tooltip_state_test.dart` triggered a Flutter framework assertion. The interpreter's widget lifecycle or state management violates a framework invariant.

**Fix Description (Proper Fix):**

Investigate and fix the specific Flutter assertion trigger. The interpreter's widget lifecycle management may need adjustment to satisfy framework invariants.

**Needs Deeper Analysis:** Yes — investigate specific assertion

#### Issue 264: painting/axis_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 264 |
| **Test Name** | `painting/axis_direction_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe — fix null-check before dispatch |
| **Description** | Method invocation on null — interpreter null-check gap |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `painting/axis_direction_test.dart` invokes a method on null. The interpreter's null-safety check before method dispatch is missing.

**Fix Description (Proper Fix):**

Fix the interpreter's null-safety checking for method invocations. Add proper null-check propagation before method dispatch.

**Needs Deeper Analysis:** Maybe — check script null safety

#### Issue 265: painting/axis_test.dart

| Field | Value |
|-------|-------|
| **Index** | 265 |
| **Test Name** | `painting/axis_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 0 |
| **Suite** | `hardly_relevant_classes_2_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `painting/axis_test.dart` triggered 3 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-53

Issues 266–270 of 551

#### Issue 266: rendering/floating_header_snap_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 266 |
| **Test Name** | `rendering/floating_header_snap_configuration_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/floating_header_snap_configuration_test.dart` triggered 1 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 267: rendering/hit_test_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 267 |
| **Test Name** | `rendering/hit_test_behavior_test.dart` |
| **Category** | `INTERPRETER-NULL-INVOKE` |
| **Immediate Fix Possible** | Maybe — fix null-check before dispatch |
| **Description** | Method invocation on null — interpreter null-check gap |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/hit_test_behavior_test.dart` invokes a method on null. The interpreter's null-safety check before method dispatch is missing.

**Fix Description (Proper Fix):**

Fix the interpreter's null-safety checking for method invocations. Add proper null-check propagation before method dispatch.

**Needs Deeper Analysis:** Maybe — check script null safety

#### Issue 268: rendering/over_scroll_header_stretch_configuration_test.dart

| Field | Value |
|-------|-------|
| **Index** | 268 |
| **Test Name** | `rendering/over_scroll_header_stretch_configuration_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/over_scroll_header_stretch_configuration_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 269: rendering/pipeline_manifold_test.dart

| Field | Value |
|-------|-------|
| **Index** | 269 |
| **Test Name** | `rendering/pipeline_manifold_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/pipeline_manifold_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_manifold` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 270: rendering/placeholder_span_index_semantics_tag_test.dart

| Field | Value |
|-------|-------|
| **Index** | 270 |
| **Test Name** | `rendering/placeholder_span_index_semantics_tag_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/placeholder_span_index_semantics_tag_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tags` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-54

Issues 271–275 of 551

#### Issue 271: rendering/platform_view_render_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 271 |
| **Test Name** | `rendering/platform_view_render_box_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/platform_view_render_box_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_controller` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 272: rendering/render_abstract_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 272 |
| **Test Name** | `rendering/render_abstract_viewport_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_abstract_viewport_test.dart` triggered 1 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 273: rendering/render_android_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 273 |
| **Test Name** | `rendering/render_android_view_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_android_view_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 274: rendering/render_animated_opacity_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 274 |
| **Test Name** | `rendering/render_animated_opacity_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_animated_opacity_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_curvedAnimation` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 275: rendering/render_animated_size_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 275 |
| **Test Name** | `rendering/render_animated_size_state_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_animated_size_state_test.dart` triggered 2 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

---

## Batch-55

Issues 276–280 of 551

#### Issue 276: rendering/render_clip_r_superellipse_test.dart

| Field | Value |
|-------|-------|
| **Index** | 276 |
| **Test Name** | `rendering/render_clip_r_superellipse_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_clip_r_superellipse_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 277: rendering/render_editable_painter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 277 |
| **Test Name** | `rendering/render_editable_painter_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_editable_painter_test.dart` triggered 3 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 278: rendering/render_sliver_box_child_manager_test.dart

| Field | Value |
|-------|-------|
| **Index** | 278 |
| **Test Name** | `rendering/render_sliver_box_child_manager_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH-FW` |
| **Immediate Fix Possible** | Yes — add type coercion in bridge generator |
| **Description** | Type mismatch in framework call (bridge coercion gap) |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_sliver_box_child_manager_test.dart` fails due to a collection type mismatch in a framework call (e.g., `List<Object?>` passed where `List<Widget>` expected). The bridge generator must emit `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` at the call site.

**Fix Description (Proper Fix):**

Fix the bridge generator's type coercion to handle framework collection types. Add `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` calls in the bridge adapter, or implement native coercion in the generator.

**Needs Deeper Analysis:** No — add coercion in bridge generator

#### Issue 279: rendering/render_sliver_floating_pinned_persistent_header_test.dart

| Field | Value |
|-------|-------|
| **Index** | 279 |
| **Test Name** | `rendering/render_sliver_floating_pinned_persistent_header_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_sliver_floating_pinned_persistent_header_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 280: rendering/render_ui_kit_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 280 |
| **Test Name** | `rendering/render_ui_kit_view_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `rendering/render_ui_kit_view_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

---

## Batch-56

Issues 281–285 of 551

#### Issue 281: services/message_codec_test.dart

| Field | Value |
|-------|-------|
| **Index** | 281 |
| **Test Name** | `services/message_codec_test.dart` |
| **Category** | `BRIDGE-MISSING-PROPERTY` |
| **Immediate Fix Possible** | Yes — add property to bridge generator |
| **Description** | Bridge missing property/getter/setter |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `services/message_codec_test.dart` accesses a property that is not emitted in the bridge class. The bridge generator must add this getter/setter.

**Fix Description (Proper Fix):**

Add the missing property to the bridge class definition. Update the bridge generator to emit the getter/setter.

**Needs Deeper Analysis:** No — add property to bridge generator

#### Issue 282: services/method_codec_test.dart

| Field | Value |
|-------|-------|
| **Index** | 282 |
| **Test Name** | `services/method_codec_test.dart` |
| **Category** | `BRIDGE-MISSING-PROPERTY` |
| **Immediate Fix Possible** | Yes — add property to bridge generator |
| **Description** | Bridge missing property/getter/setter |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `services/method_codec_test.dart` accesses a property that is not emitted in the bridge class. The bridge generator must add this getter/setter.

**Fix Description (Proper Fix):**

Add the missing property to the bridge class definition. Update the bridge generator to emit the getter/setter.

**Needs Deeper Analysis:** No — add property to bridge generator

#### Issue 283: services/raw_key_up_event_test.dart

| Field | Value |
|-------|-------|
| **Index** | 283 |
| **Test Name** | `services/raw_key_up_event_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_3_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `services/raw_key_up_event_test.dart` triggered 15 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 284: widgets/action_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 284 |
| **Test Name** | `widgets/action_listener_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/action_listener_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_dispatcher` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 285: widgets/align_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 285 |
| **Test Name** | `widgets/align_transition_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/align_transition_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_alignmentAnimation` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-57

Issues 286–290 of 551

#### Issue 286: widgets/android_view_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 286 |
| **Test Name** | `widgets/android_view_surface_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes — add type to bridge generator configuration |
| **Description** | Bridge missing type/class definition |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/android_view_surface_test.dart` references a type that has no bridge definition. The type must be added to the bridge generator's module configuration.

**Fix Description (Proper Fix):**

Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file.

**Needs Deeper Analysis:** No — add type to bridge configuration

#### Issue 287: widgets/animated_positioned_directional_test.dart

| Field | Value |
|-------|-------|
| **Index** | 287 |
| **Test Name** | `widgets/animated_positioned_directional_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/animated_positioned_directional_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 288: widgets/app_kit_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 288 |
| **Test Name** | `widgets/app_kit_view_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes — add type to bridge generator configuration |
| **Description** | Bridge missing type/class definition |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/app_kit_view_test.dart` references a type that has no bridge definition. The type must be added to the bridge generator's module configuration.

**Fix Description (Proper Fix):**

Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file.

**Needs Deeper Analysis:** No — add type to bridge configuration

#### Issue 289: widgets/autocomplete_highlighted_option_test.dart

| Field | Value |
|-------|-------|
| **Index** | 289 |
| **Test Name** | `widgets/autocomplete_highlighted_option_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/autocomplete_highlighted_option_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 290: widgets/autofill_group_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 290 |
| **Test Name** | `widgets/autofill_group_state_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/autofill_group_state_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

---

## Batch-58

Issues 291–295 of 551

#### Issue 291: widgets/automatic_keep_alive_client_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 291 |
| **Test Name** | `widgets/automatic_keep_alive_client_mixin_test.dart` |
| **Category** | `FW-LAYOUT-CONSTRAINT` |
| **Immediate Fix Possible** | Maybe — fix constraint propagation in interpreter |
| **Description** | Layout constraint error in interpreted widget tree |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/automatic_keep_alive_client_mixin_test.dart` triggered 51 layout constraint error(s) (e.g., negative minimum height/width). The interpreter's constraint propagation through the widget tree does not match native Flutter's behavior.

**Fix Description (Proper Fix):**

Fix the layout constraint handling in the interpreter's widget tree construction. The interpreter should propagate constraints correctly through the widget tree, matching native Flutter behavior.

**Needs Deeper Analysis:** Maybe — check if constraint propagation fix resolves pattern

#### Issue 292: widgets/back_button_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 292 |
| **Test Name** | `widgets/back_button_listener_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/back_button_listener_test.dart` triggered an uncategorized framework error. Requires individual investigation of the specific error context.

**Fix Description (Proper Fix):**

Investigate the specific framework error and fix the root cause in the interpreter or bridge layer.

**Needs Deeper Analysis:** Yes — individual investigation needed

#### Issue 293: widgets/backdrop_group_test.dart

| Field | Value |
|-------|-------|
| **Index** | 293 |
| **Test Name** | `widgets/backdrop_group_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/backdrop_group_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 294: widgets/border_tween_test.dart

| Field | Value |
|-------|-------|
| **Index** | 294 |
| **Test Name** | `widgets/border_tween_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/border_tween_test.dart` triggered an uncategorized framework error. Requires individual investigation of the specific error context.

**Fix Description (Proper Fix):**

Investigate the specific framework error and fix the root cause in the interpreter or bridge layer.

**Needs Deeper Analysis:** Yes — individual investigation needed

#### Issue 295: widgets/box_scroll_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 295 |
| **Test Name** | `widgets/box_scroll_view_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/box_scroll_view_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

---

## Batch-59

Issues 296–300 of 551

#### Issue 296: widgets/clip_r_superellipse_test.dart

| Field | Value |
|-------|-------|
| **Index** | 296 |
| **Test Name** | `widgets/clip_r_superellipse_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/clip_r_superellipse_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_pulse` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 297: widgets/constrained_layout_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 297 |
| **Test Name** | `widgets/constrained_layout_builder_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/constrained_layout_builder_test.dart` triggered 9 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 298: widgets/constraints_transform_box_test.dart

| Field | Value |
|-------|-------|
| **Index** | 298 |
| **Test Name** | `widgets/constraints_transform_box_test.dart` |
| **Category** | `FW-OTHER` |
| **Immediate Fix Possible** | Needs investigation |
| **Description** | Uncategorized framework error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/constraints_transform_box_test.dart` triggered an uncategorized framework error. Requires individual investigation of the specific error context.

**Fix Description (Proper Fix):**

Investigate the specific framework error and fix the root cause in the interpreter or bridge layer.

**Needs Deeper Analysis:** Yes — individual investigation needed

#### Issue 299: widgets/context_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 299 |
| **Test Name** | `widgets/context_action_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/context_action_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `InterpretedInstance` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 300: widgets/default_selection_style_test.dart

| Field | Value |
|-------|-------|
| **Index** | 300 |
| **Test Name** | `widgets/default_selection_style_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/default_selection_style_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

---

## Batch-60

Issues 301–305 of 551

#### Issue 301: widgets/default_text_editing_shortcuts_test.dart

| Field | Value |
|-------|-------|
| **Index** | 301 |
| **Test Name** | `widgets/default_text_editing_shortcuts_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/default_text_editing_shortcuts_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 302: widgets/default_text_style_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 302 |
| **Test Name** | `widgets/default_text_style_transition_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/default_text_style_transition_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_heroStyle` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 303: widgets/draggable_scrollable_actuator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 303 |
| **Test Name** | `widgets/draggable_scrollable_actuator_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/draggable_scrollable_actuator_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 304: widgets/expansible_test.dart

| Field | Value |
|-------|-------|
| **Index** | 304 |
| **Test Name** | `widgets/expansible_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/expansible_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 305: widgets/extend_selection_to_line_break_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 305 |
| **Test Name** | `widgets/extend_selection_to_line_break_intent_test.dart` |
| **Category** | `TRANSPORT-ERROR` |
| **Immediate Fix Possible** | No — requires transport layer debugging |
| **Description** | Direct HTTP transport failure |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | transport_error (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_to_line_break_intent_test.dart` encountered a direct transport/HTTP error. This is an infrastructure-level failure in the test runner's HTTP endpoint. Debug the server-side handler.

**Fix Description (Proper Fix):**

Fix the HTTP transport layer to handle the specific failure mode. Debug the server-side test runner endpoint to identify why the request fails.

**Needs Deeper Analysis:** Yes — debug HTTP transport layer

---

## Batch-61

Issues 306–310 of 551

#### Issue 306: widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 306 |
| **Test Name** | `widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 307: widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 307 |
| **Test Name** | `widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 308: widgets/extend_selection_to_next_word_boundary_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 308 |
| **Test Name** | `widgets/extend_selection_to_next_word_boundary_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_to_next_word_boundary_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 309: widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 309 |
| **Test Name** | `widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 310: widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 310 |
| **Test Name** | `widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-62

Issues 311–315 of 551

#### Issue 311: widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 311 |
| **Test Name** | `widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 312: widgets/feedback_test.dart

| Field | Value |
|-------|-------|
| **Index** | 312 |
| **Test Name** | `widgets/feedback_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/feedback_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 313: widgets/fixed_scroll_metrics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 313 |
| **Test Name** | `widgets/fixed_scroll_metrics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/fixed_scroll_metrics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 314: widgets/flex_test.dart

| Field | Value |
|-------|-------|
| **Index** | 314 |
| **Test Name** | `widgets/flex_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/flex_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 315: widgets/floating_header_snap_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 315 |
| **Test Name** | `widgets/floating_header_snap_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/floating_header_snap_mode_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-63

Issues 316–320 of 551

#### Issue 316: widgets/focus_attachment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 316 |
| **Test Name** | `widgets/focus_attachment_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/focus_attachment_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 317: widgets/focus_highlight_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 317 |
| **Test Name** | `widgets/focus_highlight_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/focus_highlight_mode_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 318: widgets/focus_highlight_strategy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 318 |
| **Test Name** | `widgets/focus_highlight_strategy_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/focus_highlight_strategy_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 319: widgets/focus_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 319 |
| **Test Name** | `widgets/focus_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/focus_order_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 320: widgets/focus_scope_node_test.dart

| Field | Value |
|-------|-------|
| **Index** | 320 |
| **Test Name** | `widgets/focus_scope_node_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/focus_scope_node_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-64

Issues 321–325 of 551

#### Issue 321: widgets/focus_traversal_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 321 |
| **Test Name** | `widgets/focus_traversal_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/focus_traversal_order_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 322: widgets/fractional_translation_test.dart

| Field | Value |
|-------|-------|
| **Index** | 322 |
| **Test Name** | `widgets/fractional_translation_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/fractional_translation_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 323: widgets/gesture_recognizer_factory_test.dart

| Field | Value |
|-------|-------|
| **Index** | 323 |
| **Test Name** | `widgets/gesture_recognizer_factory_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/gesture_recognizer_factory_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 324: widgets/gesture_recognizer_factory_with_handlers_test.dart

| Field | Value |
|-------|-------|
| **Index** | 324 |
| **Test Name** | `widgets/gesture_recognizer_factory_with_handlers_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/gesture_recognizer_factory_with_handlers_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 325: widgets/global_object_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 325 |
| **Test Name** | `widgets/global_object_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/global_object_key_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-65

Issues 326–330 of 551

#### Issue 326: widgets/hero_controller_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 326 |
| **Test Name** | `widgets/hero_controller_scope_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/hero_controller_scope_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 327: widgets/hero_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 327 |
| **Test Name** | `widgets/hero_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/hero_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 328: widgets/hero_flight_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 328 |
| **Test Name** | `widgets/hero_flight_direction_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/hero_flight_direction_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 329: widgets/hold_scroll_activity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 329 |
| **Test Name** | `widgets/hold_scroll_activity_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/hold_scroll_activity_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 330: widgets/i_o_s_system_context_menu_item_copy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 330 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_copy_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_copy_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-66

Issues 331–335 of 551

#### Issue 331: widgets/i_o_s_system_context_menu_item_custom_test.dart

| Field | Value |
|-------|-------|
| **Index** | 331 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_custom_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_custom_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 332: widgets/i_o_s_system_context_menu_item_cut_test.dart

| Field | Value |
|-------|-------|
| **Index** | 332 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_cut_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_cut_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 333: widgets/i_o_s_system_context_menu_item_live_text_test.dart

| Field | Value |
|-------|-------|
| **Index** | 333 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_live_text_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_live_text_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 334: widgets/i_o_s_system_context_menu_item_look_up_test.dart

| Field | Value |
|-------|-------|
| **Index** | 334 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_look_up_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_look_up_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 335: widgets/i_o_s_system_context_menu_item_paste_test.dart

| Field | Value |
|-------|-------|
| **Index** | 335 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_paste_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_paste_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-67

Issues 336–340 of 551

#### Issue 336: widgets/i_o_s_system_context_menu_item_search_web_test.dart

| Field | Value |
|-------|-------|
| **Index** | 336 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_search_web_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_search_web_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 337: widgets/i_o_s_system_context_menu_item_select_all_test.dart

| Field | Value |
|-------|-------|
| **Index** | 337 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_select_all_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_select_all_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 338: widgets/i_o_s_system_context_menu_item_share_test.dart

| Field | Value |
|-------|-------|
| **Index** | 338 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_share_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_share_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 339: widgets/i_o_s_system_context_menu_item_test.dart

| Field | Value |
|-------|-------|
| **Index** | 339 |
| **Test Name** | `widgets/i_o_s_system_context_menu_item_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/i_o_s_system_context_menu_item_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 340: widgets/icon_data_property_test.dart

| Field | Value |
|-------|-------|
| **Index** | 340 |
| **Test Name** | `widgets/icon_data_property_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/icon_data_property_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-68

Issues 341–345 of 551

#### Issue 341: widgets/icon_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 341 |
| **Test Name** | `widgets/icon_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/icon_data_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 342: widgets/icon_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 342 |
| **Test Name** | `widgets/icon_theme_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/icon_theme_data_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 343: widgets/idle_scroll_activity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 343 |
| **Test Name** | `widgets/idle_scroll_activity_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/idle_scroll_activity_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 344: widgets/ignore_baseline_test.dart

| Field | Value |
|-------|-------|
| **Index** | 344 |
| **Test Name** | `widgets/ignore_baseline_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/ignore_baseline_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 345: widgets/image_icon_test.dart

| Field | Value |
|-------|-------|
| **Index** | 345 |
| **Test Name** | `widgets/image_icon_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/image_icon_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-69

Issues 346–350 of 551

#### Issue 346: widgets/img_element_platform_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 346 |
| **Test Name** | `widgets/img_element_platform_view_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/img_element_platform_view_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 347: widgets/indexed_slot_test.dart

| Field | Value |
|-------|-------|
| **Index** | 347 |
| **Test Name** | `widgets/indexed_slot_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/indexed_slot_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 348: widgets/inherited_model_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 348 |
| **Test Name** | `widgets/inherited_model_element_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inherited_model_element_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 349: widgets/inspector_button_test.dart

| Field | Value |
|-------|-------|
| **Index** | 349 |
| **Test Name** | `widgets/inspector_button_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inspector_button_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 350: widgets/inspector_button_variant_test.dart

| Field | Value |
|-------|-------|
| **Index** | 350 |
| **Test Name** | `widgets/inspector_button_variant_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inspector_button_variant_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-70

Issues 351–355 of 551

#### Issue 351: widgets/inspector_reference_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 351 |
| **Test Name** | `widgets/inspector_reference_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inspector_reference_data_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 352: widgets/inspector_selection_test.dart

| Field | Value |
|-------|-------|
| **Index** | 352 |
| **Test Name** | `widgets/inspector_selection_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inspector_selection_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 353: widgets/inspector_serialization_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 353 |
| **Test Name** | `widgets/inspector_serialization_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/inspector_serialization_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 354: widgets/keep_alive_handle_test.dart

| Field | Value |
|-------|-------|
| **Index** | 354 |
| **Test Name** | `widgets/keep_alive_handle_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/keep_alive_handle_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 355: widgets/keep_alive_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 355 |
| **Test Name** | `widgets/keep_alive_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/keep_alive_notification_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-71

Issues 356–360 of 551

#### Issue 356: widgets/key_event_result_test.dart

| Field | Value |
|-------|-------|
| **Index** | 356 |
| **Test Name** | `widgets/key_event_result_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/key_event_result_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 357: widgets/key_set_test.dart

| Field | Value |
|-------|-------|
| **Index** | 357 |
| **Test Name** | `widgets/key_set_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/key_set_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 358: widgets/keyboard_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 358 |
| **Test Name** | `widgets/keyboard_listener_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/keyboard_listener_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 359: widgets/labeled_global_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 359 |
| **Test Name** | `widgets/labeled_global_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/labeled_global_key_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 360: widgets/layout_id_test.dart

| Field | Value |
|-------|-------|
| **Index** | 360 |
| **Test Name** | `widgets/layout_id_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/layout_id_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-72

Issues 361–365 of 551

#### Issue 361: widgets/lexical_focus_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 361 |
| **Test Name** | `widgets/lexical_focus_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/lexical_focus_order_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 362: widgets/live_text_input_status_notifier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 362 |
| **Test Name** | `widgets/live_text_input_status_notifier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/live_text_input_status_notifier_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 363: widgets/live_text_input_status_test.dart

| Field | Value |
|-------|-------|
| **Index** | 363 |
| **Test Name** | `widgets/live_text_input_status_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/live_text_input_status_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 364: widgets/local_history_entry_test.dart

| Field | Value |
|-------|-------|
| **Index** | 364 |
| **Test Name** | `widgets/local_history_entry_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/local_history_entry_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 365: widgets/localizations_resolver_test.dart

| Field | Value |
|-------|-------|
| **Index** | 365 |
| **Test Name** | `widgets/localizations_resolver_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/localizations_resolver_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-73

Issues 366–370 of 551

#### Issue 366: widgets/lock_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 366 |
| **Test Name** | `widgets/lock_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/lock_state_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 367: widgets/logical_key_set_test.dart

| Field | Value |
|-------|-------|
| **Index** | 367 |
| **Test Name** | `widgets/logical_key_set_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/logical_key_set_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 368: widgets/lookup_boundary_test.dart

| Field | Value |
|-------|-------|
| **Index** | 368 |
| **Test Name** | `widgets/lookup_boundary_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/lookup_boundary_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 369: widgets/matrix4_tween_test.dart

| Field | Value |
|-------|-------|
| **Index** | 369 |
| **Test Name** | `widgets/matrix4_tween_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/matrix4_tween_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 370: widgets/matrix_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 370 |
| **Test Name** | `widgets/matrix_transition_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/matrix_transition_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-74

Issues 371–375 of 551

#### Issue 371: widgets/menu_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 371 |
| **Test Name** | `widgets/menu_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/menu_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 372: widgets/menu_serializable_shortcut_test.dart

| Field | Value |
|-------|-------|
| **Index** | 372 |
| **Test Name** | `widgets/menu_serializable_shortcut_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/menu_serializable_shortcut_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 373: widgets/meta_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 373 |
| **Test Name** | `widgets/meta_data_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/meta_data_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 374: widgets/modal_barrier_test.dart

| Field | Value |
|-------|-------|
| **Index** | 374 |
| **Test Name** | `widgets/modal_barrier_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/modal_barrier_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 375: widgets/multi_selectable_selection_container_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 375 |
| **Test Name** | `widgets/multi_selectable_selection_container_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/multi_selectable_selection_container_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-75

Issues 376–380 of 551

#### Issue 376: widgets/navigation_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 376 |
| **Test Name** | `widgets/navigation_mode_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/navigation_mode_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 377: widgets/navigation_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 377 |
| **Test Name** | `widgets/navigation_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/navigation_notification_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 378: widgets/navigator_pop_handler_test.dart

| Field | Value |
|-------|-------|
| **Index** | 378 |
| **Test Name** | `widgets/navigator_pop_handler_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/navigator_pop_handler_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 379: widgets/nested_scroll_view_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 379 |
| **Test Name** | `widgets/nested_scroll_view_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/nested_scroll_view_state_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 380: widgets/nested_scroll_view_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 380 |
| **Test Name** | `widgets/nested_scroll_view_viewport_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/nested_scroll_view_viewport_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-76

Issues 381–385 of 551

#### Issue 381: widgets/next_focus_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 381 |
| **Test Name** | `widgets/next_focus_action_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/next_focus_action_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 382: widgets/next_focus_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 382 |
| **Test Name** | `widgets/next_focus_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/next_focus_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 383: widgets/notifiable_element_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 383 |
| **Test Name** | `widgets/notifiable_element_mixin_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/notifiable_element_mixin_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 384: widgets/notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 384 |
| **Test Name** | `widgets/notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/notification_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 385: widgets/numeric_focus_order_test.dart

| Field | Value |
|-------|-------|
| **Index** | 385 |
| **Test Name** | `widgets/numeric_focus_order_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/numeric_focus_order_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-77

Issues 386–390 of 551

#### Issue 386: widgets/object_key_test.dart

| Field | Value |
|-------|-------|
| **Index** | 386 |
| **Test Name** | `widgets/object_key_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/object_key_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 387: widgets/options_view_open_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 387 |
| **Test Name** | `widgets/options_view_open_direction_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/options_view_open_direction_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 388: widgets/ordered_traversal_policy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 388 |
| **Test Name** | `widgets/ordered_traversal_policy_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/ordered_traversal_policy_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 389: widgets/orientation_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 389 |
| **Test Name** | `widgets/orientation_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/orientation_builder_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 390: widgets/orientation_test.dart

| Field | Value |
|-------|-------|
| **Index** | 390 |
| **Test Name** | `widgets/orientation_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/orientation_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-78

Issues 391–395 of 551

#### Issue 391: widgets/overflow_bar_alignment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 391 |
| **Test Name** | `widgets/overflow_bar_alignment_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overflow_bar_alignment_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 392: widgets/overlay_child_layout_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 392 |
| **Test Name** | `widgets/overlay_child_layout_info_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overlay_child_layout_info_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 393: widgets/overlay_child_location_test.dart

| Field | Value |
|-------|-------|
| **Index** | 393 |
| **Test Name** | `widgets/overlay_child_location_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overlay_child_location_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 394: widgets/overlay_portal_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 394 |
| **Test Name** | `widgets/overlay_portal_controller_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overlay_portal_controller_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 395: widgets/overlay_portal_test.dart

| Field | Value |
|-------|-------|
| **Index** | 395 |
| **Test Name** | `widgets/overlay_portal_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overlay_portal_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-79

Issues 396–400 of 551

#### Issue 396: widgets/overlay_route_test.dart

| Field | Value |
|-------|-------|
| **Index** | 396 |
| **Test Name** | `widgets/overlay_route_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overlay_route_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 397: widgets/overlay_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 397 |
| **Test Name** | `widgets/overlay_state_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overlay_state_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 398: widgets/overscroll_indicator_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 398 |
| **Test Name** | `widgets/overscroll_indicator_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overscroll_indicator_notification_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 399: widgets/overscroll_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 399 |
| **Test Name** | `widgets/overscroll_notification_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/overscroll_notification_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 400: widgets/page_metrics_test.dart

| Field | Value |
|-------|-------|
| **Index** | 400 |
| **Test Name** | `widgets/page_metrics_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_metrics_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-80

Issues 401–405 of 551

#### Issue 401: widgets/page_route_builder_test.dart

| Field | Value |
|-------|-------|
| **Index** | 401 |
| **Test Name** | `widgets/page_route_builder_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_route_builder_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 402: widgets/page_test.dart

| Field | Value |
|-------|-------|
| **Index** | 402 |
| **Test Name** | `widgets/page_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/page_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 403: widgets/pan_axis_test.dart

| Field | Value |
|-------|-------|
| **Index** | 403 |
| **Test Name** | `widgets/pan_axis_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/pan_axis_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 404: widgets/paste_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 404 |
| **Test Name** | `widgets/paste_text_intent_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/paste_text_intent_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 405: widgets/platform_menu_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 405 |
| **Test Name** | `widgets/platform_menu_delegate_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_menu_delegate_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-81

Issues 406–410 of 551

#### Issue 406: widgets/platform_provided_menu_item_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 406 |
| **Test Name** | `widgets/platform_provided_menu_item_type_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_provided_menu_item_type_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 407: widgets/platform_route_information_provider_test.dart

| Field | Value |
|-------|-------|
| **Index** | 407 |
| **Test Name** | `widgets/platform_route_information_provider_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_route_information_provider_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 408: widgets/platform_selectable_region_context_menu_test.dart

| Field | Value |
|-------|-------|
| **Index** | 408 |
| **Test Name** | `widgets/platform_selectable_region_context_menu_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_selectable_region_context_menu_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 409: widgets/platform_view_creation_params_test.dart

| Field | Value |
|-------|-------|
| **Index** | 409 |
| **Test Name** | `widgets/platform_view_creation_params_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/platform_view_creation_params_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

#### Issue 410: widgets/pop_entry_test.dart

| Field | Value |
|-------|-------|
| **Index** | 410 |
| **Test Name** | `widgets/pop_entry_test.dart` |
| **Category** | `TRANSPORT-CASCADE` |
| **Immediate Fix Possible** | No — fix root transport error first; cascades resolve automatically |
| **Description** | Cascade failure from upstream transport error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_4_test` |
| **Status** | clear_failed (HTTP 0) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/pop_entry_test.dart` failed as a cascade effect of an upstream transport error. The test itself is likely correct; the failure propagates from a broken HTTP connection to the test runner. No script-level fix needed — the transport layer must be fixed.

**Fix Description (Proper Fix):**

Fix the upstream transport error that triggers the cascade. Investigate HTTP transport layer for the root cause of the 2 transport failures; once resolved, all 249 cascade issues disappear.

**Needs Deeper Analysis:** No — fix transport errors first

---

## Batch-82

Issues 411–415 of 551

#### Issue 411: widgets/raw_dialog_route_test.dart

| Field | Value |
|-------|-------|
| **Index** | 411 |
| **Test Name** | `widgets/raw_dialog_route_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH-FW` |
| **Immediate Fix Possible** | Yes — add type coercion in bridge generator |
| **Description** | Type mismatch in framework call (bridge coercion gap) |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/raw_dialog_route_test.dart` fails due to a collection type mismatch in a framework call (e.g., `List<Object?>` passed where `List<Widget>` expected). The bridge generator must emit `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` at the call site.

**Fix Description (Proper Fix):**

Fix the bridge generator's type coercion to handle framework collection types. Add `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` calls in the bridge adapter, or implement native coercion in the generator.

**Needs Deeper Analysis:** No — add coercion in bridge generator

#### Issue 412: widgets/raw_keyboard_listener_test.dart

| Field | Value |
|-------|-------|
| **Index** | 412 |
| **Test Name** | `widgets/raw_keyboard_listener_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes — add type to bridge generator configuration |
| **Description** | Bridge missing type/class definition |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/raw_keyboard_listener_test.dart` references a type that has no bridge definition. The type must be added to the bridge generator's module configuration.

**Fix Description (Proper Fix):**

Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file.

**Needs Deeper Analysis:** No — add type to bridge configuration

#### Issue 413: widgets/raw_menu_overlay_info_test.dart

| Field | Value |
|-------|-------|
| **Index** | 413 |
| **Test Name** | `widgets/raw_menu_overlay_info_test.dart` |
| **Category** | `BRIDGE-NOT-CALLABLE` |
| **Immediate Fix Possible** | Yes — add constructor to bridge |
| **Description** | Bridge missing constructor (type not callable) |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/raw_menu_overlay_info_test.dart` tries to construct a type that has no callable constructor in its bridge. The bridge generator must emit a constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge so the type becomes callable. Update bridge generator to emit constructors for this class.

**Needs Deeper Analysis:** No — add constructor to bridge

#### Issue 414: widgets/raw_radio_test.dart

| Field | Value |
|-------|-------|
| **Index** | 414 |
| **Test Name** | `widgets/raw_radio_test.dart` |
| **Category** | `BRIDGE-NATIVE-ERROR` |
| **Immediate Fix Possible** | Maybe — fix argument coercion in bridge adapter |
| **Description** | Native error during bridged method call |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/raw_radio_test.dart` triggers a native error during a bridged method call. The bridge adapter's argument coercion or null-safety is incomplete for this method.

**Fix Description (Proper Fix):**

Fix the bridge method adapter to handle the specific native error. Add proper argument coercion or null-safety checks in the bridge generator's method emission.

**Needs Deeper Analysis:** Maybe — depends on native error specifics

#### Issue 415: widgets/redo_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 415 |
| **Test Name** | `widgets/redo_text_intent_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/redo_text_intent_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

---

## Batch-83

Issues 416–420 of 551

#### Issue 416: widgets/regular_window_controller_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 416 |
| **Test Name** | `widgets/regular_window_controller_delegate_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/regular_window_controller_delegate_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 417: widgets/regular_window_controller_linux_test.dart

| Field | Value |
|-------|-------|
| **Index** | 417 |
| **Test Name** | `widgets/regular_window_controller_linux_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/regular_window_controller_linux_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 418: widgets/regular_window_controller_mac_o_s_test.dart

| Field | Value |
|-------|-------|
| **Index** | 418 |
| **Test Name** | `widgets/regular_window_controller_mac_o_s_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/regular_window_controller_mac_o_s_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 419: widgets/regular_window_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 419 |
| **Test Name** | `widgets/regular_window_controller_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/regular_window_controller_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 420: widgets/regular_window_controller_win32_test.dart

| Field | Value |
|-------|-------|
| **Index** | 420 |
| **Test Name** | `widgets/regular_window_controller_win32_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/regular_window_controller_win32_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

---

## Batch-84

Issues 421–425 of 551

#### Issue 421: widgets/regular_window_test.dart

| Field | Value |
|-------|-------|
| **Index** | 421 |
| **Test Name** | `widgets/regular_window_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/regular_window_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 422: widgets/relative_positioned_transition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 422 |
| **Test Name** | `widgets/relative_positioned_transition_test.dart` |
| **Category** | `FW-LAYOUT-OVERFLOW` |
| **Immediate Fix Possible** | Maybe — fix flex layout resolution in interpreter |
| **Description** | Layout overflow in interpreted flex layout |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/relative_positioned_transition_test.dart` triggered 4 layout overflow/unbounded flex error(s). The interpreter's flex layout resolution does not properly bound child widgets.

**Fix Description (Proper Fix):**

Fix the interpreter's flex layout resolution to respect bounded constraints. Ensure Expanded/Flexible widgets receive proper bounds from their parent during interpreted layout.

**Needs Deeper Analysis:** Maybe — check if flex layout fix resolves pattern

#### Issue 423: widgets/render_abstract_layout_builder_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 423 |
| **Test Name** | `widgets/render_abstract_layout_builder_mixin_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_abstract_layout_builder_mixin_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 424: widgets/render_nested_scroll_view_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 424 |
| **Test Name** | `widgets/render_nested_scroll_view_viewport_test.dart` |
| **Category** | `INTERPRETER-GENERIC-INFERENCE` |
| **Immediate Fix Possible** | No — requires type solver improvement (Issue #1) |
| **Description** | Generic type inference Issue #1 (`List<Object?>` vs `List<Widget>`) |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_nested_scroll_view_viewport_test.dart` fails due to generic type inference (Issue #1): the interpreter infers `List<Object?>` instead of `List<Widget>`. The interpreter's type constraint solver must be improved.

**Fix Description (Proper Fix):**

Fix the interpreter's generic type inference (Issue #1) so that `List<Widget>` is inferred instead of `List<Object?>`. Improve the type constraint solver in the interpreter.

**Needs Deeper Analysis:** Yes — Issue #1, type solver improvement

#### Issue 425: widgets/render_object_to_widget_adapter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 425 |
| **Test Name** | `widgets/render_object_to_widget_adapter_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_object_to_widget_adapter_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

---

## Batch-85

Issues 426–430 of 551

#### Issue 426: widgets/render_tap_region_surface_test.dart

| Field | Value |
|-------|-------|
| **Index** | 426 |
| **Test Name** | `widgets/render_tap_region_surface_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_tap_region_surface_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 427: widgets/render_tap_region_test.dart

| Field | Value |
|-------|-------|
| **Index** | 427 |
| **Test Name** | `widgets/render_tap_region_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_tap_region_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 428: widgets/render_tree_root_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 428 |
| **Test Name** | `widgets/render_tree_root_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_tree_root_element_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `unknown` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 429: widgets/render_two_dimensional_viewport_test.dart

| Field | Value |
|-------|-------|
| **Index** | 429 |
| **Test Name** | `widgets/render_two_dimensional_viewport_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_two_dimensional_viewport_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 430: widgets/render_web_image_test.dart

| Field | Value |
|-------|-------|
| **Index** | 430 |
| **Test Name** | `widgets/render_web_image_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/render_web_image_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-86

Issues 431–435 of 551

#### Issue 431: widgets/repeat_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 431 |
| **Test Name** | `widgets/repeat_mode_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/repeat_mode_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 432: widgets/replace_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 432 |
| **Test Name** | `widgets/replace_text_intent_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/replace_text_intent_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 433: widgets/request_focus_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 433 |
| **Test Name** | `widgets/request_focus_action_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/request_focus_action_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 434: widgets/request_focus_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 434 |
| **Test Name** | `widgets/request_focus_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/request_focus_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 435: widgets/restorable_bool_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 435 |
| **Test Name** | `widgets/restorable_bool_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_bool_n_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-87

Issues 436–440 of 551

#### Issue 436: widgets/restorable_date_time_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 436 |
| **Test Name** | `widgets/restorable_date_time_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_date_time_n_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 437: widgets/restorable_double_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 437 |
| **Test Name** | `widgets/restorable_double_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_double_n_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 438: widgets/restorable_enum_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 438 |
| **Test Name** | `widgets/restorable_enum_n_test.dart` |
| **Category** | `BRIDGE-MISSING-TYPE` |
| **Immediate Fix Possible** | Yes — add type to bridge generator configuration |
| **Description** | Bridge missing type/class definition |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_enum_n_test.dart` references a type that has no bridge definition. The type must be added to the bridge generator's module configuration.

**Fix Description (Proper Fix):**

Add the missing type/class to the bridge generator's known types. Register it in the appropriate module bridge file.

**Needs Deeper Analysis:** No — add type to bridge configuration

#### Issue 439: widgets/restorable_int_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 439 |
| **Test Name** | `widgets/restorable_int_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_int_n_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 440: widgets/restorable_listenable_test.dart

| Field | Value |
|-------|-------|
| **Index** | 440 |
| **Test Name** | `widgets/restorable_listenable_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_listenable_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-88

Issues 441–445 of 551

#### Issue 441: widgets/restorable_num_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 441 |
| **Test Name** | `widgets/restorable_num_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_num_n_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 442: widgets/restorable_num_test.dart

| Field | Value |
|-------|-------|
| **Index** | 442 |
| **Test Name** | `widgets/restorable_num_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_num_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 443: widgets/restorable_route_future_test.dart

| Field | Value |
|-------|-------|
| **Index** | 443 |
| **Test Name** | `widgets/restorable_route_future_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_route_future_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 444: widgets/restorable_string_n_test.dart

| Field | Value |
|-------|-------|
| **Index** | 444 |
| **Test Name** | `widgets/restorable_string_n_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/restorable_string_n_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 445: widgets/root_element_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 445 |
| **Test Name** | `widgets/root_element_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/root_element_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-89

Issues 446–450 of 551

#### Issue 446: widgets/root_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 446 |
| **Test Name** | `widgets/root_render_object_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/root_render_object_element_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 447: widgets/route_information_reporting_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 447 |
| **Test Name** | `widgets/route_information_reporting_type_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/route_information_reporting_type_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 448: widgets/route_information_test.dart

| Field | Value |
|-------|-------|
| **Index** | 448 |
| **Test Name** | `widgets/route_information_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/route_information_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 449: widgets/route_pop_disposition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 449 |
| **Test Name** | `widgets/route_pop_disposition_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/route_pop_disposition_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 450: widgets/route_transition_record_test.dart

| Field | Value |
|-------|-------|
| **Index** | 450 |
| **Test Name** | `widgets/route_transition_record_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/route_transition_record_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-90

Issues 451–455 of 551

#### Issue 451: widgets/router_config_test.dart

| Field | Value |
|-------|-------|
| **Index** | 451 |
| **Test Name** | `widgets/router_config_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/router_config_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 452: widgets/scroll_activity_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 452 |
| **Test Name** | `widgets/scroll_activity_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_activity_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 453: widgets/scroll_activity_test.dart

| Field | Value |
|-------|-------|
| **Index** | 453 |
| **Test Name** | `widgets/scroll_activity_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_activity_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 454: widgets/scroll_context_test.dart

| Field | Value |
|-------|-------|
| **Index** | 454 |
| **Test Name** | `widgets/scroll_context_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_context_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 455: widgets/scroll_deceleration_rate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 455 |
| **Test Name** | `widgets/scroll_deceleration_rate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_deceleration_rate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-91

Issues 456–460 of 551

#### Issue 456: widgets/scroll_drag_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 456 |
| **Test Name** | `widgets/scroll_drag_controller_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_drag_controller_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 457: widgets/scroll_end_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 457 |
| **Test Name** | `widgets/scroll_end_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_end_notification_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 458: widgets/scroll_hold_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 458 |
| **Test Name** | `widgets/scroll_hold_controller_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_hold_controller_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 459: widgets/scroll_increment_details_test.dart

| Field | Value |
|-------|-------|
| **Index** | 459 |
| **Test Name** | `widgets/scroll_increment_details_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_increment_details_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 460: widgets/scroll_increment_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 460 |
| **Test Name** | `widgets/scroll_increment_type_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_increment_type_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-92

Issues 461–465 of 551

#### Issue 461: widgets/scroll_metrics_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 461 |
| **Test Name** | `widgets/scroll_metrics_notification_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_metrics_notification_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 462: widgets/scroll_notification_observer_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 462 |
| **Test Name** | `widgets/scroll_notification_observer_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_notification_observer_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 463: widgets/scroll_notification_observer_test.dart

| Field | Value |
|-------|-------|
| **Index** | 463 |
| **Test Name** | `widgets/scroll_notification_observer_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_notification_observer_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 464: widgets/scroll_position_alignment_policy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 464 |
| **Test Name** | `widgets/scroll_position_alignment_policy_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_position_alignment_policy_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 465: widgets/scroll_position_with_single_context_test.dart

| Field | Value |
|-------|-------|
| **Index** | 465 |
| **Test Name** | `widgets/scroll_position_with_single_context_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_position_with_single_context_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-93

Issues 466–470 of 551

#### Issue 466: widgets/scroll_start_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 466 |
| **Test Name** | `widgets/scroll_start_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_start_notification_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 467: widgets/scroll_to_document_boundary_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 467 |
| **Test Name** | `widgets/scroll_to_document_boundary_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_to_document_boundary_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 468: widgets/scroll_update_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 468 |
| **Test Name** | `widgets/scroll_update_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_update_notification_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 469: widgets/scroll_view_keyboard_dismiss_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 469 |
| **Test Name** | `widgets/scroll_view_keyboard_dismiss_behavior_test.dart` |
| **Category** | `BRIDGE-INTERPRETED-INSTANCE` |
| **Immediate Fix Possible** | Yes — fix bridge generator return-type coercion or add UserBridge |
| **Description** | Bridge returns InterpretedInstance instead of native type |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_view_keyboard_dismiss_behavior_test.dart` fails because the bridge returns an `InterpretedInstance` where a native `native type` is expected. The bridge generator's return-type adapter needs to unwrap interpreted instances to their native bridge type.

**Fix Description (Proper Fix):**

Fix the bridge type resolution so that InterpretedInstance is properly unwrapped to the expected native type. Add proper return-type coercion in the bridge generator's method adapter emission, or implement a UserBridge with explicit type conversion.

**Needs Deeper Analysis:** No — fix bridge generator return-type coercion

#### Issue 470: widgets/scroll_view_test.dart

| Field | Value |
|-------|-------|
| **Index** | 470 |
| **Test Name** | `widgets/scroll_view_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scroll_view_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-94

Issues 471–475 of 551

#### Issue 471: widgets/scrollable_details_test.dart

| Field | Value |
|-------|-------|
| **Index** | 471 |
| **Test Name** | `widgets/scrollable_details_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scrollable_details_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 472: widgets/scrollbar_orientation_test.dart

| Field | Value |
|-------|-------|
| **Index** | 472 |
| **Test Name** | `widgets/scrollbar_orientation_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scrollbar_orientation_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 473: widgets/scrollbar_painter_test.dart

| Field | Value |
|-------|-------|
| **Index** | 473 |
| **Test Name** | `widgets/scrollbar_painter_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/scrollbar_painter_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 474: widgets/select_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 474 |
| **Test Name** | `widgets/select_action_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/select_action_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 475: widgets/select_all_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 475 |
| **Test Name** | `widgets/select_all_text_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/select_all_text_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-95

Issues 476–480 of 551

#### Issue 476: widgets/select_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 476 |
| **Test Name** | `widgets/select_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/select_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 477: widgets/selectable_region_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 477 |
| **Test Name** | `widgets/selectable_region_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selectable_region_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 478: widgets/selection_container_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 478 |
| **Test Name** | `widgets/selection_container_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selection_container_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 479: widgets/selection_details_test.dart

| Field | Value |
|-------|-------|
| **Index** | 479 |
| **Test Name** | `widgets/selection_details_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/selection_details_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 480: widgets/semantics_gesture_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 480 |
| **Test Name** | `widgets/semantics_gesture_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/semantics_gesture_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-96

Issues 481–485 of 551

#### Issue 481: widgets/shortcut_activator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 481 |
| **Test Name** | `widgets/shortcut_activator_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shortcut_activator_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 482: widgets/shortcut_manager_test.dart

| Field | Value |
|-------|-------|
| **Index** | 482 |
| **Test Name** | `widgets/shortcut_manager_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shortcut_manager_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_loggingManager` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 483: widgets/shortcut_map_property_test.dart

| Field | Value |
|-------|-------|
| **Index** | 483 |
| **Test Name** | `widgets/shortcut_map_property_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shortcut_map_property_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabCtrl` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 484: widgets/shortcut_registry_entry_test.dart

| Field | Value |
|-------|-------|
| **Index** | 484 |
| **Test Name** | `widgets/shortcut_registry_entry_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shortcut_registry_entry_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 485: widgets/shortcut_serialization_test.dart

| Field | Value |
|-------|-------|
| **Index** | 485 |
| **Test Name** | `widgets/shortcut_serialization_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/shortcut_serialization_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

---

## Batch-97

Issues 486–490 of 551

#### Issue 486: widgets/single_activator_test.dart

| Field | Value |
|-------|-------|
| **Index** | 486 |
| **Test Name** | `widgets/single_activator_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/single_activator_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 487: widgets/size_changed_layout_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 487 |
| **Test Name** | `widgets/size_changed_layout_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/size_changed_layout_notification_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 488: widgets/sliver_animated_grid_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 488 |
| **Test Name** | `widgets/sliver_animated_grid_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_animated_grid_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 489: widgets/sliver_animated_list_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 489 |
| **Test Name** | `widgets/sliver_animated_list_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_animated_list_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 490: widgets/sliver_child_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 490 |
| **Test Name** | `widgets/sliver_child_builder_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_child_builder_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-98

Issues 491–495 of 551

#### Issue 491: widgets/sliver_child_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 491 |
| **Test Name** | `widgets/sliver_child_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_child_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 492: widgets/sliver_multi_box_adaptor_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 492 |
| **Test Name** | `widgets/sliver_multi_box_adaptor_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_multi_box_adaptor_element_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 493: widgets/sliver_multi_box_adaptor_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 493 |
| **Test Name** | `widgets/sliver_multi_box_adaptor_widget_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_multi_box_adaptor_widget_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 494: widgets/sliver_reorderable_list_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 494 |
| **Test Name** | `widgets/sliver_reorderable_list_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/sliver_reorderable_list_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 495: widgets/slotted_container_render_object_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 495 |
| **Test Name** | `widgets/slotted_container_render_object_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/slotted_container_render_object_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-99

Issues 496–500 of 551

#### Issue 496: widgets/slotted_multi_child_render_object_widget_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 496 |
| **Test Name** | `widgets/slotted_multi_child_render_object_widget_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/slotted_multi_child_render_object_widget_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 497: widgets/slotted_multi_child_render_object_widget_test.dart

| Field | Value |
|-------|-------|
| **Index** | 497 |
| **Test Name** | `widgets/slotted_multi_child_render_object_widget_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/slotted_multi_child_render_object_widget_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 498: widgets/slotted_render_object_element_test.dart

| Field | Value |
|-------|-------|
| **Index** | 498 |
| **Test Name** | `widgets/slotted_render_object_element_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/slotted_render_object_element_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 499: widgets/snapshot_mode_test.dart

| Field | Value |
|-------|-------|
| **Index** | 499 |
| **Test Name** | `widgets/snapshot_mode_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/snapshot_mode_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 500: widgets/standard_component_type_test.dart

| Field | Value |
|-------|-------|
| **Index** | 500 |
| **Test Name** | `widgets/standard_component_type_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/standard_component_type_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-100

Issues 501–505 of 551

#### Issue 501: widgets/static_selection_container_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 501 |
| **Test Name** | `widgets/static_selection_container_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/static_selection_container_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 502: widgets/text_selection_gesture_detector_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 502 |
| **Test Name** | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/text_selection_gesture_detector_builder_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 503: widgets/toolbar_items_parent_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 503 |
| **Test Name** | `widgets/toolbar_items_parent_data_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/toolbar_items_parent_data_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 504: widgets/toolbar_options_test.dart

| Field | Value |
|-------|-------|
| **Index** | 504 |
| **Test Name** | `widgets/toolbar_options_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/toolbar_options_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 505: widgets/tooltip_position_context_test.dart

| Field | Value |
|-------|-------|
| **Index** | 505 |
| **Test Name** | `widgets/tooltip_position_context_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tooltip_position_context_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

---

## Batch-101

Issues 506–510 of 551

#### Issue 506: widgets/tooltip_window_controller_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 506 |
| **Test Name** | `widgets/tooltip_window_controller_delegate_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tooltip_window_controller_delegate_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 507: widgets/tooltip_window_controller_test.dart

| Field | Value |
|-------|-------|
| **Index** | 507 |
| **Test Name** | `widgets/tooltip_window_controller_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tooltip_window_controller_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 508: widgets/tooltip_window_test.dart

| Field | Value |
|-------|-------|
| **Index** | 508 |
| **Test Name** | `widgets/tooltip_window_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tooltip_window_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 509: widgets/transition_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 509 |
| **Test Name** | `widgets/transition_delegate_test.dart` |
| **Category** | `INTERPRETER-STATE-ACCESS` |
| **Immediate Fix Possible** | Maybe — fix mixin chain property resolution |
| **Description** | Interpreter cannot resolve State/Delegate property through mixin chain |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/transition_delegate_test.dart` fails because the interpreter cannot resolve a property on a State/Delegate/Controller subclass. The interpreter's property resolution must traverse the mixin chain and bridge class hierarchy.

**Fix Description (Proper Fix):**

Fix the interpreter's property resolution for State/Delegate/Controller subclasses. The interpreter should resolve inherited properties through the mixin chain and bridge class hierarchy.

**Needs Deeper Analysis:** Maybe — depends on mixin chain complexity

#### Issue 510: widgets/transpose_characters_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 510 |
| **Test Name** | `widgets/transpose_characters_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/transpose_characters_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-102

Issues 511–515 of 551

#### Issue 511: widgets/traversal_direction_test.dart

| Field | Value |
|-------|-------|
| **Index** | 511 |
| **Test Name** | `widgets/traversal_direction_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/traversal_direction_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 512: widgets/traversal_edge_behavior_test.dart

| Field | Value |
|-------|-------|
| **Index** | 512 |
| **Test Name** | `widgets/traversal_edge_behavior_test.dart` |
| **Category** | `BRIDGE-MISSING-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add constructor to bridge generator |
| **Description** | Bridge missing constructor for class |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/traversal_edge_behavior_test.dart` fails because the bridge for `that` is missing a constructor. The bridge generator must emit this constructor.

**Fix Description (Proper Fix):**

Add the missing constructor to the bridge generator's class definition. Update the bridge generator to emit the constructor, then regenerate bridges.

**Needs Deeper Analysis:** No — add constructor to bridge generator

#### Issue 513: widgets/tree_sliver_state_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 513 |
| **Test Name** | `widgets/tree_sliver_state_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/tree_sliver_state_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 514: widgets/two_dimensional_child_builder_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 514 |
| **Test Name** | `widgets/two_dimensional_child_builder_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/two_dimensional_child_builder_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 515: widgets/two_dimensional_child_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 515 |
| **Test Name** | `widgets/two_dimensional_child_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/two_dimensional_child_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-103

Issues 516–520 of 551

#### Issue 516: widgets/two_dimensional_child_list_delegate_test.dart

| Field | Value |
|-------|-------|
| **Index** | 516 |
| **Test Name** | `widgets/two_dimensional_child_list_delegate_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/two_dimensional_child_list_delegate_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 517: widgets/two_dimensional_child_manager_test.dart

| Field | Value |
|-------|-------|
| **Index** | 517 |
| **Test Name** | `widgets/two_dimensional_child_manager_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/two_dimensional_child_manager_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 518: widgets/two_dimensional_scrollable_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 518 |
| **Test Name** | `widgets/two_dimensional_scrollable_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/two_dimensional_scrollable_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 519: widgets/two_dimensional_viewport_parent_data_test.dart

| Field | Value |
|-------|-------|
| **Index** | 519 |
| **Test Name** | `widgets/two_dimensional_viewport_parent_data_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/two_dimensional_viewport_parent_data_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabController` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 520: widgets/undo_history_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 520 |
| **Test Name** | `widgets/undo_history_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/undo_history_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-104

Issues 521–525 of 551

#### Issue 521: widgets/undo_history_value_test.dart

| Field | Value |
|-------|-------|
| **Index** | 521 |
| **Test Name** | `widgets/undo_history_value_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/undo_history_value_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 522: widgets/undo_text_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 522 |
| **Test Name** | `widgets/undo_text_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/undo_text_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 523: widgets/unfocus_disposition_test.dart

| Field | Value |
|-------|-------|
| **Index** | 523 |
| **Test Name** | `widgets/unfocus_disposition_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/unfocus_disposition_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 524: widgets/update_selection_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 524 |
| **Test Name** | `widgets/update_selection_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/update_selection_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 525: widgets/user_scroll_notification_test.dart

| Field | Value |
|-------|-------|
| **Index** | 525 |
| **Test Name** | `widgets/user_scroll_notification_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/user_scroll_notification_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-105

Issues 526–530 of 551

#### Issue 526: widgets/viewport_element_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 526 |
| **Test Name** | `widgets/viewport_element_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/viewport_element_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 527: widgets/viewport_notification_mixin_test.dart

| Field | Value |
|-------|-------|
| **Index** | 527 |
| **Test Name** | `widgets/viewport_notification_mixin_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/viewport_notification_mixin_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 528: widgets/void_callback_action_test.dart

| Field | Value |
|-------|-------|
| **Index** | 528 |
| **Test Name** | `widgets/void_callback_action_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/void_callback_action_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 529: widgets/void_callback_intent_test.dart

| Field | Value |
|-------|-------|
| **Index** | 529 |
| **Test Name** | `widgets/void_callback_intent_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/void_callback_intent_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 530: widgets/weak_map_test.dart

| Field | Value |
|-------|-------|
| **Index** | 530 |
| **Test Name** | `widgets/weak_map_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/weak_map_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-106

Issues 531–535 of 551

#### Issue 531: widgets/web_browser_detection_test.dart

| Field | Value |
|-------|-------|
| **Index** | 531 |
| **Test Name** | `widgets/web_browser_detection_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/web_browser_detection_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 532: widgets/widget_inspector_service_extensions_test.dart

| Field | Value |
|-------|-------|
| **Index** | 532 |
| **Test Name** | `widgets/widget_inspector_service_extensions_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_inspector_service_extensions_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 533: widgets/widget_inspector_service_test.dart

| Field | Value |
|-------|-------|
| **Index** | 533 |
| **Test Name** | `widgets/widget_inspector_service_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_inspector_service_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 534: widgets/widget_order_traversal_policy_test.dart

| Field | Value |
|-------|-------|
| **Index** | 534 |
| **Test Name** | `widgets/widget_order_traversal_policy_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_order_traversal_policy_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 535: widgets/widget_state_border_side_test.dart

| Field | Value |
|-------|-------|
| **Index** | 535 |
| **Test Name** | `widgets/widget_state_border_side_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_border_side_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-107

Issues 536–540 of 551

#### Issue 536: widgets/widget_state_color_test.dart

| Field | Value |
|-------|-------|
| **Index** | 536 |
| **Test Name** | `widgets/widget_state_color_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_color_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 537: widgets/widget_state_mapper_test.dart

| Field | Value |
|-------|-------|
| **Index** | 537 |
| **Test Name** | `widgets/widget_state_mapper_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_mapper_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 538: widgets/widget_state_mouse_cursor_test.dart

| Field | Value |
|-------|-------|
| **Index** | 538 |
| **Test Name** | `widgets/widget_state_mouse_cursor_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_mouse_cursor_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 539: widgets/widget_state_outlined_border_test.dart

| Field | Value |
|-------|-------|
| **Index** | 539 |
| **Test Name** | `widgets/widget_state_outlined_border_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_outlined_border_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 540: widgets/widget_state_property_all_test.dart

| Field | Value |
|-------|-------|
| **Index** | 540 |
| **Test Name** | `widgets/widget_state_property_all_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_property_all_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---

## Batch-108

Issues 541–545 of 551

#### Issue 541: widgets/widget_state_test.dart

| Field | Value |
|-------|-------|
| **Index** | 541 |
| **Test Name** | `widgets/widget_state_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 542: widgets/widget_state_text_style_test.dart

| Field | Value |
|-------|-------|
| **Index** | 542 |
| **Test Name** | `widgets/widget_state_text_style_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_state_text_style_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 543: widgets/widget_states_constraint_test.dart

| Field | Value |
|-------|-------|
| **Index** | 543 |
| **Test Name** | `widgets/widget_states_constraint_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/widget_states_constraint_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

#### Issue 544: widgets/window_positioner_anchor_test.dart

| Field | Value |
|-------|-------|
| **Index** | 544 |
| **Test Name** | `widgets/window_positioner_anchor_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/window_positioner_anchor_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 545: widgets/window_positioner_constraint_adjustment_test.dart

| Field | Value |
|-------|-------|
| **Index** | 545 |
| **Test Name** | `widgets/window_positioner_constraint_adjustment_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/window_positioner_constraint_adjustment_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

---

## Batch-109

Issues 546–550 of 551

#### Issue 546: widgets/window_positioner_test.dart

| Field | Value |
|-------|-------|
| **Index** | 546 |
| **Test Name** | `widgets/window_positioner_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/window_positioner_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 547: widgets/window_scope_test.dart

| Field | Value |
|-------|-------|
| **Index** | 547 |
| **Test Name** | `widgets/window_scope_test.dart` |
| **Category** | `BRIDGE-TYPE-MISMATCH-FW` |
| **Immediate Fix Possible** | Yes — add type coercion in bridge generator |
| **Description** | Type mismatch in framework call (bridge coercion gap) |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/window_scope_test.dart` fails due to a collection type mismatch in a framework call (e.g., `List<Object?>` passed where `List<Widget>` expected). The bridge generator must emit `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` at the call site.

**Fix Description (Proper Fix):**

Fix the bridge generator's type coercion to handle framework collection types. Add `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` calls in the bridge adapter, or implement native coercion in the generator.

**Needs Deeper Analysis:** No — add coercion in bridge generator

#### Issue 548: widgets/windowing_owner_linux_test.dart

| Field | Value |
|-------|-------|
| **Index** | 548 |
| **Test Name** | `widgets/windowing_owner_linux_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/windowing_owner_linux_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 549: widgets/windowing_owner_mac_o_s_test.dart

| Field | Value |
|-------|-------|
| **Index** | 549 |
| **Test Name** | `widgets/windowing_owner_mac_o_s_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/windowing_owner_mac_o_s_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

#### Issue 550: widgets/windowing_owner_test.dart

| Field | Value |
|-------|-------|
| **Index** | 550 |
| **Test Name** | `widgets/windowing_owner_test.dart` |
| **Category** | `BRIDGE-GENERIC-CONSTRUCTOR` |
| **Immediate Fix Possible** | Yes — add UserBridge generic constructor factory |
| **Description** | Bridge generic constructor factory error |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | error (HTTP 400) |
| **Failure** | Yes |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/windowing_owner_test.dart` fails on a generic constructor (e.g., `Tween<T>()`, `ValueNotifier<T>()`). The bridge generator does not handle generic type parameters in constructors. A UserBridge generic constructor factory is needed.

**Fix Description (Proper Fix):**

Add a UserBridge with a generic constructor factory that performs proper type parameter resolution. Update the bridge generator to handle generic constructors natively.

**Needs Deeper Analysis:** No — add UserBridge generic factory

---

## Batch-110

Issues 551–551 of 551

#### Issue 551: widgets/windowing_owner_win32_test.dart

| Field | Value |
|-------|-------|
| **Index** | 551 |
| **Test Name** | `widgets/windowing_owner_win32_test.dart` |
| **Category** | `SCRIPT-LATEINIT` |
| **Immediate Fix Possible** | No — requires `late` variable support in interpreter |
| **Description** | Interpreter lacks `late` variable support |
| **Suite Batch** | 1 |
| **Suite** | `hardly_relevant_classes_5_test` |
| **Status** | success (HTTP 200) |
| **Failure** | No |
| **Log Output** | Yes |

**Detailed Analysis:**

Test `widgets/windowing_owner_win32_test.dart` fails because the interpreter does not support `late` variable initialization. Variable `_tabs` is declared `late` and accessed before the interpreter executes its initializer. The D4rt interpreter needs `late` field support added to its variable resolution.

**Fix Description (Proper Fix):**

Add `late` variable support to the D4rt interpreter. The interpreter must track `late` field initialization state and execute the initializer on first access, matching Dart semantics.

**Needs Deeper Analysis:** No — implement `late` support in interpreter

---
