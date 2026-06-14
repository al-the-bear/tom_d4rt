# Annotation-driven proxy / relaxer directives

`@D4rtUserProxy` / `@D4rtUserRelaxer` let a downstream project declare
proxy / relaxer generation for its **own** generic classes — including
multi-type-parameter generics the auto-generator does not cover — without
editing `buildkit.yaml`. They mirror the `@D4rtUserBridge` convention: a const
annotation carrying string-syntax arguments, applied to a class extending a
marker base (`D4UserProxy` / `D4UserRelaxer`) that the generator pre-scans.

This doc covers the **directive-discovery + variant-expansion core** (P&R #6
sub-steps a–d): how the annotations are parsed into concrete generic
instantiations. The live wiring into `generateProxies` / `generateRelaxers` and
the `lib/src/d4rt_user_proxies/` + `…_user_relaxers/` folder pre-scan is the
deferred tail (see *Status* below).

---

## Where the pieces live

| Piece | Location |
|-------|----------|
| `@D4rtUserProxy` / `@D4rtUserRelaxer` annotations | `tom_d4rt/lib/src/generator/d4rt_user_proxy_annotation.dart` |
| `D4UserProxy` / `D4UserRelaxer` marker bases | `tom_d4rt/lib/src/generator/d4.dart` (mirrored in `tom_d4rt_ast`) |
| Variant-pattern engine (analyzer-free) | `tom_d4rt_generator/lib/src/user_variant_pattern.dart` |
| Directive core + element-walker | `tom_d4rt_generator/lib/src/user_proxy_relaxer_scanner.dart` |

All four are re-exported from `package:tom_d4rt/d4rt.dart` (annotations +
markers) and `package:tom_d4rt_generator/tom_d4rt_generator.dart` (engine +
scanner).

---

## Variant syntax

Each entry in `variants` is a comma-separated list of **slots**, one slot per
type parameter of the generic base class. Every variant for a base must declare
the same number of slots (the base has a fixed arity) — a mismatch is an
`ArgumentError`.

A slot is either:

- a **literal** type name (`Customer`, `CustomerDetailForm`, `Color`), or
- a single **wildcard pattern** (`*DO`, `Customer*`) — at most one wildcard slot
  per variant — whose capture fills the other slots via `$0` / `$1` templates.

Wildcard rules:

- `*` must be at the **start** (`*DO` ⇒ `endsWith('DO')`) or the **end**
  (`Customer*` ⇒ `startsWith('Customer')`) of exactly one slot. More than one
  `*` is a `FormatException`.
- `$0` = the full matched candidate name (e.g. `CustomerDO`).
- `$1` = the wildcard-captured substring (e.g. `Customer` for `*DO` against
  `CustomerDO`).
- A `$0`/`$1` template with no wildcard slot in the same variant is a
  `FormatException`.

---

## Worked example 1 — explicit multi-type-parameter proxy

A two-parameter generic `TomFormList<TElement, TForm>` with explicit
combinations:

```dart
import 'package:tom_d4rt/d4rt.dart';

@D4rtUserProxy(
  'package:my_pkg/forms.dart',
  'TomFormList',
  variants: ['Customer, CustomerDetailForm', 'Order, OrderForm'],
)
class TomFormListUserProxy extends D4UserProxy {}
```

Expands (candidates are ignored for explicit variants) to:

```text
TomFormList<Customer, CustomerDetailForm>
TomFormList<Order, OrderForm>
```

## Worked example 2 — wildcard-pattern relaxer

Every `*DO` class in the corpus pairs with its `*Form`:

```dart
@D4rtUserRelaxer(
  'package:my_pkg/models.dart',
  'TomFormList',
  variants: [r'*DO, $1Form'],
)
class TomFormListUserRelaxer extends D4UserRelaxer {
  @override
  String get baseTypeName => 'TomFormList';
}
```

Against a candidate pool `['CustomerDO', 'OrderDO', 'Widget']`, the `*DO` slot
matches `CustomerDO` and `OrderDO` (`Widget` is skipped); `$1` captures the
prefix, so `$1Form` becomes `CustomerForm` / `OrderForm`:

```text
TomFormList<CustomerDO, CustomerForm>
TomFormList<OrderDO, OrderForm>
```

## Worked example 3 — single-parameter relaxer

The common single-type-parameter case is just a one-slot variant:

```dart
@D4rtUserRelaxer(
  'package:my_pkg/notifiers.dart',
  'ValueNotifier',
  variants: ['Color'],
)
class ValueNotifierUserRelaxer extends D4UserRelaxer {
  @override
  String get baseTypeName => 'ValueNotifier';
}
```

```text
ValueNotifier<Color>
```

---

## Expansion + rendering API

The analyzer-free core is fully unit-testable without resolving any library:

```dart
final directive = UserVariantDirective.parse(
  kind: UserVariantKind.relaxer,
  libraryPath: 'package:my_pkg/models.dart',
  baseClass: 'TomFormList',
  variants: [r'*DO, $1Form'],
  directiveClassName: 'TomFormListUserRelaxer',
  sourceFile: 'lib/src/d4rt_user_relaxers/forms.dart',
);

directive.arity;          // 2
directive.hasPattern;     // true
directive.expand(['CustomerDO', 'OrderDO']);
//   [[CustomerDO, CustomerForm], [OrderDO, OrderForm]]
directive.renderInstantiations(['CustomerDO', 'OrderDO']);
//   ['TomFormList<CustomerDO, CustomerForm>', 'TomFormList<OrderDO, OrderForm>']
```

Expansion **de-duplicates** tuples, keeping first-seen order — an explicit
variant that names the same tuple a pattern would also produce wins the slot
and is not duplicated.

`renderUserVariantInstantiationBlock(directives, candidatePool)` renders a
deterministic, golden-stable block grouping each directive's instantiations
under a `// <kind> <baseClass>` header, noting `//   (no matching candidates)`
when a directive expands to nothing — the regen-independent artifact the future
emission wiring will consume.

---

## Discovery (element-walker)

`UserProxyRelaxerScanner` is the thin element-walker, structurally identical to
`UserBridgeScanner`. Callers resolve each directive file to a `LibraryElement`
(via an `AnalysisContextCollection`, exactly as `_preScanUserBridges` does in
`bridge_api.dart`) and call `scanLibrary(library, sourceFile)`. Discovered
directives are exposed via `proxyDirectives` / `relaxerDirectives`;
`directiveClassNames` lists the directive classes so the generator can exclude
them from normal bridge generation — just as it does for `D4UserBridge`
classes.

A class that extends a marker base but carries no recognized annotation is
still recorded for exclusion, and an `onWarning` callback fires so the
misconfiguration is visible.

Directive classes belong in `lib/src/d4rt_user_proxies/` (proxy) and
`lib/src/d4rt_user_relaxers/` (relaxer), modeled on the
`lib/src/d4rt_user_bridges/` pre-scan folder.

---

## Tests

| Suite | File | Covers |
|-------|------|--------|
| `G-UVP-1..24` | `test/user_variant_pattern_test.dart` | The wildcard / capture / spec engine (pure). |
| `G-UPR-1..16` | `test/user_proxy_relaxer_directive_test.dart` | Directive parse / expand / render + golden block (pure). |
| `G-UPS-1..7` | `test/user_proxy_relaxer_scanner_test.dart` | The element-walker against a resolved fixture. |

---

## Status — shipped core vs. deferred tail

**Shipped (P&R #6 a–d):** the variant-pattern engine, the annotations + marker
bases, the directive core (`UserVariantDirective` parse / expand / render), the
instantiation-block emitter, and the `UserProxyRelaxerScanner` element-walker —
all with unit + resolution tests. None of this touches a live `*.b.dart` or any
generation entry point.

**Deferred (flutter-gated tail):**

- Wiring the scanner into `bridge_api.dart` / `per_package_orchestrator.dart`
  folder pre-scan and excluding directive classes from normal generation
  (P&R #6 b-wiring).
- Splicing the expanded instantiations into live `generateProxies` /
  `generateRelaxers` output, including the genuinely new multi-type-parameter
  relaxer generation (P&R #6 c-emission).
- Component golden of a real generated proxy/relaxer file from a fixture project
  (P&R #6 e).
- Both-twin regeneration + serial `flutter test` base-test gate (P&R #6 f).
- End-to-end integration of a `TomFormList<TElement, TForm>` script and a
  wildcard-pattern case (P&R #6 g).

The still-required manual interventions and what the generator now automates
are catalogued in `../../tom_d4rt/doc/manual_bridge_interventions.md`.
