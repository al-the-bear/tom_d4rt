# Error Analysis: 20260411-1702-issue-analysis

Generated: 2026-04-11

## Run Metadata

**Run ID:** `20260411-1702-issue-analysis`
**Date:** 2026-04-11 17:02
**Revision:** `2f385ff8`
**Suites:** 8 (essential, important, secondary, hr1–hr5)
**Total Issues:** 549 (327 failures + 222 log-only)
**Document Batches:** 110 (groups of 5 issues each)

---

## Batch-0

Issues #0–#4 of 549

### Issue #0: cupertino/controls_test.dart

**Index:** 0
**Test Name:** `cupertino/controls_test.dart`
**Category:** `FW-LAYOUT-CONSTRAINT`
**Immediate Fix Possible:** No — root cause is in the Flutter rendering layer's reaction to interpreted widget tree constraints
**Description:** Test passes (D4rt build succeeds) but produces 5 framework errors during layout. All errors are `BoxConstraints has a negative minimum height` on `_RenderEditableCustomPaint` and cascading `RenderBox was not laid out` assertions.
**Batch Number:** 0

**Detailed Analysis:**

The script builds a `CupertinoApp` containing `CupertinoFormSection` and `CupertinoListSection` widgets with `CupertinoFormRow` children wrapping `CupertinoTextField` and `CupertinoSwitch` widgets. The `CupertinoTextField` widget internally uses `_RenderEditableCustomPaint` for its editable text overlay, which requires precise constraint propagation.

When running through the D4rt interpreter, the constraints passed down to `_RenderEditableCustomPaint` end up with a negative minimum height. This is a known issue affecting all scripts that use `CupertinoTextField` — the interpreter's widget tree construction does not perfectly replicate the constraint resolution that native compiled Flutter performs during the `CupertinoFormRow` → `CupertinoTextFormFieldRow` → `CupertinoTextField` → `EditableText` → `_RenderEditableCustomPaint` layout chain.

The 5 errors are:
1. `BoxConstraints has a negative minimum height` (on `_RenderEditableCustomPaint`) — 2 occurrences
2. `RenderBox was not laid out: _RenderEditableCustomPaint` — 2 occurrences
3. `Failed assertion: '!childSemantics.renderObject._needsLayout'` — 1 occurrence (cascade from #2)

**Fix Description:**

Fix the constraint propagation in the interpreter's widget tree construction for `CupertinoTextField`-containing layouts. The interpreter needs to ensure that `BoxConstraints` passed to `_RenderEditableCustomPaint` never have negative minimum dimensions. This likely requires investigation in the bridge layer's handling of `EditableText` and its interaction with `CupertinoFormRow`'s height constraints. The semantics assertion (#3) will resolve automatically once the layout constraints are correct.

**Needs Deeper Analysis:** Yes — requires tracing the exact constraint path through `CupertinoFormRow` → `CupertinoTextField` → `EditableText` internals

---

### Issue #1: cupertino/form_test.dart

**Index:** 1
**Test Name:** `cupertino/form_test.dart`
**Category:** `FW-LAYOUT-CONSTRAINT`
**Immediate Fix Possible:** No — same root cause as Issue #0
**Description:** Test passes but produces 17 framework errors during layout. All are `BoxConstraints has a negative minimum height` on `_RenderEditableCustomPaint` and cascading `RenderBox was not laid out` assertions. The higher count (17 vs 5) is because this script creates more `CupertinoTextField` instances across multiple form sections.
**Batch Number:** 0

**Detailed Analysis:**

The script builds a comprehensive form layout with multiple `CupertinoFormSection` widgets containing `CupertinoTextField` fields for username, email, and other form inputs. Each `CupertinoTextField` instance independently triggers the same negative-height constraint bug during its `_RenderEditableCustomPaint` layout phase.

The 17 errors break down as:
1. `BoxConstraints has a negative minimum height` — 8 occurrences (one per `CupertinoTextField`)
2. `RenderBox was not laid out: _RenderEditableCustomPaint` — 8 occurrences (cascade)
3. `Failed assertion: '!childSemantics.renderObject._needsLayout'` — 1 occurrence (final cascade)

This is the exact same root cause as Issue #0. The count is higher because the form_test script creates 8 `CupertinoTextField` instances compared to controls_test's 2.

**Fix Description:**

Same fix as Issue #0. Fix the constraint propagation for `CupertinoTextField` in the interpreter's widget tree. Fixing the root cause will resolve all 17 errors across all 8 text field instances.

**Needs Deeper Analysis:** No — same root cause as Issue #0, shares the fix

---

### Issue #2: cupertino/textfield_test.dart

**Index:** 2
**Test Name:** `cupertino/textfield_test.dart`
**Category:** `FW-LAYOUT-CONSTRAINT`
**Immediate Fix Possible:** No — same root cause as Issue #0
**Description:** Test passes but produces 13 framework errors during layout. All are `BoxConstraints has a negative minimum height` on `_RenderEditableCustomPaint` and cascading `RenderBox was not laid out` assertions. This is a comprehensive deep-demo of `CupertinoTextField` variants.
**Batch Number:** 0

**Detailed Analysis:**

This is the most detailed `CupertinoTextField` test script (886 lines), creating numerous `CupertinoTextField` variants: default, styled, with prefix/suffix, with clear button, with controller, bordered variants, and form-row variants. Each `CupertinoTextField` instance triggers the same negative-constraint layout error.

The 13 errors break down as:
1. `BoxConstraints has a negative minimum height` — 6 occurrences
2. `RenderBox was not laid out: _RenderEditableCustomPaint` — 6 occurrences (cascade)
3. `Failed assertion: '!childSemantics.renderObject._needsLayout'` — 1 occurrence (final cascade)

Root cause is identical to Issues #0 and #1. The constraint propagation through the interpreter's widget tree does not correctly handle the `CupertinoTextField` → `EditableText` → `_RenderEditableCustomPaint` layout chain.

**Fix Description:**

Same fix as Issues #0 and #1. A single fix to constraint propagation for `CupertinoTextField` layouts will resolve the errors across all three scripts.

**Needs Deeper Analysis:** No — same root cause as Issue #0

---

### Issue #3: rendering/viewport_test.dart

**Index:** 3
**Test Name:** `rendering/viewport_test.dart`
**Category:** `FW-LAYOUT-OVERFLOW`
**Immediate Fix Possible:** Yes — fix the test script's Row layouts to handle text overflow
**Description:** Test passes but produces 4 framework errors: all are `A RenderFlex overflowed by 20 pixels on the right`. The script contains Row widgets where child text/chips exceed the available horizontal space.
**Batch Number:** 0

**Detailed Analysis:**

The viewport_test script (1033 lines) is a comprehensive deep-demo of `ViewportOffset`, `ScrollDirection`, and `BoxParentData`. The 4 overflow errors come from `Row` widgets where the combined width of children exceeds the test screen's width bounds. Specifically:

The script uses helper function `vpInfoRow(label, value)` which creates a `Row` with a fixed-width `SizedBox(width: 140)` for the label and an `Expanded` for the value. The overflow occurs in `Row` widgets outside of `vpInfoRow` — likely the property display rows at lines ~317 (ScrollDirection enum cards with fixed 100px widths × 3 = 300px + spacing), and similar card layouts at lines ~443 and ~510 where `Row` children have fixed widths that can exceed the available width on smaller test screens.

This is a **test script issue**, not an interpreter or bridge problem. The script renders correctly in native Flutter too but would also overflow on narrow screens.

**Fix Description:**

Fix the test script by either:
1. Wrapping the overflowing `Row` children in `Expanded` or `Flexible` to adapt to available width
2. Replacing the `Row` with a `Wrap` widget for content that may exceed horizontal space
3. Reducing the fixed-width containers (e.g., the 100px direction cards) to fit within the minimum test screen width

The specific rows to fix are the `ScrollDirection` enum card row (~line 317), and any similar fixed-width card layout rows in the script.

**Needs Deeper Analysis:** No — script layout fix, straightforward

---

### Issue #4: widgets/slidetransition_test.dart

**Index:** 4
**Test Name:** `widgets/slidetransition_test.dart`
**Category:** `BRIDGE-RELAXER-MISSING-METHOD`
**Immediate Fix Possible:** Yes — add `addListener` delegation to `$RelaxedAnimation` in the relaxer generator
**Description:** Test passes but produces 1 framework error: `NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments`. The `$RelaxedAnimation` relaxer wrapper delegates `value` but not listener registration methods.
**Batch Number:** 0

**Detailed Analysis:**

The script creates `SlideTransition` widgets with `AlwaysStoppedAnimation(Offset(...))` as the `position` parameter. The `AlwaysStoppedAnimation<Offset>` is correctly bridged and has `addListener` in its bridge class. However, when the D4rt interpreter wraps the animation through the relaxer system (for generic type compatibility), it produces a `$RelaxedAnimation<Offset>` instead of passing through the native `AlwaysStoppedAnimation<Offset>`.

The `$RelaxedAnimation<V>` class in `flutter_relaxers.b.dart` (line 161) only delegates:
- `value` → `_inner.value as V`
- `noSuchMethod(Invocation)` → `super.noSuchMethod(invocation)` (which throws)

It is **missing** delegation for all `Animation`/`Listenable` interface methods:
- `addListener(VoidCallback)` — **causes the error**
- `removeListener(VoidCallback)`
- `addStatusListener(AnimationStatusListener)`
- `removeStatusListener(AnimationStatusListener)`
- `status` getter
- `toString()`

When Flutter's `SlideTransition` widget internally calls `addListener` on the animation (to listen for position changes), it hits `noSuchMethod` which throws `NoSuchMethodError`.

**Fix Description:**

Fix the relaxer generator (`tom_d4rt_generator/lib/src/relaxer_generator.dart`) to emit full listener delegation for `$RelaxedAnimation<V>`. The generated class should include:
```dart
@override
void addListener(VoidCallback listener) => _inner.addListener(listener);
@override
void removeListener(VoidCallback listener) => _inner.removeListener(listener);
@override
void addStatusListener(AnimationStatusListener listener) => _inner.addStatusListener(listener);
@override
void removeStatusListener(AnimationStatusListener listener) => _inner.removeStatusListener(listener);
@override
AnimationStatus get status => _inner.status;
@override
String toString() => _inner.toString();
```

Alternatively, until the generator is fixed, add these methods manually to `$RelaxedAnimation` in `flutter_relaxers.b.dart`.

**Needs Deeper Analysis:** No — clear fix path, either in generator or manual override

---

## Batch 1

### Issue #5 — widgets/nestedscrollview_test.dart

**Index:** #5
**Test Name:** widgets_nestedscrollview
**Category:** INTERPRETER-GENERIC-INFERENCE
**Immediate Fix Possible:** No — interpreter limitation

**Description:** Test passes but produces 4 framework errors: `type 'List<Object?>' is not a subtype of type 'List<Widget>'`. The script explicitly uses `<Widget>[]` in the `headerSliverBuilder` callback return type, but the D4rt interpreter infers the list element type as `Object?` instead of `Widget`, producing a `List<Object?>` at runtime.

**Detailed Analysis:**
The test creates 4 `NestedScrollView` variants, each with a `headerSliverBuilder: (context, innerBoxIsScrolled) { ... }` callback that returns `<Widget>[SliverAppBar(...)]`. In native Dart, the explicit `<Widget>[]` literal creates a `List<Widget>`. The D4rt interpreter, however, does not propagate the generic type annotation from list literals through callback return types — it falls back to `List<Object?>`. When the Flutter framework assigns this return value to a `List<Widget>` parameter, the runtime type check fails.

This is Known Issue #1 in the D4rt interpreter: generic type inference for collection literals does not honor explicit type annotations in all contexts, particularly inside closures/callbacks.

**Fix Description:**
Fix the interpreter's list literal evaluation (`visitListLiteral` or equivalent) to respect explicit type arguments on list/map/set literals. When the source code specifies `<Widget>[]`, the interpreter must produce a `List<Widget>`, not `List<Object?>`. This requires changes in `tom_d4rt_ast` interpreter visitor — the type argument from the AST `TypeArgumentList` node on the `ListLiteral` must be resolved and used as the runtime generic parameter for the created list.

**Needs Deeper Analysis:** No — known issue #1, root cause understood

**Batch Number:** 1

---

### Issue #6 — material/refreshindicator_test.dart

**Index:** #6
**Test Name:** material_refreshindicator
**Category:** SCRIPT-LAYOUT-BUG
**Immediate Fix Possible:** Yes — fix the test script

**Description:** Test passes but produces 13 framework errors. The primary error is `RenderFlex children have non-zero flex but incoming height constraints are unbounded` followed by cascade errors from the unbounded layout. The script wraps a `Column` with `Expanded` children inside a `SingleChildScrollView`, which gives the Column unbounded height — `Expanded` inside an unbounded-height `Column` is illegal in Flutter.

**Detailed Analysis:**
The test script creates 5 `RefreshIndicator` variants. Each wraps its content in `SingleChildScrollView(child: Column(children: [Expanded(child: ...)]))`. A `SingleChildScrollView` provides unbounded height constraints to its child. A `Column` receiving unbounded height cannot resolve `Expanded` children (which require a finite remaining space to flex into). This is a script-level bug that would fail identically in native Flutter — it is NOT a D4rt interpreter issue.

The 13 errors break down as: 5 primary `RenderFlex children have non-zero flex` errors (one per variant) plus 8 cascade errors from the failed layout (size/constraint assertions in child render objects).

**Fix Description:**
Replace `Expanded` with `SizedBox(height: N)` or remove the `SingleChildScrollView` wrapper and use a fixed-height `Column`. For example, change each variant from:

```dart
SingleChildScrollView(
  child: Column(children: [Expanded(child: content)])
)
```

to:

```dart
SingleChildScrollView(
  child: Column(children: [SizedBox(height: 300, child: content)])
)
```

Alternatively, wrap the `Column` in a `SizedBox` with a fixed height to bound its parent constraints, or use `ListView` instead of `SingleChildScrollView + Column + Expanded`.

**Needs Deeper Analysis:** No — standard Flutter layout constraint violation in the script

**Batch Number:** 1

---

### Issue #7 — widgets/actions_test.dart

**Index:** #7
**Test Name:** widgets_actions
**Category:** INTERPRETER-LATE-INIT
**Immediate Fix Possible:** No — interpreter limitation

**Description:** Test passes but produces 1 framework error: `Undefined variable: _dispatcher` manifesting as a `LateInitializationError`. The script uses `late final` fields in a `State` subclass that are initialized in `initState()`. The D4rt interpreter fails to resolve these `late final` fields when they are accessed before or outside the expected initialization lifecycle.

**Detailed Analysis:**
The test script defines a complex stateful widget with 8 `late final` fields (lines 216-223): `_dispatcher`, `_openAction`, `_shipAction`, `_escalateAction`, `_toggleAutoAction`, `_resetAction`, `_rotatePaletteAction`, and `_localOpenAction`. These are initialized in `initState()` (line 244+). The `_dispatcher` field is an `_AuditDispatcher` instance created with an `onTrace` callback.

The D4rt interpreter reports the error as `Undefined variable: _dispatcher` rather than a proper `LateInitializationError`, suggesting the interpreter does not properly handle `late final` field semantics in interpreted classes. In native Dart, `late final` fields are legal and work correctly when initialized in `initState()` before any `build()` call.

The error occurs only once despite 8 `late final` fields, indicating the failure happens at the first access to `_dispatcher` and the framework catches and logs the error, preventing further field access attempts.

**Fix Description:**
Fix the D4rt interpreter's handling of `late final` instance fields in interpreted classes. The interpreter must:
1. Recognize `late final` field declarations and defer their initialization (not require a value at declaration time)
2. Allow assignment in `initState()` or other methods
3. Throw a proper `LateInitializationError` (not "Undefined variable") if accessed before initialization
4. Prevent re-assignment after initialization (the `final` semantics)

This requires changes in the interpreter's class field resolution in `tom_d4rt_ast`.

**Needs Deeper Analysis:** Yes — need to verify how the interpreter currently handles `late` fields and whether this is a field resolution issue or a lifecycle timing issue

**Batch Number:** 1

---

### Issue #8 — animation/tweensequence_test.dart

**Index:** #8
**Test Name:** animation_tweensequence
**Category:** BRIDGE-GENERIC-CONSTRUCTOR
**Immediate Fix Possible:** No — bridge/interpreter issue

**Description:** Test FAILS with error: `Error in generic constructor factory for 'TweenSequenceItem': Null check operator used on a null value`. The script constructs `TweenSequenceItem<double>(tween: Tween<double>(...), weight: 50)`. The generic constructor factory `_rc2TweenSequenceItem` in `flutter_relaxers.b.dart` (line 122192) correctly resolves `typeName` to `'double'` and dispatches to the `'double'` branch, but the `D4.extractBridgedArg<Animatable<double>?>(tween, 'tween')` call returns `null`, causing the trailing `!` operator to throw.

**Detailed Analysis:**
The test script creates multiple `TweenSequenceItem<double>` instances with `Tween<double>` as the `tween` argument. The construction flow is:

1. `TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 100.0), weight: 50)` is parsed
2. The interpreter first constructs `Tween<double>(begin: 0.0, end: 100.0)` — this produces a `BridgedInstance` wrapping a native `Tween<double>`
3. The `BridgedInstance` is passed as the `tween` named argument to the `_rc2TweenSequenceItem` factory
4. `D4.extractBridgedArg<Animatable<double>?>` attempts to unwrap the `BridgedInstance` to get the native `Animatable<double>` inside
5. The extraction fails — returns `null` — likely because the `BridgedInstance`'s native object (a `Tween<double>`) is not recognized as `Animatable<double>` during the type-cast unwrapping

The root cause is in `D4.extractBridgedArg` — it unwraps `BridgedInstance` objects but may fail the type check `is Animatable<double>` against the actual `Tween<double>` object due to Dart's reified generics. A `Tween<double>` is `Animatable<double>`, but if the `BridgedInstance` stores it as `dynamic` and the extraction uses a strict cast, the type parameter may be lost.

**Fix Description:**
Fix `D4.extractBridgedArg` to handle the case where the unwrapped native object is a subtype of the requested type. Specifically, when extracting `Animatable<double>` from a `BridgedInstance` wrapping `Tween<double>`, the extraction should succeed since `Tween<double> is Animatable<double>` is `true` in Dart. The issue is likely that the extraction uses `as T` where `T` includes the generic parameter, and the runtime type check fails. Consider using a softer extraction that checks `is Animatable` (without the generic parameter) or casts to `dynamic` first.

Alternatively, the `_rc2TweenSequenceItem` factory could use `D4.extractBridgedArg<Animatable<dynamic>?>` instead of `D4.extractBridgedArg<Animatable<double>?>` and let the `TweenSequenceItem<double>` constructor handle the type check.

**Needs Deeper Analysis:** Yes — need to verify `D4.extractBridgedArg` behavior with generic types and determine whether the fix belongs in `extractBridgedArg` or in the generated factory code

**Batch Number:** 1

---

### Issue #9 — services/codecs_test.dart

**Index:** #9
**Test Name:** services_codecs
**Category:** BRIDGE-MISSING-TYPE
**Immediate Fix Possible:** Yes — add ByteData bridge

**Description:** Test FAILS with error: `Undefined variable: ByteData`. The script uses `ByteData(5)` to create a byte buffer for testing `BinaryCodec`. `ByteData` is a `dart:typed_data` class that is not registered as a bridged type in the D4rt Flutter bridge — it has no constructor bridge, even though it appears as a parameter type in other bridges (e.g., `ReadBuffer`, `BinaryMessenger`).

**Detailed Analysis:**
The test script imports `package:flutter/services.dart` and `package:flutter/widgets.dart`. At line 164, it calls `ByteData(5)` to create a 5-byte buffer. `ByteData` is defined in `dart:typed_data` (re-exported through `dart:core` in some contexts). The D4rt bridge files reference `ByteData` extensively as a parameter type (in `dart_ui_bridges.b.dart`, `foundation_bridges.b.dart`, `services_bridges.b.dart`) but never register a `BridgedClass` for `ByteData` itself — there is no constructor bridge that would allow `ByteData(5)` to resolve.

Searching the bridge files confirms: `ByteData` appears in method signatures as a parameter/return type (e.g., `'done': 'ByteData done()'`, `'ReadBuffer(ByteData data)'`) but has no `BridgedClass` definition with a constructor entry.

**Fix Description:**
Add a `ByteData` bridge class to the appropriate bridge file (likely `dart_typed_data_bridges.b.dart` or `foundation_bridges.b.dart`). The bridge needs:

1. A constructor bridge for `ByteData(int length)` that calls `ByteData(length)`
2. Getter bridges for `lengthInBytes`, `buffer`, `offsetInBytes`
3. Method bridges for `getUint8`, `setUint8`, `getInt8`, `setInt8`, `getUint16`, `setUint16`, `getInt16`, `setInt16`, `getUint32`, `setUint32`, `getInt32`, `setInt32`, `getFloat32`, `setFloat32`, `getFloat64`, `setFloat64`, `getByteData` (subview)

Alternatively, if `ByteData` bridging is out of scope for the Flutter bridge set, add a `dart:typed_data` bridge package or include `ByteData` in the existing Dart core bridges. At minimum, bridge the constructor and `getUint8`/`setUint8`/`lengthInBytes` to unblock this test.

**Needs Deeper Analysis:** No — clear missing bridge, straightforward implementation

**Batch Number:** 1

---

## Batch 2

### Issue #10 — services/channels_test.dart

**Index:** #10
**Test Name:** services_channels
**Category:** BRIDGE-GENERIC-CALLBACK-TYPE
**Immediate Fix Possible:** Yes — fix the bridge callback type

**Description:** Test FAILS with error: `type '(dynamic) => Future<dynamic>' is not a subtype of type '((String?) => Future<String>)?' of 'handler'`. The script creates a `BasicMessageChannel<String>` and calls `setMessageHandler((String? message) async { ... })`. The bridge for `BasicMessageChannel.setMessageHandler` (line 8330 of `services_bridges.b.dart`) wraps the interpreter callback in a `(dynamic p0) => Future<dynamic>` closure and passes it via `(t as dynamic).setMessageHandler(...)`. At runtime, the `BasicMessageChannel<String>` expects a handler of type `((String?) => Future<String>)?`, and the `(dynamic) => Future<dynamic>` closure fails the Dart reified generic type check.

**Detailed Analysis:**
The bridge code at `services_bridges.b.dart:8330` is:
```dart
(t as dynamic).setMessageHandler(handlerRaw == null ? null : (dynamic p0) {
  return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<dynamic>;
});
```

The `as dynamic` cast on `t` disables static type checking, but the runtime still enforces the generic type constraint on the handler parameter. `BasicMessageChannel<String>.setMessageHandler` expects `Future<String> Function(String?)?` — the bridge-generated closure `(dynamic) => Future<dynamic>` is not a subtype of `(String?) => Future<String>` because:
1. The return type `Future<dynamic>` is not a subtype of `Future<String>`
2. The parameter type `dynamic` vs `String?` would be covariant (acceptable), but the return type mismatch is the blocker

This pattern affects all `BasicMessageChannel<T>` where `T` is not `dynamic`.

**Fix Description:**
The generic constructor factory for `BasicMessageChannel` must generate type-specific `setMessageHandler` wrappers. For `BasicMessageChannel<String>`, the callback must be wrapped as `(String? p0) => Future<String>`. Options:

1. **In the generic constructor factory:** When `T` is known (e.g., `String`), generate a properly-typed closure wrapper: `(String? p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<String>; }`
2. **In the bridge method:** Use a type-dispatching approach based on the runtime type of the `BasicMessageChannel` instance — check `t.runtimeType` and cast the callback accordingly
3. **Simplest fix:** Cast the interpreter callback result to `Future<T>` using reflection on the channel's codec type parameter

The same pattern likely affects `send()` (which returns `Future<T?>`) but the test only hits it on `setMessageHandler`.

**Needs Deeper Analysis:** No — root cause clear, fix requires type-aware callback wrapping in bridge

**Batch Number:** 2

---

### Issue #11 — cupertino/cupertino_secondary_test.dart

**Index:** #11
**Test Name:** cupertino_cupertino_secondary
**Category:** FW-LAYOUT-CONSTRAINT
**Immediate Fix Possible:** No — interpreter constraint propagation issue

**Description:** Test passes but produces 3 framework errors. The primary error is `BoxConstraints has a negative minimum height` in `_RenderEditableCustomPaint's layout()`. This is the same root cause as Batch-0 Issues #0, #1, #2 — `CupertinoTextField` embedded inside `CupertinoFormRow` triggers a negative-height constraint from the interpreter's layout system.

**Detailed Analysis:**
The script creates a `CupertinoFormRow` containing a `CupertinoTextField(placeholder: 'John Doe')` (line 108). Despite being wrapped in `ConstrainedBox(constraints: BoxConstraints(minHeight: 44))`, the internal `_RenderEditableCustomPaint` inside `CupertinoTextField` receives negative minimum height constraints during layout. The 3 errors cascade:

1. `BoxConstraints has a negative minimum height` — the initial constraint violation
2. `RenderBox was not laid out: _RenderEditableCustomPaint NEEDS-LAYOUT NEEDS-PAINT` — the render object that couldn't lay out due to invalid constraints
3. `Failed assertion: '!childSemantics.renderObject._needsLayout'` — semantics tree walks into the un-laid-out render object

This is identical to the Batch-0 CupertinoTextField constraint propagation issue. The interpreter's handling of `CupertinoTextField` internal layout (which involves decoration, padding, and edit region sizing) produces negative heights in some configurations.

**Fix Description:**
Same as Batch-0 Issue #0 — fix the interpreter's constraint propagation for `CupertinoTextField` internal layout. The `_RenderEditableCustomPaint` receives `height = parentHeight - decorationHeight - paddingHeight`, and when `parentHeight` is insufficiently computed, the result goes negative. The fix requires ensuring minimum constraints are clamped to zero in the interpreter's layout pass, or fixing the specific constraint computation in the `CupertinoTextField` render pipeline.

**Needs Deeper Analysis:** No — same root cause as Batch-0 #0/#1/#2

**Batch Number:** 2

---

### Issue #12 — cupertino/cupertino_form_scroll_test.dart

**Index:** #12
**Test Name:** cupertino_cupertino_form_scroll
**Category:** FW-LAYOUT-CONSTRAINT
**Immediate Fix Possible:** No — interpreter constraint propagation issue

**Description:** Test passes but produces 4 framework errors. Same `BoxConstraints has a negative minimum height` root cause from `CupertinoTextFormFieldRow` (which internally uses `CupertinoTextField`), plus an additional `RenderFlex overflowed by 3.4e+38 pixels on the bottom` error indicating an extreme overflow caused by the constraint failure cascading into layout calculations.

**Detailed Analysis:**
The script creates `CupertinoTextFormFieldRow` widgets (line 12) wrapped in `ConstrainedBox(minHeight: 44)`. The internal text field produces the same negative-height constraint as Issue #11. Additionally, the `CupertinoListSection.insetGrouped` layout at the end of the script (line 100) attempts to lay out a `Column`-like structure where the un-laid-out text field contributes an invalid size, resulting in a massive overflow value (`3.4e+38` — essentially `double.maxFinite`).

The 4 errors:
1. `BoxConstraints has a negative minimum height` — CupertinoTextField constraint violation
2. `RenderBox was not laid out: _RenderEditableCustomPaint` — cascading layout failure
3. `RenderFlex overflowed by 3.4e+38 pixels` — the overflow from invalid size propagation
4. `Failed assertion: '!childSemantics.renderObject._needsLayout'` — semantics tree issue

**Fix Description:**
Same root fix as Batch-0 #0 and Batch-2 #11 — fix CupertinoTextField constraint propagation. The overflow is a secondary symptom that will resolve once the primary constraint issue is fixed.

**Needs Deeper Analysis:** No — same root cause as Batch-0 #0/#1/#2

**Batch Number:** 2

---

### Issue #13 — cupertino/cupertino_controls_advanced_test.dart

**Index:** #13
**Test Name:** cupertino_cupertino_controls_advanced
**Category:** FW-LAYOUT-CONSTRAINT
**Immediate Fix Possible:** No — interpreter constraint propagation issue

**Description:** Test passes but produces 4 framework errors. Identical pattern to Issue #12: `BoxConstraints has a negative minimum height` from `CupertinoSearchTextField` (which internally uses the same editable text rendering as `CupertinoTextField`), plus the same `RenderFlex overflowed by 3.4e+38 pixels` cascade.

**Detailed Analysis:**
The script creates a `CupertinoSearchTextField` (line 63) wrapped in `ConstrainedBox(constraints: BoxConstraints(minHeight: 36))`. The `CupertinoSearchTextField` uses the same `_RenderEditableCustomPaint` internally, triggering the identical negative-height constraint. The Column layout in the return widget (line 90) then produces the extreme overflow.

The 4 errors are structurally identical to Issue #12:
1. `BoxConstraints has a negative minimum height`
2. `RenderBox was not laid out: _RenderEditableCustomPaint`
3. `RenderFlex overflowed by 3.4e+38 pixels`
4. `Failed assertion: '!childSemantics.renderObject._needsLayout'`

**Fix Description:**
Same root fix as all other FW-LAYOUT-CONSTRAINT issues — fix CupertinoTextField/`_RenderEditableCustomPaint` constraint propagation in the interpreter. `CupertinoSearchTextField` is affected because it uses the same underlying editable text render object.

**Needs Deeper Analysis:** No — same root cause as Batch-0 #0/#1/#2

**Batch Number:** 2

---

### Issue #14 — cupertino/cupertino_sections_test.dart

**Index:** #14
**Test Name:** cupertino_cupertino_sections
**Category:** FW-LAYOUT-CONSTRAINT
**Immediate Fix Possible:** No — interpreter constraint propagation issue

**Description:** Test passes but produces 5 framework errors. Same `BoxConstraints has a negative minimum height` root cause, but with TWO CupertinoTextFormFieldRow instances (Email and Password fields), each producing their own constraint violation and layout failure, plus the shared semantics assertion.

**Detailed Analysis:**
The script creates a `CupertinoFormSection` with two `CupertinoTextFormFieldRow` children (lines 23-39): an email field and a password field. Each field triggers the negative-height constraint independently, producing:

1. `BoxConstraints has a negative minimum height` — first text field (Email)
2. `BoxConstraints has a negative minimum height` — second text field (Password)
3. `RenderBox was not laid out: _RenderEditableCustomPaint` — first text field
4. `RenderBox was not laid out: _RenderEditableCustomPaint` — second text field
5. `Failed assertion: '!childSemantics.renderObject._needsLayout'` — semantics tree (shared)

The 5 errors (vs 3 or 4 in other issues) are simply proportional to the number of `CupertinoTextFormFieldRow` instances in the script.

**Fix Description:**
Same root fix as all other FW-LAYOUT-CONSTRAINT issues. Once the CupertinoTextField constraint propagation is fixed, all cupertino text field variants (`CupertinoTextField`, `CupertinoTextFormFieldRow`, `CupertinoSearchTextField`) will be resolved across all affected tests.

**Needs Deeper Analysis:** No — same root cause as Batch-0 #0/#1/#2

**Batch Number:** 2

---
