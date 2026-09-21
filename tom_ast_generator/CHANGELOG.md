## 0.1.8

### Fixed — `library` directives crashed the copier (sce62)

`_convertLibraryDirective` cast `node.name` to `SIdentifier?`, but the
`LibraryIdentifier` that holds it had no dispatch arm in `convert()`. So it
became the `_SUnknownNode` placeholder and the cast failed:

```
type '_SUnknownNode' is not a subtype of type 'SIdentifier?' in type cast
```

`library foo; main() => 42;` is valid Dart that the reference interpreter runs
and returns 42 for — a library directive has no runtime effect. exec could not
interpret it at all, which is a conformance break rather than a missing
feature.

The name is flattened to one `SSimpleIdentifier` carrying the dotted text.
`SPrefixedIdentifier` could have carried two components but not three, so it
would have worked until somebody wrote `library a.b.c`. Nothing reads the
component structure; the flattening is recorded at the conversion site rather
than left to be rediscovered.

### Changed — an unhandled node now says what it is

An unhandled node type reaches `_SUnknownNode`, and the two paths that consume
converted nodes both failed badly:

* `_as<T>` cast, producing `type '_SUnknownNode' is not a subtype of type
  'SIdentifier?' in type cast` — naming neither the construct nor its position.
* `_nodesAs<T>` filtered on a type pattern, so an unhandled node in a
  statement, member or collection list was **silently dropped** and the script
  ran without it.

Both now raise `UnsupportedError` naming the analyzer node type, the offset and
the source text, the way the reference interpreter's
`Unsupported AST node 'X' at offset N` does. The two constructs this currently
affects — `class B = A with M;` and dot shorthands — are unsupported by the
reference interpreter too, so this changes the diagnosis rather than the
capability.

No construct reaches the `_nodesAs` drop today: every statement, class-member
and collection-element type the analyzer parses is dispatched, and
`Configuration`, the one list element that WAS dropped (0.1.7), has had an arm
since. That path is closed for the next unhandled type rather than for a
present defect.

### Added — `tool/census_copier.dart`

Which of the copier's 154 `_convert*` methods a test suite has never executed,
and which node types reach the placeholder. See the file header for what the
census can and cannot see — notably that it cannot see a handled node whose
FIELD is silently not copied, which is what 0.1.7 fixed.

## 0.1.7

### Fixed — conditional import/export branches are no longer dropped (sce49)

`_convertImportDirective` read `uri`, `prefix`, `combinators` and
`deferredKeyword`, and never `node.configurations` — because the mirror AST had
no field to put them in. `_convertExportDirective` was the same. So

```dart
import 'stub.dart' if (dart.library.io) 'io.dart';
```

reached every consumer as `import 'stub.dart';`: a well-formed import of the
default URI with nothing anywhere recording that a branch had been discarded.
Conditional imports are the standard Dart mechanism for VM-vs-web divergence,
so the symptom surfaces on one platform, far from the cause.

Both converters now populate `configurations`, and `analyzer.Configuration` and
`analyzer.DottedName` are in the `convert()` dispatch chain — a node type that
is not in it falls through to the opaque unknown-node placeholder and is then
filtered out of the typed list, which is how DGUB8 lost every record-type
field.

The conditions are COPIED, not evaluated: which branch applies depends on the
target platform, which this converter does not know.

Requires `tom_ast_model` 0.2.2, which adds `SConfiguration` and `SDottedName`.

### Added — a 1:1 fidelity ratchet over the directive nodes

`test/directive_mirror_fidelity_test.dart` enumerates, by reflection, every
getter the analyzer's `ImportDirective`, `ExportDirective`, `Configuration` and
`DottedName` declare, and requires each to be classified exactly once: mirrored
(naming the field on the mirror node, which must exist) or deliberately absent
(with the reason). A field the analyzer adds later is in neither set and fails
the test by name, instead of disappearing the way `configurations` did.

## 0.1.6

### Released — so the corrected stamp reaches the package people install (sce9)

The tree's stamp has read 0.1.6 for some time; published 0.1.5 still ships one
saying 0.1.4, so `astgen --version` from pub.dev names the wrong release. This
release carries the corrected stamp.


### Changed — formatted the tree once (scd82)

Every package in this repo already declares an SDK floor above the 3.7
tall-style boundary, so the formatter can no longer produce two layouts here.
What was not true is that the trees were formatted: until this commit, running
`dart format` on any single file rewrote it wholesale and buried whatever real
edit came with it.

**Proven layout-only rather than assumed.** `git diff -w` cannot establish it,
because the tall style *splits* lines and a whitespace-insensitive diff still
counts a moved boundary as a change. What was checked is the token stream, per
file, twice: whitespace stripped, then whitespace and commas stripped. All 44 changed files are identical to HEAD under that normalisation — no braces were needed, so this commit is pure layout.

`dart analyze` is clean, the suite passes (566 tests), and the formatter is now
idempotent here.

## 0.1.5

### Fixed — record type annotation fields are converted, not dropped (DGUB8)

`_convertRecordTypeAnnotation` called the generic `convert()` on each
`analyzer.RecordTypeAnnotationField`. That class was never in the dispatch
chain, so every field fell through to the opaque unknown-node placeholder:
the mirror annotation reached the interpreter carrying only its ARITY — no
field types, and no named-field keys. Downstream that made
`(42, label: 'answer') is (int, {String label})` unanswerable, and let
`(1, 'a') is (String, int)` answer true.

Fields now convert into `SRecordTypeField` (`tom_ast_model` 0.2.0), keeping
the declared type — recursively, so a record inside a record survives — and
the named-field key. `RecordTypeAnnotationField` is also wired into the
generic dispatch, so no future caller can silently produce a placeholder
again.

Requires `tom_ast_model >=0.2.0`.

## 0.1.4

- Publish the analyzer-10 migration. The 0.1.3 release on pub.dev still carried
  `analyzer: ^8.0.0` / `tom_d4rt_ast: ^0.1.5`; the source had already moved to
  `analyzer: ^10.0.0` / `tom_d4rt_ast >=0.1.11` without a version bump, so the
  hosted package was stale. This bump ships the analyzer-10 constraints.
- In-workspace dependencies now use lower-bound-only constraints (no upper cap)
  so `pub upgrade` tracks our latest published components during active
  development.

## 0.1.3

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 0.1.2

- Documentation: build.yaml/CLI guide, limitations, and user guide updated;
  README aligned with the source-primary documentation reframe across the D4rt
  ecosystem.

## 0.1.1

- Consume `tom_ast_model ^0.1.1` / `tom_d4rt_ast ^0.1.5`: the converter now
  populates the `StaticResolver` slot-resolution members
  (`resolvedSlot` / `declSlot`) on the mirror AST it emits.

## 0.1.0

- First public release on pub.dev.
- 1:1 converter from the Dart analyzer AST to the serializable mirror AST
  (`SAstNode` from `tom_ast_model`), node-for-node and field-for-field.
- AST bundling machinery: parse once with the analyzer, copy to the mirror
  AST, serialize to JSON, interpret later without the analyzer.