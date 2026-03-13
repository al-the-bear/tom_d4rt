# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-06-15
>
> **secondary_classes_test.dart:** 629 passed, 26 failed

---

## Issue Index

### Release Candidate Issues

| ID | Description | Component | Status |
|----|-------------|-----------|--------|
| [RC-1](#rc-1) | Auto-generated proxy factories not wired into dartscript registration | file_generators.dart | **FIXED** (code correct, needs regeneration) |
| [RC-2](#rc-2) | Generic constructors and relaxers not wired into dartscript registration | file_generators.dart | **FIXED** (import + calls added) |
| [RC-5](#rc-5) | Supplementary methods (@protected, @deprecated) missing from bridges | bridge_generator.dart | **NO BUG** (annotation filtering correct, needs regeneration) |
| [RC-3](#rc-3) | StrutStyle constructor override via UserBridge | strut_style_user_bridge.dart | **DONE** (UserBridge exists, needs regeneration) |

### Bridge Generator Issues

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [GEN-100](#gen-100) | Nullable type mismatch in constructor parameters | Generator | dart_ui_paint_canvas, render_layers_pipeline, advanced_decorations | **OPEN** |
| [GEN-101](#gen-101) | InterpretedInstance not recognized as native interface | Generator | data_table, render_sliver_types | **OPEN** |
| [GEN-102](#gen-102) | Method signature changes (new required parameter) | Generator | scrollphysics, shortcuts_actions | **OPEN** |
| [GEN-103](#gen-103) | Deprecated/removed classes not bridged | Config | button_types, toggle_segmented, button_styles_misc, platform_menu_widgets | **OPEN** |
| [GEN-104](#gen-104) | VoidCallback typedef not bridged | Config | observer_list | **OPEN** |

### Interpreter Issues

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [INT-100](#int-100) | Mixin property access fails on bridged instances | Interpreter | animation_misc_adv | **OPEN** |
| [INT-101](#int-101) | Instance getter access reported as "static member" error | Interpreter | dart_ui_advanced, dart_ui_image_codec, dart_ui_misc_adv, display_feature | **OPEN** |
| [INT-102](#int-102) | BitField operator expects enum `.index`, fails on int | Interpreter | buffers_misc | **OPEN** |
| [INT-103](#int-103) | SynchronousFuture.then null cast in generic return | Bridge | synchronousfuture | **OPEN** |
| [INT-104](#int-104) | ByteData.lengthInBytes not accessible | Stdlib | platform_channels | **OPEN** |
| [INT-105](#int-105) | Type literal as Map key fails type cast | Interpreter | key_events | **OPEN** |

### Test Script Issues

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [TST-100](#tst-100) | Invalid GestureDetector configuration | Test Script | gesture_callbacks | **OPEN** |
| [TST-101](#tst-101) | Restoration registration logic error | Test Script | autocomplete_chips, restoration_scope, restoration_adv | **OPEN** |
| [TST-102](#tst-102) | Wrong type passed to constructor | Test Script | render_composite | **OPEN** |

---

## Release Candidate Issues

### RC-1

**Auto-generated proxy factories not wired into dartscript registration**

**Status:** FIXED (code correct, needs regeneration)

**Problem:**
`flutter_proxies.b.dart` generates `registerProxyFactories()` with all 7 configured proxy classes, but the generated `material_bridges.b.dart` (stale from 2026-03-12) did not import or call this function.

**Root Cause:**
The code in `file_generators.dart` (L136-143 import, L207-215 call) was already correct for GEN-092 proxy registration. The generated output was simply stale.

**Resolution:**
No code change needed. A regeneration of the bridge output will produce the correct imports and calls. After regeneration, the handwritten `_registerInterfaceProxies()` in `d4rt_runtime_registrations.dart` (L62-96) still contains 3 non-auto-generated proxies (TickerProvider, StatelessWidget, StatefulWidget) that are NOT in the `proxyClasses` config — these remain handwritten intentionally.

---

### RC-2

**Generic constructors and relaxers not wired into dartscript registration**

**Status:** FIXED

**Problem:**
`flutter_relaxers.b.dart` generates both `registerGenericConstructors()` (L154838) and `registerRelaxers()` (L2378), but `file_generators.dart` never imported or called these functions. The generated master registration file (`material_bridges.b.dart`) therefore never registered generic constructors or relaxers.

**Root Cause:**
Missing import and calls in `generateDartscriptFileContent()` in `file_generators.dart`. The proxy registration (GEN-092) had been added but the equivalent relaxer/RC-2 wiring was overlooked.

**Fix Applied:**
Added to `file_generators.dart`:
- Import for relaxer output file (alongside existing proxy import)
- Calls to `registerGenericConstructors()` and `registerRelaxers()` in the dartscript init function

After regeneration, the handwritten `_registerGenericConstructors()` in `d4rt_runtime_registrations.dart` (L176-268) can be removed since the auto-generated version covers the same classes. The handwritten `generic_type_relaxers.dart` can also be removed.

---

### RC-5

**Supplementary methods (@protected, @deprecated) missing from bridges**

**Status:** NO BUG in annotation filtering (needs regeneration)

**Problem:**
Generated bridges appeared to be missing `@protected` methods (e.g., `ChangeNotifier.notifyListeners`, `ChangeNotifier.hasListeners`) and `@deprecated` methods.

**Investigation Findings:**
The annotation filtering in `bridge_generator.dart` is **already correct**:
- `_hasInternalAnnotation()` (L13453, L15510) only checks `@internal`, `@visibleForOverriding`, `@mustBeOverridden`
- `_hasInternalElementAnnotation()` (L13472) — same resolved-element checks
- `_parseMethod()` (L15096, L15759) — only filters via the above functions
- `_parseMemberFromGetterElement` (L14923), `_parseMemberFromSetterElement` (L14952), `_parseMemberFromMethodElement` (L15008) — NO annotation filtering for inherited members
- `@protected`, `@deprecated`, and `@visibleForTesting` are **NOT** filtered at member level

**Fix Applied:**
Fixed 11 misleading comments throughout `bridge_generator.dart` that incorrectly said "Skip X marked as @visibleForTesting, @protected, or @internal" — changed to accurately describe the actual behavior: "@internal, @visibleForOverriding, or @mustBeOverridden".

**Note:** The stale generated output has other issues (corrupted `foundation_bridges.b.dart`, ChangeNotifier placed in wrong module). Regeneration should resolve these.

---

### RC-3

**StrutStyle constructor override via UserBridge**

**Status:** DONE (needs regeneration)

**Problem:**
`dart:ui.StrutStyle` creates an opaque object with no getters. D4rt scripts need `painting.StrutStyle` (which has full getter support) to be created instead.

**Solution:**
`StrutStyleUserBridge` in `d4rt_user_bridges/strut_style_user_bridge.dart` is already implemented:
- Annotated with `@D4rtUserBridge('dart:ui', 'StrutStyle')`
- `overrideConstructor` method creates `painting.StrutStyle` with all named parameters
- The `UserBridgeScanner` recognizes this via the `overrideConstructor` naming convention (L538-544 in `user_bridge_scanner.dart`)
- The bridge generator checks `userBridge?.getConstructorOverride(ctorName)` at L7457 and emits the UserBridge override

After regeneration, the handwritten `StrutStyle` generic constructor in `d4rt_runtime_registrations.dart` (L231-268) can be removed (it has a TODO for this).

---

## Bridge Generator Issues

### GEN-100

**Nullable type mismatch in constructor parameters**

**Status:** OPEN

**Problem:**
When passing a non-null value to a nullable parameter (e.g., `TextStyle` to `TextStyle?`), the bridge rejects it:

```
Invalid parameter "style": expected TextStyle?, got TextStyle
```

**Affected Tests:**
- `dart_ui_paint_canvas_test.dart`
- `render_layers_pipeline_test.dart`  
- `advanced_decorations_test.dart`

**Failing Script Code:**
```dart
// dart_ui_paint_canvas_test.dart line ~60
final text = ui.Text('Hello', style: textStyle);
```

**Root Cause:**
The generated bridge parameter validator compares exact type names. When the parameter is declared as `TextStyle?`, it expects the argument's runtime type description to include the `?`, but `TextStyle` instances report as `TextStyle` (non-nullable).

**Fix Location:**
`tom_d4rt_generator/lib/src/generators/constructor_generator.dart` — The `_generateParameterValidation` method should accept non-null values for nullable parameters.

---

### GEN-101

**InterpretedInstance not recognized as native interface implementation**

**Status:** OPEN

**Problem:**
When an interpreted class extends/implements a native abstract class or interface, the bridge cannot recognize the `InterpretedInstance` as satisfying the native type:

```
Invalid parameter "source": expected DataTableSource, got InterpretedInstance(TestDataSource)
Invalid parameter "delegate": expected SliverPersistentHeaderDelegate, got InterpretedInstance(TestPersistentHeaderDelegate)
```

**Affected Tests:**
- `data_table_test.dart`
- `render_sliver_types_test.dart`

**Failing Script Code:**
```dart
// data_table_test.dart
class TestDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) => ...
  @override
  int get rowCount => 10;
  // ...
}

final table = PaginatedDataTable(
  source: TestDataSource(),  // ← Fails here
  // ...
);
```

**Root Cause:**
The bridge validates constructor parameters by checking if the passed object's type matches the expected native type. An `InterpretedInstance` wrapping a subclass of the native type is not recognized.

**Fix Location:**
1. `tom_d4rt_generator/lib/src/generators/constructor_generator.dart` — Add proxy factory registration for abstract classes that are commonly extended by user code
2. `tom_d4rt_ast/lib/src/runtime/bridge/bridged_types.dart` — Add `InterpretedInstance` unwrapping logic that creates proxies

---

### GEN-102

**Method signature changes (new required parameter)**

**Status:** OPEN

**Problem:**
Flutter API changes added required parameters to methods that previously had none. The bridge was generated from an older signature:

```
NeverScrollableScrollPhysics.shouldAcceptUserOffset expects at least 1 argument(s), got 0
DoNothingAction.consumesKey expects at least 1 argument(s), got 0
```

**Affected Tests:**
- `scrollphysics_test.dart`
- `shortcuts_actions_test.dart`

**Failing Script Code:**
```dart
// scrollphysics_test.dart
final physics = NeverScrollableScrollPhysics();
print('shouldAcceptUserOffset: ${physics.shouldAcceptUserOffset()}');  // ← Missing required parameter
```

**Root Cause:**
- `shouldAcceptUserOffset` now requires a `ScrollMetrics` parameter (added in Flutter 3.x)
- `consumesKey` now requires an `Intent` parameter

**Fix Location:**
1. Test scripts need updating to pass required parameters
2. Bridge regeneration needed for updated method signatures

---

### GEN-103

**Deprecated/removed classes not bridged**

**Status:** OPEN

**Problem:**
Several deprecated Flutter classes are referenced but not included in the bridge configuration:

```
Undefined variable: ButtonBar
Undefined variable: ButtonBarThemeData
Undefined variable: RawKeyboardListener
```

**Affected Tests:**
- `button_types_test.dart` — `ButtonBar`
- `toggle_segmented_test.dart` — `ButtonBar`
- `button_styles_misc_test.dart` — `ButtonBarThemeData`
- `platform_menu_widgets_test.dart` — `RawKeyboardListener`

**Failing Script Code:**
```dart
// button_types_test.dart
final buttonBar = ButtonBar(
  children: [ElevatedButton(...), TextButton(...)],
);
```

**Root Cause:**
`ButtonBar`, `ButtonBarThemeData`, and `RawKeyboardListener` are deprecated in recent Flutter versions and were excluded from bridge generation.

**Fix Location:**
1. **Option A:** Add deprecated classes to `buildkit.yaml` for backward compatibility
2. **Option B:** Update test scripts to use replacement APIs (`OverflowBar`, `KeyboardListener`)

---

### GEN-104

**VoidCallback typedef not bridged**

**Status:** OPEN

**Problem:**
```
Type 'VoidCallback' not found
```

**Affected Tests:**
- `observer_list_test.dart`

**Failing Script Code:**
```dart
// observer_list_test.dart
final VoidCallback callback = () {
  print('Callback executed');
};
final observers = ObserverList<VoidCallback>();
observers.add(callback);
```

**Root Cause:**
`VoidCallback` is a typedef (`typedef VoidCallback = void Function()`) that is not registered in the bridge's type system.

**Fix Location:**
1. `buildkit.yaml` — Add `VoidCallback` to type alias registrations
2. `tom_d4rt_generator/lib/src/generators/typedef_generator.dart` — Generate registration for common function typedefs

---

## Interpreter Issues

### INT-100

**Mixin property access fails on bridged instances**

**Status:** OPEN

**Problem:**
When a bridged class uses a mixin, properties defined by the mixin are not accessible:

```
Undefined property or method 'value' on bridged instance of 'AnimationWithParentMixin'
```

**Affected Tests:**
- `animation_misc_adv_test.dart`

**Failing Script Code:**
```dart
// animation_misc_adv_test.dart line 45-46
final stoppedAnim = AlwaysStoppedAnimation<double>(0.5);
print('AlwaysStoppedAnimation value: ${stoppedAnim.value}');  // ← Fails here
```

**Root Cause:**
`AlwaysStoppedAnimation` uses `AnimationWithParentMixin` which provides the `value` getter. The bridge for `AlwaysStoppedAnimation` doesn't include mixin members.

**Fix Location:**
`tom_d4rt_generator/lib/src/analyzers/class_analyzer.dart` — When analyzing a class, collect members from all mixins and generate adapters for them.

---

### INT-101

**Instance getter access reported as "static member" error**

**Status:** OPEN

**Problem:**
When accessing an instance getter that's missing from the bridge, the error incorrectly reports it as a "static member":

```
Undefined static member 'feature' on bridged class 'FontFeature'
Undefined static member 'isRecording' on bridged class 'PictureRecorder'
Undefined static member 'bounds' on bridged class 'DisplayFeature'
Undefined static member 'runtimeType' on bridged class 'SemanticsUpdateBuilder'
```

**Affected Tests:**
- `dart_ui_advanced_test.dart` — `FontFeature.feature` (instance getter)
- `dart_ui_image_codec_test.dart` — `PictureRecorder.isRecording` (instance getter)
- `dart_ui_misc_adv_test.dart` — `SemanticsUpdateBuilder.runtimeType` (Object getter)
- `display_feature_test.dart` — `DisplayFeature.bounds` (instance getter)

**Failing Script Code:**
```dart
// dart_ui_advanced_test.dart line 68
for (final f in features) {
  print('FontFeature: ${f.feature} = ${f.value}');  // ← f.feature fails
}
```

**Root Cause:**
1. The instance getters (`feature`, `isRecording`, `bounds`) are not included in the bridge
2. The error message path goes through static member lookup, producing a misleading error

**Fix Location:**
1. `tom_d4rt_generator` — Ensure instance getters are generated for these classes
2. `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` — Improve error message to distinguish static vs instance access

---

### INT-102

**BitField operator expects enum `.index`, fails on int**

**Status:** OPEN

**Problem:**
```
Native error during bridged operator '[]=' on BitField: NoSuchMethodError: Class 'int' has no instance getter 'index'.
Receiver: 0
Tried calling: index
```

**Affected Tests:**
- `buffers_misc_test.dart`

**Failing Script Code:**
```dart
// buffers_misc_test.dart line 15-17
final bits = BitField<int>(4);
bits[0] = true;  // ← Fails here - 0 has no .index
bits[2] = true;
```

**Root Cause:**
The bridge adapter for `BitField.operator[]=` was generated assuming the index parameter is always an enum (which has `.index`). However, `BitField<int>` uses plain integers.

**Fix Location:**
`tom_d4rt_generator/lib/src/generators/operator_generator.dart` — Check if the index type is an enum before calling `.index`, or handle int directly.

---

### INT-103

**SynchronousFuture.then null cast in generic return**

**Status:** OPEN

**Problem:**
```
Native error during bridged method call 'then' on SynchronousFuture: type 'Null' is not a subtype of type 'Object' in type cast
```

**Affected Tests:**
- `synchronousfuture_test.dart`

**Failing Script Code:**
```dart
// synchronousfuture_test.dart
final future = SynchronousFuture<String>('hello');
future.then((value) {
  print('Got value: $value');
});
```

**Root Cause:**
The `then` method's callback returns `FutureOr<R>` which may be null. The bridge casts the result without null-checking.

**Fix Location:**
`tom_d4rt_generator/lib/src/generators/method_generator.dart` — Handle nullable returns in generic method adapters.

---

### INT-104

**ByteData.lengthInBytes not accessible**

**Status:** OPEN

**Problem:**
```
Undefined property or method 'lengthInBytes' on _ByteDataView
```

**Affected Tests:**
- `platform_channels_test.dart`

**Failing Script Code:**
```dart
// platform_channels_test.dart
final buffer = Uint8List(100).buffer;
final data = ByteData.view(buffer);
print('lengthInBytes: ${data.lengthInBytes}');  // ← Fails
```

**Root Cause:**
`ByteData` is a `dart:typed_data` class. The `lengthInBytes` getter is not bridged in the stdlib implementation.

**Fix Location:**
`tom_d4rt_ast/lib/src/runtime/stdlib/typed_data/byte_data.dart` — Add `lengthInBytes` getter to the ByteData bridge.

---

### INT-105

**Type literal as Map key fails type cast**

**Status:** OPEN

**Problem:**
```
Native error during default bridged constructor for 'Actions': Argument Error: Invalid parameter "actions": cannot convert Map to Map<Type, Action<Intent>> - type 'InterpretedClass' is not a subtype of type 'Type' in type cast
```

**Affected Tests:**
- `key_events_test.dart`

**Failing Script Code:**
```dart
// key_events_test.dart
Actions(
  actions: <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (intent) => null,
    ),
  },
  child: ...,
)
```

**Root Cause:**
The interpreter represents class references as `InterpretedClass` objects, not Dart `Type` objects. When passing a `Map<InterpretedClass, X>` to a native API expecting `Map<Type, X>`, the cast fails.

**Fix Location:**
`tom_d4rt_ast/lib/src/runtime/bridge/bridged_types.dart` — Add special handling to convert `InterpretedClass` to its corresponding native `Type` when the target type is `Type`.

---

## Test Script Issues

### TST-100

**Invalid GestureDetector configuration**

**Status:** OPEN

**Problem:**
```
Native error during default bridged constructor for 'GestureDetector': Incorrect GestureDetector arguments.
Having both a pan gesture recognizer and a scale gesture recognizer is redundant; scale is a superset of pan.
```

**Affected Tests:**
- `gesture_callbacks_test.dart`

**Failing Script Code:**
```dart
GestureDetector(
  onPanStart: ...,
  onPanUpdate: ...,
  onScaleStart: ...,  // ← Can't have both pan and scale
  onScaleUpdate: ...,
  child: ...,
)
```

**Fix:**
Update test script to use only scale (which includes pan) or only pan, not both.

---

### TST-101

**Restoration registration logic error**

**Status:** OPEN

**Problem:**
```
'package:flutter/src/widgets/restoration_properties.dart': Failed assertion: line 85 pos 12: 'isRegistered': is not true.
```

**Affected Tests:**
- `autocomplete_chips_test.dart`
- `restoration_scope_test.dart`
- `restoration_adv_test.dart`

**Root Cause:**
The test scripts use `RestorableProperty` objects without properly registering them with a `RestorationMixin`. The `isRegistered` assertion fails because the restorable must be registered via `registerForRestoration()` before use.

**Fix:**
Update test scripts to properly register RestorableProperty instances with a RestorationScope.

---

### TST-102

**Wrong type passed to constructor**

**Status:** OPEN

**Problem:**
```
Invalid parameter "vsync": expected TickerProvider, got AlwaysStoppedAnimation<double>
```

**Affected Tests:**
- `render_composite_test.dart`

**Failing Script Code:**
```dart
// render_composite_test.dart
AnimationController(
  vsync: someAnimation,  // ← Wrong type - should be a TickerProvider
  duration: Duration(seconds: 1),
)
```

**Fix:**
Update test script to pass a proper `TickerProvider` (like `SingleTickerProviderStateMixin` state) to `AnimationController.vsync`.

---

## Summary by Category

| Category | Count | Issue IDs |
|----------|-------|-----------|
| Bridge Generator - Type Handling | 5 | GEN-100, GEN-101 |
| Bridge Generator - API Changes | 2 | GEN-102 |
| Bridge Config - Missing Types | 5 | GEN-103, GEN-104 |
| Interpreter - Property Access | 5 | INT-100, INT-101 |
| Interpreter - Type Coercion | 2 | INT-102, INT-105 |
| Interpreter - Method Handling | 1 | INT-103 |
| Stdlib - Missing Members | 1 | INT-104 |
| Test Scripts | 5 | TST-100, TST-101, TST-102 |

---

## Test File to Issue Mapping

| Test File | Error Summary | Issue ID |
|-----------|---------------|----------|
| animation_misc_adv_test.dart | Mixin property `value` not accessible | INT-100 |
| dart_ui_advanced_test.dart | Instance getter `feature` not bridged | INT-101 |
| dart_ui_paint_canvas_test.dart | `TextStyle?` vs `TextStyle` mismatch | GEN-100 |
| dart_ui_image_codec_test.dart | Instance getter `isRecording` not bridged | INT-101 |
| dart_ui_misc_adv_test.dart | Instance getter `runtimeType` not bridged | INT-101 |
| buffers_misc_test.dart | BitField operator expects enum `.index` | INT-102 |
| observer_list_test.dart | `VoidCallback` typedef not found | GEN-104 |
| synchronousfuture_test.dart | Null cast in `then()` return | INT-103 |
| gesture_callbacks_test.dart | Pan+scale conflict in GestureDetector | TST-100 |
| button_types_test.dart | Deprecated `ButtonBar` not bridged | GEN-103 |
| data_table_test.dart | InterpretedInstance not recognized as DataTableSource | GEN-101 |
| toggle_segmented_test.dart | Deprecated `ButtonBar` not bridged | GEN-103 |
| button_styles_misc_test.dart | Deprecated `ButtonBarThemeData` not bridged | GEN-103 |
| autocomplete_chips_test.dart | Restoration registration missing | TST-101 |
| advanced_decorations_test.dart | `TextStyle?` vs `TextStyle` mismatch | GEN-100 |
| render_composite_test.dart | Wrong type passed to vsync | TST-102 |
| render_sliver_types_test.dart | InterpretedInstance not recognized as delegate | GEN-101 |
| render_layers_pipeline_test.dart | `TextStyle?` vs `TextStyle` mismatch | GEN-100 |
| platform_channels_test.dart | ByteData.lengthInBytes not bridged | INT-104 |
| key_events_test.dart | InterpretedClass not coercible to Type | INT-105 |
| scrollphysics_test.dart | Method signature changed | GEN-102 |
| shortcuts_actions_test.dart | Method signature changed | GEN-102 |
| display_feature_test.dart | Instance getter `bounds` not bridged | INT-101 |
| restoration_scope_test.dart | Restoration registration missing | TST-101 |
| platform_menu_widgets_test.dart | Deprecated `RawKeyboardListener` not bridged | GEN-103 |
| restoration_adv_test.dart | Restoration registration missing | TST-101 |
