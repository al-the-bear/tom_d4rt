# tom_d4rt_generator

> **Attribution.** The `tom_d4rt` project is an extended clone of the original
> d4rt project by Moustapha Kodjo Amadou, initially published in 2025. The
> complete interpreter is based on his idea.

D4rt bridge generator — reads `buildkit.yaml`, follows barrel exports, and emits
`*.b.dart` files that register Dart APIs with the D4rt sandboxed interpreter.

---

## Overview

[D4rt](https://pub.dev/packages/tom_d4rt) is a sandboxed Dart interpreter. To
call real Dart APIs from inside a D4rt script the interpreter needs a *bridge*: a
generated class that maps interpreter method calls to native Dart invocations.

`tom_d4rt_generator` automates the entire bridge-writing process:

1. It reads a `d4rtgen:` block in your project's `buildkit.yaml`.
2. It follows barrel-file export chains, respecting `show`/`hide` clauses, to
   discover every class, enum, mixin, extension, global function, and global
   variable that should be bridged.
3. It uses the Dart analyzer (element-mode, summary-backed in v1.9.0) to
   extract constructors, methods, getters, setters, operators, type parameters,
   default values, and annotations.
4. It emits one or more `*.b.dart` output files — **never** to be hand-edited —
   containing `BridgedClass` registrations, relaxer wrappers, proxy classes, and
   a `dartscript.b.dart` entry-point that wires everything together.

The generated files are consumed at runtime by the `tom_d4rt` interpreter and
by bridge corpus packages such as `tom_d4rt_flutter` and `tom_d4rt_flutter_ast`
(the Flutter/Material bridge corpora — see [Ecosystem](#ecosystem)).

> **Start here:** [`doc/index.md`](doc/index.md) is the navigation hub for this
> package's documentation. It maps the 17 docs into the four mechanism areas
> (A–D) summarised below and links each to its canonical reference. Read it
> before diving into the individual guides.

### What it generates — the A–D taxonomy

The generator emits four categories of artifact. The labels **A–D** are used
throughout the codebase and the docs; this README and
[`doc/index.md`](doc/index.md) share the same taxonomy:

| Cat | Artifact | Selection | What it solves | Canonical doc |
|-----|----------|-----------|----------------|---------------|
| **A** | `$Relaxed*<V>` type-relaxing wrapper classes | auto (1 type param) | erased generics (`ValueNotifier<dynamic>` ≠ `ValueNotifier<MagnifierInfo>`) | [generics_wrapper_and_type_relaxation_strategy.md](doc/generics_wrapper_and_type_relaxation_strategy.md) |
| **B** | `_relax*` factory switches (`registerGenericTypeWrapper`) | auto + combinatorial | materialising a concrete type-arg at runtime | [generics_wrapper_and_type_relaxation_strategy.md](doc/generics_wrapper_and_type_relaxation_strategy.md) |
| **C** | `_rc2*` generic-constructor factories (`registerGenericConstructor`) | auto + combinatorial | `MyClass<String>()` without knowing the type at generation time | [generic_constructor_and_other_extensions.md](doc/generic_constructor_and_other_extensions.md) |
| **D** | `D4rt*` proxy classes (`registerInterfaceProxy`) | explicit `proxyClasses:` | native subclasses of abstract delegates (`CustomPainter`, `FlowDelegate`) | [proxy_class_generation.md](doc/proxy_class_generation.md) |

The combinatorial **B/C** families dominate generated size; the reduction knobs
(`generateAllRelaxers` / `relaxerClasses` / `additionalRelaxerTypes`, plus the
scanned allowlist in [generate_allowlists.md](doc/generate_allowlists.md)) trade
generate-everything for a scanned allowlist.

---

## Installation

Add the generator as a dev dependency:

```yaml
dev_dependencies:
  tom_d4rt_generator: ^1.9.4
  build_runner: ^2.4.0   # only needed for build_runner integration
```

The package ships a standalone CLI executable called `d4rtgen`; no additional
activation step is required.

---

## Quick Start

### 1. Add a `d4rtgen:` block to `buildkit.yaml`

```yaml
# buildkit.yaml
d4rtgen:
  name: my_package
  helpersImport: package:tom_d4rt/tom_d4rt.dart
  generateBarrel: true
  barrelPath: lib/d4rt_bridges.b.dart
  generateDartscript: true
  dartscriptPath: lib/dartscript.b.dart
  registrationClass: MyPackageBridge
  generateTestRunner: true
  testRunnerPath: bin/d4rtrun.b.dart
  modules:
    - name: all
      barrelFiles:
        - lib/my_package.dart
      barrelImport: package:my_package/my_package.dart
      outputPath: lib/src/d4rt_bridges/my_package_bridges.b.dart
```

### 2. Run the generator

Using the `d4rtgen` CLI (recommended):

```bash
# Generate for the project in the current directory
dart run tom_d4rt_generator:d4rtgen --project=.

# Generate for a specific path
dart run tom_d4rt_generator:d4rtgen --project=/path/to/my_package

# Generate for multiple projects via comma-separated list or glob
dart run tom_d4rt_generator:d4rtgen --project=tom_*_bridges,devops/tom_build_cli

# Scan a workspace tree for all projects that have a d4rtgen config
dart run tom_d4rt_generator:d4rtgen --scan=. --recursive

# List discovered projects without generating
dart run tom_d4rt_generator:d4rtgen --scan=. --list

# Verbose output showing per-class progress
dart run tom_d4rt_generator:d4rtgen --project=. --verbose
```

Or via `build_runner` (useful for continuous watch mode):

```bash
dart run build_runner build
dart run build_runner watch
```

The `build_runner` builder key is `tom_d4rt_generator:d4rt_bridge_builder`.

### 3. Register bridges at runtime

Import and call the generated entry-point from your host application:

```dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:my_package/dartscript.b.dart';

final d4rt = D4rt();
MyPackageBridge.registerBridges(d4rt, 'package:my_package/my_package.dart');
```

---

## End-to-end worked example

A complete loop: a barrel exposes a native class, the generator bridges it, and
a D4rt script calls it through the `tom_d4rt` interpreter.

**1. The native API and its barrel** (`lib/my_package.dart`):

```dart
// lib/src/temperature.dart
class Temperature {
  final double celsius;
  const Temperature(this.celsius);
  double get fahrenheit => celsius * 9 / 5 + 32;
  Temperature warmer(double by) => Temperature(celsius + by);
}

// lib/my_package.dart  (barrel)
export 'src/temperature.dart';
```

**2. Generate the bridges** with the `d4rtgen:` block from the Quick Start:

```bash
dart run tom_d4rt_generator:d4rtgen --project=.
# writes lib/src/d4rt_bridges/my_package_bridges.b.dart,
# lib/dartscript.b.dart, relaxers.b.dart, etc.
```

**3. Register and run a script** against the generated bridges:

```dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:my_package/dartscript.b.dart';

void main() {
  final d4rt = D4rt();
  MyPackageBridge.registerBridges(
    d4rt,
    'package:my_package/my_package.dart',
  );

  final result = d4rt.execute(
    source: '''
      import 'package:my_package/my_package.dart';

      double main() {
        final t = Temperature(20).warmer(5); // 25 C
        return t.fahrenheit;                  // 77.0
      }
    ''',
  );

  print(result); // 77.0
}
```

The script never imports the native package directly — it runs inside the
sandbox and reaches `Temperature` only through the generated `BridgedClass`.
When the generator cannot derive correct code for a member, override just that
member with a `D4UserBridge` (see [UserBridge override system](#userbridge-override-system))
without touching the rest of the generated file.

For runnable, multi-feature versions of this loop see the sample projects under
[`tom_d4rt_samples/`](../tom_d4rt_samples/):
[`d4rt_userbridges_sample`](../tom_d4rt_samples/d4rt_userbridges_sample/) (the
hand-written override path this generator scans) and
[`d4rt_introduction_sample`](../tom_d4rt_samples/d4rt_introduction_sample/)
(basic interpreter use of bridged APIs).

---

## Features

### Barrel-file export following

The generator starts from the `barrelFiles` list and recursively follows
`export` directives. It correctly propagates `show`/`hide` clauses through
re-export chains (including multi-hop chains where clause intersection and
union are applied at each hop). Packages that should be skipped during
re-export traversal can be listed in `skipReExports`; alternatively set
`followAllReExports: false` and enumerate only the packages you want via
`followReExports`.

### Per-package deduplication via `PerPackageBridgeOrchestrator`

When multiple barrel files re-export the same source package, the
`PerPackageBridgeOrchestrator` generates a single
`package_<pkgname>_bridges.b.dart` file per source package in a shared
`libraryPath` directory. The per-module barrel files become thin delegating
wrappers that import those per-package files. This eliminates duplicate
`BridgedClass` registrations that would otherwise cause runtime conflicts.

### Summary-backed extraction (v1.9.0)

All class extraction now runs through `ElementModeExtractor`, an element-walker
backed by analyzer `.sum` summaries. The shared summary cache
(`tom_analyzer_shared`) is reused by sibling generators (e.g.,
`tom_reflection_generator`). The legacy 16,000-line AST visitor path was
removed entirely in this release.

### Relaxer wrappers — `$Relaxed<V>`

For every generic class whose type argument must be materialised at runtime
(e.g., `Animation<double>`, `ValueNotifier<String>`), the relaxer generator
emits a `$RelaxedAnimation<V>` wrapper class plus a factory function with a
`switch` dispatch over the concrete type argument. A `registerRelaxers()`
function registers all factories with `D4.registerGenericTypeWrapper()`. The
output file defaults to `relaxers.b.dart` alongside the first module's bridge
file and can be overridden via `relaxerOutputPath`. Upstream relaxer modules
can be imported and re-used rather than re-generated via `priorRelaxerModules`.

### Proxy classes for abstract delegates

Configuring `generateProxies: true` and listing class names under `proxyClasses`
causes the proxy generator to produce concrete subclasses for abstract delegates
such as `CustomPainter` or `CustomClipper`. Each abstract method becomes a
`Function` callback field so that D4rt scripts can supply callback
implementations:

```dart
// Generated (do not edit):
class D4rtCustomPainter extends CustomPainter {
  final void Function(Canvas, Size) onPaint;
  final bool Function(CustomPainter) onShouldRepaint;
  D4rtCustomPainter({required this.onPaint, required this.onShouldRepaint});
  @override void paint(Canvas c, Size s) => onPaint(c, s);
  @override bool shouldRepaint(CustomPainter p) => onShouldRepaint(p);
}
```

Proxy class names default to `D4rt<ClassName>` and can be customised via a
`proxyName` entry in the config.

### Generic constructor factories (RC-2)

For classes with a single type parameter and matching constructors the generator
emits a runtime-dispatch switch that selects the right native type at
construction time, enabling D4rt scripts to write `MyClass<String>()` without
knowing the concrete type at generation time.

### Callback wrapping

Function-type parameters are automatically wrapped so that an interpreted
callable stored in the interpreter's closure scope can be passed to native Dart
code that expects a concrete `Function` type.

### UserBridge override system

When the generator cannot produce correct code for a member (unusual operator
signatures, platform-specific callbacks, etc.) you can write a companion class
that overrides individual members while keeping all other generated code intact.

Declare a class that extends `D4UserBridge`, annotate it with
`@D4rtUserBridge(libraryPath)` (or `@D4rtGlobalsUserBridge(libraryPath)` for
top-level overrides), and place it in `lib/src/d4rt_user_bridges/` or
`lib/d4rt_user_bridges/`. The scanner (`UserBridgeScanner`) discovers the file
automatically and the generator injects the overrides at code-emission time.

```dart
// lib/src/d4rt_user_bridges/matrix2x2_user_bridge.dart
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:my_package/src/matrix2x2.dart';

@D4rtUserBridge('package:my_package/src/matrix2x2.dart')
class Matrix2x2UserBridge extends D4UserBridge {
  static Object? overrideOperatorIndex(
    InterpreterVisitor visitor,
    Object target,
    List<Object?> positional,
    Map<String, Object?> named,
    List<RuntimeType>? typeArgs,
  ) {
    final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
    final indices = D4.coerceList<int>(positional[0], 'indices');
    return matrix[indices];
  }
}
```

Override method naming conventions (all static, all prefixed `override`):

| Override target | Method prefix |
|---|---|
| Default constructor | `overrideConstructor` |
| Named constructor `foo` | `overrideConstructorFoo` |
| Instance method `bar` | `overrideMethodBar` |
| Instance getter `baz` | `overrideGetterBaz` |
| Instance setter `qux` | `overrideSetterQux` |
| Static method `foo` | `overrideStaticMethodFoo` |
| Static getter `bar` | `overrideStaticGetterBar` |
| Operator `[]` | `overrideOperatorIndex` |
| Operator `[]=` | `overrideOperatorIndexAssign` |
| Operator `+` | `overrideOperatorPlus` |
| Operator `==` | `overrideOperatorEquals` |

For top-level (globals) overrides use `@D4rtGlobalsUserBridge` and prefix
methods with `overrideGlobalVariable`, `overrideGlobalGetter`, or
`overrideGlobalFunction`.

### Mixin and extension bridging

Pure `mixin` declarations and named/anonymous extensions are bridged. Extension
methods discovered by walking the import tree of each source file are included
so D4rt scripts can call extension methods from packages like
`package:collection`.

### Type alias registration

Non-function `typedef` aliases (e.g.,
`typedef MaterialStateProperty<T> = WidgetStateProperty<T>`) are collected and
registered via a generated `classAliases()` method so that D4rt scripts can
reference the alias name directly.

### Dart record types

Record types as function parameters and return values are fully supported. The
generator emits conversion code that converts `InterpretedRecord` ↔ native Dart
record at call sites.

### Configurable D4rt runtime import

The `d4rtImport` key lets you point the generated files at an alternative
runtime package (e.g., `package:tom_d4rt_exec/d4rt.dart`), making the generator
reusable across different D4rt deployment targets.

### Test infrastructure (`testing.dart`)

The optional `testing.dart` library exposes `D4rtTester`,
`D4rtTestResult`, and `IssueTestHelper` for writing regression tests that
execute D4rt scripts against real generated bridges. The generator ships 94+
D4rt test scripts covering constructors, fields, methods, operators, generics,
inheritance, parameters, async, enums, and UserBridge overrides across six
example projects.

---

## Configuration Reference

All keys live under a top-level `d4rtgen:` block in `buildkit.yaml`. This is a
quick reference; the **full configuration guide** — with the advanced entry
shapes (proxy variants, generic constructors/interceptors, recreators) and the
registration-facade / annotation-directive surfaces — is in
[doc/tom_d4rt_generator_configuration.md](doc/tom_d4rt_generator_configuration.md).

### Top-level keys

| Key | Type | Default | Description |
|---|---|---|---|
| `name` | `String` | required | Project name used for class naming |
| `modules` | `List` | required | One or more module definitions (see below) |
| `d4rtImport` | `String` | `package:tom_d4rt/d4rt.dart` | D4rt runtime import in generated files |
| `helpersImport` | `String` | `package:tom_d4rt/tom_d4rt.dart` | D4rt helpers import |
| `generateBarrel` | `bool` | `true` | Emit a barrel file exporting all module bridges |
| `barrelPath` | `String` | — | Output path for the barrel file |
| `generateDartscript` | `bool` | `true` | Emit a `dartscript.b.dart` registration entry-point |
| `dartscriptPath` | `String` | — | Output path for the dartscript file |
| `registrationClass` | `String` | — | Name for the top-level registration class |
| `libraryPath` | `String` | auto-derived | Directory for per-package bridge files |
| `generateTestRunner` | `bool` | `false` | Emit an executable `d4rtrun.b.dart` test runner |
| `testRunnerPath` | `String` | — | Output path for the test runner |
| `importedBridges` | `List` | `[]` | External bridge packages to import and chain |
| `recursiveBoundTypes` | `List<String>` | `[]` | Additional types for recursive-bound dispatch |
| `generateProxies` | `bool` | `false` | Emit proxy subclasses for abstract delegates |
| `proxiesOutputPath` | `String` | — | Output path for the proxies file |
| `proxyClasses` | `List` | `[]` | Abstract classes to proxy (string or `{className, proxyName}`) |
| `relaxerOutputPath` | `String` | auto-derived | Output path for the relaxer wrappers file |
| `priorRelaxerModules` | `List<String>` | `[]` | Upstream packages whose relaxers to import instead of re-generating |
| `generateAllRelaxers` | `bool` | `true` | When `false`, restrict the combinatorial relaxer/RC-2 surface to discovered sites + `relaxerClasses` + `additionalRelaxerTypes` (collapses output size) |
| `relaxerClasses` | `List` | `[]` | Extra classes kept eligible as relaxer/RC-2 type-args when `generateAllRelaxers: false` |
| `additionalRelaxerTypes` | `List<String>` | `[]` | Extra type names kept eligible when `generateAllRelaxers: false` (emitted by the corpus scanner) |
| `recreatorClasses` | `List` | `[]` | Single-type-param widgets to emit `registerGenericTypeWrapper` re-creators for |
| `genericInterceptors` | `List` | `[]` | Type-arg-keyed re-dispatch interceptors (e.g. `RadioGroup.maybeOf<T>`); dormant when empty |
| `genericConstructors` | `List` | `[]` | Templated RC-2 generic constructor factories (e.g. `GlobalKey<NavigatorState>()`); dormant when empty |
| `yieldVoidCallbacks` | `bool` | `false` | Wrap void bridged callbacks in an `async` closure that yields to the event loop (`tom_d4rt_flutter*` only) |

See [doc/tom_d4rt_generator_configuration.md](doc/tom_d4rt_generator_configuration.md)
for the per-entry YAML shapes of `proxyClasses`, `genericConstructors`,
`genericInterceptors`, and `recreatorClasses`.

### Per-module keys (`modules[*]`)

| Key | Type | Default | Description |
|---|---|---|---|
| `name` | `String` | required | Module name |
| `barrelFiles` | `List<String>` | required (or inferred from `barrelImport`) | Barrel files to scan |
| `barrelImport` | `String` | — | Primary barrel URI for import-prefix generation |
| `outputPath` | `String` | required | Output `*.b.dart` file path |
| `excludePatterns` | `List<String>` | `[]` | Class-name glob patterns to skip |
| `excludeClasses` | `List<String>` | `[]` | Class names to skip |
| `excludeEnums` | `List<String>` | `[]` | Enum names to skip |
| `excludeFunctions` | `List<String>` | `[]` | Top-level function names to skip |
| `excludeConstructors` | `List<String>` | `[]` | Constructor names (`Class.named`) to skip |
| `excludeVariables` | `List<String>` | `[]` | Top-level variable names to skip |
| `excludeSourcePatterns` | `List<String>` | `[]` | Source URI glob patterns to skip; supports `#symbol` selectors |
| `followAllReExports` | `bool` | `true` | Follow all external re-exports by default |
| `skipReExports` | `List<String>` | `[]` | Package names to skip when following re-exports |
| `followReExports` | `List<String>` | `[]` | Package names to follow when `followAllReExports` is `false` |
| `importShowClause` | `List<String>` | `[]` | Symbols to include in generated `import … show` |
| `importHideClause` | `List<String>` | `[]` | Symbols to include in generated `import … hide` |
| `generateDeprecatedElements` | `bool` | `false` | Include `@deprecated` elements in output |
| `deprecatedAllowlist` | `List<String>` | `[]` | Per-symbol opt-in for deprecated elements even when `generateDeprecatedElements: false` |

---

## Architecture and Key Concepts

### `BridgeGenerator`

The core workhorse (`lib/src/bridge_generator.dart`, ~13,600 lines). Given a
list of barrel files it:

1. Calls `parseExportFiles()` to walk the export graph and collect
   `ExportInfo` per source file (with resolved `show`/`hide` clauses).
2. Resolves each source file through an `AnalysisContextCollection` backed
   by `.sum` summary bundles.
3. Delegates to `ElementModeExtractor` to collect `ClassInfo`,
   `GlobalFunctionInfo`, `GlobalVariableInfo`, `EnumInfo`, and
   `ExtensionInfo`.
4. Emits the `BridgedClass` registration code.

### `ElementModeExtractor`

Element-walker over `LibraryElement` (`lib/src/element_mode_extractor.dart`).
Produces the same output types as the legacy AST visitor that was removed in
v1.9.0. Handles type aliases, inheritance resolution, default-value rendering,
metadata/annotation serialization, inherited members, and type substitution.

### `PerPackageBridgeOrchestrator`

Four-phase deduplication engine (`lib/src/per_package_orchestrator.dart`):

1. Scans `d4rt_user_bridges/` directories for `UserBridgeScanner`.
2. `collectPackageInfo()` — maps each source file to its owning package.
3. `buildGlobalClassLookup()` — builds a cross-package `ClassInfo` map for
   inheritance resolution.
4. `generatePerPackageFiles()` — generates one bridge file per source package
   with scoped exclusions.
5. `generateDelegatingBarrelFiles()` — generates thin barrel files that
   delegate to the per-package files.

### `UserBridgeScanner`

Element-walker over `LibraryElement` that discovers classes extending
`D4UserBridge` (`lib/src/user_bridge_scanner.dart`). Looks for
`@D4rtUserBridge(libraryPath, className?)` and
`@D4rtGlobalsUserBridge(libraryPath)` annotations. Extracts every
`override*`-prefixed static method and maps it to the correct member category
(constructor, getter, setter, method, static method, operator).

### `RelaxerGenerator`

Consumes `GenericExtractionSite` records accumulated during bridge emission
(`lib/src/relaxer_generator.dart`). Generates `$Relaxed<Base><V>` wrapper
classes, per-module factory functions with `switch` dispatch on the concrete
type argument, and a `registerRelaxers()` registration function.

### `ProxyGenerator`

Reads the `proxyClasses` list from `BridgeConfig`, resolves each class through
the analyzer, and emits concrete subclasses with `Function` callback fields for
every abstract method and overridable getter
(`lib/src/proxy_generator.dart`).

### Generated file conventions

All generated files:

- Carry a `// D4rt Bridge — Generated file, do not edit` header and an ISO
  timestamp.
- Include a comprehensive `// ignore_for_file:` directive covering the
  pragmatic suppressions needed for generated bridge code.
- Use the `*.b.dart` extension (enforced by `ensureBDartExtension()`).
- Should never be committed to source control if you regenerate on every build.

The primary output files per project are:

| File | Purpose |
|---|---|
| `<outputPath>.b.dart` (per module) | `BridgedClass` registrations for all classes, enums, extensions, and globals in that module |
| `relaxers.b.dart` | `$Relaxed<T><V>` wrapper classes and `registerRelaxers()` |
| `proxies.b.dart` (optional) | Concrete proxy subclasses for abstract delegates |
| `d4rt_bridges.b.dart` (barrel) | Re-exports all module bridge files |
| `dartscript.b.dart` | Top-level `registerBridges()` / `register()` entry-point |
| `d4rtrun.b.dart` (optional) | Executable test runner for validating bridges interactively |

---

## Programmatic API

```dart
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

// Generate from a buildkit.yaml config file:
final result = await generateBridges(
  configPath: '/path/to/project/buildkit.yaml',
);

// Or from a BridgeConfig object:
final config = BridgeConfig.fromJson({...});
final result = await generateBridges(
  config: config,
  projectPath: '/path/to/project',
);

if (result.isSuccess) {
  print('Generated ${result.totalClasses} classes');
  print('Output files: ${result.outputFiles}');
}
```

---

## Ecosystem

```
tom_d4rt (interpreter)
    |
    +-- tom_d4rt_generator  (THIS PACKAGE — bridge generator)
            |
            +-- tom_d4rt_flutter / tom_d4rt_flutter_ast
                (Flutter + Material bridge corpus — output of this generator)
```

The `tom_d4rt` interpreter package provides the runtime types (`BridgedClass`,
`D4UserBridge`, `D4rt`, `D4`, `InterpreterVisitor`, `RuntimeType`, …) that the
generated code depends on. `tom_d4rt_generator` produces the glue that maps
interpreter calls to real Dart code. Bridge corpus packages
(`tom_d4rt_flutter_ast`) are just Dart packages whose `*.b.dart` files were
generated by this tool.

The `tom_analyzer_shared` package provides the shared `.sum` summary cache so
`tom_d4rt_generator` and `tom_reflection_generator` can reuse each other's
analysis work without re-scanning the same dependencies twice.

Repository: `github.com/al-the-bear/tom_d4rt` (monorepo), path
`tom_d4rt_generator/`.

---

## Further documentation

[`doc/index.md`](doc/index.md) is the navigation hub — start there. The docs are
grouped by the mechanism areas it defines:

**Getting started**

| Document | Description |
|---|---|
| [doc/index.md](doc/index.md) | Navigation hub — maps all docs into the A–D mechanism areas |
| [Bridge Generator User Guide](doc/bridgegenerator_user_guide.md) | End-to-end walkthrough |
| [Configuration Guide](doc/tom_d4rt_generator_configuration.md) | **Authoritative** full `d4rtgen:` `buildkit.yaml` model — all keys, advanced entry shapes, facades/annotations |
| [CLI User Guide](doc/d4rt_generator_cli_user_guide.md) | `d4rtgen` command reference |
| [build.yaml Builder Reference](doc/bridgegenerator_user_reference.md) | `build_runner` builder-options reference |

**Generics (categories A/B/C)**

| Document | Description |
|---|---|
| [Generics wrappers & type relaxation](doc/generics_wrapper_and_type_relaxation_strategy.md) | A/B — `$Relaxed*<V>` wrappers and `_relax*` factory switches |
| [Generic constructors & runtime extensions](doc/generic_constructor_and_other_extensions.md) | C — `_rc2*` generic-constructor factories (RC-1…RC-5) |
| [Generate allowlists](doc/generate_allowlists.md) | Reduction knobs and the scanned relaxer allowlist |

**Proxies (category D)**

| Document | Description |
|---|---|
| [Proxy class generation](doc/proxy_class_generation.md) | D — `D4rt*` proxy subclasses for abstract delegates |

**User bridges & annotation directives**

| Document | Description |
|---|---|
| [UserBridge Guide](doc/user_bridge_user_guide.md) | Writing `@D4rtUserBridge` override classes |
| [UserBridge Design](doc/userbridge_override_design.md) | Override pre-scan and registration routing internals |
| [User proxy/relaxer annotations](doc/user_proxy_relaxer_annotations.md) | `@D4rtUserProxy` / `@D4rtUserRelaxer` variant-pattern directives |

**Advanced**

| Document | Description |
|---|---|
| [Deprecated allowlist](doc/deprecated_allowlist.md) | Per-symbol `@Deprecated` opt-in |
| [VM↔web skew coercion](doc/vm_web_skew_coercion.md) | Nullability-skew coercion registry |

**Testing**

| Document | Description |
|---|---|
| [Test coverage](doc/test_coverage.md) | Test-suite layout and coverage |
| [Worked samples](doc/worked_samples.md) | Sample apps catalogued against the mechanisms they exercise |
| [Issues](doc/issues.md) | Known issues / open-issue log |

### Consumers and related packages

- [`tom_d4rt`](../tom_d4rt/) — the interpreter that provides the runtime types
  (`BridgedClass`, `D4UserBridge`, `D4rt`, `D4`, …) the generated code depends on.
- [`tom_d4rt_flutter`](../tom_d4rt_flutter/) — source-based Flutter/Material
  bridge corpus generated by this tool.
- [`tom_d4rt_flutter_ast`](../tom_d4rt_flutter_ast/) — analyzer-free Flutter/
  Material bridge corpus (web/OTA) generated by this tool.

---

## Status

**Mature — v1.9.4.**

Version 1.9.0 completes a six-phase migration from a dual-path (AST + element)
extraction model to a single element-mode code path backed by analyzer `.sum`
summaries. The public generator API is unchanged. Generated bridge output for
all five documented consumer packages is byte-identical to the pre-migration
baseline (modulo the `Generated: <timestamp>` header). All known consumers have
zero new regressions.

### What's new in 1.9.3 – 1.9.4

**1.9.4 — housekeeping.** Test artifacts moved to a gitignored `testlog/`
folder; `doc/` no longer ships machine-generated baselines. No code changes.

**1.9.3 — generated-code hygiene & docs.** Generated `*.b.dart` bridges now emit
expanded `// ignore_for_file:` headers so corpora (including `tom_d4rt_flutter`)
are analyzer-clean without per-file hand edits; proxy/relaxer
manual-intervention guidance consolidated into
[doc/user_proxy_relaxer_annotations.md](doc/user_proxy_relaxer_annotations.md).

### What's new in 1.9.1 – 1.9.2

**1.9.1 — build_runner registration parity (fix).** The build_runner /
orchestrator path now emits a compiling `dartscript.b.dart`: the delegating
barrel emits the `subPackageBarrels()` method the shared template calls, and
the build_runner path now generates `relaxers.b.dart` (falling back to a
resolvable no-op stub when there are no extraction sites). The standalone/CLI
and build_runner paths now emit interchangeable registration code, locked by a
new regression test that `dart analyze`-checks the assembled artifacts.

**1.9.2 — annotation-driven proxies/relaxers and new template families.**

- **Annotation directives** `@D4rtUserProxy` / `@D4rtUserRelaxer`, backed by a
  variant-pattern engine, let user bridges declare proxy/relaxer overrides
  (full treatment in the configuration & registration-facade docs).
- **New template families**: B3 generic-constructor reifiers, A4
  RenderBox-proxy, super-constructor-arg capture factories, generic-type-arg
  proxy variants, State-proxy mixin variants, and generic interceptor
  re-dispatch.
- **`genericInterceptors`** config knob wired into `BridgeConfig`, plus a
  VM↔web signature-skew coercion table.
- **`yieldVoidCallbacks`** switch for cooperative input/frame yield: void
  callback wrappers are emitted as async closures awaiting a 1 ms delay.
- Per-symbol `@Deprecated` allowlist; opt-in `vector_math_64` bridge.
- Requires `tom_d4rt ^1.8.21`.

> The new config knobs (`genericInterceptors`, `yieldVoidCallbacks`) are
> documented in the Configuration section; the registration facades and the
> `@D4rtUserProxy` / `@D4rtUserRelaxer` annotations get their full reference in
> the registration-facade docs. See `CHANGELOG.md` for the complete entry.

Repository: <https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_generator>

---

## License

MIT License — see [LICENSE](LICENSE) for details.

Author: Alexis Kyaw ([LinkedIn](https://www.linkedin.com/in/nickmeinhold/))
