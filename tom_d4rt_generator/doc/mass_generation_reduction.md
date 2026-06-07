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

### MCI#5 / A5 — generic-widget re-creators folded into the generator (2026-06-07)

Some immutable Flutter widgets cannot be relaxer-wrapped at all: a `$Relaxed`
subclass works by overriding/forwarding, but widgets are immutable and drive
complex rendering, so the relaxer must instead **re-construct** the widget with
the script's `<T>`. When a script writes `DropdownMenuItem(value: 'a')` without
type args, the bridge constructor produces `DropdownMenuItem<dynamic>`, which
then fails assignment into `DropdownButton<String>.items` (invariant generics).
The re-creator reads each constructor parameter back from its same-named
instance getter and rebuilds `DropdownMenuItem<String>`.

These three re-creators (`DropdownMenuItem<T>`, `DropdownMenuEntry<T>`,
`ButtonSegment<T>`) were previously **hand-written** in each twin's
`d4rt_runtime_registrations.dart` (`_registerGenericWidgetReCreators()`). They
are now emitted by the generator:

| Field (`BridgeConfig`) | Default | Effect |
|------------------------|---------|--------|
| `recreatorClasses` | `[]` | Single-type-parameter widgets to emit a `D4.registerGenericTypeWrapper` re-creator for. Entry is a bare class name (default inner types `String, int, double, bool, num`) or `{className: …, innerTypes: […]}`. Independent of `generateAllRelaxers`. |

`generateWidgetReCreator` (in `relaxer_generator.dart`) emits the re-creator
inline inside `registerRelaxers()`, after the factory registrations. It reads
the class's single type parameter, its default constructor, and the instance
getters (including inherited), then emits a `switch (innerTypeArg)` with a
leading `dynamic`/`Object`/`Object?` arm (no value cast), one arm per inner
type (the lone type-parameter constructor parameter cast to that type —
nullable when the parameter type is `T?`, as for `DropdownMenuItem.value`,
non-null when `T`, as for `DropdownMenuEntry`/`ButtonSegment`), and a
`_ => null` fallthrough. The emitter **bails conservatively** (warns, emits
nothing) when the class is not exactly one type parameter, has no default
constructor, has a constructor parameter without a matching getter, or has a
parameter that references the type parameter in a non-bare form (e.g.
`List<T>`) that cannot be safely cast.

The emitted output is **byte-for-byte identical** to the hand-written
re-creators (pinned by unit test `G-RCR-1`), so the obsolete hand-written
`_registerGenericWidgetReCreators()` in both twins can be deleted once the
generator is wired and regenerated — see the deferred completion step.

### MCI#3 / A3 — State-proxy mixin variants folded into the generator (2026-06-07)

An interpreted `State` subclass cannot have a Flutter mixin grafted onto it at
runtime (R2: Dart mixins are resolved at compile time), and `State` is abstract
(R1). So every `State` subclass that declares a real Flutter state mixin needs a
**native proxy that actually mixes in** the corresponding mixin, so the mixin's
native overrides (`createTicker`, `restoreState`/`registerForRestoration`,
`updateKeepAlive`, …) run. These were hand-written in each twin's
`d4rt_runtime_registrations.dart` as five near-verbatim copies of one skeleton:

| Variant class | `with` clause | Extra-override slot |
|---------------|---------------|---------------------|
| `_InterpretedState` | — | — |
| `_InterpretedSingleTickerProviderState` | `SingleTickerProviderStateMixin` | — |
| `_InterpretedMultiTickerProviderState` | `TickerProviderStateMixin` | — |
| `_InterpretedRestorationMixinState` | `RestorationMixin<_InterpretedStatefulWidget>` | `restorationId` getter + guarded `restoreState` |
| `_InterpretedKeepAliveState` | `AutomaticKeepAliveClientMixin` | `wantKeepAlive` getter + `super.build(context)` build prefix |

The web (`tom_d4rt_flutter_ast`) twin had **drifted** — it was missing the
`_InterpretedKeepAliveState` variant entirely (accidental, flagged in
`open_step0_review_baseline.md` D1 / `mci_step0_review_baseline.md` D1). The
emitter closes that gap by emitting all five for both twins from one template.

| Field (`ProxyClassConfig`) | Default | Effect |
|----------------------------|---------|--------|
| `mixinVariants` | `[]` | State mixins to emit a native proxy variant for. Each entry is a Flutter state-mixin name; unknown names warn-and-skip. Independent of the abstract-delegate `proxyClasses` mechanism. |

`generateStateProxyFamily` (in `state_proxy_generator.dart`) emits the plain
`_InterpretedState` followed by one variant per recognised mixin, in declaration
order. `generateStateProxyVariant` emits a single class: the canonical
lifecycle skeleton (`initState`/`didChangeDependencies` super-first,
`deactivate`/`dispose` interpreted-first, full `build` delegation and
`didUpdateWidget`), each lifecycle override wrapped in the **Bug-46 re-entrancy
guard** (`_lifecycleInProgress` enter/try/finally-remove so a script
`super.initState()` short-circuits), plus the per-mixin extra-override slot.
`stateProxyVariantSpecFor` maps a mixin name to its spec (returns `null` for
unknowns, driving the warn-and-skip).

**Canonical-normalization nuance.** Unlike the MCI#5 re-creators, the
hand-written State variants carry cosmetic inconsistencies (comment-period
drift, the KeepAlive copy's abbreviated `didUpdateWidget`). The emitter produces
one **canonical** form; the golden test (`G-SPX-1`) pins that canonical contract
rather than byte-parity with the current messy code. Behavioural equivalence
with the hand code is validated by the serial base-test gate at regen time — the
differences are cosmetic / behaviour-preserving. The dormant default (`[]`)
keeps committed bridge output unchanged until the buildkit knob is set and both
twins are regenerated — see the deferred completion step (which also carries the
A4 RenderBox family and the KeepAlive web-twin gap closure).

### MCI#6 / B1 — generic-type-arg proxy variants folded into the generator (2026-06-07)

An **invariant** generic delegate cannot be backed by a single concrete-arg
proxy. `CustomClipper<T>` is invariant, so a `CustomClipper<Path>` proxy handed
to a script that declared `extends CustomClipper<RRect>` blows up downstream in
Flutter at `_RenderCustomClip<RRect>._clip = clipper.getClip(size)` with
`_NativePath is not a subtype of RRect`. The fix is one **typed** proxy per
concrete type argument, each returning a non-null fallback of its own `T`, plus
a `registerInterfaceProxy` selector that picks the variant matching the script's
reified bridged-super type argument (`bridgedSuperTypeArgNames[0]`):

| Variant class | `extends` | `getClip` fallback |
|---------------|-----------|--------------------|
| `_InterpretedCustomClipperPath` | `CustomClipper<Path>` | `Path()` |
| `_InterpretedCustomClipperRect` | `CustomClipper<Rect>` | `Offset.zero & size` |
| `_InterpretedCustomClipperRRect` | `CustomClipper<RRect>` | `RRect.fromRectAndCorners(Offset.zero & size)` |
| `_InterpretedCustomClipperRSuperellipse` | `CustomClipper<RSuperellipse>` | `RSuperellipse.fromRectAndRadius(Offset.zero & size, Radius.zero)` |

These four classes were hand-written near-verbatim in each twin's
`d4rt_runtime_registrations.dart`. The emitter replaces them with one template.

| Field (`ProxyClassConfig`) | Default | Effect |
|----------------------------|---------|--------|
| `typeArgVariants` | `[]` | Generic type-args to emit a typed proxy variant for. Each entry is `{typeArg, defaultExpr}` — `typeArg` is analyzer-validatable, `defaultExpr` is the non-null fallback (the only extra human input; there is no generic non-null default for an arbitrary `T`). |

`generateTypeArgProxyVariant` / `generateTypeArgProxyClasses` /
`generateTypeArgProxySelector` (in `typearg_proxy_generator.dart`) emit the
classes in declaration order plus the selector switch. The **first** listed
variant is the selector's `default:` arm (matched when the script gives no type
argument or an unlisted one); the rest become `case` arms in order. The
per-variant pieces are just the type argument `T` and the `defaultExpr` (which
substitutes into both the null-method early return and the catch/non-match
fallthrough). The abstract method shape is `CustomClipper`'s
(`T getClip(Size size)` + `bool shouldReclip(covariant CustomClipper<T>)`),
which is the sole B1 case.

**Canonical-normalization nuance** (as in MCI#3): the emitter produces a
canonical form — the golden (`G-TAV-1`/`G-TAV-5`) pins it; the regen-time
base-test gate validates behavioural equivalence with the hand code, whose only
differences are cosmetic doc-comment drift and switch-arm ordering (the hand
form lists `RRect, Rect, RSuperellipse, default→Path`; the canonical form lists
config order `Rect, RRect, RSuperellipse, default→Path`). The dormant default
(`[]`) keeps committed bridge output unchanged.

**Deferred (B3 + heavy tail).** The B3 generic-**constructor** switches
(`GlobalKey`, `ValueKey`, `ValueNotifier`) named in the same `typeArgVariants`
todo are **not** folded here: their shapes diverge (named-arg passthrough with a
typed default for `GlobalKey`; positional-value nullable-aware arms with a
`null` default for `ValueKey`/`ValueNotifier`), so they are not a single
byte-for-byte template. They — plus wiring `typeArgVariants` into both twins'
`buildkit.yaml`, regen, removing the hand-written classes/switches, and the
serial base-test + `CustomClipper<RRect>` / `GlobalKey<NavigatorState>()`
integration gate — are recorded in the deferred completion step.

---

### MCI#7 / B2 — super-constructor-argument capture folded into the generator (2026-06-07)

A bridged base with **required** super-constructor formals loses its abstract
ctor at bridge time, so when a script declares
`class _MyScroll extends BoxScrollView { _MyScroll() : super(scrollDirection: …); }`
the `super(...)` call has nowhere to land natively. The fix is a native proxy
whose static `create(visitor, instance)` factory re-reads each captured
`super(...)` named arg off the `InterpretedInstance`
(`_readSuperArg<T>(instance, 'name', visitor)`) and forwards it to the real
native super-constructor, defaulting any required formal the script omitted.
Four proxies followed this pattern (`_InterpretedBoxScrollView`,
`_InterpretedTwoDimensionalScrollView`, `_InterpretedTwoDimensionalViewport`,
`_InterpretedRenderTwoDimensionalViewport`), each with one
`_readSuperArg<T>(...) ?? default` line per super-formal hand-written in both
twins' `d4rt_runtime_registrations.dart`.

| Field (`ProxyClassConfig`) | Default | Effect |
|----------------------------|---------|--------|
| `superArgDefaults` | `{}` | `name → default-expr` map for the **required** super-formals. The generator derives the super-formal list + types from the analyzer; this map is the only human input (a sane default for each required formal a script might omit, e.g. `scrollDirection: Axis.vertical`). Script-supplied `super(...)` args always win — the default only applies when the captured arg is null. |

`superarg_proxy_generator.dart` emits the factory from a `SuperArgFormal` list
(`{name, type, isRequired, defaultExpr}` — the first three analyzer-derived,
`defaultExpr` merged from `superArgDefaults` via `applySuperArgDefaults`):

- `generateSuperArgEntry` emits one ctor-call entry: the `key` formal always
  falls back to `_readKey(instance, visitor)`; a defaulted formal gets a
  trailing `?? defaultExpr`; a bare optional formal forwards the nullable read
  as-is.
- `generateSuperArgCaptureFactory` reads each **required-without-default**
  formal into a local, emits one combined null-check `StateError` preamble
  naming them, then the proxy ctor call and the canonical
  `instance.nativeProxy ??= proxy; return proxy;` tail.
- `generateReadSuperArgHelper` emits the shared `_readSuperArg<T>` helper
  (script-arg-wins-over-default semantics live here: a missing or
  non-coercible capture returns `null` so the caller's `?? default` applies).

Pinned by `G-SAC-1` (all-optional `BoxScrollView` factory), `G-SAC-2`
(`TwoDimensionalViewport` required-validation preamble), `G-SAC-8` (the helper),
plus entry/merge/round-trip tests `G-SAC-3..7`, `G-SAC-9..12`.

**Canonical-normalization nuance** (as in MCI#3/MCI#6): the emitter produces a
canonical form (one un-wrapped line per formal, a single combined null-check);
the golden pins it, and the regen-time base-test gate validates behavioural
equivalence with the hand code, whose only differences are cosmetic dartfmt
line-wrap and a per-proxy `StateError` message. The dormant default (`{}`)
keeps committed bridge output unchanged.

**Deferred (override-hook wrapping + heavy tail).** Each proxy also forwards a
bespoke virtual hook back into the interpreter (`buildViewport`,
`buildChildLayout`, `createRenderObject`/`updateRenderObject`,
`layoutChildSequence`) — these are **not** derivable from the annotation, so the
full proxy class (its `extends`/`implements` clause, the `._(...)`
super-forwarding ctor, and the override body) stays hand-written for now; only
the `create()` capture factory is emitted. Wrapping the bespoke hooks, wiring
`superArgDefaults` into both twins' `buildkit.yaml`, regen, removing the
hand-written factories, and the serial base-test + scrolling-view integration
gate are recorded in the deferred completion step.

---

### P&R#6 — user-proxy/-relaxer annotations + variant-pattern engine (2026-06-07)

**cleanup_todos #27.** Added the user-extensible proxy/relaxer declaration
surface plus the analyzer-free variant-expansion engine that the future
scanner consumes. This unblocks downstream projects declaring proxy/relaxer
generation for their **own** generics — including multi-type-parameter
generics, which the auto-generator does not cover — without editing
`buildkit.yaml`.

- **Engine** — `lib/src/user_variant_pattern.dart` (exported from the barrel):
  - `WildcardPattern` — parses a single-`*` driver pattern (`*DO` ⇒ `endsWith`,
    `Customer*` ⇒ `startsWith`); rejects zero, more-than-one, or mid-slot `*`;
    `match(candidate)` returns the `$0`/`$1` capture or `null`.
  - `WildcardCapture` — `full` (`$0`, the whole matched name) + `captured`
    (`$1`, the wildcard substring) + `expandTemplate` (substitutes `$0`/`$1`,
    leaves literals untouched).
  - `TypeArgVariantSpec` — parses a comma-separated **multi-slot** variant
    (one slot per type parameter); exactly one slot may carry the `*`, the rest
    are literals or `$0`/`$1` templates; rejects `$`-templates with no wildcard
    source and >1 wildcard slot; `expand(candidates)` yields concrete
    type-argument tuples (explicit variants ignore the candidate pool).
  - `expandUserVariants(specs, candidates)` — aggregates multiple specs,
    order-preserving de-dup, with a cross-spec arity check.

  Confirmed `$0`/`$1` semantics: `'*DO, $1Form'` matched against `CustomerDO`
  derives `['CustomerDO', 'CustomerForm']`.

- **Annotations** — `@D4rtUserProxy` / `@D4rtUserRelaxer`
  (`tom_d4rt/lib/src/generator/d4rt_user_proxy_annotation.dart`, exported from
  `d4rt.dart`), const with string-syntax `variants`, modeled on
  `@D4rtUserBridge`. Marker base class `D4UserProxy` added next to the existing
  `D4UserRelaxer` in **both** `d4.dart` twins.

- Tests `G-UVP-1..24` (`test/user_variant_pattern_test.dart`) — all green
  (full generator suite 769 passed); `dart analyze` clean throughout. The
  engine is dormant: no folder is scanned and no emission is wired, so
  committed `*.b.dart` output is unchanged.

**Deferred (completion_steps.d4rt.md, "P&R#6"):** the
`lib/src/d4rt_user_proxies/` + `…_user_relaxers/` scanner + `bridge_api`
pre-scan wiring, the annotation-driven proxy/relaxer **emission** (widening the
proxy/relaxer emitters from single- to N-type-parameter), the component golden,
the both-twin regen + serial base-test gate, the `TomFormList<TElement, TForm>`
+ wildcard integration tests, the edge-case buffer, and the worked-example docs.

### MCI#8 / B4 — generic interceptor re-dispatch folded into the generator (2026-06-07)

A handful of Flutter lookups are keyed by the *exact* reified type argument —
`RadioGroup.maybeOf<T>(context)` resolves via
`dependOnInheritedWidgetOfExactType<_RadioGroupStateScope<T>>()`. The generated
bridge adapter forwards the call without `<T>`, so the lookup collapses to
`<dynamic>` and misses (R4). The interpreter already exposes an interceptor hook
at the top of these adapters
(`bridge_generator.dart:_bridgedStaticMethodInterceptHooks` →
`D4.findBridgedStaticMethodInterceptor`); the interceptor *body* was hand-written
in each twin's `d4rt_runtime_registrations.dart`, and within it the
**re-dispatch half** — a `switch (typeName)` over an allow-list of common
type-arg names — was pure boilerplate (~150 lines across the cases).

`generic_interceptor_generator.dart` templates exactly that half from a
`GenericInterceptorConfig` (`bridge_config.dart`):

```dart
const cfg = GenericInterceptorConfig(
  className: 'RadioGroup', methodName: 'maybeOf', isStatic: true,
  typeArgVariants: ['String', 'int', 'double', 'num', 'bool', 'Object'],
  fallbackExpr: '_radioGroupMaybeOfFallback(visitor, positional, named, typeArgs)',
);
```

`generateGenericInterceptor(cfg)` emits the canonical
`D4.registerBridgedStaticMethodInterceptor('RadioGroup', 'maybeOf', …)` call with
the `switch (typeName) { 'String' => RadioGroup.maybeOf<String>(ctx), …, _ =>
null }` re-dispatch, chaining to the hand-written `fallbackExpr` (the R5
ancestor-walk half, kept until MCI#11) when the switch returns null. The emitter
returns the empty string when no type-arg variant is declared — **dormant by
default**, so committed `*.b.dart` is unchanged until a `buildkit.yaml` declares
an interceptor. 14 unit tests `G-GMI-1..14` pin the canonical output
byte-for-byte (instance + static shapes, with/without fallback, config
round-trip).

**Wired (2026-06-07):** `genericInterceptors` is now a first-class
`BridgeConfig` field (declaration / constructor / `fromJson` / `toJson`
/ `copyWith`), parsed straight from `d4rtgen:` → `genericInterceptors:`
(the buildkit loader delegates to `BridgeConfig.fromJson`). The
`relaxer_generator.dart` registration pass emits each configured
interceptor **inline into `registerRelaxers()`** alongside the MCI#5
re-creators, and the GEN-095 stub guard treats a non-empty interceptor
list as emittable. Tests `G-GMI-BC-1..4` pin the config round-trip.
**Dormant by default** — no `buildkit.yaml` declares an interceptor, so
committed `*.b.dart` is byte-identical.

**Still deferred (blocked on serial Flutter harness — see
`_ai/quests/d4rt/todo_impossible.md`):** the both-twin regen, deleting
only the re-dispatch half of the hand-written `RadioGroup.maybeOf`
(keeping the R5 fallback), the serial base-test gate, and the
`RadioGroup.maybeOf<String>(ctx)` integration test. This also needs a
**public** fallback helper + a new `fallbackImport` config field, since
the current `_radioGroupMaybeOfFallback` is private to
`d4rt_runtime_registrations.dart`. **N/A:** the four non-`RadioGroup`
interceptors named in the original todo have no re-dispatch half — they
are pure ancestor/proxy walks (the permanent R5 mechanism per
MCI#11/#36), so there is nothing to template away from them.

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
