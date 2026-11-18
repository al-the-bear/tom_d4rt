# Resolved bundles: the static facts table

A bundle carries the program's syntax, not its static types. Where Dart's
behaviour depends on a static type the program does not write, the runtime
approximates it from run-time values. Two examples: the type arguments of an
extension called on a typed local (`final Map<String, int> m = host(); m.keyKind()`),
and the element type of an untyped literal (`[1, 2]`). A resolving bundler
knows those types, because the analyzer resolved the program. It records them
in an optional **static facts table**, so a runtime can use them where it
would otherwise approximate.

## Writing it

`AstBundlerConfig(resolve: true)` runs the resolving check (see the user
guide). With `staticFacts: true`, the default, the same resolution also
records the facts, and the bundler returns a `ResolvedAstBundle`:

```dart
final bundle = await AstBundler(
  explicitSources: sources,
  declarationStubs: stubs,
  fileAccessValidator: (_) => false,
  config: const AstBundlerConfig(resolve: true),
).createFromSource(sources[entry]!, sourcePath: entry);

if (bundle is ResolvedAstBundle) {
  print('${bundle.facts.factCount} facts');
}
final bytes = bundle.toBytes(); // carries the table under "facts"
```

A program with no fact gets a plain `AstBundle`. So does bundling with
`staticFacts: false`, or without `resolve`. `astgen --resolve` checks
entrypoints but writes single converted units, not bundles, so it writes no
table.

## What is recorded

The model is `SStaticFacts` in `tom_ast_model` (`lib/src/facts/static_facts.dart`).
Two kinds of fact are recorded, each keyed by the node it is about.

| Fact | Node it is keyed by | Holds |
| --- | --- | --- |
| `SExtensionCallFact` | the `MethodInvocation`, `PropertyAccess`, `PrefixedIdentifier`, `IndexExpression`, `BinaryExpression` or `PrefixExpression` that reaches an extension member, or the left-hand side of an assignment to an extension setter | the receiver's static type, the extension's library URI and name (none for an unnamed extension), the extension's type arguments as Dart infers them from its `on` type |
| `STypeArgumentsFact` | a generic `MethodInvocation` / `FunctionExpressionInvocation`, an `InstanceCreationExpression` or a `ListLiteral` / `SetOrMapLiteral` that does not write its type arguments | the inferred type arguments |

- **No explicit receiver, no fact.** An extension member reached without an
  explicit receiver gets no fact: inside the extension, `this` is the receiver
  it was called on.
- **One fact per node.** A generic extension method called without type
  arguments keeps the extension fact.
- **A type that cannot be named gets no fact.** For example, a type from a
  library that exists only at run time and has no declaration stub leaves its
  node without one. A typed local still names its type even then:
  `final Map<String, int> m = host();` records `Map<String, int>`.

## Layout

```json
"facts": {
  "format": 1,
  "stamp": {"sdk": "3.13.7 (stable) ...", "packages": {"intl": "0.20.3"}},
  "types": [{"k": "i", "u": "dart:core", "n": "String"}, ...],
  "modules": {
    "package:p/main.dart": {
      "120:18": {"x": [2, "package:p/main.dart", "KeyKind", [0, 1]]},
      "40:6": {"t": [3]}
    }
  }
}
```

- **`modules`.** Module URI → the node's `offset:length` in that module's
  source → the fact. Offsets are those the converter stores on every node, so
  the runtime finds a node's fact by its own offset and length.
- **`types`.** Every type, interned once per bundle and referred to by index:
  - `k` is the kind: `i` interface, `p` type parameter, `f` function, `r` record,
    `d` dynamic, `v` void, `n` Never;
  - `u` is the declaring library URI and `n` the name;
  - `a` holds the type arguments as indices;
  - `q` is set for a nullable type;
  - `s` holds the display string of a function or record type.
- **`format`.** The table's own format number. A reader that finds another
  number reads no table (`SStaticFacts.fromJson` returns null).
- **The bundle format does not change.** The key is optional and additive.
  `AstBundle.fromJson` reads the keys it knows, so a reader that does not know
  `facts` reads and runs the bundle as before. The bundle's `version` stays
  `2.0`.
- **The ZIP form.** `ResolvedAstBundle.toZip` (tom_d4rt_ast 0.244's) does not
  carry the table; tom_d4rt_ast 0.251.0's `AstBundle.toZip` does.

## The stamp, and when a runtime trusts the facts

The facts describe the program as the analyzer saw it: against one Dart SDK
and particular versions of the packages the program's types come from. The
stamp records that:

- **`sdk`.** The `version` file of the Dart SDK the analyzer ran on.
- **`packages`.** Name → version, for every package that a recorded type
  comes from and whose version the bundler could read (in a project, from the
  package's `pubspec.yaml`). With `explicitSources` alone there are no
  versions to read, so the map is empty.

A runtime compares the stamp with what it runs against, as follows:

1. **Packages.** For each stamped package that the runtime bridges, the
   package's version must equal the version of its bridges.
2. **The SDK.** Where the host can tell its Dart SDK version, its
   `major.minor` must equal the stamp's.
3. **What is not compared.** A package or SDK the runtime cannot tell the
   version of.
4. **On a mismatch.** The runtime ignores the whole table and approximates as
   it does without one. It reports the mismatch once through the run's
   diagnostics. It never refuses the bundle, so a mismatch can never make
   behaviour worse than a bundle without facts.

## The runtime side

tom_d4rt_ast (from 0.251.0) reads the table into `AstBundle.facts`, from JSON,
from gzip bytes and from the ZIP entry `facts.json.gz`.
`D4rtRunner.executeBundle` runs the stamp check above:
- the host declares its bridge versions in `bridgedPackageVersions`;
- its SDK is `hostSdkVersion` (`Platform.version` on the VM, null on the web).

When the check passes, the runner attaches each fact to its node, and the
interpreter uses it:
- for an extension member's type arguments, and for the extension Dart
  picks by the receiver's static type - method calls, getters, operators,
  index operators and setters alike;
- for the inferred type arguments of literals, calls and creations.

On a mismatch the run ignores the table and reports the mismatch once through
`D4rtRunner.onDiagnostic`. What changes for a script, side by side with native
Dart: `tom_d4rt_ast/doc/resolved_bundles.md`.

## Size

Measured on 2026-11-17 on mbp (Dart 3.13.7, analyzer 14.7.0). Each figure is
the bundle JSON (`toJson`, compact) and its gzip size, without the table →
with it.

| Bundle | JSON | gz | Facts / types |
| --- | --- | --- | --- |
| GitHub #18's repro (with its stub) | 5.4 KB, +5.3% | 1.1 KB, +8.6% | 1 / 3 |
| intl 0.20.3 closure (intl, clock, meta, path; 32 modules) | 4.7 MB, +1.1% | 340 KB, +3.3% | 2,050 / 26 |
| One Flutter script (`range_labels_test`, 1,327 lines) | 598 KB, +0.1% | 53 KB, +0.7% | 6 / 3 |
| The 351 material corpus scripts | 194 MB, +0.3% | 16.9 MB, +1.1% | 16,489 / 1,665 |

Collecting the facts adds a small share to the resolve time. Resolving
itself is the cost: see the user guide's resolving check.
