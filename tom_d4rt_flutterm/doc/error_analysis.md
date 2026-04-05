# Error Analysis — tom_d4rt_flutterm Test Results

Generated: 2026-04-05 (updated after RC-3 interface proxy fix)

## Summary

- **Total test failures:** 152 (across 8 test files with failures) — down from 309 (–157)
- **Total framework errors:** 111 blocks (386 individual errors, occurring in passing tests) — up from 69/304 (more tests now progress further)
- **Test files with 0 test failures:** bridge_execution_test.dart, essential_classes_test.dart, tom_d4rt_flutterm_test.dart

### RC-3 Fix Impact

The RC-3 fix in `visitInstanceCreationExpression` (both tom_d4rt and tom_d4rt_ast) applies interface proxy conversion at instance creation time, so interpreted classes extending bridged types like `StatefulWidget` and `StatelessWidget` are returned as native proxies.

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Total test failures | 309 | 152 | **–157 (–51%)** |
| InterpretedInstance errors | 107 | 20 | **–87 (–81%)** |
| Tests passing | 1,688 | 1,845 | **+157** |
| Framework error blocks | 69 | 111 | +42 (more tests reach further) |

The remaining 20 InterpretedInstance errors occur when an interpreted instance is passed as an **argument** to a bridged constructor (e.g., `child: InterpretedInstance(PanelTheme)` to `Directionality`), which is the argument-extraction path, not the instance-creation path.

The largest new framework error category is `widget` property access (154 occurrences in 111 FW blocks) — tests that previously failed at InterpretedInstance now progress further and pass, but produce framework errors because `State.widget` is not resolved on interpreted State subclasses.

## Test Failure Categories

152 test failures (153 `[E]` markers, 1 duplicate). These are actual test failures counted by dart test.

| Category | Count | Before | Change | Description |
|----------|-------|--------|--------|-------------|
| Missing unnamed constructor | 35 | 34 | +1 | Classes like _ThemePreset(17), _ThemePack(2) etc. — constructor not resolved |
| hashCode on bridged enum | 17 | 17 | — | hashCode not found on enum values — interpreter issue |
| _TickerProviderShim mixin | 15 | 15 | — | Mixin 'on' clause type not found — interpreter issue |
| Undefined .name on bridged | 12 | 12 | — | Undefined property 'name' on bridged enum/class |
| Native bridged constructor error | 11 | 11 | — | Native error during default bridged constructor execution |
| Other undefined var/property | 7 | 4 | +3 | Various undefined variables or properties |
| Return type mismatch | 6 | 6 | — | "A value of type X can't be returned from function Y" |
| InterpretedFunction type mismatch | 5 | 5 | — | InterpretedFunction is not subtype of closure type |
| Null check on SPostfixExpression | 5 | 5 | — | Null check operator at SPostfixExpression |
| _SUnknownNode (for-loop) | 5 | 5 | — | Unknown for-loop node in AST — interpreter issue |
| WidgetState.isSatisfiedBy | 5 | 5 | — | WidgetState method resolution failure |
| toString on bridged enum | 4 | 3 | +1 | Calling toString on bridged enum |
| Object not callable | 4 | 4 | — | No default constructor bridge — interpreter issue |
| InterpretedInstance not converted | 4 | 105 | **–101** | **Mostly fixed by RC-3** — remaining are argument-passing cases |
| flutter_test import unresolved | 3 | 3 | — | Package not available in D4rt — interpreter issue |
| Timeout | 3 | 0 | +3 | Test or build timed out — newly exposed |
| CatmullRomSpline assertion | 3 | 3 | — | Control points assertion — list bridging issue |
| ByteData / platform channel | 3 | 3 | — | ByteData-related errors |
| Unsupported operation | 2 | 2 | — | SystemColor, unsupported indexing |
| Failed assertion (native) | 2 | 2 | — | Flutter framework assertion failures |
| Other (single-occurrence) | 2 | 73 | **–71** | Script not found, null method invocation, etc. |
| **TOTAL** | **153** | **317** | **–164** | **(152 unique failures + 1 duplicate [E] marker)** |

## Framework Error Categories

111 framework error blocks (386 individual errors). These occur in **passing** tests — the test completes but Flutter's error handler catches runtime errors during widget build/layout. These increased from 69 blocks (304 individual) because more tests now progress past the InterpretedInstance barrier.

| Category | Count | Description |
|----------|-------|-------------|
| Undefined property 'widget' on State | 154 | State subclass can't access `this.widget` — newly exposed by RC-3 fix |
| Layout/render errors | 41 | Infinite size, RenderFlex constraints, RenderBox not laid out |
| Failed assertions | 30 | Various Flutter framework assertion failures during layout/paint |
| Null check operator | 19 | Null check on various interpreter nodes |
| InterpretedInstance (argument path) | 16 | InterpretedInstance passed as constructor argument to bridged class |
| .name on bridged instance | 13 | Undefined property 'name' on bridged enum/class |
| Other undefined var/property | 10 | Various undefined variables or properties |
| roundToDouble | 9 | Missing method on bridged int |
| Actions/Map\<Type\> conversion | 5 | Cannot convert Map to typed Map in bridged constructors |
| whereType on BridgedList | 4 | Missing method on bridged List |
| EagerGestureRecognizer | 3 | Undefined static member 'new' on bridged class |
| toString on bridged | 2 | toString resolution on bridged types |
| _dispatcher late init | 2 | Late variable accessed before assignment |
| Other framework errors | 28 | Various runtime errors in widget tree |

## Detailed Error Analysis

> **Note on Interpreter issue #24 (InterpretedInstance not Widget):** All errors tagged with
> "Interpreter issue #24" that involve `Expected Widget but got InterpretedInstance` at the
> top-level return of `build()` are **FIXED by RC-3**. The fix applies interface proxy
> conversion in `visitInstanceCreationExpression`, so interpreted classes extending
> `StatefulWidget` or `StatelessWidget` are now returned as native proxies. Remaining
> InterpretedInstance errors (20 total) occur when an interpreted instance is passed as a
> **constructor argument** to a bridged class (e.g., `child: InterpretedInstance(PanelTheme)`).
> These are argument-extraction path issues, not instance-creation issues.

### Error #1 — widgets/center_test.dart — **FIXED by RC-3**

| Field | Value |
|-------|-------|
| **Test file** | essential_classes_test.dart:525 |
| **Script** | widgets/center_test.dart |
| **Error** | `Expected Widget but got InterpretedInstance` |
| **Status** | **FIXED** — RC-3 interface proxy conversion in `visitInstanceCreationExpression` now returns the native proxy (`_InterpretedStatefulWidget`) instead of the raw `InterpretedInstance`. This test now passes. |
| **Code** | `return const _CenterGeometryAtlasDemo();` — `build()` returns a `StatefulWidget` subclass |
| **Explanation** | The script defines `_CenterGeometryAtlasDemo extends StatefulWidget` and returns it from `build()`. Previously the D4rt interpreter returned an `InterpretedInstance` that failed `is Widget`. The RC-3 fix applies `D4.tryCreateInterfaceProxyWithVisitor()` at instance creation time, converting the instance to an `_InterpretedStatefulWidget` that satisfies `is Widget`. |

### Error #2 — animation/catmull_rom_curve_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:93 |
| **Script** | animation/catmull_rom_curve_test.dart |
| **Error** | `Native error during default bridged constructor for 'CatmullRomCurve': Failed assertion: line 947: validateControlPoints` |
| **Code** | `final basicCurve = CatmullRomCurve(basicPoints);` where `basicPoints = <Offset>[Offset(0.2, 0.2), Offset(0.5, 0.8), Offset(0.8, 0.2)]` |
| **Explanation** | The script creates a `CatmullRomCurve` with 3 control points. In native Dart, `CatmullRomCurve` adds start (0,0) and end (1,1) automatically, giving 5 points total (> 3 required by the underlying `CatmullRomSpline`). The assertion fires because the interpreter likely passes the `List<Offset>` incorrectly to the native constructor — the offsets may not be properly bridged, causing the validation function to fail. **Interpreter issue** — bridged `List<Offset>` not properly typed when passed to native constructors. Could also be a validation issue with how the offsets are bridged (they may be `InterpretedInstance` instead of native `Offset`). |

### Error #3 — animation/catmull_rom_spline_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:100 |
| **Script** | animation/catmull_rom_spline_test.dart |
| **Error** | `Native error during default bridged constructor for 'CatmullRomSpline': controlPoints.length > 3` |
| **Code** | `final basicSpline = CatmullRomSpline(basicPoints);` where `basicPoints = <Offset>[Offset(0.0, 0.0), Offset(0.3, 0.8), Offset(0.7, 0.2), Offset(1.0, 1.0)]` (4 points) |
| **Explanation** | The script provides 4 control points (which satisfies 4 > 3). The assertion still fires — same root cause as Error #2. The `List<Offset>` may not be bridged correctly, causing the native constructor to see an empty or incorrectly-typed list. **Interpreter issue** — same as #2, `List<Offset>` bridging problem. |

### Error #4 — animation/curve2_d_sample_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:131 |
| **Script** | animation/curve2_d_sample_test.dart |
| **Error** | `Native error during default bridged constructor for 'CatmullRomSpline': controlPoints.length > 3` |
| **Code** | Same pattern — creates `CatmullRomSpline` with `List<Offset>` |
| **Explanation** | Same root cause as Errors #2-3. **Interpreter issue** — `List<Offset>` bridging. |

### Error #5 — animation/curve2_d_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:136 |
| **Script** | animation/curve2_d_test.dart |
| **Error** | `Native error during default bridged constructor for 'CatmullRomSpline': controlPoints.length > 3` |
| **Code** | Same pattern — creates `CatmullRomSpline` with `List<Offset>` |
| **Explanation** | Same root cause as Errors #2-4. **Interpreter issue** — `List<Offset>` bridging. |

### Error #6 — animation/curve_tween_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:143 |
| **Script** | animation/curve_tween_test.dart |
| **Error** | `Native error during bridged method call 'reduce' on Iterable: type 'NativeFunction' is not a subtype of type 'InterpretedFunction' in type cast` |
| **Code** | `].map((t) => elasticOutTween.transform(t)).reduce(math.max);` (line 435) |
| **Explanation** | The script calls `.reduce(math.max)` on an `Iterable<double>`. `math.max` is a native Dart top-level function. The interpreter's bridge for `Iterable.reduce()` expects an `InterpretedFunction` (a closure defined in D4rt code) but receives a `NativeFunction` reference. **Interpreter issue** — native functions cannot be passed as callbacks to bridged collection methods like `reduce()`. The interpreter should wrap native functions or accept both types. |

### Error #7 — animation/elastic_in_out_curve_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:162 |
| **Script** | animation/elastic_in_out_curve_test.dart |
| **Error** | `Native error during bridged method call 'reduce' on Iterable: type 'NativeFunction' is not a subtype of type 'InterpretedFunction'` |
| **Code** | `.reduce(math.max)` / `.reduce(math.min)` pattern |
| **Explanation** | Same as Error #6 — `math.max`/`math.min` are native functions passed to `reduce()`. **Interpreter issue** — same root cause. |

### Error #8 — animation/elastic_out_curve_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:169 |
| **Script** | animation/elastic_out_curve_test.dart |
| **Error** | Same `reduce`/`NativeFunction` error |
| **Code** | `.reduce(math.max)` / `.reduce(math.min)` |
| **Explanation** | Same as Error #6. **Interpreter issue**. |

### Error #9 — animation/flipped_curve_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:176 |
| **Script** | animation/flipped_curve_test.dart |
| **Error** | Same `reduce`/`NativeFunction` error |
| **Code** | `.reduce(math.max)` / `.reduce(math.min)` |
| **Explanation** | Same as Error #6. **Interpreter issue**. |

### Error #10 — animation/reverse_tween_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:207 |
| **Script** | animation/reverse_tween_test.dart |
| **Error** | `Error in generic constructor factory for 'ReverseTween': Null check operator used on a null value` |
| **Code** | `final reversedDouble = ReverseTween<double>(doubleTween);` (line 49) |
| **Explanation** | `ReverseTween<double>` is a generic class. The interpreter's generic constructor factory cannot resolve the type parameter `<double>` properly, causing a null check to fail during construction. **Interpreter issue #36** — generic constructor factory does not properly handle type arguments. |

### Error #11 — dart_ui/color_space_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:484 |
| **Script** | dart_ui/color_space_test.dart |
| **Error** | `Unsupported target for indexing: null` |
| **Code** | `info['color'] as Color` (line 131) — where `info` comes from `_colorSpaceInfo(cs)` which returns a `Map<String, dynamic>` via a `switch` on `ui.ColorSpace` values |
| **Explanation** | The script calls `_colorSpaceInfo(cs)` which uses a `switch (cs)` over `ui.ColorSpace` enum values and returns a `Map<String, dynamic>`. The interpreter cannot properly resolve the switch-case matching on bridged enum values, causing `_colorSpaceInfo` to return `null` (no case matches). When the caller then attempts `info['color']`, the `[]` indexing operator is applied to `null`, producing `Unsupported target for indexing: null`. **Interpreter issue** — switch-case matching on bridged `dart:ui` enums fails because the interpreter cannot compare bridged enum instances in pattern matching. |

### Error #12 — dart_ui/display_feature_state_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:505 |
| **Script** | dart_ui/display_feature_state_test.dart |
| **Error** | `Property "hashCode" not found on enum value DisplayFeatureState.unknown` |
| **Code** | `'${state.name}: toString=${state.toString()}, hashCode=${state.hashCode}'` (line 74) — inside `for (final state in allStates)` |
| **Explanation** | The script iterates over `DisplayFeatureState` enum values and accesses `.hashCode` on each. The D4rt interpreter's bridge for `DisplayFeatureState` does not expose the `hashCode` property (inherited from `Object`). **Interpreter issue #21** — `hashCode` not found on bridged enum values. The bridge needs to forward `hashCode` to the underlying native enum instance. |

### Error #13 — dart_ui/display_feature_type_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:512 |
| **Script** | dart_ui/display_feature_type_test.dart |
| **Error** | `Property "hashCode" not found on enum value DisplayFeatureType.unknown` |
| **Code** | `'${type.name}: toString=${type.toString()}, hashCode=${type.hashCode}'` (line 69) — inside `for (final type in allTypes)` |
| **Explanation** | Same as Error #12. `DisplayFeatureType` enum values missing `hashCode` property in the bridge. **Interpreter issue #21**. |

### Error #14 — dart_ui/filter_quality_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:526 |
| **Script** | dart_ui/filter_quality_test.dart |
| **Error** | `Property "hashCode" not found on enum value FilterQuality.none` |
| **Code** | `print('hashCode equal: ${none.hashCode == ui.FilterQuality.none.hashCode}');` (line 42) |
| **Explanation** | The script compares `hashCode` values of `FilterQuality.none`. Same root cause as Errors #12-13. **Interpreter issue #21** — enum bridge missing `hashCode`. |

### Error #15 — dart_ui/font_style_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:531 |
| **Script** | dart_ui/font_style_test.dart |
| **Error** | `Property "hashCode" not found on enum value FontStyle.normal` |
| **Code** | `print('hashCode equal: ${normal.hashCode == ui.FontStyle.normal.hashCode}');` (line 35) |
| **Explanation** | Same as Errors #12-14. `FontStyle` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #16 — dart_ui/image_byte_format_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:557 |
| **Script** | dart_ui/image_byte_format_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Image'` |
| **Code** | `print('${f.name}: index=${f.index}');` (line 1197) — inside `for (final f in ImageByteFormat.values)` |
| **Explanation** | The script accesses `.name` on `ImageByteFormat` enum values, but the error message says "bridged instance of 'Image'". The D4rt interpreter incorrectly resolves `ImageByteFormat` values to the `Image` bridge class (likely prefix-matching on the class name). Since the `Image` bridge has no `.name` property, the access fails. **Interpreter issue** — enum values bridged under wrong class due to name resolution; `ImageByteFormat` mapped to `Image` bridge instead of its own enum bridge. |

### Error #17 — dart_ui/painting_style_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:613 |
| **Script** | dart_ui/painting_style_test.dart |
| **Error** | `Undefined property or method 'toString' on StrokeCap` |
| **Code** | `_paintInfoTile('strokeCap', strokePaint.strokeCap.toString()),` (line 239) |
| **Explanation** | The script calls `.toString()` on the `StrokeCap` enum value returned by `strokePaint.strokeCap`. The D4rt bridge for `StrokeCap` does not expose `toString()` (inherited from `Object`). Unlike the `hashCode` errors (#12-15) where `.hashCode` was missing, here `.toString()` is also not forwarded. **Interpreter issue** — bridged enum types missing base `Object` methods (`toString`, `hashCode`). Related to issue #21. |

### Error #18 — dart_ui/path_fill_type_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:620 |
| **Script** | dart_ui/path_fill_type_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Path'` |
| **Code** | `print('  ${fillType.index}: ${fillType.name}');` (line 25) — inside `for (final fillType in PathFillType.values)` |
| **Explanation** | The script accesses `.name` on `PathFillType` enum values, but the interpreter resolves the bridge to `Path` instead of `PathFillType`. Same class name prefix-matching issue as Error #16. The `Path` bridge has no `.name` property. **Interpreter issue** — `PathFillType` enum incorrectly resolved to `Path` bridge. |

### Error #19 — dart_ui/path_operation_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:627 |
| **Script** | dart_ui/path_operation_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Path'` |
| **Code** | `print('  ${op.index}: ${op.name}');` (line 25) — inside `for (final op in PathOperation.values)` |
| **Explanation** | Same as Error #18. `PathOperation` enum values incorrectly resolved to `Path` bridge. **Interpreter issue** — same name-prefix resolution bug. |

### Error #20 — dart_ui/placeholder_alignment_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:648 |
| **Script** | dart_ui/placeholder_alignment_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Placeholder'` |
| **Code** | `print('${align.name}: index=${align.index}');` (line 22) — inside `for (final align in PlaceholderAlignment.values)` |
| **Explanation** | Same pattern as Errors #16, #18, #19. `PlaceholderAlignment` enum values are incorrectly resolved to `Placeholder` bridge. `.name` is not available on the `Placeholder` bridge. **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #21 — dart_ui/point_mode_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:0 |
| **Script** | dart_ui/point_mode_test.dart |
| **Error** | `type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast` |
| **Code** | `for (final mode in PointMode.values) { print('${mode.name}: index=${mode.index}'); }` (line 22) |
| **Explanation** | The AST converter fails to parse this for-in loop during AST generation. The `_SUnknownNode` error occurs because the converter's `_convertForStatement` method encounters a loop parts node it cannot cast to `SForLoopParts`. This happens at the AST conversion stage before interpretation begins. **Interpreter issue #39** — for-loop parsing fails for certain constructs. |

### Error #22 — dart_ui/semantics_hit_test_behavior_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:695 |
| **Script** | dart_ui/semantics_hit_test_behavior_test.dart |
| **Error** | `Property "hashCode" not found on enum value SemanticsHitTestBehavior.opaque` |
| **Code** | `'opaque.hashCode == opaque.hashCode: ${opaque.hashCode == SemanticsHitTestBehavior.opaque.hashCode}'` (line 744) |
| **Explanation** | Same as Errors #12-15. `SemanticsHitTestBehavior` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #23 — dart_ui/semantics_input_type_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:702 |
| **Script** | dart_ui/semantics_input_type_test.dart |
| **Error** | `Property "hashCode" not found on enum value SemanticsInputType.text` |
| **Code** | `'text.hashCode == text.hashCode: ${text.hashCode == SemanticsInputType.text.hashCode}'` (line 932) |
| **Explanation** | Same as Error #22. `SemanticsInputType` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #24 — dart_ui/semantics_role_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:709 |
| **Script** | dart_ui/semantics_role_test.dart |
| **Error** | `Property "hashCode" not found on enum value SemanticsRole.tab` |
| **Code** | `print('tab.hashCode: ${tab.hashCode}');` (line 932) |
| **Explanation** | Same as Error #22. `SemanticsRole` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #25 — dart_ui/semantics_validation_result_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:716 |
| **Script** | dart_ui/semantics_validation_result_test.dart |
| **Error** | `Property "hashCode" not found on enum value SemanticsValidationResult.valid` |
| **Code** | `'valid.hashCode == valid.hashCode: ${valid.hashCode == SemanticsValidationResult.valid.hashCode}'` (line 942) |
| **Explanation** | Same as Error #22. `SemanticsValidationResult` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #26 — dart_ui/stroke_join_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:740 |
| **Script** | dart_ui/stroke_join_test.dart |
| **Error** | `Property "hashCode" not found on enum value StrokeJoin.miter` |
| **Code** | `print('join1.hashCode: ${join1.hashCode}');` (line 1089) — where `join1 = StrokeJoin.miter` |
| **Explanation** | Same as Error #22. `StrokeJoin` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #27 — dart_ui/system_color_palette_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:747 |
| **Script** | dart_ui/system_color_palette_test.dart |
| **Error** | `Unsupported operation: SystemColor not supported on the current platform.` |
| **Code** | `final provides = ui.SystemColor.platformProvidesSystemColors;` (line 828) and `final light = ui.SystemColor.light;` (line 836) |
| **Explanation** | `SystemColor` is a Flutter platform API that provides W3C CSS system colors. The `platformProvidesSystemColors` property or the `.light`/`.dark` palette accessors throw `UnsupportedError` because the test environment (Linux headless Flutter test runner) does not support system colors. **Platform limitation** — not an interpreter issue, the native `SystemColor` API itself is unavailable in the test environment. |

### Error #28 — dart_ui/target_pixel_format_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:754 |
| **Script** | dart_ui/target_pixel_format_test.dart |
| **Error** | `Property "hashCode" not found on enum value TargetPixelFormat.dontCare` |
| **Code** | `'dontCare.hashCode == dontCare.hashCode: ${dontCare.hashCode == TargetPixelFormat.dontCare.hashCode}'` (line 878) |
| **Explanation** | Same as Error #22. `TargetPixelFormat` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #29 — dart_ui/text_affinity_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:761 |
| **Script** | dart_ui/text_affinity_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Text'` |
| **Code** | `print('${a.name}: index=${a.index}');` (line 22) — inside `for (final a in TextAffinity.values)` |
| **Explanation** | Same name-prefix resolution bug as Errors #16, #18-20. `TextAffinity` enum values are incorrectly resolved to the `Text` widget bridge (which has no `.name` property). **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #30 — dart_ui/text_align_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:766 |
| **Script** | dart_ui/text_align_test.dart |
| **Error** | `Property "hashCode" not found on enum value TextAlign.left` |
| **Code** | `print('align1.hashCode: ${align1.hashCode}');` (line 869) — where `align1 = TextAlign.left` |
| **Explanation** | Same as Error #22. `TextAlign` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #31 — dart_ui/text_baseline_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:773 |
| **Script** | dart_ui/text_baseline_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Text'` |
| **Code** | `print('${b.name}: index=${b.index}');` (line 22) — inside `for (final b in TextBaseline.values)` |
| **Explanation** | Same name-prefix resolution bug as Error #29. `TextBaseline` enum values resolved to `Text` widget bridge. **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #32 — dart_ui/text_decoration_style_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:780 |
| **Script** | dart_ui/text_decoration_style_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'TextDecoration'` |
| **Code** | `print('${s.name}: index=${s.index}');` (line 22) — inside `for (final s in TextDecorationStyle.values)` |
| **Explanation** | Same name-prefix resolution bug. `TextDecorationStyle` enum values resolved to `TextDecoration` bridge (a class, not an enum). **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #33 — dart_ui/text_direction_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:787 |
| **Script** | dart_ui/text_direction_test.dart |
| **Error** | `Property "hashCode" not found on enum value TextDirection.ltr` |
| **Code** | `print('dir1.hashCode: ${dir1.hashCode}');` (line 865) — where `dir1 = TextDirection.ltr` |
| **Explanation** | Same as Error #22. `TextDirection` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #34 — dart_ui/tile_mode_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:799 |
| **Script** | dart_ui/tile_mode_test.dart |
| **Error** | `Property "hashCode" not found on enum value TileMode.clamp` |
| **Code** | `print('mode1.hashCode: ${mode1.hashCode}');` (line 797) — where `mode1 = TileMode.clamp` |
| **Explanation** | Same as Error #22. `TileMode` enum bridge missing `hashCode`. **Interpreter issue #21**. |

### Error #35 — dart_ui/view_focus_direction_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:851 |
| **Script** | dart_ui/view_focus_direction_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'View'` |
| **Code** | `'ViewFocusDirection.${direction.name}'` (line 236) and `print('${d.name}: index=${d.index}');` (line 1037) |
| **Explanation** | `ViewFocusDirection` enum values are resolved to `View` bridge class. The `View` bridge has no `.name` property. **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #36 — dart_ui/view_focus_state_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:858 |
| **Script** | dart_ui/view_focus_state_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'View'` |
| **Code** | `'ViewFocusState.${state.name}'` (line 236) and `print('${s.name}: index=${s.index}');` (line 1235) |
| **Explanation** | Same as Error #35. `ViewFocusState` enum values resolved to `View` bridge. **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #37 — foundation/diagnostics_stack_trace_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:957 |
| **Script** | foundation/diagnostics_stack_trace_test.dart |
| **Error** | `Native error during default bridged constructor for 'DiagnosticsStackTrace': Argument Error: Invalid parameter "stack": expected StackTrace?, got BridgedStaticMethodCallable` |
| **Code** | `final dst1 = DiagnosticsStackTrace('Test trace', trace);` (line 14) — where `trace = StackTrace.current` (line 11) |
| **Explanation** | The script obtains a `StackTrace` via `StackTrace.current`. The interpreter resolves `StackTrace.current` as a `BridgedStaticMethodCallable` (a reference to the static getter) instead of invoking it and returning the actual `StackTrace` value. When passed to the `DiagnosticsStackTrace` constructor, the type check fails because the bridge expects `StackTrace?` but receives a callable reference. **Interpreter issue** — static getters on bridged classes returned as callable references instead of being evaluated. |

### Error #38 — foundation/object_created_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:1053 |
| **Script** | foundation/object_created_test.dart |
| **Error** | `'Object' is not callable (no default constructor bridge found)` |
| **Code** | `final testObj = Object();` (line 11) |
| **Explanation** | The script creates a plain `Object()` instance. The D4rt interpreter does not have a bridged constructor for `Object` — the Dart core `Object` class constructor is not registered in the bridge system. **Interpreter issue** — no bridge for `Object()` constructor. `Object` is fundamental to Dart and should have at minimum a default constructor bridge. |

### Error #39 — foundation/object_disposed_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:1060 |
| **Script** | foundation/object_disposed_test.dart |
| **Error** | `'Object' is not callable (no default constructor bridge found)` |
| **Code** | `final obj1 = Object();` (line 10) |
| **Explanation** | Same as Error #38. `Object()` constructor not bridged. **Interpreter issue**. |

### Error #40 — foundation/object_event_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:1067 |
| **Script** | foundation/object_event_test.dart |
| **Error** | `'Object' is not callable (no default constructor bridge found)` |
| **Code** | `final obj1 = Object();` (line 10) |
| **Explanation** | Same as Error #38. `Object()` constructor not bridged. **Interpreter issue**. |

### Error #41 — gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:1161 |
| **Script** | gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart |
| **Error** | `Native error during default bridged constructor for 'FlutterErrorDetailsForPointerEventDispatcher': Argument Error: Invalid parameter "stack": expected StackTrace?, got BridgedStaticMethodCallable` |
| **Code** | `FlutterErrorDetailsForPointerEventDispatcher(exception: 'test', stack: StackTrace.current, ...)` (line 9-11) |
| **Explanation** | Same as Error #37. `StackTrace.current` is resolved as a `BridgedStaticMethodCallable` instead of being invoked. The constructor receives a callable reference where it expects a `StackTrace?`. **Interpreter issue** — static getters on bridged classes returned as callable references. |

### Error #42 — gestures/tap_move_details_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_1_test.dart:1421 |
| **Script** | gestures/tap_move_details_test.dart |
| **Error** | `Native error during default bridged constructor for 'DragUpdateDetails': Failed assertion: line 129: 'primaryDelta == null || (primaryDelta == delta.dx && delta.dy == 0.0) || (primaryDelta == delta.dy && delta.dx == 0.0)'` |
| **Code** | `DragUpdateDetails(globalPosition: Offset(150.0, 250.0), localPosition: Offset(75.0, 125.0), delta: Offset(5.0, 10.0), primaryDelta: 10.0, ...)` (line 10-15) |
| **Explanation** | The script passes `primaryDelta: 10.0` with `delta: Offset(5.0, 10.0)`. The native `DragUpdateDetails` constructor asserts that if `primaryDelta` is non-null, it must equal either `delta.dx` (with `delta.dy == 0`) or `delta.dy` (with `delta.dx == 0`). Here `delta.dx=5.0` and `delta.dy=10.0`, neither is zero, so the assertion fires. **Script error** — invalid constructor arguments that violate `DragUpdateDetails`'s invariant. |

### Error #43 — material/bottom_navigation_bar_type_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:112 |
| **Script** | material/bottom_navigation_bar_type_test.dart |
| **Error** | `Expected Widget but got InterpretedInstance` |
| **Code** | `return _BottomNavigationBarTypeDemo();` (line 14) — `_BottomNavigationBarTypeDemo extends StatefulWidget` (line 17) |
| **Explanation** | The script defines `_BottomNavigationBarTypeDemo extends StatefulWidget` and returns it from `build()`. The D4rt interpreter wraps the result as `InterpretedInstance` instead of recognizing it as a native `Widget`. **Interpreter issue #24** — interpreted classes inheriting from bridged types not cast to their native superclass. |

### Error #44 — material/button_bar_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:131 |
| **Script** | material/button_bar_theme_data_test.dart |
| **Error** | `Undefined property or method 'toString' on MainAxisAlignment` |
| **Code** | `String alignName = themeData.alignment.toString().split('.').last;` (line 109) |
| **Explanation** | `themeData.alignment` returns a `MainAxisAlignment` enum value. The script calls `.toString()` on it. The bridge for `MainAxisAlignment` does not expose `toString()` (inherited from `Object`). **Interpreter issue** — same as Error #17, bridged enum types missing base `Object` methods. |

### Error #45 — material/collapse_mode_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:213 |
| **Script** | material/collapse_mode_test.dart |
| **Error** | `Null check operator used on a null value at Instance of 'SPostfixExpression'` |
| **Code** | `final colors = modeGradients[mode]!;` (line 106) — where `modeGradients` is a `Map<CollapseMode, List<Color>>` |
| **Explanation** | The script uses the null-assertion operator `!` on a map lookup result: `modeGradients[mode]!`. The map lookup `modeGradients[mode]` returns `null` because the bridged `CollapseMode` enum value used as the key doesn't match the key stored in the map (enum identity/equality issue in the bridge), causing the `!` operator to throw. **Interpreter issue** — combination of enum equality in map lookup and null-assertion handling. |

### Error #46 — material/floating_label_behavior_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:466 |
| **Script** | material/floating_label_behavior_test.dart |
| **Error** | `Null check operator used on a null value at Instance of 'SPostfixExpression'` |
| **Code** | `final data = behaviorDescriptions[behavior]!;` (line 57) — where `behaviorDescriptions` is a `Map<FloatingLabelBehavior, Map<String, dynamic>>` |
| **Explanation** | Same as Error #45. Map lookup with bridged enum key returns `null`, then `!` assertion fails. **Interpreter issue** — enum equality in map lookup. |

### Error #47 — material/list_tile_style_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:0 |
| **Script** | material/list_tile_style_test.dart |
| **Error** | `Cannot resolve import "package:flutter_test/flutter_test.dart" from main.dart` |
| **Code** | Script contains `import 'package:flutter_test/flutter_test.dart';` |
| **Explanation** | The script imports `package:flutter_test/flutter_test.dart` which is a test-only package not available in the D4rt interpreter's bridged libraries or explicit sources. The AST bundler cannot resolve the import. **Interpreter issue #40** — `flutter_test` package not bridged. |

### Error #48 — material/material_scroll_behavior_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:635 |
| **Script** | material/material_scroll_behavior_test.dart |
| **Error** | `Undefined property or method 'map' on _ConstSet<PointerDeviceKind>` |
| **Code** | `String devicesStr = devices.map((d) => d.toString()).join(', ');` (line 138) — where `devices = behavior.dragDevices` (a `Set<PointerDeviceKind>`) |
| **Explanation** | The native `ScrollBehavior.dragDevices` returns a `Set<PointerDeviceKind>` (internally `_ConstSet`). The D4rt bridge for `Set` (specifically `_ConstSet`) does not expose the `.map()` method. **Interpreter issue** — `Set` bridge missing `map()` and other `Iterable` methods. |

### Error #49 — material/selection_area_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:34 |
| **Script** | material/selection_area_test.dart |
| **Error** | `HttpException: Connection closed before full header was received` |
| **Code** | N/A — the test app crashed or was unavailable when this test ran |
| **Explanation** | The HTTP connection to the test app (localhost:4247) was interrupted. The test app may have crashed during a previous test or encountered a memory/resource issue. **Infrastructure issue** — not an interpreter error, the test app was unavailable. |

### Error #50 — material/shape_border_tween_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:1002 |
| **Script** | material/shape_border_tween_test.dart |
| **Error** | `SocketException: Connection refused (OS Error: Connection refused, errno = 111), address = localhost, port = 37000` |
| **Code** | N/A — the test app was not running when this test attempted to connect |
| **Explanation** | The test runner could not connect to the test app server on port 37000. The app likely crashed earlier and was not restarted in time. **Infrastructure issue** — same as Error #49, test app unavailable. |

### Errors #51–#79 — Infrastructure Failures (SocketException / HttpException)

All 29 errors below are **infrastructure issues** — the test app (Flutter app running its HTTP server) crashed during the hardly_relevant_classes_2_test.dart run (likely caused by one of the earlier errors) and was not restarted. All subsequent tests in that file fail with `SocketException: Connection refused` because the app server is down.

| # | Script | Test file line | Error type |
|---|--------|---------------|------------|
| 51 | material/show_value_indicator_test.dart | 1009 | SocketException |
| 52 | material/simple_dialog_option_test.dart | 1016 | SocketException |
| 53 | material/slider_interaction_test.dart | 1023 | SocketException |
| 54 | material/snack_bar_theme_data_test.dart | 1030 | SocketException |
| 55 | material/spell_check_suggestions_toolbar_layout_delegate_test.dart | 1037 | SocketException |
| 56 | material/standard_fab_location_test.dart | 1044 | SocketException |
| 57 | material/step_style_test.dart | 1051 | SocketException |
| 58 | material/stretch_mode_test.dart | 1056 | SocketException |
| 59 | material/tab_alignment_test.dart | 1063 | SocketException |
| 60 | material/tab_indicator_animation_test.dart | 1070 | SocketException |
| 61 | material/tab_page_selector_indicator_test.dart | 1077 | SocketException |
| 62 | material/tab_page_selector_test.dart | 1084 | SocketException |
| 63 | material/table_row_ink_well_test.dart | 1091 | SocketException |
| 64 | material/tappable_chip_attributes_test.dart | 1098 | SocketException |
| 65 | material/text_magnifier_test.dart | 1105 | SocketException |
| 66 | material/theme_data_tween_test.dart | 1112 | SocketException |
| 67 | material/theme_extension_test.dart | 1119 | SocketException |
| 68 | material/theme_mode_test.dart | 1126 | SocketException |
| 69 | material/thumb_test.dart | 1131 | SocketException |
| 70 | material/time_of_day_format_test.dart | 1136 | SocketException |
| 71 | material/time_picker_entry_mode_test.dart | 1143 | SocketException |
| 72 | material/toggle_buttons_theme_data_test.dart | 1150 | SocketException |
| 73 | material/toggle_buttons_theme_test.dart | 1157 | SocketException |
| 74 | material/tooltip_state_test.dart | 1164 | SocketException |
| 75 | material/underline_tab_indicator_test.dart | 1171 | SocketException |
| 76 | material/vertical_divider_test.dart | 1178 | SocketException |
| 77 | material/widget_state_input_border_test.dart | 1185 | SocketException |
| 78 | painting/accumulator_test.dart | 1197 | SocketException |
| 79 | painting/asset_bundle_image_key_test.dart | 1204 | SocketException |

**Root cause:** The test app crashed (likely due to an unhandled interpreter error) and the test runner's app restart mechanism did not recover in time. All these scripts would need re-running with a stable test app to determine their actual interpreter behavior.

### Error #80 — painting/asset_bundle_image_provider_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_2_test.dart:1211 |
| **Script** | painting/asset_bundle_image_provider_test.dart |
| **Error** | `Script not found: .../painting/asset_bundle_image_provider_test.dart` |
| **Code** | N/A — the script file does not exist on disk |
| **Explanation** | The test references a script file that was never created or was accidentally deleted. **Issue #41** — script not found. |

### Errors #81–#112 — Infrastructure Failures (SocketException)

All 32 errors are **infrastructure issues** — test app crashed during the hardly_relevant_classes_2_test.dart run. Same root cause as Errors #51-79.

| # | Script | Test file line |
|---|--------|---------------|
| 81 | painting/axis_direction_test.dart | 1218 |
| 82 | painting/axis_test.dart | 1225 |
| 83 | painting/border_style_test.dart | 1230 |
| 84 | painting/box_fit_test.dart | 1237 |
| 85 | painting/box_shape_test.dart | 1242 |
| 86 | painting/class_test.dart | 1247 |
| 87 | painting/clip_context_test.dart | 1252 |
| 88 | painting/color_property_test.dart | 1259 |
| 89 | painting/fitted_sizes_test.dart | 1266 |
| 90 | painting/flutter_logo_style_test.dart | 1273 |
| 91 | painting/image_repeat_test.dart | 1280 |
| 92 | painting/image_size_info_test.dart | 1287 |
| 93 | painting/image_stream_completer_handle_test.dart | 1294 |
| 94 | painting/inline_span_semantics_information_test.dart | 1301 |
| 95 | painting/inline_span_test.dart | 1308 |
| 96 | painting/matrix_utils_test.dart | 1315 |
| 97 | painting/multi_frame_image_stream_completer_test.dart | 1322 |
| 98 | painting/network_image_load_exception_test.dart | 1329 |
| 99 | painting/one_frame_image_stream_completer_test.dart | 1336 |
| 100 | painting/painting_binding_test.dart | 1343 |
| 101 | painting/render_comparison_test.dart | 1350 |
| 102 | painting/resize_image_policy_test.dart | 1357 |
| 103 | painting/shader_warm_up_test.dart | 1364 |
| 104 | painting/text_overflow_test.dart | 1371 |
| 105 | painting/text_width_basis_test.dart | 1378 |
| 106 | painting/transform_property_test.dart | 1385 |
| 107 | painting/vertical_direction_test.dart | 1392 |
| 108 | painting/web_html_element_strategy_test.dart | 1399 |
| 109 | painting/web_image_info_test.dart | 1406 |
| 110 | physics/bounded_friction_simulation_test.dart | 1418 |
| 111 | physics/class_test.dart | 1425 |
| 112 | physics/spring_type_test.dart | 1430 |

### Error #113 — rendering/annotation_entry_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:72 |
| **Script** | rendering/annotation_entry_test.dart |
| **Error** | `A value of type '_InteractiveAnnotationDemo' can't be returned from the function '_buildInteractiveDemo' because it has a return type of 'Widget'` |
| **Code** | `Widget _buildInteractiveDemo() { return _InteractiveAnnotationDemo(); }` (line 418-420) — `_InteractiveAnnotationDemo extends StatefulWidget` (line 423) |
| **Explanation** | A helper function with return type `Widget` returns an instance of `_InteractiveAnnotationDemo` (which extends `StatefulWidget`). The interpreter cannot verify that interpreted class instances satisfy their bridged superclass type annotation. This is a variant of **interpreter issue #24** — the interpreter sees _InteractiveAnnotationDemo as an interpreted type, not as Widget. Unlike the top-level `build()` errors, this occurs in an internal helper function with an explicit Widget return type. |

### Error #114 — rendering/annotation_result_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:79 |
| **Script** | rendering/annotation_result_test.dart |
| **Error** | `A value of type '_MultipleEntriesWidget' can't be returned from the function '_buildMultipleEntriesDemo' because it has a return type of 'Widget'` |
| **Code** | `Widget _buildMultipleEntriesDemo() { return _MultipleEntriesWidget(); }` (line 462-464) — `_MultipleEntriesWidget extends StatefulWidget` (line 467) |
| **Explanation** | Same as Error #113. Internal function returns interpreted StatefulWidget where Widget is expected. **Interpreter issue #24** variant. |

### Error #115 — rendering/cache_extent_style_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:93 |
| **Script** | rendering/cache_extent_style_test.dart |
| **Error** | `A value of type '_InteractiveComparisonWidget' can't be returned from the function '_buildInteractiveComparisonDemo' because it has a return type of 'Widget'` |
| **Code** | `Widget _buildInteractiveComparisonDemo() { return _InteractiveComparisonWidget(); }` (line 494-496) — `_InteractiveComparisonWidget extends StatefulWidget` (line 499) |
| **Explanation** | Same as Errors #113-114. **Interpreter issue #24** variant. |

### Error #116 — rendering/child_layout_helper_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:0 |
| **Script** | rendering/child_layout_helper_test.dart |
| **Error** | `type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast` |
| **Code** | For-loop in the script (pattern similar to other scripts using `for (final x in values)`) |
| **Explanation** | Same as Error #21. AST converter fails to parse a for-loop construct. **Interpreter issue #39**. |

### Error #117 — rendering/class_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:0 |
| **Script** | rendering/class_test.dart |
| **Error** | `Cannot resolve import "package:flutter_test/flutter_test.dart"` |
| **Code** | Script contains `import 'package:flutter_test/flutter_test.dart';` |
| **Explanation** | Same as Error #47. `flutter_test` package not bridged. **Interpreter issue #40**. |

### Error #118 — rendering/cross_axis_alignment_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:131 |
| **Script** | rendering/cross_axis_alignment_test.dart |
| **Error** | `Undefined property or method 'toString' on CrossAxisAlignment` |
| **Code** | `alignment.toString().split('.').last` (line 217) — where `alignment` is a `CrossAxisAlignment` enum value |
| **Explanation** | Same as Error #17. `CrossAxisAlignment` enum bridge does not expose `toString()` from `Object`. **Interpreter issue** — bridged enum types missing base `Object` methods. |

### Error #119 — rendering/decoration_position_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:138 |
| **Script** | rendering/decoration_position_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Decoration'` |
| **Code** | `position.name.toUpperCase()` (line 229) and `position.name` (line 432) — where `position` is a `DecorationPosition` enum value |
| **Explanation** | Same name-prefix resolution bug. `DecorationPosition` enum values resolved to `Decoration` bridge (a class). `.name` is not available on the `Decoration` bridge. **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #120 — rendering/diagnostics_debug_creator_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:0 |
| **Script** | rendering/diagnostics_debug_creator_test.dart |
| **Error** | `Cannot resolve import "package:flutter_test/flutter_test.dart"` |
| **Code** | Script contains `import 'package:flutter_test/flutter_test.dart';` |
| **Explanation** | Same as Error #47. **Interpreter issue #40**. |

### Error #121 — rendering/flex_fit_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:157 |
| **Script** | rendering/flex_fit_test.dart |
| **Error** | `Undefined property or method 'name' on bridged instance of 'Flex'` |
| **Code** | `'FlexFit.${value.name}'` (line 246) and `'FlexFit.${fit.name}'` (line 386) — where `value`/`fit` are `FlexFit` enum values |
| **Explanation** | Same name-prefix resolution bug. `FlexFit` enum values resolved to `Flex` bridge class. `.name` is not available on `Flex`. **Interpreter issue** — enum-to-class name prefix resolution bug. |

### Error #122 — rendering/hit_test_behavior_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:213 |
| **Script** | rendering/hit_test_behavior_test.dart |
| **Error** | `Cannot invoke method 'withAlpha' on null. Use '?.' for null-aware method invocation.` |
| **Code** | `color: _kPink800.withAlpha(80)` (line 64) — where `const _kPink800 = Color(0xFF9D174D);` (line 33) |
| **Explanation** | The script defines `_kPink800` as a top-level `const Color`. The interpreter fails to resolve this constant when used inside a deeply nested widget tree. The value is `null` at the point of use, so calling `.withAlpha()` on it fails. **Interpreter issue** — top-level const variables evaluated to `null` in certain scoping contexts within widget tree construction. |

### Error #123 — rendering/over_scroll_header_stretch_configuration_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:276 |
| **Script** | rendering/over_scroll_header_stretch_configuration_test.dart |
| **Error** | `Expected Widget but got InterpretedInstance` |
| **Code** | Script returns a `StatefulWidget` subclass from `build()` |
| **Explanation** | **Interpreter issue #24** — interpreter returns `InterpretedInstance` instead of native `Widget`. |

### Error #124 — rendering/pipeline_manifold_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:304 |
| **Script** | rendering/pipeline_manifold_test.dart |
| **Error** | `Expected Widget but got InterpretedInstance` |
| **Code** | Script returns a `StatefulWidget` subclass from `build()` |
| **Explanation** | **Interpreter issue #24**. |

### Error #125 — rendering/placeholder_span_index_semantics_tag_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:311 |
| **Script** | rendering/placeholder_span_index_semantics_tag_test.dart |
| **Error** | `Expected Widget but got InterpretedInstance` |
| **Code** | Script returns a `StatefulWidget` subclass from `build()` |
| **Explanation** | **Interpreter issue #24**. |

### Error #126 — rendering/platform_view_hit_test_behavior_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:318 |
| **Script** | rendering/platform_view_hit_test_behavior_test.dart |
| **Error** | `Expected Widget but got InterpretedInstance` |
| **Code** | Script returns a `StatefulWidget` subclass from `build()` |
| **Explanation** | **Interpreter issue #24**. |

### Error #127 — rendering/platform_view_render_box_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:325 |
| **Script** | rendering/platform_view_render_box_test.dart |
| **Error** | `Class '_FaqItem' does not have an unnamed constructor that accepts arguments` |
| **Code** | `_FaqItem(question: '...', answer: '...')` (line 30) — where `class _FaqItem` has `const _FaqItem({required this.question, required this.answer});` |
| **Explanation** | The script defines `_FaqItem` with a named-parameter constructor (`const _FaqItem({required this.question, ...})`). However, the `const` list `_faqItems` is populated *before* the class definition (lines 29-52, class at line 162+). The interpreter cannot resolve the constructor for `_FaqItem` when it's used before the class is defined in the source. **Script pattern issue** — the interpreter does not support forward references to class definitions in const expressions. |

### Error #128 — rendering/render_abstract_viewport_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:332 |
| **Script** | rendering/render_abstract_viewport_test.dart |
| **Error** | `Class '_Profile' does not have an unnamed constructor that accepts arguments` |
| **Code** | `_Profile(id: '...', name: '...', ...)` (line 7) — where `class _Profile` is defined at line 141+ |
| **Explanation** | Same as Error #127. `_Profile` class with named-parameter constructor is used in a const list before the class definition. **Interpreter issue** — forward references to class constructors in const expressions. |

### Error #129 — rendering/render_android_view_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:339 |
| **Script** | rendering/render_android_view_test.dart |
| **Error** | `Class '_ThemePreset' does not have an unnamed constructor that accepts arguments` |
| **Code** | `_ThemePreset(id: '...', name: '...', ...)` (line 7) — where `class _ThemePreset` is at line 126+ |
| **Explanation** | Same as Errors #127-128. Forward reference to `_ThemePreset` constructor in const list. **Interpreter issue** — forward references to class constructors. |

### Error #130 — rendering/render_animated_opacity_mixin_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:346 |
| **Script** | rendering/render_animated_opacity_mixin_test.dart |
| **Error** | `Class '_ThemePreset' does not have an unnamed constructor that accepts arguments` |
| **Code** | Same `_ThemePreset` pattern as Error #129 |
| **Explanation** | Same as Error #129. **Interpreter issue** — forward references to class constructors. |

### Error #131 — rendering/render_animated_size_state_test.dart

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:353 |
| **Script** | rendering/render_animated_size_state_test.dart |
| **Error** | `Class '_ThemePreset' does not have an unnamed constructor that accepts arguments` |
| **Code** | Same `_ThemePreset` pattern as Error #129 |
| **Explanation** | Same as Error #129. **Interpreter issue** — forward references to class constructors. |

---

## Errors #132–#309 (178 errors)

All remaining errors 132–309 are repetitive instances of previously identified interpreter issues. Each error was individually examined; every one maps to a known category with no unknowns.

### Category Breakdown

| Category | Count | Root Cause |
|----------|-------|------------|
| Issue #24 — InterpretedInstance | 102 | Interpreter returns `InterpretedInstance` instead of `Widget` |
| Issue #40 — flutter_test import | 49 | `package:flutter_test` not bridged |
| _ThemePreset constructor | 14 | Forward reference to class constructor |
| _ThemeProfile constructor | 4 | Forward reference to class constructor |
| _Profile constructor | 2 | Forward reference to class constructor |
| Issue #21 — hashCode on enum | 4 | `hashCode` not found on bridged enum |
| Issue #39 — _SUnknownNode | 3 | Record destructuring in for-loops |

Plus 1 unique error: Error #136 (WidgetSpan assertion).

---

### Error #136 — WidgetSpan assertion (unique)

| Field | Value |
|-------|-------|
| **Test file** | hardly_relevant_classes_3_test.dart:395 |
| **Script** | rendering/render_inline_children_container_defaults_test.dart |
| **Error** | `Native error during default bridged constructor for 'WidgetSpan': Failed assertion: 'baseline != null \|\| !(identical(alignment, ui.PlaceholderAlignment.aboveBaseline) \|\| identical(alignment, ui.PlaceholderAlignment.belowBaseline) \|\| identical(alignment, ui.PlaceholderAlignment.baseline))'` |
| **Code** | `WidgetSpan(alignment: alignment, child: ...)` where `alignment` is `PlaceholderAlignment.aboveBaseline` or `belowBaseline`, without providing the required `baseline` parameter |
| **Explanation** | **Script error** — The test script creates `WidgetSpan` with `PlaceholderAlignment.aboveBaseline` and `belowBaseline` but does not provide the mandatory `baseline` parameter. Flutter's `WidgetSpan` asserts that when alignment is `aboveBaseline`, `belowBaseline`, or `baseline`, the `baseline` parameter must not be null. This is a bug in the test script, not the interpreter. |

---

### Issue #24 — InterpretedInstance (102 errors)

The interpreter returns an `InterpretedInstance` instead of the expected `Widget` type. The script's `build()` function returns a widget tree, but the interpreter wraps it in an `InterpretedInstance` which cannot be cast to `Widget`.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 137 | rendering/render_proxy_sliver_test.dart | hardly_relevant_classes_3_test.dart:416 |
| 138 | rendering/render_sliver_box_child_manager_test.dart | hardly_relevant_classes_3_test.dart:423 |
| 139 | rendering/render_sliver_constrained_cross_axis_test.dart | hardly_relevant_classes_3_test.dart:430 |
| 140 | rendering/render_sliver_cross_axis_group_test.dart | hardly_relevant_classes_3_test.dart:437 |
| 141 | rendering/render_sliver_edge_insets_padding_test.dart | hardly_relevant_classes_3_test.dart:444 |
| 142 | rendering/render_sliver_fill_remaining_and_overscroll_test.dart | hardly_relevant_classes_3_test.dart:451 |
| 143 | rendering/render_sliver_fill_remaining_with_scrollable_test.dart | hardly_relevant_classes_3_test.dart:458 |
| 144 | rendering/render_sliver_fixed_extent_box_adaptor_test.dart | hardly_relevant_classes_3_test.dart:465 |
| 145 | rendering/render_sliver_floating_pinned_persistent_header_test.dart | hardly_relevant_classes_3_test.dart:472 |
| 146 | rendering/render_ui_kit_view_test.dart | hardly_relevant_classes_3_test.dart:500 |
| 150 | widgets/abstract_layout_builder_test.dart | hardly_relevant_classes_4_test.dart:51 |
| 151 | widgets/action_listener_test.dart | hardly_relevant_classes_4_test.dart:65 |
| 153 | widgets/android_overscroll_indicator_test.dart | hardly_relevant_classes_4_test.dart:93 |
| 154 | widgets/android_view_surface_test.dart | hardly_relevant_classes_4_test.dart:100 |
| 155 | widgets/app_kit_view_test.dart | hardly_relevant_classes_4_test.dart:142 |
| 156 | widgets/autocomplete_highlighted_option_test.dart | hardly_relevant_classes_4_test.dart:170 |
| 157 | widgets/autofill_group_state_test.dart | hardly_relevant_classes_4_test.dart:219 |
| 158 | widgets/back_button_listener_test.dart | hardly_relevant_classes_4_test.dart:240 |
| 159 | widgets/backdrop_group_test.dart | hardly_relevant_classes_4_test.dart:247 |
| 160 | widgets/bottom_navigation_bar_item_test.dart | hardly_relevant_classes_4_test.dart:296 |
| 161 | widgets/box_scroll_view_test.dart | hardly_relevant_classes_4_test.dart:317 |
| 162 | widgets/callback_shortcuts_test.dart | hardly_relevant_classes_4_test.dart:331 |
| 163 | widgets/child_back_button_dispatcher_test.dart | hardly_relevant_classes_4_test.dart:359 |
| 166 | widgets/default_selection_style_test.dart | hardly_relevant_classes_4_test.dart:483 |
| 167 | widgets/default_text_editing_shortcuts_test.dart | hardly_relevant_classes_4_test.dart:490 |
| 169 | widgets/device_orientation_builder_test.dart | hardly_relevant_classes_4_test.dart:546 |
| 170 | widgets/dismissible_test.dart | hardly_relevant_classes_4_test.dart:677 |
| 171 | widgets/draggable_scrollable_actuator_test.dart | hardly_relevant_classes_4_test.dart:754 |
| 172 | widgets/expansible_test.dart | hardly_relevant_classes_4_test.dart:864 |
| 173 | widgets/flex_test.dart | hardly_relevant_classes_4_test.dart:966 |
| 175 | widgets/hero_controller_scope_test.dart | hardly_relevant_classes_4_test.dart:1048 |
| 176 | widgets/hero_controller_test.dart | hardly_relevant_classes_4_test.dart:1055 |
| 178 | widgets/icon_data_test.dart | hardly_relevant_classes_4_test.dart:1151 |
| 180 | widgets/ignore_baseline_test.dart | hardly_relevant_classes_4_test.dart:1172 |
| 181 | widgets/image_icon_test.dart | hardly_relevant_classes_4_test.dart:1177 |
| 182 | widgets/img_element_platform_view_test.dart | hardly_relevant_classes_4_test.dart:1184 |
| 184 | widgets/keyboard_listener_test.dart | hardly_relevant_classes_4_test.dart:1266 |
| 185 | widgets/layout_id_test.dart | hardly_relevant_classes_4_test.dart:1278 |
| 189 | widgets/lookup_boundary_test.dart | hardly_relevant_classes_4_test.dart:1332 |
| 191 | widgets/meta_data_test.dart | hardly_relevant_classes_4_test.dart:1365 |
| 192 | widgets/modal_barrier_test.dart | hardly_relevant_classes_4_test.dart:1372 |
| 194 | widgets/navigator_pop_handler_test.dart | hardly_relevant_classes_4_test.dart:1400 |
| 196 | widgets/orientation_builder_test.dart | hardly_relevant_classes_4_test.dart:1475 |
| 197 | widgets/overlay_state_test.dart | hardly_relevant_classes_4_test.dart:1529 |
| 201 | widgets/shortcut_manager_test.dart | hardly_relevant_classes_5_test.dart:851 |
| 202 | widgets/shortcut_map_property_test.dart | hardly_relevant_classes_5_test.dart:858 |
| 203 | widgets/shortcut_registry_entry_test.dart | hardly_relevant_classes_5_test.dart:872 |
| 204 | widgets/shortcut_serialization_test.dart | hardly_relevant_classes_5_test.dart:886 |
| 205 | widgets/single_activator_test.dart | hardly_relevant_classes_5_test.dart:893 |
| 206 | widgets/size_changed_layout_notification_test.dart | hardly_relevant_classes_5_test.dart:900 |
| 207 | widgets/sliver_animated_grid_state_test.dart | hardly_relevant_classes_5_test.dart:921 |
| 208 | widgets/sliver_animated_list_state_test.dart | hardly_relevant_classes_5_test.dart:928 |
| 209 | widgets/sliver_child_builder_delegate_test.dart | hardly_relevant_classes_5_test.dart:935 |
| 210 | widgets/sliver_child_delegate_test.dart | hardly_relevant_classes_5_test.dart:942 |
| 211 | widgets/sliver_child_list_delegate_test.dart | hardly_relevant_classes_5_test.dart:949 |
| 212 | widgets/sliver_multi_box_adaptor_element_test.dart | hardly_relevant_classes_5_test.dart:970 |
| 213 | widgets/sliver_multi_box_adaptor_widget_test.dart | hardly_relevant_classes_5_test.dart:977 |
| 214 | widgets/sliver_persistent_header_delegate_test.dart | hardly_relevant_classes_5_test.dart:1005 |
| 215 | widgets/sliver_reorderable_list_state_test.dart | hardly_relevant_classes_5_test.dart:1012 |
| 216 | widgets/slotted_container_render_object_mixin_test.dart | hardly_relevant_classes_5_test.dart:1026 |
| 217 | widgets/slotted_multi_child_render_object_widget_mixin_test.dart | hardly_relevant_classes_5_test.dart:1033 |
| 227 | widgets/batch3_actions_test.dart | important_classes_test.dart:682 |
| 234 | widgets/gesture_detector_adv_test.dart | secondary_classes_test.dart:1017 |
| 236 | material/scaffold_messenger_test.dart | secondary_classes_test.dart:2131 |
| 241 | rendering/box_hit_test_entry_test.dart | secondary_classes_test.dart:2466 |
| 242 | rendering/box_hit_test_result_test.dart | secondary_classes_test.dart:2473 |
| 243 | rendering/clip_r_superellipse_layer_test.dart | secondary_classes_test.dart:2487 |
| 244 | rendering/container_box_parent_data_test.dart | secondary_classes_test.dart:2508 |
| 245 | rendering/platform_view_layer_test.dart | secondary_classes_test.dart:2613 |
| 267 | rendering/render_semantics_annotations_test.dart | secondary_classes_test.dart:2893 |
| 268 | rendering/render_semantics_gesture_handler_test.dart | secondary_classes_test.dart:2900 |
| 269 | rendering/render_shader_mask_test.dart | secondary_classes_test.dart:2907 |
| 270 | rendering/render_shrink_wrapping_viewport_test.dart | secondary_classes_test.dart:2914 |
| 271 | rendering/render_sized_overflow_box_test.dart | secondary_classes_test.dart:2921 |
| 272 | rendering/render_sliver_animated_opacity_test.dart | secondary_classes_test.dart:2928 |
| 273 | rendering/render_sliver_fill_viewport_test.dart | secondary_classes_test.dart:2942 |
| 274 | rendering/render_sliver_fixed_extent_list_test.dart | secondary_classes_test.dart:2949 |
| 275 | widgets/android_view_test.dart | secondary_classes_test.dart:3524 |
| 277 | widgets/autofill_group_test.dart | secondary_classes_test.dart:3594 |
| 278 | widgets/checked_mode_banner_test.dart | secondary_classes_test.dart:3625 |
| 280 | widgets/composited_transform_follower_test.dart | secondary_classes_test.dart:3653 |
| 281 | widgets/default_asset_bundle_test.dart | secondary_classes_test.dart:3688 |
| 282 | widgets/default_text_height_behavior_test.dart | secondary_classes_test.dart:3695 |
| 283 | widgets/directionality_test.dart | secondary_classes_test.dart:3702 |
| 284 | widgets/display_feature_sub_screen_test.dart | secondary_classes_test.dart:3709 |
| 286 | widgets/fade_in_image_test.dart | secondary_classes_test.dart:3735 |
| 287 | widgets/glowing_overscroll_indicator_test.dart | secondary_classes_test.dart:3763 |
| 288 | widgets/html_element_view_test.dart | secondary_classes_test.dart:3770 |
| 291 | widgets/indexed_stack_test.dart | secondary_classes_test.dart:3798 |
| 292 | widgets/inherited_notifier_test.dart | secondary_classes_test.dart:3812 |
| 293 | widgets/inherited_theme_test.dart | secondary_classes_test.dart:3819 |
| 294 | widgets/inherited_widget_test.dart | secondary_classes_test.dart:3826 |
| 295 | widgets/list_wheel_scroll_view_test.dart | secondary_classes_test.dart:3882 |
| 296 | widgets/list_wheel_viewport_test.dart | secondary_classes_test.dart:3889 |
| 297 | widgets/magnifier_decoration_test.dart | secondary_classes_test.dart:3903 |
| 298 | widgets/navigation_toolbar_test.dart | secondary_classes_test.dart:3931 |
| 299 | widgets/overflow_bar_test.dart | secondary_classes_test.dart:3945 |
| 300 | widgets/overflow_box_test.dart | secondary_classes_test.dart:3952 |
| 301 | widgets/page_storage_bucket_test.dart | secondary_classes_test.dart:3966 |
| 302 | widgets/page_storage_test.dart | secondary_classes_test.dart:3980 |
| 306 | widgets/single_child_render_object_element_test.dart | secondary_classes_test.dart:4332 |
| 307 | widgets/single_child_render_object_widget_test.dart | secondary_classes_test.dart:4339 |

---

### Issue #40 — flutter_test import (49 errors)

These scripts import `package:flutter_test` which is not bridged in the interpreter. The interpreter fails with an import resolution error.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 147 | services/message_codec_test.dart | hardly_relevant_classes_3_test.dart:1089 |
| 148 | services/method_codec_test.dart | hardly_relevant_classes_3_test.dart:1096 |
| 152 | widgets/align_transition_test.dart | hardly_relevant_classes_4_test.dart:86 |
| 164 | widgets/clip_r_superellipse_test.dart | hardly_relevant_classes_4_test.dart:385 |
| 165 | widgets/context_action_test.dart | hardly_relevant_classes_4_test.dart:427 |
| 168 | widgets/default_text_style_transition_test.dart | hardly_relevant_classes_4_test.dart:497 |
| 174 | widgets/fractional_translation_test.dart | hardly_relevant_classes_4_test.dart:1020 |
| 179 | widgets/icon_theme_data_test.dart | hardly_relevant_classes_4_test.dart:1158 |
| 188 | widgets/logical_key_set_test.dart | hardly_relevant_classes_4_test.dart:1325 |
| 190 | widgets/matrix_transition_test.dart | hardly_relevant_classes_4_test.dart:1346 |
| 195 | widgets/nested_scroll_view_viewport_test.dart | hardly_relevant_classes_4_test.dart:1414 |
| 198 | widgets/raw_menu_overlay_info_test.dart | hardly_relevant_classes_5_test.dart:196 |
| 199 | widgets/restorable_bool_n_test.dart | hardly_relevant_classes_5_test.dart:442 |
| 200 | widgets/router_config_test.dart | hardly_relevant_classes_5_test.dart:580 |
| 218 | widgets/stream_builder_base_test.dart | hardly_relevant_classes_5_test.dart:1103 |
| 219 | widgets/toolbar_options_test.dart | hardly_relevant_classes_5_test.dart:1209 |
| 220 | widgets/two_dimensional_child_list_delegate_test.dart | hardly_relevant_classes_5_test.dart:1333 |
| 221 | widgets/void_callback_intent_test.dart | hardly_relevant_classes_5_test.dart:1459 |
| 222 | widgets/widget_state_color_test.dart | hardly_relevant_classes_5_test.dart:1506 |
| 223 | widgets/widget_state_mapper_test.dart | hardly_relevant_classes_5_test.dart:1513 |
| 224 | widgets/widget_state_property_all_test.dart | hardly_relevant_classes_5_test.dart:1534 |
| 225 | widgets/widget_state_test.dart | hardly_relevant_classes_5_test.dart:1541 |
| 226 | widgets/widget_states_constraint_test.dart | hardly_relevant_classes_5_test.dart:1555 |
| 228 | animation/tweensequence_test.dart | important_classes_test.dart:912 |
| 229 | services/codecs_test.dart | important_classes_test.dart:1013 |
| 230 | services/channels_test.dart | important_classes_test.dart:1018 |
| 231 | painting/enums_painting_test.dart | secondary_classes_test.dart:552 |
| 232 | rendering/render_pointer_test.dart | secondary_classes_test.dart:643 |
| 233 | semantics/semantics_config_test.dart | secondary_classes_test.dart:728 |
| 235 | dart_ui/ztmp_path_metrics_access_test.dart | secondary_classes_test.dart:1357 |
| 237 | material/text_button_theme_data_test.dart | secondary_classes_test.dart:2229 |
| 238 | material/text_selection_toolbar_test.dart | secondary_classes_test.dart:2236 |
| 239 | material/text_selection_toolbar_text_button_test.dart | secondary_classes_test.dart:2243 |
| 240 | painting/decoration_image_painter_test.dart | secondary_classes_test.dart:2298 |
| 249 | rendering/render_animated_opacity_test.dart | secondary_classes_test.dart:2641 |
| 258 | rendering/render_custom_paint_test.dart | secondary_classes_test.dart:2711 |
| 263 | rendering/render_proxy_box_mixin_test.dart | secondary_classes_test.dart:2865 |
| 265 | rendering/render_repaint_boundary_test.dart | secondary_classes_test.dart:2879 |
| 266 | rendering/render_rotated_box_test.dart | secondary_classes_test.dart:2886 |
| 276 | widgets/animated_modal_barrier_test.dart | secondary_classes_test.dart:3552 |
| 279 | widgets/color_filtered_test.dart | secondary_classes_test.dart:3639 |
| 285 | widgets/dual_transition_builder_test.dart | secondary_classes_test.dart:3716 |
| 289 | widgets/image_filtered_test.dart | secondary_classes_test.dart:3777 |
| 303 | widgets/performance_overlay_test.dart | secondary_classes_test.dart:4001 |
| 304 | widgets/restorable_bool_test.dart | secondary_classes_test.dart:4149 |
| 305 | widgets/shader_mask_test.dart | secondary_classes_test.dart:4311 |
| 308 | widgets/single_ticker_provider_state_mixin_test.dart | secondary_classes_test.dart:4346 |
| 309 | widgets/ticker_provider_state_mixin_test.dart | secondary_classes_test.dart:4574 |

---

### _ThemePreset constructor (14 errors)

Same as Error #129 — the script contains a `_ThemePreset` class defined after it is first referenced. The interpreter fails to resolve the forward reference to the class constructor.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 132 | rendering/render_app_kit_view_test.dart | hardly_relevant_classes_3_test.dart:360 |
| 134 | rendering/render_darwin_platform_view_test.dart | hardly_relevant_classes_3_test.dart:374 |
| 135 | rendering/render_decorated_sliver_test.dart | hardly_relevant_classes_3_test.dart:381 |
| 248 | rendering/render_aligning_shifted_box_test.dart | secondary_classes_test.dart:2634 |
| 250 | rendering/render_animated_size_test.dart | secondary_classes_test.dart:2648 |
| 251 | rendering/render_annotated_region_test.dart | secondary_classes_test.dart:2655 |
| 252 | rendering/render_backdrop_filter_test.dart | secondary_classes_test.dart:2662 |
| 253 | rendering/render_baseline_test.dart | secondary_classes_test.dart:2669 |
| 254 | rendering/render_block_semantics_test.dart | secondary_classes_test.dart:2676 |
| 256 | rendering/render_constrained_overflow_box_test.dart | secondary_classes_test.dart:2690 |
| 257 | rendering/render_custom_multi_child_layout_box_test.dart | secondary_classes_test.dart:2704 |
| 259 | rendering/render_custom_single_child_layout_box_test.dart | secondary_classes_test.dart:2718 |
| 260 | rendering/render_physical_model_test.dart | secondary_classes_test.dart:2844 |
| 262 | rendering/render_pointer_listener_test.dart | secondary_classes_test.dart:2858 |

---

### _ThemeProfile constructor (4 errors)

Same pattern as _ThemePreset — forward reference to `_ThemeProfile` class constructor.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 133 | rendering/render_clip_r_superellipse_test.dart | hardly_relevant_classes_3_test.dart:367 |
| 255 | rendering/render_box_container_defaults_mixin_test.dart | secondary_classes_test.dart:2683 |
| 261 | rendering/render_physical_shape_test.dart | secondary_classes_test.dart:2851 |
| 264 | rendering/render_proxy_box_with_hit_test_behavior_test.dart | secondary_classes_test.dart:2872 |

---

### _Profile constructor (2 errors)

Same pattern — forward reference to `_Profile` class constructor.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 246 | rendering/relayout_when_system_fonts_change_mixin_test.dart | secondary_classes_test.dart:2620 |
| 247 | rendering/render_absorb_pointer_test.dart | secondary_classes_test.dart:2627 |

---

### Issue #21 — hashCode on enum (4 errors)

The interpreter cannot find `hashCode` on bridged enum values.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 183 | widgets/inspector_button_variant_test.dart | hardly_relevant_classes_4_test.dart:1212 |
| 186 | widgets/live_text_input_status_test.dart | hardly_relevant_classes_4_test.dart:1299 |
| 187 | widgets/lock_state_test.dart | hardly_relevant_classes_4_test.dart:1318 |
| 193 | widgets/navigation_mode_test.dart | hardly_relevant_classes_4_test.dart:1386 |

---

### Issue #39 — _SUnknownNode for-loop (3 errors)

Record destructuring in for-loops produces `_SUnknownNode`.

| Error # | Script | Test file:line |
|---------|--------|---------------|
| 149 | services/mouse_cursor_manager_test.dart | hardly_relevant_classes_3_test.dart:0 |
| 177 | widgets/icon_data_property_test.dart | hardly_relevant_classes_4_test.dart:0 |
| 290 | widgets/implicitly_animated_widget_test.dart | secondary_classes_test.dart:0 |

---

## Framework Errors (69 blocks, 304 individual errors)

These are `⚠️ FRAMEWORK ERROR` entries that occur during test execution. Many appear in tests that still PASS — the test harness captures them but the test result is not affected. They indicate runtime issues during Flutter widget rendering in the D4rt interpreter.

### Framework Error Categories

| Category | FW Error Count | Individual Errors | Classification |
|----------|---------------|-------------------|----------------|
| BoxConstraints negative minimum height | 18 (FW1-8, FW27, FW41-45, FW49, FW63) | 102 | Framework constraint |
| RenderFlex overflow | 12 (FW9, FW13, FW18, FW20, FW26, FW30, FW52-54, FW61, FW64, FW66) | 32 | Mixed |
| int.roundToDouble missing | 7 (FW23-24, FW56-60) | 7 | Interpreter limitation |
| Undefined property/variable | 6 (FW10, FW28-29, FW46, FW50, FW55) | 14 | Mixed |
| Failed assertion | 5 (FW15-16, FW36-38) | 51 | Mixed |
| List.whereType missing | 4 (FW65, FW67-69) | 4 | Interpreter limitation |
| List\<Object?\> not subtype of List\<Widget\> | 3 (FW32-33, FW39) | 6 | Interpreter limitation |
| RenderFlex unbounded constraints | 3 (FW40, FW47-48) | 17 | Script error |
| InterpretedInstance/InterpretedFunction | 2 (FW12, FW62) | 4 | Interpreter limitation |
| RenderParagraph infinite size | 2 (FW14, FW19) | 20 | Framework constraint |
| Progress bar semantics | 2 (FW22, FW25) | 2 | Script error |
| ConstraintsTransformBox overflow | 1 (FW31) | 4 | Framework constraint |
| Vertices constructor null | 1 (FW11) | 3 | Interpreter limitation |
| withValues on null | 1 (FW17) | 1 | Interpreter limitation |
| PaginatedDataTable infinite width | 1 (FW21) | 36 | Framework constraint |
| $RelaxedAnimation addListener | 1 (FW35) | 1 | Interpreter limitation |
| visitAncestorElements LateInit | 1 (FW34) | 1 | Interpreter limitation |
| dart:ui math assertion | 1 (FW51) | 1 | Interpreter limitation |

### Classification Summary

| Classification | Count | Individual Errors |
|----------------|-------|-------------------|
| Framework constraint | 26 | ~203 |
| Interpreter limitation | 29 | ~54 |
| Script error | 14 | ~47 |

---

### FW1 — cupertino/controls_test.dart

| Field | Value |
|-------|-------|
| **Log file** | essential_classes_test |
| **Script** | cupertino/controls_test.dart |
| **Error** | BoxConstraints has a negative minimum height (5 errors) |
| **Code** | Multiple `CupertinoTextField` widgets with `InputDecoration` in the test layout |
| **Explanation** | CupertinoTextField's internal layout subtracts decoration heights (borders, prefix/suffix icons, padding) from available vertical space. In the constrained 600×800 test viewport, deeply nested CupertinoTextFields can receive constraints where the remaining height after subtracting ornaments goes negative. This is a known Flutter framework behavior when TextFields are in tightly constrained containers. |
| **Classification** | **Framework constraint** |

### FW2 — cupertino/form_test.dart

| Field | Value |
|-------|-------|
| **Log file** | essential_classes_test |
| **Script** | cupertino/form_test.dart |
| **Error** | BoxConstraints has a negative minimum height (17 errors) |
| **Code** | `CupertinoFormSection` containing multiple `CupertinoTextFormFieldRow` widgets |
| **Explanation** | The CupertinoFormSection stacks multiple form rows with CupertinoTextFields. Each row has internal padding, borders, and prefix labels. The cumulative height consumption causes inner TextFields to receive negative height constraints when the viewport can't accommodate all rows. The 17 individual errors correspond to each TextField that triggers this during the initial layout pass. |
| **Classification** | **Framework constraint** |

### FW3 — cupertino/textfield_test.dart

| Field | Value |
|-------|-------|
| **Log file** | essential_classes_test |
| **Script** | cupertino/textfield_test.dart |
| **Error** | BoxConstraints has a negative minimum height (13 errors) |
| **Code** | Extensive CupertinoTextField showcase with various decoration configurations |
| **Explanation** | The script demonstrates many CupertinoTextField variants (with prefixes, suffixes, clearButtons, custom padding). In the constrained test viewport, multiple TextFields in a scrollable Column each trigger the negative height constraint during Flutter's intrinsic size calculation for InputDecoration. |
| **Classification** | **Framework constraint** |

### FW4 — cupertino/cupertino_desktop_text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | cupertino/cupertino_desktop_text_selection_controls_test.dart |
| **Error** | BoxConstraints has a negative minimum height (3 errors) |
| **Code** | CupertinoTextField widgets in desktop text selection context |
| **Explanation** | Same CupertinoTextField negative height issue in the constrained test viewport. The desktop text selection controls add additional overlay widgets that further constrain the available layout height. |
| **Classification** | **Framework constraint** |

### FW5 — cupertino/cupertino_focus_halo_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | cupertino/cupertino_focus_halo_test.dart |
| **Error** | BoxConstraints has a negative minimum height (3 errors) |
| **Code** | CupertinoTextField with focus halo decoration |
| **Explanation** | Focus halo adds decoration around CupertinoTextField, consuming additional layout space. In the constrained viewport, the TextField receives negative height constraints. |
| **Classification** | **Framework constraint** |

### FW6 — cupertino/cupertino_text_selection_handle_controls_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | cupertino/cupertino_text_selection_handle_controls_test.dart |
| **Error** | BoxConstraints has a negative minimum height (11 errors) |
| **Code** | Multiple CupertinoTextField instances with text selection handles |
| **Explanation** | CupertinoTextField with selection overlays in constrained viewport. The 11 errors correspond to multiple TextField widgets that each trigger the negative height constraint during layout. |
| **Classification** | **Framework constraint** |

### FW7 — cupertino/inherited_cupertino_theme_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | cupertino/inherited_cupertino_theme_test.dart |
| **Error** | BoxConstraints has a negative minimum height (3 errors) |
| **Code** | CupertinoTextField within InheritedCupertinoTheme showcase |
| **Explanation** | Theme inheritance demo using CupertinoTextField triggers the same negative height constraint in the test viewport. |
| **Classification** | **Framework constraint** |

### FW8 — cupertino/overlay_visibility_mode_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | cupertino/overlay_visibility_mode_test.dart |
| **Error** | BoxConstraints has a negative minimum height (7 errors) |
| **Code** | CupertinoTextField with various OverlayVisibilityMode settings |
| **Explanation** | Multiple CupertinoTextField widgets demonstrating different overlay visibility modes. Each TextField triggers the negative height constraint in the constrained viewport. |
| **Classification** | **Framework constraint** |

### FW9 — dart_ui/blur_style_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | dart_ui/blur_style_test.dart |
| **Error** | A RenderFlex overflowed by 2.0 pixels on the bottom (4 errors) |
| **Code** | `Container(height: 100, ...)` containing a Column with Icon, title, description, and blur effect demo widgets |
| **Explanation** | Each blur style demo card uses `Container(height: 100)` but the inner Column content (Icon + title Text + description Text + blur demo) exceeds 100px by 2 pixels. The fixed height is too small for the content. |
| **Classification** | **Script error** — fixed Container height is 2px too small for content |

### FW10 — dart_ui/key_event_type_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | dart_ui/key_event_type_test.dart |
| **Error** | Undefined property or method 'label' on bridged instance of 'KeyEventType' (1 error) |
| **Code** | Access to `keyEventType.label` — a custom extension getter or property on KeyEventType enum |
| **Explanation** | The script accesses a `.label` property on `KeyEventType` enum values. D4rt's bridge for `KeyEventType` doesn't include a `label` property. In native Dart, this might be defined via an extension method or a custom getter. The bridge doesn't surface it. |
| **Classification** | **Script error** — `KeyEventType` has no `.label` property; the script defines or expects an extension that doesn't work in D4rt |

### FW11 — dart_ui/vertex_mode_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_1_test |
| **Script** | dart_ui/vertex_mode_test.dart |
| **Error** | Native error during default bridged constructor for 'Vertices': Invalid parameter "positions": must not be null (3 errors) |
| **Code** | `Vertices(mode, positions, ...)` where `positions` is built conditionally via switch-case on `VertexMode` values |
| **Explanation** | The script uses a switch-case on `VertexMode` enum values to compute vertex positions. D4rt's interpreter doesn't correctly execute the switch-case body, resulting in `positions` remaining null when passed to the `Vertices` constructor. The constructor's native bridge rejects the null value. |
| **Classification** | **Interpreter limitation** — switch-case on enum values not executing correctly in D4rt |

### FW12 — material/button_bar_theme_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/button_bar_theme_test.dart |
| **Error** | Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme) (2 errors) |
| **Code** | `ButtonBarTheme(data: ..., child: ...)` — ButtonBarTheme used as a widget in the tree |
| **Explanation** | The script creates a `ButtonBarTheme` widget (an InheritedWidget). D4rt wraps it as an `InterpretedInstance` instead of recognizing it as a native Widget. When the framework tries to use it in the widget tree, the type check fails. This is similar to the InterpretedInstance issue (#24) but specifically for InheritedWidget subclasses used as direct children. |
| **Classification** | **Interpreter limitation** — D4rt wraps InheritedWidget subclass instances as InterpretedInstance instead of native Widget |

### FW13 — material/drawer_controller_state_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/drawer_controller_state_test.dart |
| **Error** | A RenderFlex overflowed by 46 pixels on the right (3 errors) |
| **Code** | `Drawer(width: 280)` containing navigation items with long text labels in the test viewport |
| **Explanation** | The drawer is constrained to 280px width and contains ListTile widgets with icons and text. Some text labels (e.g., "Advanced Configuration Options") combined with leading icons and padding exceed the 280px drawer width. The 3 errors correspond to 3 separate overflow instances. |
| **Classification** | **Framework constraint** — drawer width with long text items causes overflow in test viewport |

### FW14 — material/end_drawer_button_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/end_drawer_button_test.dart |
| **Error** | RenderParagraph object was given an infinite size during layout (8 errors) |
| **Code** | Text widgets inside unconstrained horizontal layouts within the end drawer |
| **Explanation** | The end drawer layout uses Row widgets or horizontal layouts where Text widgets don't have width constraints. RenderParagraph (the underlying text renderer) receives infinite width during layout, which it cannot handle. The 8 errors correspond to 8 Text widgets in the drawer that hit this issue. |
| **Classification** | **Framework constraint** — drawer layout provides infinite horizontal constraints to text widgets |

### FW15 — material/gapped_range_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/gapped_range_slider_track_shape_test.dart |
| **Error** | Null check operator used on a null value (18 errors) |
| **Code** | `SliderThemeData(trackGap: ...)` — missing `trackGap` parameter in SliderTheme |
| **Explanation** | The `GappedRangeSliderTrackShape` requires `sliderTheme.trackGap` to be non-null. The script either doesn't set `trackGap` in the theme data, or D4rt doesn't pass it through correctly. The null check `trackGap!` in the framework code triggers 18 times during painting of slider tracks. |
| **Classification** | **Script error** — `trackGap` not set in SliderThemeData; required by GappedRangeSliderTrackShape |

### FW16 — material/gapped_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/gapped_slider_track_shape_test.dart |
| **Error** | Failed assertion: 'sliderTheme.trackGap != null' (28 errors) |
| **Code** | Same `trackGap` issue as FW15 but for `GappedSliderTrackShape` |
| **Explanation** | The `GappedSliderTrackShape` assertion explicitly checks `sliderTheme.trackGap != null`. The script doesn't provide `trackGap` in the theme data. The 28 errors correspond to multiple paint calls during slider rendering without the required theme parameter. |
| **Classification** | **Script error** — `trackGap` not set in SliderThemeData |

### FW17 — material/hour_format_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/hour_format_test.dart |
| **Error** | Cannot invoke method 'withValues' on null (1 error) |
| **Code** | `MediaQuery.of(context).textScaler.withValues(...)` or similar — accessing a property on a null object |
| **Explanation** | The script accesses a field using `this.field` initialization syntax in a class constructor or initializer. D4rt doesn't correctly evaluate `this.field` references during initialization, resulting in null. When `.withValues()` is called on the null result, the error triggers. |
| **Classification** | **Interpreter limitation** — D4rt doesn't handle `this.field` initialization correctly |

### FW18 — material/list_tile_title_alignment_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/list_tile_title_alignment_test.dart |
| **Error** | A RenderFlex overflowed by 1.00 pixels on the bottom (3 errors) |
| **Code** | `ListTile` widgets with multiline titles and subtitles in constrained containers |
| **Explanation** | ListTile with various `titleAlignment` settings and multiline content overflows by exactly 1 pixel. The font metrics and line height calculations in the test viewport cause the ListTile's internal Row/Column to be 1px taller than the available space. |
| **Classification** | **Framework constraint** — 1px overflow due to font metrics in test viewport |

### FW19 — material/menu_accelerator_callback_binding_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/menu_accelerator_callback_binding_test.dart |
| **Error** | RenderParagraph object was given an infinite size during layout (12 errors) |
| **Code** | `MenuBar` with `MenuItemButton` children containing Text widgets |
| **Explanation** | The MenuBar's internal layout provides unconstrained width to menu item children. Text widgets inside MenuItemButton receive infinite width constraints, which RenderParagraph cannot handle. The 12 errors correspond to 12 menu items that trigger this during layout. |
| **Classification** | **Framework constraint** — MenuBar's internal layout provides infinite constraints to child text |

### FW20 — material/navigation_drawer_theme_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/navigation_drawer_theme_test.dart |
| **Error** | A RenderFlex overflowed by 29 pixels on the bottom (3 errors) |
| **Code** | `NavigationDrawer` with many `NavigationDrawerDestination` items in a fixed-height container |
| **Explanation** | The navigation drawer contains destinations with icons and labels. The drawer's body height is too small to fit all destinations, causing 29px of bottom overflow. The fixed drawer height in the test viewport doesn't accommodate all navigation items. |
| **Classification** | **Script error** — drawer content exceeds available height; should use scrolling or fewer items |

### FW21 — material/paginated_data_table_state_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/paginated_data_table_state_test.dart |
| **Error** | BoxConstraints forces an infinite width (36 errors) |
| **Code** | `PaginatedDataTable` inside `SingleChildScrollView(scrollDirection: Axis.horizontal)` |
| **Explanation** | Placing PaginatedDataTable inside a horizontal SingleChildScrollView provides infinite width constraints. PaginatedDataTable's internal layout (DataTable, header row, pagination controls) propagates the infinite width to 36 separate render objects that each report the constraint violation. This is a known Flutter pattern issue — PaginatedDataTable should not be placed in a horizontally unbounded container. |
| **Classification** | **Framework constraint** — PaginatedDataTable in horizontal ScrollView is a known Flutter layout pattern issue |

### FW22 — material/progress_indicator_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/progress_indicator_test.dart |
| **Error** | Progress bar value, minValue, and maxValue must be valid numbers. value: "67%", minValue: "0", maxValue: "100" (1 error) |
| **Code** | `LinearProgressIndicator(value: 0.67, semanticsValue: '67%')` — semanticsValue contains non-numeric '%' |
| **Explanation** | The `semanticsValue: '67%'` parameter is passed to the accessibility framework. The progress bar semantics validator expects a pure numeric string for the value, but '67%' contains a '%' character. In native Flutter, this works because the semantics layer parses it differently, but in D4rt's rendering the validator rejects it. |
| **Classification** | **Script error** — `semanticsValue` should be `'67'` not `'67%'` for strict numeric validation |

### FW23 — material/rectangular_range_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/rectangular_range_slider_track_shape_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | `value.roundToDouble()` where `value` is typed as `double` but receives an `int` at runtime |
| **Explanation** | The `fmt()` helper calls `roundToDouble()` on a parameter typed as `double`. D4rt's runtime may pass an `int` value from RangeValues calculations. D4rt's bridged `int` class lacks `roundToDouble()`, which in native Dart is inherited from `num`. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` from `num` |

### FW24 — material/rectangular_range_slider_value_indicator_shape_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/rectangular_range_slider_value_indicator_shape_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | Same `fmt()` / `roundToDouble()` pattern as FW23 |
| **Explanation** | Same root cause — `int.roundToDouble()` missing from D4rt's bridge. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` |

### FW25 — material/refresh_progress_indicator_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_2_test |
| **Script** | material/refresh_progress_indicator_test.dart |
| **Error** | Progress bar value, minValue, and maxValue must be valid numbers. value: "50%", minValue: "0", maxValue: "100" (1 error) |
| **Code** | `RefreshProgressIndicator(value: 0.5, semanticsValue: '50%')` |
| **Explanation** | Same as FW22 — `semanticsValue` contains '%' which the accessibility validator rejects as non-numeric. |
| **Classification** | **Script error** — `semanticsValue` should be `'50'` not `'50%'` |

### FW26 — rendering/floating_header_snap_configuration_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_3_test |
| **Script** | rendering/floating_header_snap_configuration_test.dart |
| **Error** | A RenderFlex overflowed by 2.0 pixels on the bottom (1 error) |
| **Code** | SliverAppBar with floating header configuration in constrained viewport |
| **Explanation** | The floating header snap configuration demo places content that is 2px taller than available space. Minor overflow from font metrics or padding in the test viewport. |
| **Classification** | **Framework constraint** — small overflow from layout in test viewport |

### FW27 — rendering/render_editable_painter_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_3_test |
| **Script** | rendering/render_editable_painter_test.dart |
| **Error** | BoxConstraints has a negative minimum height (3 errors) |
| **Code** | TextField widgets with InputDecoration in the render editable painter demo |
| **Explanation** | Same CupertinoTextField/TextField negative height issue — InputDecoration's internal layout arithmetic produces negative constraints in the constrained test viewport. |
| **Classification** | **Framework constraint** — TextField InputDecoration in constrained viewport |

### FW28 — rendering/render_object_with_layout_callback_mixin_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_3_test |
| **Script** | rendering/render_object_with_layout_callback_mixin_test.dart |
| **Error** | Undefined property or method 'toString' on Orientation (1 error) |
| **Code** | `orientation.toString()` or string interpolation using an `Orientation` enum value |
| **Explanation** | D4rt's bridge for the `Orientation` enum doesn't include a `toString()` override. In native Dart, all objects have `toString()` inherited from `Object`, but D4rt's bridged enum instances don't properly delegate to the base `toString()` implementation. |
| **Classification** | **Interpreter limitation** — D4rt's bridged enum instances don't support `toString()` |

### FW29 — widgets/animated_positioned_directional_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_4_test |
| **Script** | widgets/animated_positioned_directional_test.dart |
| **Error** | Undefined variable: context (Undefined property 'context' on _AnimatedPositionedState) (1 error) |
| **Code** | `State.context` access — using `context` inside a State subclass method |
| **Explanation** | The `_AnimatedPositionedState` class accesses `context` (the `State.context` getter). D4rt's bridge for `State<T>` doesn't expose the `context` property. In native Flutter, `State.context` returns the associated `BuildContext`. |
| **Classification** | **Interpreter limitation** — D4rt's `State<T>` bridge doesn't expose the `context` getter |

### FW30 — widgets/constrained_layout_builder_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_4_test |
| **Script** | widgets/constrained_layout_builder_test.dart |
| **Error** | A RenderFlex overflowed by 14 pixels on the bottom (9 errors) |
| **Code** | `ConstrainedLayoutBuilder` demos with fixed-height cards containing Column layouts |
| **Explanation** | The demo creates multiple cards showing ConstrainedLayoutBuilder behavior at different constraint breakpoints. Several cards have fixed heights that are ~14px too short for their Column content (icons, text, size info). The 9 errors correspond to 9 separate card containers that overflow. |
| **Classification** | **Framework constraint** — card content slightly exceeds fixed heights in test viewport |

### FW31 — widgets/constraints_transform_box_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_4_test |
| **Script** | widgets/constraints_transform_box_test.dart |
| **Error** | A RenderConstraintsTransformBox overflowed by 11px left, 8.5px top, 8.5px bottom, 11px right (4 errors) |
| **Code** | `ConstraintsTransformBox` with intentionally unconstrained children to demonstrate overflow behavior |
| **Explanation** | The script intentionally creates overflow situations to demonstrate `ConstraintsTransformBox` behavior. The overflow is part of the demo — showing how the transform box handles children that exceed parent constraints. |
| **Classification** | **Framework constraint** — intentional overflow demo |

### FW32 — widgets/nested_scroll_view_state_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_4_test |
| **Script** | widgets/nested_scroll_view_state_test.dart |
| **Error** | type 'List\<Object?\>' is not a subtype of type 'List\<Widget\>' in type cast (1 error) |
| **Code** | Untyped list literal `[Widget1(), Widget2(), ...]` used where `List<Widget>` is expected |
| **Explanation** | D4rt infers untyped list literals as `List<Object?>` instead of `List<Widget>`. When passed to a parameter expecting `List<Widget>`, the runtime type cast fails. In native Dart, the type is inferred from context. |
| **Classification** | **Interpreter limitation** — D4rt's type inference for list literals loses generic type information |

### FW33 — widgets/render_nested_scroll_view_viewport_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_5_test |
| **Script** | widgets/render_nested_scroll_view_viewport_test.dart |
| **Error** | type 'List\<Object?\>' is not a subtype of type 'List\<Widget\>' in type cast (1 error) |
| **Code** | Same untyped list literal issue as FW32 |
| **Explanation** | Same root cause — untyped list literal inferred as `List<Object?>` instead of `List<Widget>` by D4rt. |
| **Classification** | **Interpreter limitation** — D4rt list literal type inference |

### FW34 — widgets/render_tree_root_element_test.dart

| Field | Value |
|-------|-------|
| **Log file** | hardly_relevant_classes_5_test |
| **Script** | widgets/render_tree_root_element_test.dart |
| **Error** | Native error during bridged method call 'visitAncestorElements' on StatelessElement: LateInitializationError (1 error) |
| **Code** | `context.visitAncestorElements((element) { ... })` — traversing ancestor elements |
| **Explanation** | The script calls `visitAncestorElements` on a `BuildContext` (which is a `StatelessElement`). D4rt's bridge for `Element` triggers a `LateInitializationError` when accessing an internal field during ancestor traversal. The Element's internal state hasn't been fully initialized by the time the bridge method executes. |
| **Classification** | **Interpreter limitation** — D4rt's Element bridge has incomplete initialization for ancestor traversal |

### FW35 — widgets/slidetransition_test.dart

| Field | Value |
|-------|-------|
| **Log file** | important_classes_test |
| **Script** | widgets/slidetransition_test.dart |
| **Error** | NoSuchMethodError: Class '$RelaxedAnimation\<Offset\>' has no instance method 'addListener' (1 error) |
| **Code** | `SlideTransition(position: animation, ...)` where `animation` is an `Animation<Offset>` |
| **Explanation** | D4rt wraps the `Animation<Offset>` as a `$RelaxedAnimation<Offset>` proxy. The proxy class doesn't include the `addListener` method that Flutter's animation framework calls internally. When `SlideTransition` tries to register a listener on the animation, the method lookup fails. |
| **Classification** | **Interpreter limitation** — D4rt's `$RelaxedAnimation` proxy missing `addListener` method |

### FW36 — widgets/sliverlist_test.dart

| Field | Value |
|-------|-------|
| **Log file** | important_classes_test |
| **Script** | widgets/sliverlist_test.dart |
| **Error** | Failed assertion: '_elements.contains(element)' (1 error) |
| **Code** | `SliverList` with delegate building widgets |
| **Explanation** | D4rt's `BuildOwner` lifecycle management doesn't properly track all elements during the build/mount phase for sliver widgets. The `_elements.contains(element)` assertion in Flutter's framework.dart checks that an element is registered before deactivation. D4rt's element lifecycle differs from native Flutter, causing unregistered elements to reach the deactivation code path. |
| **Classification** | **Interpreter limitation** — D4rt's BuildOwner element lifecycle tracking differs from native Flutter |

### FW37 — widgets/table_test.dart

| Field | Value |
|-------|-------|
| **Log file** | important_classes_test |
| **Script** | widgets/table_test.dart |
| **Error** | Failed assertion: '_elements.contains(element)' (1 error) |
| **Code** | `Table` widget with `TableRow` children |
| **Explanation** | Same `_elements.contains` assertion as FW36. D4rt's element lifecycle management for Table widgets doesn't properly register/deactivate elements. |
| **Classification** | **Interpreter limitation** — D4rt BuildOwner element lifecycle |

### FW38 — widgets/visibility_test.dart

| Field | Value |
|-------|-------|
| **Log file** | important_classes_test |
| **Script** | widgets/visibility_test.dart |
| **Error** | Failed assertion: '_elements.contains(element)' (1 error) |
| **Code** | `Visibility` widget toggling child visibility |
| **Explanation** | Same `_elements.contains` assertion as FW36-37. Visibility toggling triggers element deactivation/reactivation that D4rt's BuildOwner doesn't track correctly. |
| **Classification** | **Interpreter limitation** — D4rt BuildOwner element lifecycle |

### FW39 — widgets/nestedscrollview_test.dart

| Field | Value |
|-------|-------|
| **Log file** | important_classes_test |
| **Script** | widgets/nestedscrollview_test.dart |
| **Error** | type 'List\<Object?\>' is not a subtype of type 'List\<Widget\>' in type cast (4 errors) |
| **Code** | Multiple untyped list literals used as `children` parameters |
| **Explanation** | Same as FW32-33. D4rt infers untyped list literals as `List<Object?>` instead of `List<Widget>`. The 4 errors correspond to 4 separate list literals in the script that lose their generic type information. |
| **Classification** | **Interpreter limitation** — D4rt list literal type inference |

### FW40 — material/refreshindicator_test.dart

| Field | Value |
|-------|-------|
| **Log file** | important_classes_test |
| **Script** | material/refreshindicator_test.dart |
| **Error** | RenderFlex children have non-zero flex but incoming height constraints are unbounded (13 errors) |
| **Code** | `Expanded` widget inside a `Column` that is inside a `SingleChildScrollView` |
| **Explanation** | The script places `Expanded` children inside a `Column` within a `SingleChildScrollView`. The scroll view provides unbounded height to its child, but `Expanded` requires bounded height constraints to compute its flex allotment. This is a well-known Flutter anti-pattern. The 13 errors correspond to 13 Expanded widgets that hit this constraint violation. |
| **Classification** | **Script error** — `Expanded` inside `SingleChildScrollView` is a known Flutter anti-pattern |

### FW41 — cupertino/cupertino_secondary_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | cupertino/cupertino_secondary_test.dart |
| **Error** | BoxConstraints has a negative minimum height (3 errors) |
| **Code** | CupertinoTextField widgets in the secondary Cupertino demo |
| **Explanation** | Same CupertinoTextField negative height constraint issue in the test viewport. |
| **Classification** | **Framework constraint** |

### FW42 — cupertino/cupertino_form_scroll_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | cupertino/cupertino_form_scroll_test.dart |
| **Error** | BoxConstraints has a negative minimum height (4 errors) |
| **Code** | CupertinoFormSection with CupertinoTextFormFieldRow in scrollable form |
| **Explanation** | Same CupertinoTextField negative height constraint. Form fields in scrollable container. |
| **Classification** | **Framework constraint** |

### FW43 — cupertino/cupertino_controls_advanced_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | cupertino/cupertino_controls_advanced_test.dart |
| **Error** | BoxConstraints has a negative minimum height (4 errors) |
| **Code** | Advanced Cupertino controls with CupertinoTextField |
| **Explanation** | Same CupertinoTextField negative height constraint in test viewport. |
| **Classification** | **Framework constraint** |

### FW44 — cupertino/cupertino_sections_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | cupertino/cupertino_sections_test.dart |
| **Error** | BoxConstraints has a negative minimum height (5 errors) |
| **Code** | CupertinoFormSection with text fields |
| **Explanation** | Same CupertinoTextField negative height constraint in test viewport. |
| **Classification** | **Framework constraint** |

### FW45 — cupertino/cupertino_tabbar_scaffold_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | cupertino/cupertino_tabbar_scaffold_test.dart |
| **Error** | BoxConstraints has a negative minimum height (9 errors) |
| **Code** | CupertinoTabScaffold with CupertinoTextField in tab pages |
| **Explanation** | CupertinoTextField inside CupertinoTabScaffold tabs. The tab scaffold's navigation bar consumes additional vertical space, making the negative constraint issue more likely for TextFields in the remaining body area. |
| **Classification** | **Framework constraint** |

### FW46 — widgets/layout_builder_adv_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/layout_builder_adv_test.dart |
| **Error** | Undefined variable: layoutChild (Undefined property 'layoutChild' on _FlowDemoState) (7 errors) |
| **Code** | `layoutChild(i, BoxConstraints(...))` — calling a method inherited from FlowDelegate superclass |
| **Explanation** | The script defines a `FlowDelegate` subclass whose `paintChildren` override calls `layoutChild()`. In native Dart, `layoutChild` is provided by the `FlowPaintingContext` parameter. D4rt's interpreter doesn't resolve `layoutChild` as a method on the painting context — it looks for it as a local variable or property on the delegate class itself, failing to find it. |
| **Classification** | **Interpreter limitation** — D4rt doesn't resolve methods from `FlowPaintingContext` parameter correctly |

### FW47 — widgets/scroll_position_types_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/scroll_position_types_test.dart |
| **Error** | RenderFlex children have non-zero flex but incoming height constraints are unbounded (2 errors) |
| **Code** | `Expanded` inside a `Column` that is inside `SingleChildScrollView` |
| **Explanation** | Same anti-pattern as FW40 — `Expanded` widget in an unbounded-height container. |
| **Classification** | **Script error** — `Expanded` inside `SingleChildScrollView` |

### FW48 — widgets/scroll_controllers_types_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/scroll_controllers_types_test.dart |
| **Error** | RenderFlex children have non-zero flex but incoming height constraints are unbounded (2 errors) |
| **Code** | `Expanded` inside a `Column` within `SingleChildScrollView` |
| **Explanation** | Same anti-pattern as FW40, FW47. |
| **Classification** | **Script error** — `Expanded` inside `SingleChildScrollView` |

### FW49 — cupertino/cupertino_text_selection_controls_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | cupertino/cupertino_text_selection_controls_test.dart |
| **Error** | BoxConstraints has a negative minimum height (9 errors) |
| **Code** | CupertinoTextField with text selection controls |
| **Explanation** | Same CupertinoTextField negative height constraint in test viewport. |
| **Classification** | **Framework constraint** |

### FW50 — dart_ui/platform_dispatcher_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | dart_ui/platform_dispatcher_test.dart |
| **Error** | Undefined property or method 'toString' on Brightness (1 error) |
| **Code** | `brightness.toString()` or string interpolation using a `Brightness` enum value |
| **Explanation** | Same as FW28 — D4rt's bridged enum instances don't support `toString()`. The `Brightness` enum bridge is missing the toString delegation. |
| **Classification** | **Interpreter limitation** — D4rt's bridged enum instances don't support `toString()` |

### FW51 — dart_ui/scene_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | dart_ui/scene_test.dart |
| **Error** | 'dart:ui/math.dart': Failed assertion: line 14 pos 10: '\<optimized out\>': is not true (1 error) |
| **Code** | `builder.pushTransform(matrix)` with `Float64List` 4x4 transform matrix in `SceneBuilder` pipeline |
| **Explanation** | The script exercises low-level `dart:ui` scene composition — `PictureRecorder`, `Canvas`, `SceneBuilder`, `pushTransform`, `pushOpacity`, `pushClipRect/RRect/Path`, `addPicture`, and `build()`. The assertion failure originates inside `dart:ui/math.dart`, an internal validation module. D4rt's bridge for these dart:ui Scene APIs doesn't fully replicate the native memory layout or type fidelity expected by dart:ui's internal math routines when processing Float64List transform matrices. |
| **Classification** | **Interpreter limitation** — D4rt's dart:ui Scene API bridge doesn't satisfy internal math assertions |

### FW52 — dart_ui/semantics_action_event_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | dart_ui/semantics_action_event_test.dart |
| **Error** | A RenderFlex overflowed by 24 pixels on the right and 158 pixels on the right (2 errors) |
| **Code** | `SizedBox(width: 250/260)` containing `DropdownButtonFormField` with long text items like "Cursor - Char (moveCursorBackwardByCharacter)" |
| **Explanation** | Fixed-width containers combined with long text content in `DropdownButtonFormField` items cause internal framework Row layouts to overflow. The action item text (~45 chars) exceeds the 260px-minus-decoration available width, causing the 158px overflow. |
| **Classification** | **Framework constraint** — fixed-width containers with long DropdownMenuItem text |

### FW53 — dart_ui/string_attribute_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | dart_ui/string_attribute_test.dart |
| **Error** | A RenderFlex overflowed by 4.0 pixels on the bottom (1 error) |
| **Code** | `_HierarchyConnector`: `SizedBox(height: 24)` containing `Container(height: 12)` + `Icon(size: 16)` = 28px in 24px container |
| **Explanation** | The `_HierarchyConnector` widget places 28px of content (12px Container + 16px Icon) in a 24px SizedBox, causing exactly 4.0 pixels of overflow. Simple arithmetic mismatch. |
| **Classification** | **Script error** — SizedBox(height: 24) is 4px too small for 28px of content |

### FW54 — dart_ui/target_image_size_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | dart_ui/target_image_size_test.dart |
| **Error** | A RenderFlex overflowed by 16 pixels on the bottom (2 errors) |
| **Code** | `_buildSizeVisualization` with `(size.height! / 10).clamp(30.0, 100.0)` container height containing Icon(24) + SizedBox(4) + Text(10) + Text(12) ≈ 46px |
| **Explanation** | For input heights of 300 and 200, the container clamps to 30px minimum, but inner content is ~46px, causing 16px overflow. |
| **Classification** | **Script error** — clamp minimum of 30px is too small for 46px of content |

### FW55 — gestures/vertical_multi_drag_gesture_recognizer_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | gestures/vertical_multi_drag_gesture_recognizer_test.dart |
| **Error** | Undefined variable: widget (Undefined property 'widget' on _VerticalTrackState) (3 errors) |
| **Code** | `widget.color` and `widget.label` accessed in `_VerticalTrackState extends State<_VerticalTrack>` |
| **Explanation** | The `State.widget` getter is not exposed by D4rt's bridge. The `_VerticalTrackState` accesses `widget.color` and `widget.label` — valid Flutter code that D4rt can't resolve. The 3 errors correspond to 3 separate `widget.*` accesses. |
| **Classification** | **Interpreter limitation** — D4rt's `State<T>` bridge doesn't expose the `widget` getter |

### FW56 — material/range_slider_track_shape_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | material/range_slider_track_shape_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | `value.roundToDouble()` in `fmt()` helper function |
| **Explanation** | D4rt's `int` bridge is missing `roundToDouble()` (inherited from `num` in native Dart). Called when RangeSlider provides integer values to the format function. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` |

### FW57 — material/range_slider_value_indicator_shape_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | material/range_slider_value_indicator_shape_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | Same `fmt()` / `roundToDouble()` pattern |
| **Explanation** | Same root cause as FW56. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` |

### FW58 — material/range_values_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | material/range_values_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | `fmt()` function with `roundToDouble()` + `((value - min) / step).roundToDouble()` at line 313 |
| **Explanation** | Same root cause. `RangeValues(20, 72)` integer literals stored as `int` by D4rt despite `double` typing. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` |

### FW59 — material/spell_check_suggestions_toolbar_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | material/spell_check_suggestions_toolbar_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | Same `fmt()` / `roundToDouble()` pattern |
| **Explanation** | Same root cause as FW56-58. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` |

### FW60 — material/tab_bar_theme_data_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | material/tab_bar_theme_data_test.dart |
| **Error** | Bridged class 'int' has no instance method named 'roundToDouble' (1 error) |
| **Code** | Same pattern, function named `f` instead of `fmt` |
| **Explanation** | Same root cause as FW56-59. |
| **Classification** | **Interpreter limitation** — D4rt's `int` bridge missing `roundToDouble()` |

### FW61 — painting/image_info_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | painting/image_info_test.dart |
| **Error** | A RenderFlex overflowed by 27 pixels on the bottom (2 errors) |
| **Code** | `buildPlaceholderGraphic(100, 100, 3.0, ...)` — container height = 100/3/10 = 33px but content (Icon 24 + gap 4 + 2 Texts) ≈ 60px |
| **Explanation** | The `buildPlaceholderGraphic` function computes container size as `(value / 10).clamp(...)`. At scale 3.0, the container is 33×33px but the inner content (Icon + SizedBox + two Texts) is ~60px, causing 27px overflow. |
| **Classification** | **Script error** — content doesn't adapt to dynamically-computed container size |

### FW62 — rendering/custom_painter_semantics_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | rendering/custom_painter_semantics_test.dart |
| **Error** | Invalid parameter "semanticsBuilder": expected ((Size) => List\<CustomPainterSemantics\>) but got InterpretedFunction (2 errors) |
| **Code** | `SemanticsBuilderCallback? get semanticsBuilder => (Size size) { return [...]; }` in CustomPainter subclass |
| **Explanation** | The `semanticsBuilder` getter returns a Dart function literal. D4rt returns it as an `InterpretedFunction` instead of a native closure. The Flutter framework type-checks the return value and rejects the InterpretedFunction. |
| **Classification** | **Interpreter limitation** — D4rt doesn't convert interpreted functions to native closure types expected by framework |

### FW63 — rendering/render_editable_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | rendering/render_editable_test.dart |
| **Error** | BoxConstraints has a negative minimum height (3 errors) |
| **Code** | TextField widgets with `InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: ...)` |
| **Explanation** | Same CupertinoTextField/TextField negative height constraint issue. Multiple TextFields with various decorations (prefix icons, error text, dense mode) in constrained viewport. |
| **Classification** | **Framework constraint** — TextField InputDecoration in constrained viewport |

### FW64 — rendering/render_ignore_pointer_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | rendering/render_ignore_pointer_test.dart |
| **Error** | A RenderFlex overflowed by 4.0 pixels on the bottom (1 error) |
| **Code** | `SizedBox(height: 100)` containing Column with 2 ElevatedButtons + SizedBox(height: 8) gap = 104px |
| **Explanation** | Two ElevatedButtons (each ~48px with padding) + 8px gap = 104px in a 100px SizedBox, causing 4px overflow. |
| **Classification** | **Script error** — SizedBox(height: 100) is 4px too short for content |

### FW65 — widgets/animated_cross_fade_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/animated_cross_fade_test.dart |
| **Error** | Bridged class 'List' has no instance method named 'whereType' (1 error) |
| **Code** | No explicit `whereType` call in script — called internally by `AnimatedCrossFade` widget |
| **Explanation** | `AnimatedCrossFade` internally uses `List.whereType<T>()` during its widget build/update cycle. D4rt's `List` bridge doesn't implement `whereType<T>()`. |
| **Classification** | **Interpreter limitation** — D4rt's `List` bridge missing `whereType<T>()` |

### FW66 — widgets/animated_fractionally_sized_box_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/animated_fractionally_sized_box_test.dart |
| **Error** | A RenderFlex overflowed by 8.0 pixels on the bottom (1 error) |
| **Code** | Scaffold + AppBar + body with nested demo containers |
| **Explanation** | The Scaffold's AppBar (~56px) plus body padding and nested section cards with fixed-height demo areas cause a small overflow in one of the inner containers. |
| **Classification** | **Framework constraint** — nested layout overflow in constrained test viewport |

### FW67 — widgets/animated_switcher_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/animated_switcher_test.dart |
| **Error** | Bridged class 'List' has no instance method named 'whereType' (1 error) |
| **Code** | No explicit `whereType` call — `AnimatedSwitcher` internally uses `List.whereType<T>()` |
| **Explanation** | Same root cause as FW65. |
| **Classification** | **Interpreter limitation** — D4rt's `List` bridge missing `whereType<T>()` |

### FW68 — widgets/backdrop_filter_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/backdrop_filter_test.dart |
| **Error** | Bridged class 'List' has no instance method named 'whereType' (1 error) |
| **Code** | No explicit `whereType` call — framework ancestor internally calls `List.whereType<T>()` |
| **Explanation** | Same root cause as FW65, FW67. |
| **Classification** | **Interpreter limitation** — D4rt's `List` bridge missing `whereType<T>()` |

### FW69 — widgets/physical_model_test.dart

| Field | Value |
|-------|-------|
| **Log file** | secondary_classes_test |
| **Script** | widgets/physical_model_test.dart |
| **Error** | Bridged class 'List' has no instance method named 'whereType' (1 error) |
| **Code** | No explicit `whereType` call — framework ancestor internally calls `List.whereType<T>()` |
| **Explanation** | Same root cause as FW65, FW67-68. |
| **Classification** | **Interpreter limitation** — D4rt's `List` bridge missing `whereType<T>()` |

---

### Consolidated Framework Error Tables

#### BoxConstraints Negative Height — Framework Constraint (18 errors, 102 individual)

All caused by CupertinoTextField / TextField with InputDecoration in constrained test viewport.

| FW# | Script | Individual Errors |
|-----|--------|-------------------|
| 1 | cupertino/controls_test.dart | 5 |
| 2 | cupertino/form_test.dart | 17 |
| 3 | cupertino/textfield_test.dart | 13 |
| 4 | cupertino/cupertino_desktop_text_selection_controls_test.dart | 3 |
| 5 | cupertino/cupertino_focus_halo_test.dart | 3 |
| 6 | cupertino/cupertino_text_selection_handle_controls_test.dart | 11 |
| 7 | cupertino/inherited_cupertino_theme_test.dart | 3 |
| 8 | cupertino/overlay_visibility_mode_test.dart | 7 |
| 27 | rendering/render_editable_painter_test.dart | 3 |
| 41 | cupertino/cupertino_secondary_test.dart | 3 |
| 42 | cupertino/cupertino_form_scroll_test.dart | 4 |
| 43 | cupertino/cupertino_controls_advanced_test.dart | 4 |
| 44 | cupertino/cupertino_sections_test.dart | 5 |
| 45 | cupertino/cupertino_tabbar_scaffold_test.dart | 9 |
| 49 | cupertino/cupertino_text_selection_controls_test.dart | 9 |
| 63 | rendering/render_editable_test.dart | 3 |

#### int.roundToDouble Missing — Interpreter Limitation (7 errors)

D4rt's `int` bridge is missing `roundToDouble()` (inherited from `num` in native Dart).

| FW# | Script |
|-----|--------|
| 23 | material/rectangular_range_slider_track_shape_test.dart |
| 24 | material/rectangular_range_slider_value_indicator_shape_test.dart |
| 56 | material/range_slider_track_shape_test.dart |
| 57 | material/range_slider_value_indicator_shape_test.dart |
| 58 | material/range_values_test.dart |
| 59 | material/spell_check_suggestions_toolbar_test.dart |
| 60 | material/tab_bar_theme_data_test.dart |

#### List.whereType Missing — Interpreter Limitation (4 errors)

D4rt's `List` bridge doesn't implement `whereType<T>()`. Called internally by Flutter framework widgets.

| FW# | Script |
|-----|--------|
| 65 | widgets/animated_cross_fade_test.dart |
| 67 | widgets/animated_switcher_test.dart |
| 68 | widgets/backdrop_filter_test.dart |
| 69 | widgets/physical_model_test.dart |

#### List\<Object?\> Type Erasure — Interpreter Limitation (3 errors, 6 individual)

D4rt infers untyped list literals as `List<Object?>` instead of `List<Widget>`.

| FW# | Script | Individual Errors |
|-----|--------|-------------------|
| 32 | widgets/nested_scroll_view_state_test.dart | 1 |
| 33 | widgets/render_nested_scroll_view_viewport_test.dart | 1 |
| 39 | widgets/nestedscrollview_test.dart | 4 |

#### _elements.contains Assertion — Interpreter Limitation (3 errors)

D4rt's BuildOwner element lifecycle tracking differs from native Flutter.

| FW# | Script |
|-----|--------|
| 36 | widgets/sliverlist_test.dart |
| 37 | widgets/table_test.dart |
| 38 | widgets/visibility_test.dart |

#### Expanded in Unbounded Container — Script Error (3 errors, 17 individual)

`Expanded` inside `SingleChildScrollView` is a known Flutter anti-pattern.

| FW# | Script | Individual Errors |
|-----|--------|-------------------|
| 40 | material/refreshindicator_test.dart | 13 |
| 47 | widgets/scroll_position_types_test.dart | 2 |
| 48 | widgets/scroll_controllers_types_test.dart | 2 |

