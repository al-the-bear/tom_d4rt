# Regenerating the bridges

The `*.b.dart` files under `lib/` are produced by the D4rt bridge generator from
`buildkit.yaml`. **They are checked into this repository**, so every example
runs on a fresh clone without ever invoking the generator —
`./run_example.sh money_math` just works.

This sample is special: before generating, the generator **pre-scans** the
barrel's exported files for `@D4rtUserBridge` / `@D4rtGlobalsUserBridge` classes
(under `lib/src/d4rt_user_bridges/`) and folds those hand-written overrides into
the generated registration tables. So the committed `ledger_bridges.b.dart`
already contains both the auto-generated members *and* the user-bridge overrides
woven together — there is no separate registration step for the overrides.

You only need to regenerate when you change the native library
(`lib/src/…`), a user bridge, or `buildkit.yaml`.

## Command

Run from the package root:

```sh
dart pub get      # once, if you have not already
dart run tom_d4rt_generator:d4rtgen --not-recursive -s "$(pwd)"
```

- `-s "$(pwd)"` points the generator at this package. It needs an **absolute,
  normalized** scan path; a bare `dart run tom_d4rt_generator:d4rtgen` fails with
  *"Only absolute normalized paths are supported: ."*.
- `--not-recursive` stops it from descending into sibling packages in the
  workspace.

## What it produces

| File | Purpose |
| --- | --- |
| `lib/src/d4rt_bridges/ledger_bridges.b.dart` | A `BridgedClass` for every exported native type (`Money`, `Grid`, `Box`, globals), **with the user-bridge overrides woven in** (e.g. `'+': MoneyUserBridge.overrideOperatorPlus`). |
| `lib/src/d4rt_bridges/relaxers.b.dart` | Generic relaxer wrappers (for `Box<T>`). |
| `lib/d4rt_bridges.b.dart` | Barrel re-exporting the per-module bridge files. |
| `lib/dartscript.b.dart` | The `UserBridgesSampleBridges` class with `register(d4rt)`, which the runner calls. |

## A user bridge must be reachable from the barrel

The pre-scan only sees `@D4rtUserBridge` classes that are exported (directly or
transitively) from a module's barrel file. This sample exports the
`lib/src/d4rt_user_bridges/*.dart` files from `lib/d4rt_userbridges_sample.dart`
for exactly that reason. A user bridge that isn't exported is silently ignored.

## Why the generated code is committed

Committing the output keeps the sample **browsable and runnable without a build
step**: a reader can open `ledger_bridges.b.dart` to see precisely how an
override is wired in, and a user can run the examples without installing or
running the generator. The generator is deterministic, so regenerating over
unchanged input reproduces the same content (only the timestamp comment differs).

## Never hand-edit `*.b.dart`

The generated files carry a *"do not edit"* banner: the next regeneration
overwrites them. To change behaviour, edit the native library, the user bridge,
or `buildkit.yaml` and regenerate.
