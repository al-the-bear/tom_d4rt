# Mass-Generation Reduction Proposal

> **Step-0 measured baseline — 2026-06-05** (P&R quest step 0d). Captured
> from the committed `*.b.dart` of `tom_d4rt_flutter_ast` *before* any
> reduction work, so steps 4/5 reductions are measurable against it. These
> numbers **supersede** the April "Current Scale" figures further down (which
> are kept only as the original analysis context).

### Generated `*.b.dart` size — `tom_d4rt_flutter_ast` (current)

| File | Lines |
|------|------:|
| `flutter_relaxers.b.dart` | **181,152** |
| `widgets_bridges.b.dart` | 104,566 |
| `rendering_bridges.b.dart` | 100,021 |
| `material_widgets_bridges.b.dart` | 76,337 |
| `cupertino_bridges.b.dart` | 18,287 |
| `gestures_bridges.b.dart` | 13,954 |
| `painting_bridges.b.dart` | 13,204 |
| `services_bridges.b.dart` | 11,053 |
| `dart_ui_bridges.b.dart` | 8,483 |
| `foundation_bridges.b.dart` | 7,564 |
| `animation_bridges.b.dart` | 4,918 |
| `semantics_bridges.b.dart` | 3,444 |
| `flutter_proxies.b.dart` | 1,585 |
| `physics_bridges.b.dart` | 856 |
| `scheduler_bridges.b.dart` | 849 |
| `material_bridges.b.dart` | 163 |
| `flutter_bridges_barrel.b.dart` | 16 |
| **Total (all `*.b.dart`)** | **546,452** |

### Category counts (measured against `flutter_relaxers.b.dart` + `flutter_proxies.b.dart`)

| Category | Artifact | Count | Selection | Combinatorial? |
|----------|----------|------:|-----------|----------------|
| A | `$Relaxed*<V>` wrapper classes | **50** | auto (1-type-param, extracted/RC-2) | No |
| B | `_relax*` factory switches (`registerGenericTypeWrapper`) | **99** | auto + `allConcreteBridgedTypes` injection | **Yes** |
| C | `_rc2*` ctor factories (`registerGenericConstructor`) | **119** | auto (eligible × ctor) × `allBridgedTypes` | **Yes** |
| D | `D4rt*` proxy classes (`registerInterfaceProxy`) | **15** | explicit `proxyClasses:` only | No |

The relaxer file alone is 181,152 lines; categories **B + C** (the two
combinatorial switch families, 99 + 119 = 218 switch sites) account for the
overwhelming majority. Capping the `allConcreteBridgedTypes` / `allBridgedTypes`
enumeration (steps 4/5) is the single highest-leverage lever and touches
neither the 50 wrappers nor the 15 proxies.

> **Measurement commands (reproducible):**
> `find tom_d4rt_flutter_ast/lib/src/bridges -name '*.b.dart' -exec wc -l {} +`;
> category counts via `grep -c '^class \$Relaxed'`,
> `grep -c 'registerGenericTypeWrapper'`, `grep -c 'registerGenericConstructor'`,
> `grep -cE '^class D4rt'` on the relaxer/proxy files.

### P&R step 4 — reduction knobs landed (2026-06-07)

The generator now exposes the **reduction lever** as opt-in config
(`tom_d4rt_generator`, P&R#4):

| Field (`BridgeConfig`) | Default | Effect |
|------------------------|---------|--------|
| `generateAllRelaxers` | `true` | When `true`, Categories **B** (`allConcreteBridgedTypes`) and **C** (`allBridgedTypes`) enumerate *every* concrete bridged class — the current 181 k-line surface, unchanged. |
| `relaxerClasses` | `[]` | Extra class names kept eligible when `generateAllRelaxers: false` (bare string or `{className: …}` map). |
| `additionalRelaxerTypes` | `[]` | Extra type names kept eligible when reduced (bare or `package:uri:Type`); the field the P&R#5 corpus scanner emits its allowlist into. |

When `generateAllRelaxers: false`, the candidate type-arg enumeration in
**both** combinatorial switch families collapses to
`genericExtractionSites ∪ relaxerClasses ∪ additionalRelaxerTypes`.
Categories **A** (50 wrappers) and **D** (15 proxies) are untouched.

**Reduction realized so far: 0 lines.** The default stays
generate-everything (request *i*), so this step adds the mechanism without
changing committed output — a default-config regen of both flutter twins is
**byte-identical** to the committed `*.b.dart` (only the `// Generated:`
timestamp header differs). The actual line-count collapse lands when P&R
step 5 (corpus scanner) supplies a concrete allowlist and flips
`generateAllRelaxers: false`; the expected magnitude is the ~181 k → low-
thousands range projected in *Expected Impact* below.

### P&R step 5 — corpus type-combination scanner (2026-06-07)

The reduced enumeration of step 4 needs a concrete `additionalRelaxerTypes`
allowlist that captures every type-argument the real corpus exercises, so
flipping `generateAllRelaxers: false` does not silently drop coverage. The
scanner produces that allowlist.

**Tool.** `tom_d4rt_generator:scan_corpus_types`
(lib: `CorpusTypeScanner` in `lib/src/corpus_type_scanner.dart`; CLI:
`bin/scan_corpus_types.dart`). It statically parses every `.dart` script
under a corpus directory (`parseString`, recovery mode — no resolution, so
scripts that don't type-check in isolation still scan) and collects the bare
name of every type that appears inside any `TypeArgumentList`, at any nesting
depth. `Map<String, List<Color>>` yields `String`, `List`, `Color`;
`extractBridgedArg<Tween<Offset>>` yields `Tween`, `Offset`. `dynamic`,
`void`, and `Never` are dropped (never bridged class keys). The emitter
renders a sorted, de-duplicated `additionalRelaxerTypes:` YAML block.

```sh
dart run tom_d4rt_generator:scan_corpus_types \
  --corpus ../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts \
  --output doc/corpus_relaxer_allowlist.yaml
```

**Committed artifact:** `doc/corpus_relaxer_allowlist.yaml` —
**2,733 distinct type-args** scanned from **2,083 corpus scripts**
(2026-06-07). The list intentionally over-approximates: it includes
user-defined classes the scripts declare locally (e.g. `AnimatedGridState`)
and generic type *parameters* (`T`). Over-approximation is **inert** — at
generation time the allowlist is intersected with the real
`globalClassLookup` keys (only actual bridged classes survive), so a
type-arg that is not a bridged class simply never produces a switch case.
The list is therefore a safe superset; the cost of an extra name is zero.

**Effective-allowlist measurement (2026-06-07).** Intersecting the 2,733
scanned type-args with the **2,201** distinct bridged-class names registered
across `tom_d4rt_flutter_ast/lib/src/bridges/*_bridges.b.dart` leaves **341**
names that actually produce switch cases. So under
`generateAllRelaxers: false` each combinatorial B/C switch enumerates ~341
corpus-driven candidate type-args (before unioning `genericExtractionSites`)
instead of all 2,201 — an **~85 % reduction in candidate types per switch**.
The remaining 2,392 scanned names are inert (user-declared classes / generic
type parameters). Reproduce with:

```sh
grep -ohE "name: '[A-Za-z_][A-Za-z0-9_]*'" \
  tom_d4rt_flutter_ast/lib/src/bridges/*_bridges.b.dart \
  | sed -E "s/name: '([^']+)'/\1/" | sort -u > /tmp_ws/bclasses.txt
grep -E '^  - ' tom_d4rt_generator/doc/corpus_relaxer_allowlist.yaml \
  | sed -E 's/^  - //' | sort -u > /tmp_ws/scanargs.txt
comm -12 /tmp_ws/bclasses.txt /tmp_ws/scanargs.txt | wc -l   # → 341
```

**The "scan → reduce → verify" workflow:**

1. **Scan** — run `scan_corpus_types` over the corpus → `additionalRelaxerTypes`
   allowlist (the committed `corpus_relaxer_allowlist.yaml`).
2. **Reduce** — paste the block into the flutter twin's `buildkit.yaml`
   `d4rtgen:` section, set `generateAllRelaxers: false`, and regenerate
   bridges + proxies for **both** `tom_d4rt_flutter` and
   `tom_d4rt_flutter_ast`. The combinatorial B/C switch families now
   enumerate only `genericExtractionSites ∪ relaxerClasses ∪
   additionalRelaxerTypes`.
3. **Verify** — run the **base-test** on both twins (fast gate), then the
   relevant corpus subset with `D4RT_LOG_RELAXER_USAGE=1` (P&R step 1) and
   assert the end-of-run `D4.usageLogSummary()` reports **zero misses**
   (`miss|base|typeArg`). A miss means a runtime type-arg the static scan did
   not surface (only possible via inference where the type-arg is never
   written syntactically) — reconcile by adding that name to the allowlist or
   confirming it is already covered by `genericExtractionSites`.

**Cross-validation (step-1 log vs. step-5 scan).** The scanner is a static
superset of every type-argument *written* in the corpus. The runtime usage
log (`D4.usageLogEnabled` / `D4RT_LOG_RELAXER_USAGE`) records type-args
*observed* at extraction time. The only way a runtime hit can be absent from
the static scan is a type-arg supplied purely by inference (never written
`<...>`); those correspond to bridge extraction sites and are already covered
by `genericExtractionSites`, which the reduced gating unions in independently
of the scan. A full empirical reconciliation requires one serial corpus run
with logging enabled — recorded as a deferred completion step (it is
co-located with the step-4 `generateAllRelaxers: false` production flip, since
both share the same heavyweight serial base-test gate on both twins).

---

## Problem

> **Historical (2026-04 analysis).** The figures in this section predate the
> 2026-06-05 baseline above and are retained only as original design context;
> the file has since grown from 135 k to 181 k lines.

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
