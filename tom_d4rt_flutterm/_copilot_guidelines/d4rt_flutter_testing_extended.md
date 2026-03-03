# D4rt Flutter Testing — Extended Strategies

This document catalogs all problematic test cases discovered during the essential and important test tiers, explains why they are problematic, and proposes test strategies grouped by solution approach.

> **Note:** This document also serves as the foundation for a future **D4rt Flutter Developer Guide** that will document known limitations (e.g., D4rt scripts cannot subclass abstract Flutter classes) and recommended workarounds for each pattern. The test strategies here directly map to the patterns developers will need to follow.

## Table of Contents

- [D4rt Flutter Testing — Extended Strategies](#d4rt-flutter-testing--extended-strategies)
  - [Table of Contents](#table-of-contents)
  - [1. Background](#1-background)
  - [2. Problem Categories](#2-problem-categories)
  - [3. Catalog of Problematic Cases](#3-catalog-of-problematic-cases)
    - [3.1 Abstract Classes (No Constructor Bridge)](#31-abstract-classes-no-constructor-bridge)
    - [3.2 Render Objects](#32-render-objects)
    - [3.3 dart:ui Drawing Primitives](#33-dartui-drawing-primitives)
    - [3.4 Platform Services (Static-Only)](#34-platform-services-static-only)
    - [3.5 Semantics Internals](#35-semantics-internals)
    - [3.6 Abstract Delegates (User-Implementable)](#36-abstract-delegates-user-implementable)
    - [3.7 Global Functions (show\*)](#37-global-functions-show)
    - [3.8 Framework-Created State Objects](#38-framework-created-state-objects)
    - [3.9 Controllers Requiring TickerProvider](#39-controllers-requiring-tickerprovider)
    - [3.10 Image Providers Requiring I/O](#310-image-providers-requiring-io)
    - [3.11 Soft Gaps (Marked Created But Incomplete)](#311-soft-gaps-marked-created-but-incomplete)
    - [3.12 Callback Signature Patterns](#312-callback-signature-patterns)
  - [4. Test Strategy Groups](#4-test-strategy-groups)
    - [Strategy A: Test App Canvas/Render Endpoint](#strategy-a-test-app-canvasrender-endpoint)
    - [Strategy B: Test Indirectly via Concrete Subclass](#strategy-b-test-indirectly-via-concrete-subclass)
    - [Strategy C: Test via Framework Accessors (.of/.state)](#strategy-c-test-via-framework-accessors-ofstate)
    - [Strategy D: Test App Provides Pre-Built Instances](#strategy-d-test-app-provides-pre-built-instances)
    - [Strategy E: Test via Widget Wrapping (Theme/Data)](#strategy-e-test-via-widget-wrapping-themedata)
    - [Strategy F: Test via Global Function Calls](#strategy-f-test-via-global-function-calls)
    - [Strategy G: Test App TickerProvider Endpoint](#strategy-g-test-app-tickerprovider-endpoint)
    - [Strategy H: Standard Script (Already Testable)](#strategy-h-standard-script-already-testable)
    - [Strategy I: Bridge Generator Enhancement](#strategy-i-bridge-generator-enhancement)
    - [Strategy J: Test via /execute Endpoint (Non-Widget)](#strategy-j-test-via-execute-endpoint-non-widget)
    - [Strategy K: No User-Facing Need (Framework Internals)](#strategy-k-no-user-facing-need-framework-internals)
  - [5. Implementation Priority](#5-implementation-priority)
    - [Phase 1: No Test App Changes (Highest Priority)](#phase-1-no-test-app-changes-highest-priority)
    - [Phase 2: Minor Test App Extensions](#phase-2-minor-test-app-extensions)
    - [Phase 3: Test App Canvas/Render Endpoint](#phase-3-test-app-canvasrender-endpoint)
    - [Phase 4: Bridge Generator Enhancement (Lowest Priority)](#phase-4-bridge-generator-enhancement-lowest-priority)
    - [Skipped — Framework Internals (Strategy K)](#skipped--framework-internals-strategy-k)
    - [Total Coverage Estimate](#total-coverage-estimate)

---

## 1. Background

The D4rt Flutter test framework uses an HTTP-driven Flutter test app that:

1. Accepts D4rt script bundles via `POST /build` (widget rendering) or `POST /execute` (non-visual evaluation)
2. Scripts define `dynamic build(BuildContext context)` — the `BuildContext` comes from the test app's widget tree
3. The returned Widget is embedded directly in the app's Scaffold body
4. `print()` output is captured and returned with the HTTP response

**Current limitation:** Scripts can only return Widgets for the `/build` endpoint or arbitrary values for `/execute`. The test app does not currently provide:
- Canvas/PaintingContext for direct render-layer testing
- TickerProvider for animation controllers
- Pre-built abstract class instances
- Overlay/dialog dismissal after `show*` calls

**Bridge status:** All classes in this document are bridged. The issue is never "no bridge exists" but rather "the bridge can't construct the class" (abstract) or "the test environment doesn't provide the right context" (needs Canvas, TickerProvider, etc.).

---

## 2. Problem Categories

| Category | Count | Root Cause |
|----------|-------|-----------|
| Abstract classes (no constructor) | 12 | Bridge has empty `constructors: {}` |
| Render objects | ~70 | Need render tree context, not widget tree |
| dart:ui drawing | 5 | Need Canvas/PictureRecorder context |
| Platform services (static-only) | 10 | Require platform channels, some may work |
| Semantics internals | 5 | Low-level accessibility tree |
| Abstract delegates (user-implementable) | 6 | Cannot subclass from D4rt |
| Global functions (show*) | 7 | Need BuildContext + trigger modal overlays |
| Framework-created state objects | 5 | Cannot instantiate directly |
| Controllers needing TickerProvider | 2 | Need vsync parameter |
| Image providers needing I/O | 4 | Need file/network/asset access |
| Soft gaps (marked created, incomplete) | 2 | Script doesn't actually test the class |
| Callback signatures | 0 | NOT a bridge issue (verified correct) |

---

## 3. Catalog of Problematic Cases

### 3.1 Abstract Classes (No Constructor Bridge)

These classes are bridged but have `constructors: {}` because they are abstract in Flutter SDK.

| Class | Library | Bridge File | Concrete Subclass Available |
|-------|---------|-------------|---------------------------|
| `AnimatedWidget` | widgets | widgets_bridges.b.dart | Yes: `AnimatedBuilder`, `FadeTransition`, `SlideTransition`, etc. |
| `Route` | widgets | widgets_bridges.b.dart | Yes: `MaterialPageRoute`, `CupertinoPageRoute` |
| `ModalRoute` | widgets | widgets_bridges.b.dart | Yes: `MaterialPageRoute`, `DialogRoute` |
| `PageRoute` | widgets | widgets_bridges.b.dart | Yes: `MaterialPageRoute`, `CupertinoPageRoute` |
| `PopupRoute` | widgets | widgets_bridges.b.dart | Yes: via `showMenu`, `showDialog` |
| `RenderBox` | rendering | rendering_bridges.b.dart | Yes: `RenderFlex`, `RenderParagraph`, etc. |
| `RenderObject` | rendering | rendering_bridges.b.dart | Yes: all render objects |
| `Gradient` (painting) | painting | painting_bridges.b.dart | Yes: `LinearGradient`, `RadialGradient`, `SweepGradient` |
| `Simulation` | physics | physics_bridges.b.dart | Yes: `SpringSimulation`, `FrictionSimulation` |
| `ImageProvider` | painting | painting_bridges.b.dart | Yes: `AssetImage`, `NetworkImage`, `MemoryImage`, `FileImage` |
| `CustomPainter` | rendering | rendering_bridges.b.dart | No D4rt subclass possible (see §3.6) |
| `CustomClipper` | rendering | rendering_bridges.b.dart | No D4rt subclass possible (see §3.6) |

**Why:** The bridge generator correctly skips constructors for abstract classes. Getters and methods are available — if you have an instance, you can call methods on it.

### 3.2 Render Objects

These classes operate at the render layer, below the widget tree. The current test app only embeds widgets.

**From essential testplan (marked not-testable):**

| Class | Bridge Status | Notes |
|-------|-------------|-------|
| `RenderBox` | Getter-only (abstract) | Base class for box render objects |
| `RenderObject` | Getter-only (abstract) | Base class for all render objects |
| `RenderFlex` | **Has constructor** | Implements Row/Column layout |
| `RenderStack` | Has constructor (essential) | Implements Stack layout |
| `RenderPadding` | Has constructor (essential) | Implements Padding |
| `RenderPositionedBox` | Has constructor (essential) | Implements Align/Center |
| `RenderConstrainedBox` | Has constructor (essential) | Implements ConstrainedBox |
| `RenderDecoratedBox` | Has constructor (essential) | Implements DecoratedBox |
| `PaintingContext` | **Has constructor** | Provides canvas for painting |
| `PipelineOwner` | **Has constructor** | Manages render pipeline |
| `ViewConfiguration` | Has constructor (essential) | View parameters |

**From important testplan (unimplemented):**

| Class | Bridge Status | Notes |
|-------|-------------|-------|
| `RenderProxyBox` | **Has constructor** | Base for single-child render objects |
| `RenderOpacity` | Has constructor | opacity property |
| `RenderParagraph` | **Has constructor** (with `textScaler` overload) | Text rendering |
| `RenderImage` | Has constructor | Image rendering |
| `RenderTransform` | Has constructor | Transform matrix |
| `RenderClipRect` | Has constructor | Rectangular clipping |
| `RenderClipRRect` | Has constructor | Rounded rect clipping |
| `RenderClipOval` | Has constructor | Oval clipping |
| `RenderClipPath` | Has constructor | Path clipping |
| `RenderFittedBox` | Has constructor | Fitted box scaling |
| `RenderShiftedBox` | Getter-only (abstract) | Base for shifted children |
| `RenderSliver` | Getter-only (abstract) | Base sliver class |
| `RenderSliverGrid` | Has constructor | Grid sliver layout |
| `RenderSliverList` | Has constructor | List sliver layout |
| `RenderSliverOpacity` | Has constructor | Opacity for slivers |
| `RenderSliverPadding` | Has constructor | Padding for slivers |
| `RenderTable` | Has constructor | Table layout |
| `RenderWrap` | Has constructor | Wrap layout |
| `RenderFlow` | Has constructor | Flow layout |
| `RenderViewport` | Has constructor | Scrollable viewport |
| `RenderView` | Has constructor | Root render object |
| `RenderAspectRatio` | Has constructor | Aspect ratio enforcement |
| `RenderIntrinsicHeight` | Has constructor | Intrinsic height sizing |
| `RenderIntrinsicWidth` | Has constructor | Intrinsic width sizing |
| `RenderLimitedBox` | Has constructor | Size limiter |
| `RenderListBody` | Has constructor | List body layout |

**Why:** Render objects are not Widgets — they can't be returned from `build()`. They need a render tree context (parent render object, constraints) to be tested meaningfully. Many have constructors so they CAN be instantiated, but they crash without proper parent attachment and layout.

### 3.3 dart:ui Drawing Primitives

| Class | Bridge Status | Notes |
|-------|-------------|-------|
| `Canvas` | **Has constructor** (takes `PictureRecorder` + optional `Rect`) | Bridged and constructable |
| `PictureRecorder` | **Has constructor** | Default constructor |
| `Picture` | No constructor (factory-produced) | Obtained from `PictureRecorder.endRecording()` |
| `Image` (dart:ui) | No constructor | Obtained from `Picture.toImage()` or codecs |
| `Vertices` | Has constructor | Custom vertex drawing for `Canvas.drawVertices()` |

**Why (essential):** Marked not-testable because scripts return Widgets via `/build`. But Canvas/PictureRecorder ARE bridged with constructors — they could be tested via `/execute` or a new Canvas-specific endpoint.

### 3.4 Platform Services (Static-Only)

These classes have `constructors: {}` because they are static-utility classes (no instances needed).

**From essential testplan (marked not-testable):**

| Class | Bridge Status | Reason Marked Not-Testable |
|-------|-------------|---------------------------|
| `Clipboard` | Static methods bridged (`setData`, `getData`) | "Requires platform channel" |
| `ClipboardData` | Has constructor | Data container for clipboard |
| `SystemChrome` | Static methods bridged | "Requires platform channel" |
| `SystemNavigator` | Static methods bridged | "Requires platform channel" |
| `SystemSound` | Static methods bridged | "Requires platform channel" |
| `HapticFeedback` | Static methods bridged | "Requires platform channel" |
| `AssetBundle` | Abstract (getter-only) | "Requires platform channel" |
| `MethodChannel` | **Has constructor** | "Requires platform channel" |
| `MethodCall` | Has constructor | "Requires platform channel" |

**From important testplan:**

| Class | Bridge Status | Notes |
|-------|-------------|-------|
| `BasicMessageChannel` | Has constructor | Platform messaging |
| `EventChannel` | Has constructor | Platform event streams |
| `OptionalMethodChannel` | Has constructor | Optional methods |
| `StandardMessageCodec` | Has constructor | Message encoding |
| `StandardMethodCodec` | Has constructor | Method encoding |
| `JSONMessageCodec` | Has constructor | JSON encoding |
| `JSONMethodCodec` | Has constructor | JSON sessions |
| `StringCodec` | Has constructor | String encoding |
| `BinaryCodec` | Has constructor | Binary encoding |
| `SystemUiOverlayStyle` | Has constructor | Status bar config |
| `HardwareKeyboard` | Static/singleton | Keyboard events |

**Why:** Platform services call native code via MethodChannel. In the Flutter test app environment, many of these will actually work (the app has a real platform layer). The "not-testable" classification may be overly conservative — we should re-evaluate.

### 3.5 Semantics Internals

| Class | Bridge Status | Source |
|-------|-------------|--------|
| `SemanticsNode` | **Has constructor** | Essential (not-testable) |
| `SemanticsData` | **Has constructor** | Important |
| `SemanticsOwner` | **Has constructor** (needs callback) | Important |
| `SemanticsHintOverrides` | Has constructor | Important |
| `SemanticsService` | Static-only | Important |
| `SemanticsSortKey` | Getter-only (abstract) | Important |
| `OrdinalSortKey` | Has constructor | Important |
| `SemanticsTag` | Has constructor | Important |

**Why:** SemanticsNode was marked not-testable in the essential tier as "Low-level semantics API". But it HAS a bridged constructor. The real issue is that meaningful testing requires an actual widget tree with semantics enabled, and verifying semantics output.

### 3.6 Abstract Delegates (User-Implementable)

These are abstract classes designed to be subclassed by app developers. The bridge generator correctly does not generate constructors (they're abstract), and D4rt has no subclassing mechanism.

| Class | Abstract Methods | Used By |
|-------|-----------------|---------|
| `CustomPainter` | `paint(Canvas, Size)`, `shouldRepaint()` | `CustomPaint.painter` |
| `CustomClipper` | `getClip(Size)`, `shouldReclip()` | `ClipRect`, `ClipRRect`, `ClipPath` |
| `FlowDelegate` | `paintChildren()`, `shouldRelayout()`, `getSize()` | `Flow` |
| `MultiChildLayoutDelegate` | `performLayout()`, `hasChild()` | `CustomMultiChildLayout` |
| `SingleChildLayoutDelegate` | `getConstraintsForChild()`, `getPositionForChild()` | `CustomSingleChildLayout` |
| `FocusTraversalPolicy` | `sortDescendants()` | `FocusTraversalGroup` |

**Why:** These require D4rt to define a class that implements abstract methods. The current D4rt interpreter does not support defining new classes that extend native abstract classes. The bridge can only call methods on existing native instances.

### 3.7 Global Functions (show*)

All are bridged as top-level functions in `material_widgets_bridges.b.dart`.

| Function | Required Params | Returns |
|----------|----------------|---------|
| `showDialog` | `context`, `builder: (ctx) => Widget` | `Future<T?>` |
| `showModalBottomSheet` | `context`, `builder: (ctx) => Widget` | `Future<T?>` |
| `showBottomSheet` | `context`, `builder: (ctx) => Widget` | `PersistentBottomSheetController` |
| `showMenu` | `context`, `items: List<PopupMenuEntry>`, `position: RelativeRect` | `Future<T?>` |
| `showDatePicker` | `context`, `initialDate`, `firstDate`, `lastDate` | `Future<DateTime?>` |
| `showTimePicker` | `context`, `initialTime` | `Future<TimeOfDay?>` |
| `showSearch` | `context`, `delegate: SearchDelegate` | `Future<T?>` |

**Why:** These functions are callable from D4rt scripts (the `BuildContext` is available from `build()`). However:
1. They return Futures — the build function is synchronous
2. They trigger persistent overlays (dialogs, sheets) that remain visible
3. `showSearch` requires a `SearchDelegate` instance (abstract — same as §3.6)
4. The test result for the HTTP response is the Widget returned from `build()`, not the dialog

### 3.8 Framework-Created State Objects

These State objects are created internally by Flutter's framework, not by user code.

| Class | Bridge Status | How to Obtain |
|-------|-------------|--------------|
| `NavigatorState` | Has constructor (but framework creates it) | `Navigator.of(context)` — bridged |
| `FormState` | Has constructor (but framework creates it) | `Form.of(context)` or GlobalKey |
| `FormFieldState` | Has constructor (but framework creates it) | `FormField.of(context)` or GlobalKey |
| `ScaffoldState` | Has constructor | `Scaffold.of(context)` |
| `ScaffoldMessengerState` | Has constructor | `ScaffoldMessenger.of(context)` |

**Why:** While bridges have constructors, directly instantiating a State object is meaningless — it won't be attached to a widget or element tree. The correct way to test is to embed the parent widget (Navigator, Form, Scaffold) and access its state via `.of(context)` or GlobalKey.

### 3.9 Controllers Requiring TickerProvider

| Class | Bridge Status | Missing Dependency |
|-------|-------------|-------------------|
| `TabController` | **Has constructor** — requires `length` + `vsync` | `TickerProvider` (typically `SingleTickerProviderStateMixin`) |
| `AnimationController` | Has constructor — requires `vsync` | Same |

**Why:** The `vsync` parameter must be a `TickerProvider`. In Flutter, this comes from a `StatefulWidget` with `SingleTickerProviderStateMixin`. D4rt scripts cannot mix in this mixin. However, `DefaultTabController` IS bridged and wraps a `TabController` internally.

### 3.10 Image Providers Requiring I/O

| Class | Bridge Status | I/O Requirement |
|-------|-------------|----------------|
| `AssetImage` | **Has constructor** | Needs Flutter asset bundle (works in test app!) |
| `NetworkImage` | **Has constructor** | Needs network access (works in test app!) |
| `FileImage` | **Has constructor** | Needs file system access |
| `MemoryImage` | **Has constructor** | Needs `Uint8List` of image bytes |
| `ExactAssetImage` | Has constructor | Needs Flutter asset bundle |
| `DecorationImage` | Has constructor | Needs an `ImageProvider` |

**Why (essential):** Marked not-testable as "D4rt sandbox lacks asset/network access". But the test app IS a real Flutter app — it HAS an asset bundle and network access. The D4rt script runs inside the app's process. `AssetImage('icon.png')` would resolve against the test app's pubspec assets. `NetworkImage('https://...')` would make real HTTP requests. These may actually work.

### 3.11 Soft Gaps (Marked Created But Incomplete)

| Class | Testplan Entry | Actual Script Coverage | Issue |
|-------|---------------|----------------------|-------|
| `StatefulBuilder` | `widgets/builder_test.dart` — marked `created` | Script only tests `Builder`, NOT `StatefulBuilder` | Missing test code |
| `AnimatedWidget` | `widgets/animatedbuilder_test.dart` — marked `created` | Script tests `AnimatedBuilder` (concrete subclass) | Abstract — only indirectly tested |

### 3.12 Callback Signature Patterns

**Investigation result: NOT a bridge issue.**

The `CreateRectTween?` typedef pattern in `hero_test.dart` was investigated:
- Flutter SDK typedef: `typedef CreateRectTween = Tween<Rect?> Function(Rect? begin, Rect? end)`
- Bridge code correctly emits: `(Rect? p0, Rect? p1)` matching the SDK
- The fix from `(Rect begin, Rect end)` to `(Rect? begin, Rect? end)` was a **script authoring error**, not a bridge issue

Other callback patterns verified correct:
- `WidgetBuilder`: `Widget Function(BuildContext)` ✓
- `TransitionBuilder`: `Widget Function(BuildContext, Widget?)` ✓
- `StatefulWidgetBuilder`: `Widget Function(BuildContext, void Function(void Function()))` ✓ (StateSetter correctly expanded)

---

## 4. Test Strategy Groups

### Strategy A: Test App Canvas/Render Endpoint

**Target:** Render objects, Canvas, PictureRecorder, PaintingContext, Picture, Vertices

**Approach:** Add a new `/render` endpoint to the test app that:
1. Accepts a D4rt script with a `dynamic render(Canvas canvas, Size size)` function
2. Creates a `PictureRecorder` + `Canvas` and passes them to the script
3. Script draws on the canvas, then the endpoint calls `endRecording()` to get a `Picture`
4. Returns success/failure + captured print output
5. Optionally: convert `Picture` to `Image` for screenshot comparison

**Test script pattern:**
```dart
import 'dart:ui';
dynamic render(Canvas canvas, Size size) {
  final paint = Paint()..color = Color(0xFFFF0000);
  canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  print('Drew red rectangle ${size.width}x${size.height}');
  return 'ok';
}
```

**Alternatively, for render objects:** Add a `/layout` endpoint that:
1. Creates a `PipelineOwner` and a root `RenderView`
2. Accepts a D4rt script with `dynamic layout(PipelineOwner owner)` or similar
3. Script creates render objects, attaches them to the tree, and triggers layout
4. Returns render object properties (size, offset) for validation

**Classes enabled (~30+):**

| Class | Test Pattern |
|-------|-------------|
| `Canvas` | Direct — construct PictureRecorder + Canvas, call draw methods |
| `PictureRecorder` | Direct — construct, record, endRecording |
| `Picture` | Indirect — result of endRecording |
| `Vertices` | Direct — construct, pass to Canvas.drawVertices |
| `Image` (dart:ui) | Indirect — `picture.toImage(w, h)` |
| `RenderFlex` | Layout — construct with children, `layout(constraints)` |
| `RenderParagraph` | Layout — construct with `TextSpan`, check `size` |
| `RenderProxyBox` | Layout — construct, attach child |
| `RenderOpacity`, `RenderTransform`, `RenderClipRect`, ... | Layout — construct, attach, layout |
| `PaintingContext` | Advanced — construct for manual painting |
| `RenderView` | Root of layout tree |
| `PipelineOwner` | Manages the render pipeline |
| `SliverConstraints`, `SliverGeometry` | Data classes for sliver layout |

### Strategy B: Test Indirectly via Concrete Subclass

**Target:** Abstract classes with bridged concrete subclasses

**Approach:** Test the abstract class by instantiating a concrete subclass and verifying that inherited methods/getters work correctly.

| Abstract Class | Test Via | Verifiable Members |
|---------------|----------|-------------------|
| `AnimatedWidget` | `AnimatedBuilder`, `FadeTransition` | `.listenable` getter |
| `Route` | `MaterialPageRoute` | `.settings` getter |
| `ModalRoute` | `MaterialPageRoute` (with Navigator) | `.canPop`, `.isCurrent` |
| `PageRoute` | `MaterialPageRoute` | `.fullscreenDialog` |
| `Gradient` | `LinearGradient`, `RadialGradient` | `.colors`, `.createShader()` |
| `Simulation` | `SpringSimulation`, `FrictionSimulation` | `.x()`, `.dx()`, `.isDone()` |
| `ImageProvider` | `MemoryImage` or `NetworkImage` | `.resolve()` |
| `RenderBox` | Any concrete render object | `.size`, `.constraints` (via Strategy A) |
| `RenderObject` | Any concrete render object | `.debugCreator`, `.depth` (via Strategy A) |
| `RenderShiftedBox` | Concrete subclasses | `.child` getter |
| `RenderSliver` | `RenderSliverList` etc. | `.geometry` getter |

**Script pattern:**
```dart
import 'package:flutter/material.dart';
dynamic build(BuildContext context) {
  // Test via concrete subclass
  final gradient = LinearGradient(colors: [Colors.red, Colors.blue]);
  print('Gradient colors: ${gradient.colors}');
  print('Gradient type: ${gradient.runtimeType}');
  // Test abstract method via concrete subclass
  final shader = gradient.createShader(Rect.fromLTWH(0, 0, 100, 100));
  print('Shader created: ${shader.runtimeType}');
  return Container(decoration: BoxDecoration(gradient: gradient));
}
```

### Strategy C: Test via Framework Accessors (.of/.state)

**Target:** State objects, NavigatorState, FormState, ScaffoldState

**Approach:** Build a widget tree that creates the state, then access it via `.of(context)` or `GlobalKey`.

| Class | Access Pattern | Setup Widget |
|-------|---------------|-------------|
| `NavigatorState` | `Navigator.of(context)` | Already in tree (test app has MaterialApp -> Navigator) |
| `FormState` | Use `GlobalKey<FormState>` | Build `Form(key: formKey, child: ...)` |
| `FormFieldState` | Use `GlobalKey<FormFieldState>` | Build `TextFormField(key: fieldKey)` |
| `ScaffoldState` | `Scaffold.of(context)` | Already in tree (test app has Scaffold) |
| `ScaffoldMessengerState` | `ScaffoldMessenger.of(context)` | Already in tree |

**Script pattern:**
```dart
import 'package:flutter/material.dart';
dynamic build(BuildContext context) {
  // NavigatorState is already available — test app wraps in MaterialApp
  final navigator = Navigator.of(context);
  print('NavigatorState obtained: ${navigator.runtimeType}');
  print('Navigator canPop: ${navigator.canPop()}');
  
  // ScaffoldMessengerState also available
  final messenger = ScaffoldMessenger.of(context);
  print('ScaffoldMessengerState: ${messenger.runtimeType}');
  
  return Container(child: Text('State access test'));
}
```

**Note:** For `FormState`, the script must return a `Form` widget wrapping `TextFormField` and access will happen in a nested `Builder`:
```dart
dynamic build(BuildContext context) {
  final formKey = GlobalKey();
  return Form(
    key: formKey,
    child: Builder(builder: (formContext) {
      final formState = Form.of(formContext);
      print('FormState: $formState');
      return TextFormField();
    }),
  );
}
```

**Caveat:** `GlobalKey` must be bridged for this pattern to work. Needs verification.

### Strategy D: Test App Provides Pre-Built Instances

**Target:** Abstract delegates (CustomPainter, CustomClipper, FlowDelegate, etc.)

**Approach:** The test app registers pre-built native implementations that D4rt scripts can reference, OR introduces a new endpoint that wraps the script's return value in the needed context.

**Option D1: Named native instances**
The test app pre-registers several named `CustomPainter` instances (e.g., a red-circle painter, a grid painter) in the D4rt interpreter scope. Scripts reference them by name.

```dart
// In test app: register native instances
d4rt.registerGlobal('redCirclePainter', _RedCirclePainter());
d4rt.registerGlobal('gridPainter', _GridPainter());

// In D4rt script:
dynamic build(BuildContext context) {
  return CustomPaint(painter: redCirclePainter, child: ...);
}
```

**Option D2: Bridge generator creates proxy subclass**
The bridge generator could emit a `D4rtCustomPainter` class that delegates `paint()` and `shouldRepaint()` to D4rt callbacks. This is a bridge generator enhancement (see Strategy I).

| Class | Option | Notes |
|-------|--------|-------|
| `CustomPainter` | D1 or D2 | D2 is more powerful but complex |
| `CustomClipper` | D1 or D2 | Clips to paths/rects |
| `FlowDelegate` | D1 | Complex — `paintChildren` receives `FlowPaintingContext` |
| `MultiChildLayoutDelegate` | D1 | Complex — receives `LayoutConstraints` |
| `SingleChildLayoutDelegate` | D1 | Simpler version of multi |

### Strategy E: Test via Widget Wrapping (Theme/Data)

**Target:** ThemeData, TextTheme, ColorScheme, all `*Theme` data classes, styling/decoration classes

**Approach:** These are data classes that configure widgets. Test by constructing them and wrapping them in their associated widget.

| Class Group | Test Pattern |
|-------------|-------------|
| `ThemeData`, `TextTheme`, `ColorScheme`, `AppBarTheme`, `CardTheme`, etc. | Construct `ThemeData(...)`, wrap in `Theme(data: ..., child: ...)` |
| `CupertinoThemeData`, `CupertinoIconThemeData`, etc. | Construct data, wrap in `CupertinoTheme(data: ..., child: ...)` |
| `ButtonThemeData`, `IconButtonTheme`, `TextButtonTheme`, etc. | Construct, wrap in `theme: ThemeData(extensions: [...])` |
| `LinearGradient`, `RadialGradient`, `SweepGradient` | Use in `BoxDecoration(gradient: ...)` |
| `Border`, `BorderSide`, `BoxShadow` | Use in `BoxDecoration(border: ..., boxShadow: [...])` |
| `ShapeDecoration`, `RoundedRectangleBorder`, `BeveledRectangleBorder`, etc. | Use in `DecoratedBox` or button shapes |
| `StrutStyle` | Use in `Text(strutStyle: ...)` |
| `TextDecoration` | Use in `TextStyle(decoration: ...)` |
| `SystemUiOverlayStyle` | Use in `AnnotatedRegion` |
| `Matrix4` | Use in `Transform(transform: ...)` |
| `FontFeature`, `FontVariation` | Use in `TextStyle(fontFeatures: [...])` |

**This is the largest single group** (~90 theme data classes + ~20 styling classes). These are straightforward scripts — construct the data object, print its properties, use it in a widget.

**Script pattern:**
```dart
import 'package:flutter/material.dart';
dynamic build(BuildContext context) {
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.teal);
  print('ColorScheme primary: ${colorScheme.primary}');
  print('ColorScheme surface: ${colorScheme.surface}');
  
  final theme = ThemeData(colorScheme: colorScheme);
  print('ThemeData brightness: ${theme.brightness}');
  
  return Theme(data: theme, child: Builder(builder: (ctx) {
    final resolved = Theme.of(ctx);
    print('Resolved primary: ${resolved.colorScheme.primary}');
    return Card(child: Text('Theme test'));
  }));
}
```

### Strategy F: Test via Global Function Calls

**Target:** `showDialog`, `showModalBottomSheet`, `showBottomSheet`, `showMenu`, `showDatePicker`, `showTimePicker`

**Approach:** Call the function from within `build()` after a post-frame callback, or use a button tap simulation. The returned Future completes when the dialog is dismissed.

**Option F1: Fire-and-forget + return the main widget**
Script calls the show function and returns a widget. The dialog appears as an overlay. The test verifies the function didn't throw. No dismissal needed.

```dart
import 'package:flutter/material.dart';
dynamic build(BuildContext context) {
  // Schedule the dialog to show after the build completes
  // (can't show during build itself)
  Future.microtask(() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(title: Text('Test'), content: Text('It works')),
    );
  });
  print('showDialog scheduled');
  return Container(child: Text('showDialog test'));
}
```

**Option F2: Test app `/build-and-show` endpoint**
A new endpoint that:
1. Executes the build function
2. Waits for a frame
3. Checks if an overlay was shown
4. Optionally dismisses it (Navigator.pop)
5. Returns result including overlay info

**Option F3: Use `/execute` for non-widget show functions**
For `showDatePicker`, `showTimePicker` which return Futures, the `/execute` endpoint could be used if we provide a BuildContext from the test app.

| Function | Recommended Approach |
|----------|---------------------|
| `showDialog` | F1 (fire-and-forget) |
| `showModalBottomSheet` | F1 |
| `showBottomSheet` | F1 (via `Scaffold.of(context)`) |
| `showMenu` | F1 |
| `showDatePicker` | F1 |
| `showTimePicker` | F1 |
| `showSearch` | Skip — requires abstract `SearchDelegate` (see §3.6) |

**Note:** The `context` in `build()` may not have a `Scaffold` ancestor for `showBottomSheet`. Wrapping in `Builder` nested inside the returned Scaffold may be needed.

### Strategy G: Test App TickerProvider Endpoint

**Target:** `TabController`, `AnimationController`

**Approach:** Two options:

**G1: Use `DefaultTabController` (easiest)**
`DefaultTabController` is fully bridged and wraps `TabController` internally. Scripts can use it without needing a TickerProvider.

```dart
import 'package:flutter/material.dart';
dynamic build(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Builder(builder: (ctx) {
      final controller = DefaultTabController.of(ctx);
      print('TabController length: ${controller.length}');
      print('TabController index: ${controller.index}');
      return TabBar(tabs: [Tab(text: 'A'), Tab(text: 'B'), Tab(text: 'C')]);
    }),
  );
}
```

**G2: Test app provides TickerProvider**
The test app could register a native `TickerProvider` instance in the D4rt scope:
```dart
// In test app (StatefulWidget with SingleTickerProviderStateMixin):
d4rt.registerGlobal('tickerProvider', this); // 'this' implements TickerProvider
```

Then scripts:
```dart
final controller = TabController(length: 3, vsync: tickerProvider);
```

| Class | Recommended |
|-------|------------|
| `TabController` | G1 (use `DefaultTabController`) |
| `AnimationController` | G2 (provide TickerProvider) or skip (animation tested via AlwaysStoppedAnimation) |
| `PageController` | Direct — no vsync needed, has its own constructor |

### Strategy H: Standard Script (Already Testable)

**Target:** Many classes currently in the unimplemented list that are actually testable with the existing test infrastructure.

These just need scripts written — no test app changes required:

| Category | Classes | Script Pattern |
|----------|---------|---------------|
| **Cupertino widgets** | `CupertinoPicker`, `CupertinoDatePicker`, `CupertinoTimerPicker`, `CupertinoMagnifier`, `CupertinoMenuAnchor`, `CupertinoMenuItem`, `CupertinoRefreshSliver`, etc. | Standard widget return from `build()` |
| **Material widgets** | `Stepper`, `PaginatedDataTable`, `DataTable`, `ExpansionTile`, `Badge`, `MenuBar`, `Ink`, `CalendarDatePicker`, etc. | Standard widget return |
| **Animation** | `AlwaysStoppedAnimation`, `CompoundAnimation`, `TweenSequence`, `TweenSequenceItem`, `ProxyAnimation`, `ReverseAnimation`, `TrainHoppingAnimation`, `AnimationStyle` | Construct, access properties, use in widget |
| **Painting data** | `Border`, `BorderSide`, `BoxShadow`, `ColorSwatch`, `HSLColor`, `HSVColor`, `FractionalOffset`, `RelativeRect`, `MaskFilter`, `ColorFilter`, `ImageFilter` | Construct, verify properties, use in decoration |
| **Text** | `TextSelection`, `TextRange`, `TextPosition`, `TextHeightBehavior`, `TextScaler`, `TextEditingDelta`, `TextAlignVertical`, `AttributedString` | Construct, access properties |
| **Error handling** | `FlutterError`, `FlutterErrorDetails`, `ErrorDescription`, `ErrorHint`, `ErrorSummary` | Construct, access properties via `/execute` |
| **Physics** | `SpringSimulation`, `FrictionSimulation`, `ScrollSpringSimulation` | Construct, call `.x(t)`, `.dx(t)`, `.isDone(t)` via `/execute` |
| **Routing data** | `RouteSettings`, `MaterialPageRoute` | Construct, read properties |
| **Layout delegates/data** | `FixedColumnWidth`, `FlexColumnWidth`, `IntrinsicColumnWidth`, `FlexParentData`, `StackParentData`, `SliverGridDelegateWithFixedCrossAxisCount`, `SliverGridDelegateWithMaxCrossAxisExtent` | Construct via widget params |
| **Gestures data** | `Velocity`, `ForcePressDetails` | Construct, read properties via `/execute` |
| **Miscellaneous** | `ErrorDescription`, `DiagnosticsNode`, `DiagnosticPropertiesBuilder`, `FlutterLogo` | Various |
| **Localization** | `DefaultCupertinoLocalizations`, `DefaultWidgetsLocalizations`, `Localizations` | Access via `Localizations.of(context)` |
| **License** | `LicensePage`, `LicenseEntry`, `LicenseRegistry` | Build `LicensePage` widget |
| **Keyboard** | `LogicalKeyboardKey`, `PhysicalKeyboardKey` | Access static constants |

### Strategy I: Bridge Generator Enhancement

**Target:** Abstract delegate classes that could benefit from proxy class generation

**Approach:** The bridge generator could be enhanced to emit proxy/adapter subclasses for select abstract classes, allowing D4rt scripts to provide callback implementations.

| Class | Generated Proxy Would Need | Priority |
|-------|---------------------------|----------|
| `CustomPainter` | `paint(Canvas, Size)`, `shouldRepaint(CustomPainter)` → D4rt callbacks | High — CustomPaint is important |
| `CustomClipper<T>` | `getClip(Size)`, `shouldReclip(CustomClipper)` → D4rt callbacks | Medium |
| `FlowDelegate` | `paintChildren(FlowPaintingContext)`, `shouldRelayout()`, `shouldRepaint()` | Low |
| `MultiChildLayoutDelegate` | `performLayout(Size)` | Low |
| `SingleChildLayoutDelegate` | `getConstraintsForChild()`, `getPositionForChild()` | Low |
| `SearchDelegate` | `buildSuggestions()`, `buildResults()`, `buildLeading()`, `buildActions()` | Low |

**Implementation approach:**
```dart
// Generated by bridge generator:
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

This enables scripts like:
```dart
final painter = D4rtCustomPainter(
  onPaint: (canvas, size) {
    canvas.drawCircle(Offset(size.width/2, size.height/2), 50.0, Paint()..color = Colors.red);
  },
  onShouldRepaint: (old) => false,
);
return CustomPaint(painter: painter, size: Size(200, 200));
```

**This is a significant feature** — it would unlock testing for all abstract delegate patterns. Consider filing a separate generator issue.

### Strategy J: Test via /execute Endpoint (Non-Widget)

**Target:** Data classes, utility classes, physics simulations, error objects, paint/text measurement classes that don't produce visible widgets

**Approach:** Use the existing `/execute` endpoint which calls a `main()` function and returns the result as JSON. No widget rendering needed.

| Class Group | Test Pattern |
|-------------|-------------|
| Physics (`SpringSimulation`, `FrictionSimulation`, etc.) | Create, call `.x(t)`, `.dx(t)`, `.isDone(t)`, return results |
| Error handling (`FlutterError`, `FlutterErrorDetails`) | Create, access `.message`, `.toString()` |
| Text measurement (`TextPainter`, `ParagraphStyle`, `StrutStyle`) | Create, check properties. NOTE: `TextPainter.layout()` needs paragraph which needs `ParagraphBuilder` |
| Velocity, GlyphInfo, LineMetrics, TextBox | Construct, read properties |
| Codec classes | Encode/decode test data |
| Matrix4, RSTransform | Mathematical operations |

**Script pattern (using main instead of build):**
```dart
import 'dart:ui';
dynamic main() {
  final sim = SpringSimulation(SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0), 0.0, 1.0, 0.0);
  print('x(0.0) = ${sim.x(0.0)}');
  print('x(0.5) = ${sim.x(0.5)}');
  print('x(1.0) = ${sim.x(1.0)}');
  print('isDone(0.5) = ${sim.isDone(0.5)}');
  return 'ok';
}
```

### Strategy K: No User-Facing Need (Framework Internals)

**Target:** Classes that D4rt Flutter developers would never interact with directly

These are **not technically impossible** to expose — singletons like `SchedulerBinding.instance` could be registered in the D4rt scope, and internal classes could be accessed through their parent objects. The point is that Flutter app developers (and therefore D4rt script authors) never use these directly. They are implementation details of the Flutter framework.

| Class | Why No User Need | Could Be Exposed Via |
|-------|-----------------|---------------------|
| `BindingBase` | Abstract base — users interact with concrete bindings | N/A (abstract) |
| `SchedulerBinding` | Frame scheduling — handled by framework | `SchedulerBinding.instance` (singleton) |
| `ServicesBinding` | Platform service initialization | `ServicesBinding.instance` (singleton) |
| `GestureBinding` | Gesture system initialization | `GestureBinding.instance` (singleton) |
| `GestureArenaManager` | Gesture disambiguation — internal to `GestureDetector` | `GestureBinding.instance.gestureArena` |
| `GestureArenaEntry` | Arena membership tracking | Created internally by arena |
| `GestureArenaMember` | Abstract interface for arena participants | N/A (abstract) |
| `GestureArenaTeam` | Groups recognizers — internal to gesture system | Could construct directly |
| `PointerRouter` | Routes pointer events — internal to `GestureBinding` | `GestureBinding.instance.pointerRouter` |
| `HitTestEntry` | Hit test result entries | Created by framework during hit testing |
| `HitTestResult` | Hit test result container | Created by framework during hit testing |
| `HitTestTarget` | Abstract interface for hit-testable objects | N/A (abstract) |

**Decision:** Skip these in the testplan. If a future D4rt use case needs access to framework singletons (e.g., `SchedulerBinding.instance.addPostFrameCallback`), the bridge already supports accessing them — it's just a matter of registering them in the D4rt scope. This could be done on-demand without bridge generator changes.

**For the developer guide:** Document that these classes exist in the bridge but are framework internals. If advanced scripts need them (e.g., manual frame scheduling), they can be accessed through singleton accessors.

---

## 5. Implementation Priority

### Phase 1: No Test App Changes (Highest Priority)

**Strategy H (standard scripts)** and **Strategy E (theme/data wrapping)** cover the largest number of classes with zero infrastructure work:

| Work Item | Est. Classes | Strategy |
|-----------|-------------|----------|
| Theme data classes batch | ~90 | E |
| Cupertino widgets batch | ~30 | H |
| Painting/decoration data | ~20 | H, E |
| Standard material widgets | ~15 | H |
| Animation classes | ~10 | H, J |
| Routing data (RouteSettings, MaterialPageRoute) | ~5 | H |
| Text data classes | ~10 | H, J |
| Error/diagnostics | ~5 | J |
| Physics simulations | ~5 | J |
| Fix StatefulBuilder gap | 1 | H |
| **Subtotal** | **~190** | |

### Phase 2: Minor Test App Extensions

| Work Item | Est. Classes | Strategy |
|-----------|-------------|----------|
| State object access (.of pattern) | ~5 | C |
| Global functions (show*) batch | ~6 | F |
| DefaultTabController pattern | ~2 | G |
| Image providers (re-evaluate in test app) | ~4 | H (may just work) |
| Platform services (re-evaluate) | ~10 | H, J (may just work) |
| Semantics data classes | ~5 | H, J |
| **Subtotal** | **~32** | |

### Phase 3: Test App Canvas/Render Endpoint

| Work Item | Est. Classes | Strategy |
|-----------|-------------|----------|
| Add `/render` endpoint to test app | infrastructure | A |
| Render object scripts | ~25 | A |
| Canvas/drawing scripts | ~5 | A |
| **Subtotal** | **~30** | |

### Phase 4: Bridge Generator Enhancement (Lowest Priority)

| Work Item | Est. Classes | Strategy |
|-----------|-------------|----------|
| Proxy class generation for abstract delegates | ~6 | I |
| CustomPainter proxy | 1 | I |
| CustomClipper proxy | 1 | I |
| FlowDelegate, Layout delegates | 4 | I |
| **Subtotal** | **~6** | |

### Skipped — Framework Internals (Strategy K)

~12 classes skipped — not because they can't be exposed (singletons are trivially accessible via `.instance`), but because D4rt Flutter developers have no user-facing need for them. If a future use case arises, they can be registered in the D4rt scope without bridge generator changes.

### Total Coverage Estimate

| Phase | Classes | Cumulative |
|-------|---------|-----------|
| Already implemented | 101 | 101/527 (19%) |
| Phase 1 | ~190 | 291/527 (55%) |
| Phase 2 | ~32 | 323/527 (61%) |
| Phase 3 | ~30 | 353/527 (67%) |
| Phase 4 | ~6 | 359/527 (68%) |
| Already essential tier | 229 | 588/756 (78%) |
| Skipped — no user need (K) | ~12 | — |
| Essential not-testable (re-evaluate) | ~25 | See note below |

> **Re-evaluation note:** Many classes marked `not-testable` in the essential tier (render objects, Canvas, platform services, images) are actually testable with Strategies A, D, E, H, or J. The essential tier `not-testable` count of 25 should drop significantly after implementing the extended strategies.
