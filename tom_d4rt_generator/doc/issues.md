# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-03-08
>
> Generator test suite: **618 passed, 0 skipped, 0 failed**
> Flutterm integration: **148 passed, 22 skipped, 0 failed**

---

## Issue Index

### Generator Issues

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [GEN-083](#gen-083) | Proxy/adapter class generation | Generator | custompaint, flow, etc. | **OPEN** |
| [GEN-085](#gen-085) | Theme typedef alias registration | Generator | appbar_themes, component_themes, dialog_themes, input_themes | **OPEN** |
| [GEN-086](#gen-086) | Setter adapter BridgedInstance unwrapping | Generator | picture, canvas | **OPEN** |
| [GEN-087](#gen-087) | Non-wrappable constructor parameter defaults | Generator | asset | **OPEN** |
| [GEN-088](#gen-088) | Missing Cupertino widget bridges | Generator | menu_widgets, pulldown | **OPEN** |
| [GEN-089](#gen-089) | NoDefaultCupertinoThemeData constructor | Generator | cupertino_themes_batch4 | **OPEN** |
| [GEN-090](#gen-090) | GravitySimulation endDistance assertion | Generator | simulations | **OPEN** |
| [GEN-091](#gen-091) | AlwaysStoppedAnimation generic type | Generator | rotationtransition (workaround) | **OPEN** |

### Engine Issues (Interpreter Limitations)

| ID | Description | Component | Affected Tests | Status |
|----|-------------|-----------|----------------|--------|
| [ENG-001](#eng-001) | Collection literal generic type inference | Interpreter | segmentedbutton, widgetstate, misc_themes | **OPEN** |
| [ENG-002](#eng-002) | Type literals as map key expressions | Interpreter | actions | **OPEN** |
| [ENG-003](#eng-003) | Typed callback setter assignment | Interpreter | recognizers | **OPEN** |
| [ENG-004](#eng-004) | Float64List type unavailable | Interpreter | filters (workaround) | **OPEN** |
| [ENG-005](#eng-005) | ByteData.lengthInBytes not bridged | Interpreter | codecs (workaround) | **OPEN** |

### Test Impact Matrix

| Test Script | Skip Reason | Issue IDs |
|-------------|-------------|-----------|
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

Three complementary approaches:

**Approach 1 — Bridge-side collection casting (do this):**

Modify bridge argument extraction to cast collections to the expected generic type. When the bridge knows it needs a `Set<String>`, it can do `(arg as Set).cast<String>()`. This could be added to `D4.extractBridgedArg` or as a new `D4.extractTypedCollection` helper.

```dart
// In bridge argument extraction:
Set<T> extractTypedSet<T>(dynamic arg) {
  if (arg is Set) return arg.cast<T>();
  throw ArgumentError('Expected Set, got ${arg.runtimeType}');
}
```

**Approach 2 — Interpreter type annotation support: (do this, too)**

Support explicit type annotations on collection literals: `<String>{'day'}`, `<WidgetState>{}`, `<TargetPlatform, PageTransitionsBuilder>{...}`. This is a substantial interpreter enhancement but the most correct solution.

**Approach 3 — Helper classes in tom_d4rt_flutterm (UserBridge workaround):**

Provide typed collection factory helpers via UserBridge:

```dart
// In tom_d4rt_flutterm as a UserBridge:
class WidgetStateSetHelper extends D4UserBridge {
  static List<String> get nativeNames => ['WidgetStateSet'];

  @override
  dynamic overrideConstructor(String name, List args, Map<String, dynamic> namedArgs) {
    if (name == 'of') return Set<WidgetState>.from(args[0] as Iterable);
    if (name == 'empty') return <WidgetState>{};
    return null;
  }
}
```

D4rt script usage: `WidgetStateSet.of([WidgetState.hovered])` or `WidgetStateSet.empty()`

**d) Implementation Scope:**

| Approach | Effort | Impact | Recommendation |
|----------|--------|--------|----------------|
| Bridge-side casting | Low | Fixes all tests using bridges | **Do first** |
| Type annotation support | High | Fixes all collection typing globally | **Do as well** |
| UserBridge helpers | Medium | Script-friendly API | Supplement for complex cases |

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

**Approach 1 — UserBridge helper in tom_d4rt_flutterm:**

Provide an `ActionMapHelper` that accepts string-based action registration:

```dart
class ActionMapHelper extends D4UserBridge {
  static List<String> get nativeNames => ['ActionMap'];

  @override
  dynamic overrideConstructor(String name, List args, Map<String, dynamic> namedArgs) {
    if (name == 'of') {
      // Accept a list of [intentType, action] pairs
      // Use bridge-registered type lookup to resolve Type objects
      final entries = args[0] as List;
      final map = <Type, Action<Intent>>{};
      for (final entry in entries) {
        final pair = entry as List;
        final typeName = pair[0] as String;
        final action = pair[1] as Action<Intent>;
        map[_resolveType(typeName)] = action;
      }
      return map;
    }
    return null;
  }
}
```

**Approach 2 — Interpreter `Type` expression support:**

** USER'S CHOICE: this should be easier than it looks like, we simply extend the API for BridgedClass to include a Type getType() method that is implemented in the generated bridges. Then this is not so complicated in the interpreter **

Add a resolution path that, when an identifier appears in an expression context (not a call), evaluates it to a `Type` object if it matches a registered bridge class name. This is a complex interpreter change.

**d) Implementation Scope:**

UserBridge approach is practical and can be implemented immediately. Interpreter-level `Type` support is a deeper language feature.

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

**Approach 1 — Generator setter callback wrapping (recommended):**

When the generator detects a setter whose type is a `Function` type (callback), emit a wrapper that converts `InterpretedFunction` to the expected native callback:

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

**Approach 2 — UserBridge for recognizers:**

Create a `GestureRecognizerHelper` UserBridge that provides a `configure` method:

```dart
class GestureHelper extends D4UserBridge {
  static List<String> get nativeNames => ['GestureHelper'];

  @override
  dynamic overrideMethodDoWork(String name, dynamic instance, List args, Map<String, dynamic> namedArgs) {
    if (name == 'configureHDrag') {
      final recognizer = args[0] as HorizontalDragGestureRecognizer;
      final onStart = namedArgs['onStart'] as InterpretedFunction?;
      if (onStart != null) {
        recognizer.onStart = (details) => onStart.call([D4.wrapBridged(details)]);
      }
      // ... same for onUpdate, onEnd
    }
    return null;
  }
}
```

**d) Implementation Scope:**

The generator fix (Approach 1) is the proper solution — it extends the existing callback wrapping logic from constructor parameters to setters. The UserBridge approach is a stopgap.

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

## Open Issues — Generator (Bridge Code)

### GEN-083

**Proxy/adapter class generation for abstract delegate classes**

**Status:** OPEN (2026-03-03) — Feature request from flutterm testing Strategy I

**a) Problem:**

D4rt scripts cannot create instances of abstract delegate classes like `CustomPainter`, `CustomClipper<T>`, `FlowDelegate`, etc. These classes require subclassing with overridden abstract methods, but D4rt scripts cannot define native Dart subclasses. This means `CustomPaint(painter: myPainter)` is not possible from D4rt — the interpreter has no way to provide a `CustomPainter` subclass with `paint()` and `shouldRepaint()` implementations.

Existing test scripts (e.g., `custompaint_test.dart`, `flow_test.dart`) document this limitation — they can only test the delegate classes as types/constructors but cannot provide callback-driven implementations.

**b) Root Cause:**

The bridge generator only generates wrapper bridges for existing classes (bridging their constructors, methods, getters, setters). It has no mechanism to emit **proxy subclasses** that extend an abstract class and delegate abstract methods to D4rt callback functions.

**c) Proposed Solution:**

Enhance the generator to detect abstract classes with abstract methods and emit proxy/adapter subclasses that accept callback `Function` parameters. For each abstract method, generate a corresponding named callback parameter.

**Target classes (6 identified):**

| Class | Abstract Methods to Proxy | Priority |
|-------|--------------------------|----------|
| `CustomPainter` | `paint(Canvas, Size)`, `shouldRepaint(CustomPainter)` | **High** — CustomPaint is the primary custom drawing widget |
| `CustomClipper<T>` | `getClip(Size)`, `shouldReclip(CustomClipper)` | Medium |
| `FlowDelegate` | `paintChildren(FlowPaintingContext)`, `shouldRelayout()`, `shouldRepaint()` | Low |
| `MultiChildLayoutDelegate` | `performLayout(Size)` | Low |
| `SingleChildLayoutDelegate` | `getConstraintsForChild(BoxConstraints)`, `getPositionForChild(Size, Size)` | Low |
| `SearchDelegate` | `buildSuggestions(BuildContext)`, `buildResults(BuildContext)`, `buildLeading(BuildContext)`, `buildActions(BuildContext)` | Low |

**Generated code pattern:**

```dart
class D4rtCustomPainter extends CustomPainter {
  final Function(Canvas, Size) _onPaint;
  final Function(CustomPainter) _onShouldRepaint;

  D4rtCustomPainter({
    required Function(Canvas, Size) onPaint,
    required Function(CustomPainter) onShouldRepaint,
  }) : _onPaint = onPaint, _onShouldRepaint = onShouldRepaint;

  @override
  void paint(Canvas canvas, Size size) => _onPaint(canvas, size);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => _onShouldRepaint(oldDelegate);
}
```

**d) Implementation Scope:**

1. **Detection** — Identify abstract classes with abstract methods during analysis
2. **Configuration** — Add `proxyClasses` list to d4rtgen module config (opt-in per class)
3. **Code emission** — Generate `D4rt{ClassName}` proxy class in the module's bridge file
4. **Bridge registration** — Register the proxy class alongside the original class bridge
5. **Callback unwrapping** — Ensure D4rt `Function` values are correctly unwrapped as native callbacks

**Why needed:** Custom drawing is a fundamental Flutter capability. Without proxy generation, D4rt scripts cannot create custom painters/clippers/delegates, limiting them to pre-built widgets only.

**Reference:** Strategy I in `tom_d4rt_flutterm/_copilot_guidelines/d4rt_flutter_testing_extended.md`

---

### GEN-085

**Theme class typedef alias registration**

**Status:** OPEN (2026-03-08) — Identified during flutterm important classes testing

**a) Problem:**

Four Material theme classes are registered in the bridge with their internal Dart SDK class names, but Flutter's public API uses typedef aliases. D4rt scripts use the public names, causing bridge lookup failures:

| Public API Name (used in scripts) | Internal SDK Name (registered in bridge) |
|-----------------------------------|------------------------------------------|
| `BottomAppBarTheme` | `BottomAppBarThemeData` |
| `CardTheme` | `CardThemeData` |
| `DialogTheme` | `DialogThemeData` |
| `TabBarTheme` | `TabBarThemeData` |

Scripts using `BottomAppBarTheme(...)` fail because the bridge only knows `BottomAppBarThemeData`.

**Affected tests:** `appbar_themes_test.dart`, `component_themes_test.dart`, `dialog_themes_test.dart`, `input_themes_test.dart`

**b) Root Cause:**

The generator scans Flutter SDK source files and finds the actual class declarations (e.g., `class BottomAppBarThemeData`). The public typedef aliases (e.g., `typedef BottomAppBarTheme = BottomAppBarThemeData`) are separate declarations that the generator doesn't follow when registering bridge names.

**c) Proposed Solution:**

**Approach 1 — Generator typedef detection (recommended):**

During class scanning, also scan for `typedef X = Y` declarations and register the alias name alongside the real class name. The bridge should respond to both names.

**Approach 2 — UserBridge nativeNames (immediate workaround):**

Use the `nativeNames` mechanism on a UserBridge to register the alias:

```dart
class BottomAppBarThemeAlias extends D4UserBridge {
  static List<String> get nativeNames => ['BottomAppBarTheme'];

  @override
  dynamic overrideConstructor(String name, List args, Map<String, dynamic> namedArgs) {
    // Delegate to the existing BottomAppBarThemeData bridge
    return BottomAppBarThemeData(/* forward namedArgs */);
  }
}
```

**Approach 3 — d4rtgen.yaml alias config:**

Add an `aliases` field to the module config:

```yaml
classes:
  BottomAppBarThemeData:
    aliases: [BottomAppBarTheme]
```

**d) Implementation Scope:**

Generator-level typedef scanning is the cleanest fix — it's a one-time enhancement that handles all future typedef aliases automatically.

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
- Or using a UserBridge override

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

**Approach 1 — Extended type switch (practical):**

Add the most common Flutter types to the switch:

```dart
if (value is Color) return AlwaysStoppedAnimation<Color>(value);
if (value is Offset) return AlwaysStoppedAnimation<Offset>(value);
if (value is Size) return AlwaysStoppedAnimation<Size>(value);
if (value is RelativeRect) return AlwaysStoppedAnimation<RelativeRect>(value);
if (value is Decoration) return AlwaysStoppedAnimation<Decoration>(value);
if (value is BorderRadius) return AlwaysStoppedAnimation<BorderRadius>(value);
if (value is TextStyle) return AlwaysStoppedAnimation<TextStyle>(value);
```

But this needs BridgedInstance unwrapping first — the `value` comes in as `BridgedInstance<Color>`, not `Color`.

**Approach 2 — Generator-based type exploration (recommended):**

During generation, scan which concrete types are used with `AlwaysStoppedAnimation<T>` across the Flutter API (by finding constructor parameters typed as `Animation<X>`) and emit switch cases for all discovered types.

**Approach 3 — UserBridge specialization:**

Create type-specific constructors via UserBridge:

```dart
class AnimationHelper extends D4UserBridge {
  static List<String> get nativeNames => ['StoppedAnimation'];

  @override
  dynamic overrideConstructor(String name, List args, Map<String, dynamic> namedArgs) {
    final value = D4.extractBridgedArgDynamic(args[0]);
    if (name == 'ofRelativeRect') return AlwaysStoppedAnimation<RelativeRect>(value as RelativeRect);
    if (name == 'ofDecoration') return AlwaysStoppedAnimation<Decoration>(value as Decoration);
    if (name == 'ofColor') return AlwaysStoppedAnimation<Color>(value as Color);
    return null;
  }
}
```

D4rt script usage: `StoppedAnimation.ofRelativeRect(myRect)` instead of `AlwaysStoppedAnimation(myRect)`

**d) Implementation Scope:**

The generator approach (Approach 2) is the best long-term fix. The UserBridge approach (Approach 3) can be implemented immediately as a workaround.

**Why needed:** `PositionedTransition`, `DecoratedBoxTransition`, and color/style animations are important for Flutter UI. Without proper generics, these animation widgets cannot be used from D4rt scripts.

---

## Workaround Strategy Summary

### UserBridge Approach

The `D4UserBridge` mechanism (in `tom_d4rt_ast`) allows custom bridge implementations that override constructor, method, getter, setter, and operator behaviors without modifying the generator. Key points:

- **Annotation:** `@D4rtUserBridge(libraryPath: 'package:my_package/my_bridge.dart')`
- **Base class:** `D4UserBridge` with override methods
- **Name mapping:** `static List<String> get nativeNames` for registering alternative type names
- **Currently unused** in `tom_d4rt_flutterm` — all bridges are fully generated
- **Integration:** `orchestrator.scanUserBridges()` in the generator's builder.dart

### Proposed UserBridge Helpers for tom_d4rt_flutterm

| Helper Class | Issue | Purpose |
|-------------|-------|---------|
| `WidgetStateSet` | ENG-001 | Create typed `Set<WidgetState>` from list |
| `TypedMapHelper` | ENG-001 | Create typed `Map<K,V>` from untyped map |
| `ActionMap` | ENG-002 | Create `Map<Type, Action<Intent>>` by string name |
| `GestureHelper` | ENG-003 | Configure recognizer callbacks with proper typing |
| `StoppedAnimation` | GEN-091 | Type-specific `AlwaysStoppedAnimation<T>` constructors |
| `ThemeAliases` | GEN-085 | Register public typedef names (if generator fix deferred) |

### Priority Order

| Priority | Issues | Approach | Impact |
|----------|--------|----------|--------|
| **High** | GEN-085, GEN-086 | Generator fix | Unblocks 6 tests |
| **High** | ENG-001 | Bridge-side collection casting | Unblocks 3 tests |
| **Medium** | GEN-087, GEN-088 | Generator fix + config | Unblocks 3 tests |
| **Medium** | ENG-002, ENG-003 | UserBridge helpers | Unblocks 2 tests |
| **Medium** | GEN-091 | Extended switch or UserBridge | Restores workaround sections |
| **Low** | GEN-089, GEN-090 | Investigation needed | Unblocks 2 tests |
| **Low** | ENG-004, ENG-005 | typed_data bridges | Workaround already applied |

---

## Resolved Issues Archive

All previously tracked issues (GEN-078 through GEN-082, G-DOV-8, G-FLP-54/55/57, G-FBI-04/12/21/22/32/33/34/40, G-NUM-11/12/15/26/27/31) have been resolved as of 2026-03-02. See git history for details.

| Category | Count | IDs |
|----------|-------|-----|
| Fixed (generator) | 5 | GEN-078, GEN-079, GEN-080, GEN-082, G-FLP-54 |
| Fixed (runtime) | 2 | GEN-081, I-BUG-14b |
| Fixed (interpreter) | 1 | G-DOV-8 |
| Closed (by design) | 2 | G-FLP-55, G-FLP-57 |
| Verified (already work) | 14 | G-FBI-04, G-FBI-12, G-FBI-21, G-FBI-22, G-FBI-32, G-FBI-33, G-FBI-34, G-FBI-40, G-NUM-11, G-NUM-12, G-NUM-15, G-NUM-26, G-NUM-27, G-NUM-31 |

---

## Known Limitations (not generator issues)

- **I-BUG-14a** (records with named fields) — **Dart language limitation.** Native records with named fields cannot be constructed dynamically at runtime. The interpreter returns `InterpretedRecord` which has the correct data but doesn't pass `isA<({int x, int y})>()` type checks.
- **G-DOV2-7** (extension on enum type resolution) — Interpreter issue, not tracked in this generator issues file.
