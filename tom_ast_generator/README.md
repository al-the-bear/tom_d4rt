# tom_ast_generator

A 1:1 converter from the Dart analyzer AST to a fully serializable mirror AST, with bundling machinery that enables parse-once, serialize, and interpret-without-analyzer workflows.

## Overview

`tom_ast_generator` sits at the boundary between the Dart `analyzer` package and the analyzer-free D4rt runtime. Its job is precise: walk every node of an `analyzer.CompilationUnit`, and produce a structurally identical tree of `SAstNode` objects (defined in `tom_ast_model` / `tom_d4rt_ast`) — one mirror node per analyzer node, one field per field, no information lost.

Once converted, the mirror AST has no dependency on the Dart analyzer. It can be serialized to JSON (or YAML), bundled alongside application assets, and later interpreted by `tom_d4rt_exec` or any D4rt-compatible runtime without the analyzer ever being present. This matters most in Flutter applications, where shipping the `analyzer` package is impractical. The pipeline is:

```
Dart source files
       │
       ▼  (analyzer — build/CI machine)
analyzer.CompilationUnit
       │
       ▼  AstConverter.convertCompilationUnit()
SAstNode tree (tom_ast_model)
       │
       ▼  AstBundler → AstBundle.toJson() / toBytes()
.ast.yaml / .json asset  ←─── shipped inside app
       │
       ▼  (tom_d4rt_ast / tom_d4rt_exec — device, no analyzer)
Interpreted at runtime
```

The package also provides the `astgen` CLI, which automates the conversion step across a whole Dart workspace using `buildkit.yaml`-driven configuration.

## Installation

### As a library dependency

```yaml
dependencies:
  tom_ast_generator: ^0.1.1
```

```
dart pub add tom_ast_generator
```

The public library export is `package:tom_ast_generator/tom_ast_generator.dart`
(also importable as `package:tom_ast_generator/tom_d4rt_astgen.dart` for
legacy compatibility). Both re-export `AstConverter`, `AstBundler`,
`AstBundlerConfig`, `ImportResolution`, `ImportAction`, and the full
`tom_d4rt_ast` surface (`SCompilationUnit`, `SAstNode`, `AstBundle`, etc.).

### As a CLI tool

The package ships a `bin/astgen.dart` executable registered as `astgen`. To
activate it globally:

```
dart pub global activate tom_ast_generator
astgen --help
```

Or invoke it without activation from within a project that depends on it:

```
dart run tom_ast_generator:astgen --help
```

## Features

### 1. Full-coverage AST conversion (`AstConverter`)

`AstConverter.convertCompilationUnit()` converts an `analyzer.CompilationUnit`
to `SCompilationUnit` by dispatching every `analyzer.AstNode` subtype through a
single `convert()` method. Coverage includes:

- **Declarations** — classes, mixins, enums, extensions, extension types, functions, top-level variables, constructors, fields, type aliases (`typedef`), enum constants
- **Statements** — block, if/else, for/for-each, while, do-while, switch (classic and expression), try/catch, break, continue, return, yield, assert, labeled, empty
- **Expressions** — binary, prefix, postfix, conditional (`?:`), assignment, method invocation, function expression invocation, index, property access, cascade, instance creation, `this`, `super`, `throw`, `await`, `as`, `is`, `rethrow`, named, spread, null-aware collection elements, if-element, for-element, function and constructor references
- **Literals** — integer, double, boolean, simple string, string interpolation, adjacent strings, null, list, set/map, symbol, record
- **Types** — named type, generic function type, type argument list, type parameter list, record type annotation
- **Parameters** — simple, default, field-formal (`this.`), function-typed, super-formal
- **Function bodies** — block, expression (`=>`), empty, native
- **Directives** — import, export, part, part-of, library
- **Dart 3 patterns** — constant, wildcard, declared variable, assigned variable, object, list, map, record, pattern field, logical-or, logical-and, cast, relational, null-check, null-assert, parenthesized, rest; plus `switch` pattern cases, guarded patterns, `when` clauses
- **Extension types** — `ExtensionTypeDeclaration`, `RepresentationDeclaration`
- **Misc** — annotations, comments, argument lists, labels, extends/implements/with clauses, constructor names, super and redirecting constructor invocations, show/hide combinators

Unknown node types produce a placeholder `_SUnknownNode` (carrying offset, length, and the original runtime type name) rather than throwing, so partial conversion is always possible.

### 2. AST bundling with recursive import resolution (`AstBundler`)

`AstBundler` builds an `AstBundle` — a self-contained map of URI → `SCompilationUnit` — from either a source string or a file path. It recursively follows imports and parts, respecting a priority-ordered resolution strategy:

| Import type | Resolution |
|-------------|------------|
| `dart:*` (and custom `stdlibSchemes`) | Skip — available at runtime |
| URI in `bridgedLibraries` | Skip — native bridge handles it |
| URI in `explicitSources` | Include provided source string |
| `package:same_package/…` | Auto-include from disk via `projectRoot` |
| Relative/file-path import | Auto-include from disk |
| Other `package:…` | Error — not bridged and not same-package |

Circular import chains are handled safely through a visited-URI set; an
optional `maxImportDepth` (default 64) acts as a final safeguard.

A `fileAccessValidator` callback can gate every disk read, wiring the bundler
to D4rt's `FilesystemPermission` sandbox.

The resulting `AstBundle` (from `tom_d4rt_ast`) is JSON- and
binary-serializable (`toJson()`, `toBytes()`, `fromJson()`, `fromBytes()`),
making it suitable for embedding as a Flutter asset or writing to disk.

### 3. `astgen` CLI — workspace-wide batch conversion

The `astgen` CLI converts Dart source files to `.ast.yaml` files in bulk,
driven by an `astgen:` section in `buildkit.yaml`. It integrates with the
`tom_build_base` workspace navigation infrastructure (project discovery, scan,
recursion, dry-run, verbose).

Key CLI options (standard `tom_build_base` flags):

| Option | Description |
|--------|-------------|
| `--scan <dir>` / `-s` | Scan directory for projects with `astgen:` config |
| `--project <path>` / `-p` | Process a single project |
| `--recursive` / `-r` | Recurse into sub-projects during scan |
| `--dry-run` | Show what would be converted, write nothing |
| `--verbose` / `-v` | Show per-file detail |
| `--list` | List projects that have astgen config; combine with `--show` to print their config sections |
| `--version` / `-V` | Print version |

Generated files use the `.ast.yaml` extension:
`my_runner.dart` → `my_runner.ast.yaml`.

## Usage

### Quick start — converting a single file programmatically

```dart
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';

void main() {
  const source = '''
void greet(String name) {
  print('Hello, \$name!');
}
''';

  // 1. Parse with the analyzer
  final parseResult = parseString(content: source, throwIfDiagnostics: false);

  // 2. Convert to the mirror AST
  final converter = AstConverter();
  final mirrorAst = converter.convertCompilationUnit(parseResult.unit);

  // 3. Serialize to JSON (round-trip safe)
  final json = mirrorAst.toJson();
  final restored = SCompilationUnit.fromJson(json);

  print('Declarations: ${restored.declarations.length}'); // 1
}
```

### Building a bundle for runtime shipping

```dart
import 'package:tom_ast_generator/tom_ast_generator.dart';

Future<void> main() async {
  // Create a bundler — tell it which packages are handled by native bridges
  final bundler = AstBundler(
    bridgedLibraries: {
      'package:my_native_lib/my_native_lib.dart',
    },
    // packageName and projectRoot are auto-detected from pubspec.yaml
    // when createFromFile() is used, but can be set explicitly:
    packageName: 'my_app',
    projectRoot: '/path/to/my_app',
  );

  // Build a bundle from a file — imports are resolved recursively
  final bundle = await bundler.createFromFile('lib/scripts/entry.dart');

  // Serialize to JSON for embedding as a Flutter asset
  final json = bundle.toJson();

  // Or serialize to compact bytes
  final bytes = bundle.toBytes();

  // At runtime (no analyzer needed):
  // final restored = AstBundle.fromBytes(bytes);
  // final runner = D4rtRunner();
  // await runner.run(restored);
}
```

### Using explicit sources (in-memory imports)

```dart
final bundler = AstBundler(
  explicitSources: {
    'package:helpers/math.dart': 'int add(int a, int b) => a + b;',
  },
);

final bundle = await bundler.createFromSource('''
import 'package:helpers/math.dart';
void main() { print(add(1, 2)); }
''');
```

### `astgen` CLI — `buildkit.yaml` configuration

Place an `astgen:` section in `buildkit.yaml` at your project root:

```yaml
astgen:
  convert:
    - entrypoints: lib/*.runner.dart
      output: project:tom_runtime/assets
      root: .
      exclude:
        - lib/*.g.dart
      preserve_structure: false
      include_sourcemap: true
```

Then run:

```bash
# Convert all matched files in the current project
astgen

# Dry run — show what would be written
astgen --dry-run --verbose

# Scan a whole workspace recursively
astgen --scan . --recursive
```

Output path formats supported in `output`:

- `project:tom_runtime/assets` — workspace-relative project lookup by `pubspec.yaml` name
- Absolute path: `/path/to/output`
- Relative path: `../other_project/assets`

See `doc/astgen_build_yaml.md` in this package for the full configuration
reference, including `preserve_structure`, `include_sourcemap`, and exclusion
patterns.

## Architecture and key concepts

### Node-for-node copying

`AstConverter` is a pure structural mapper. It does not use the `analyzer`'s
visitor infrastructure; instead, `convert(AstNode?)` is a flat dispatch chain
that matches every known `AstNode` subtype and calls a dedicated private
converter for it. Each converter creates the corresponding `SAstNode` subclass,
calling `convert()` recursively for every child. Offset and length are
preserved on every node for future source-mapping.

### The bundle format (`AstBundle`)

An `AstBundle` is a plain Dart object (from `tom_d4rt_ast`):

```dart
class AstBundle {
  final String entryPointUri;             // e.g. 'lib/main.dart'
  final Map<String, SCompilationUnit> modules; // URI → parsed AST
}
```

`AstBundler` populates `modules` by recursively resolving imports from the
entry point. The bundle is complete and self-contained: every Dart source file
that is not a `dart:*` stdlib module or a bridged native library is included.
The resulting bundle is serialized via `toJson()` / `toBytes()` and can be
reconstructed with `fromJson()` / `fromBytes()` — with no analyzer involvement.

### `buildkit.yaml` vs `tom_build.yaml`

The `astgen` CLI uses two configuration files:

- **`buildkit.yaml`** (or `build.yaml`) — per-project conversion rules (`astgen: convert: [...]`). This is what drives file-to-file conversion.
- **`tom_build.yaml`** — workspace-level project discovery marker. Projects that have this file with an `astgen:` section are discovered automatically when running `astgen --scan`.

### YAML output format

The CLI emits `.ast.yaml` files. The YAML is generated directly from the mirror AST's `toJson()` map; null fields are omitted for compactness. When `include_sourcemap: true` is set, the YAML is wrapped:

```yaml
sourcemap:
  source_file: /absolute/path/to/source.dart
  generated_at: 2026-02-06T10:30:45.123Z
ast:
  # ... mirror AST content
```

## Ecosystem position

```
tom_ast_model          (zero-dependency AST node definitions)
      ▲
tom_d4rt_ast           (analyzer-free runtime: AstBundle, D4rtRunner, …)
      ▲
tom_ast_generator      (THIS — analyzer + AstConverter + AstBundler + astgen CLI)
      ▲
tom_d4rt_exec          (execution entry point, CLI wiring)
      ▲
tom_dcli_exec          (dcli-specific CLI layer)
```

`tom_ast_generator` is the only package in the stack that depends on
`analyzer`. Everything below it (`tom_d4rt_ast`, `tom_ast_model`) is
analyzer-free and safe to ship in Flutter applications. Everything above it
(`tom_d4rt_exec`, `tom_dcli_exec`) is the runtime and CLI layer. The JSON /
bytes produced by `AstBundler` cross this boundary: they are produced by
`tom_ast_generator` (with analyzer) and consumed by `tom_d4rt_ast` (without).

All packages live in the same repository:
[github.com/al-the-bear/tom_d4rt](https://github.com/al-the-bear/tom_d4rt).

## Status

**Version 0.1.1** — current release on pub.dev (first published at 0.1.0).

The core conversion and bundling are production-ready. The `include_imports`,
`import_depth`, and `include_relative_imports` fields in the CLI `buildkit.yaml`
configuration are accepted but not yet implemented (they are placeholders for a
future batch-import feature in the CLI path; the `AstBundler` API already
handles recursive import resolution fully).

- Package repository: [github.com/al-the-bear/tom_d4rt/tree/main/tom_ast_generator](https://github.com/al-the-bear/tom_d4rt/tree/main/tom_ast_generator)
- Issue tracker: [github.com/al-the-bear/tom_d4rt/issues](https://github.com/al-the-bear/tom_d4rt/issues)
- SDK requirement: Dart `^3.10.4`
