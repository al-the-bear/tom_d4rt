# build_suite — extended multi-file DCli sample

A miniature build/automation tool, written as a multi-file D4rt CLI script.
It is the command-line analog of the Flutter "extended sample" apps: a real
multi-file program with classes and functions split across files, driven by
the DCli **shell** and **filesystem** bridges, and wireable into a **BuildKit**
pipeline.

The suite never touches the surrounding workspace — every run builds a
throw-away Dart project inside a temp directory (`createTempDir`) and
discards it on exit.

## Files

| File | Role |
|------|------|
| [`main.dart`](main.dart) | Entry point — argument parsing + target dispatch |
| [`tasks.dart`](tasks.dart) | `BuildTask` hierarchy (`EnvCheck`, `Clean`, `Generate`, `Analyze`, `Package`) + `TaskRunner` |
| [`logger.dart`](logger.dart) | `BuildLogger` — coloured, step-numbered output via the DCli colour bridges |
| [`buildkit.yaml`](buildkit.yaml) | BuildKit pipelines (`ci`, `quick`) that drive the script |

## What it exercises

- **Cross-file classes & functions** — an abstract `BuildTask` base with
  concrete subclasses in `tasks.dart`, a `BuildLogger` in `logger.dart`, all
  composed from `main.dart` via relative imports.
- **Shell bridges** — `which('dart')`, `'dart --version'.firstLine`.
- **Filesystem bridges** — `createDir`, `find`, `read`, `exists`,
  `deleteDir`, `createTempDir`, and the `String.write` path extension.
- **Colour output** — `cyan`, `green`, `yellow`, `red`, `grey` from DCli.
- **BuildKit integration** — `buildkit.yaml` runs the script as pipeline steps.

## Running

```bash
# Default target is "all": env-check → clean → generate → analyze → package
dcli main.dart

# Individual targets
dcli main.dart clean
dcli main.dart generate
dcli main.dart analyze
dcli main.dart all

# Plain Dart works too (it is ordinary Dart source)
dart run main.dart analyze
```

Targets and the tasks they run are defined by `tasksForTarget` in
`tasks.dart`.

## Via BuildKit

```bash
bk :pipeline ci      # clean → analyze → all
bk :pipeline quick   # analyze only
```

See the DCli scripting guide, Appendix C (BuildKit Integration) for the
pipeline contract.
