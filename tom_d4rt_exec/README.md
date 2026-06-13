# tom_d4rt_exec

Analyzer-free D4rt interpreter — the CLI and embedding entry point that parses Dart source via the `analyzer` package, mirrors the resulting AST into the `tom_d4rt_ast` serializable tree, and hands it to the `tom_d4rt_ast` interpreter for execution.

## Overview

`tom_d4rt_exec` is the **migration target** for the D4rt interpreter ecosystem, replacing `tom_d4rt` for all Flutter and server use-cases. It separates the two responsibilities that were bundled together in the original package:

1. **Parsing** — Dart source is parsed by the `analyzer` package and converted 1:1 into the `tom_d4rt_ast` mirror AST via `tom_ast_generator`'s `AstConverter`.
2. **Execution** — The mirror AST is handed to `tom_d4rt_ast`'s `InterpreterVisitor` and `D4rtRunner`, which perform the actual interpretation entirely without `analyzer` at runtime.

This split means downstream packages (`tom_dcli_exec`, Flutter apps, servers) can embed the interpreter, run scripts, and hot-reload interpreted code **without taking a compile-time or tree-shake dependency on `analyzer`** — the analyzer step happens only here, at the execution entry point.

### Execution modes

| Mode | API | Use-case |
|---|---|---|
| Fresh-context execution | `D4rt.execute()` | Runs a script from scratch; resets global environment |
| Continued execution | `D4rt.continuedExecute()` | Adds declarations to an existing context without reset |
| REPL-style evaluation | `D4rt.eval()` | Evaluates a single expression in the current context |
| File-based execution | `executeFile()` / `executeFileContinued()` | Loads a `.d4rt.dart` or `.dart` script from disk with automatic import resolution |
| Source-from-string (with base path) | `executeSource()` | Runs source code with relative-import resolution against a base directory |
| Bundle execution | `D4rt.executeBundle()` | Runs a pre-bundled `AstBundle` produced by `AstBundler`; no parse step at runtime |

## Installation

```yaml
dependencies:
  tom_d4rt_exec: ^1.8.3
```

```sh
dart pub add tom_d4rt_exec
```

## Features

- **Full Dart 3 syntax support** — classes, generics, patterns, extension types, sealed classes, records, async/await, async*/sync* generators, streams, mixins, enums with members, and more.
- **Sandboxed execution** — scripts run in an isolated environment; sensitive operations (`dart:io`, `dart:isolate`) require explicit permission grants via `d4rt.grant(...)`.
- **Bridging system** — expose native Dart classes, enums, extension methods, top-level functions, global variables, and global getters/setters to interpreted code.
- **Bridge deduplication** — `sourceUri` tracking prevents duplicate bridge registration when the same type is re-exported through multiple barrel files.
- **Module system** — full import/export with `show`, `hide`, and `as prefix` combinators; circular-import detection via module cache.
- **Class aliases and function typedefs** — `registerClassAlias()` and `registerFunctionTypedef()` allow typedef names used in scripts to resolve to their target types.
- **Library re-exports** — `registerLibraryReExport()` mirrors Dart's `export` directive for native bridge packages.
- **Bridge validation** — `D4rt.validateRegistrations()` collects all registration errors in one pass without aborting on the first conflict.
- **Configuration introspection** — `getConfiguration()` returns a `D4rtConfiguration` snapshot of all registered bridges, permissions, and globals.
- **Environment introspection** — `getEnvironmentState()` returns the live global environment after execution.
- **Debug logging** — `setDebug(true)` enables detailed trace output for all interpreter passes.
- **Versioned build info** — `TomVersionInfo` carries version, git commit, and build timestamp.
- **Multi-platform** — declared for Android, iOS, Linux, macOS, Web, and Windows.

## Quick Start

```dart
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  // Execute a script with a main function
  d4rt.execute(
    source: '''
      void main() {
        print("Hello from D4rt!");
      }
    ''',
  );
}
```

## Usage

### Basic Execution

`execute()` parses the source, resets the interpreter environment, and calls the named function (default: `main`):

```dart
final d4rt = D4rt();

// Call main() by default
d4rt.execute(source: '''
  void main() {
    print("Hello!");
  }
''');

// Call a custom function with positional arguments
final result = d4rt.execute(
  source: '''
    String greet(String name, int age) {
      return "Hello \$name, you are \$age";
    }
  ''',
  name: 'greet',
  positionalArgs: ['Alice', 30],
);
print(result); // "Hello Alice, you are 30"

// Named arguments
d4rt.execute(
  source: 'String greet({required String name, int age = 0}) => "\$name (\$age)";',
  name: 'greet',
  namedArgs: {'name': 'Bob', 'age': 25},
);
```

### REPL-Style Evaluation

After an initial `execute()` call establishes context, use `eval()` to evaluate expressions incrementally in the same environment:

```dart
final d4rt = D4rt();

// Establish context
d4rt.execute(source: '''
  var counter = 0;
  void increment() { counter++; }
''');

// Evaluate expressions in the established context
d4rt.eval('increment()');
d4rt.eval('increment()');
print(d4rt.eval('counter')); // 2
```

### Continued Execution

`continuedExecute()` adds new declarations and executes them without resetting the global environment:

```dart
final d4rt = D4rt();

d4rt.execute(source: 'void main() {}');

d4rt.continuedExecute(source: '''
  int square(int x) => x * x;
  void main() {}
''');

print(d4rt.eval('square(5)')); // 25
```

### File-Based Script Execution

`executeFile()` reads a `.dart` or `.d4rt.dart` script from disk and automatically resolves all relative imports before executing:

```dart
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();

  final result = executeFile(
    d4rt,
    '/path/to/scripts/main.d4rt.dart',
    log: print,
  );

  if (result.success) {
    print('Result: ${result.result}');
    print('Sources loaded: ${result.sourcesLoaded}');
  } else {
    print('Error: ${result.error}');
    print(result.stackTrace);
  }
}
```

Use `executeFileContinued()` to evaluate a script's files into an existing context via `eval()` rather than replacing it, and `executeSource()` to run source code from a string with a base path for import resolution.

### Exposing Native Code (Bridging)

Register native classes, enums, and functions before execution to make them available in scripts:

```dart
// Register a bridged class
d4rt.registerBridgedClass(myClassBridge, 'package:my_app/types.dart');

// Register a bridged enum
d4rt.registerBridgedEnum(myEnumDefinition, 'package:my_app/types.dart');

// Register a top-level function
d4rt.registertopLevelFunction(
  'myFunc',
  (args, namedArgs) => doSomething(args),
  'package:my_app/types.dart',
);

// Register a global variable
d4rt.registerGlobalVariable('appName', 'MyApp', 'package:my_app/types.dart');

// Register a global getter (evaluated lazily on each access)
d4rt.registerGlobalGetter(
  'currentTime',
  () => DateTime.now().millisecondsSinceEpoch,
  'package:my_app/types.dart',
);

// Register a global getter + setter pair
d4rt.registerGlobalGetter('counter', () => _counter, 'package:my_app/types.dart');
d4rt.registerGlobalSetter('counter', (v) => _counter = v as int, 'package:my_app/types.dart');

// Scripts import and use them normally
d4rt.execute(source: '''
  import 'package:my_app/types.dart';

  void main() {
    final obj = MyClass();
    obj.doSomething();
    print(currentTime);
  }
''');
```

Use `tom_d4rt_generator` to generate bridge code automatically from your existing Dart classes. See the [Bridge Generator User Guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md).

For manual bridging patterns, see the [Bridging Guide](doc/BRIDGING_GUIDE.md) and the [Advanced Bridging Guide](doc/advanced_bridging_user_guide.md).

### Security and Permissions

D4rt is sandboxed by default. Access to `dart:io` and `dart:isolate` is blocked unless explicitly permitted:

```dart
final d4rt = D4rt();

// Grant filesystem access
d4rt.grant(FilesystemPermission.any);

// Grant isolate operations
d4rt.grant(IsolatePermission.any);

// Revoke a previously granted permission
d4rt.revoke(FilesystemPermission.any);

// Check permission state
print(d4rt.hasPermission(FilesystemPermission.any));
```

### Bridge Validation

Catch registration conflicts across all bridge packages in one pass:

```dart
final d4rt = D4rt();
// ... register all bridges ...

final errors = d4rt.validateRegistrations(
  source: """
    import 'package:my_pkg/my_pkg.dart';
    import 'package:other_pkg/other_pkg.dart';
    void main() {}
  """,
);

if (errors.isNotEmpty) {
  for (final e in errors) print('  - $e');
}
```

### Bundle Execution

For environments where the parse step must be eliminated at runtime (Flutter hot-reload, tight startup), use `AstBundler` (re-exported from `tom_ast_generator`) to pre-bundle scripts, then execute the bundle:

```dart
final bundler = AstBundler(config: AstBundlerConfig(...));
final bundle = await bundler.bundle('path/to/entry.dart');

final d4rt = D4rt();
// ... register bridges ...
d4rt.executeBundle(bundle);
```

## Architecture and Key Concepts

### Parse-Mirror-Interpret Pipeline

```
Dart source
    |
    v  (analyzer package — compile-time dependency of tom_d4rt_exec only)
analyzer AST
    |
    v  (tom_ast_generator: AstConverter — 1:1 structural copy)
SCompilationUnit (mirror AST — serializable, no analyzer types)
    |
    v  (tom_d4rt_ast: InterpreterVisitor / D4rtRunner)
Execution result
```

The `AstConverter` in `tom_ast_generator` performs a 1:1 structural mapping of every `analyzer` node to its corresponding `S*` node in `tom_d4rt_ast` (e.g., `ClassDeclaration` → `SClassDeclaration`). The interpreter in `tom_d4rt_ast` never sees `analyzer` types at all.

### D4rt Class

`D4rt` (exported from `lib/d4rt.dart` and `lib/tom_d4rt.dart`) is the primary entry point. Internally it holds:

- `AstConverter` — parses source via `analyzer` and converts to mirror AST.
- `D4rtRunner` — the `tom_d4rt_ast` bundle-execution path; all bridge registrations and permissions are forwarded to it.
- `ModuleLoader` — resolves imports, loads stdlib modules, and registers bridges per-import with deduplication.
- `_moduleLoader.globalEnvironment` — the live interpreter environment, accessible after execution via `getEnvironmentState()`.

### Two-Pass Execution

Each `execute()` call runs two passes over the `SCompilationUnit`:

1. **Declaration pass** (`DeclarationVisitor`) — registers class, function, and variable names in the environment without evaluating initializers.
2. **Interpretation pass** (`InterpreterVisitor`) — processes import directives (triggering bridge registration), evaluates top-level initializers, and then calls the named entry function.

### ModuleLoader

`ModuleLoader` (in `lib/src/module_loader.dart`) implements `ModuleContext` from `tom_d4rt_ast`. It:

- Resolves and caches loaded modules by URI.
- Registers bridges lazily when their import is processed (with `show`/`hide` filter support).
- Handles stdlib modules (`dart:core`, `dart:math`, `dart:convert`, `dart:io`, `dart:collection`, `dart:typed_data`, `dart:isolate`) via the `Stdlib` registry.
- Auto-loads stdlib modules when resolving extension on-types that target stdlib types.
- Accumulates registration errors in validation mode instead of throwing on the first one.

### Import Path: `d4rt.dart` vs `tom_d4rt.dart`

| Import | Purpose |
|---|---|
| `package:tom_d4rt_exec/d4rt.dart` | Full public API |
| `package:tom_d4rt_exec/tom_d4rt.dart` | Compatibility re-export — bridge files generated for `tom_d4rt` import `tom_d4rt/tom_d4rt.dart`; this alias lets the same files work with `tom_d4rt_exec` after a package rename |
| `package:tom_d4rt_exec/tom_d4rt_exec.dart` | Convenience re-export of `d4rt.dart` |

### ScriptExecutionResult

The file- and source-based helpers in `lib/src/script_execution.dart` return `ScriptExecutionResult` with:

- `success` — whether execution completed without error.
- `result` — the return value of the called function.
- `error` / `stackTrace` — populated on failure.
- `sourcesLoaded` — number of source files resolved (main + all transitively imported files).

## Ecosystem

`tom_d4rt_exec` sits in the middle of the D4rt interpreter stack:

```
tom_ast_model
    ^
    |  (defines serializable S* AST node types)
tom_d4rt_ast
    ^
    |  (interpreter runtime, D4rtRunner, InterpreterVisitor, stdlib, bridging API)
tom_ast_generator
    ^
    |  (AstConverter: analyzer AST -> mirror AST; AstBundler)
tom_d4rt_exec          <-- THIS PACKAGE
    ^
    |  (CLI runner, DCli scripting integration)
tom_dcli_exec
```

`tom_d4rt` is the original monolithic interpreter that bundles the analyzer, AST, and runtime together. `tom_d4rt_exec` replaces it for all new integrations. Bridge packages generated against `tom_d4rt` can be migrated by changing their import from `package:tom_d4rt/tom_d4rt.dart` to `package:tom_d4rt_exec/tom_d4rt.dart` — the compatibility alias keeps the public API identical.

## Documentation

- [User Guide](doc/d4rt_user_guide.md) — complete usage documentation, execution modes, and configuration.
- [Bridging Guide](doc/BRIDGING_GUIDE.md) — how to bridge native Dart classes and functions manually.
- [Advanced Bridging Guide](doc/advanced_bridging_user_guide.md) — `D4` helper class, type coercion, argument extraction, target validation, and global function bridging.
- [Known Limitations](doc/d4rt_limitations.md) — documented won't-fix limitations (isolate serialization, large-tuple records).
- [Bridge Generator User Guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md) — automating bridge creation with code generation.
- [Bridge Generator Reference](../tom_d4rt_generator/doc/bridgegenerator_user_reference.md) — generator configuration options.

## Status

**Version 1.8.3** — current release on pub.dev (first published at 1.8.2).

- 1680+ tests passing (2 intentional won't-fix exclusions).
- All 20 Dart language areas covered in the `dart_overview` test suite.
- Supported platforms: Android, iOS, Linux, macOS, Web, Windows.

Repository: [https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_exec](https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_exec)
