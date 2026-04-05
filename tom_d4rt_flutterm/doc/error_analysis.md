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

## Detailed Category Explanations


Each subsection below explains one category from the Test Failure Categories table: the root cause, the code pattern that triggers it, and the actual error message produced.

---

### 1. Missing Unnamed Constructor (35 failures)

**Error message:**
```
Runtime Error: Class '_ThemePreset' does not have an unnamed constructor that accepts arguments.
```

**Code that fails:**
```dart
class _ThemePreset {
  const _ThemePreset({
    required this.id,
    required this.name,
    required this.seed,
    required this.brightness,
  });
  final String id;
  final String name;
  final Color seed;
  final Brightness brightness;
}

// Usage in script:
const List<_ThemePreset> _presets = [
  _ThemePreset(id: 'ocean', name: 'Ocean', seed: Color(0xFF0284C7), brightness: Brightness.light),
];
```

**Affected test scripts:** `_ThemePreset` (17), `_ThemePack` (2), `_ThemeRecipe` (2), `_ThemeProfile` (4), `_Profile` (3), `_FaqItem`, `_ScenarioCard`, `_ButtonFamily`, `_ThemePalette`, `_PaintThemePreset`, `_ThemeModel`, `_ThemeTrack` (1 each).

**Explanation:** D4rt test scripts define private classes with `const` named-parameter constructors. The interpreter cannot resolve these constructors because the class is defined entirely in the interpreted code (not bridged) and uses advanced constructor features. When D4rt encounters `_ThemePreset(id: 'ocean', ...)`, it looks for an unnamed constructor on the class but cannot match the constructor to the call. This is because the interpreter's constructor resolution does not properly handle `const` constructors with named parameters on interpreted classes. The 35 failures include 17 different `_ThemePreset` usages across multiple test scripts, plus similar patterns in other private classes. This is the largest single category because many test scripts follow the same pattern of defining a configuration class and instantiating it with named parameters.

---

### 2. hashCode on Bridged Enum (17 failures)

**Error message:**
```
Runtime Error: Property "hashCode" not found on enum value DisplayFeatureState.unknown
```

**Code that fails:**
```dart
for (final state in DisplayFeatureState.values) {
  print('${state.name}: hashCode=${state.hashCode}');
}
```

**Affected test scripts:** `display_feature_state_test.dart`, `display_feature_type_test.dart`, `filter_quality_test.dart`, `font_weight_test.dart`, `image_byte_format_test.dart`, `paint_test.dart`, `pointer_change_test.dart`, `pointer_device_kind_test.dart`, `pointer_signal_kind_test.dart`, and other `dart_ui/` enum tests.

**Explanation:** The test scripts access `.hashCode` on bridged `dart:ui` enum values (e.g., `FilterQuality.none.hashCode`). In native Dart, `hashCode` is inherited from `Object` and available on every value including enums. However, the D4rt bridge system for enums only exposes explicitly bridged properties. Since `hashCode` is not part of the enum bridge definition — it's inherited from `Object` — the interpreter cannot find it. The fix requires the enum bridge to either explicitly include `hashCode` or the interpreter's property resolution to fall back to `Object`-level properties when looking up members on bridged enum values.

---

### 3. _TickerProviderShim Mixin (15 failures)

**Error message:**
```
Runtime Error: Type 'State' in 'on' clause of mixin '_TickerProviderShim' not found. Ensure it's defined.
```

**Code that fails:**
```dart
// Workaround: TickerProviderStateMixin is not directly usable in D4rt
mixin _TickerProviderShim<T extends StatefulWidget> on State<T> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

class _AlignTransitionDemoState extends State<_AlignTransitionDemo>
    with _TickerProviderShim<_AlignTransitionDemo> {
  late AnimationController _controller;
  // ...
}
```

**Affected test scripts:** `align_transition_test.dart`, `clip_r_superellipse_test.dart`, `default_text_style_transition_test.dart`, `fade_transition_test.dart`, `positioned_transition_test.dart`, `rotation_transition_test.dart`, `scale_transition_test.dart`, `size_transition_test.dart`, `slide_transition_test.dart`, and 6 other animation-related widget tests.

**Explanation:** The test scripts need `SingleTickerProviderStateMixin` or `TickerProviderStateMixin` to create `AnimationController` instances, but these mixins cannot be used directly in D4rt because they are bridged mixins with complex `on` clause constraints. As a workaround, the scripts define `_TickerProviderShim<T extends StatefulWidget> on State<T>`, which reimplements the ticker behavior. However, the interpreter cannot resolve `State<T>` in the mixin's `on` clause — it looks for a type named `State` in the interpreted scope but only finds the bridged `State` class, which the mixin system cannot match. This is a fundamental limitation of the interpreter's mixin resolution: it cannot recognize bridged types in mixin `on` clauses.

---

### 4. Undefined .name on Bridged Instance (12 failures)

**Error message:**
```
Runtime Error: Undefined property or method 'name' on bridged instance of 'Image'.
Runtime Error: Undefined property or method 'name' on bridged instance of 'Path'.
```

**Code that fails:**
```dart
for (final format in ImageByteFormat.values) {
  print('Format: ${format.name}');
}
```

**Affected test scripts:** `image_byte_format_test.dart`, `path_fill_type_test.dart`, `path_operation_test.dart`, `stroke_cap_test.dart`, `stroke_join_test.dart`, `clip_op_test.dart`, and other `dart_ui/` enum tests.

**Explanation:** The `.name` extension getter was added to Dart enums in Dart 2.15. It returns the string representation of an enum value (e.g., `ImageByteFormat.png.name` returns `"png"`). In the D4rt bridge system, this getter is not automatically available on bridged enum values because it's a language-level extension, not an instance member defined in the enum class. The error message says "on bridged instance of 'Image'" because the interpreter resolves `ImageByteFormat` to the bridged `Image`-related type, but the `.name` property is not in its bridge definition. The fix requires adding `.name` support at the enum bridge level, either as a synthetic property or by recognizing the Dart 2.15 enum extension in the interpreter.

---

### 5. Native Bridged Constructor Error (11 failures)

**Error message:**
```
Runtime Error: Native error during default bridged constructor for 'CatmullRomSpline':
  Failed assertion: 'controlPoints.length > 3'
Runtime Error: Native error during default bridged constructor for 'CatmullRomCurve':
  Failed assertion: validateControlPoints
Runtime Error: Native error during default bridged constructor for 'Directionality': [...]
Runtime Error: Native error during default bridged constructor for 'FocusScope': [...]
Runtime Error: Native error during default bridged constructor for 'WillPopScope': [...]
Runtime Error: Native error during default bridged constructor for 'Actions': [...]
```

**Code that fails (CatmullRomSpline pattern):**
```dart
final basicPoints = <Offset>[
  Offset(0.0, 0.0),
  Offset(0.3, 0.8),
  Offset(0.7, 0.2),
  Offset(1.0, 1.0),
];
final basicSpline = CatmullRomSpline(basicPoints);
```

**Code that fails (widget constructor pattern):**
```dart
return Directionality(
  textDirection: TextDirection.ltr,
  child: myWidget,  // InterpretedInstance passed as child
);
```

**Explanation:** This category covers errors that occur when D4rt successfully finds and invokes a bridged constructor, but the native Dart constructor throws during execution. There are two distinct sub-patterns:

1. **List type bridging (CatmullRomSpline/CatmullRomCurve — 3 failures):** The script constructs a `List<Offset>` and passes it to `CatmullRomSpline(controlPoints)`. The interpreter creates the list correctly, but the `<Offset>` generic type is lost during bridging — the native constructor receives a `List<dynamic>` or a list where the items are `InterpretedInstance` wrappers instead of native `Offset` objects, causing the assertion to fail because the list appears empty or incorrectly typed.

2. **Widget constructor arguments (8 failures):** The script passes an interpreted instance as a constructor argument (e.g., `child: myWidget`). The bridged constructor's native Dart code expects a `Widget` but receives an `InterpretedInstance`. Unlike the top-level `build()` return path (fixed by RC-3), the constructor argument extraction path does not apply interface proxy conversion. These are closely related to the InterpretedInstance category but differ in that the error originates inside the native constructor, not in the test framework.

---

### 6. Other Undefined Variable/Property (7 failures)

**Error messages:**
```
Runtime Error: Undefined property or method 'map' on _ConstSet<PointerDeviceKind>.
Runtime Error: Undefined variable: build
Runtime Error: Undefined property or method 'length' on _HashSet<LogicalKeyboardKey>.
Runtime Error: Undefined variable: ToolbarOptions
Runtime Error: Undefined property or method 'runtimeType' on () => void.
```

**Code that fails (Undefined .map):**
```dart
final devices = ScrollBehavior().dragDevices;  // returns Set<PointerDeviceKind>
final names = devices.map((d) => d.name).toList();
```

**Code that fails (Undefined build):**
```dart
Widget build(BuildContext context) {
  return Scaffold(
    body: build(context),  // recursive call — 'build' not resolved as variable
  );
}
```

**Explanation:** This is a catch-all category for various unresolved identifiers:

- **`.map` on Set (2 failures):** The interpreter bridges `Set` but does not expose the `Iterable.map()` method on `_ConstSet` (an internal Set implementation returned by some Flutter APIs). The script receives a `_ConstSet<PointerDeviceKind>` from `ScrollBehavior().dragDevices` and tries to call `.map()`, but the bridge only covers `Set` members, not inherited `Iterable` members.
- **Undefined `build` (2 failures):** A top-level `build` function is referenced inside the widget tree but the interpreter does not resolve it as a variable reference — the function name is visible in interpreted scope but the resolution fails when used in a nested context.
- **Other undefined (3 failures):** `ToolbarOptions` (deprecated class not bridged), `runtimeType` on closures (not supported on InterpretedFunction), and `length` on `_HashSet` (internal Set type missing inherited properties).

---

### 7. Return Type Mismatch (6 failures)

**Error message:**
```
Runtime Error: A value of type '_InteractiveAnnotationDemo' can't be returned from the function
  '_buildInteractiveDemo' because it has a return type of 'Widget'.
```

**Code that fails:**
```dart
Widget _buildInteractiveDemo() {
  return _InteractiveAnnotationDemo();  // extends StatefulWidget
}
```

**Affected test scripts:** `annotation_entry_test.dart`, `annotation_result_test.dart`, `cache_extent_style_test.dart`, `hit_test_behavior_test.dart`, `interactive_viewer_test.dart`, `corner_comparison_test.dart`.

**Explanation:** This is a variant of the InterpretedInstance problem. The script defines a helper function with an explicit `Widget` return type that returns an instance of an interpreted class extending `StatefulWidget`. The RC-3 fix applies interface proxy conversion in `visitInstanceCreationExpression`, which converts the interpreted instance to a native proxy. However, the interpreter's return-type check occurs _before_ the proxy conversion in certain code paths — specifically in helper functions (not the top-level `build()`). The interpreter sees that `_InteractiveAnnotationDemo` (an `InterpretedClass`) is not literally `Widget` and rejects the return. The fix for this would require the return-type checker to recognize interface proxies or perform the type check after proxy conversion.

---

### 8. InterpretedFunction Type Mismatch (5 failures)

**Error message:**
```
Runtime Error: Native error during bridged method call 'reduce' on Iterable:
  type 'NativeFunction' is not a subtype of type 'InterpretedFunction' in type cast
```

**Code that fails:**
```dart
import 'dart:math' as math;

final maxElastic = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
    .map((t) => elasticOutTween.transform(t))
    .reduce(math.max);   // <-- math.max is a NativeFunction
```

**Affected test scripts:** `curve_tween_test.dart`, `elastic_in_out_curve_test.dart`, `elastic_out_curve_test.dart`, `flipped_curve_test.dart`, `sawtooth_test.dart`.

**Explanation:** The script calls `.reduce(math.max)` on an `Iterable<double>`. In native Dart, `math.max` is a top-level function `int max(int a, int b)` / `double max(num a, num b)` that can be passed as a function reference. When the interpreter encounters `math.max`, it resolves it as a `NativeFunction` (a reference to a natively-implemented function). The bridge for `Iterable.reduce()` expects its callback parameter to be an `InterpretedFunction` (a D4rt-interpreted closure) and fails with a type cast error when it receives a `NativeFunction`.

The fix requires the `reduce` bridge (and similar higher-order-function bridges) to accept both `InterpretedFunction` and `NativeFunction` as callbacks, wrapping `NativeFunction` in a compatible adapter before invoking it.

---

### 9. Null Check on SPostfixExpression (5 failures)

**Error messages:**
```
Runtime Error: Null check operator used on a null value at Instance of 'SPostfixExpression'
Runtime Error: Error in generic constructor factory for 'ReverseTween': Null check operator used on a null value
```

**Code that fails (enum postfix):**
```dart
final allModes = CollapseMode.values;  // .values is a postfix on enum type
for (final mode in allModes) {
  print('${mode.toString()}');
}
```

**Code that fails (generic constructor):**
```dart
final reversedDouble = ReverseTween<double>(doubleTween);
```

**Affected test scripts:** `reverse_tween_test.dart`, `collapse_mode_test.dart`, `floating_label_behavior_test.dart`, `clip_behavior_test.dart`.

**Explanation:** The `SPostfixExpression` is an AST node representing a postfix operation (e.g., `.values` on an enum type, `.entries` on a map, or the `!` null assertion operator). The null check error occurs when the interpreter tries to resolve the target of a postfix expression but fails:

1. **Enum `.values` (3 failures):** The interpreter encounters `CollapseMode.values` and creates an `SPostfixExpression` node. When evaluating the `.values` property access, the interpreter looks up the `values` getter on the bridged enum type, but the property resolution returns `null` because `values` is a static member, not an instance member. The null check (`!`) on the lookup result then throws.

2. **Generic constructor factory (2 failures):** `ReverseTween<double>(...)` triggers the generic constructor factory, which internally uses postfix expression evaluation. The `<double>` type argument resolution hits a null check because the factory cannot find the concrete type for the generic parameter.

---

### 10. _SUnknownNode for-loop (5 failures)

**Error message:**
```
type '_SUnknownNode' is not a subtype of type 'SForLoopParts?' in type cast
  at AstConverter._as
  at AstConverter._convertForStatement
```

**Code that fails:**
```dart
for (final (i, point) in points.indexed) {
  canvas.drawCircle(point, 4.0, pointPaint);
  // ...
}
```

**Affected test scripts:** `point_mode_test.dart`, `child_layout_helper_test.dart`, `mouse_cursor_manager_test.dart`, `hit_sliver_test.dart`, `text_composition_test.dart`.

**Explanation:** The test scripts use Dart 3's record destructuring in for-loops: `for (final (x, y) in pairs)`. The `AstConverter` in `tom_ast_generator` does not recognize the destructuring pattern `(i, point)` as a valid `SForLoopParts` node. Instead, it produces an `_SUnknownNode` — a placeholder for unrecognized AST constructs. When the interpreter then tries to evaluate the for-loop, it casts the loop parts to `SForLoopParts?` and fails because `_SUnknownNode` is not a subtype.

This is an AST converter limitation, not an interpreter limitation. The fix requires adding pattern variable declaration support to `AstConverter._convertForStatement()` in `tom_ast_generator`, which would handle the `DartPatternVariableDeclaration` AST node and convert it to a proper `SForLoopParts` representation.

---

### 11. WidgetState Resolution (5 failures)

**Error messages:**
```
Runtime Error: Error during bridged constructor 'resolveWith' for class 'WidgetStateColor':
  Undefined property or method 'contains' on _ConstSet<WidgetState>.
Runtime Error: Undefined enum value 'any' on bridged enum 'WidgetState'.
Runtime Error: Error in generic constructor factory for 'WidgetStatePropertyAll':
  type 'Null' is not a subtype of type 'Color' in type cast
```

**Code that fails:**
```dart
final stateColor = WidgetStateColor.resolveWith((states) {
  if (states.contains(WidgetState.disabled)) {
    return Colors.grey;
  }
  if (states.contains(WidgetState.pressed)) {
    return Colors.red;
  }
  return Colors.green;
});
```

**Affected test scripts:** `widget_state_color_test.dart`, `widget_state_mapper_test.dart`, `widget_state_property_all_test.dart`, `widget_state_mouse_cursor_test.dart`, `widget_state_text_style_test.dart`.

**Explanation:** `WidgetState` (formerly `MaterialState`) is a relatively new Flutter API with several interacting bridging gaps:

1. **`.contains` on Set (2 failures):** The `states` parameter in the `resolveWith` callback is a `Set<WidgetState>`. The interpreter correctly passes the set, but the bridged `Set` implementation (`_ConstSet`) does not expose the `contains()` method, causing a resolution failure.

2. **Enum value `.any` (1 failure):** `WidgetState.any` is a special static member that returns a `WidgetStatesConstraint`, not a regular enum value. The interpreter treats it as an enum lookup and fails when `any` is not found among the enum constants.

3. **Generic factory type resolution (2 failures):** `WidgetStatePropertyAll<Color>(Colors.green)` goes through the generic constructor factory, which cannot properly resolve the `<Color>` type parameter during construction, resulting in a null cast error.

---

### 12. toString on Bridged Enum (4 failures)

**Error message:**
```
Runtime Error: Undefined property or method 'toString' on MainAxisAlignment.
Runtime Error: Undefined property or method 'toString' on StrokeCap.
Runtime Error: Undefined property or method 'toString' on Clip.
```

**Code that fails:**
```dart
for (final alignment in MainAxisAlignment.values) {
  print('Alignment: ${alignment.toString()}');
}
```

**Affected test scripts:** `painting_style_test.dart`, `button_bar_theme_data_test.dart`, `clip_context_test.dart`, `tab_bar_indicator_animation_test.dart`.

**Explanation:** Similar to the `hashCode` issue (#2). When `toString()` is called on a bridged enum value, the interpreter looks for `toString` in the enum's bridge definition. Since `toString()` is inherited from `Object` and not explicitly bridged on enum types, the lookup fails. In native Dart, `toString()` on an enum returns the full name (e.g., `"MainAxisAlignment.center"`). The interpreter's property resolution chain does not fall back to `Object`-level methods for bridged enum values.

The fix is the same as for `hashCode`: either add `toString` to the enum bridge definition or make the interpreter's lmethod resolution fall back to `Object`-level methods for all bridged types.

---

### 13. Object Not Callable (4 failures)

**Error message:**
```
Runtime Error: 'Object' is not callable (no default constructor bridge found).
```

**Code that fails:**
```dart
final testObj = Object();

final event = ObjectCreated(
  library: 'package:test/test.dart',
  className: 'MyClass',
  object: testObj,
);
```

**Affected test scripts:** `object_created_test.dart`, `object_disposed_test.dart`, `object_event_test.dart`, `object_flag_test.dart`.

**Explanation:** The script calls `Object()` to create a plain Dart object. In native Dart, `Object` has a default constructor that returns a new `Object` instance. However, D4rt does not bridge the `Object()` constructor — `Object` is treated as a type only, not as a constructible class. When the interpreter encounters `Object()`, it searches for a constructor bridge for `Object` and finds none, producing the "is not callable" error.

The fix requires adding a bridge for the `Object()` default constructor. Since `Object` is the root of Dart's class hierarchy and its constructor is trivial, this should be straightforward.

---

### 14. InterpretedInstance Not Converted (4 failures)

**Error message:**
```
Expected Widget but got InterpretedInstance
```

**Code that fails:**
```dart
dynamic build(BuildContext context) {
  return _BottomNavigationBarTypeDemo();  // extends StatefulWidget
}
```

**Affected test scripts:** `bottom_navigation_bar_type_test.dart`, `over_scroll_header_stretch_configuration_test.dart`, `scaffold_messenger_test.dart`, `actions_test.dart`.

**Explanation:** These are the 4 remaining InterpretedInstance errors after the RC-3 fix eliminated 101 others. The RC-3 fix applies `D4.tryCreateInterfaceProxyWithVisitor()` at instance creation time to convert `InterpretedInstance` to a native Widget proxy. However, these 4 cases fail for one of two reasons:

1. **Passed as constructor argument:** The interpreted instance is passed as an argument to a bridged widget constructor (e.g., `child: myInterpretedWidget`). The argument extraction path does not apply proxy conversion, so the bridged constructor receives an `InterpretedInstance` instead of a `Widget`.

2. **Proxy creation fails:** `tryCreateInterfaceProxyWithVisitor()` returns `null` for these specific classes because the interface proxy system cannot find a matching proxy for the superclass hierarchy. This can happen when the class has multiple levels of interpreted inheritance or when the `State.createState()` method cannot be properly proxied.

---

### 15. flutter_test Import Unresolved (3 failures)

**Error message:**
```
Bad state: Cannot resolve import "package:flutter_test/flutter_test.dart" from main.dart:
  Package import "package:flutter_test/flutter_test.dart" is not bridged and not in the same package.
  Either add it to bridgedLibraries or provide it via explicitSources.
```

**Code that fails:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';  // <-- not bridged

Widget buildSectionHeader(String title, {IconData? icon}) {
  // ...
}
```

**Affected test scripts:** `list_tile_style_test.dart`, `class_test.dart`, `diagnostics_debug_creator_test.dart`.

**Explanation:** A few test scripts import `package:flutter_test/flutter_test.dart`, which is the Flutter testing framework (provides `testWidgets`, `expect`, `find`, etc.). The D4rt bundler resolves imports by looking for them in the bridged libraries list or in explicitly provided sources. Since `flutter_test` is neither bridged nor part of the Flutter bridged libraries set, the bundler fails during the import resolution phase — before the script even starts executing.

These scripts were generated with the import by mistake. The test framework is provided by the test harness, not by the script itself. Removing the unnecessary `import 'package:flutter_test/...'` line from these scripts would fix them without any interpreter changes.

---

### 16. Timeout (3 failures)

**Error messages:**
```
TimeoutException after 0:00:30.000000: Test timed out after 30 seconds.
Build timed out after 10 seconds
```

**Code context:**
```dart
// scrollbar_theme_data_test.dart — complex theme with many nested widgets
// search_controller_test.dart — SearchController with debounced callbacks
```

**Affected test scripts:** `scrollbar_theme_data_test.dart`, `search_controller_test.dart` (2 failures — one dart test timeout, one build timeout).

**Explanation:** These tests exceed their time limits. There are two timeout mechanisms:

1. **Dart test timeout (30s):** The test framework's global timeout. Two tests (`scrollbar_theme_data_test.dart`, `search_controller_test.dart`) exceed this because the D4rt interpreter takes significantly longer to execute complex widget trees compared to native Dart. The interpreter must resolve every method call, property access, and constructor invocation through the bridge system, multiplying execution time.

2. **Build timeout (10s):** The test harness imposes a 10-second timeout on the D4rt `build()` function. `search_controller_test.dart` hits this in a second attempt after already timing out at 30 seconds — the test timed out waiting for the initial execution, then when retried with a build-specific timeout, it fails again.

These are not interpreter bugs but performance limitations. The scripts are large and exercise complex widget trees. Solutions include increasing timeouts for known-slow tests or optimizing the interpreter's hot path for widget construction.

---

### 17. CatmullRomSpline Assertion (3 failures)

**Error message:**
```
Runtime Error: Native error during default bridged constructor for 'CatmullRomSpline':
  Failed assertion: 'controlPoints.length > 3':
  There must be at least four control points to create a CatmullRomSpline.
```

**Code that fails:**
```dart
final basicPoints = <Offset>[
  Offset(0.0, 0.0),
  Offset(0.3, 0.8),
  Offset(0.7, 0.2),
  Offset(1.0, 1.0),
];
final basicSpline = CatmullRomSpline(basicPoints);  // 4 points, should satisfy > 3
```

**Affected test scripts:** `catmull_rom_spline_test.dart`, `curve2_d_sample_test.dart`, `curve2_d_test.dart`.

**Explanation:** The script creates a `List<Offset>` with 4 elements and passes it to `CatmullRomSpline()`. In native Dart, 4 control points satisfy the `> 3` assertion. However, the assertion still fires because of how D4rt bridges the `List<Offset>` to the native constructor:

The interpreter creates a `BridgedList` containing 4 `Offset` objects. When this list is passed to the native `CatmullRomSpline()` constructor, the bridge extracts the list values but may not preserve the generic type `<Offset>`. The native constructor receives a list where the elements are `BridgedInstance<Offset>` wrappers instead of raw `Offset` objects. Alternatively, the list may be passed as a `List<dynamic>` and the native `CatmullRomSpline` constructor's validation function — which iterates the list and checks each element — fails because the wrappers aren't recognized as `Offset` instances.

This is a specific case of the general "bridged collection type erasure" problem: when a `List<BridgedType>` is passed to a native constructor, the generic type and element unwrapping are not handled consistently.

---

### 18. ByteData / Platform Channel (3 failures)

**Error messages:**
```
Runtime Error: Undefined property or method 'lengthInBytes' on _ByteDataView.
Runtime Error: Cannot access property 'lengthInBytes' on target of type _ByteDataView.
Runtime Error: Undefined variable: ByteData
```

**Code that fails:**
```dart
final standardCodec = StandardMessageCodec();
final stringBytes = standardCodec.encodeMessage('Hello World');
print('String encoded: ${stringBytes?.lengthInBytes} bytes');  // <-- fails
```

**Affected test scripts:** `message_codec_test.dart`, `method_codec_test.dart`, `codecs_test.dart`.

**Explanation:** The `StandardMessageCodec.encodeMessage()` method returns a `ByteData?`. In native Dart, `ByteData` provides properties like `lengthInBytes`, `buffer`, etc. The D4rt interpreter encounters three different failure modes:

1. **Property not found on internal type (2 failures):** The `encodeMessage()` bridge returns a `_ByteDataView` (an internal `dart:typed_data` type). The interpreter resolves `lengthInBytes` on `_ByteDataView` but the bridge only covers `ByteData`, not its internal implementations.

2. **Type not bridged (1 failure):** `ByteData` is referenced as a type (e.g., `ByteData.sublistView(...)`) but is not available as a bridged class in the interpreter scope, causing an "Undefined variable: ByteData" error.

---

### 19. Unsupported Operation (2 failures)

**Error messages:**
```
Runtime Error: Unsupported target for indexing: null
Unsupported operation: SystemColor not supported on the current platform.
```

**Code that fails (indexing null):**
```dart
Map<String, dynamic> _colorSpaceInfo(ui.ColorSpace cs) {
  switch (cs) {
    case ui.ColorSpace.sRGB: return {'color': Color(0xFFFF0000), ...};
    case ui.ColorSpace.displayP3: return {'color': Color(0xFF00FF00), ...};
    // ...
  }
}

final info = _colorSpaceInfo(cs);
final color = info['color'] as Color;  // info is null — switch didn't match
```

**Code that fails (SystemColor):**
```dart
print('System accent: ${SystemColor.accent}');
```

**Affected test scripts:** `color_space_test.dart`, `system_color_palette_test.dart`.

**Explanation:** Two distinct issues:

1. **Indexing null (1 failure):** The `switch (cs)` on a `dart:ui` enum fails to match any case because the interpreter cannot compare bridged enum values in switch-case patterns. The function returns `null` (implicit return for non-matching switch), and the caller then tries `info['color']` on `null`, producing "Unsupported target for indexing: null".

2. **SystemColor (1 failure):** `SystemColor` is a platform-specific API that is not available on Linux. This is a platform limitation, not an interpreter issue. The test runs on a Linux headless environment where system accent colors are not defined.

---

### 20. Failed Assertion / Native (2 failures)

**Error message:**
```
'package:flutter/src/widgets/restoration_properties.dart': Failed assertion:
  line 85 pos 12: 'isRegistered': is not true.
```

**Code that fails:**
```dart
dynamic build(BuildContext context) {
  final restorableBoolN = RestorableBoolN(null);
  restorableBoolN.value = true;
  print('After setting true: ${restorableBoolN.value}');
  // ...
}
```

**Affected test scripts:** `restorable_bool_n_test.dart`, `restorable_bool_test.dart`.

**Explanation:** `RestorableBoolN` is a Flutter restoration property that requires registration with a `RestorationMixin` before its `value` can be accessed or set. In native Flutter, this registration happens automatically through the widget tree's restoration framework. In the D4rt test context, the script creates `RestorableBoolN(null)` directly inside `build()` without going through the full restoration lifecycle (no `RestorationMixin`, no `registerForRestoration()`). When the script then calls `restorableBoolN.value = true`, the Flutter framework's own assertion fires: `isRegistered` is `false` because the property was never registered.

This is a test script issue, not an interpreter issue. The scripts need to either register the restorable property properly with a `RestorationMixin` or test the class through the full widget lifecycle.

---

### 21. Other Single-Occurrence Errors (2 failures)

These are unique errors that don't form a pattern:

**21a. Script not found:**
```
Bad state: Script not found: .../painting/asset_bundle_image_provider_test.dart
```
The test script file does not exist at the expected path. The test list references it but the file was not generated. Fix: add the missing script or remove the test entry.

**21b. Null method invocation:**
```
Runtime Error: Cannot invoke method 'withAlpha' on null. Use '?.' for null-aware method invocation.
```
A color value resolves to `null` and `.withAlpha(...)` is called on it without null-aware syntax. The script code uses `color.withAlpha(128)` where `color` was supposed to be resolved from a theme or configuration but returned `null` due to an upstream resolution failure. This is likely a cascading error — an earlier failure (e.g., theme not resolved) causes `null` to propagate to a `.withAlpha()` call.
