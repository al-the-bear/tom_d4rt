# Mass-Generation Reduction Proposal

## Problem

`flutter_relaxers.b.dart` is **135,278 lines** — the single largest generated file. The root cause is a combinatorial explosion of unbounded type parameters × all concrete bridged types.

### Current Scale

| Component | Count | Lines (approx) |
|-----------|------:|---------------:|
| `$Relaxed*` proxy classes | 50 | ~1,200 |
| Relaxer factories (`_relax*`) | 87 | ~130,000 |
| Constructor factories (`_rc2*`) | 118 | ~4,000 |
| **Total** | **205** | **~135,000** |

### Breakdown

- `_relaxWidgetStatePropertyAll$rc2` alone has **130,156 switch cases** — it accounts for 99.8% of all relaxer factory cases (unbounded `<V>` → every concrete type).
- 81 of 118 constructor factories repeat the **same 1,604 switch cases** identically.
- Only constrained factories (e.g., `CustomClipper<T extends Path|RRect|Rect>`) have manageable case counts.

## Root Cause

In `relaxer_generator.dart`, `_buildRelaxerTargets`:

- **Step 2b**: For GEN-075 classes (type-dispatch constructors), ALL `allConcreteBridgedTypes` are added as eligible type args — regardless of whether the type is ever actually used with that class.
- **Step 2c**: Propagates further — if a GEN-075 class has a parameter like `Animatable<T>`, all concrete types propagate to the `Animatable` factory too.

The extraction sites (`GenericExtractionSite`) already track which types were actually observed during bridge analysis — but Step 2b discards that precision and adds everything.

## Proposed Solution: Three-Tier Strategy

### Tier 1 — Usage-Based Generation (generator change)

Modify `_buildRelaxerTargets` Step 2b: instead of adding ALL concrete bridged types for unbounded type params, only add types that were **actually observed** as type arguments in the SDK source during bridge analysis.

The `GenericExtractionSite` records already contain this information. The change is to stop overriding them with the full type enumeration.

**Expected reduction**: ~95% of switch cases eliminated. Most generic classes are only instantiated with 3–10 different type args in practice.

### Tier 2 — Dynamic Fallback (generator change)

For factory functions that still have a switch, add a `dynamic` default case:

```dart
Object? _relaxFoo(Object value, String innerTypeArg) {
  if (value is! Foo) return null;
  return switch (innerTypeArg) {
    'double' => $RelaxedFoo<double>(value),
    'Color'  => $RelaxedFoo<Color>(value),
    // ... only observed types ...
    _ => $RelaxedFoo<dynamic>(value),  // fallback
  };
}
```

Since `$Relaxed` proxies use `as V` casts internally, `V = dynamic` means casts always succeed. The wrapper still delegates correctly. The only risk is when Flutter APIs check covariance (e.g., assigning `Tween<dynamic>` where `Tween<double>` is expected).

**When NOT to use dynamic fallback**: Classes where the wrapped value gets passed back to Flutter code that expects a specific type arg (e.g., `Route<T>` where `Navigator.push` checks the return type). These need explicit cases. A generator annotation like `@D4rtNoDynamicFallback` or a configuration list could control this.

### Tier 3 — Runtime Registration (already available)

For edge cases discovered after generation, use `D4.registerGenericTypeWrapper()` in `d4rt_runtime_registrations.dart`. This is the mechanism we already use for supplementary Tween inner types (double, int, num, Color, Offset + nullable variants).

This handles types that weren't observed in the SDK but appear in user scripts — no regeneration needed.

## Expected Impact

| Metric | Current | After Tier 1+2 |
|--------|--------:|---------------:|
| `flutter_relaxers.b.dart` lines | 135,278 | ~3,000–5,000 |
| Switch cases per factory | 1,604 avg | 5–15 + fallback |
| Total switch cases | 260,686 | ~1,000–2,000 |
| File size on disk | ~4 MB | ~150 KB |

## Implementation Steps

1. **Generator**: Modify `_buildRelaxerTargets` Step 2b — limit to observed type args only
2. **Generator**: Add `_ => $RelaxedFoo<dynamic>(value)` as default case in factory generation
3. **Generator**: Add opt-out mechanism for classes where dynamic fallback is unsafe
4. **Regenerate** all bridge files
5. **Test**: Run the Flutter test suite to find regressions from reduced type coverage
6. **Runtime registration**: Add `D4.registerGenericTypeWrapper()` calls for any types discovered missing during testing

## Related Changes (RC-8)

The runtime registration infrastructure used in Tier 3 was introduced alongside this analysis:

- `D4.registerGenericTypeWrapper()` — already existed, used for Tween inner types
- `D4.registerEnumStaticGetter()` — new API for enum static members (e.g., `WidgetState.any`)
- `_registerSupplementaryRelaxers()` in `d4rt_runtime_registrations.dart` — demonstrates the Tier 3 pattern
