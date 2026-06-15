# D4rt User-Bridges Sample — overriding what the generator can't bridge

The [advanced sample](../d4rt_advanced_sample/) showed the bridge generator
turning a native Dart library into something a D4rt script can drive. The
generator is good, but it is not omniscient: a handful of Dart shapes — operator
overloading, composite index keys, generic operators, whole-library globals —
can't be bridged reliably from static analysis alone. For those, D4rt provides
**user bridges**: small, hand-written adapters that you drop next to the native
code and that the generator folds into its output automatically.

This sample bridges a tiny "ledger" library and layers four kinds of user
bridge on top of it. The focus example, **`money_math`**, drives a `Money` value
type whose every arithmetic operator and whose `format()` method are supplied by
a user bridge — while its constructors and plain getters are still
auto-generated. The script can't tell the difference; both halves live on one
bridged class.

> This README explains **how user bridges work** and walks through `money_math`
> end to end. The other examples (`grid_report`, `config_overrides`) are
> summarised at the end. The complete, runnable source lives in the git
> repository at `tom_ai/d4rt/tom_d4rt_samples/d4rt_userbridges_sample/`.

---

## Table of contents

1. [When the generator isn't enough](#1-when-the-generator-isnt-enough)
2. [Project layout](#2-project-layout)
3. [Running it](#3-running-it)
4. [The native library](#4-the-native-library)
5. [Anatomy of a user bridge](#5-anatomy-of-a-user-bridge)
6. [How the generator finds and folds in overrides](#6-how-the-generator-finds-and-folds-in-overrides)
7. [The focus example: `money_math`](#7-the-focus-example-money_math)
8. [Following one call across the boundary](#8-following-one-call-across-the-boundary)
9. [The four override mechanisms](#9-the-four-override-mechanisms)
10. [User bridges vs. generator configuration](#10-user-bridges-vs-generator-configuration)
11. [The other examples](#11-the-other-examples)
12. [Where to go next](#12-where-to-go-next)

---

## 1. When the generator isn't enough

The generator reads your library's analyzed API and emits a `BridgedClass` per
type: an adapter lambda for each constructor, method, getter, setter and
operator. For ordinary members this works because the argument and return types
are concrete and known. It breaks down in four recurring situations:

| Shape | Why static generation struggles |
| --- | --- |
| **Operator overloading** (`+`, `-`, `*`, unary `-`) | The interpreter dispatches operators through a single per-symbol key, and the binary/unary `-` collision plus operand-unwrapping rules are easy to get subtly wrong. The generator emits a stub it can't fully trust. |
| **Composite index keys** (`grid[[row, col]]`) | `operator[]` is generated assuming a single scalar index. A `List<int>` key needs coercion the generated adapter doesn't perform. |
| **Generic operators** (`Box<T>`'s `operator[]`) | The element type `T` is erased at generation time, so the generated adapter can't coerce the argument or the result. |
| **Library globals** (top-level vars / getters / functions) | Sometimes you want the *script* to observe different values than native Dart — a sandboxed default, a fixed clock — which is a substitution, not a translation. |

A user bridge solves all four the same way: you write the adapter by hand, and
the generator wires *your* method in instead of its own.

---

## 2. Project layout

```
d4rt_userbridges_sample/
├── buildkit.yaml                       # generator config (registrationClass: UserBridgesSampleBridges)
├── pubspec.yaml                        # depends on tom_d4rt; dev: tom_d4rt_generator
├── lib/
│   ├── d4rt_userbridges_sample.dart    # barrel: native classes + user bridges
│   ├── d4rt_bridges.b.dart             # GENERATED barrel of bridges
│   ├── dartscript.b.dart               # GENERATED registration class
│   └── src/
│       ├── money/money.dart            # native: Money value type (operators)
│       ├── grid/grid.dart              # native: Grid (composite index)
│       ├── box/box.dart                # native: Box<T> (generic index)
│       ├── config/app_config.dart      # native: top-level globals
│       ├── d4rt_user_bridges/          # HAND-WRITTEN overrides
│       │   ├── money_user_bridge.dart
│       │   ├── grid_user_bridge.dart
│       │   ├── box_user_bridge.dart
│       │   └── app_config_user_bridge.dart
│       └── d4rt_bridges/
│           ├── ledger_bridges.b.dart   # GENERATED (overrides folded in)
│           └── relaxers.b.dart         # GENERATED
├── bin/run_example.dart                # runner (folder + stdin modes)
├── example/
│   ├── money_math/{main,invoice}.dart  # FOCUS example (multi-file)
│   ├── grid_report/main.dart
│   └── config_overrides/main.dart
├── run_example.sh / run_example.ps1
└── test/user_bridges_test.dart
```

Everything ending in `.b.dart` is generated and must never be hand-edited —
fix the source or the user bridge and regenerate.

---

## 3. Running it

```bash
# focus example
./example/money_math/run.sh
# or by name from the package root
./run_example.sh money_math

# the others
./run_example.sh grid_report
./run_example.sh config_overrides

# a one-off script from stdin
echo "import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';
void main(List<String> args) => print((Money(1000) + Money(250)).format());" \
  | ./run_example.sh
```

The generated bridges (`lib/*.b.dart`) — overrides already woven in — are
**checked into the repository**, so the examples run on a fresh clone with no
generation step (the first run only fetches dependencies). After changing a
native class, a user bridge, or `buildkit.yaml`, regenerate them — see
[`run_generator.md`](run_generator.md). On Windows use `run_example.ps1` with the
same arguments.

`money_math` prints:

```
Line items:
  Widget   USD 9.99 x3 = USD 29.97
  Gadget   USD 19.50 x2 = USD 39.00
  Refund   (USD 5.00) x1 = (USD 5.00)

Subtotal:    USD 63.97
Tax (8%):    USD 5.12
Grand total: USD 69.09
As a credit: (USD 69.09)  (negative: true)
```

Every `+`, `*` and unary `-` above ran through `MoneyUserBridge`; every
`format()` ran through its override (note the accounting parentheses on negative
amounts).

---

## 4. The native library

The native code knows nothing about D4rt. `Money` is an ordinary immutable value
type stored in integer cents:

```dart
class Money {
  final int cents;
  final String currency;
  const Money(this.cents, [this.currency = 'USD']);
  Money.amount(double amount, [this.currency = 'USD'])
      : cents = (amount * 100).round();

  Money operator +(Money other) { /* same-currency add */ }
  Money operator -(Money other) { /* same-currency subtract */ }
  Money operator *(num factor)  => Money((cents * factor).round(), currency);
  Money operator -()            => Money(-cents, currency);   // unary

  double get majorUnits => cents / 100;
  bool   get isNegative => cents < 0;
  String format()       => '$currency ${majorUnits.toStringAsFixed(2)}';
}
```

The constructors, `majorUnits` and `isNegative` are generated automatically. The
four operators and `format()` are the members we override.

---

## 5. Anatomy of a user bridge

A user bridge is a class that **extends `D4UserBridge`** and carries a
`@D4rtUserBridge` annotation naming the library (and optionally the class) it
overrides. Each override is a **static** method whose name follows a convention
the generator recognises, and whose signature is fixed:

```dart
import 'package:tom_d4rt/d4rt.dart';
import '../money/money.dart';

@D4rtUserBridge('package:d4rt_userbridges_sample/src/money/money.dart')
class MoneyUserBridge extends D4UserBridge {
  static Object? overrideOperatorPlus(
    InterpreterVisitor visitor,        // the running interpreter
    Object target,                     // the receiver (a bridged Money)
    List<Object?> positional,          // positional args from the script
    Map<String, Object?> named,        // named args from the script
    List<RuntimeType>? typeArgs,       // type arguments, if any
  ) {
    final money = D4.validateTarget<Money>(target, 'Money');
    final other = D4.extractBridgedArg<Money>(positional[0], 'other');
    return money + other;              // delegate to native Dart
  }
  // ... overrideOperatorMinus, overrideOperatorMultiply, overrideMethodFormat
}
```

Three things make this work:

- **Naming convention** maps method name → member:
  `overrideOperator{Plus|Minus|Multiply|Index|IndexAssign}`,
  `overrideMethod{Name}`, and for globals
  `overrideGlobalVariable{Name}` / `overrideGlobalGetter{Name}` /
  `overrideGlobalFunction{Name}`.
- **The `D4` helpers** do the boundary bookkeeping:
  `D4.validateTarget<T>` unwraps and type-checks the receiver;
  `D4.extractBridgedArg<T>` unwraps an argument; `D4.coerceList<T>` /
  `D4.getRequiredArg<T>` / `D4.getOptionalNamedArg<T>` handle the rest.
- **The binary/unary `-` collision**: the interpreter routes both `a - b` and
  `-a` through the `-` key, so `overrideOperatorMinus` checks whether
  `positional` is empty to tell them apart.

```dart
static Object? overrideOperatorMinus(visitor, target, positional, named, typeArgs) {
  final money = D4.validateTarget<Money>(target, 'Money');
  if (positional.isEmpty) return -money;                    // unary  -a
  final other = D4.extractBridgedArg<Money>(positional[0], 'other');
  return money - other;                                     // binary a - b
}
```

---

## 6. How the generator finds and folds in overrides

You do **not** register user bridges separately. The barrel exports both the
native classes and the user-bridge classes:

```dart
// lib/d4rt_userbridges_sample.dart
export 'src/money/money.dart';
export 'src/d4rt_user_bridges/money_user_bridge.dart';
// ... and the others
```

When you run the generator
(`dart run tom_d4rt_generator:d4rtgen --not-recursive -s "$(pwd)"`, see
[`run_generator.md`](run_generator.md)), it:

1. **Pre-scans** every barrel-reachable file for classes extending
   `D4UserBridge`. It logs them as skipped *as bridge targets*
   (`SKIPPED: class MoneyUserBridge - extends D4UserBridge (helper class)`) —
   they are providers, not types to bridge.
2. **Generates** the normal `BridgedClass` for each native type.
3. **Substitutes** your override wherever the convention matches a member,
   leaving the generated adapter in place for everything else.

The result is visible in `lib/src/d4rt_bridges/ledger_bridges.b.dart`:

```dart
// Money's operator/method table — note the user-bridge references:
'format': MoneyUserBridge.overrideMethodFormat,
'+':      MoneyUserBridge.overrideOperatorPlus,
'-':      MoneyUserBridge.overrideOperatorMinus,
'*':      MoneyUserBridge.overrideOperatorMultiply,
// Grid / Box index operators and the app_config globals are wired the same way.
```

The generator emits one registration class, `UserBridgesSampleBridges`. The
runner installs everything — generated members and overrides — with a single
call:

```dart
final d4rt = D4rt();
UserBridgesSampleBridges.register(d4rt);   // generated + hand-written together
```

---

## 7. The focus example: `money_math`

`money_math` is a two-file script. `invoice.dart` defines a *script-side* type
that composes the *bridged native* `Money`:

```dart
// example/money_math/invoice.dart
import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';

class LineItem {
  final String label;
  final Money price;
  final int qty;
  LineItem(this.label, this.price, this.qty);
  Money get total => price * qty;        // user-bridged operator*
}

Money sumTotals(List<LineItem> items) {
  var running = const Money(0);
  for (final item in items) {
    running = running + item.total;       // user-bridged operator+
  }
  return running;
}
```

`main.dart` imports it with a plain relative import and renders an invoice:

```dart
import 'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart';
import 'invoice.dart';

void main(List<String> args) {
  final items = [
    LineItem('Widget', Money.amount(9.99), 3),
    LineItem('Gadget', Money.amount(19.50), 2),
    LineItem('Refund', Money.amount(-5.00), 1),
  ];
  // ...
  final subtotal = sumTotals(items);   // operator+
  final tax = subtotal * 0.08;         // operator*
  final grand = subtotal + tax;        // operator+
  final credit = -grand;               // unary operator-
  print('As a credit: ${credit.format()}');  // overridden format()
}
```

The runner loads both files into one in-memory source map keyed by
`package:example/<file>`, so the relative `import 'invoice.dart'` resolves
**without touching the filesystem** — the same multi-file mechanism the
introduction and advanced samples use. `LineItem` is interpreted; `Money` is
native and reached through the bridge.

---

## 8. Following one call across the boundary

Take `subtotal * 0.08` from the script:

1. The interpreter evaluates `subtotal` to a bridged `Money` and `0.08` to a
   `double`.
2. It looks up the `*` operator on `Money`'s bridge table and finds
   `MoneyUserBridge.overrideOperatorMultiply` (not a generated stub).
3. It calls the override with `target` = the bridged `Money`, `positional` =
   `[0.08]`.
4. `D4.validateTarget<Money>(target, 'Money')` unwraps the receiver to the
   native `Money`; `D4.extractBridgedArg<num>(positional[0], 'factor')` unwraps
   the factor.
5. The override runs real Dart — `money * factor` — and returns a new native
   `Money`, which the interpreter re-wraps as a bridged value.

From the script's side this is indistinguishable from calling
`majorUnits` (a generated getter). One bridged class, two implementation
sources.

---

## 9. The four override mechanisms

This sample deliberately exercises each kind of user bridge:

| Mechanism | File | Annotation | Overrides |
| --- | --- | --- | --- |
| **Operators + method** | `money_user_bridge.dart` | `@D4rtUserBridge(money.dart)` | `+`, `-` (binary+unary), `*`, `format()` |
| **Composite index** | `grid_user_bridge.dart` | `@D4rtUserBridge(grid.dart, 'Grid')` | `operator[]`, `operator[]=` with a `List<int>` key |
| **Generic index** | `box_user_bridge.dart` | `@D4rtUserBridge(box.dart, 'Box')` | `operator[]`, `operator[]=` on `Box<T>` |
| **Library globals** | `app_config_user_bridge.dart` | `@D4rtGlobalsUserBridge(app_config.dart)` | `appName`, `maxItems`, `currentTime` getter, `describe()`, `taxCents()` |

The globals bridge has a slightly different shape — variables and getters take
no interpreter arguments, and functions use the `(visitor, positional, named,
typeArgs)` signature:

```dart
@D4rtGlobalsUserBridge('package:d4rt_userbridges_sample/src/config/app_config.dart')
class AppConfigUserBridge extends D4UserBridge {
  static Object? overrideGlobalVariableAppName() => 'ScriptLedger';
  static Object? Function() overrideGlobalGetterCurrentTime() =>
      () => DateTime.utc(2026, 1, 1);                  // fixed, deterministic clock
  static Object? overrideGlobalFunctionTaxCents(visitor, positional, named, typeArgs) {
    final cents = D4.getRequiredArg<int>(positional, 0, 'cents', 'taxCents');
    final rate  = D4.getOptionalNamedArg<num?>(named, 'rate') ?? 0.10;
    return (cents * rate).round();
  }
}
```

`config_overrides` proves the substitution: scripts see `ScriptLedger` and a
frozen clock, while `version` — which has *no* override — still shows its native
default.

---

## 10. User bridges vs. generator configuration

Not every awkward member needs hand-written code. Some can be addressed purely
by tuning `buildkit.yaml`:

- **Excluding members or whole classes** (`excludeClasses`,
  `excludeSourcePatterns`) when a type shouldn't be bridged at all.
- **`importShow` / `importHide`** to narrow what a barrel contributes when two
  re-exports collide.

The rule of thumb:

- If the member's *signature* is the problem (operator dispatch, composite or
  generic index keys), you genuinely need a **user bridge** — no config makes
  the generator infer the missing type information.
- If the problem is *which* members or packages get bridged, prefer **generator
  configuration** — it's declarative and survives regeneration with no extra
  code.

`Money.format()` is the in-between case: it's a perfectly ordinary method the
generator *can* bridge. We override it anyway to show that user bridges and
generated members coexist on one class — and because a user bridge is the right
home for behaviour (accounting parentheses) that differs from the native
default. Had we only wanted to *hide* it, generator config would have been the
lighter choice.

---

## 11. The other examples

- **`grid_report`** — builds a 3×3 `Grid` with composite `grid[[r, c]]` index
  operators (user-bridged) and reads back `grid.sum` (generated). Then fills a
  generic `Box` via `box[i] = …` (user-bridged generic operator) and checks
  `box.isEmpty` / `box.size` (generated). Demonstrates that user-bridge writes
  and generated reads see the same underlying state.
- **`config_overrides`** — prints the `app_config` globals and shows the
  overridden values (`ScriptLedger`, `maxItems` 100, a fixed clock, custom
  `describe`/`taxCents`) alongside the un-overridden `version`.

Both are single-file scripts; run them with `./run_example.sh <name>`.

---

## 12. Where to go next

- **Add your own override**: write a `*_user_bridge.dart` under
  `lib/src/d4rt_user_bridges/`, export it from the barrel, and regenerate (see
  [`run_generator.md`](run_generator.md)). The naming convention does the wiring.
- **Generic proxies / relaxers**: for libraries with heavy generics, the
  generator also supports `@D4rtUserProxy` / `@D4rtUserRelaxer` to drive generic
  constructor and method dispatch — a step beyond the per-member overrides here.
- **Compare with the generator-only path**: the
  [advanced sample](../d4rt_advanced_sample/) bridges a library with *no* user
  bridges, so the contrast with this one shows exactly where hand-written
  adapters earn their place.

The full, runnable source — native library, user bridges, generated output,
examples and tests — lives in the git repository at
`tom_ai/d4rt/tom_d4rt_samples/d4rt_userbridges_sample/`.
