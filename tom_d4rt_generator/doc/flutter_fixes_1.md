# Flutter Fixes 1 — Fix Plan for Remaining 9 D4rt Flutter Test Failures

**Status:** Plan  
**Date:** 2026-03-24  
**Context:** After multi-session work on the D4rt Flutter integration tests (tom_d4rt_flutterm), test results improved from 222 passed / 30 failed to **263 passed / 9 failed**. This document is the detailed fix plan for the remaining 9 failures.

---

## 1. Remaining Failures Overview

| # | Suite | Test File | Widget/Class | Error Summary |
|---|-------|-----------|-------------|---------------|
| 1 | Essential | tween_test.dart | `TweenSequence<double>` | `TweenSequenceItem<dynamic>` → `TweenSequenceItem<double>` cast fails |
| 2 | Essential | animation_test.dart | `TweenSequence<double>` | Same as #1 |
| 3 | Essential | dropdown_test.dart | `DropdownButton<String>` | `DropdownMenuItem<Object>` → `DropdownMenuItem<String>` cast fails |
| 4 | Essential | formcontrols_test.dart | `Radio<String>` | `WidgetStatePropertyAll<dynamic>` → `WidgetStateProperty<Color?>?` cast fails |
| 5 | Important | segmentedbutton_test.dart | `SegmentedButton<String>` | `ButtonSegment<dynamic>` → `ButtonSegment<String>` cast fails |
| 6 | Important | dropdownform_test.dart | `DropdownButtonFormField<String>` | `DropdownMenuItem<Object>` → `DropdownMenuItem<String>` cast fails |
| 7 | Important | misc_themes_test.dart | `PageTransitionsTheme` | `Map<Object?, Object?>` not accepted as `Map<TargetPlatform, PageTransitionsBuilder>` |
| 8 | Important | tweensequence_test.dart | `TweenSequenceItem<Color>` | `ColorTween` → `Animatable<Color>?` cast fails |
| 9 | Important | channels_test.dart | `BasicMessageChannel<String>` | `(dynamic) => Future<dynamic>` not subtype of `((String?) => Future<String>)?` |

---

## 2. Root Cause Analysis

### 2.1 Nested Generic Type Erasure in Collections (Failures #1–#6)

**What happens:**

1. D4rt script creates `TweenSequenceItem<double>(tween: myTween, weight: 50)`
2. The RC-2 factory `_rc2TweenSequenceItem` dispatches on `typeArgs.first.name == 'double'` and constructs a native `TweenSequenceItem<double>`. The native object has the correct type.
3. The interpreter wraps the result as `BridgedInstance(bridgedClass, nativeObject)` — BridgedInstance stores the native object but does **not** store `typeArguments`.
4. These BridgedInstances are collected into a D4rt list (`List<Object?>`).
5. The list is passed to `TweenSequence<double>(items: [...])`.
6. The RC-2 factory for `TweenSequence<double>` calls `D4.coerceList<TweenSequenceItem<double>>(items, 'items')`.
7. `D4.coerceList` detects each element is a `BridgedInstance` and unwraps: `e.nativeObject as T`.
8. **This succeeds** because the native object IS `TweenSequenceItem<double>`.

**Wait — then why does it fail?** The error message says `TweenSequenceItem<dynamic>`, not `TweenSequenceItem<double>`. This means one of two things:

- **Scenario A:** The test script creates items WITHOUT explicit type arguments (`TweenSequenceItem(...)` instead of `TweenSequenceItem<double>(...)`). Without `<double>` in the source, the interpreter doesn't pass `typeArgs`. The RC-2 factory returns `null` (typeName == null). The fallback regular bridge constructor creates `TweenSequenceItem<dynamic>`.
- **Scenario B:** The regular bridge constructor is what creates the items — it has no type dispatch at all and always produces `<dynamic>`.

Either way, the native objects end up as `TweenSequenceItem<dynamic>`. Dart's reified generic system means `TweenSequenceItem<dynamic>` is NOT a subtype of `TweenSequenceItem<double>`, so the `as T` cast fails.

**DropdownMenuItem variant (failures #3, #6):** DropdownMenuItem's regular bridge constructor creates `DropdownMenuItem<Object>` (the class has a bridge-level default of `Object`). Without relaxer wrapper resolution, `DropdownMenuItem<Object>` cannot be cast to `DropdownMenuItem<String>`.

**WidgetStateProperty variant (failure #4):** `WidgetStatePropertyAll<dynamic>` is not a `WidgetStateProperty<Color?>`. This isn't in a list — it's a direct named parameter on `Radio`. The `D4.extractBridgedArg<WidgetStateProperty<Color?>>` call SHOULD invoke GEN-079 wrapper resolution (`_genericTypeWrappers['WidgetStateProperty']`), since a wrapper factory IS registered. However, the factory receives `WidgetStatePropertyAll<dynamic>` as input, and `WidgetStatePropertyAll` is a subclass of `WidgetStateProperty`. The factory may not handle this subclass correctly — or the inner type argument mismatch (`dynamic` vs `Color?`) may cause the `is T` check to fail even after wrapping.

**ButtonSegment variant (failure #5):** `ButtonSegment<dynamic>` → `ButtonSegment<String>`. Critically, `ButtonSegment` does **not** have a registered `registerGenericTypeWrapper` or a `$Relaxed` wrapper class. The relaxer generator skipped it (likely because it wasn't found in `genericExtractionSites`). Without a wrapper, there's no way to re-type a `ButtonSegment<dynamic>` as `ButtonSegment<String>`.

### 2.2 Non-RC2 Map Coercion (Failure #7)

**What happens:**

1. `PageTransitionsTheme` is a non-generic class with a constructor parameter `builders: Map<TargetPlatform, PageTransitionsBuilder>`.
2. The generated bridge uses **combinatorial dispatch** (because `builders` has a non-wrappable default value).
3. In the "builders present" branch, the parameter is extracted via `D4.getRequiredNamedArg<Map<TargetPlatform, PageTransitionsBuilder>>(...)`.
4. `getRequiredNamedArg` → `extractBridgedArg` → unwraps BridgedInstance at top level → tries `unwrapped is Map<TargetPlatform, PageTransitionsBuilder>`.
5. The unwrapped value is `Map<Object?, Object?>` because D4rt map literals have erased key/value types. The `is` check fails.
6. `extractBridgedArg` has GEN-079 wrapper resolution for generic types, but `Map` is not a registered wrapper factory type — it's handled separately by `coerceMap`.
7. `extractBridgedArg`'s own map coercion path (INTER-004 at ~line 795) only handles `Map` → `Map` when `T` is generic `Map<K,V>`, but it doesn't coerce enum keys or arbitrary typed map args adequately.

**Root cause in the generator:** The `_generateCombinatorialDispatch` method in `bridge_generator.dart` (~line 7964) checks for `_isListType` and function types, but has **no branch for `_isMapType` or `_isSetType`**. So map-typed parameters in combinatorial-dispatch constructors use `getRequiredNamedArg` with the full type, which fails.

### 2.3 Bridge Inheritance + Nullability Cast Failure (Failure #8)

**What happens:**

1. Test creates `ColorTween(begin: Colors.red, end: Colors.blue)` — the bridge constructs a native `ColorTween`.
2. The `ColorTween` is passed as the `tween` parameter to `TweenSequenceItem<Color>(tween: colorTween, weight: 50)`.
3. The RC-2 factory for `TweenSequenceItem<Color>` extracts `tween` and casts: `tween as Animatable<Color>?`.
4. **Cast fails.** `ColorTween extends Tween<Color?> extends Animatable<Color?>`. The native hierarchy has `Color?` (nullable), but the RC-2 case requires `Animatable<Color>` (non-nullable). `Animatable<Color?>` is NOT `Animatable<Color>` due to Dart's reified generics.

**Root cause:** The RC-2 switch case for `'Color'` substitutes `T` → `Color` (non-nullable) throughout, producing `Animatable<Color>`. But `Tween<Color?>` and `ColorTween` use `Color?` (nullable). The substitution doesn't account for nullability differences between the declared type parameter and the actual superclass type arguments.

### 2.4 Generic Class Method Function Typing (Failure #9)

**What happens:**

1. Test creates `BasicMessageChannel<String>('test', StringCodec())` via RC-2, producing a native `BasicMessageChannel<String>`.
2. Test calls `channel.setMessageHandler((String? msg) async => 'reply')`.
3. The bridge method dispatch at `services_bridges.b.dart:9421` generates:
   ```dart
   t.setMessageHandler(handlerRaw == null ? null :
     (dynamic p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<dynamic>; });
   ```
4. The wrapper closure has type `(dynamic) => Future<dynamic>`.
5. The native `BasicMessageChannel<String>.setMessageHandler` expects `((String?) => Future<String>)?`.
6. `Future<dynamic>` is **not** a subtype of `Future<String>` in Dart, so the assignment fails.

**Root cause chain:**
- The bridge generator registers `BasicMessageChannel` as a non-parametric bridge (class-level T is erased)
- Method bridges use `dynamic` for all T-involving parameter and return types
- The method adapter signature receives `typeArgs` (method-level), but `BasicMessageChannel<String>.setMessageHandler` has no method-level type params — T comes from the class
- The bridge has no access to the class-level type argument that was used during construction
- `BridgedInstance.typeArguments` is always `const []` — never populated

---

## 3. Fix Plan

### Fix A — GEN-079 Wrapper Resolution in `D4.coerceList` / `D4.coerceMap`

**Component:** `tom_d4rt` — `lib/src/generator/d4.dart`  
**Fixes failures:** #1, #2, #3, #5, #6 (and future similar issues)  
**Priority:** HIGH — fixes 5 of 9 failures with a single change  
**Estimated effort:** Small  

**What to change:**

In `D4.coerceList<T>()`, after the `e.nativeObject as T` cast attempt fails (and before rethrowing), add GEN-079 wrapper resolution for elements. This is the same logic already in `extractBridgedArg` at lines 741–757, applied to each list element.

**Detailed implementation:**

```dart
// In D4.coerceList<T>(), inside the element mapping lambda,
// after unwrapping BridgedInstance and before the final `e as T`:

// GEN-079: Generic wrapper resolution for list elements.
// When T is a generic type (e.g., TweenSequenceItem<double>) and the
// element is the correct base type but with wrong type args
// (e.g., TweenSequenceItem<dynamic>), use registered wrapper factories
// to create a properly typed proxy.
final unwrapped = e is BridgedInstance ? e.nativeObject : e;
if (unwrapped != null && _genericTypeWrappers.isNotEmpty) {
  final tStr = T.toString();
  String baseT = tStr;
  while (baseT.endsWith('?')) baseT = baseT.substring(0, baseT.length - 1);
  if (baseT.contains('<')) {
    final baseTypeName = baseT.substring(0, baseT.indexOf('<'));
    final factories = _genericTypeWrappers[baseTypeName];
    if (factories != null) {
      final innerTypeArg = baseT.substring(
        baseT.indexOf('<') + 1,
        baseT.lastIndexOf('>'),
      );
      for (final factory in factories) {
        final wrapped = factory(unwrapped, innerTypeArg);
        if (wrapped is T) return wrapped;
      }
    }
  }
}
```

Insert this block right before the final `return e as T;` fallback in the `coerceList` element mapper, and similarly in `coerceSet` if Set variants of these failures exist.

**Why this works:** For `D4.coerceList<TweenSequenceItem<double>>(items)`:
- Each element is unwrapped from BridgedInstance → `TweenSequenceItem<dynamic>` native object
- `e.nativeObject as TweenSequenceItem<double>` fails (type erasure)
- GEN-079 kicks in: parses `T` = `TweenSequenceItem<double>`, base = `TweenSequenceItem`, inner = `double`
- Finds the registered factory `_relaxTweenSequenceItem$animation`
- Factory creates `$RelaxedTweenSequenceItem<double>(innerObject)` which extends `TweenSequenceItem<double>`
- `wrapped is TweenSequenceItem<double>` passes → returns wrapped element

**Missing wrappers:** `ButtonSegment` and `DropdownMenuItem` currently have NO relaxer wrappers or `registerGenericTypeWrapper` calls. See Fix B.

---

### Fix B — Generate Relaxer Wrappers for All RC-2 Generic Classes

**Component:** `tom_d4rt_generator` — `lib/src/relaxer_generator.dart`  
**Fixes failures:** #3, #5, #6 (prerequisite for Fix A to work on these)  
**Priority:** HIGH — ensures all RC-2 generic classes get wrapper factories  
**Estimated effort:** Medium  

**What to change:**

Currently, relaxer wrappers are only generated for classes that appear in `genericExtractionSites` (i.e., classes whose type parameter appears in `extractBridgedArg<Foo<T>>` call sites during bridge generation). `ButtonSegment` and `DropdownMenuItem` don't appear there because they're only ever passed as list elements, not as direct typed arguments.

Add a second source of relaxer targets: **all classes that have an RC-2 generic constructor factory** (`gen075Classes`). If a class has RC-2, it can be constructed with erased type args, so it needs a wrapper for later re-typing.

**Detailed implementation:**

In `_buildRelaxerTargets()`, after processing `genericExtractionSites`, iterate `gen075Classes` and add any missing entries:

```dart
// Step 2b: Ensure all gen075/RC-2 classes also get relaxer wrappers.
// These classes can be constructed with erased type args and may need
// re-wrapping when passed into typed collection parameters.
for (final className in gen075Classes) {
  if (targets.any((t) => t.classInfo.name == className)) continue;
  final classInfo = globalClassLookup[className];
  if (classInfo == null) continue;
  if (classInfo.typeParameters.length != 1) continue; // only single-T
  targets.add(RelaxerTarget(
    classInfo: classInfo,
    extractionSites: [], // no direct extraction sites, but needed for collections
  ));
}
```

This ensures `ButtonSegment`, `DropdownMenuItem`, and any other RC-2 class missing a relaxer wrapper gets one.

**Alternative approach:** Instead of adding to `_buildRelaxerTargets()`, we could use the already-existing `gen075Classes` set (which IS passed to `generateRelaxers`) more aggressively. The relaxer generator already has access to this data but only uses it for RC-2 constructor factory generation, not for wrapper class generation. Extending it to also trigger wrapper generation makes the fix self-maintaining — any new RC-2 class automatically gets a wrapper.

---

### Fix C — Map and Set Coercion in Combinatorial Dispatch

**Component:** `tom_d4rt_generator` — `lib/src/bridge_generator.dart`  
**Fixes failure:** #7  
**Priority:** MEDIUM  
**Estimated effort:** Small  

**What to change:**

In `_generateCombinatorialDispatch()` (~line 7964), the "param present" branch checks for `_isListType` and function types but not Maps or Sets. Add branches for both.

**Detailed implementation:**

In the combinatorial dispatch param extraction, after the existing `_isListType` check:

```dart
// Existing:
if (_isListType(param.type)) {
  // ... D4.coerceList<ElementType>(...)
}
// Add:
else if (_isMapType(param.type)) {
  final typeArgs = _getMapTypeArgs(param.type, importPrefix);
  final keyType = typeArgs.$1;
  final valueType = typeArgs.$2;
  buffer.writeln(
    "          final $localName = D4.coerceMap<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
  );
}
else if (_isSetType(param.type)) {
  final elementType = _getSetElementType(param.type, importPrefix);
  buffer.writeln(
    "          final $localName = D4.coerceSet<$elementType>(named['${param.name}'], '${param.name}');",
  );
}
```

**Also apply the same fix in `_generateNamedParamExtraction()`** — the non-combinatorial constructor path. Search for any other code path where map-typed constructor parameters are extracted with `getRequiredNamedArg` or `getOptionalNamedArg` instead of `coerceMap`, and add map coercion there too.

**Why this works:** `D4.coerceMap<TargetPlatform, PageTransitionsBuilder>(...)` unwraps BridgedEnumValue keys (getting native `TargetPlatform` enum values) and BridgedInstance values (getting native `PageTransitionsBuilder` objects), producing a correctly-typed Map.

---

### Fix D — Nullability-Aware Type Substitution in RC-2 Case Generation

**Component:** `tom_d4rt_generator` — `lib/src/relaxer_generator.dart`  
**Fixes failure:** #8  
**Priority:** MEDIUM  
**Estimated effort:** Medium  

**What to change:**

The RC-2 `_writeRC2Case` method substitutes the type parameter T with the concrete type for each switch case. When T = `Color`, it generates `Animatable<Color>` for the `tween` parameter. But the actual Dart class `Tween<Color?>` uses nullable `Color?`, and `Animatable<Color?>` ≠ `Animatable<Color>`.

The fix has two complementary parts:

**Part 1 — Use `extractBridgedArg` instead of raw `as` cast for non-collection params:**

Currently, RC-2 cases cast with `safeName as Animatable<Color>?`. Replace this with `D4.extractBridgedArg<Animatable<Color>?>(safeName, 'tween')`. The `extractBridgedArg` method has GEN-079 wrapper resolution that can create `$RelaxedAnimatable<Color>(colorTween)` which IS `Animatable<Color>`.

In `_writeRC2Case`, for parameters that are generic types (contain the class type param, e.g., `Animatable<T>`), generate:

```dart
// Instead of: tween as Animatable<Color>?
// Generate:   D4.extractBridgedArg<Animatable<Color>?>(tween, 'tween')
```

This leverages the existing GEN-079 wrapper infrastructure. The `$RelaxedAnimatable<Color>` wrapper can accept a `ColorTween` (which is `Animatable<Color?>`) as inner object and re-expose it with `Color` type parameter.

**Part 2 — Relaxer wrapper nullable inner type tolerance:**

The `$RelaxedTweenSequenceItem<V>` constructor does:
```dart
$RelaxedTweenSequenceItem(this._inner)
    : super(tween: _inner.tween as Animatable<V>, weight: _inner.weight);
```

If V = `Color` but `_inner.tween` is `Animatable<Color?>`, this cast also fails. The relaxer wrapper's `super()` call needs to handle nullability:
- In the relaxer generator `_generateWrapperClass()`, when emitting the super constructor call, detect if a field type has `T` in a covariant position and cast via `extractBridgedArg` instead of raw `as`.
- Or, more practically: the `super()` call can use `_inner.tween as dynamic` and rely on runtime dispatch. Since `TweenSequenceItem` only reads `tween` (never writes), this is safe.

**Alternative simpler approach:** In the RC-2 switch body, when substituting type arguments in nested positions, append `?` to make the substitution nullable-aware. E.g., for `Animatable<T>` where T = `Color`, check if known Dart SDK classes use `T?` in that position and generate `Animatable<Color?>?` instead. This requires a lookup table of known nullable type parameter usages but would avoid the issue entirely.

---

### Fix E — Store Class Type Arguments on BridgedInstance

**Component:** `tom_d4rt` — `lib/src/interpreter_visitor.dart`  
**Fixes failure:** #9 (prerequisite)  
**Priority:** HIGH — enables Fix F  
**Estimated effort:** Small  

**What to change:**

In `visitInstanceCreationExpression`, the RC-2 constructor path (~line 8375) and the regular constructor path (~line 8427) both create `BridgedInstance(bridgedClass, nativeObject)` WITHOUT passing `typeArguments`. The `evaluatedTypeArguments` are available in scope but never stored.

**Detailed implementation:**

```dart
// Line 8375 (RC-2 path):
// Before:
final bridgedInstance = BridgedInstance(bridgedClass, nativeObject);

// After:
final bridgedInstance = BridgedInstance(
  bridgedClass,
  nativeObject,
  typeArguments: evaluatedTypeArguments ?? const [],
);
```

Same for line 8427 (regular constructor path).

Also, in the GEN-075 path where type is inferred from a positional parameter's runtime type (inside the bridge constructor itself), the bridge constructor can call `D4.setLastConstructedTypeArgs([inferredTypeName])` which the interpreter picks up after the constructor returns. This is more complex and may not be needed initially.

**Why this matters:** Once `BridgedInstance.typeArguments` is populated, method adapters can read the target's class-level type arguments and use them for typed dispatch. This is the foundation for Fix F.

---

### Fix F — Type-Aware Method Dispatch for Generic Classes

**Component:** `tom_d4rt_generator` — `lib/src/bridge_generator.dart`  
**Fixes failure:** #9  
**Priority:** HIGH  
**Estimated effort:** Large  
**Depends on:** Fix E  

**What to change:**

For generic classes like `BasicMessageChannel<T>`, the bridge generator currently erases T to `dynamic` in method adapters. The `setMessageHandler` wrapper creates `(dynamic p0) => ... as Future<dynamic>`, but the native method expects `(String?) => Future<String>` when T=String.

**Approach: Instance-level type dispatch in method adapters.**

When the generator detects that a method involves the class type parameter T (in parameter types or return type), generate a type-dispatch switch similar to RC-2:

```dart
'setMessageHandler': (visitor, target, positional, named, typeArgs) {
  final t = D4.validateTarget<BasicMessageChannel>(target, 'BasicMessageChannel');
  final handlerRaw = positional[0];

  // Read class-level type argument from BridgedInstance
  final classTypeArg = (target is BridgedInstance && target.typeArguments.isNotEmpty)
      ? target.typeArguments.first.name
      : null;

  switch (classTypeArg) {
    case 'String':
      t.setMessageHandler(handlerRaw == null ? null :
        (String? p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0])
          .then<String>((v) => v as String); });
    case 'int':
      t.setMessageHandler(handlerRaw == null ? null :
        (int? p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0])
          .then<int>((v) => v as int); });
    // ... cases for all known type specializations
    default:
      t.setMessageHandler(handlerRaw == null ? null :
        (dynamic p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0])
          as Future<dynamic>; });
  }
  return null;
},
```

**Detailed implementation in the generator:**

1. In `_generateMethodBody()`, detect if the method references the class type parameter(s).
2. If it does, generate a preamble that reads the instance's stored type arguments from `BridgedInstance`.
3. Generate a switch on the type argument name.
4. In each case, emit the method call with correctly typed function wrappers and casts.
5. The default case falls back to `dynamic` (backward compatible).

**Optimization:** Only generate type-dispatch for methods that actually involve T in function-typed parameters or generic return types. Simple `T` parameters/returns can use `extractBridgedArg` + runtime coercion without full dispatch.

**Scope consideration:** This is the most complex fix. Consider limiting the initial implementation to function-typed parameters that involve T (where the type mismatch causes runtime failures), rather than all T-involving methods. Return types like `Future<T>` from `send()` are also affected but might not cause failures if the caller doesn't strictly type-check the result.

---

### Fix G — Enhance `D4.extractBridgedArg` Map Coercion

**Component:** `tom_d4rt` — `lib/src/generator/d4.dart`  
**Supports fix for:** #7 (complementary to Fix C)  
**Priority:** LOW  
**Estimated effort:** Small  

**What to change:**

The INTER-004 collection casting path in `extractBridgedArg` (~line 795) handles `Map` but uses basic element unwrapping. Enhance it to use `coerceMap` internally for typed Map extraction:

```dart
// When T is Map<K,V> and unwrapped is Map<Object?, Object?>:
if (unwrapped is Map && baseT.startsWith('Map<')) {
  // Parse K and V from T.toString() and delegate to coerceMap
  return D4.coerceMap<K, V>(unwrapped, 'arg') as T;
}
```

This is a safety net for cases where combinatorial dispatch (Fix C) isn't involved — e.g., non-combinatorial constructors and method calls with typed Map parameters.

---

## 4. Implementation Order and Dependencies

```
Phase 1 — Foundation (tom_d4rt)
├─ Fix E: Store typeArguments on BridgedInstance          [Small, enables Fix F]
├─ Fix A: GEN-079 resolution in coerceList/coerceSet      [Small, high impact]
└─ Fix G: Map coercion in extractBridgedArg               [Small, safety net]

Phase 2 — Generator (tom_d4rt_generator)
├─ Fix B: Relaxer wrappers for all RC-2 classes           [Medium, enables Fix A for #3/#5/#6]
├─ Fix C: Map/Set coercion in combinatorial dispatch      [Small, direct fix for #7]
└─ Fix D: Nullability-aware RC-2 type substitution        [Medium, fixes #8]

Phase 3 — Advanced Generator (tom_d4rt_generator)
└─ Fix F: Type-aware method dispatch for generic classes  [Large, fixes #9, depends on Fix E]

Regenerate + Test
└─ Rebuild generator, regenerate all bridges, run tests
```

**Expected outcome by fix:**

| Fix | Failures Fixed | Test Count |
|-----|---------------|------------|
| A + B | #1, #2, #3, #5, #6 | 5 |
| C (+ G) | #7 | 1 |
| D | #8 | 1 |
| E + F | #9 | 1 |
| **Total** | **#1–#9** | **9** |

If all fixes succeed: **272 passed, 0 failed** (from original 222/30).

---

## 5. Component Change Summary

### tom_d4rt (interpreter runtime)

| File | Change | Fix |
|------|--------|-----|
| `lib/src/generator/d4.dart` | Add GEN-079 wrapper resolution inside `coerceList` element mapping | A |
| `lib/src/generator/d4.dart` | Add GEN-079 wrapper resolution inside `coerceSet` element mapping | A |
| `lib/src/generator/d4.dart` | Enhance INTER-004 Map coercion to use `coerceMap` for typed Map extraction | G |
| `lib/src/interpreter_visitor.dart` | Pass `evaluatedTypeArguments` to `BridgedInstance` constructor in RC-2 + regular paths | E |

### tom_d4rt_generator (code generator)

| File | Change | Fix |
|------|--------|-----|
| `lib/src/relaxer_generator.dart` | Extend `_buildRelaxerTargets()` to include all `gen075Classes` | B |
| `lib/src/bridge_generator.dart` | Add `_isMapType` + `_isSetType` branches in `_generateCombinatorialDispatch()` | C |
| `lib/src/bridge_generator.dart` | Add Map/Set branches in `_generateNamedParamExtraction()` where missing | C |
| `lib/src/relaxer_generator.dart` | Use `extractBridgedArg` instead of raw `as` cast for generic-typed params in RC-2 cases | D |
| `lib/src/relaxer_generator.dart` | Nullability-aware type substitution in `_writeRC2Case` | D |
| `lib/src/bridge_generator.dart` | Type-dispatched method wrappers for T-involving function params in generic class methods | F |

### tom_d4rt_flutterm (generated output + tests)

| File | Change | Fix |
|------|--------|-----|
| `lib/src/bridges/flutter_relaxers.b.dart` | Regenerated — new wrapper classes for ButtonSegment, DropdownMenuItem, etc. | B |
| `lib/src/bridges/services_bridges.b.dart` | Regenerated — type-dispatched `setMessageHandler` for BasicMessageChannel | F |
| `lib/src/bridges/material_widgets_bridges.b.dart` | Regenerated — `coerceMap` for PageTransitionsTheme.builders | C |

---

## 6. Risk Assessment

| Fix | Risk | Mitigation |
|-----|------|------------|
| A | GEN-079 wrapper resolution adds overhead to every list element | Only triggers when direct `as T` fails — no overhead on happy path |
| B | More relaxer wrapper classes = larger generated file | File is already 135K lines; a few more wrappers are negligible |
| C | Map coercion might lose entries if keys can't be coerced | `coerceMap` already handles BridgedEnumValue keys; failure throws clear error |
| D | Nullability-aware substitution adds complexity to RC-2 generation | Limit to known patterns; `extractBridgedArg` handles edge cases |
| E | Storing typeArguments increases BridgedInstance memory slightly | `List<RuntimeType>` is typically 0-1 elements; negligible |
| F | Type-dispatched methods significantly increase generated code size | Limit to methods with T-involving function params (rare); use shared helper |

---

## 7. Testing Strategy

1. **After Fix A + B:** Re-run `essential_classes_test.dart` — expect failures #1, #2, #3 to pass
2. **After Fix A + B:** Re-run `important_classes_test.dart` — expect failures #5, #6 to pass
3. **After Fix C:** Re-run misc_themes_test.dart — expect failure #7 to pass
4. **After Fix D:** Re-run tweensequence_test.dart — expect failure #8 to pass  
   Also re-run tween_test.dart, animation_test.dart (in case the TweenSequenceItem→Animatable cast was cascading)
5. **After Fix E + F:** Re-run channels_test.dart — expect failure #9 to pass
6. **Full regression:** Run all essential + important tests to verify no regressions

Unit tests for the changes themselves:
- Add a test in `tom_d4rt` for `D4.coerceList` with mock GEN-079 wrapper factories
- Add a test in `tom_d4rt` for `BridgedInstance.typeArguments` population
- Add generator tests for Map/Set coercion in combinatorial dispatch output
