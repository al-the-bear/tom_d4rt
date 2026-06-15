# tom_d4rt_ast

Analyzer-free Dart interpreter runtime that executes pre-compiled `SAstNode` bundles with full bridging, sandboxing, and standard library support.

## Overview

`tom_d4rt_ast` is the pure-runtime half of the D4rt interpreter ecosystem. It accepts pre-parsed `SAstNode` trees (the serializable mirror AST defined in `tom_ast_model`) and executes them directly — no `analyzer` package required.

### Why no analyzer?

The Dart `analyzer` package is large and incompatible with Flutter's tree-shaker constraints. Shipping it inside a mobile app is not practical. `tom_d4rt_ast` breaks that dependency: the analyzer is used only at build time (in `tom_ast_generator`) to convert Dart source into a compact JSON representation. The resulting `.ast` bundle can be distributed separately — downloaded at runtime, stored in assets, or fetched from a server — and interpreted on-device by this package.

### The Flutter use case

A Flutter app embeds `tom_d4rt_ast` (no analyzer weight). Server-side tooling uses `tom_ast_generator` to convert Dart scripts to `.ast` bundles once. The app downloads or bundles those `.ast` files, loads them with `AstBundle.fromFile` / `AstBundle.fromBytes`, and calls `D4rtRunner.executeBundleAs<T>`. The script runs on the device, producing a typed result. New script logic can be deployed without submitting an app update to the store.

### Relationship to `tom_d4rt`

`tom_d4rt` is the original analyzer-based interpreter that parses and executes Dart source directly. `tom_d4rt_ast` contains the same `InterpreterVisitor`, `Environment`, bridging infrastructure, and standard library — they are kept in strict 1:1 sync. The difference is the AST source: `tom_d4rt` builds its AST from the analyzer's `CompilationUnit`; `tom_d4rt_ast` reads `SAstNode` trees from `tom_ast_model`. Any interpreter fix applied to one package must be applied to the other. The `D4` helper class (static bridge utilities) exists in both packages with an identical API surface (`lib/src/runtime/generator/d4.dart` in this package, `lib/src/generator/d4.dart` in `tom_d4rt`).

### Which line to use — source-based vs analyzer-free

D4rt ships in **two execution families**:

- **Source-based (analyzer)** — `tom_d4rt`, `tom_d4rt_dcli`,
  `tom_d4rt_flutter`. Parses Dart source with the `analyzer` package and
  interprets it directly. This is the **stable reference** and is **usually the
  preferable choice**.
- **Analyzer-free (mirror AST)** — **this package**, plus `tom_ast_model`,
  `tom_ast_generator`, `tom_d4rt_exec`, `tom_dcli_exec`, and
  `tom_d4rt_flutter_ast`. Runs from pre-compiled `SAstNode` trees with **no
  analyzer dependency**, which is what makes it viable on the **web** (the
  analyzer package is too large to ship) and for **on-the-fly / OTA UI
  updates**.

`tom_d4rt_ast` is a **complete alternative** to the source-based interpreter,
but because the **generated AST bundles are large**, reach for it only when the
**web/OTA constraint applies**. For server-side or CLI scripting where the
analyzer is acceptable, prefer `tom_d4rt` (or its drop-in entry point
`tom_d4rt_exec`). See [`tom_d4rt_exec`](../tom_d4rt_exec/) for the
analyzer-free execution entry that parses source at build time and feeds this
runtime.

## Installation

```sh
dart pub add tom_d4rt_ast
```

`pubspec.yaml`:

```yaml
dependencies:
  tom_d4rt_ast: ^0.1.7
```

The package requires Dart SDK `^3.10.4`. Its only runtime dependencies are `archive` (ZIP/gzip bundle I/O) and `tom_ast_model` (zero-dependency `SAstNode` definitions).

## Features

- **`InterpreterVisitor`** — two-pass AST walker (declaration pass + interpretation pass) that evaluates all Dart statement and expression node kinds defined in `tom_ast_model`, including async/await, generators, pattern matching, extension types, and records.
- **`Environment`** — lexical scoping with a linked-chain model. Each function call, block, or class body gets its own `Environment` whose `enclosing` reference chains back to the global scope. Supports `define`, `get`, `assign`, `defineBridge`, `defineBridgedEnum`, and lazy `GlobalGetter` / `GlobalSetter` entries.
- **`BridgedClass` / `BridgedInstance`** — native Dart classes are exposed to interpreted code via adapter maps for constructors, instance methods, static methods, getters, and setters. `BridgedInstance<T>` wraps the native object alongside its `BridgedClass` descriptor. A static supertype registry (`BridgedClass.registerSupertypes`) enables hierarchy-aware `isSubtypeOf` checks without `dart:mirrors`.
- **`BridgedEnum` / `BridgedEnumValue`** — native enums with per-value instance getter and method adapters, plus static getter support (e.g. `WidgetState.any`).
- **Permission sandbox** — five concrete `Permission` subclasses guard filesystem, network, process, isolate, and dangerous operations. `D4rtRunner.grant` / `revoke` / `checkPermission` control what interpreted code may do at runtime.
- **Callable system** — `Callable` (abstract), `InterpretedFunction`, `InterpretedClass`, `NativeFunction`, and several bridged adapter callables form a uniform call protocol used throughout the interpreter.
- **Runtime types** — `RuntimeType` / `RuntimeValue` interfaces, `InterpretedClass`, `InterpretedInstance`, `InterpretedRecord`, `TypeParameter`, and the type-coercion helpers on the `D4` class.
- **`AstBundle`** — a transportable ZIP archive containing one or more `SCompilationUnit` modules with a `manifest.json`. Supports JSON, gzip-compressed JSON, and ZIP serialization. Auto-detects format on load.
- **`AstModuleLoader`** — resolves `import` directives against the bundle's pre-loaded module map with zero file I/O. Handles `dart:*` stdlib registration, bridged-library wiring, re-export chains, and per-module scoped environments.
- **Standard library bridges** — `dart:core` (String, int, double, num, bool, List, Map, Set, Iterable, DateTime, Duration, RegExp, Uri, BigInt, …), `dart:async` (Future, Stream, StreamController, Completer, Timer), `dart:typed_data` (ByteData, Uint8List, Float32List, Int32List, and all typed array variants), `dart:convert` (JSON, UTF-8, Base64, Latin-1, ASCII, …), `dart:collection` (HashMap, HashSet, LinkedHashMap, SplayTreeMap, Queue, …), `dart:math` (Random, Point, Rectangle, constants), `dart:io` (File, Directory, Process, Platform, stdout/stderr, HttpClient, Socket), and `dart:isolate` stubs. Platform-conditional entry point selects `stdlib_io.dart` on VM / `stdlib_web.dart` on web.
- **`D4` helper class** — static utilities consumed by generated bridge code: `unwrapAs<T>`, `unwrapInterpreterValue`, `extractBridgedArg<T>`, `coerceList<T>`, `getRequiredArg`, `getRequiredNamedArg`, `validateTarget<T>`, `withActiveVisitor`, generic-type wrapper registration, and the native-to-interpreted `Expando` map.
- **`registerExtensions` / `finalizeBridges`** — ordered extension hook for bridge packages that have post-registration wiring dependencies.
- **Introspection** — `DeclarationInfo` sealed class hierarchy (`FunctionInfo`, `ClassInfo`, `VariableInfo`, `EnumInfo`, `ExtensionInfo`) for inspecting what a script declares.

## How a bundle gets here

In normal use you do **not** build `SAstNode` trees by hand. The AST arrives
as a pre-compiled bundle produced by build-time tooling, and `tom_d4rt_ast`
only runs it:

```
Dart source (.dart)
      │
      ▼  analyzer (build time, off-device)
analyzer CompilationUnit
      │
      ▼  tom_ast_generator  (1:1 copy → mirror AST)
SAstNode tree
      │
      ▼  AstBundle  (JSON / gzip / ZIP, ships to the device)
.ast bundle
      │
      ▼  tom_d4rt_ast  (THIS package — on-device, no analyzer)
typed result / widget tree
```

The conversion (analyzer → mirror AST → bundle) is owned by
[`tom_ast_generator`](../tom_ast_generator/) and driven end-to-end by
[`tom_d4rt_exec`](../tom_d4rt_exec/). This package is the **last stage only**:
load a bundle, execute it, get a typed result back. The hand-built-AST example
further down exists for completeness and tests — it is not the normal path.

## Quick Start

### Run a pre-compiled bundle (the normal path)

```dart
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  final bundle = AstBundle.fromFile('path/to/script.ast');

  final runner = D4rtRunner();
  runner.grant(FilesystemPermission.read); // grant only what the script needs

  final result = runner.executeBundleAs<String>(bundle, name: 'buildLabel');
  print(result);
}
```

### Load from bytes (e.g. downloaded over HTTP in Flutter)

```dart
import 'package:tom_d4rt_ast/runtime.dart';

Future<void> runScript(List<int> bytes) async {
  final bundle = AstBundle.fromZip(bytes);   // or fromBytes() for gzip JSON
  final runner = D4rtRunner();
  final result = await runner.executeBundleAsAsync<Map<String, dynamic>>(bundle);
  print(result);
}
```

### Parse a JSON AST string

```dart
final runner = D4rtRunner();
final ast = runner.parseJson(jsonString); // returns SCompilationUnit
final result = runner.execute(ast: ast, name: 'compute');
```

### Advanced: build a bundle by hand

This is **not** the normal path (see [How a bundle gets here](#how-a-bundle-gets-here)) — bundles are produced by `tom_ast_generator`. It is shown only so the `SAstNode` shape is concrete, e.g. for tests that synthesise tiny programs:

```dart
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  final mainFn = SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: SFormalParameterList(offset: 0, length: 0),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(
          offset: 0,
          length: 0,
          statements: [
            SReturnStatement(
              offset: 0,
              length: 0,
              expression: SIntegerLiteral(offset: 0, length: 2, value: 42),
            ),
          ],
        ),
      ),
    ),
  );

  final unit = SCompilationUnit(
    offset: 0, length: 0,
    declarations: [mainFn],
  );

  final bundle = AstBundle(
    entryPointUri: 'package:demo/main.dart',
    modules: {'package:demo/main.dart': unit},
  );

  final result = D4rtRunner().executeBundleAs<int>(bundle);
  print(result); // 42
}
```

### Registering a native class bridge

```dart
import 'package:tom_d4rt_ast/runtime.dart';

final colorBridge = BridgedClass(
  nativeType: Color,
  name: 'Color',
  constructors: {
    '': (visitor, positional, named) {
      final value = positional[0] as int;
      return Color(value);
    },
  },
  getters: {
    'red':   (visitor, target) => (target as Color).red,
    'green': (visitor, target) => (target as Color).green,
    'blue':  (visitor, target) => (target as Color).blue,
  },
);

final runner = D4rtRunner();
runner.registerBridgedClass(colorBridge, 'dart:ui');
```

### Using `registerExtensions` and `finalizeBridges`

Some bridge packages have wiring that must run after another package's registrations complete. Use `registerExtensions` to declare those callbacks; the runner fires them in registration order before the first script execution.

```dart
final runner = D4rtRunner();

// Register primary bridges inline.
runner.registerBridgedClass(widgetBridge,   'package:flutter/widgets.dart');
runner.registerBridgedClass(materialBridge, 'package:flutter/material.dart');

// Queue post-material wiring; it runs before the first executeBundle* call.
runner.registerExtensions('my_flutter_package', () {
  registerInterfaceProxyOverrides(runner);
});

// Optional: finalize early for deterministic timing.
runner.finalizeBridges();

final result = runner.executeBundleAs<Widget>(bundle);
```

`finalizeBridges` is idempotent — subsequent calls are no-ops. Calling `registerExtensions` after `finalizeBridges` throws `StateError`.

### Warming up: `warmup()` (cold-start flakiness, OPEN B.11 / U25)

The first script run after a test harness' `setUpAll` used to flake under host load because the interpreter infrastructure — extension finalization, the stdlib bridges, and the registered bridged-class/enum definitions — cold-started *during* that first build. `warmup()` pays that cost up front so the first real build behaves like a warm one:

```dart
final runner = D4rtRunner();
// ... register all bridges / extensions ...
runner.warmup();              // finalizeBridges() + build a throwaway environment
final result = runner.executeBundleAs<Widget>(bundle); // first build, no cold start
```

`warmup()` runs `finalizeBridges()` and then builds (and discards) a global environment, exercising the full `Stdlib(...).register()` + bridged-definition registration path. It is idempotent and script-neutral — the warmup environment leaves no script declarations behind, and the next `execute*`/`executeBundle*` call rebuilds a fresh environment as usual.

`D4rtRunner` has no Dart source parser (that lives in `tom_d4rt_exec`'s `D4rt`, whose `warmup()` additionally warms the analyzer front-end by parsing + executing a trivial throwaway script), so the runner warms only the bridge/stdlib half — the portion the parser-less Flutter runtime and a test app's `/warmup` endpoint share. The analyzer-based VM twin `tom_d4rt`'s `D4rt.warmup()` mirrors the same contract.

## Example projects

The interpreter executes the same Dart language as the source-based line, so
the language/bridging samples apply directly — the only difference is that the
analyzer-free runtime consumes a pre-compiled `AstBundle` rather than source
text. Runnable samples live in
[`tom_d4rt_samples/`](../tom_d4rt_samples/):

| Sample | What it shows |
| --- | --- |
| [`d4rt_introduction_sample`](../tom_d4rt_samples/d4rt_introduction_sample/) | Basic interpreter use and language semantics. |
| [`d4rt_advanced_sample`](../tom_d4rt_samples/d4rt_advanced_sample/) | Advanced language and bridging features. |
| [`d4rt_flutter_sample`](../tom_d4rt_samples/d4rt_flutter_sample/) | Flutter Material bridges — the canonical web/OTA target for this runtime. |
| [`d4rt_userbridges_sample`](../tom_d4rt_samples/d4rt_userbridges_sample/) | Hand-written `D4UserBridge` overrides. |

For the **end-to-end AstBundle → widget tree** path on Flutter (the web/OTA use
case this package exists for), see
[`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast/) and its demo app
[`tom_d4rt_flutter_ast_test`](../tom_d4rt_flutter_ast_test/).

## Architecture and Key Concepts

### SAstNode-driven execution

`tom_ast_model` defines the `SAstNode` hierarchy — a fully serializable mirror of the Dart AST. Every node is JSON-serializable with no reference to the `analyzer` package. `InterpreterVisitor` extends `GeneralizingSAstVisitor<Object?>` and implements `visit*` methods for each node kind. The `DeclarationVisitor` performs a first pass that registers class and function declarations into the environment before any statements execute.

### The 1:1-with-analyzer principle

When a bug is found in the interpreter logic (type coercion, enum handling, `isSubtypeOf` chain walk, etc.), the fix goes into `tom_ast_model` or into both `tom_d4rt` and `tom_d4rt_ast` simultaneously. The rule is: **fix the AST model or the shared interpreter logic, not a one-off workaround in one package**. The `_copilot_guidelines/sync_with_tom_d4rt.md` document in this package enforces this contract.

### Bridging: native-to-interpreted interop

Interpreted code can call native Dart constructors and methods through registered `BridgedClass` / `BridgedEnum` entries. When a bridged constructor is called, the adapter function returns a native instance wrapped in `BridgedInstance<T>`. `InterpreterVisitor` recognizes `BridgedInstance` at getter / method call sites and dispatches through the registered `BridgedMethodAdapter` / `BridgedInstanceGetterAdapter`. For interpreted subclasses of bridged types, an `InterfaceProxyFactory` (registered via `D4.registerInterfaceProxy`) creates a native proxy that delegates method calls back through `InterpreterVisitor`.

### Environment and lexical scoping

Each `Environment` holds a `Map<String, Object?>` for named values and a `Map<String, BridgedClass>` for type-resolution. The `enclosing` reference chains scopes: local → function closure → class → global. `define` writes to the current scope; `assign` walks the chain to find the binding owner; `get` walks up until it finds a value or throws `RuntimeD4rtException`.

### AstBundle format

A `.ast` file is a ZIP archive containing a plain-JSON `manifest.json` (format version, entry point URI, file-to-URI mapping) and one gzip-compressed JSON entry per module (`0.ast.json`, `1.ast.json`, …). Optional Dart source files (`0.src.dart`) can be co-bundled for debugging. `AstBundle.fromFile` auto-detects format from magic bytes (ZIP `PK\x03\x04`, gzip `\x1F\x8B`, or plain JSON fallback).

### Permission sandbox

Every operation in the stdlib that touches the filesystem, network, process execution, or isolate spawning calls `ModuleContext.checkPermission` before proceeding. Permissions are scoped: `FilesystemPermission.readPath('/data')` grants read access under that prefix; `NetworkPermission.connectTo('api.example.com')` grants outbound connections to that host only. `DangerousPermission.codeEvaluation` guards eval-like functionality. All permissions default to denied.

### `D4.unwrapAs<T>` and the return boundary

At the script-to-host boundary, `D4rtRunner._bridgeInterpreterValueToNative` recursively converts the raw interpreter result: `BridgedInstance` and `BridgedEnumValue` leaf nodes are unwrapped to their native objects; `List` and `Map` elements are recursed; `InterpretedRecord` with up to 16 positional fields is converted to a native Dart record. `executeBundleAs<T>` then applies `D4.unwrapAs<T>` for the final typed cast, throwing `D4UnwrapException` (with `expectedType` and `actualType` fields) on mismatch.

## Ecosystem Position

```
tom_ast_model          (zero-dependency, serializable SAstNode hierarchy)
    ^
    |  depends on
    |
tom_d4rt_ast           (THIS — analyzer-free interpreter runtime)
    ^
    |  depends on
    |
tom_ast_generator      (analyzer-based Dart source → SAstNode converter)
    ^
    |  depends on
    |
tom_d4rt_exec          (full D4rt execution entry point, 100% API-compatible with tom_d4rt)
    ^
    |  depends on
    |
tom_dcli_exec          (DCli CLI tool, uses tom_d4rt_exec for script execution)

tom_d4rt               (original analyzer-based interpreter; kept in sync with tom_d4rt_ast)
```

The `tom_d4rt_ast` package is the only component that a Flutter app needs to embed. Build tooling (`tom_ast_generator`, `tom_d4rt_exec`, `tom_d4rt`) runs on the developer machine or CI server and is never shipped to end users.

## Further documentation

`tom_d4rt_ast` runs the same interpreter as the analyzer-based base, so its docs are **differences-only** (policy P1) and link to `tom_d4rt` for shared semantics.

- [User Guide](doc/tom_d4rt_ast_user_guide.md) — what differs in the analyzer-free runtime: `AstBundle` loading, `D4rtRunner`, the typed-execute API, and the Flutter/web deployment model.
- [Limitations (delta)](doc/tom_d4rt_ast_limitations.md) — runtime-specific limits (no on-device parser, web `dart:io` absence, bundle-scoped imports); links back to the canon.
- [Extension Registration](doc/extension_registration.md) — `registerExtensions` / `finalizeBridges` ordering contract.
- [Relaxer Usage Logging](doc/usage_logging.md) — opt-in `D4` usage instrumentation.
- [Runtime Registration Surface](doc/runtime_registration_surface.md) — the canonical `D4.register*` reference (shared with the VM twin).
- Base (shared) docs: [tom_d4rt User Guide](../tom_d4rt/doc/d4rt_user_guide.md) · [Bridging Guide](../tom_d4rt/doc/BRIDGING_GUIDE.md) · [Limitations (canonical)](../tom_d4rt/doc/d4rt_limitations.md).

### Related packages

- [`tom_ast_model`](../tom_ast_model/) — the zero-dependency `SAstNode` data model this runtime executes. Defines every node kind, JSON round-tripping, and structural equality; this package adds the interpreter on top.
- [`tom_ast_generator`](../tom_ast_generator/) — the analyzer-based copier that turns Dart source into `SAstNode` bundles. Owns the build-time half of the pipeline.
- [`tom_d4rt_exec`](../tom_d4rt_exec/) — the full execution entry point (analyzer at parse time, this runtime for interpretation); the drop-in counterpart of `tom_d4rt`.
- [`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast/) — Flutter Material bridges built on this runtime; the canonical web/OTA consumer.
- [`tom_d4rt`](../tom_d4rt/) — the source-based reference interpreter kept in strict 1:1 sync with this package.

## Status

**Version 0.1.7** — current release on pub.dev (first published at 0.1.4). The package is production-quality in the context of the Tom framework and is kept continuously in sync with the analyzer-based `tom_d4rt` interpreter.

Repository: [https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_ast](https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_ast)

Issues and pull requests should be filed against the parent repository at [https://github.com/al-the-bear/tom_d4rt](https://github.com/al-the-bear/tom_d4rt).
