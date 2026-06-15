# Regenerating the bridges

The `*.b.dart` files under `lib/` are produced by the D4rt bridge generator from
`buildkit.yaml`. **They are checked into this repository**, so every example
runs on a fresh clone without ever invoking the generator —
`./run_example.sh log_report` just works.

Only this project's native log-analysis library is generated here. The dcli
shell-scripting bridges (`read`/`write`/`find`, `'cmd'.run`, …) ship ready-made
inside `tom_d4rt_dcli` and are **not** generated — the runner registers them
directly via `TomD4rtDcliBridge.register`.

You only need to regenerate when you change the native library
(`lib/src/loglib/…`) or `buildkit.yaml`.

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
| `lib/src/d4rt_bridges/loglib_bridges.b.dart` | A `BridgedClass` for every type the barrel exports (`LogEntry`, `LogParser`, `LogStats`, `LogLevel`). |
| `lib/src/d4rt_bridges/relaxers.b.dart` | Generic relaxer wrappers. |
| `lib/d4rt_bridges.b.dart` | Barrel re-exporting the per-module bridge files. |
| `lib/dartscript.b.dart` | The `DcliSampleBridges` class with `register(d4rt)`, which the runner calls alongside `TomD4rtDcliBridge.register`. |

## Why the generated code is committed

Committing the output keeps the sample **browsable and runnable without a build
step**: a reader can open `loglib_bridges.b.dart` to see a real bridge, and a
user can run the examples without installing or running the generator. The
generator is deterministic, so regenerating over unchanged input reproduces the
same content (only the timestamp comment differs).

## Never hand-edit `*.b.dart`

The generated files carry a *"do not edit"* banner: the next regeneration
overwrites them. To change bridge behaviour, change the native library or
`buildkit.yaml` and regenerate.
