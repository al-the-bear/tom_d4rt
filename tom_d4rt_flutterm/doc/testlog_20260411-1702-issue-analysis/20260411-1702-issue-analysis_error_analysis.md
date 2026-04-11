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
