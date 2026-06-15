# tom_d4rt_exec

The analyzer-free **execution entry point** of the D4rt interpreter family: it parses Dart source with the `analyzer` package, mirrors the resulting AST 1:1 into the serializable [`tom_d4rt_ast`](../tom_d4rt_ast/) tree, and hands that tree to the `tom_d4rt_ast` interpreter — which runs with **no `analyzer` types at runtime**.

## Overview

`tom_d4rt_exec` is the analyzer-free counterpart of [`tom_d4rt`](../tom_d4rt/). It separates the two responsibilities the original package bundled together:

1. **Parsing** — Dart source is parsed by the `analyzer` package and converted 1:1 into the `tom_d4rt_ast` mirror AST via [`tom_ast_generator`](../tom_ast_generator/)'s `AstConverter`.
2. **Execution** — The mirror AST is handed to `tom_d4rt_ast`'s `InterpreterVisitor` and `D4rtRunner`, which interpret it entirely without `analyzer` at runtime.

This split is what makes the analyzer-free family possible: the **runtime** (`tom_d4rt_ast`) carries no `analyzer` dependency, so it can ship to the **web** — where the `analyzer` package is too large — and drive **on-the-fly / OTA UI updates** by interpreting pre-built AST bundles. `tom_d4rt_exec` is the build/CLI side of that workflow: it does the analyzer parse and produces the tree (or an `AstBundle`) that the runtime executes.

### Which interpreter should I use?

[`tom_d4rt`](../tom_d4rt/) is the stable reference and is **usually the preferable choice** for command-line, server, and desktop embeddings. Reach for the analyzer-free line (`tom_d4rt_exec` + `tom_d4rt_ast`) when you actually need the web / OTA case: the runtime has no analyzer dependency, but because the AST bundles it consumes are **large**, it is a complete alternative rather than a default.

| Package | What it is | Analyzer dependency | Use when |
|---|---|---|---|
| [`tom_d4rt`](../tom_d4rt/) | Source-based reference interpreter; parse + interpret in one package | Yes (parse and runtime) | CLI / server / desktop — the usual choice |
| `tom_d4rt_exec` *(this package)* | Analyzer-free execution entry; parse via analyzer, interpret via `tom_d4rt_ast` | Yes, **parse only** — none at runtime | You need the analyzer-free runtime, or to build `AstBundle`s |
| [`tom_d4rt_ast`](../tom_d4rt_ast/) | Pure runtime + serializable AST; runs pre-built bundles | **No** | Web / OTA — ship bundles, interpret on device |

`tom_d4rt_exec` keeps `tom_d4rt`'s public API: bridge packages and scripts move over by changing imports only (see [Ecosystem](#ecosystem)).

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
  tom_d4rt_exec: ^1.8.5
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

## Example projects

`tom_d4rt_exec` shares its execution API and language semantics with [`tom_d4rt`](../tom_d4rt/), so the runnable samples in [`tom_d4rt_samples/`](../tom_d4rt_samples/) apply here too — the only change is the import (`package:tom_d4rt_exec/tom_d4rt.dart`):

- [d4rt_introduction_sample](../tom_d4rt_samples/d4rt_introduction_sample/) — run multi-file D4rt programs with nothing but the interpreter. Start here.
- [d4rt_advanced_sample](../tom_d4rt_samples/d4rt_advanced_sample/) — bridge a native Dart library using [`tom_d4rt_generator`](../tom_d4rt_generator/).

For the web / OTA bundle workflow that is unique to the analyzer-free line, see [Bundle Execution](#bundle-execution) below and [`tom_d4rt_ast`](../tom_d4rt_ast/).

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

For environments where the parse step must be eliminated at runtime (web, Flutter hot-reload / OTA, tight startup), use `AstBundler` (re-exported from [`tom_ast_generator`](../tom_ast_generator/)) to pre-bundle scripts, then execute the bundle. This is the workflow a server uses to compile source once and ship the bundle to a thin [`tom_d4rt_ast`](../tom_d4rt_ast/) client:

```dart
final bundler = AstBundler(config: AstBundlerConfig(...));
final bundle = await bundler.bundle('path/to/entry.dart');

final d4rt = D4rt();
// ... register bridges ...
d4rt.executeBundle(bundle);
```

#### Typed bundle execution

`executeBundleAs<T>` / `executeBundleAsAsync<T>` run a bundle and **unwrap the result to a native `T`** instead of returning a `BridgedInstance`, using the same unwrap path as the runner (`D4.unwrapAs<T>`). Use the async variant for `async` entry points that return a `Future`:

```dart
final widget = d4rt.executeBundleAs<Widget>(bundle, name: 'build');
final value  = await d4rt.executeBundleAsAsync<int>(bundle, name: 'computeAsync');
```

#### Extension hook for bridge packages

Bridge packages register relaxers and proxy factories through a programmatic hook rather than comment-driven ordering. `registerExtensions(packageName, body)` queues a callback; `finalizeBridges()` runs every queued callback once, in registration order, after the standard bridges are wired up — it is called implicitly on the first `execute` / `executeBundle`:

```dart
d4rt.registerExtensions('my_pkg', () => registerMyOverrides());
d4rt.finalizeBridges(); // optional — runs implicitly on first execute
```

See the [extension-registration guide](../tom_d4rt_ast/doc/extension_registration.md) in `tom_d4rt_ast` for the full contract.

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

[`tom_d4rt`](../tom_d4rt/) is the source-based reference that bundles the analyzer, AST, and runtime together — and remains the usual choice for CLI / server / desktop (see [Which interpreter should I use?](#which-interpreter-should-i-use)). `tom_d4rt_exec` is the entry point for the analyzer-free line you adopt when the web / OTA constraint applies. Bridge packages and scripts written against `tom_d4rt` move over by changing their import from `package:tom_d4rt/tom_d4rt.dart` to `package:tom_d4rt_exec/tom_d4rt.dart` — the compatibility alias keeps the public API identical.

## Further documentation

`tom_d4rt_exec` is the analyzer-using entry point; its docs are exec-specific and link to `tom_d4rt` for the (identical) language semantics and bridging model.

This package's own guides (in [`doc/`](doc/)):

- [User Guide](doc/tom_d4rt_exec_user_guide.md) — exec-specific: the parse → mirror-AST → interpret pipeline, source execution, and the bundle / typed-execute API. Links to the base guide for shared semantics.
- [Limitations (delta)](doc/tom_d4rt_exec_limitations.md) — entry-point-specific limits (not web-safe; analyzer-boundary parse errors; bundle/runtime version alignment); links back to the canon.
- [Bridging Guide](doc/BRIDGING_GUIDE.md) — how to bridge native Dart classes and functions manually.
- [Advanced Bridging Guide](doc/advanced_bridging_user_guide.md) — `D4` helper class, type coercion, argument extraction, target validation, and global function bridging.
- [Issues](doc/issues.md) — tracked exec-specific issues and their status.

Related packages (don't duplicate — follow the link):

- [tom_d4rt_ast](../tom_d4rt_ast/) — the analyzer-free runtime this package executes against ([extension registration](../tom_d4rt_ast/doc/extension_registration.md))
- [tom_ast_generator](../tom_ast_generator/) — the `AstConverter` (analyzer AST → mirror AST) and `AstBundler` this package re-exports
- [tom_d4rt](../tom_d4rt/) — the source-based reference; base docs: [User Guide](../tom_d4rt/doc/d4rt_user_guide.md) · [Limitations (canonical)](../tom_d4rt/doc/d4rt_limitations.md)
- [tom_d4rt_generator](../tom_d4rt_generator/) — automated bridge generation ([user guide](../tom_d4rt_generator/doc/bridgegenerator_user_guide.md) · [reference](../tom_d4rt_generator/doc/bridgegenerator_user_reference.md))
- [tom_dcli_exec](../tom_dcli_exec/) — DCli REPL built on this entry point

## Status

**Version 1.8.5** — current release on pub.dev (first published at 1.8.2).

- 1680+ tests passing (2 intentional won't-fix exclusions).
- All 20 Dart language areas covered in the `dart_overview` test suite.
- Supported platforms: Android, iOS, Linux, macOS, Web, Windows.

Repository: [https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_exec](https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_exec)
