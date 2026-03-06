# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-03-06
>
> Generator test suite: **618 passed, 0 skipped, 0 failed**
> Flutterm integration: **1953 passed, 42 failed** (essential: 108/0, important: 160/2, hardly_relevant: 1059/4, secondary: 620/36)

---

## Issue Index

### Generator Issues

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [GEN-085](#gen-085) | Theme/function typedef alias registration | Generator | appbar_themes, component_themes, dialog_themes, input_themes + VoidCallback | **OPEN** |
| [GEN-086](#gen-086) | Setter adapter BridgedInstance unwrapping | Generator | picture, canvas | **OPEN** |
| [GEN-087](#gen-087) | Non-wrappable constructor parameter defaults | Generator | asset, NetworkImage | **OPEN** |
| [GEN-088](#gen-088) | Missing Cupertino widget bridges | Generator | menu_widgets, pulldown | **OPEN** |
| [GEN-089](#gen-089) | NoDefaultCupertinoThemeData constructor | Generator | cupertino_themes_batch4 | **OPEN** |
| [GEN-090](#gen-090) | GravitySimulation endDistance assertion | Generator | simulations | **OPEN** |
| [GEN-091](#gen-091) | AlwaysStoppedAnimation generic type | Generator | rotationtransition (workaround) | **OPEN** |
| [GEN-092](#gen-092) | Interface proxy factory registration | Generator | DataTableSource, FlowDelegate, SliverPersistentHeaderDelegate, MultiChildLayoutDelegate | **NEW** |
| [GEN-093](#gen-093) | Inherited members from generic superclasses | Generator | RestorableInt, RestorableNum, TextEditingController, TransformationController, ByteData | **NEW** |
| [GEN-094](#gen-094) | Flutter API method signature changes | Generator | shouldAcceptUserOffset | **NEW** |

### Engine Issues (Interpreter Limitations)

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [ENG-001](#eng-001) | Collection literal generic type inference | Interpreter | segmentedbutton, widgetstate, misc_themes | **OPEN** |
| [ENG-002](#eng-002) | Type literals as map key expressions | Interpreter | actions | **OPEN** |
| [ENG-003](#eng-003) | Typed callback setter assignment | Interpreter | recognizers | **OPEN** |
| [ENG-004](#eng-004) | Float64List type unavailable | Interpreter | filters (workaround) | **OPEN** |
| [ENG-005](#eng-005) | ByteData.lengthInBytes not bridged | Interpreter | codecs (workaround) | **OPEN** |
| [ENG-006](#eng-006) | runtimeType on InterpretedFunction/NativeFunction | Interpreter | 5 failures across test suites | **NEW** |
| [ENG-007](#eng-007) | Nullable type extraction mismatch | Interpreter/Bridge | TextStyle? vs TextStyle, 3 failures | **NEW** |
| [ENG-008](#eng-008) | Unexported/deprecated type variable references | Bridge Config | ButtonBar, RawKeyboardListener, unexported enums | **NEW** |
| [ENG-009](#eng-009) | Enum coercion for bitfield operator parameters | Interpreter | BitField operator `[]=` | **NEW** |

### Test Impact Matrix

| Test Script | Skip/Failure Reason | Issue IDs |
|-------------|---------------------|-----------|
| segmentedbutton_test | Set/collection type inference | ENG-001 |
| widgetstate_test | Set/collection type inference | ENG-001 |
| misc_themes_test | Map generic type inference | ENG-001 |
| actions_test | Type as Map key | ENG-002 |
| recognizers_test | Typed callback setter | ENG-003 |
| appbar_themes_test | Theme typedef alias | GEN-085 |
| component_themes_test | Theme typedef alias | GEN-085 |
| dialog_themes_test | Theme typedef alias | GEN-085 |
| input_themes_test | Theme typedef alias | GEN-085 |
| menu_widgets_test | Missing Cupertino bridge | GEN-088 |
| pulldown_test | Missing Cupertino bridge | GEN-088 |
| cupertino_themes_batch4_test | Constructor type mismatch | GEN-089 |
| picture_test | Setter unwrap | GEN-086 |
| canvas_test | Setter unwrap | GEN-086 |
| simulations_test | Assertion failure | GEN-090 |
| asset_test | Non-wrappable default | GEN-087 |
| rotationtransition_test | Workaround applied (sections removed) | GEN-091 |
| filters_test | Workaround applied (Float64List removed) | ENG-004 |
| codecs_test | Workaround applied (ByteData replaced) | ENG-005 |
| important_classes_test | InterpretedFunction callback type mismatch (1), non-wrappable default (1) | ENG-003, GEN-087 |
| hardly_relevant_classes_test | Undefined variables for unexported enums (4) | ENG-008 |
| secondary_classes_test | Proxy factory not registered (7), nullable type mismatch (3), runtimeType on functions (5), undefined variables (6), inherited members not bridged (5), collection type mismatch (2), method signature change (1), enum coercion (1), VoidCallback not found (1), other (5) | GEN-092, ENG-007, ENG-006, ENG-008, GEN-093, ENG-001, GEN-094, ENG-009, GEN-085 |

---

## Open Issues — Engine (Interpreter Limitations)

### ENG-001

**Collection literal generic type inference**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

D4rt collection literals produce untyped collections that fail when passed to Flutter APIs expecting typed generics:

- `{'day'}` → `LinkedHashSet<dynamic>` instead of `Set<String>` — fails `SegmentedButton(selected:)` which requires `Set<String>`
- `{WidgetState.hovered}` → `LinkedHashSet<dynamic>` instead of `Set<WidgetState>` — fails `resolve()` which requires `Set<WidgetState>`
- `{}` → always `Map<dynamic, dynamic>` (never `Set<T>`) — empty `{}` cannot produce an empty Set
- `{TargetPlatform.android: zoomBuilder}` → `Map<Object?, Object?>` instead of `Map<TargetPlatform, PageTransitionsBuilder>`

**Affected tests:** `segmentedbutton_test.dart`, `widgetstate_test.dart`, `misc_themes_test.dart`

**b) Root Cause:**

The interpreter's `visitSetOrMapLiteral` (`interpreter_visitor.dart` L7928) correctly distinguishes Set from Map by checking element types (non-`MapLiteralEntry` elements → Set, `MapLiteralEntry` → Map). However:

1. **Non-empty Set literals `{value}` ARE correctly identified as Sets** — the elements are inspected and since they're not `MapLiteralEntry`, a `LinkedHashSet()` is created. **The parsing itself works.**
2. **The problem is generic types** — the Set/Map is created with `<dynamic>` generics because D4rt has no static type system to infer `<String>`, `<WidgetState>`, etc. from context.
3. **Empty `{}` always defaults to Map** (L7975) — this follows Dart spec where `{}` without type annotation is a Map. Native Dart uses static analysis to determine if `{}` should be a Set based on the expected type from context (e.g., parameter type), but D4rt cannot do this.

**c) Proposed Solution:**

Two complementary fixes:

**Fix 1 — Bridge-side collection casting (do first):**

Modify bridge argument extraction to cast collections to the expected generic type. When the bridge knows it needs a `Set<String>`, it can do `(arg as Set).cast<String>()`. This could be added to `D4.extractBridgedArg` or as a new `D4.extractTypedCollection` helper.

```dart
// In bridge argument extraction:
Set<T> extractTypedSet<T>(dynamic arg) {
  if (arg is Set) return arg.cast<T>();
  throw ArgumentError('Expected Set, got ${arg.runtimeType}');
}
```

**Fix 2 — Interpreter type annotation support (do as well):**

Support explicit type annotations on collection literals: `<String>{'day'}`, `<WidgetState>{}`, `<TargetPlatform, PageTransitionsBuilder>{...}`. This is a substantial interpreter enhancement but the most correct solution — it makes D4rt scripts behave like native Dart for typed collections.

**d) Implementation Scope:**

| Fix | Effort | Impact | Recommendation |
|-----|--------|--------|----------------|
| Bridge-side casting | Low | Fixes all tests using bridges | **Do first** |
| Type annotation support | High | Fixes all collection typing globally | **Do as well** |

**Why needed:** `WidgetStateProperty.resolve()`, `SegmentedButton(selected:)`, and `PageTransitionsTheme(builders:)` are fundamental Flutter APIs. Without typed collections, D4rt scripts cannot use state-dependent properties, segmented buttons, or configure page transitions.

---

### ENG-002

**Type literals cannot be used as map key expressions**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

D4rt scripts cannot use bare class names as `Type` values in map literals. The `Actions` widget requires `Map<Type, Action<Intent>>` where class names like `ActivateIntent` serve as type keys:

```dart
// This Dart code fails in D4rt:
Actions(
  actions: {
    ActivateIntent: CallbackAction<ActivateIntent>(...),  // ← ActivateIntent as Type key
    DismissIntent: CallbackAction<DismissIntent>(...),
  },
  child: ...
);
```

D4rt interprets `ActivateIntent` as a constructor call rather than a `Type` reference.

**Affected tests:** `actions_test.dart`

**b) Root Cause:**

The D4rt interpreter resolves identifiers through scope lookup. When it encounters `ActivateIntent` in a map key position, it tries to resolve it as a variable or constructor invocation. There is no mechanism to evaluate a class name to its `Type` object (equivalent to Dart's `ActivateIntent` expression that evaluates to `Type`).

**c) Proposed Solution:**

**Interpreter `Type` expression support via BridgedClass.getType():**

Extend the `BridgedClass` API to include a `Type getType()` method that returns the native Dart `Type` object. The generated bridges implement this method. Then in the interpreter, when an identifier appears in an expression context (not a call), resolve it to its `Type` object via the registered bridge class's `getType()`.

This is simpler than it looks — the bridge already knows its native type. The interpreter just needs a resolution path:

1. Add `Type getType()` to `BridgedClass` API
2. Implement in all generated bridges: `Type getType() => MyClass;`
3. In interpreter identifier resolution, when in expression context (not invocation), check if identifier maps to a registered bridge class and call `getType()`
4. The returned `Type` object works as a native Dart map key

```dart
// In generated bridge:
class MyClassBridge extends BridgedClass {
  @override
  Type getType() => MyClass;
  // ... existing bridge code
}
```

```dart
// In interpreter (expression context, not call):
final bridgeClass = environment.lookupBridgeClass(identifier);
if (bridgeClass != null) return bridgeClass.getType();
```

**d) Implementation Scope:**

| Step | Effort | Component |
|------|--------|-----------|
| Add `getType()` to BridgedClass | Low | tom_d4rt_ast |
| Generate `getType()` in bridges | Low | tom_d4rt_generator |
| Interpreter expression resolution | Medium | tom_d4rt interpreter |

**Why needed:** The `Actions` / `Shortcuts` system is how Flutter applications handle keyboard shortcuts and accessibility actions. Without `Type`-keyed maps, D4rt scripts cannot define action dispatchers.

---

### ENG-003

**InterpretedFunction not assignable to typed callback setters**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

D4rt callback functions (`InterpretedFunction`) cannot be assigned to typed setter properties like `onStart`, `onUpdate`, `onEnd` on gesture recognizers:

```dart
final hDrag = HorizontalDragGestureRecognizer();
hDrag.onStart = (DragStartDetails details) {  // ← Fails
  print('  hDrag.onStart: ${details.globalPosition}');
};
```

The setter `onStart` expects `void Function(DragStartDetails)?` but receives `InterpretedFunction` which doesn't implement that specific function type.

**Affected tests:** `recognizers_test.dart`

**b) Root Cause:**

D4rt wraps all user-defined functions as `InterpretedFunction` objects. These implement `Function` but not specific typed function signatures like `void Function(DragStartDetails)`. When the bridge setter adapter tries to assign the value directly to the native property, Dart's type system rejects it because `InterpretedFunction` is not a `void Function(DragStartDetails)`.

This is different from constructor callback parameters where the bridge can wrap the `InterpretedFunction` in a native closure at code-generation time. Setters currently pass values through without wrapping.

**c) Proposed Solution:**

**Generator setter callback wrapping:**

When the generator detects a setter whose type is a `Function` type (callback), emit a wrapper that converts `InterpretedFunction` to the expected native callback. This extends the existing callback wrapping logic already used for constructor parameters to also cover setters:

```dart
// Generated setter adapter:
if (setterName == 'onStart') {
  final fn = value as InterpretedFunction;
  instance.onStart = (DragStartDetails details) {
    return fn.call([D4.wrapBridged(details)]);
  };
  return;
}
```

The generator already knows the setter's parameter type from analysis, so it can detect `Function` types and emit the appropriate wrapping lambda.

**d) Implementation Scope:**

Moderate change in the generator's setter emission code. The pattern already exists for constructor callback parameters — it needs to be applied to setter adapters as well. Specifically:

1. During setter analysis, detect if the setter type is a `Function` type
2. If so, emit a setter adapter that wraps `InterpretedFunction` in a native closure
3. The closure bridges arguments using `D4.wrapBridged()` for each parameter

**Why needed:** Direct gesture recognizer configuration is common in custom gesture handling code. Without setter callbacks, D4rt scripts cannot configure drag, tap, scale, or other recognizers.

---

### ENG-004

**Float64List type unavailable in D4rt runtime**

**Status:** OPEN (2026-03-08) — Workaround applied in test script

**a) Problem:**

`Float64List` from `dart:typed_data` is not available in the D4rt interpreter environment. Test scripts that use `Float64List.fromList([...])` for ImageFilter kernel data fail.

**Affected tests:** `filters_test.dart` (workaround: replaced Float64List usage with alternative)

**b) Root Cause:**

The D4rt interpreter does not bridge `dart:typed_data` classes. `Float64List`, `Int32List`, etc. are not registered as bridge types.

**c) Proposed Solution:**

- **Bridge approach:** Add full support for `dart:typed_data` bridges in the interpreter, including all typed list classes (`Float64List`, `Int32List`, `Uint8List` etc.)


**d) Why needed:** Low priority — most Flutter APIs accept regular `List<double>`. Only needed for APIs with explicit typed_data requirements.

---

### ENG-005

**ByteData.lengthInBytes property not bridged**

**Status:** OPEN (2026-03-08) — Workaround applied in test script

**a) Problem:**

`ByteData.lengthInBytes` getter is not available through the bridge. Code that checks `byteData.lengthInBytes` fails.

**Affected tests:** `codecs_test.dart` (workaround: replaced with null check)

**b) Root Cause:**

`ByteData` is a `dart:typed_data` class. Its properties are not fully bridged in the D4rt runtime.

**c) Proposed Solution:**

Same as ENG-004 — bridge `dart:typed_data` types

**d) Why needed:** Low priority — only needed for raw byte data manipulation in codec/image processing scripts.

---

### ENG-006

**runtimeType property on InterpretedFunction / NativeFunction**

**Status:** NEW (2026-03-06) — Identified during flutterm secondary_classes integration testing

**a) Problem:**

D4rt scripts that access `.runtimeType` on function values fail with:

```
Cannot access property 'runtimeType' on target of type InterpretedFunction
Cannot access property 'runtimeType' on target of type NativeFunction
```

This occurs in test scripts that check callback types or log function metadata. `runtimeType` is a property of `Object` and should be accessible on all values, including functions.

**Affected tests:** 5 failures across secondary_classes_test.dart

**b) Root Cause:**

`InterpretedFunction` and `NativeFunction` are D4rt's internal representations of user-defined and native callback functions. While they implement `Function`, the interpreter's property resolution for these types does not include `Object` members like `runtimeType`, `hashCode`, or `toString`. The interpreter special-cases function types in its property access logic, and the `Object` member fallback path is not reached for functions.

**c) Proposed Solution:**

**Approach 1 — Add Object member fallback for function types (recommended):**

In the interpreter's property access handler (`visitPrefixedIdentifier` or `visitPropertyAccess`), when the target is an `InterpretedFunction` or `NativeFunction`, check for `Object` member names before throwing:

```dart
if (target is InterpretedFunction || target is NativeFunction) {
  switch (propertyName) {
    case 'runtimeType': return target.runtimeType;
    case 'hashCode': return target.hashCode;
    case 'toString': return () => target.toString();
  }
}
```

**Approach 2 — Make function types extend a bridged base:**

Register `Function` as a bridged type with standard `Object` member accessors. This is more involved but handles all Object members uniformly.

**d) Implementation Scope:**

Small change in the interpreter's property resolution for function types. Approach 1 is a 10-line fix.

**Why needed:** `runtimeType` access is common in debug output, type checking, and logging patterns. Without this, any D4rt script that inspects function metadata will fail.

---

### ENG-007

**Nullable type extraction mismatch**

**Status:** NEW (2026-03-06) — Identified during flutterm secondary_classes integration testing

**a) Problem:**

Bridge argument extraction fails when the expected type is nullable but the provided value is non-nullable:

```
expected TextStyle?, got TextStyle
```

This occurs when a constructor parameter expects `TextStyle?` but the bridge unwraps the `BridgedInstance<TextStyle>` to a `TextStyle` value, which then fails the `is TextStyle?` type check in some code paths.

**Affected tests:** 3 failures across secondary_classes_test.dart (TextStyle-related widgets)

**b) Root Cause:**

In `D4.extractBridgedArg<T>()` (d4.dart L663+), when `T` is `TextStyle?`, the method attempts to match the value against type `T`. A non-null `TextStyle` should satisfy `is TextStyle?` — in Dart's type system, `TextStyle` is a subtype of `TextStyle?`. However, the bridge may be:

1. Using a different code path that compares `runtimeType` strings rather than `is T` checks
2. The `BridgedInstance` wrapping is confusing the type check — the value is still wrapped when the nullable check occurs
3. Cross-package type identity issues — the `TextStyle` from one bridge registration doesn't match `TextStyle?` from another

**c) Proposed Solution:**

**Approach 1 — Add nullable-aware type coercion in extractBridgedArg:**

When `extractBridgedArg<T>()` fails the `is T` check but `T` is nullable and the value matches the non-nullable base type, accept the conversion:

```dart
static T extractBridgedArg<T>(dynamic value, String argName) {
  // ... existing unwrapping logic ...
  final unwrapped = _unwrap(value);
  if (unwrapped is T) return unwrapped;
  
  // Nullable fallback: if T is nullable and value matches base type
  if (null is T && unwrapped != null) {
    // T is nullable — try direct cast
    return unwrapped as T;
  }
  throw ArgumentError('Expected $T, got ${unwrapped.runtimeType} for $argName');
}
```

**Approach 2 — Use extractBridgedArgOrNull for nullable parameters:**

The generator should detect nullable parameter types and emit `D4.extractBridgedArgOrNull<TextStyle>(...)` instead of `D4.extractBridgedArg<TextStyle?>(...)`, handling the nullability at the call site.

**d) Implementation Scope:**

Approach 1 is a small change in `d4.dart`. Approach 2 requires generator awareness of nullable parameters (may already partially exist).

**Why needed:** Many Flutter widget constructors have nullable style parameters (`TextStyle?`, `Color?`, `EdgeInsets?`). Without proper nullable handling, D4rt scripts cannot pass styles to widgets like `Text`, `TextField`, `AppBar`.

---

### ENG-008

**Unexported/deprecated type variable references**

**Status:** NEW (2026-03-06) — Identified during flutterm hardly_relevant and secondary_classes testing

**a) Problem:**

D4rt test scripts reference types that are either deprecated in the current Flutter SDK or not publicly exported:

**Deprecated types (removed from Flutter 3.32+):**
- `ButtonBar` — deprecated, replaced by `OverflowBar`
- `ButtonBarThemeData` — deprecated along with `ButtonBar`
- `RawKeyboardListener` — deprecated, replaced by `KeyboardListener`

**Unexported types (internal to Flutter SDK):**
- `RenderAnimatedSizeState` — enum from `rendering/animated_size.dart`, not in public barrel exports
- `KeyDataTransitMode` — enum from `services/hardware_keyboard.dart`, not publicly exported
- `KeyboardSide` — enum from `services/raw_keyboard.dart`, not publicly exported
- `ModifierKey` — enum from `services/raw_keyboard.dart`, not publicly exported

**Affected tests:** 6 failures across hardly_relevant_classes_test.dart and secondary_classes_test.dart

**b) Root Cause:**

The bridge classes and test scripts were generated against an earlier Flutter SDK version. Flutter regularly deprecates and removes APIs, and some types that existed in prior versions are no longer available. Additionally, some types are defined in internal files that are not part of Flutter's public API barrel exports.

The generator includes these types because it scans the SDK source files directly rather than going through the public API surface. Types defined in internal files get bridged even though they can't be accessed by D4rt scripts through normal import paths.

**c) Proposed Solution:**

**Approach 1 — Update bridge configuration (immediate):**

Remove deprecated and unexported types from `d4rtgen.yaml` module configurations, or add them to an exclusion list:

```yaml
# In d4rtgen.yaml module config:
exclude_classes:
  - ButtonBar
  - ButtonBarThemeData
  - RawKeyboardListener
  - RenderAnimatedSizeState
  - KeyDataTransitMode
  - KeyboardSide
  - ModifierKey
```

**Approach 2 — Generator public API filter (recommended long-term):**

Enhance the generator to verify that scanned classes are actually reachable through the package's public barrel file (`package:flutter/material.dart`, etc.) before generating bridges. Classes only reachable via `src/` imports should be flagged or excluded automatically.

**Approach 3 — Deprecation awareness:**

Add a `@Deprecated` annotation scanner to the generator. Classes or members marked `@Deprecated` get either skipped or annotated in the generated bridge as deprecated.

**d) Implementation Scope:**

Approach 1 is immediate — configuration change only. Approach 2 is a generator enhancement that prevents this problem class from recurring with future SDK updates.

**Why needed:** Medium priority — test suites should only test types that are actually available in the current Flutter SDK. False failures from deprecated types make it harder to track real regressions.

---

### ENG-009

**Enum coercion for bitfield operator parameters**

**Status:** NEW (2026-03-06) — Identified during flutterm secondary_classes integration testing

**a) Problem:**

The `[]=` operator on bitfield-like classes expects an enum value as the index, but receives an `int` from the D4rt interpreter:

```
Class 'int' has no instance getter 'index'
```

This occurs when D4rt scripts use bracket assignment on types like `BitField` where the key type is an enum and the operator implementation accesses `.index` on the key parameter.

**Affected tests:** 1 failure in secondary_classes_test.dart

**b) Root Cause:**

The bridge-generated operator adapter passes the key argument as its raw D4rt value (an `int`). The native operator implementation expects an enum value and accesses `.index` on it. Since D4rt doesn't have native enum instances for all bridge-registered enums, the raw int value is passed through, and calling `.index` on an `int` fails.

The bridge operator adapter code looks like:

```dart
'[]=': (instance, args) => instance[args[0]] = args[1],
```

When `args[0]` should be an enum value but is an `int`, the operator body fails.

**c) Proposed Solution:**

**Approach 1 — Type-aware operator argument extraction (recommended):**

The generator should detect when an operator parameter type is an enum and emit coercion code:

```dart
'[]=': (instance, args) {
  final key = MyEnum.values[D4.extractBridgedArg<int>(args[0], 'key')];
  instance[key] = D4.extractBridgedArg<bool>(args[1], 'value');
},
```

This requires the generator to analyze operator parameter types during code generation.

**Approach 2 — Runtime enum coercion in D4.extractBridgedArg:**

When the expected type is an enum and the provided value is an `int`, look up the enum type's `.values` list and convert:

```dart
if (T is Enum && value is int) {
  // Use reflection or registered enum values to convert
  return _registeredEnumValues[T]![value] as T;
}
```

This would require registering enum `.values` lists for all bridged enums.

**d) Implementation Scope:**

Generator-side fix (Approach 1) is more targeted and doesn't require runtime enum registration. The generator already knows the parameter types.

**Why needed:** Low priority — bitfield operations are uncommon. But the pattern of enum-typed operator parameters may appear in other classes.

---

## Open Issues — Generator (Bridge Code)

### GEN-092

**Interface proxy factory registration**

**Status:** NEW (2026-03-06) — Identified during flutterm secondary_classes integration testing

**a) Problem:**

Proxy subclasses for abstract delegate classes were generated in this session (GEN-083, now resolved), but the proxy **factories** are not registered with `D4.registerInterfaceProxy()`. When D4rt scripts create interpreted subclasses of abstract classes, `extractBridgedArg<T>()` cannot convert the `InterpretedInstance` to the native type:

```
expected DataTableSource, got InterpretedInstance(TestDataSource)
expected FlowDelegate, got InterpretedInstance(TestFlowDelegate)
expected SliverPersistentHeaderDelegate, got InterpretedInstance(TestPersistentHeaderDelegate)
expected MultiChildLayoutDelegate, got InterpretedInstance(TestMultiChildLayoutDelegate)
```

**Affected tests:** 7 failures in secondary_classes_test.dart

**Affected classes:**
- `DataTableSource` — required for `PaginatedDataTable(source:)`
- `FlowDelegate` — required for `Flow(delegate:)`
- `SliverPersistentHeaderDelegate` — required for `SliverPersistentHeader(delegate:)`
- `MultiChildLayoutDelegate` — required for `CustomMultiChildLayout(delegate:)`
- `SingleChildLayoutDelegate` — required for `CustomSingleChildLayout(delegate:)` (proxy exists via GEN-083 fix)
- `CustomPainter` — proxy exists, factory may or may not be registered
- `CustomClipper` — proxy exists, factory may or may not be registered

**b) Root Cause:**

In `D4.extractBridgedArg<T>()` (d4.dart L663+), the conversion path for `InterpretedInstance` is:

1. Check `bridgedSuperObject` → null for abstract classes (no native super instance)
2. Check `_interfaceProxies[className]` → not found because no factory was registered
3. Check type coercions → no match
4. Throw: `expected T, got InterpretedInstance(...)`

The proxy classes (e.g., `D4rtCustomPainter`, `D4rtFlowDelegate`) exist in `flutter_proxies.b.dart` but the bridge registration code in `flutter_proxies_bridges.b.dart` does not call `D4.registerInterfaceProxy()` to register the factory function that converts D4rt callback functions into native proxy instances.

**c) Proposed Solution:**

**Generator auto-registers proxy factories:**

Enhance the proxy generator to emit both the proxy class AND the corresponding `D4.registerInterfaceProxy()` call, so proxy compilation and factory registration are always in sync. The generator already knows the proxy's abstract methods and their signatures — it should also emit the factory that bridges `InterpretedInstance` method calls to native proxy callbacks:

```dart
// Generated alongside proxy class:
D4.registerInterfaceProxy<CustomPainter>('CustomPainter', (InterpretedInstance instance) {
  return D4rtCustomPainter(
    onPaint: (canvas, size) {
      instance.callMethod('paint', [D4.wrapBridged(canvas), D4.wrapBridged(size)]);
    },
    onShouldRepaint: (oldDelegate) {
      return instance.callMethod('shouldRepaint', [D4.wrapBridged(oldDelegate)]) as bool;
    },
  );
});
```

**d) Implementation Scope:**

Extend the proxy generator (`proxy_generator.dart`) to emit a `registerProxyFactories()` function alongside the proxy classes. This function is called during bridge initialization and registers each proxy factory with `D4.registerInterfaceProxy()`. The generator already has all the method signature information needed.

**Why needed:** High priority — 7 test failures. These are fundamental Flutter delegate patterns. Without proxy factory registration, D4rt scripts cannot use `CustomPaint`, `Flow`, `PaginatedDataTable`, `SliverPersistentHeader`, or `CustomMultiChildLayout`.

---

### GEN-093

**Inherited members from generic superclasses not bridged**

**Status:** NEW (2026-03-06) — Identified during flutterm secondary_classes integration testing

**a) Problem:**

Bridge-generated classes that inherit from generic superclasses are missing inherited members (getters, setters, methods). The inherited properties are not generated in the bridge because the generator does not walk up the generic superclass hierarchy:

```
Undefined property: 'value' on RestorableInt
Undefined property: 'value' on RestorableNum  
Undefined property: 'value' on TextEditingController
Cannot assign to 'value' on TransformationController
Undefined property: 'lengthInBytes' on _ByteDataView
```

**Affected tests:** 5 failures in secondary_classes_test.dart (4 undefined property + 1 no setter adapter)

**Inheritance chains affected:**
- `RestorableInt` → `RestorableNum<int>` → `RestorableValue<int>` — `.value` getter/setter defined on `RestorableValue<T>`
- `RestorableNum<num>` → `RestorableValue<num>` — `.value` getter/setter defined on `RestorableValue<T>`
- `TextEditingController` → `ValueNotifier<TextEditingValue>` → `ChangeNotifier` — `.value` from `ValueNotifier<T>`
- `TransformationController` → `ValueNotifier<Matrix4>` — `.value` setter from `ValueNotifier<T>`
- `ByteData` (internal `_ByteDataView`) → `TypedData` — `.lengthInBytes` from `TypedData`

**b) Root Cause:**

The bridge generator's class analyzer collects members declared directly on the target class and its concrete superclasses. When a superclass is generic (e.g., `RestorableValue<T>`, `ValueNotifier<T>`), the analyzer either:

1. Stops walking at the generic superclass boundary because it cannot resolve the generic type parameter
2. Skips members from generic superclasses because the type parameter `T` in the member signature can't be concretized for the bridge

For example, `RestorableValue<T>.value` has type `T`, which is `int` for `RestorableInt`. The generator would need to substitute `T → int` when generating the bridge for `RestorableInt`, which it currently doesn't do.

**c) Proposed Solution:**

**Generator type parameter substitution:**

When analyzing class members, walk the full superclass hierarchy including generic superclasses. For each generic superclass, substitute the type parameters based on the subclass's `extends` clause:

```dart
// During bridge analysis for RestorableInt:
// 1. See: class RestorableInt extends RestorableNum<int>
// 2. See: class RestorableNum<T extends num> extends RestorableValue<T>
// 3. Substitute: T = int in all member signatures from RestorableValue
// 4. Emit: 'value': (instance) => instance.value  // type: int
```

This requires tracking type parameter bindings through the class hierarchy and substituting them in member signatures when generating bridge code.

**d) Implementation Scope:**

Generator type parameter substitution (Approach 1) is a significant enhancement — the analyzer needs to:
1. Track type parameter bindings through the class hierarchy
2. Substitute type parameters in member signatures
3. Handle multi-level generic chains (e.g., `A<T>` → `B<T>` → `C<T>`)

This is a fundamental improvement to the generator's type resolution.

**Why needed:** High priority — `ValueNotifier`, `RestorableValue`, and `TextEditingController` are core Flutter state management primitives. Without inherited member bridging, D4rt scripts cannot read/write reactive values.

---

### GEN-094

**Flutter API method signature changes**

**Status:** NEW (2026-03-06) — Identified during flutterm secondary_classes integration testing

**a) Problem:**

A bridge-generated method adapter has an outdated parameter count that doesn't match the current Flutter SDK method signature:

```
shouldAcceptUserOffset expects at least 1 argument(s), got 0
```

The generated bridge calls `instance.shouldAcceptUserOffset()` with no arguments, but the current Flutter SDK version of this method requires a parameter.

**Affected tests:** 1 failure in secondary_classes_test.dart

**b) Root Cause:**

The bridge was generated against a Flutter SDK version where `shouldAcceptUserOffset` took no parameters (or was a getter). A subsequent Flutter SDK update added a required parameter to this method. The generated bridge code is now stale.

This is a general category — any Flutter SDK API change that modifies method signatures will cause similar bridge mismatches.

**c) Proposed Solution:**

**Approach 1 — Regenerate bridges for current SDK (immediate):**

Run `d4rtgen build` against the current Flutter SDK to regenerate all bridge classes with current method signatures.

**Approach 2 — Version-aware bridge generation (long-term):**

Add a mechanism to detect SDK version changes and flag potentially stale bridges:
- Store the Flutter SDK version used during generation in a metadata comment
- During build, compare against current SDK version and warn if different
- Provide a `d4rtgen check` command that reports signature mismatches without regenerating

**d) Implementation Scope:**

Immediate fix: regenerate bridges. Long-term: SDK version tracking in the generator.

**Why needed:** Low priority individually, but represents a recurring maintenance pattern — any Flutter SDK update may introduce similar mismatches. The version-tracking solution prevents silent staleness.

---

### GEN-085

**Theme/function typedef alias registration**

**Status:** OPEN (2026-03-08, updated 2026-03-06) — Identified during flutterm important classes testing + secondary_classes testing

**a) Problem:**

**Theme typedefs:** Four Material theme classes are registered in the bridge with their internal Dart SDK class names, but Flutter's public API uses typedef aliases. D4rt scripts use the public names, causing bridge lookup failures:

| Public API Name (used in scripts) | Internal SDK Name (registered in bridge) |
|-----------------------------------|------------------------------------------|
| `BottomAppBarTheme` | `BottomAppBarThemeData` |
| `CardTheme` | `CardThemeData` |
| `DialogTheme` | `DialogThemeData` |
| `TabBarTheme` | `TabBarThemeData` |

**Function typedefs:** `VoidCallback` (`typedef VoidCallback = void Function()`) is not registered in the bridge type system. Scripts using `VoidCallback` as a type annotation fail with `Type 'VoidCallback' not found`.

Scripts using `BottomAppBarTheme(...)` fail because the bridge only knows `BottomAppBarThemeData`.

**Affected tests:** `appbar_themes_test.dart`, `component_themes_test.dart`, `dialog_themes_test.dart`, `input_themes_test.dart`, + 1 failure in secondary_classes_test.dart (VoidCallback)

**b) Root Cause:**

The generator scans Flutter SDK source files and finds the actual class declarations (e.g., `class BottomAppBarThemeData`). The public typedef aliases (e.g., `typedef BottomAppBarTheme = BottomAppBarThemeData`) are separate declarations that the generator doesn't follow when registering bridge names.

**c) Proposed Solution:**

**Generator typedef detection:**

During class scanning, also scan for `typedef X = Y` declarations and register the alias name alongside the real class name. The bridge should respond to both names. This is a one-time generator enhancement that handles all future typedef aliases automatically, including:

- Class typedef aliases (e.g., `typedef BottomAppBarTheme = BottomAppBarThemeData`)
- Function typedefs (e.g., `typedef VoidCallback = void Function()`)

For function typedefs like `VoidCallback`, the generator should register the typedef name in the bridge type system so it resolves to the underlying function type.

Additionally, the generator config could support an explicit `aliases` field for cases where the typedef is not easily auto-detected:

```yaml
classes:
  BottomAppBarThemeData:
    aliases: [BottomAppBarTheme]
```

**d) Implementation Scope:**

Generator-level typedef scanning is the cleanest fix. The scan happens during the existing class analysis phase — extend it to also collect `typedef` declarations from the same source files.

**Why needed:** These are commonly used Material theme classes. Every app using `ThemeData(bottomAppBarTheme: BottomAppBarTheme(...))` will hit this.

---

### GEN-086

**Setter adapter does not unwrap BridgedInstance**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

Bridge-generated setter adapters pass values directly using `value as dynamic` instead of unwrapping `BridgedInstance<T>` to the native Dart object. When a D4rt script sets `Paint.color = someColor`, the bridge receives a `BridgedInstance<Color>` but passes it directly to the native setter, which expects a raw `Color`.

```dart
// Current generated code (broken):
'color': (instance, value) => instance.color = value as dynamic,

// Correct code should be:
'color': (instance, value) => instance.color = D4.extractBridgedArg<Color>(value, 'color'),
```

**Affected tests:** `picture_test.dart`, `canvas_test.dart`

**b) Root Cause:**

The generator's setter emission code uses `value as dynamic` for all setter adapters. Constructor named arguments correctly use `D4.extractBridgedArg<T>()` for unwrapping, but the setter code path was not updated with the same unwrapping logic. This is an oversight in the code emission template for setter adapters.

**c) Proposed Solution:**

Modify the setter emission code in the generator to use the same `D4.extractBridgedArg<T>()` unwrapping as constructor named arguments. The generator already knows the setter's parameter type from analysis, so it can emit the correct cast:

```dart
// Generator should emit for bridged types:
'color': (instance, value) => instance.color = D4.extractBridgedArg<Color>(value, 'color'),

// Generator should emit for primitive types:
'strokeWidth': (instance, value) => instance.strokeWidth = value as double,
```

**d) Implementation Scope:**

Small change in the generator's setter emission code. Find the setter template in the emitter and apply the same type-aware unwrapping used for constructor arguments.

**Why needed:** `Paint` is the most fundamental drawing primitive. Without correct setter unwrapping, D4rt scripts cannot configure paint color, shader, stroke, etc. — making all custom drawing code non-functional.

---

### GEN-087

**Non-wrappable constructor parameter defaults emitted unconditionally**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

`NetworkImage` has a web-only parameter `webHtmlElementStrategy` whose default value comes from `dart:_engine` (a private platform library). The generator emits this parameter unconditionally with `getRequiredNamedArgTodoDefault('webHtmlElementStrategy', ..., '<default unavailable>')`. When D4rt scripts create `NetworkImage(url)` without providing this parameter, the bridge passes `'<default unavailable>'` as the actual value, causing a runtime error.

**Affected tests:** `asset_test.dart` (plus `decoration_test.dart`, `nav_destinations_test.dart` which have script-level workarounds)

**b) Root Cause:**

The generator's `getRequiredNamedArgTodoDefault` mechanism is designed for parameters where the default value can't be replicated in generated code. But it still passes the placeholder string to the constructor. For web-only parameters, the entire parameter should be omitted when not explicitly provided by the caller.

**c) Proposed Solution:**

**Approach 1 — Conditional parameter emission (recommended):**

When a parameter has `'<default unavailable>'`, check if the caller provided it before including it in the constructor call. If not provided, omit it entirely and let the native constructor use its own default:

```dart
// Generate conditional emission:
final webStrategy = namedArgs.containsKey('webHtmlElementStrategy')
    ? namedArgs['webHtmlElementStrategy']
    : null;  // omit from call

// Then conditionally include in constructor:
if (webStrategy != null) {
  return NetworkImage(url, webHtmlElementStrategy: webStrategy);
} else {
  return NetworkImage(url);  // native default used
}
```

**Approach 2 — Platform-conditional code:**

Mark parameters as platform-specific in `d4rtgen.yaml` and skip them on non-web platforms.

**d) Implementation Scope:**

Modify the generator to detect `<default unavailable>` placeholders and emit conditional parameter inclusion instead of unconditional pass-through.

**Why needed:** `NetworkImage` is a primary image loading class. D4rt scripts that load images from URLs need this to work.

---

### GEN-088

**Missing Cupertino widget bridge classes**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

Two Cupertino widget families are not included in the bridge class list:

- `CupertinoMenuAnchor` (and related `CupertinoMenuItem`, `CupertinoMenuLargeButton`, etc.)
- `CupertinoPulldownButton` (and related `CupertinoPulldownMenuItem`, etc.)

These are relatively new Flutter Cupertino classes (added in Flutter 3.32+) that were not in the SDK when the initial bridge module was configured.

**Affected tests:** `menu_widgets_test.dart`, `pulldown_test.dart`

**b) Root Cause:**

The classes are simply not listed in the `d4rtgen.yaml` module configuration for the Cupertino package. The generator cannot bridge classes it doesn't know about.

**c) Proposed Solution:**

Add the missing classes to the `cupertino` module in `d4rtgen.yaml`:

```yaml
# In cupertino module config:
classes:
  # ... existing classes ...
  CupertinoMenuAnchor:
  CupertinoMenuItem:
  CupertinoMenuLargeButton:
  CupertinoPulldownButton:
  CupertinoPulldownMenuItem:
```

Then regenerate the Cupertino bridges: `d4rtgen build cupertino`

**d) Implementation Scope:**

Configuration change + regeneration. No generator code changes needed.

**Why needed:** Cupertino menus are the standard iOS-style context menu and pulldown button pattern. Apps targeting iOS need these.

---

### GEN-089

**NoDefaultCupertinoThemeData constructor type mismatch**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

The `NoDefaultCupertinoThemeData` constructor bridge has a type mismatch when constructing instances. The bridge-generated constructor passes arguments that don't match the expected parameter types.

**Affected tests:** `cupertino_themes_batch4_test.dart`

**b) Root Cause:**

`NoDefaultCupertinoThemeData` is a special Cupertino theme class with an atypical constructor signature. The generator may be treating it like a regular theme data class but it has different parameter types or required parameters that conflict with the generated bridge.

**c) Proposed Solution:**

Investigate the exact constructor signature of `NoDefaultCupertinoThemeData` and compare it to the generated bridge code. The fix may require:

- Adjusting the generator's parameter type detection for this class
- Adding it to the special-case handling in the generator

**d) Implementation Scope:**

Requires investigation of the specific mismatch. May be a simple parameter type fix or may need special handling.

**Why needed:** Lower priority — `NoDefaultCupertinoThemeData` is an internal theme support class. Most apps use `CupertinoThemeData` directly.

---

### GEN-090

**GravitySimulation endDistance assertion failure**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

Creating a `GravitySimulation` through the bridge fails with an assertion error related to the `endDistance` parameter. The bridge's argument ordering or value extraction produces values that violate the constructor's assertion: `endDistance` must be greater than `distance`.

**Affected tests:** `simulations_test.dart`

**b) Root Cause:**

The `GravitySimulation` constructor in the Flutter SDK has specific parameter semantics:

```dart
GravitySimulation(double acceleration, double distance, double endDistance, double velocity)
```

With the assertion: `assert(googAssert: endDistance >= distance)`. The bridge may be:

1. Extracting positional arguments in the wrong order
2. Or the test script may be passing arguments in the wrong order (test script bug, not bridge bug)

Investigation needed to determine if this is a bridge ordering issue or a test script error.

**c) Proposed Solution:**

1. Verify the test script's argument order matches `(acceleration, distance, endDistance, velocity)`
2. If the test script is wrong, fix the test script and remove the skip
3. If the bridge ordering is wrong, fix the bridge's positional argument extraction

**d) Implementation Scope:**

Small fix — likely a test script correction or bridge argument reordering.

**Why needed:** Low priority — `GravitySimulation` is a niche physics simulation class.

---

### GEN-091

**AlwaysStoppedAnimation generic type limited to primitives**

**Status:** OPEN (2026-03-08) — Workaround applied (sections removed from rotationtransition_test)

**a) Problem:**

The `AlwaysStoppedAnimation<T>` bridge (GEN-075 fix) uses a switch statement on the runtime type of the `value` parameter to determine the generic type `T`. The switch only covers primitive types:

```dart
// animation_bridges.b.dart L2891:
final value = D4.getNthPositionalArg(0, positionalArgs);
if (value is double) return AlwaysStoppedAnimation<double>(value);
if (value is int) return AlwaysStoppedAnimation<int>(value);
if (value is String) return AlwaysStoppedAnimation<String>(value);
if (value is bool) return AlwaysStoppedAnimation<bool>(value);
return AlwaysStoppedAnimation(value);  // ← AlwaysStoppedAnimation<dynamic>
```

When `value` is a `BridgedInstance<RelativeRect>` or `BridgedInstance<Decoration>`, the default case produces `AlwaysStoppedAnimation<dynamic>`, which fails type checks like `is Animation<RelativeRect>`.

This causes `PositionedTransition(rect:)` and `DecoratedBoxTransition(decoration:)` to fail because they require `Animation<RelativeRect>` and `Animation<Decoration>` respectively.

**Affected tests:** `rotationtransition_test.dart` (sections removed as workaround — the remaining rotation/scale/fade/size sections work because they use `double`)

**b) Root Cause:**

The GEN-075 fix was designed for the common case (Animation of primitives). Flutter uses `AlwaysStoppedAnimation<T>` with many types: `Color`, `Offset`, `Size`, `RelativeRect`, `Decoration`, `BoxDecoration`, `TextStyle`, `BorderRadius`, etc. The switch would need to enumerate all these.

**c) Proposed Solution:**

**Generator-based type exploration:**

During generation, scan which concrete types are used with `AlwaysStoppedAnimation<T>` across the Flutter API (by finding constructor parameters typed as `Animation<X>`) and emit switch cases for all discovered types. The generator already analyzes Flutter source — it can identify all parameters with `Animation<SpecificType>` annotations and build the complete type switch:

```dart
// Generated type switch based on API scan:
final unwrapped = D4.extractBridgedArgDynamic(value);
if (unwrapped is double) return AlwaysStoppedAnimation<double>(unwrapped);
if (unwrapped is int) return AlwaysStoppedAnimation<int>(unwrapped);
if (unwrapped is Color) return AlwaysStoppedAnimation<Color>(unwrapped);
if (unwrapped is Offset) return AlwaysStoppedAnimation<Offset>(unwrapped);
if (unwrapped is Size) return AlwaysStoppedAnimation<Size>(unwrapped);
if (unwrapped is RelativeRect) return AlwaysStoppedAnimation<RelativeRect>(unwrapped);
if (unwrapped is Decoration) return AlwaysStoppedAnimation<Decoration>(unwrapped);
if (unwrapped is BorderRadius) return AlwaysStoppedAnimation<BorderRadius>(unwrapped);
if (unwrapped is TextStyle) return AlwaysStoppedAnimation<TextStyle>(unwrapped);
// ... all types discovered from Animation<X> parameter scan
return AlwaysStoppedAnimation(unwrapped);
```

Note: The value must be unwrapped from `BridgedInstance<T>` first using `D4.extractBridgedArgDynamic()` before the `is` checks.

**d) Implementation Scope:**

1. Add an API scan pass to the generator that finds all `Animation<X>` parameter types across the bridged API surface
2. Collect the set of concrete types used as `X`
3. Emit a type switch in the `AlwaysStoppedAnimation` constructor bridge that covers all discovered types
4. Include `BridgedInstance` unwrapping before the switch

**Why needed:** `PositionedTransition`, `DecoratedBoxTransition`, and color/style animations are important for Flutter UI. Without proper generics, these animation widgets cannot be used from D4rt scripts.

---

## Fix Strategy Summary

All issues should be resolved with proper generator or interpreter fixes. No UserBridge workarounds.

### Fix Categories

| Category | Issues | Fix Location |
|----------|--------|--------------|
| Generator — proxy lifecycle | GEN-092 | proxy_generator.dart (emit registerInterfaceProxy calls) |
| Generator — type resolution | GEN-085, GEN-091, GEN-093 | class analyzer + emitter (typedef scanning, generic superclass walk, animation type scan) |
| Generator — setter emission | GEN-086, ENG-003 | setter adapter template (extractBridgedArg unwrapping, callback wrapping) |
| Generator — parameter handling | GEN-087, GEN-094, ENG-009 | constructor emitter (conditional defaults, SDK signature update, enum coercion) |
| Generator — config | GEN-088, ENG-008 | d4rtgen.yaml (add missing classes, remove deprecated/unexported) |
| Interpreter — type system | ENG-001, ENG-002, ENG-007 | interpreter + d4.dart (collection casting, Type expressions via BridgedClass.getType(), nullable handling) |
| Interpreter — function model | ENG-006 | interpreter property resolution (Object member fallback for functions) |
| Interpreter — runtime | ENG-004, ENG-005 | typed_data bridges (lower priority) |
| Investigation | GEN-089, GEN-090 | Need further analysis |

### Priority Order

| Priority | Issues | Proper Fix | Impact |
|----------|--------|------------|--------|
| **High** | GEN-092 | Generator emits proxy factory registration | Unblocks 7 tests (delegate classes) |
| **High** | GEN-085, GEN-086 | Generator typedef scanning + setter unwrapping | Unblocks 6+ tests |
| **High** | GEN-093 | Generator generic superclass type parameter substitution | Unblocks 5 tests (RestorableValue, ValueNotifier) |
| **High** | ENG-001 | Bridge-side collection casting in D4.extractBridgedArg + interpreter type annotations | Unblocks 3 tests |
| **Medium** | ENG-006 | Interpreter Object member fallback for function types | Fixes 5 failures |
| **Medium** | ENG-007 | Nullable-aware type extraction in D4.extractBridgedArg | Fixes 3 failures |
| **Medium** | GEN-087, GEN-088 | Generator conditional parameter emission + config update | Unblocks 3 tests |
| **Medium** | ENG-002 | BridgedClass.getType() API + interpreter Type expression resolution | Unblocks 1 test |
| **Medium** | ENG-003 | Generator setter callback wrapping (extend constructor pattern) | Unblocks 1 test |
| **Medium** | ENG-008 | Remove deprecated/unexported types from d4rtgen.yaml | Fixes 6 false failures |
| **Medium** | GEN-091 | Generator API scan for Animation<X> types | Restores workaround sections |
| **Low** | GEN-089, GEN-090 | Investigation needed | Unblocks 2 tests |
| **Low** | GEN-094 | Regenerate bridges for current SDK | Fixes 1 failure |
| **Low** | ENG-009 | Generator enum-aware operator argument extraction | Fixes 1 failure |
| **Low** | ENG-004, ENG-005 | Bridge dart:typed_data types | Test workarounds already applied |

---

## Resolved Issues Archive

All previously tracked issues (GEN-078 through GEN-082, G-DOV-8, G-FLP-54/55/57, G-FBI-04/12/21/22/32/33/34/40, G-NUM-11/12/15/26/27/31) have been resolved as of 2026-03-02. See git history for details.

GEN-083 (Proxy/adapter class generation) was resolved on 2026-03-06 — proxy_generator.dart enhanced to support both abstract (required) and overridable (optional nullable with super fallback) method callbacks. All 5 proxy classes (D4rtCustomPainter, D4rtCustomClipper, D4rtFlowDelegate, D4rtMultiChildLayoutDelegate, D4rtSingleChildLayoutDelegate) now compile correctly. Note: proxy factory registration is tracked separately as GEN-092.

| Category | Count | IDs |
|----------|-------|-----|
| Fixed (generator) | 6 | GEN-078, GEN-079, GEN-080, GEN-082, GEN-083, G-FLP-54 |
| Fixed (runtime) | 2 | GEN-081, I-BUG-14b |
| Fixed (interpreter) | 1 | G-DOV-8 |
| Closed (by design) | 2 | G-FLP-55, G-FLP-57 |
| Verified (already work) | 14 | G-FBI-04, G-FBI-12, G-FBI-21, G-FBI-22, G-FBI-32, G-FBI-33, G-FBI-34, G-FBI-40, G-NUM-11, G-NUM-12, G-NUM-15, G-NUM-26, G-NUM-27, G-NUM-31 |

---

## Known Limitations (not generator issues)

- **I-BUG-14a** (records with named fields) — **Dart language limitation.** Native records with named fields cannot be constructed dynamically at runtime. The interpreter returns `InterpretedRecord` which has the correct data but doesn't pass `isA<({int x, int y})>()` type checks.
- **G-DOV2-7** (extension on enum type resolution) — Interpreter issue, not tracked in this generator issues file.
