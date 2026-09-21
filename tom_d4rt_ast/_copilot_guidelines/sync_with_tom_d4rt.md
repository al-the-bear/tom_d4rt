# 🚨 CRITICAL: tom_d4rt_ast and tom_d4rt Must Be Synchronized

## ⚠️ READ THIS BEFORE MAKING CHANGES

The **D4 class** exists in TWO locations that MUST stay synchronized:

| Package | File Location |
|---------|---------------|
| `tom_d4rt_ast` | `lib/src/runtime/generator/d4.dart` |
| `tom_d4rt` | `lib/src/generator/d4.dart` |

## Why Two Copies?

- `tom_d4rt_ast` is the standalone AST/interpreter package (minimal dependencies)
- `tom_d4rt` is the full D4rt package that re-exports tom_d4rt_ast plus adds helpers

Generated bridge code may import from either package depending on the project setup.

## Required Workflow

When modifying the D4 class:

1. **Make changes in BOTH files** - they must have identical helper methods
2. **Run tests in BOTH packages** before publishing
3. **Publish BOTH packages** - they must be published together
4. **Update dependents** - bump version constraints in projects that use either

## Publishing Order

1. `tom_d4rt_ast` (contains tom_d4rt_exec) - publish first
2. `tom_d4rt` - publish second (may depend on tom_d4rt_ast)

## Bumping again before the last bump shipped

**If the version you are replacing is already COMMITTED, add a new CHANGELOG
heading — do not rename the old one.** This package has done it twice: 0.22.0
was absorbed into 0.23.0, and 0.44.0 into 0.45.0 — two of the three occurrences
in the repo, which is why the rule is repeated here rather than left in
`tom_d4rt`'s build guidance.

It is not carelessness. A bump lands, the work turns out to be unfinished, and
renaming the heading is literally the right edit for "this goes out as the next
version instead". It is wrong only because the first number is already in
history with nothing describing it.

`F-SCC17-5` in `tom_d4rt`'s `release_hygiene_test.dart` fails on the next one,
but only after the commit exists — and the remedy then is to write a section
for a release nobody can install, or to add a baseline entry. Both are
bookkeeping for something two headings would have avoided. Rename freely only
while the version being replaced is still uncommitted.

## Methods That Must Be Synchronized

- `callInterpreterCallback()`
- `castCallbackResult<R>()` - ENG-011 fix
- `unwrapInterpreterValue()`
- `extractBridgedArg<T>()`
- `extractBridgedArgOrNull<T>()`
- All other static helpers on the D4 class

## Verification

After synchronizing, verify both compile:
```bash
cd tom_ai/d4rt/tom_d4rt_ast && dart analyze lib/src/runtime/generator/d4.dart
cd tom_ai/d4rt/tom_d4rt && dart analyze lib/src/generator/d4.dart
```
