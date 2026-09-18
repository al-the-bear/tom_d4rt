## 0.2.2

### Added — `SConfiguration` and `SDottedName`: conditional import/export branches (sce49)

`SImportDirective` carried `uri`, `prefix`, `combinators`, `isDeferred` and
`metadata` — and no `configurations`; `SExportDirective` was the same. A
directive written

```dart
import 'stub.dart' if (dart.library.io) 'io.dart';
```

therefore had nowhere to put its branch, so a converter dropped it: the
directive survived as `import 'stub.dart';`, not reported, not warned about,
and not recorded anywhere. Every consumer downstream saw a well-formed import
of the default URI with no way to learn that a branch had been discarded — and
conditional imports are the standard Dart mechanism for VM-vs-web divergence.

`SConfiguration` (name, optional `== '...'` test value, branch URI) and
`SDottedName` (the condition's `dart.library.io`) are the missing nodes, and
both directives now carry a `configurations` list with JSON round-tripping,
structural equality and visitor dispatch (`visitConfiguration`,
`visitDottedName`).

**The conditions are preserved, not evaluated.** Which branch applies depends
on the target platform, which this model does not know; resolving it belongs to
the bundler at compile time or the runner at load time. A field that exists can
be resolved later — a dropped one cannot be recovered at all.

A patch bump rather than a minor one, although 0.2.0 set the precedent of a
minor for an additive node. `tom_ast_generator` depends on this package AND on
`tom_d4rt_ast`, which constrains it to `^0.2.0`; under pub's 0.x rules a 0.3.0
is breaking, so it could not resolve against a published `tom_d4rt_ast` until
that package shipped a raised constraint — which it cannot right now. Adding
API is not a breaking change, so the patch is also the semantically accurate
bump.

## 0.2.1

### Changed — formatted the tree once (scd82)

Every package in this repo already declares an SDK floor above the 3.7
tall-style boundary, so the formatter can no longer produce two layouts here.
What was not true is that the trees were formatted: until this commit, running
`dart format` on any single file rewrote it wholesale and buried whatever real
edit came with it.

**Proven layout-only rather than assumed.** `git diff -w` cannot establish it,
because the tall style *splits* lines and a whitespace-insensitive diff still
counts a moved boundary as a change. What was checked is the token stream, per
file, twice: whitespace stripped, then whitespace and commas stripped. The single changed file is identical to HEAD under that normalisation.

`dart analyze` is clean, the suite passes (7 tests), and the formatter is now
idempotent here.

## 0.2.0

- **Add `SRecordTypeField`** — the fields of a record type *annotation*
  (`int` and `String label` in `(int, {String label})`) were previously
  unrepresentable, so a converter had nowhere to put them and dropped them into
  an opaque placeholder. The arity survived; the field types and the named-field
  keys did not, which left the interpreter unable to answer
  `(42, label: 'answer') is (int, {String label})`.
- **Breaking:** `SRecordTypeAnnotation.positionalFields` / `.namedFields` are now
  `List<SRecordTypeField>` instead of `List<SAstNode>`, so a consumer cannot
  silently receive a field it can read nothing off. Bundles serialised before
  this version still deserialise — their fields come back typeless and nameless
  rather than being dropped, which preserves the recorded arity.

## 0.1.3

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 0.1.2

- Documentation: limitations and user guide updated; README aligned with the
  source-primary documentation reframe across the D4rt ecosystem.

## 0.1.1

- Add `StaticResolver` and the `resolvedSlot` / `declSlot` node fields that
  back the interpreter's slot-based variable resolution (static name → frame
  slot binding computed once, replacing per-access map lookups).
- Add `ForEachPartsWithPattern` support so pattern-destructuring `for-in`
  loops round-trip through the serializable AST.

## 0.1.0

- Initial release — extracted from `tom_d4rt_ast`
- Pure AST model classes with JSON serialization
- Zero external dependencies