# Resolved bundles: running with static facts

tom_d4rt_ast interprets a program without its static types: the bundle is
parsed, not resolved. Where Dart's behaviour depends on a static type the
program does not write, the interpreter approximates it from run-time values.
The limitations doc's Lim-13 (`tom_d4rt/doc/d4rt_limitations.md`) describes
this.

A bundle made in tom_ast_generator's resolving mode carries those types as an
optional **static facts table** (`AstBundle.facts`). The bundle side is
described in `tom_ast_generator/doc/resolved_bundles.md`: what is recorded,
the layout, and the stamp. `D4rtRunner.executeBundle` uses the table when its
stamp agrees with the host.

## What the facts change

| Where | Without facts | With facts (as in Dart) |
| --- | --- | --- |
| An extension's type parameters on a method call, getter, property access, operator, index operator or setter | From the receiver's written type, else its run-time type arguments, else `dynamic` | From the receiver's static type: `{'x': 7}.keyKind()` binds `K = String` |
| Which extension a member goes to, when several apply | The first one in scope whose `on` type matches the receiver's run-time type | The one Dart picks by the receiver's static type |
| An untyped list, set or map literal | Answered from its elements; `{}` with no elements is a map | The type arguments Dart inferred: `[1, 2]` is a `List<int>`, `Set<int> s = {}` is a set |
| A generic call or instance creation that writes no type arguments | Type parameters unbound, or taken from the arguments | The inferred type arguments: `typeOf(3)` binds `T = int`, `Box('s')` is a `Box<String>` |

GitHub #18's map cases, side by side (the test
`test/runtime/ghissues70_static_facts_test.dart` runs them natively and
interpreted):

| Expression | Native Dart | With facts | Without facts |
| --- | --- | --- | --- |
| `narrow.keyKind()` (`Map<String, int> narrow`) | `String` | `String` | `String` |
| `wide.keyKind()` (`Map<dynamic, dynamic> wide = narrow`) | `dynamic` | `dynamic` | `dynamic` |
| `{'x': 7}.keyKind()` | `String` | `String` | `dynamic` |
| `emptyNarrow.toJson()` (`K == String ? {} : []`) | `{}` | `{}` | `{}` |
| `emptyWide.toJson()` | `[]` | `[]` | `[]` |
| `<String, int>{}.toJson()` | `{}` | `{}` | `{}` |
| `narrow.kind()` (extensions on `Map<dynamic, dynamic>` and `Map<String, int>`) | `narrow` | `narrow` | `wide` |
| `[1, 2].keyKindOfList()` (`E.toString()`) | `int` | `int` | `dynamic` |
| `typeOf(3)` (`'$T'`) | `int` | `int` | `T` |
| `Box('s').kind` (`'$T'`) | `String` | `String` | `dynamic` |

**Operators, index operators and setters.** An extension's binary and
prefix operators (`m + 1`, `~m`), its index operators (`s[0]`, `s[0] = v`)
and its setters (`m.tag = v`) use the facts too; the test
`test/runtime/ghissues75_static_facts_operators_test.dart` runs them natively
and interpreted. An extension `operator []` or `[]=` on `Map` never runs, in
Dart or here: `Map` declares both itself, and an instance member wins.

**A type the scope cannot name.** If a type in a fact cannot be named in the
current scope (a type from a library the module does not import), that one
fact is not used and the interpreter approximates as without it.

## The stamp check

The facts describe the program as the analyzer saw it. A run uses them only
where the host agrees with the stamp:

- **`D4rtRunner.bridgedPackageVersions`** (package name → version) declares
  the version of each package whose bridges the runner registers. A stamped
  package listed there must have exactly that version. A package not listed is
  not compared.
- **`D4rtRunner.hostSdkVersion`** is the host's Dart SDK: `Platform.version`
  on the VM, null on the web. Its `major.minor` must equal the stamp's. Null
  is not compared.

On a mismatch the run ignores the whole table and approximates as without it.
The mismatch is reported once per bundle and runner, naming both versions:

- through `D4rtRunner.onDiagnostic`;
- as a warning through the logger.

`lastRunUsedStaticFacts` and `lastStaticFactsMismatch` tell what the last
`executeBundle` did.

```dart
final runner = D4rtRunner()
  ..bridgedPackageVersions['flutter'] = '3.47.9'
  ..onDiagnostic = (message) => log.warning(message);
final result = runner.executeBundle(AstBundle.fromBytes(bytes));
```

## Formats

The table travels with the bundle in every format:

- **JSON and gzip bytes:** under the `facts` key;
- **ZIP:** as the entry `facts.json.gz`, which the manifest does not name.

A reader without the table support, such as tom_d4rt_ast before 0.251.0,
ignores it and runs the bundle as before. The bundle format version stays
`2.0`. A table of another table format, or an unreadable one, is dropped when
the bundle loads. The bundle then runs as without facts.

## tom_d4rt

tom_d4rt runs source, not bundles, so it has no static facts and always
approximates. This is the one place where the two interpreters answer
differently for the same program on purpose: tom_d4rt_ast with a resolved
bundle, against tom_d4rt with the same source.
