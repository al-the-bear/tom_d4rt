# tom_d4rt_generator Configuration Guide

This is the **authoritative reference** for configuring the D4rt bridge
generator. Every knob lives under a single top-level `d4rtgen:` block in
`buildkit.yaml` (or `build.yaml`). This guide enumerates the full model; for
the *mechanism* behind the relaxer / generic-constructor / proxy machinery it
links to the dedicated docs rather than re-explaining them — see
[index.md](index.md) for the map.

> **Generated files are never hand-edited.** Every `*.b.dart` is owned by this
> generator. To change generated output, change the config (or the generator)
> and regenerate. See the quest rule in `_ai/quests/d4rt/overview.d4rt.md`.

## Where configuration lives

| File | Role |
|------|------|
| `buildkit.yaml` → `d4rtgen:` | The configuration consumed by the `d4rtgen` CLI. Authoritative. |
| `build.yaml` → `targets: … d4rt_bridge_builder` | The `build_runner` builder options (see [bridgegenerator_user_reference.md](bridgegenerator_user_reference.md)). |
| `tom_build.yaml` | Workspace discovery marker for `d4rtgen --scan`. |

Both run paths read the **same** `d4rtgen:` model. Pick the CLI
([d4rt_generator_cli_user_guide.md](d4rt_generator_cli_user_guide.md)) for CI /
batch / one-shot generation, or `build_runner` for watch mode.

## Minimal configuration

```yaml
# buildkit.yaml
d4rtgen:
  name: my_package
  generateBarrel: true
  barrelPath: lib/d4rt_bridges.b.dart
  generateDartscript: true
  dartscriptPath: lib/dartscript.b.dart
  registrationClass: MyPackageBridge
  modules:
    - name: all
      barrelFiles:
        - lib/my_package.dart
      barrelImport: package:my_package/my_package.dart
      outputPath: lib/src/d4rt_bridges/my_package_bridges.b.dart
```

## Top-level keys (`d4rtgen:`)

Mirrors `BridgeConfig` in `lib/src/bridge_config.dart`.

### Identity & entry-point generation

| Key | Type | Default | Description |
|---|---|---|---|
| `name` | `String` | **required** | Project name used for class/identifier naming. |
| `modules` | `List` | **required** | One or more module definitions (see below). |
| `d4rtImport` | `String` | `package:tom_d4rt/d4rt.dart` | D4rt runtime import emitted in generated files. Override to `package:tom_d4rt_exec/d4rt.dart` for the analyzer-free exec runtime. |
| `helpersImport` | `String` | `package:tom_d4rt/tom_d4rt.dart` | D4rt helper (`D4`) import. |
| `generateBarrel` | `bool` | `true` | Emit a barrel file re-exporting all module bridges. |
| `barrelPath` | `String` | — | Output path for the barrel file. |
| `generateDartscript` | `bool` | `true` | Emit a `dartscript.b.dart` registration entry-point. |
| `dartscriptPath` | `String` | — | Output path for the dartscript file. |
| `registrationClass` | `String` | — | Name of the top-level registration class. |
| `libraryPath` | `String` | auto-derived | Directory for per-package bridge files (enables `PerPackageBridgeOrchestrator` dedup). |
| `generateTestRunner` | `bool` | `false` | Emit an executable `d4rtrun.b.dart` test runner. |
| `testRunnerPath` | `String` | — | Output path for the test runner. |
| `importedBridges` | `List` | `[]` | External bridge packages to import and chain (entry: `{import, class}`). |

### Relaxers, proxies, generic constructors (mechanism toggles)

| Key | Type | Default | Description |
|---|---|---|---|
| `recursiveBoundTypes` | `List<String>` | `[]` | Extra types for recursive-bound dispatch (`T extends Comparable<T>`). Bare name or `package:uri.dart:Type`. |
| `generateProxies` | `bool` | `false` | Emit proxy subclasses for abstract delegates (Category D). |
| `proxiesOutputPath` | `String` | — | Output path for the proxies file. |
| `proxyClasses` | `List` | `[]` | Abstract classes to proxy (see [proxy entry shapes](#proxy-class-entries)). |
| `relaxerOutputPath` | `String` | `lib/src/relaxers.b.dart` | Output path for the relaxer wrappers file. |
| `priorRelaxerModules` | `List<String>` | `[]` | Upstream package names whose relaxers to import instead of re-generating. |
| `generateAllRelaxers` | `bool` | `true` | When `true`, enumerate *every* bridged class as a candidate generic type-arg (full combinatorial B/C surface — large output). When `false`, restrict to discovered sites + `relaxerClasses` + `additionalRelaxerTypes`. |
| `relaxerClasses` | `List` | `[]` | Extra classes kept eligible as relaxer/RC-2 type-args when `generateAllRelaxers: false`. |
| `additionalRelaxerTypes` | `List<String>` | `[]` | Extra type names kept eligible when `generateAllRelaxers: false` (this is what the `scan_corpus_types` corpus scanner emits into `corpus_relaxer_allowlist.yaml`). |
| `recreatorClasses` | `List` | `[]` | Single-type-param widgets to emit `registerGenericTypeWrapper` re-creators for (MCI#5 / A5). |
| `genericInterceptors` | `List` | `[]` | Type-arg-keyed re-dispatch interceptors (MCI#8 / B4 — e.g. `RadioGroup.maybeOf<T>`). Dormant when empty. |
| `genericConstructors` | `List` | `[]` | Templated RC-2 generic constructor factories (MCI#6 / B3 — e.g. `GlobalKey<NavigatorState>()`). Dormant when empty. |
| `yieldVoidCallbacks` | `bool` | `false` | Wrap every *void* bridged callback in an `async` closure that yields ~1 ms after invoking the interpreted callback, handing a slice of the event loop back. For `tom_d4rt_flutter*` configs only — keep `false` for CLI/build scripting. Non-void callbacks are left untouched. |

When all four dormant lists (`recreatorClasses`, `genericInterceptors`,
`genericConstructors`) are empty and `generateAllRelaxers` keeps its default,
generated `*.b.dart` output is byte-identical to the historical behaviour.

### Type-mapping escape hatch

| Key | Type | Default | Description |
|---|---|---|---|
| `typeMappings` | `Map<String,String>` | `{}` | Substitute an awkward source type with another type at emission time. Keyed by source type name (`SomeType`) or its exact nullable spelling (`SomeType?`); the value is emitted verbatim wherever that type would appear — parameters, fields, return types, and each type argument inside generics. A bare key covers both nullable and non-nullable occurrences. The mapped type's own bridge registration is left intact. |
| `additionalImports` | `List<String>` | `[]` | Full `import` URIs added to every generated bridge file. Pairs with `typeMappings` when a substitute type lives in a package the generator would not otherwise import. |

This is the config seam behind the "fix the generator, not the generated code"
rule: a downstream package can resolve a hard-to-bridge type through
`buildkit.yaml` instead of patching the generator. Both keys default to empty,
so with no entries generated `*.b.dart` output is byte-identical.

```yaml
d4rtgen:
  typeMappings:
    SomeAwkwardType: dynamic
    SomeSealedBase: Object?
  additionalImports:
    - package:my_pkg/shims.dart
```

## Per-module keys (`modules[*]`)

Mirrors `ModuleConfig` in `lib/src/bridge_config.dart`.

| Key | Type | Default | Description |
|---|---|---|---|
| `name` | `String` | **required** | Module name. |
| `barrelFiles` | `List<String>` | required (or inferred from `barrelImport`) | Barrel files to scan; export graph is followed recursively. |
| `barrelImport` | `String` | — | Primary barrel URI for import-prefix generation. |
| `outputPath` | `String` | **required** | Output `*.b.dart` file path. |
| `excludePatterns` | `List<String>` | `[]` | Class-name glob patterns to skip. |
| `excludeClasses` | `List<String>` | `[]` | Exact class names to skip. |
| `excludeEnums` | `List<String>` | `[]` | Enum names to skip. |
| `excludeFunctions` | `List<String>` | `[]` | Top-level function names to skip. |
| `excludeConstructors` | `List<String>` | `[]` | Constructor names to skip (`Class.named`). |
| `excludeVariables` | `List<String>` | `[]` | Top-level variable names to skip. |
| `excludeSourcePatterns` | `List<String>` | `[]` | Source-URI glob patterns to skip; supports `#symbol` selectors for symbol-level exclusion. |
| `followAllReExports` | `bool` | `true` | Follow all external re-exports by default. |
| `skipReExports` | `List<String>` | `[]` | Package names to skip when following re-exports. |
| `followReExports` | `List<String>` | `[]` | Package names to follow when `followAllReExports: false`. |
| `importShowClause` | `List<String>` | `[]` | Symbols to include in generated `import … show`. |
| `importHideClause` | `List<String>` | `[]` | Symbols to include in generated `import … hide`. |
| `generateDeprecatedElements` | `bool` | `false` | Include `@deprecated` elements in output. |
| `deprecatedAllowlist` | `List<String>` | `[]` | Per-symbol opt-in for deprecated elements even when `generateDeprecatedElements: false`. See [deprecated_allowlist.md](deprecated_allowlist.md). |

## Advanced entry shapes

### Proxy class entries

`proxyClasses` accepts a bare string (`CustomPainter`) or a map. The map form
unlocks the typed/variant proxy machinery (Category D). Full detail in
[proxy_class_generation.md](proxy_class_generation.md).

```yaml
d4rtgen:
  generateProxies: true
  proxiesOutputPath: lib/src/bridges/flutter_proxies.b.dart
  proxyClasses:
    - CustomPainter                      # simple: D4rtCustomPainter
    - className: CustomClipper
      proxyName: D4rtCustomClipper       # custom proxy name
      typeArgVariants:                   # MCI#6/B1: one typed proxy per T
        - typeArg: Path                  #   first entry is the default arm
          defaultExpr: Path()
        - typeArg: Rect
          defaultExpr: Offset.zero & size
    - className: State                   # MCI#3/A3+A4: mixin-bearing variants
      mixinVariants:
        - SingleTickerProviderStateMixin
        - RestorationMixin
    - className: BoxScrollView           # super-formal defaults for an
      superArgDefaults:                  #   abstract base the proxy extends
        scrollDirection: Axis.vertical
        reverse: 'false'
        clipBehavior: Clip.hardEdge
```

The three map keys on a proxy entry are independent and may be combined:

| Proxy key | Type | Purpose |
|-----------|------|---------|
| `proxyName` | `String` | Override the generated proxy class name (default `D4rt<ClassName>`). |
| `mixinVariants` | `List<String>` | Emit one proxy variant per mixin so an interpreted subclass can mix in `SingleTickerProviderStateMixin` etc. (MCI#3 / A3+A4). |
| `typeArgVariants` | `List<{typeArg, defaultExpr}>` | Emit one typed proxy per type argument; the first entry is the default arm (MCI#6 / B1). |
| `superArgDefaults` | `Map<String,String>` | Default expressions for the **required** super-formal parameters of the abstract base the proxy extends, so the generated proxy can call `super(...)` without the script supplying them. Keys are parameter names; values are Dart expressions (quote bare literals like `'false'`). |

### Generic constructor entries

`genericConstructors` reifies a script's explicit type argument into a concrete
native generic (work the type-erased bridge constructor boundary cannot do).
Each entry has a `kind` discriminator. Full detail in
[generic_constructor_and_other_extensions.md](generic_constructor_and_other_extensions.md).

```yaml
d4rtgen:
  genericConstructors:
    - className: GlobalKey
      kind: namedPassthrough          # forwards named args to Class<T>(named…)
      typeArgVariants: [NavigatorState, ScaffoldState]
      namedArgs:
        - name: debugLabel
          type: String
    - className: ValueNotifier
      kind: nullableValue             # value is T ? Class<T>(v) : Class<T?>(v as T?)
      typeArgVariants: [int, String, double]
      includeDynamicArm: true         # adds a leading <dynamic> arm
```

### Generic interceptor entries

`genericInterceptors` templates the re-dispatch half of a type-arg-keyed
lookup (e.g. `RadioGroup.maybeOf<T>(context)`) that the bridge boundary would
otherwise collapse to `<dynamic>`. Emitted inline into `registerRelaxers()`.

```yaml
d4rtgen:
  genericInterceptors:
    - className: RadioGroup
      methodName: maybeOf
      isStatic: true
      typeArgVariants: [int, String]
      contextArgIndex: 0
      contextArgType: BuildContext
      fallbackExpr: null
```

### Recreator entries

`recreatorClasses` accepts a bare class name or `{className, innerTypes}`. When
`innerTypes` is omitted it defaults to `[String, int, double, bool, num]`.

```yaml
d4rtgen:
  recreatorClasses:
    - ValueListenableBuilder
    - className: Tween
      innerTypes: [double, Offset, Color]
```

## Registration facades & annotation directives

Two configuration *surfaces* live outside `buildkit.yaml`:

1. **Runtime registration facades** — `registerRelaxerFactory`,
   `registerInterfaceProxy`, `registerGenericConstructor` are called on the
   `D4rt` runtime to register what the generator emits (and to hand-register
   extras). They are documented on the runtime side — see the
   [tom_d4rt User Guide → Extension Registration and Facades](../../tom_d4rt/doc/d4rt_user_guide.md#extension-registration-and-facades).
   The generated `registerRelaxers()` / `registerGenericConstructors()` /
   proxy registrations call these for you.

2. **Annotation directives** — `@D4rtUserProxy` / `@D4rtUserRelaxer` let a
   downstream project declare proxy/relaxer generation for its **own** generic
   classes (including multi-type-parameter generics the auto-generator does not
   cover) without editing `buildkit.yaml`. They mirror the `@D4rtUserBridge`
   override convention. Full detail in
   [user_proxy_relaxer_annotations.md](user_proxy_relaxer_annotations.md) and,
   for hand-written member overrides, [user_bridge_user_guide.md](user_bridge_user_guide.md).

## Output files

The generator emits, per project: per-module `<outputPath>` bridges, a
`relaxers.b.dart` (wrappers + `registerRelaxers()` + `registerGenericConstructors()`),
an optional `proxies.b.dart`, a barrel, a `dartscript.b.dart` entry-point, and
an optional `d4rtrun.b.dart` test runner. See the README "Generated file
conventions" table for the full list and the `*.b.dart` header/extension rules.

## See also

- [index.md](index.md) — documentation map (the four mechanism areas A–D).
- [bridgegenerator_user_guide.md](bridgegenerator_user_guide.md) — quick start.
- [d4rt_generator_cli_user_guide.md](d4rt_generator_cli_user_guide.md) — the `d4rtgen` CLI.
- [generics_wrapper_and_type_relaxation_strategy.md](generics_wrapper_and_type_relaxation_strategy.md) — why relaxers (A/B) exist.
