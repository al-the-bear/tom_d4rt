# D4rt Exec Project Guidelines

**Project:** `tom_d4rt_exec`  
**Type:** Dart Package (migration target)

## Purpose

`tom_d4rt_exec` is the migration target for the analyzer-free D4rt split. It starts as a copy of `tom_d4rt` v1.8.1 and will be transformed to run entirely on the mirror AST from `tom_d4rt_ast`, eliminating the `analyzer` dependency.

The original `tom_d4rt` stays untouched — all existing project dependencies remain on `tom_d4rt`. Once the migration is complete, downstream projects can switch to `tom_d4rt_exec` by changing one `pubspec.yaml` line and imports.

## Migration Plan

1. Move interpreter infrastructure into `tom_d4rt_ast` (swap analyzer imports for mirror AST)
2. Rewire `tom_d4rt_exec` to use `tom_d4rt_ast` (interpreter) + `tom_d4rt_astgen` (parsing)
3. Run conformance tests: same test suite against `tom_d4rt` and `tom_d4rt_exec`
4. Once passing, downstream projects can switch dependencies

## Conformance Testing

Run the same tests against both packages to detect regressions:
- `tom_d4rt` = reference (1680 passing, 2 pre-existing failures as of v1.8.1)
- `tom_d4rt_exec` = migration target (must match or exceed)

## Related Packages

- `tom_d4rt` — The stable, unchanged reference version (all projects depend on this)
- `tom_d4rt_ast` — Mirror AST model (zero deps, serializable)
- `tom_d4rt_astgen` — 1:1 copier: analyzer AST → mirror AST
- `tom_d4rt_generator` — Code generator for bridges
- `tom_d4rt_dcli` — DCli integration for D4rt scripting
