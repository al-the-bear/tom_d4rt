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

## Batch 3

### Issue #15 — cupertino/cupertino_tabbar_scaffold_test.dart

**Index:** #15
**Test Name:** cupertino_cupertino_tabbar_scaffold
**Category:** FW-LAYOUT-CONSTRAINT
**Immediate Fix Possible:** No — interpreter constraint propagation issue

**Description:** Test passes but produces 9 framework errors. Same `BoxConstraints has a negative minimum height` root cause from `CupertinoTextFormFieldRow` (which internally uses `CupertinoTextField`). The script contains 4 `CupertinoTextFormFieldRow` instances (lines 168, 175, 194, 201), each producing a negative-height constraint error and a cascading not-laid-out error, plus 1 shared semantics assertion.

**Detailed Analysis:**
The script tests `CupertinoTabBar`, `CupertinoTabScaffold`, `CupertinoTabController`, and various `CupertinoFormSection`/`CupertinoFormRow` widgets. The form sections contain `CupertinoTextFormFieldRow` fields for name, email, street, and city input. Each text form field triggers the same `_RenderEditableCustomPaint` negative-height layout issue seen in Batch-0 (#0/#1/#2) and Batch-2 (#11-#14).

The 9 errors break down as: 4 × `BoxConstraints has a negative minimum height` + 4 × `RenderBox was not laid out: _RenderEditableCustomPaint` + 1 × `!childSemantics.renderObject._needsLayout` assertion.

**Fix Description:**
Same root fix as all other FW-LAYOUT-CONSTRAINT issues — fix CupertinoTextField constraint propagation in the interpreter's layout system.

**Needs Deeper Analysis:** No — same root cause as Batch-0 #0/#1/#2

**Batch Number:** 3

---

### Issue #16 — semantics/semantics_config_test.dart

**Index:** #16
**Test Name:** semantics_semantics_config
**Category:** BRIDGE-INTERPRETED-FUNCTION-COERCION
**Immediate Fix Possible:** No — interpreter/bridge limitation

**Description:** Test FAILS with error: `type 'InterpretedFunction' is not a subtype of type '(() => void)?'`. The script assigns interpreter-created closures (e.g., `() { tapCount++; ... }`) to `SemanticsConfiguration` action setters like `configActions.onTap = () { ... }`. The interpreter wraps the closure as an `InterpretedFunction` object, which is not recognized as a native `void Function()` by Dart's runtime type system.

**Detailed Analysis:**
The script (2053 lines) creates a `SemanticsConfiguration` and assigns callbacks to multiple action properties: `onTap`, `onLongPress`, `onScrollLeft`, `onScrollRight`, `onScrollUp`, `onScrollDown`, `onIncrease`, `onDecrease`, `onCopy`, `onDismiss` (lines 738-784). Each assignment is of the form:

```dart
configActions.onTap = () {
  tapCount++;
  print('  Action: onTap fired ($tapCount)');
};
```

The `SemanticsConfiguration.onTap` setter expects `VoidCallback?` (i.e., `void Function()?`). The D4rt interpreter creates an `InterpretedFunction` for the closure literal, which does NOT implement `void Function()` at the Dart runtime level. When the bridge passes this `InterpretedFunction` to the native setter, the runtime rejects it.

This is a fundamental limitation: interpreter-created closures cannot satisfy Dart's reified function type checks without being wrapped in a native trampoline callback.

**Fix Description:**
The bridge for `SemanticsConfiguration` property setters must detect when the value is an `InterpretedFunction` and wrap it in a native callback trampoline:

```dart
'onTap': (visitor, target, value) {
  final t = D4.validateTarget<SemanticsConfiguration>(target, 'SemanticsConfiguration');
  if (value is InterpretedFunction) {
    t.onTap = () { D4.callInterpreterCallback(visitor, value, []); };
  } else {
    t.onTap = value as VoidCallback?;
  }
}
```

This pattern needs to be applied to all `VoidCallback?` setters on `SemanticsConfiguration`. Alternatively, the bridge generator could automatically detect `VoidCallback?`/`void Function()?` setter types and generate trampoline wrappers. This is the same class of problem as BRIDGE-GENERIC-CALLBACK-TYPE (Issue #10) but for property setters rather than method parameters.

**Needs Deeper Analysis:** No — root cause clear, fix requires callback trampolines in SemanticsConfiguration bridge setters

**Batch Number:** 3

---

### Issue #17 — widgets/gesture_detector_adv_test.dart

**Index:** #17
**Test Name:** widgets_gesture_detector_adv
**Category:** INTERPRETER-STATE-WIDGET-ACCESS
**Immediate Fix Possible:** No — interpreter limitation

**Description:** Test passes but produces 5 framework errors, all identical: `Undefined property 'widget' on _<ClassName>State`. The script defines 5 `State` subclasses (`_ArenaSceneState`, `_PanScaleSceneState`, `_LongPressTimelineSceneState`, `_RawGestureFactorySceneState`, `_PointerAndPracticalSceneState`), each accessing `widget.config` in their `build()` method. The D4rt interpreter does not resolve the inherited `widget` getter from `State<T>` on interpreted State subclasses.

**Detailed Analysis:**
The script (1363 lines) defines 5 `StatefulWidget`/`State` pairs. Each `State` subclass accesses `widget.config` (lines 474, 598, 728, 885, 984) where `config` is a `final` field declared on the corresponding `StatefulWidget`. In native Dart, `State<T>.widget` returns the current `T` instance. The D4rt interpreter fails to resolve `widget` as an inherited property on interpreted classes extending `State<T>`.

The error message `Undefined property 'widget' on _ArenaSceneState` indicates the interpreter looks for `widget` directly on the interpreted class's property map and does not fall through to the native `State` base class getter. Each of the 5 State subclasses produces exactly one error when its `build()` is first called.

Despite the errors, the test passes because the framework catches and logs the error during build, and each scene likely renders a fallback or partial UI.

**Fix Description:**
Fix the interpreter's property resolution for interpreted classes that extend native bridge classes. When an interpreted `State<T>` subclass accesses `widget`, the interpreter must:
1. Check the interpreted class's own fields/getters first
2. Fall through to the bridge class's registered getters (from the `State` bridge)
3. The `State` bridge should register `widget` as a getter that returns the native `State.widget` value

This may require the bridge for `State<T>` to expose `widget` as a getter, or the interpreter's `visitPropertyAccess` to check the native superclass bridge when the interpreted class doesn't define the property.

**Needs Deeper Analysis:** Yes — need to verify how the interpreter resolves inherited properties on native base classes and whether the `State` bridge registers `widget` as a getter

**Batch Number:** 3

---

### Issue #18 — widgets/layout_builder_adv_test.dart

**Index:** #18
**Test Name:** widgets_layout_builder_adv
**Category:** INTERPRETER-INTERPRETED-CLASS-METHOD
**Immediate Fix Possible:** No — interpreter limitation

**Description:** Test passes but produces 7 framework errors. The primary error is `Undefined property 'layoutChild' on TestMultiChildLayoutDelegate`. The script defines a `TestMultiChildLayoutDelegate extends MultiChildLayoutDelegate` with a `performLayout(Size size)` method that calls `layoutChild(...)` and `positionChild(...)`. The interpreter does not resolve inherited methods (`layoutChild`, `positionChild`) from the native `MultiChildLayoutDelegate` base class.

**Detailed Analysis:**
The script defines two custom delegate classes (lines 187-217):
- `TestMultiChildLayoutDelegate extends MultiChildLayoutDelegate` — calls `layoutChild()` and `positionChild()` in `performLayout()`
- `TestSingleChildLayoutDelegate extends SingleChildLayoutDelegate` — overrides `getPositionForChild()`

The `layoutChild` error occurs because the interpreter's interpreted class (`TestMultiChildLayoutDelegate`) overrides `performLayout`, but when that method calls `layoutChild(...)`, the interpreter looks for `layoutChild` in the interpreted class scope and doesn't find it. It should fall through to the native `MultiChildLayoutDelegate` bridge which presumably has `layoutChild` as a method.

The cascade errors (6 additional) are all secondary: `RenderCustomSingleChildLayoutBox object was given an infinite size`, `RenderConstrainedOverflowBox object was given an infinite size`, `RenderFlex object was given an infinite size`, `Rect argument contained a NaN value`, `!childSemantics.renderObject._needsLayout`. These occur because the `CustomMultiChildLayout` fails to lay out its children (since `performLayout` errors out), and the invalid/missing sizes propagate through the render tree.

**Fix Description:**
Same fundamental issue as #17 (INTERPRETER-STATE-WIDGET-ACCESS) — the interpreter needs to resolve method calls on interpreted class instances to the native superclass bridge when the method is not defined on the interpreted class itself. For `TestMultiChildLayoutDelegate`, calling `layoutChild(...)` should resolve to `MultiChildLayoutDelegate.layoutChild()` on the native instance.

This requires the interpreter's method resolution to:
1. Check the interpreted class's own methods
2. Fall through to the bridge class's registered methods for the native superclass
3. Invoke the bridge method on the native backing instance

**Needs Deeper Analysis:** Yes — same class of problem as #17, need to verify interpreter's inherited method resolution for interpreted classes extending bridged natives

**Batch Number:** 3

---

### Issue #19 — widgets/scroll_position_types_test.dart

**Index:** #19
**Test Name:** widgets_scroll_position_types
**Category:** SCRIPT-LAYOUT-BUG
**Immediate Fix Possible:** Yes — fix the test script

**Description:** Test passes but produces 2 framework errors: `RenderFlex children have non-zero flex but incoming height constraints are unbounded` and the cascading semantics assertion. The script wraps a `Column` with an `Expanded(child: ListView.builder(...))` inside `SingleChildScrollView`, creating unbounded height constraints — identical pattern to Batch-1 Issue #6 (refreshindicator_test.dart).

**Detailed Analysis:**
The return widget (lines 81-103) is structured as:

```dart
SingleChildScrollView(
  child: Column(
    children: [
      Expanded(
        child: ListView.builder(...)
      ),
      Text('Scroll Position Types Test'),
    ],
  ),
)
```

`SingleChildScrollView` gives unbounded height to its child. `Column` receives unbounded height. `Expanded` requires finite remaining space to flex into. This is the same illegal layout pattern as Issue #6. This is a script-level bug that would fail identically in native Flutter.

**Fix Description:**
Replace the layout to avoid `Expanded` inside unbounded parents. Options:

1. Remove `SingleChildScrollView` and use `Column` directly with `Expanded(child: ListView.builder(...))` — this works if the `Scaffold.body` provides bounded constraints
2. Replace `Expanded` with `SizedBox(height: 400, child: ListView.builder(...))` inside the `SingleChildScrollView`
3. Remove `Column` entirely and use just `ListView.builder(...)` as the body

Simplest fix:
```dart
Scaffold(
  body: Column(
    children: [
      Expanded(
        child: ListView.builder(
          controller: scrollController,
          itemCount: 50,
          itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
        ),
      ),
      const Text('Scroll Position Types Test'),
    ],
  ),
)
```

**Needs Deeper Analysis:** No — standard Flutter layout constraint violation in the script

**Batch Number:** 3

---

## Batch 4

### Issue #20

**Script:** `widgets/scroll_controllers_types_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 158
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `RenderFlex children have non-zero flex but incoming height constraints are unbounded.`
2. `'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`

**Category:** SCRIPT-LAYOUT-BUG

**Root Cause Analysis:**

The script (103 lines) builds `MaterialApp > Scaffold > Center > SingleChildScrollView > Column > [Expanded(child: ListView.builder(...)), Text(...)]`. This is the identical illegal layout pattern as Issues #6 and #19: `Expanded` inside `SingleChildScrollView` gives the `Column` unbounded height, and `Expanded` requires finite remaining space to flex into. The semantics assertion (#2) is a cascading failure from the layout error — the child never gets laid out, so its semantics RenderObject remains in a `_needsLayout` state.

**Fix Description:**
Remove `SingleChildScrollView` and use `Column` directly inside `Scaffold.body` with `Expanded(child: ListView.builder(...))`. The `ListView.builder` already handles scrolling internally. Alternatively, replace `Expanded` with `SizedBox(height: N)` if the `SingleChildScrollView` wrapper is intentional.

**Needs Deeper Analysis:** No — identical SCRIPT-LAYOUT-BUG as Issues #6 and #19

**Batch Number:** 4

---

### Issue #21

**Script:** `cupertino/cupertino_text_selection_controls_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 177
**Result:** success (test passed)
**Errors:** 9 framework errors (log-only)

**Error Messages:**

1–4. `BoxConstraints has a negative minimum height. These invalid constraints were provided to _RenderEditableCustomPaint's layout() function` (×4)
5–8. `RenderBox was not laid out: _RenderEditableCustomPaint#xxxxx NEEDS-LAYOUT NEEDS-PAINT` (×4)
9. `'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`

**Category:** FW-LAYOUT-CONSTRAINT

**Root Cause Analysis:**

The script (88 lines) creates 4 `CupertinoTextField` instances — one standalone and three in a loop (sharing the same `cupertinoTextSelectionControls`). Each `CupertinoTextField` produces a negative-height constraint error and a subsequent `NEEDS-LAYOUT` assertion (4 fields × 2 errors = 8), plus one final semantics assertion cascading from the layout failures. This is the same CupertinoTextField-in-D4rt issue as Issues #0–#3, #11–#15: the D4rt interpreter's rendering pipeline computes a negative minimum height for `_RenderEditableCustomPaint` inside `CupertinoTextField`.

**Fix Description:**
Add an explicit `minHeight: 0.0` constraint normalization in the D4rt rendering bridge before passing constraints to `_RenderEditableCustomPaint.layout()`. This would clamp `minHeight` to `max(0, minHeight)` so the Cupertino text field's internal render objects never receive negative constraints. Alternatively, wrap each `CupertinoTextField` in a `SizedBox(height: 48)` to guarantee positive incoming constraints.

**Needs Deeper Analysis:** No — same FW-LAYOUT-CONSTRAINT as all other CupertinoTextField issues

**Batch Number:** 4

---

### Issue #22

**Script:** `dart_ui/ztmp_path_metrics_access_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 197
**Result:** failure (test FAILED)
**Errors:** 1 test failure

**Error Message:**

```
Expected: true
  Actual: <false>
Bad state: No element
```

**Category:** BRIDGE-ITERATOR-SUPPORT

**Root Cause Analysis:**

The script is very small (16 lines). It creates a `Path`, adds a `moveTo`/`lineTo` segment, then calls `path1.computeMetrics().first`. The `.first` accessor on the `PathMetrics` iterable throws `Bad state: No element`, meaning the iterable returned by `computeMetrics()` is empty. In native Dart/Flutter, `computeMetrics()` on a path with at least one contour returns a non-empty iterable with one `PathMetric` per contour. In the D4rt bridge, either `computeMetrics()` returns an empty iterable because the bridge does not properly iterate the underlying `PathMetrics` object, or the `.first` accessor on the bridge's iterable wrapper is not correctly implemented.

**Fix Description:**
Implement or fix the `PathMetrics` iterable bridge so that `computeMetrics()` returns a proper iterable that yields `PathMetric` objects for each contour. The bridge needs to support the `Iterator` protocol (`moveNext()` / `current`) and derived accessors like `.first`, `.isEmpty`, `.length` on the `PathMetrics` object returned by `Path.computeMetrics()`.

**Needs Deeper Analysis:** Yes — need to verify whether `PathMetrics` bridge exists and whether it implements the Iterable protocol correctly, specifically `moveNext()`/`current` and the `.first` getter

**Batch Number:** 4

---

### Issue #23

**Script:** `dart_ui/scene_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 203
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
'dart:ui/math.dart': Failed assertion: line 14 pos 10: '<optimized out>': is not true.
```

**Category:** FW-INTERNAL-ASSERTION

**Root Cause Analysis:**

The script (1484 lines) is a complex Scene composition studio that uses `SceneBuilder` to construct layered scenes with `pushTransform`, `pushOpacity`, `pushClipRect`, `pushClipRRect`, `pushClipPath`, `addPicture`, and then rasterizes via `scene.toImage()` / `scene.toImageSync()`. The assertion comes from `dart:ui/math.dart` line 14 — this is a Flutter engine internal math validation (likely a range/NaN/finite check) that fires during the scene rasterization pipeline. The script uses `math.cos`, `math.sin`, `math.pi`, `math.max`, `math.min` extensively for orbit calculations, transform matrices, and star-path generation. An `<optimized out>` assertion message means the engine's debug assertion lost the expression text at compile time.

The most likely trigger is that a computed value (such as a transform matrix element or an opacity clamped to `(opacity * 255).round().clamp(0, 255)`) passes through a `dart:ui` internal math check that expects values within a specific range, and some floating-point edge case (e.g., very small scale or rotation producing a subnormal value) triggers the assertion during the scene's `toImage` or `toImageSync` call.

**Fix Description:**
Add explicit finite-value guards in the D4rt bridge's `SceneBuilder.pushTransform` and `SceneBuilder.pushOpacity` implementations to validate that all matrix elements are finite and opacity values are within `[0, 255]` before forwarding to the engine. For the script side, ensure the `Float64List` transform matrix elements are clamped to reasonable ranges (e.g., `clampDouble(value, -1e6, 1e6)`) to prevent edge-case floating-point values from reaching the engine's internal math assertions.

**Needs Deeper Analysis:** Yes — need to reproduce with specific parameter combinations to identify exactly which math check fails; the `<optimized out>` message obscures the actual assertion condition

**Batch Number:** 4

---

### Issue #24

**Script:** `dart_ui/semantics_action_event_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 204
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `A RenderFlex overflowed by 24 pixels on the right.`
2. `A RenderFlex overflowed by 158 pixels on the right.`

**Category:** FW-LAYOUT-OVERFLOW

**Root Cause Analysis:**

The script (1413 lines) is a comprehensive SemanticsActionEvent demo with multiple `Wrap` and `Row` containers holding fixed-width `SizedBox` children (e.g., `SizedBox(width: 250)`, `SizedBox(width: 260)`, `SizedBox(width: 160)`). While `Wrap` handles overflow by wrapping to new lines, the script also contains several `Row` widgets (lines 310, 770, 862, 1048) with children that have fixed widths or text content that can exceed the available horizontal space. When the D4rt interpreter renders the script in a constrained viewport, two of these `Row` widgets produce overflow: one by 24 pixels (a tight fit where children barely exceed the width) and one by 158 pixels (a wider layout mismatch). The `_SemanticsMapPainter` custom painter section calculates node positions using `42 + t * (size.width - 84)` which could also produce painting outside bounds, but the logged errors specifically cite `RenderFlex` (Row/Column), not CustomPaint.

**Fix Description:**
Wrap overflow-prone `Row` children in `Flexible` or `Expanded` to allow them to shrink within the available space. Alternatively, replace `Row` with `Wrap` for sections containing multiple fixed-width children (such as the miniMetric cards at ~line 940). For text-heavy Row children, add `overflow: TextOverflow.ellipsis` and `maxLines: 1` to prevent text from pushing the Row beyond bounds.

**Needs Deeper Analysis:** No — standard RenderFlex overflow from fixed-width children in constrained viewport

**Batch Number:** 4

---

## Batch 5

### Issue #25

**Script:** `dart_ui/string_attribute_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 211
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

1. `A RenderFlex overflowed by 4.0 pixels on the bottom.`

**Category:** FW-LAYOUT-OVERFLOW

**Root Cause Analysis:**

The script (956 lines) is a comprehensive StringAttribute demo using `MaterialApp > Scaffold > SingleChildScrollView > Column` with many helper widget sections (`_buildHeader`, `_buildClassHierarchy`, `_buildSpellOutDemo`, `_buildLocaleDemo`, etc.). The 4px bottom overflow is a minor vertical overflow from one of the `Column` children — likely a section with tightly packed content where the combined height of children slightly exceeds the available vertical space in a `Row` or nested `Column` that has constrained height. Since the outer layout uses `SingleChildScrollView`, this is not the outer column but an inner container with a fixed or constrained height where the content exceeds by exactly 4 pixels.

**Fix Description:**
Identify the inner container with constrained height that causes the 4px overflow and either increase its height by ~8 pixels or wrap its content in a `SingleChildScrollView` / `Flexible`. Alternatively, reduce padding or font size marginally in the tight section. The overflow is cosmetic (4px) and does not affect functionality.

**Needs Deeper Analysis:** No — minor cosmetic RenderFlex bottom overflow in a constrained inner container

**Batch Number:** 5

---

### Issue #26

**Script:** `dart_ui/target_image_size_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 213
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `A RenderFlex overflowed by 16 pixels on the bottom.`
2. `A RenderFlex overflowed by 16 pixels on the bottom.`

**Category:** FW-LAYOUT-OVERFLOW

**Root Cause Analysis:**

The script (899 lines) is a TargetImageSize demo with many sections containing `Row` widgets with `Expanded` children (`_buildAspectRatioBox` calls at line 355–359) and helper functions that build visual boxes representing image sizes. The two 16px bottom overflows come from inner containers or `Column` sections where the content height exceeds the available space. The script uses `SingleChildScrollView` as the outer wrapper, so the overflow is in nested containers with constrained heights (e.g., the aspect ratio visualization boxes or size comparison cards that have a fixed height but content that overflows by 16 pixels).

**Fix Description:**
Add `clipBehavior: Clip.hardEdge` to the overflowing containers, or increase the container heights by ~20 pixels to accommodate the content. Alternatively, reduce internal padding in the affected sections.

**Needs Deeper Analysis:** No — standard RenderFlex bottom overflow in constrained inner containers, same pattern as Issue #25

**Batch Number:** 5

---

### Issue #27

**Script:** `gestures/vertical_multi_drag_gesture_recognizer_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 255
**Result:** success (test passed)
**Errors:** 3 framework errors (log-only)

**Error Messages:**

1–3. `Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _VerticalTrackState.)` (×3)

**Category:** INTERPRETER-STATE-WIDGET-ACCESS

**Root Cause Analysis:**

The script (94 lines) defines a `_VerticalTrack` StatefulWidget with `_VerticalTrackState` that accesses `widget.color` and `widget.label` in its `build` method. The D4rt interpreter cannot resolve the `widget` property on interpreted `State` subclasses — this is the same issue as Issue #17. The error fires 3 times because there are 3 instances of `_VerticalTrack` ('A', 'B', 'C') in the `Row`, each triggering the same `widget` property access failure. The `_VerticalTrackState.build()` method references `widget.color` (line 82), `widget.label` (line 84), and `widget.color` again (line 82 via `withAlpha`).

**Fix Description:**
Fix the D4rt interpreter's `State` class bridge to correctly expose the `widget` getter on interpreted State subclasses. The `widget` property should return the associated StatefulWidget instance. This is a known interpreter limitation where interpreted classes extending native bridge classes (like `State<T>`) cannot access inherited getters that are backed by the framework's internal state management.

**Needs Deeper Analysis:** No — same INTERPRETER-STATE-WIDGET-ACCESS as Issue #17

**Batch Number:** 5

---

### Issue #28

**Script:** `material/scaffold_messenger_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 311
**Result:** failure (test FAILED)
**Errors:** 1 test failure

**Error Message:**

```
Expected: true
  Actual: <false>
Expected Widget but got InterpretedInstance
```

**Category:** INTERPRETER-INTERPRETED-CLASS-COERCION

**Root Cause Analysis:**

The script (1359 lines) defines multiple `StatelessWidget` and `StatefulWidget` subclasses (`ScaffoldMessengerDemoApp`, `ScaffoldMessengerWrapper`, `SectionHeader`, `BasicSnackBarControls`, `CustomSnackBarControls`, `MaterialBannerControls`, `AdvancedMessengerControls`). The `build` function returns `ScaffoldMessengerDemoApp()` — an instance of an interpreted class that extends `StatelessWidget`. The test framework expects a `Widget` but receives an `InterpretedInstance` because the D4rt interpreter does not automatically coerce interpreted class instances to their native supertype. When the interpreter creates an instance of `ScaffoldMessengerDemoApp`, the result is an `InterpretedInstance` object rather than an actual `Widget` subclass, so the `is Widget` check fails.

**Fix Description:**
Add type coercion in the D4rt bridge layer so that interpreted class instances extending native Widget classes (StatelessWidget, StatefulWidget) are automatically wrapped or registered as proper Widget instances. The bridge needs to recognize that `InterpretedInstance` objects whose interpreted class extends `StatelessWidget` or `StatefulWidget` should be treated as Widgets for type-checking purposes. This may require a UserBridge registration for the interpreted class → Widget relationship.

**Needs Deeper Analysis:** Yes — need to investigate the interpreted class instantiation path and determine the best coercion strategy (UserBridge wrapper vs automatic type-check override)

**Batch Number:** 5

---

### Issue #29

**Script:** `material/text_button_theme_data_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 325
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

1. `Runtime Error: Cannot invoke method 'toStringAsFixed' on null. Use '?.' for null-aware method invocation.`

**Category:** INTERPRETER-NULL-PROPERTY-RESOLUTION

**Root Cause Analysis:**

The script (1835 lines) builds a comprehensive TextButtonThemeData demo. The error occurs in the `_stateDiagnosticText` function (line ~1193–1197) which resolves `ButtonStyle` properties via `.resolve(states)` and then chains `.toStringAsFixed()`. The code uses null-safe operators (`?.`) in most places (e.g., `textStyle?.fontSize?.toStringAsFixed(1)`), but some chains like `side?.width.toStringAsFixed(1)` assume that if `side` is non-null then `side.width` is also non-null. In the D4rt interpreter, the `BorderSide.width` property or `Size.width`/`Size.height` property may resolve to null instead of a double because the bridge does not correctly resolve these numeric properties on the native objects. Alternatively, one of the `_buildSlider` calls (line ~715–743) passes a variable that the interpreter evaluates as null instead of the expected double value.

**Fix Description:**
Ensure the D4rt bridge correctly resolves numeric properties (`width`, `height`, `fontSize`) on native Flutter objects like `BorderSide`, `Size`, and `TextStyle` so they return non-null doubles. The bridge getter implementations for these properties should return the actual numeric value rather than null. As a script-side workaround, change `side?.width.toStringAsFixed(1)` to `side?.width?.toStringAsFixed(1)` and similarly for all `.width`/`.height` chains.

**Needs Deeper Analysis:** Yes — need to determine which specific property chain returns null to pinpoint the exact bridge getter that fails

**Batch Number:** 5

---

## Batch 6

### Issue #30

**Script:** `material/text_selection_toolbar_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 326
**Result:** success (test passed)
**Errors:** 4 framework errors (log-only)

**Error Messages:**

1. `RenderCustomSingleChildLayoutBox object was given an infinite size during layout.`
2. `RenderPadding object was given an infinite size during layout.`
3. `RenderTransform object was given an infinite size during layout.`
4. `'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`

**Category:** FW-LAYOUT-CONSTRAINT

**Root Cause Analysis:**

The script (1559 lines) renders `TextSelectionToolbar` widgets inside `Positioned` children within a `Stack`. The `Positioned` widgets specify only `left` and `top` offsets (e.g., `left: 28, top: 296`) without constraining `right`/`bottom`/`width`/`height`. This gives the `TextSelectionToolbar` unbounded constraints from the Stack. `TextSelectionToolbar` internally uses `CustomSingleChildLayout` which tries to be as big as possible — when given infinite constraints, the `RenderCustomSingleChildLayoutBox` receives infinite size. The `RenderPadding` and `RenderTransform` errors cascade from the same unbounded ancestor. The semantics assertion (#4) cascades from child objects that never complete layout.

**Fix Description:**
Add explicit width/height constraints to the `Positioned` wrapping the `TextSelectionToolbar`, or add `right` and `bottom` offsets to bound the available space. For example: `Positioned(left: 28, top: 296, right: 28, bottom: 28, child: TextSelectionToolbar(...))`. Alternatively, wrap the toolbar in a `SizedBox` with explicit dimensions.

**Needs Deeper Analysis:** No — standard unbounded-constraint issue from placing TextSelectionToolbar in a partially-constrained Positioned

**Batch Number:** 6

---

### Issue #31

**Script:** `material/text_selection_toolbar_text_button_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 327
**Result:** success (test passed)
**Errors:** 4 framework errors (log-only)

**Error Messages:**

1. `RenderCustomSingleChildLayoutBox object was given an infinite size during layout.`
2. `RenderPadding object was given an infinite size during layout.`
3. `RenderTransform object was given an infinite size during layout.`
4. `'package:flutter/src/rendering/object.dart': Failed assertion: line 5737 pos 14: '!childSemantics.renderObject._needsLayout': is not true.`

**Category:** FW-LAYOUT-CONSTRAINT

**Root Cause Analysis:**

The script (1724 lines) has the identical pattern as Issue #30: `TextSelectionToolbar` inside `Positioned(left: 30, top: 94, ...)` within a `Stack`, with no `right`/`bottom`/`width`/`height`, giving the toolbar unbounded constraints. The cascade of errors (CustomSingleChildLayoutBox → Padding → Transform → semantics assertion) is the same. This script focuses on `TextSelectionToolbarTextButton` but uses the same toolbar container pattern.

**Fix Description:**
Same fix as Issue #30: add explicit `right`/`bottom` offsets or `width`/`height` to the `Positioned` wrapping `TextSelectionToolbar`, or wrap in a bounded `SizedBox`.

**Needs Deeper Analysis:** No — identical pattern as Issue #30

**Batch Number:** 6

---

### Issue #32

**Script:** `painting/decoration_image_painter_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 336
**Result:** failure (test FAILED)
**Errors:** 1 test failure

**Error Message:**

```
Expected: true
  Actual: <false>
Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null
```

**Category:** INTERPRETER-NON-EXHAUSTIVE-SWITCH

**Root Cause Analysis:**

The script (974 lines) defines helper functions `_getBoxFitDescription(BoxFit fit)`, `_getImageRepeatDescription(ImageRepeat repeat)`, and `_getFilterQualityDescription(FilterQuality quality)` that use `switch` statements on enums without a `default` case. In native Dart, these switches are exhaustive (all enum values are covered), so the compiler guarantees a return value. However, the D4rt interpreter does not recognize enum switches as exhaustive — when the interpreter fails to match the enum value in the switch cases (possibly due to different enum representation), the function returns `null` instead of a String. This null is then passed to `Text(null)`, which triggers `Invalid parameter "data": expected String, got Null`. This is a known D4rt interpreter limitation with non-exhaustive switch handling.

**Fix Description:**
Add a `default` case to each switch statement that returns a fallback string (e.g., `default: return fit.name;`). This ensures the function always returns a non-null String even when the D4rt interpreter cannot match the specific enum case. Alternatively, fix the D4rt interpreter's enum matching in switch statements to correctly identify all enum values.

**Needs Deeper Analysis:** No — known D4rt interpreter limitation with non-exhaustive switch on enums

**Batch Number:** 6

---

### Issue #33

**Script:** `painting/image_info_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 342
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `A RenderFlex overflowed by 27 pixels on the bottom.`
2. `A RenderFlex overflowed by 58 pixels on the bottom.`

**Category:** FW-LAYOUT-OVERFLOW

**Root Cause Analysis:**

The script (1178 lines) is an ImageInfo demo. Two inner containers or Column sections have content that exceeds the available vertical space — one by 27 pixels and one by 58 pixels. The outer layout uses `SingleChildScrollView` (based on the pattern), so the overflows occur in nested constrained containers with fixed heights where the content (text + visual elements) exceeds the allocated space. These are cosmetic layout overflows that do not affect test success.

**Fix Description:**
Increase the height of the overflowing containers by ~30px and ~60px respectively, or add `clipBehavior: Clip.hardEdge` to suppress the visual overflow. Alternatively, reduce padding or font size in the affected sections.

**Needs Deeper Analysis:** No — standard cosmetic RenderFlex bottom overflow in constrained containers

**Batch Number:** 6

---

### Issue #34

**Script:** `rendering/box_hit_test_result_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 363
**Result:** failure (test FAILED)
**Errors:** 1 test failure

**Error Message:**

```
Expected: true
  Actual: <false>
Expected Widget but got InterpretedInstance
```

**Category:** INTERPRETER-INTERPRETED-CLASS-COERCION

**Root Cause Analysis:**

The script (1528 lines) defines `_BoxHitTestResultDemoApp extends StatelessWidget` and `_BoxHitTestResultDemoScreen extends StatelessWidget`. The `build()` function returns `_BoxHitTestResultDemoApp()` — an instance of an interpreted class extending `StatelessWidget`. The test framework expects a `Widget` but receives an `InterpretedInstance` because the D4rt interpreter does not coerce interpreted class instances to their native supertype. This is the identical issue as Issue #28.

**Fix Description:**
Same fix as Issue #28: add type coercion in the D4rt bridge layer so that interpreted class instances extending native Widget classes are recognized as proper Widget instances for type-checking purposes. The bridge needs to wrap or register `InterpretedInstance` objects whose class hierarchy includes `StatelessWidget`/`StatefulWidget` as valid Widgets.

**Needs Deeper Analysis:** No — identical INTERPRETER-INTERPRETED-CLASS-COERCION as Issue #28

**Batch Number:** 6

---

## Batch 7

### Issue #35

**Script:** `rendering/custom_painter_semantics_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 370
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `Argument Error: Invalid parameter "semanticsBuilder": expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction`
2. `A RenderFlex overflowed by 3.0 pixels on the bottom.`

**Category:** BRIDGE-INTERPRETED-FUNCTION-COERCION (primary), FW-LAYOUT-OVERFLOW (secondary)

**Root Cause Analysis:**

The script (1281 lines) defines a custom `CustomPainter` class with a `semanticsBuilder` getter that returns a function `(Size) => List<CustomPainterSemantics>`. The D4rt interpreter returns an `InterpretedFunction` for this callback, but the CustomPainter bridge expects a native Dart function type `SemanticsBuilderCallback?` (which is `typedef SemanticsBuilderCallback = List<CustomPainterSemantics> Function(Size size)`). The bridge cannot accept the InterpretedFunction in place of the expected callback type. The secondary overflow (3px bottom) is a minor cosmetic layout issue.

**Fix Description:**
Add callback coercion in the CustomPainter bridge or implement a general InterpretedFunction-to-native-callback wrapper that can invoke the interpreted function when the native callback is called. The semanticsBuilder setter/constructor parameter needs to detect InterpretedFunction and wrap it in a native closure that invokes the interpreted function. For the overflow: increase container height by 5px or add padding reduction.

**Needs Deeper Analysis:** No — standard BRIDGE-INTERPRETED-FUNCTION-COERCION pattern with minor overflow

**Batch Number:** 7

---

### Issue #36

**Script:** `rendering/platform_view_layer_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 383
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `A RenderFlex overflowed by 53 pixels on the right.`
2. `A RenderFlex overflowed by 70 pixels on the right.`

**Category:** FW-LAYOUT-OVERFLOW

**Root Cause Analysis:**

The script (1549 lines) is a platform view layer demo. Two horizontal Row or Flex containers have children whose combined widths exceed the available horizontal space — one by 53 pixels and one by 70 pixels. The outer layout likely has adequate scrolling, but inner constrained containers with fixed width content (buttons, labels, platform view previews) overflow horizontally. These are cosmetic layout overflows that do not affect test success.

**Fix Description:**
Wrap the overflowing Row sections in a `SingleChildScrollView(scrollDirection: Axis.horizontal)` to allow horizontal scrolling, or reduce the content width by removing padding, using smaller widgets, or switching to a `Wrap` layout. Alternatively, increase the parent container width or use `Flexible`/`Expanded` to distribute space.

**Needs Deeper Analysis:** No — standard cosmetic RenderFlex horizontal overflow in constrained containers

**Batch Number:** 7

---

### Issue #37

**Script:** `rendering/relayout_when_system_fonts_change_mixin_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 384
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_RelayoutHostWidget)
```

**Category:** INTERPRETER-INTERPRETED-CLASS-COERCION

**Root Cause Analysis:**

The script (1741 lines) defines `_RelayoutHostWidget extends LeafRenderObjectWidget`. This interpreted class extends a native Flutter widget class. When passed to `Positioned.fill(child: _RelayoutHostWidget(...))`, the bridge receives an `InterpretedInstance` but expects a `Widget`. The D4rt interpreter does not coerce interpreted class instances that extend native Widget subclasses to their native supertype. This is the identical issue pattern as Issues #28, #34.

**Fix Description:**
Same fix as Issue #28: add type coercion in the D4rt bridge layer so that interpreted class instances extending native Widget classes (including `RenderObjectWidget` subclasses like `LeafRenderObjectWidget`) are recognized as proper Widget instances for type-checking purposes.

**Needs Deeper Analysis:** No — identical INTERPRETER-INTERPRETED-CLASS-COERCION as Issue #28

**Batch Number:** 7

---

### Issue #38

**Script:** `rendering/render_absorb_pointer_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 385
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got InterpretedInstance(_AbsorbGateHost)
```

**Category:** INTERPRETER-INTERPRETED-CLASS-COERCION

**Root Cause Analysis:**

The script (1645 lines) defines `_AbsorbGateHost extends SingleChildRenderObjectWidget`. This interpreted class extends a native Flutter widget class. When passed to `Positioned.fill(child: _AbsorbGateHost(...))`, the bridge receives an `InterpretedInstance` but expects a `Widget`. The D4rt interpreter does not coerce interpreted class instances that extend native Widget subclasses to their native supertype. This is the identical issue pattern as Issues #28, #34, #37.

**Fix Description:**
Same fix as Issue #28: add type coercion in the D4rt bridge layer so that interpreted class instances extending native Widget classes (including `SingleChildRenderObjectWidget`) are recognized as proper Widget instances for type-checking purposes.

**Needs Deeper Analysis:** No — identical INTERPRETER-INTERPRETED-CLASS-COERCION as Issue #28

**Batch Number:** 7

---

### Issue #39

**Script:** `rendering/render_aligning_shifted_box_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 386
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Undefined property or method 'characters' on bridged instance of 'String'.
```

**Category:** BRIDGE-STRING-EXTENSION-MISSING

**Root Cause Analysis:**

The script (1410 lines) uses `preset.label.characters.first` at line 946 to extract the first grapheme cluster of a String for display in an avatar. The `characters` extension property on String is provided by Dart's `package:characters` and exposes a `Characters` iterable for proper Unicode grapheme handling. The D4rt String bridge does not implement the `characters` extension getter, causing a runtime error when the script attempts to access it. The error surfaces during iteration (toList call) because the interpreted code likely maps over items that include the characters access.

**Fix Description:**
Add the `characters` extension getter to the D4rt String bridge. The getter should return a `Characters(this)` object or a bridge-wrapped equivalent that provides `first`, `last`, `length`, `iterator`, and other `Characters` methods. Alternatively, for a quick workaround, the script could use `preset.label.substring(0, 1)` instead of `preset.label.characters.first`.

**Needs Deeper Analysis:** No — missing String extension in bridge; implementation path is clear

**Batch Number:** 7

---

## Batch 8

### Issue #40

**Script:** `rendering/render_animated_opacity_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 387
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
Runtime Error: Undefined variable: _controller (Original error: LateInitializationError: Late variable '_controller' without initializer is accessed before being assigned.)
```

**Category:** INTERPRETER-LATE-INIT

**Root Cause Analysis:**

The script (1614 lines) defines `late AnimationController _controller;` at line 202 in a StatefulWidget's State class. The controller is initialized in `initState()` at line 238. The D4rt interpreter does not properly handle late variable initialization flow — when code attempts to access `_controller` during widget construction or before `initState()` completes, the interpreter fails to recognize the deferred initialization pattern. This is the same pattern as previously seen INTERPRETER-LATE-INIT issues.

**Fix Description:**
Either initialize `_controller` inline with a nullable pattern (`AnimationController? _controller;`) and check for null, or ensure the D4rt interpreter correctly supports late variable semantics by tracking initialization state in the Scope. The runtime should defer access validation until actual usage rather than at declaration time.

**Needs Deeper Analysis:** No — known INTERPRETER-LATE-INIT pattern

**Batch Number:** 8

---

### Issue #41

**Script:** `rendering/render_block_semantics_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 392
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `A RenderFlex overflowed by 56 pixels on the bottom.`
2. `A RenderFlex overflowed by 56 pixels on the bottom.`

**Category:** FW-LAYOUT-OVERFLOW

**Root Cause Analysis:**

The script (1404 lines) is a block semantics demo. Two inner containers or Column sections have content that exceeds the available vertical space by exactly 56 pixels each. The overflows likely occur in nested constrained containers where text labels, visual elements, or padding exceed the allocated height. Both overflows are the same magnitude, suggesting two similar UI sections with identical layout constraints. These are cosmetic layout overflows that do not affect test success.

**Fix Description:**
Increase the height of the overflowing containers by ~60px, or add `clipBehavior: Clip.hardEdge` to suppress visual overflow. Alternatively, reduce padding, font sizes, or content density in the affected sections.

**Needs Deeper Analysis:** No — standard cosmetic RenderFlex bottom overflow in constrained containers

**Batch Number:** 8

---

### Issue #42

**Script:** `rendering/render_box_container_defaults_mixin_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 393
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_DefaultsContainer)
```

**Category:** INTERPRETER-INTERPRETED-CLASS-COERCION

**Root Cause Analysis:**

The script (1753 lines) defines `_DefaultsContainer extends MultiChildRenderObjectWidget` at line 1312. When this interpreted class instance is passed to a builder or returned as a widget, the bridge receives an `InterpretedInstance` but expects a native `Widget`. The D4rt interpreter does not coerce interpreted class instances extending native Widget subclasses (including `MultiChildRenderObjectWidget`) to their native supertype. This is the identical issue pattern as Issues #28, #34, #37, #38.

**Fix Description:**
Same fix as Issue #28: add type coercion in the D4rt bridge layer so that interpreted class instances extending native Widget classes are recognized as proper Widget instances for type-checking purposes.

**Needs Deeper Analysis:** No — identical INTERPRETER-INTERPRETED-CLASS-COERCION as Issue #28

**Batch Number:** 8

---

### Issue #43

**Script:** `rendering/render_custom_multi_child_layout_box_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 396
**Result:** success (test passed)
**Errors:** 1 framework error (log-only)

**Error Message:**

```
Runtime Error: Native error during default bridged constructor for 'CustomMultiChildLayout': Argument Error: Invalid parameter "delegate": expected MultiChildLayoutDelegate, got InterpretedInstance(_D…
```

**Category:** INTERPRETER-INTERPRETED-CLASS-COERCION

**Root Cause Analysis:**

The script (1656 lines) defines several delegate classes: `_DashboardDelegate`, `_OrbitDelegate`, `_WaterfallDelegate`, etc., all extending `_BaseDelegate extends MultiChildLayoutDelegate`. When an interpreted delegate is passed to `CustomMultiChildLayout(delegate: _DashboardDelegate(...))`, the bridge receives an `InterpretedInstance` but expects a native `MultiChildLayoutDelegate`. This is the same coercion issue pattern but for non-Widget classes extending native abstract classes.

**Fix Description:**
Extend the D4rt bridge type coercion system to handle non-Widget native class hierarchies. When an interpreted class extends `MultiChildLayoutDelegate` (or other delegate/callback abstract classes), the bridge should recognize the InterpretedInstance as implementing that delegate type and wrap it appropriately for native callback invocation.

**Needs Deeper Analysis:** Yes — requires extending coercion system beyond Widget hierarchy to include delegate pattern classes

**Batch Number:** 8

---

### Issue #44

**Script:** `rendering/render_custom_paint_test.dart`
**Suite:** `secondary_classes`
**Test ID:** 397
**Result:** success (test passed)
**Errors:** 2 framework errors (log-only)

**Error Messages:**

1. `Runtime Error: Undefined variable: mounted (Original error: Native error in bridged mixin getter 'mounted': Argument Error: Invalid target: expected SingleTickerProviderStateMixin, got InterpretedInst…`
2. `Bad state: No element`

**Category:** INTERPRETER-STATE-MIXIN-ACCESS (primary), FW-COLLECTION-EMPTY (secondary)

**Root Cause Analysis:**

The script (1509 lines) defines `_RenderCustomPaintStudioState extends State<...> with SingleTickerProviderStateMixin` at line 138. Line 759 uses `if (!mounted)` to check widget mount state. The D4rt interpreter cannot properly access the `mounted` getter from the `SingleTickerProviderStateMixin` because the bridge expects a native mixin instance but receives an InterpretedInstance. The secondary error "Bad state: No element" occurs at line 1439 where `path.computeMetrics().first` is called — if `computeMetrics()` returns an empty iterable, `.first` throws this error.

**Fix Description:**
For the mixin issue: the State bridge needs to recognize interpreted State subclasses with mixins and properly delegate mixin getter calls. The `mounted` property access should route through the State bridge rather than the mixin bridge. For the collection error: add a guard `if (path.computeMetrics().isNotEmpty)` before accessing `.first`, or use `firstOrNull` extension.

**Needs Deeper Analysis:** Yes — mixin getter resolution in interpreted State classes requires bridge infrastructure work

**Batch Number:** 8

---
