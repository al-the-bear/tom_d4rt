## 0.1.6

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