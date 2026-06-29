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