# astgen — configuration and command line

`astgen` converts Dart source files into serialized mirror-AST files
(`*.ast.yaml`). It is the batch, file-emitting front end of this package; the
`AstBundler` library API, which produces the JSON bundles `tom_d4rt_ast`
executes, is described in the
[user guide](tom_ast_generator_user_guide.md).

Everything below is what the shipped tool (`bin/astgen.dart`,
`lib/src/v2/`) reads and does. `test/v2/scf33_astgen_doc_examples_test.dart`
runs every `astgen:` example in this file through the tool, so an example that
stops being readable fails a test.

## Where the configuration lives

astgen reads one file: **`buildkit.yaml` in the project root**, and within it
the `astgen:` section. There is no other configuration file — no
`tom_build.yaml`, no `build.yaml`, and no build_runner builder.

A project whose `buildkit.yaml` is missing, or has no `astgen:` section, is
skipped without a message. That is what lets astgen run across a whole
workspace and act only on the projects that asked for it.

```yaml
# buildkit.yaml
astgen:
  convert:
    - entrypoints: lib/**/*.runner.dart
      output: assets/ast
```

`convert` is a list; each entry is one conversion, run in order.

## A `convert` entry

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `entrypoints` | string | **required** | Glob of the files to convert, relative to `root`. |
| `output` | string | **required** | Directory the `.ast.yaml` files are written to. See below. |
| `root` | string | `.` | Directory, relative to the project, that `entrypoints` and `exclude` are matched from, and that `preserve_structure` keeps paths relative to. |
| `exclude` | list of strings, or one string | none | Globs, relative to `root`, removed from the `entrypoints` matches. |
| `preserve_structure` | bool | `false` | Keep each file's directory, relative to `root`, under `output`. When `false` every file lands directly in `output`. |
| `include_sourcemap` | bool | `false` | Wrap the AST in a `sourcemap` / `ast` pair recording the source file's absolute path and the generation time. |
| `include_imports` | bool | `false` | **Accepted and ignored.** Import following is not implemented; with `--verbose` the tool says so. Use `AstBundler` when a script's imports must travel with it. |
| `import_depth` | int | `1` | Ignored, as `include_imports`. |
| `include_relative_imports` | bool | `true` | Ignored, as `include_imports`. |

An entry without `entrypoints` or `output` fails the project.

### `output`

Three forms:

- **`project:<name>/<subdir>`** — the directory `<subdir>` inside the project
  whose `pubspec.yaml` declares `name: <name>`. The project is looked for
  relative to the project being converted: `../<name>`, `../*/<name>` and
  `../*/*/<name>`, first match wins. A name that is not found fails the
  project.
- **a relative path** — relative to the project root, for example
  `assets/ast` or `../runtime/assets`.
- **an absolute path**.

The directory is created when it does not exist.

### Output file names

The output name is the source name with its **last** extension replaced by
`.ast.yaml`:

```
lib/hello.dart          → hello.ast.yaml
lib/hello.runner.dart   → hello.runner.ast.yaml
```

With `preserve_structure: true` the path relative to `root` is kept as well:

```yaml
astgen:
  convert:
    - entrypoints: '**/*.runner.dart'
      root: lib
      output: project:tom_runtime/assets
      preserve_structure: true
```

```
lib/tools/my_tool.runner.dart   → <tom_runtime>/assets/tools/my_tool.runner.ast.yaml
lib/main.runner.dart            → <tom_runtime>/assets/main.runner.ast.yaml
```

With `root: .` the same files keep their `lib/` prefix:
`assets/lib/tools/my_tool.runner.ast.yaml`. Without `preserve_structure`,
files with the same name in different directories overwrite one another in
`output`.

### Globs

`entrypoints` and `exclude` use `package:glob` syntax, matched from `root`:
`*` does not cross a `/`, `**` does, and `**/` also matches no directory at
all, so `lib/**/*.runner.dart` finds `lib/a.runner.dart` as well as
`lib/x/y/a.runner.dart`. Quote a glob that starts with `*` or `**` — a bare
`*` begins a YAML alias.

### A complete example

```yaml
astgen:
  convert:
    # Runner scripts, flat, with source maps for error reporting.
    - entrypoints: lib/**/*.runner.dart
      exclude:
        - lib/**/*.g.dart
        - lib/**/*.freezed.dart
      output: project:tom_runtime/assets
      include_sourcemap: true

    # Walker tools, keeping their directory layout.
    - entrypoints: '**/*.walker.dart'
      root: example/walkers
      output: build/ast/walkers
      preserve_structure: true
```

## What astgen writes

One YAML file per source file: the `SCompilationUnit` produced by
`AstConverter`, serialized field for field, null fields omitted. With
`include_sourcemap: true` the file reads:

```yaml
sourcemap:
  source_file: /absolute/path/to/lib/hello.runner.dart
  generated_at: 2026-09-30T10:30:45.123
ast:
  # the SCompilationUnit
```

Each file stands alone: imports are recorded as directives, not followed.

## Errors

A project **fails** — and the run exits non-zero — when:

- `buildkit.yaml` cannot be parsed, or a `convert` entry lacks `entrypoints` or
  `output`;
- a `root` directory does not exist;
- an `output` cannot be resolved (a `project:` name that is not found);
- a matched file has a parse error. Conversion stops at that file; files
  converted before it are already written.

An `entrypoints` glob that matches nothing is a **warning**, not a failure: a
project whose scripts have not been written yet should not break a
workspace-wide run.

The verdict does not depend on `--verbose` or `--dry-run`. A dry run resolves
every `output` and so fails on the same configuration a real run fails on,
which makes `--dry-run` the way to check a new configuration.

## Command line

astgen is a `tom_build_base` tool, so project selection and traversal are the
shared ones described in
[CLI Tools Navigation](https://github.com/al-the-bear/tom_basics/blob/main/tom_build_base/doc/cli_tools_navigation.md).
`astgen --help` lists every option; the ones used most:

| Option | Effect |
| --- | --- |
| *(none)* | Process the project in the current directory and every project found below it. Projects named `zom_*` are test fixtures and are skipped. |
| `-p, --project=<pattern>` | Only the named projects (names, paths or globs; comma-separated). |
| `-s, --scan=<path>` | Start the scan at `<path>` instead of the current directory. |
| `-r, --recursive` / `--not-recursive` | Descend into subdirectories, or not. |
| `-x, --exclude=<pattern>`, `--exclude-projects=<name>` | Leave projects out by path or by name. |
| `-R, --execution-root[=<path>]` | Run from the workspace root; a bare `-R` finds it. |
| `--test` | Include the `zom_*` test projects. |
| `-n, --dry-run` | Print `source -> output` for every file, write nothing. |
| `-v, --verbose` | Print each conversion's settings, the resolved paths and a summary. |
| `-l, --list` | List the projects that have an `astgen:` section, and do nothing else. |
| `--show` | With `--list`, also print each project's `astgen:` section. |

```bash
# Check a configuration: which projects, what they say, what they would write
dart run tom_ast_generator:astgen --list --show
dart run tom_ast_generator:astgen --dry-run

# Convert
dart run tom_ast_generator:astgen

# One project, from anywhere in the workspace
dart run tom_ast_generator:astgen -R -p my_project -v
```

Installed as a binary (see the README), the command is `astgen` with the same
options.
