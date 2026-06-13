# log_pipeline — extended multi-file DCli sample

A file-processing pipeline written as a multi-file D4rt CLI script. It
synthesises a few sample `.log` files in a temp directory, then runs a
**parse → filter → aggregate** pipeline over them and emits both a coloured
console summary and a written report file.

It is the command-line analog of the Flutter "extended sample" apps — a real
multi-file program with a staged data-flow design, value types, and the DCli
filesystem bridges doing the I/O.

## Files

| File | Role |
|------|------|
| [`main.dart`](main.dart) | Entry point — fixture generation + pipeline wiring |
| [`models.dart`](models.dart) | `LogEntry` value type + line parser (`tryParse`) |
| [`stages.dart`](stages.dart) | `ParseStage`, `FilterStage`, `AggregateStage` |
| [`report.dart`](report.dart) | `Report` value type + plain-text and coloured renderers |

## What it exercises

- **Staged, cross-file data flow** — three single-responsibility stages
  composed from `main.dart` via relative imports.
- **Filesystem bridges** — `createTempDir`, `find`, `read`, `cat`, `exists`,
  `deleteDir`, and the `String.write` path extension.
- **Robust parsing** — malformed lines are skipped via a nullable
  `LogEntry.tryParse`.
- **Colour output** — per-level ASCII bars rendered with `red`, `yellow`,
  `green`, `grey` from DCli.

## Running

```bash
# Aggregate every level
dcli main.dart

# Keep only the listed levels (case-insensitive)
dcli main.dart ERROR WARN
dcli main.dart INFO

# Plain Dart works too (it is ordinary Dart source)
dart run main.dart ERROR
```

Positional arguments are the log levels to keep; with no arguments the
pipeline aggregates all levels.
