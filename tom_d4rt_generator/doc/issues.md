# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-09

---

## Issue Index

### Fixed (v1.5.0 and earlier)

| ID | Description | Complexity | Status |
|----|-------------|------------|--------|
| [GEN-028](#gen-028) | CLI didn't pass export filtering params to generator | Medium | Fixed |
| [GEN-029](#gen-029) | CLI path missing export info filtering for globals | Medium | Fixed |
| [GEN-030](#gen-030) | Multi-barrel modules only registered under primary barrel | High | Fixed |
| [GEN-031](#gen-031) | CLI `args['projects']` referenced undefined ArgParser option | Low | Fixed |
| [GEN-032](#gen-032) | Test runner generation step missing from bin CLI path | Medium | Fixed |
| [GEN-033](#gen-033) | Test runner init source included non-package `lib/` URIs | Medium | Fixed |
| [GEN-034](#gen-034) | Test runner registration doubled with `lib/` paths | Medium | Fixed |
| [GEN-035](#gen-035) | Test runner file detection missed `.d4rt` extension | Low | Fixed |
| [GEN-036](#gen-036) | Example script `run_all_examples.dart` referenced wrong executable name | Low | Fixed |
| [GEN-037](#gen-037) | Generated bridge files don't consistently use .b.dart extension | Medium | Fixed |
| [GEN-038](#gen-038) | Test runner fails on first duplicate instead of reporting all | Low | Fixed |
| [GEN-039](#gen-039) | Test runner config not supported in build.yaml | Low | Fixed |
| [GEN-040](#gen-040) | Recursive bound error message references `_sample` instead of `sample` | Low | Fixed |
| [GEN-043](#gen-043) | Generated user bridge references lack import prefix ($pkg.) | Medium | Fixed |

### Fixed (v1.5.2)

| ID | Description | Complexity | Status |
|----|-------------|------------|--------|
| [GEN-007](#gen-007) | Function type alias detection limited to 7 hardcoded names | Low | Resolved |
| [GEN-008](#gen-008) | Private SDK library mapping is hardcoded and incomplete | Low | Resolved |
| [GEN-009](#gen-009) | Generic type parameter detection uses hardcoded name set | Low | Resolved |
| [GEN-011](#gen-011) | Global function/variable generation counts always report 0 | Low | Resolved |
| [GEN-013](#gen-013) | Build runner reports approximate class count (files × 10) | Low | Resolved |
| [GEN-017](#gen-017) | Missing barrel export silently downgrades to dynamic | Medium | Resolved |
| [GEN-019](#gen-019) | Barrel preference heuristic may pick wrong barrel for re-exports | Medium | Resolved |
| [GEN-020](#gen-020) | Global exclusions merge across modules — accidental cross-filtering | Medium | Resolved |
| [GEN-021](#gen-021) | Builder-defining packages unconditionally skipped for bridging | Low | Resolved |
| [GEN-025](#gen-025) | Record types with nested functions may have edge cases | Medium | Resolved |
| [GEN-026](#gen-026) | 14 concrete types across projects silently downgraded to dynamic | Medium | Resolved |
| [GEN-027](#gen-027) | InvalidType warnings indicate analyzer resolution failures | Medium | Resolved |
| [GEN-041](#gen-041) | Enhanced enum fields not accessible via bridges at runtime | Medium | Resolved |
| [GEN-042](#gen-042) | Classes with implicit default constructors are not bridged | Medium | Resolved |
| [GEN-044](#gen-044) | Enum `.values` static getter not bridged | Low | Resolved |
| [GEN-046](#gen-046) | GlobalsUserBridge overrides not applied at runtime | Medium | Resolved |
| [GEN-047](#gen-047) | Extension declarations not bridged | High | Resolved |
| [GEN-048](#gen-048) | Pure mixin declarations not bridged | Medium | Resolved |
| [GEN-049](#gen-049) | Extension methods on bridged classes not resolved | High | Resolved |
| [GEN-050](#gen-050) | Operator methods emit invalid syntax (`t.<`, `t.>`) | Medium | Resolved |
| [GEN-051](#gen-051) | Sealed class constructors incorrectly instantiated | Medium | Resolved |
| [GEN-015](#gen-015) | Nested public classes collected by syntactic visitor | Low | Resolved |
| [GEN-016](#gen-016) | Auxiliary imports may resolve wrong type on name collision | Medium | Resolved |
| [GEN-002](#gen-002) | Recursive type bounds dispatched to only 3 hardcoded types | Low | Resolved |
| [GEN-010](#gen-010) | Complex external packages list is hardcoded | Low | Resolved |
| [GEN-012](#gen-012) | Type parameter substitution uses fragile regex text replacement | Medium | Resolved |
| [GEN-045](#gen-045) | Barrel-level name collisions silently break bridging | Medium | Resolved |
| [GEN-024](#gen-024) | Four config sources with complex precedence rules | Medium | Resolved |

### Won't Fix

| ID | Description | Complexity | Reason |
|----|-------------|------------|--------|
| [GEN-001](#gen-001) | Generic methods lose type parameters (type erasure) | Fundamental | Dart limitation |
| [GEN-003](#gen-003) | Complex default values cannot be represented in generated code | Fundamental | Analyzer limitation |
| [GEN-004](#gen-004) | Combinatorial dispatch capped at 4 non-wrappable params | Medium | Performance tradeoff |
| [GEN-006](#gen-006) | Syntactic fallback loses all resolved type information | Fundamental | By design |
| [GEN-014](#gen-014) | Syntactic fallback: this.x params always typed as dynamic | Fundamental | By design |
| [GEN-018](#gen-018) | Parameterized typedef expansion may produce incorrect types | Medium | Syntactic fallback |

### TODO (sorted by relevance)

| ID | Description | Complexity | Relevance |
|----|-------------|------------|-----------|
| [GEN-005](#gen-005) | Function types inside collections are unbridgeable | High | Not Important |
| [GEN-022](#gen-022) | Main generator file is 8,490 lines — maintainability concern | High | Not Important |
| [GEN-023](#gen-023) | Duplicated visitor logic between resolved and syntactic paths | High | Not Important |

---

## Issue Details

### Fixed Issues

---

### GEN-028

**CLI didn't pass export filtering params to generator**

**a) Problem:**

The CLI code path in `d4rt_gen.dart` called `generateBridgesFromExports()` but did not forward four module config parameters:

**Before fix (d4rt_gen.dart — `_generateBridges()`):**
```dart
final result = await generator.generateBridgesFromExports(
  barrelFiles: module.barrelFiles,
  exportInfo: exportInfo,
  outputPath: module.outputPath,
  // Missing: followAllReExports, skipReExports, followReExports, excludeSourcePatterns
);
```

**After fix:**
```dart
final result = await generator.generateBridgesFromExports(
  barrelFiles: module.barrelFiles,
  exportInfo: exportInfo,
  outputPath: module.outputPath,
  followAllReExports: module.followAllReExports,
  skipReExports: module.skipReExports,
  followReExports: module.followReExports,
  excludeSourcePatterns: module.excludeSourcePatterns,
);
```

**Where the problem manifested:** Without these parameters, the generator defaulted to `followAllReExports: true`. For the dcli module (configured with `followAllReExports: false`, `skipReExports: [dcli_core, crypto]`), this meant the generator followed re-exports from `dcli_core` and `crypto` — pulling in hundreds of types from skipped packages. The generated bridge referenced types that weren't properly imported, causing dozens of compile errors.

**b) Location:**
`d4rt_gen.dart` ~line 764 — the `generateBridgesFromExports()` call in `_generateBridges()`.

**c) Resolution:**
Fixed 2026-02-07. All four parameters are now passed through from the module config.

---

---

### GEN-029

**CLI path missing export info filtering for globals**

**a) Problem:**

The generator has two code paths: `generateBridges()` (used by CLI) and `generateBridgesWithWriter()` (used by build_runner). The build_runner path correctly filters global functions, variables, and enums by barrel export `show`/`hide` clauses. The CLI path did not:

**Build_runner path (had filtering):**
```dart
// Checks if the function is actually exported from the barrel
if (exportInfo != null && !exportInfo.isNameExported(func.name)) continue;
```

**CLI path (was missing filtering):**
```dart
// Processed all globals without checking export visibility
for (final func in globalFunctions) {
  _generateGlobalFunctionBridge(buffer, func, ...);  // No export check!
}
```

**Where the problem manifested:** The CLI path generated bridges for functions that were not exported from the barrel file (e.g., internal helper functions visible in source but hidden via `show`/`hide` in the barrel). The generated bridge tried to reference these names through the barrel import prefix (`$pkg.helperFunc()`), but since they weren't exported, the Dart compiler couldn't find them — causing compile errors like `The function 'helperFunc' isn't defined`.

**b) Location:**
`bridge_generator.dart` ~line 1800–1830 — the globals processing loop in `generateBridges()`.

**c) Resolution:**
Fixed 2026-02-07. Added export info filtering for enums, functions, and variables in `generateBridges()`, matching the existing logic in `generateBridgesWithWriter()`.

---

---

### GEN-030

**Multi-barrel modules only registered under primary barrel**

**a) Problem:**

A module can have multiple barrel files. For example, the dcli module:

```yaml
# build.yaml
barrelFiles:
  - package:dcli/dcli.dart         # primary
  - package:dcli_core/dcli_core.dart  # secondary
barrelImport: package:dcli/dcli.dart   # primary barrel
```

**Before fix — generated dartscript.b.dart:**
```dart
static void register([D4rt? interpreter]) {
  final d4rt = interpreter ?? D4rt();
  TomD4rtDcliBridge.registerBridges(d4rt, 'package:dcli/dcli.dart');
  // ✗ Missing: 'package:dcli_core/dcli_core.dart' not registered
}
```

**Before fix — generated import block in bridge file:**
```dart
import 'package:dcli/dcli.dart' as $pkg;
// ✗ Missing: import 'package:dcli_core/dcli_core.dart' as $pkg2;
```

**After fix — generated dartscript.b.dart:**
```dart
static void register([D4rt? interpreter]) {
  final d4rt = interpreter ?? D4rt();
  TomD4rtDcliBridge.registerBridges(d4rt, 'package:dcli/dcli.dart');
  TomD4rtDcliBridge.registerBridges(d4rt, 'package:dcli_core/dcli_core.dart');
  // ✓ Both barrels registered
}
```

**After fix — generated import block:**
```dart
import 'package:dcli/dcli.dart' as $pkg;
import 'package:dcli_core/dcli_core.dart' as $pkg2;
// ✓ Both barrel imports present
```

**Where the problem manifested:** A D4rt script that imported the secondary barrel:
```dart
import 'package:dcli_core/dcli_core.dart';
```
…got a runtime `SourceCodeException: Module source not preloaded for URI: package:dcli_core/dcli_core.dart`. The bridges were only registered under `package:dcli/dcli.dart`, so the D4rt interpreter couldn't find them when looking up the secondary URI.

**b) Location:**
`file_generators.dart` ~line 107 — `generateDartscriptFileContent()` only used `barrelImport` (primary). `bridge_generator.dart` ~line 3870 — `getImportBlock()` only returned the primary barrel's import.

**c) Resolution:**
Fixed 2026-02-07. `dartscript.b.dart` now registers bridges under ALL barrel import paths, and `getImportBlock()` generates import statements for all barrel files.

---

---

### GEN-037

**Status:** Fixed  
**Complexity:** Medium  
**Title:** Generated bridge files don't consistently use .b.dart extension

**a) What exactly is the problem:**

The generator has inconsistent file naming:
- Default exclusion patterns expect `**/*.b.dart`, `**/*_bridges.b.dart`
- Test runner is generated as `d4rtrun.b.dart` ✓
- But bridge module files are generated as `user_guide_bridges.dart` (no `.b.` suffix)
- Barrel and dartscript files also lack `.b.` suffix

This creates confusion and makes it harder to identify generated files. The exclusion patterns suggest `.b.dart` was intended for ALL generated files but is only applied to test runners.

**Proposed solution:** ALL generated files should use `.b.dart` extension:
- Bridge modules: `user_guide_bridges.b.dart`
- Barrel: `d4rt_bridges.b.dart`
- Dartscript: `dartscript.b.dart`
- Test runner: `d4rtrun.b.dart`

The suffix must be **appended automatically** — if config says `"testRunnerPath": "bin/d4rtrun.b.dart"`, the generator should strip `.dart` and append `.b.dart`, resulting in `bin/d4rtrun.b.dart` (not `bin/d4rtrun.b.dart.b.dart`).

**b) Location:**
- `bin/d4rt_gen.dart` lines 813-830 — writes barrel/dartscript/testrunner without suffix logic
- `file_generators.dart` — all `generate*Content()` functions don't handle suffix
- Module `outputPath` is used directly without transformation

**c) Resolution:**
Fixed 2026-02-08. Added `ensureBDartExtension(String path)` helper in `file_generators.dart` that normalizes any path to `.b.dart`. Applied consistently across all four entry points:
- `bin/d4rt_gen.dart` — standalone CLI
- `lib/src/cli/d4rt_generator_cli.dart` — library CLI
- `lib/src/bridge_api.dart` — programmatic API (also added missing test runner generation)
- `lib/src/file_generators.dart` — content generators for barrel exports and dartscript/test runner imports

All generated files now use `.b.dart` extension regardless of what the config specifies.

---

---

### GEN-040

**Status:** Fixed  
**Complexity:** Low  
**Title:** Recursive bound error message references `_sample` instead of `sample`

**a) What exactly is the problem:**

The bridge generator's recursive bound type dispatch code emits an `ArgumentError` fallback message that references `_sample.runtimeType`. However, the local variable created in the generated code is named `sample` (without underscore), causing 3 compile errors in any bridge containing functions with recursive type bounds (e.g., `sortItems<T extends Comparable<T>>`).

Example of generated code with the bug:
```dart
final sample = positional[0];
// ... type checks ...
throw ArgumentError('sortItems: ... Got: ${_sample.runtimeType}');  // ERROR: _sample undefined
```

**b) Location:**
`lib/src/bridge_generator.dart` line 6366 — the fallback error string in `_generateRecursiveBoundDispatch()` used `\${_sample.runtimeType}` instead of `\${sample.runtimeType}`.

Also added `prefer_function_declarations_over_variables` to the `ignore_for_file` directive (line 3211) since generated callback wrapper lambdas trigger this lint.

**c) Resolution:**
Fixed the interpolation from `_sample` to `sample` in the generator source. Regenerated all affected bridge files. The `ignore_for_file` directive now includes `prefer_function_declarations_over_variables` for generated files.

---

---

### GEN-043

**Generated user bridge references lack import prefix ($pkg.)**

**Status: Fixed**

**a) Problem:**

When the generator detects a `D4UserBridge` subclass and wires its override methods into the generated bridge code, it emits bare class names like `Vector2DUserBridge.overrideOperatorPlus`. However, the barrel file is imported with a prefix (`as $pkg`), so the generated code should emit `$pkg.Vector2DUserBridge.overrideOperatorPlus`.

Without the prefix, the generated bridge file fails to compile with "Undefined name" errors for every user bridge reference.

**Example of broken generated code (before fix):**
```dart
import 'package:my_package/my_package.dart' as $pkg;

// ...
methods: {
  '+': Vector2DUserBridge.overrideOperatorPlus,  // ERROR: Undefined name
},
```

**Correct generated code (after fix):**
```dart
import 'package:my_package/my_package.dart' as $pkg;

// ...
methods: {
  '+': $pkg.Vector2DUserBridge.overrideOperatorPlus,  // OK
},
```

**Reproducing test:**
`test/d4rt_tester_test.dart` → `D4rtTester end-to-end` → `userbridge_user_guide` → `Vector2D and Matrix2x2 via user bridges`

**b) Location:**

`bridge_generator.dart` — 11 emission points in `_generateClassBridge()` and the global registration methods where `userBridge.userBridgeClassName` or `globalsUserBridge.userBridgeClassName` was interpolated without calling `_getPrefixedClassName()`.

**c) Fix applied:**

In `_generateClassBridge()`, compute `prefixedUserBridge` at the top of the method using the existing `_getPrefixedClassName(userBridge.userBridgeClassName, userBridge.sourceFile)` helper. Replace all 8 class-level bare references with `prefixedUserBridge`. For the 3 global-level references, compute the prefixed name inline using the same method.

---

---

### GEN-038

**Status:** Already Fixed (non-issue)  
**Complexity:** Low  
**Title:** Test runner fails on first duplicate instead of reporting all

**a) What exactly is the problem:**

This was believed to be an issue, but investigation revealed it was already solved.

The generated `_runInitEval()` function calls `d4rt.validateRegistrations(source: _initSource)` which uses `collectRegistrationErrors: true` mode internally. This collects ALL duplicate registration errors and returns them as a `List<String>` rather than throwing on the first one.

The `validateRegistrations()` method exists in `tom_d4rt/lib/src/d4rt_base.dart` at line 283.

**b) Location:**
`file_generators.dart` — `generateTestRunnerContent()` generates `_runInitEval()` which correctly calls `d4rt.validateRegistrations()` and iterates over all errors.

**c) Resolution:**
No changes needed. The implementation was already correct when the test runner feature was added.

---

---

### GEN-039

**Status:** Already Fixed (non-issue)  
**Complexity:** Low  
**Title:** Test runner config not supported in build.yaml

**a) What exactly is the problem:**

This was believed to be an issue, but investigation revealed it was already solved.

The `BuildConfigLoader.loadFromBuildYaml()` in `lib/src/build_config_loader.dart` correctly navigates the `build.yaml` structure (`targets.$default.builders.tom_d4rt_generator:d4rt_bridge_builder.options`) and passes all fields through `BridgeConfig.fromJson()`. This includes `generateTestRunner` and `testRunnerPath`.

Both the standalone CLI (`bin/d4rt_gen.dart`) and the library CLI (`lib/src/cli/d4rt_generator_cli.dart`) call `BuildConfigLoader.loadFromBuildYaml()` when processing a project directory, falling back to `d4rt_bridging.json` only if no build.yaml config is found.

**b) Location:**
`lib/src/build_config_loader.dart` — `loadFromBuildYaml()` correctly handles all `BridgeConfig` fields.

**c) Resolution:**
No changes needed. The build.yaml support was already fully implemented when the test runner config fields were added to `BridgeConfig`.

---

### Won't Fix Issues

---

### GEN-001

**Generic methods lose type parameters (type erasure)**

**a) Problem:**

When a Dart API defines a generic method like `T withFileProtection<T>(List<String> protected, T Function() action)`, the bridge generator cannot forward the type argument `T` from the D4rt interpreter to the host Dart call. This is because Dart's reified generics require the type argument at compile time, but the interpreter only knows it at runtime.

The generator detects type parameters during parsing:

```dart
// bridge_generator.dart — BridgedMethodInfo fields
final bool hasTypeParameters;
final Map<String, String?> methodTypeParameters; // e.g. {'T': 'Object', 'E': null}
```

When generating the bridge call, every occurrence of `T` is replaced with its bound (or `dynamic` if unbounded). The generated bridge always calls the host method with `<dynamic>`:

**Source Dart API (dcli):**
```dart
T withFileProtection<T>(List<String> protected, T Function() action, {String? workingDirectory});
```

**Generated bridge code (dcli_bridges.b.dart):**
```dart
'withFileProtection': (visitor, positional, named, typeArgs) {
  final protected = D4.getRequiredArg<List<String>>(positional, 0, 'protected', 'withFileProtection');
  final action = D4.getRequiredArg<dynamic Function()>(positional, 1, 'action', 'withFileProtection');
  //                                 ^^^^^^^ was T Function(), erased to dynamic
  final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
  return $pkg.withFileProtection<dynamic>(protected, action, workingDirectory: workingDirectory);
  //                             ^^^^^^^ type argument erased to <dynamic>
},
```

**Where the problem manifests:** The `typeArgs` parameter is received by the bridge callback but never used. A D4rt script calling `withFileProtection<int>(...)` will not pass `int` to the host — the host always runs `<dynamic>`. This means:
- Return types lose their generic precision (returns `dynamic` instead of `int`)
- Function parameters typed with `T` become `dynamic Function()` instead of `int Function()`
- Generic collection parameters like `List<T>` become `List<dynamic>`

This pattern appears across all generic functions: `runChecked<T>()`, `runCheckedSync<T>()`, `tomProtect<T>()`, `getFromCurrentZone<T>()`, etc.

**b) Location:**
`bridge_generator.dart` — fields on `BridgedMethodInfo` (~line 82–87); type erasure logic in `_generateMethodBody()` where `effectiveTypeParams` merges class and method type params; `_getTypeArgument()` where type parameter names are looked up and replaced with their bounds.

**c) Strategies:**
- **Won't Fix (fundamental):** Dart's reified generics require the type argument to be known at compile time at the call site. The interpreter dispatches at runtime and cannot synthesize a `Type` object that the host Dart VM accepts as a generic argument.
- **Mitigation:** For common cases, the generator already produces specialized overloads (e.g., `cast<int>`, `cast<String>`). Could extend the set of pre-specialized types via configuration.

---

---

### GEN-003

**Complex default values cannot be represented in generated code**

**a) Problem:**

Dart allows arbitrary compile-time constant expressions as default values. The bridge generator lives in a separate library and can only represent simple literals and public const references. When it encounters a default value it can't reproduce, it marks it as "non-wrappable" and uses combinatorial dispatch (see GEN-004) to generate variants that either include or omit that parameter.

The generator's `_prefixDefaultValue()` can handle:
- Literals: `null`, `true`, `false`, `42`, `'hello'`
- Empty collections: `const []`, `{}`
- Core constants: `const Duration(...)`, `double.infinity`
- Public enum/static access: `FetchMethod.get`, `Encoding.utf8`

It **cannot** handle:
- Private constants: `_defaultTimeout`
- Constructor calls from unexported types
- Complex const expressions: `const [1, 2, 3]`
- Function call defaults: `_generateId()`

**Source Dart API (dcli — `cat()`):**
```dart
void cat(String path, {Sink<List<int>> stdout = io.stdout});
//                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ complex default: io.stdout
```

**Generated bridge code (dcli_bridges.b.dart):**
```dart
'cat': (visitor, positional, named, typeArgs) {
  final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cat');
  if (!named.containsKey('stdout')) {
    $pkg.cat(path);           // ← variant 1: omit 'stdout', let Dart use its own default
    return null;
  }
  if (named.containsKey('stdout')) {
    final stdout = D4.getRequiredNamedArg<void Function(String)>(named, 'stdout', 'cat');
    $pkg.cat(path, stdout: stdout);  // ← variant 2: pass explicit 'stdout'
    return null;
  }
  throw StateError('Unreachable: all named parameter combinations should be covered');
},
```

**Where the problem manifests:** The generated code must check whether the D4rt script provided the parameter. If not, it calls the host method *without* that parameter so Dart applies its own default. This works but produces verbose code — and for methods with many non-wrappable defaults, the variants multiply exponentially (see GEN-004).

**b) Location:**
`bridge_generator.dart` — `_prefixDefaultValue()` for default value classification; `_isWrappableDefault()` for the wrappable check; `_generateCombinatorialDispatch()` for generating the 2^N if/else variants.

**c) Strategies:**
- **Won't Fix (fundamental):** Cross-library default value evaluation is not possible in Dart without code generation that imports the original library — but the bridge *is* that generated code, creating a circular problem for private defaults.
- **Mitigation:** Combinatorial dispatch (2^N variants) works for up to 4 params (see GEN-004). Could also generate a thin forwarding function in the source package that exposes defaults explicitly.

---

---

### GEN-004

**Combinatorial dispatch capped at 4 non-wrappable params**

**a) Problem:**

When a method has N named parameters with non-wrappable defaults (see GEN-003), the generator produces 2^N call variants. Each variant is an `if` block that checks which named parameters were provided by the script:

**Generator source (bridge_generator.dart):**
```dart
final useCombinatorial =
    nonWrappableDefaults.isNotEmpty && nonWrappableDefaults.length <= 4;
// ...
final count = unwrappableParams.length;
final limit = 1 << count;  // 2^N combinations
for (var i = 0; i < limit; i++) { /* generate if block for each combination */ }
```

At N=1: 2 variants (like the `cat()` example in GEN-003).
At N=2: 4 variants. At N=4: 16 variants. At N=5: 32 variants — too many.

**Where the problem manifests:** Methods with 5+ non-wrappable defaults get **no** combinatorial dispatch at all. The generator cannot produce a correct call because it can't reproduce the default values and can't enumerate all 32+ combinations. Such methods are either bridged with only the "all params present" variant (losing defaults), or skipped with a `// TODO` comment.

**b) Location:**
`bridge_generator.dart` — the `nonWrappableDefaults.length <= 4` guard; `_generateCombinatorialDispatch()` which generates the 2^N `if` blocks.

**c) Strategies:**
- **Won't Fix (trade-off):** Raising the limit causes massive generated code bloat. 2^8 = 256 variants for a single method is impractical.
- **Alternative:** Generate a single call variant that uses `Function.apply` with a `Map<Symbol, dynamic>` for named params. This avoids the combinatorial explosion but loses compile-time type safety in the generated code.

---

---

### GEN-006

**Syntactic fallback loses all resolved type information**

**a) Problem:**

The generator has two code paths: the **resolved path** (using the Dart analyzer's fully resolved AST) and the **syntactic fallback** (raw syntax tree parsing). When the analyzer cannot produce a resolved AST for a source file (e.g., missing dependencies, analysis errors), the generator falls back to `_ClassVisitor` which only sees the textual syntax.

**Resolved path** produces rich bridge code:
```dart
// Knows the import URI for SettingsYaml, resolves this.field types, expands typedefs
final config = D4.getRequiredArg<$pkg.SettingsYaml>(positional, 0, 'config', 'loadConfig');
```

**Syntactic fallback** produces degraded bridge code:
```dart
// Can't resolve SettingsYaml's import URI → falls back to dynamic
// Can't resolve this.fieldName types → uses dynamic
final config = D4.getRequiredArg<dynamic>(positional, 0, 'config', 'loadConfig');
```

**What is lost in the fallback:**
- Type import URIs (import prefixes can't be resolved → types become `dynamic`)
- Superclass/mixin type resolution (inherited methods not bridged)
- `this.x` and `super.x` parameter types (become `dynamic` — see GEN-014)
- Typedef expansion (alias names used instead of expanded `Function` signatures — see GEN-007)
- Inherited members (only declared members are visible)

**b) Location:**
`bridge_generator.dart` ~line 2600–2630 — fallback decision in `_processSourceFile()`; `_ClassVisitor` defined at ~line 8200+ (syntactic path); `_ResolvedClassVisitor` at ~line 7400+ (resolved path).

**c) Strategies:**
- **Won't Fix (fundamental for the fallback path):** The fallback exists because analysis failed. By definition, resolved type info is unavailable.
- **Mitigation:** Improve analyzer reliability by ensuring all dependencies are resolvable. Add a `--strict` flag that fails instead of falling back, so users know when quality is degraded.
- Log which files used the fallback so users can investigate and fix the underlying analysis issue.

---

---

### GEN-014

**Syntactic fallback: this.x params always typed as dynamic**

**a) Problem:**

In Dart constructors, `this.fieldName` is shorthand for assigning a parameter to a field. The type comes from the field declaration. In the syntactic fallback visitor (see GEN-006), the field's type is unknown because the AST isn't resolved:

**Source Dart API:**
```dart
class Server {
  final int port;
  final String host;
  Server(this.port, this.host);  // port is int, host is String
}
```

**Resolved path produces:**
```dart
final port = D4.getRequiredArg<int>(positional, 0, 'port', 'Server');
final host = D4.getRequiredArg<String>(positional, 1, 'host', 'Server');
```

**Syntactic fallback produces:**
```dart
final port = D4.getRequiredArg<dynamic>(positional, 0, 'port', 'Server');
final host = D4.getRequiredArg<dynamic>(positional, 1, 'host', 'Server');
```

**Where the problem manifests:** The bridge compiles fine but loses type safety at the parameter boundary. A D4rt script could pass a `String` for `port` and the bridge wouldn't catch it — the error would only surface deep inside the host Dart code. The resolved path handles this correctly by looking up the field's declared type via the `ClassElement`.

**b) Location:**
`bridge_generator.dart` ~line 8390–8400 — `_ClassVisitor._parseParameters()` for `FieldFormalParameter`.

**c) Strategies:**
- **Won't Fix (inherent to fallback):** Without a resolved AST, the field type is unknown. The syntactic visitor would need to find and parse the field declaration in the same class, which is fragile and incomplete for inherited fields.
- The resolved path handles this correctly, so the real mitigation is ensuring analysis succeeds.

---

### TODO Issues

---

### GEN-017

**Missing barrel export silently downgrades to dynamic**

**Status:** RESOLVED

**a) Problem:**

When a type used in a method signature isn't exported from the module's barrel file, the generator logs a warning and replaces the type with `dynamic`:

**Generator source (bridge_generator.dart):**
```dart
void _recordMissingExport(String context, String typeName) {
  final warning = 'Missing export: Type "$typeName" used in $context is not exported from barrel file';
  _missingExportWarnings.add(warning);
  if (verbose) print('WARNING: $warning');
}
// Then returns 'dynamic' as the type
```

**Source Dart API (tom_crypto package):**
```dart
AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> getRsaKeyPair(SecureRandom secureRandom);
```

**Generated bridge code (tom_crypto_bridges.b.dart):**
```dart
'getRsaKeyPair': (visitor, positional, named, typeArgs) {
  final secureRandom = D4.getRequiredArg<dynamic>(positional, 0, 'secureRandom', 'getRsaKeyPair');
  //                                     ^^^^^^^ was SecureRandom — not in barrel exports
  return ext_tom_crypto.getRsaKeyPair(secureRandom);
},
```

**Where the problem manifests:** The generated code compiles and the method is callable from D4rt, but:
1. **No type checking** at the bridge boundary — a script can pass any value, and the error surfaces deep in the host Dart code with an unhelpful cast error
2. **IDE autocompletion** in D4rt shows the parameter as `dynamic` instead of `SecureRandom`
3. **The warning is easily missed** in verbose generation output — users don't know their bridge has degraded type safety

This is the root mechanism behind GEN-026 (14 concrete types downgraded across projects).

**b) Location:**
`bridge_generator.dart` — `_recordMissingExport()` logs the warning; multiple call sites in `_getTypeArgument()` that return `'dynamic'` after recording the missing export.

**c) Strategies:**
- Add a `--strict-exports` flag that fails generation instead of falling back to `dynamic`.
- Generate a summary report at the end listing all dynamic fallbacks, grouped by affected class/method.
- In the generated bridge code, add a comment `/* was: OriginalType */` next to `dynamic` so the degradation is visible in code review.

---

---

### GEN-026

**14 concrete types across projects silently downgraded to dynamic**

**Status:** RESOLVED (same fix as GEN-017)

**a) Problem:**

This is GEN-017 in action across real projects. During generation, the following concrete types aren't found in barrel exports and get replaced with `dynamic`:

**tom_d4rt_dcli (dcli module):**
| Original Type | Used In | Bridge Result |
|---------------|---------|---------------|
| `Trace` | Stack trace methods | `dynamic` |
| `SettingsYaml` | Configuration methods | `dynamic` |
| `ColumnComparator` | Table formatting | `dynamic` |
| `CancelableLineAction` | Line action callbacks | `dynamic` |

**tom_dartscript_bridges (tom_crypto module):**
| Original Type | Used In | Bridge Result |
|---------------|---------|---------------|
| `RSAPublicKey` | `rsaEncrypt()`, `rsaVerify()` | `dynamic` |
| `RSAPrivateKey` | `rsaDecrypt()`, `rsaSign()` | `dynamic` |
| `SecureRandom` | `getRsaKeyPair()` | `dynamic` |
| `JWT`, `JWTKey`, `JWTAlgorithm` | JWT token operations | `dynamic` |
| `Argon2Parameters` | Password hashing config | `dynamic` |
| `Invocation` | Reflection | `dynamic` |
| `MdPdfConverterOptions` | Markdown-to-PDF conversion | `dynamic` |
| `LedgerData` | Distributed ledger | `dynamic` |

**Concrete example — RSA functions in generated bridge:**

Source Dart API:
```dart
Uint8List rsaEncrypt(RSAPublicKey myPublic, Uint8List dataToEncrypt);
Uint8List rsaDecrypt(RSAPrivateKey myPrivate, Uint8List cipherText);
```

Generated bridge (tom_crypto_bridges.b.dart):
```dart
'rsaEncrypt': (visitor, positional, named, typeArgs) {
  final myPublic = D4.getRequiredArg<dynamic>(positional, 0, 'myPublic', 'rsaEncrypt');
  //                                  ^^^^^^^ was RSAPublicKey (from pointycastle package)
  final dataToEncrypt = D4.getRequiredArg<dynamic>(positional, 1, 'dataToEncrypt', 'rsaEncrypt');
  return ext_tom_crypto.rsaEncrypt(myPublic, dataToEncrypt);
},
'rsaDecrypt': (visitor, positional, named, typeArgs) {
  final myPrivate = D4.getRequiredArg<dynamic>(positional, 0, 'myPrivate', 'rsaDecrypt');
  //                                   ^^^^^^^ was RSAPrivateKey (from pointycastle package)
  final cipherText = D4.getRequiredArg<dynamic>(positional, 1, 'cipherText', 'rsaDecrypt');
  return ext_tom_crypto.rsaDecrypt(myPrivate, cipherText);
},
```

**Where the problem manifests:** A D4rt script can pass any value for `myPublic` — the bridge won't catch the type error until `ext_tom_crypto.rsaEncrypt()` tries to use the value internally, producing an unhelpful cast error deep in the host code.

**b) Location:**
These are runtime warnings from the generator. Each triggers `_recordMissingExport()` (see GEN-017) because the types come from packages (`pointycastle`, `dart_jsonwebtoken`, `tom_basics`, `tom_dist_ledger`) that aren't included in the respective module's `barrelFiles`.

**c) General Strategy — same as GEN-017 (Resolved-Type Import Propagation):**

This is GEN-017 manifested across real projects. All 14 types would be automatically resolved by the GEN-017 fix: since the resolved analyzer already knows these types and their source URIs, carrying that information through to code generation would auto-generate the correct auxiliary imports without any barrel configuration changes.

No per-type or per-package manual configuration needed.

---

---

### GEN-041

**Status:** RESOLVED  
**Complexity:** Medium  
**Title:** Enhanced enum fields not accessible via bridges at runtime

**a) What exactly is the problem:**

When a Dart enum has custom fields (an "enhanced enum"), the bridge generator creates `BridgedEnumValue` entries for each constant but does not bridge the custom field getters. At runtime in D4rt, accessing an enhanced enum's field (e.g., `Priority.high.value`) throws:

```
Runtime Error: Property "value" not found on enum value Priority.high
```

The standard enum properties (`name`, `index`) work because `BridgedEnumValue` in `tom_d4rt` provides them by default. But user-defined fields on enhanced enums require explicit getter bridges, which the generator does not currently produce.

**Source Dart API (example_project — `enum_classes.dart`):**
```dart
enum Priority implements Comparable<Priority> {
  low(1), medium(2), high(3), critical(4);
  final int value;
  const Priority(this.value);
  // ...
}
```

**D4rt script that fails:**
```dart
print('Priority value: ${Priority.high.value}'); // Runtime Error
```

The `name` and `index` properties work fine because they are built-in to `BridgedEnumValue`, but custom fields like `value` are not bridged.

**Reproducing test:**
`test/d4rt_tester_test.dart` → `D4rtTester end-to-end` → `example_project` → `basic classes, constructors, enums`  
Test script: `example/example_project/test/d4rt_test_basics.dart` (line accessing `Priority.high.value`)

**b) Location:**
The bridge generator's enum handling is in `bridge_generator.dart`. The enum bridge generation creates `BridgedEnumValue` entries for each constant but doesn't emit getter bridges for custom fields defined on the enum class. The runtime `BridgedEnumValue.get()` in `tom_d4rt/src/bridge/bridged_enum.dart` only handles `name` and `index`, throwing for any other property.

**c) General Strategy — Use `EnumElement` API for full enum introspection:**

The current enum visitor (L7152) uses AST-level `EnumDeclaration` and only collects constant names. The Dart analyzer's `EnumElement` (available via `node.declaredElement`) provides full introspection: fields, methods, constructors, and implemented interfaces.

**Fix:**
1. In `_ResolvedClassVisitor.visitEnumDeclaration()`, obtain `EnumElement` via `node.declaredElement`.
2. Iterate `enumElement.fields` — for each non-synthetic, non-private field (excluding `index`, `values`, built-in ones), record it as a bridgeable getter.
3. Iterate `enumElement.methods` — for each non-synthetic, non-private method, record it as a bridgeable method.
4. Extend the enum code generation (L3454) to emit property getter and method bridges per enum value, using a `getters:` and `methods:` map in `BridgedEnumDefinition`.
5. In `BridgedEnumValue.get()` (in tom_d4rt), look up custom field accessors from the definition before throwing.

This is fully general — any enhanced enum's fields and methods are auto-discovered from the analyzer, no hardcoding needed.

---

---

### GEN-042

**Status:** RESOLVED  
**Complexity:** Medium  
**Title:** Classes with implicit default constructors are not bridged

**a) What exactly is the problem:**

When a Dart class has no explicit constructor declaration, Dart provides an implicit default no-argument constructor. The bridge generator does not detect or bridge this implicit constructor. At runtime in D4rt, attempting to instantiate such a class throws:

```
Runtime Error: 'Person' is not callable (no default constructor bridge found).
```

**Source Dart API (dart_overview — `run_declarations.dart`):**
```dart
class Person {
  String name = '';
  int age = 0;
  void greet() { print('Hello, I am $name!'); }
}
// No explicit constructor — Dart provides Person() implicitly
```

**D4rt script that fails:**
```dart
var person = Person();  // Runtime Error: not callable
person.name = 'Alice';
```

Classes with explicit constructors (e.g., `Dog(this.name, this.age)`) work correctly. The issue is limited to classes that rely on Dart's implicit default constructor.

Similarly, the `Calculator` class in `dart_overview/classes/declarations/` has no explicit constructor, only methods:
```dart
class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  // ...
}
```

**Reproducing test:**
`test/d4rt_tester_test.dart` → `D4rtTester end-to-end` → `dart_overview` → `declarations, enums, generic classes`  
Test script: `example/dart_overview/test/d4rt_test_overview.dart` (line `var person = Person()`)

**b) Location:**
The bridge generator's constructor detection logic in `bridge_generator.dart`. When iterating class members to find constructors, it only emits a constructor bridge when it finds an explicit `ConstructorDeclaration` in the source. If none exists, no constructor bridge is generated, and the class becomes non-instantiable from D4rt.

**c) General Strategy — Use `ClassElement.constructors` instead of AST-only detection:**

Both visitors currently detect constructors by scanning AST `ConstructorDeclaration` nodes (L7330, L8283). This misses implicit constructors since they have no AST node.

**Fix:** In `_ResolvedClassVisitor.visitClassDeclaration()`, after the AST scan finds zero constructors, check `classElement.constructors` (from `node.declaredElement`). If `classElement.unnamedConstructor?.isSynthetic == true` (implicit default), synthesize a constructor bridge entry with zero parameters that calls the Dart default constructor:

```dart
if (constructors.isEmpty) {
  final classElement = node.declaredElement;
  if (classElement?.unnamedConstructor?.isSynthetic == true) {
    constructors.add(ConstructorInfo(name: '', params: [], isConst: false, isFactory: false));
  }
}
```

This is fully general — works for any class with an implicit default constructor without any hardcoding. The syntactic visitor (`_ClassVisitor`) should apply the same check for consistency, though it may not have access to `ClassElement` — in that case, assume a default constructor exists when none is found in the AST (safe heuristic since Dart always provides one).

---

---

### GEN-044

**Enum `.values` static getter not bridged**

**Status: RESOLVED**

**a) Problem:**

Dart enums have a built-in static getter `.values` that returns a `List` of all enum members. The bridge generator does not generate a bridge for this static getter, so accessing `EnumType.values` from D4rt fails at runtime with:

```
Undefined enum value 'values' on bridged enum 'Day'
```

This prevents iterating over enum values, checking `length`, or using common enum patterns like `Day.values[index]` or `Day.values.where(...)` from within D4rt scripts.

**Example:**
```dart
// Works in native Dart:
print(Day.values.length); // 7
print(Day.values[0]);     // Day.monday

// Fails in D4rt:
Day.values.length  // → Undefined enum value 'values' on bridged enum 'Day'
```

**Reproducing test:**
`test/d4rt_coverage_test.dart` → `TOP08: simple enum` — fails with the above error because the script accesses `Day.values.length`.

**b) Location:**

The enum bridge generation logic in `bridge_generator.dart`. When generating an enum bridge, the generator emits individual named values (e.g., `Day.monday`, `Day.tuesday`) but does not synthesize a `.values` static getter that returns the complete list.

**c) General Strategy — Unconditionally emit `.values` for all enums:**

Since `.values` is a built-in static getter on **every** Dart enum, this requires no detection — just unconditionally emit it in the enum code generation (L3454–L3507).

**Fix:** In the enum bridge generation loop, add `values` as a static member that returns `EnumType.values`. In the runtime `BridgedEnumDefinition`, handle `values` lookup to return the host Dart `List<EnumType>`.

This pairs naturally with the GEN-041 fix (enhanced enum introspection via `EnumElement`), since both modify the same generation and runtime code paths. Implement together as a single "complete enum bridging" change.

---

---

### GEN-002

**Recursive type bounds dispatched to only 3 hardcoded types**

**Status: RESOLVED in v1.5.2**

**Fix applied:**
1. Expanded `_defaultRecursiveBoundTypes` to include `Duration` and `BigInt` (both implement `Comparable<T>` where T is themselves)
2. Added `recursiveBoundTypes` field to `BridgeConfig` for user configuration via `buildkit.yaml`
3. Modified `BridgeGenerator` constructor to merge configured types with defaults (configured types take precedence, then defaults added)

**Configuration example (buildkit.yaml):**
```yaml
d4rtgen:
  recursiveBoundTypes:
    - MyCustomComparable
    - package:my_pkg/types.dart:AnotherComparable
```

The effective list is: `configuredTypes ∪ defaultTypes` where defaults are now `['num', 'String', 'DateTime', 'Duration', 'BigInt']`.

**Original issue:**

When a method has a type parameter with a recursive bound like `T extends Comparable<T>`, the generator cannot use `<dynamic>` (since `dynamic` doesn't implement `Comparable<dynamic>`). Instead, it generates concrete dispatch variants that test the runtime type and call the method with the matching type argument. Previously only 3 types were dispatched by default (num, String, DateTime), causing `ArgumentError` at runtime for Duration, BigInt, etc.

---

---

### GEN-012

**Type parameter substitution uses fragile regex text replacement**

**Status:** RESOLVED in v1.5.2

**Resolution:** Replaced regex-based text replacement with structural type reconstruction for `FunctionType`. The fix uses `type.formalParameters` to iterate over all parameters, recursively substituting each parameter's type via the existing `_substituteTypeParameters()` method, then reconstructs the function signature string. This handles:
- Required, optional positional, and named parameters
- Required-named parameter marking
- Nullable types in return and parameter positions
- Nested function types (via recursion)

**a) Problem (original):

When substituting type parameters in function types (e.g., replacing `T` with `int` in `T Function(T)`), the generator uses two approaches:

**Generator source (bridge_generator.dart — `_substituteTypeParameters()`):**
```dart
// For InterfaceType and TypeParameterType: proper structural substitution
if (type is TypeParameterType) {
  return substitution[name]!.getDisplayString();  // ✓ correct
}
if (type is InterfaceType) {
  // Recursively substitutes type arguments  // ✓ correct
}

// For FunctionType: falls back to regex text replacement
if (type is FunctionType) {
  var display = type.getDisplayString();
  for (final entry in substitution.entries) {
    display = display.replaceAll(
      RegExp(r'\b' + entry.key + r'\b'),  // ✗ fragile
      entry.value.getDisplayString(),
    );
  }
  return display;
}
```

**Example of potential failure:**
- Type parameter: `T`
- Function type display string: `DateTime Function(T, DateTime)`
- Regex `\bT\b` matches `T` correctly here…
- But with a type parameter named `E`: `Set<E> Function(E)` — regex `\bE\b` would also match the `E` in `Set<E>`, which is fine, but could fail with edge cases in complex nested types.

**Where the problem manifests:** For `InterfaceType` and `TypeParameterType`, substitution is structural and correct. Only `FunctionType` uses the fragile regex path. The comment in the source says *"not perfect but handles most cases"*. Failures would produce incorrect type strings in the generated bridge code (wrong types, corrupted signatures).

**b) Location:**
`bridge_generator.dart` — `_substituteTypeParameters()` method; the `FunctionType` branch with `RegExp(r'\b' + entry.key + r'\b')`.

**c) General Strategy — Use the analyzer's `TypeSystem.instantiate()` / structural walk:**

The method at L7685 already handles `TypeParameterType` and `InterfaceType` structurally — only `FunctionType` falls back to regex. The fix is to extend the structural approach to `FunctionType`.

**Fix:** In `_substituteTypeParameters()`, for the `FunctionType` branch:
1. Recursively substitute the `returnType` (already handled for other type kinds).
2. Iterate `type.parameters` — for each, recursively substitute its `type`.
3. Reconstruct the function type string from the substituted parts: `"${substitutedReturn} Function(${substitutedParams.join(', ')})"`.

Alternatively, use the Dart analyzer's `Substitution.fromPairs()` from `package:analyzer/dart/element/type_algebra.dart` which performs structural substitution on any `DartType` including `FunctionType`. This is the canonical way and handles all edge cases (nested functions, named params, optional params) correctly.

No hardcoding involved — purely structural type manipulation.

---

---

### GEN-016

**Auxiliary imports may resolve wrong type on name collision**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Addressed by GEN-017's Resolved-Type Import Propagation. The `_globalTypeToUri` registry now captures authoritative type→URI mappings from the analyzer. When generating imports, the code looks up the type in this registry to get the correct package URI, eliminating name-based ambiguity. The syntactic fallback path still uses first-match heuristic, which is acceptable for that limited path.

**a) Problem:**

When a type isn't found in the module's barrel exports, the generator falls back to "auxiliary imports" — it looks at the source file's own import statements to find the type. If two packages export a type with the same name, the first match wins:

**Source Dart API (file has two imports):**
```dart
import 'package:http/http.dart';  // exports Response
import 'package:dio/dio.dart';     // also exports Response
```

**Method signature:** `Response sendRequest(...)` — which `Response` should the bridge import?

**What happens:** The auxiliary import resolver picks whichever import it finds first. If it picks `package:dio`, but the method actually uses `package:http`'s `Response`, the generated bridge has a type mismatch that may or may not compile (depending on whether the types have compatible interfaces).

**Where the problem manifests:** In the generated bridge import block, the wrong package would appear:
```dart
import 'package:dio/dio.dart' as ext_dio;  // Wrong! Should be package:http
```
This could cause compile errors (if the types are incompatible) or silent type mismatches (if they happen to have similar APIs).

**b) Location:**
`bridge_generator.dart` ~line 3040–3100 — auxiliary import resolution in `_resolveAuxiliaryType()`.

**c) General Strategy — Use resolved `DartType` source URI for authoritative resolution:**

The ambiguity only exists because auxiliary import resolution works by matching **type names** against **import URIs** from the source file. But the resolved analyzer already knows exactly which `DartType` the method uses — including its defining library URI.

**Fix:** Same mechanism as GEN-017 (Resolved-Type Import Propagation). When the resolved visitor collects parameter types, record the authoritative `element.library.identifier` URI for each type. In code generation, use this URI directly to determine the import prefix — no name-based matching needed, no ambiguity possible.

If the resolved data isn't available (syntactic fallback), warn about the ambiguity and pick the first match (current behavior) — this is acceptable for the fallback path.

---

---

### GEN-018

**Parameterized typedef expansion may produce incorrect types**

**Status:** Won't Fix (syntactic fallback limitation)

**Resolution:** The resolved path correctly handles parameterized typedefs because the analyzer provides fully-instantiated `FunctionType` with all type arguments applied. The syntactic fallback path cannot fully resolve parameterized typedefs without type information from the analyzer — this is inherent to the syntactic approach. Users should ensure their project uses the resolved path (default) for correct typedef handling.

**a) Problem:**

When a typedef not exported from the barrel is used in a method signature, the generator tries to expand it to its underlying type. Simple typedefs work:

```dart
typedef VoidCallback = void Function();
// → expanded correctly to: void Function()
```

But parameterized typedefs require substituting type arguments:

**Source Dart API:**
```dart
typedef Converter<S, T> = T Function(S input);
void transform(Converter<String, int> converter);
// Should expand to: void transform(int Function(String input) converter)
```

**What can go wrong:** If `_expandTypedef()` doesn't properly apply the type arguments `<String, int>` to `S` and `T`, the expanded type could be `dynamic Function(dynamic input)` or even `T Function(S input)` (leaving unsubstituted parameters).

**Where the problem manifests:** The generated bridge would have the wrong function signature:
```dart
// Incorrect expansion:
final converter = D4.getRequiredArg<dynamic Function(dynamic)>(positional, 0, ...);
// Correct expansion:
final converter = D4.getRequiredArg<int Function(String)>(positional, 0, ...);
```
The incorrect version compiles but loses type safety. The resolved path doesn't have this issue because the analyzer already provides the fully-resolved `FunctionType` with applied type arguments.

**b) Location:**
`bridge_generator.dart` ~line 5830–5910 — typedef expansion in `_expandTypedef()`.

**c) General Strategy — Rely on resolved `FunctionType` from analyzer (already correct):**

The resolved path already gets the fully-instantiated `FunctionType` from the analyzer with all type arguments applied. The issue only occurs in manual expansion for the syntactic path.

**Fix:** Ensure the resolved visitor's typedef expansion (L7057 `_expandFunctionType()`) passes the fully-resolved `FunctionType` to code generation, rather than reconstructing the expansion from the typedef's raw definition. The resolved `FunctionType.parameters` and `FunctionType.returnType` already have `<String, int>` substituted for `<S, T>` — no manual substitution needed.

For the syntactic fallback: the existing manual expansion is inherently limited. Rather than improving it, mark the syntactic path's typedef handling as best-effort and document that correct typedef expansion requires the resolved path.

Add test cases for parameterized typedef expansion to verify.

**Decision:** This issue will remain open — the syntactic fallback path cannot fully resolve parameterized typedefs without type information from the analyzer.

---

---

### GEN-020

**Global exclusions merge across modules — accidental cross-filtering**

**a) Problem:**

Exclusion patterns from all modules are merged into global sets before generation begins:

**Generator source (per_package_orchestrator.dart — `collectPackageInfo()`):**
```dart
final Set<String> _globalExcludeClasses = {};
// ...
for (final module in config.modules) {
  _globalExcludeClasses.addAll(module.excludeClasses);
  _globalExcludeFunctions.addAll(module.excludeFunctions);
  _globalExcludeVariables.addAll(module.excludeVariables);
  _globalExcludeSourcePatterns.addAll(module.excludeSourcePatterns);
}
```

These global sets are then applied to **every** package:
```dart
final result = await generator.generateBridgesWithWriter(
  excludeClasses: _globalExcludeClasses.toList(),  // all modules' exclusions!
  excludeFunctions: _globalExcludeFunctions.toList(),
  // ...
);
```

**Example scenario:**
```yaml
# Module A: dcli
excludeClasses: ['*Exception', '*Error']

# Module B: tom_basics
# No exclusions — but wants its exception classes bridged
```

**Where the problem manifests:** Module A excludes `*Exception` for dcli, but after merging, the `*Exception` pattern also excludes `TomValidationException`, `ConfigException`, etc. from Module B's tom_basics package. Classes silently disappear from the generated bridge with no warning.

**b) Location:**
`per_package_orchestrator.dart` — `_globalExcludeClasses` and related fields; `collectPackageInfo()` merge loop; application via `generateBridgesWithWriter()` calls.

**c) General Strategy — Scope exclusions to their declaring module:**

The fix is straightforward: stop merging into global sets. Instead, pass each module's exclusions only to the packages belonging to that module.

**Fix:** In `per_package_orchestrator.dart`, replace the global exclusion sets (L103–106) with a `Map<String, ModuleExclusions>` keyed by module name. In the per-package generation loop (L404), look up the exclusions for the module that owns the current package, not the global union.

```dart
// Before: global merge
_globalExcludeClasses.addAll(module.excludeClasses);

// After: per-module storage
_moduleExclusions[module.name] = ModuleExclusions(
  classes: module.excludeClasses,
  functions: module.excludeFunctions,
  variables: module.excludeVariables,
  sourcePatterns: module.excludeSourcePatterns,
);
```

No hardcoding involved — purely structural change to the exclusion scoping logic.

**d) Resolution:**

**Status:** RESOLVED in v1.5.2

Added per-module exclusion storage in `per_package_orchestrator.dart`:
- Replaced `_globalExcludeClasses`, `_globalExcludeFunctions`, `_globalExcludeVariables`, `_globalExcludeSourcePatterns` global sets with `Map<String, _ModuleExclusions> _moduleExclusions`
- In `collectPackageInfo()`: Store each module's exclusions separately keyed by module name
- Added `_getExclusionsForPackage(packageName)` helper that finds all modules that include the package and returns their merged exclusions
- In `generatePerPackageFiles()`: Call `_getExclusionsForPackage()` to get only relevant exclusions for each package

Now exclusions are scoped correctly — excluding `*Exception` in the dcli module no longer affects tom_basics exception classes.

---

---

### GEN-025

**Record types with nested functions may have edge cases**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Enhanced `_resolveRecordTypeWithPrefixes()` to handle:
- Named field groups: `({int x, String y})` - detects `{...}` wrapper and processes correctly
- Mixed positional/named fields: `(int, {String name})` - tracks brace depth during parsing
- Function types in record fields - delegated to `_getTypeArgument()` which handles them
- Added `_resolveRecordNamedFields()` helper for processing named field groups

**a) Problem:**

Dart 3 record type support (`(int, String)`, `({int x, String y})`) was added recently to the generator. Simple records work:

```dart
(int, String) getResult();  // → bridge returns (int, String) correctly
```

But records containing function types as fields are more complex:

```dart
(int, void Function()) getCallback();  // Record with function field
((int, String), bool) getNested();     // Nested records
```

**Where the problem manifests:** The record type resolution in `_resolveRecordType()` is newer and less tested than the main type resolution path. Edge cases like:
- Function types as positional record fields: `(void Function(), int)`
- Named record fields with function types: `({void Function() callback, int count})`
- Deeply nested records: `((int, (String, bool)), double)`
- Record type aliases: `typedef Pair<T> = (T, T)`

…may produce incorrect bridge code or fall back to `dynamic` for the entire record.

**b) Location:**
`bridge_generator.dart` ~line 6130–6200 — record type handling in `_resolveRecordType()`.

**c) General Strategy — Structural recursion through record type fields:**

The record type handler (`_resolveRecordType()` at ~L6130) should delegate to the same type resolution pipeline for each field. This means function-type fields in records automatically get the same wrapping/resolution as standalone function-type parameters.

**Fix:** In `_resolveRecordType()`, for each positional and named field:
1. Call `_resolveTypeArgument()` on the field's type string (already done for simple types).
2. If the field type is a `FunctionType`, apply the same function-wrapping logic used for regular parameters.
3. For nested records `(int, (String, bool))`, recurse — `_resolveRecordType()` should call itself for inner record fields.

Add comprehensive test cases for: function-type fields, nested records, named record fields with function types, and record type aliases.

No hardcoding — relies on the existing type resolution pipeline being applied recursively.

---

---

### GEN-027

**InvalidType warnings indicate analyzer resolution failures**

**Status:** RESOLVED (v1.5.2) - remains open as inherent analyzer limitation

**Resolution:** Added explicit `InvalidType` handling in `_collectInfoFromDartType()`. When the analyzer returns `InvalidType`, the generator now:
1. Detects it explicitly with `if (dartType is InvalidType)`
2. Returns early without attempting to access `.element` or other properties
3. The type falls back to `dynamic` in generated code (acceptable behavior)

The underlying cause (missing dependencies, circular imports, analyzer bugs) cannot be fixed by the generator - this is an inherent limitation.

**a) Problem:**

Different from GEN-017 (type exists but isn't in barrel exports), `InvalidType` means the Dart analyzer itself could not determine what the type is. This happens when:
- A dependency hasn't had `dart pub get` run
- A source file has circular imports the analyzer can't resolve
- An analyzer bug mishandles a specific type pattern

**What the generator sees:**
```
WARNING: Parameter 'config' in method 'initialize' has InvalidType — using dynamic
```

The analyzer returns a special `InvalidType` sentinel instead of a resolved `DartType`. The generator has no choice but to use `dynamic`.

**How it differs from GEN-017:**
- GEN-017: Analyzer resolves the type correctly (e.g., `RSAPublicKey`), but it's not in barrel exports → `dynamic`
- GEN-027: Analyzer cannot resolve the type at all → `InvalidType` → `dynamic`

**Where the problem manifests:** Same as GEN-017 — the generated bridge has `dynamic` instead of the correct type. But the fix is different: instead of adding barrel exports, you need to fix the underlying analysis failure (missing dependency, circular import, etc.).

**b) Location:**
Appears at generation runtime. The generator encounters `InvalidType` from the analyzer's resolved AST and logs a warning.

**c) General Strategy — Fall back to dynamic with improved diagnostics:**

`InvalidType` is an analyzer sentinel meaning "I couldn't resolve this." The generator cannot fix analyzer failures — falling back to `dynamic` is the only option.

**Decision:** Accept `dynamic` fallback for `InvalidType`. Improve diagnostics to help users fix the root cause:
1. **Actionable diagnostics:** When `InvalidType` is encountered, log the specific file, line, and parameter along with the analysis errors for that compilation unit (available via `result.errors`). This gives the user enough context to fix the root cause.
2. **Pre-validation:** Before generation, run a quick analysis health check. If `dart pub get` hasn't been run or dependencies are missing, fail early with a clear message.

This issue will remain open — it's an inherent limitation of depending on the analyzer.

---

---

### GEN-045

**Barrel-level name collisions silently break bridging**

**Status:** RESOLVED in v1.5.2

**Resolution:** Implemented explicit collision detection and warning for classes, enums, functions, and variables. When the generator detects duplicate names from different source files:
1. Keeps the first occurrence and skips subsequent duplicates
2. Emits a detailed warning identifying both source files
3. Suggests using `excludeClasses`/`excludeEnums`/etc. or barrel `show`/`hide` clauses

Example warning output:
```
⚠️  NAME COLLISION: Class "Animal" is defined in multiple source files:
    1. package:dart_overview/mixins/basics/run_basics.dart (kept)
    2. package:dart_overview/classes/inheritance/run_inheritance.dart (skipped)
    Consider excluding one with excludeClasses, or using show/hide in barrel exports.
```

**Future enhancement:** Source-file-level import aliasing (per-source imports with unique prefixes) to bridge both colliding types rather than skipping one. This is not yet implemented.

**a) Problem (original):

When a barrel file exports two different classes with the same name from different source files, the Dart compiler raises a conflict error. This prevents the barrel from being used at all, and the types in conflict must be manually excluded.

In the `dart_overview` example project, both `classes/inheritance/run_inheritance.dart` and `mixins/basics/run_basics.dart` define a class named `Animal`:

```dart
// classes/inheritance/run_inheritance.dart
class Animal {
  final String name;
  Animal(this.name);
  void eat() { ... }
  String speak() { return 'Some sound'; }
}

// mixins/basics/run_basics.dart
abstract class Animal {
  String get name;
  void move();
}
```

Exporting both through the barrel file produces a compile error. The workaround was to exclude `Bird`, `Eagle`, `Penguin`, `Flying`, and `Walking` from the barrel (since they all depend on the mixins `Animal`), losing test coverage for:
- Constrained mixins (`mixin Flying on Animal`)
- `on` clause in mixin declarations
- Multi-mixin concrete classes (`Eagle extends Bird with Flying`)

**Reproducing test:**
No test currently exists — the types were excluded from the barrel to avoid the compile error. Adding them back causes `dart analyze` to fail on the barrel.

**b) Location:**

This is a barrel design limitation rather than a generator bug per se. The generator processes whatever the barrel exports. However, the generator could help by:
1. Detecting name collisions during config loading / barrel scanning.
2. Supporting `show`/`hide` prefixes or import aliases to disambiguate.

**c) General Strategy — Source-file-level import aliasing in generated bridges:**

The barrel collision happens because the barrel re-exports both types under the same name. But the generated bridge doesn't have to import via the barrel — it can import from the source files directly with unique prefixes.

**Fix:**
1. **Detection:** During barrel scanning, when the export map encounters a duplicate name from a different source file, flag the collision instead of silently picking one.
2. **Per-source imports:** For colliding types, generate imports from the **source files** rather than the barrel: `import 'package:dart_overview/src/inheritance.dart' as $src_inh;` and `import 'package:dart_overview/src/mixins.dart' as $src_mix;`. Bridge one as `$src_inh.Animal` and the other as `$src_mix.Animal`.
3. **D4rt namespace mapping:** In the D4rt runtime, register the colliding types under qualified names (e.g., `inheritance.Animal` and `mixins.Animal`) so scripts can disambiguate. The unqualified `Animal` could map to whichever the user specifies in config, or the generator could prompt the user.

The source-file URI is already available from `_ResolvedClassVisitor._collectTypeInfo()` — this is a natural extension of the existing import management (`_getOrCreateAuxiliaryPrefix()` at L2978).

No hardcoding — automatically handles any name collision by falling back to source-level imports.

---

---

### GEN-046

**GlobalsUserBridge overrides not applied at runtime**

**Status: TODO**

**a) Problem:**

When a user bridge class provides overrides for global variables and global functions (using the `overrideGlobalVariable{Name}` and `overrideGlobalFunction{Name}` naming convention), these overrides are not applied at runtime. The original (non-overridden) values are returned instead.

In the `userbridge_override` example project, `GlobalsUserBridge` defines overrides:

```dart
class GlobalsUserBridge extends D4UserBridge {
  String? get overrideGlobalVariableAppName => 'OverriddenApp';
  int? get overrideGlobalVariableMaxRetries => 10;
  Function? get overrideGlobalFunctionGreet =>
      (String name) => 'Custom greeting for $name!';
  Function? get overrideGlobalFunctionCalculate =>
      (int a, int b) => a * b + 100;
}
```

Expected behavior: D4rt scripts accessing `appName` should get `'OverriddenApp'` (not `'DefaultApp'`), `maxRetries` should be `10` (not `3`), etc.

Actual behavior: The original values are returned — `appName` is still `'DefaultApp'`, `maxRetries` is still `3`, and the original function implementations are called.

The existing `d4rt_test_overrides.dart` test did not catch this because it only prints values without asserting on the overridden results.

**Reproducing test:** `example/userbridge_override/test/ubr03_field_override.dart`

**b) Location:**

The issue is likely in the bridge runtime's user bridge resolution for globals. The class-level user bridge mechanism works (Vector2D, Matrix2x2, MyList overrides all apply correctly), but the globals user bridge mechanism does not wire up the `overrideGlobalVariable*` / `overrideGlobalFunction*` getters to the global accessor bridges.

Possible locations:
- Global bridge generation in the main generator (how globals bridges are emitted)
- User bridge scanner (may not scan for global overrides)
- Bridge runtime initialization (may not register global user bridge overrides)

**c) General Strategy — Mirror class-level user bridge wiring for globals:**

The class-level user bridge mechanism already works. The pattern is: the generated init code checks if a user bridge provides an override getter, and if so, uses the override instead of the default.

**Fix:**
1. **Investigation:** Compare the class-level bridge init code (where `Vector2DUserBridge.overrideMethodXxx` replaces the generated bridge) with the globals bridge init code. The globals init likely doesn't check for `overrideGlobalVariable*`/`overrideGlobalFunction*` getters at all.
2. **Generator change:** In the globals bridge generation, emit the same override-check pattern used for class bridges: `final getter = globalsUserBridge?.overrideGlobalVariableAppName; if (getter != null) { use getter } else { use default }`.
3. **Validation:** The `ubr03_field_override.dart` test script will automatically verify the fix.

No hardcoding — the same reflection-based override pattern used for classes is applied to globals.

**d) Resolution:**

**Status:** RESOLVED in v1.5.2

Investigation found the generator already correctly implements globals override detection and wiring. The issue was in the example project `userbridge_override`:

1. **Missing annotations**: `GlobalsUserBridge` lacked `@D4rtGlobalsUserBridge` annotation, `MyListUserBridge` lacked `@D4rtUserBridge` annotation
2. **Wrong library path**: Annotations must reference the source file path (e.g., `package:userbridge_override_example/src/globals.dart`), not the barrel
3. **Wrong method signatures**: `MyListUserBridge` operator overrides had incorrect parameter types

**Fixes applied:**
- Added `@D4rtGlobalsUserBridge('package:userbridge_override_example/src/globals.dart')` to `GlobalsUserBridge`
- Added `@D4rtUserBridge('package:userbridge_override_example/src/my_list.dart', 'MyList')` to `MyListUserBridge`
- Fixed operator override signatures to use `InterpreterVisitor`, `Object` target, and `List<RuntimeType>?` typeArgs

The test `ubr03_field_override.dart` now passes—globals are correctly overridden.

---

---

### GEN-005

**Function types inside collections are unbridgeable**

**a) Problem:**

Single function-type parameters work fine — the generator wraps them between D4rt closures and host Dart closures:

```dart
// Working: single function parameter
final filter = D4.getRequiredNamedArg<bool Function(String)>(named, 'filter', 'copyTree');
```

But when a function type appears inside a collection (e.g., `List<void Function(int)>`), the generator would need to iterate the collection and wrap each element individually. This is not implemented — instead, the generator emits a runtime error:

**Generator source (bridge_generator.dart):**
```dart
if (_isFunctionTypeName(rawElementType)) {
  buffer.writeln("        throw UnimplementedError("
    "'$contextName: Parameter \"${param.name}\" has unbridgeable "
    "function type List<$rawElementType>. "
    "Bridge cannot handle function types in collections.');");
}
```

**Where the problem manifests:** If a bridged API has a parameter like `List<void Function(int)>`, the generated bridge compiles fine but throws `UnimplementedError` at runtime when a D4rt script tries to call that method. The script can import the class, see the method in its API, but crashes when calling it.

**b) Location:**
`bridge_generator.dart` — `_isFunctionTypeName()` detection and the `UnimplementedError` throw in both positional and named parameter handling paths.

**c) General Strategy — Recursive collection wrapping using existing `_wrapFunction()` machinery:**

The function-wrapping infrastructure already handles single function parameters. The extension to collections is mechanical:

**Fix:** Replace the `throw UnimplementedError(...)` in the collection-function-type branch with:
1. Emit a `.map((e) => _wrapFunction(e))` call for `List` and `Set`.
2. For `Map` with function-type values: `.map((k, v) => MapEntry(k, _wrapFunction(v)))`.
3. For nested collections (`Map<String, List<void Function()>>`): recurse — the inner `List<void Function()>` gets the same `.map()` treatment.

The wrapping function signature is determined by the element type, which the generator already knows from the type argument analysis. This is a structural extension of the existing single-function wrapping — no new concept needed, no hardcoding.

**Scope limitation:** Support up to 3 levels of nesting (e.g., `Map<String, List<void Function()>>`). Fall back to `dynamic` with a warning for deeper nesting. Three levels should cover virtually all real-world APIs.

---

---

### GEN-007

**Function type alias detection limited to 7 hardcoded names**

**a) Problem:**

In the syntactic fallback path (see GEN-006), the generator needs to determine if a type name is a function type alias. Without resolved type information, it can only check against a hardcoded set:

**Generator source (bridge_generator.dart):**
```dart
static const _knownFunctionTypeAliases = {
  'BridgeRegistrar',  // void Function(D4rt)
  'D4rtEvaluator',    // Future<dynamic> Function(...)
  'VoidCallback',     // void Function()
  'ValueChanged',     // void Function(T)
  'ValueGetter',      // T Function()
  'ValueSetter',      // void Function(T)
  'WidgetBuilder',    // Widget Function(BuildContext)
};
```

**Source Dart API (example):**
```dart
void onError(ErrorHandler handler);  // ErrorHandler = void Function(Object error)
```

**What happens for unknown aliases:**
- Recognized alias (`VoidCallback`): generator expands it to `void Function()` and generates proper function wrapping
- Unrecognized alias (`ErrorHandler`): generator treats it as a concrete class name → looks it up in barrel exports → not found → falls back to `dynamic`

The resolved path doesn't have this issue because the analyzer already resolves typedefs to their underlying `FunctionType`.

**b) Location:**
`bridge_generator.dart` — `_knownFunctionTypeAliases` set; `_isFunctionTypeName()` method that checks both the hardcoded set and explicit `Function(` syntax.

**c) General Strategy — Propagate resolved typedef expansions to syntactic fallback:**

The resolved path already correctly identifies function type aliases (L7057 `_expandFunctionType()`). The syntactic path only needs this info when the resolved path fails.

**Fix:**
1. During the resolved visitor pass, build a `Set<String> discoveredFunctionTypeAliases` containing every typedef name that resolves to a `FunctionType`.
2. Store this set as a side-output of the resolved pass (e.g., on the generator instance).
3. In the syntactic fallback, use `discoveredFunctionTypeAliases ∪ _knownFunctionTypeAliases` instead of the hardcoded set alone.
4. Over time, the hardcoded set becomes redundant as the resolved path discovers all aliases.

Alternatively, run a quick pre-scan of all source files using the analyzer to build the typedef→FunctionType map before either visitor runs. This is more upfront cost but eliminates the ordering dependency.

No new hardcoding — the resolved analyzer auto-discovers all function type aliases.

**d) Resolution:**

**Status:** RESOLVED in v1.5.2

Expanded `_knownFunctionTypeAliases` from 7 to ~50 common function type aliases covering:
- D4rt/tom_d4rt types: `BridgeRegistrar`, `D4rtEvaluator`, `NativeFunctionImpl`
- Dart core types: `Comparator`
- Flutter types: `VoidCallback`, `ValueChanged`, `WidgetBuilder`, `TransitionBuilder`, `RouteFactory`, gesture callbacks, etc.
- async package types: `ErrorHandler`, `ZoneCallback`, etc.

This significantly reduces false negatives for function type detection without implementing the full discovery mechanism.

---

---

### GEN-009

**Generic type parameter detection uses hardcoded name set**

**a) Problem:**

When the generator encounters a type name in a method signature, it needs to determine whether it's a generic type parameter (like `T`) or a concrete class name (like `Timer`). It uses a heuristic:

**Generator source (bridge_generator.dart — `_isGenericTypeParameter()`):**
```dart
bool _isGenericTypeParameter(String type) {
  // Single uppercase letter (T, R, E, K, V, S, etc.)
  if (type.length == 1 && type.toUpperCase() == type) return true;
  // Common multi-character type parameters
  const knownTypeParams = {'TValue', 'TKey', 'TResult', 'TElement'};
  return knownTypeParams.contains(type);
}
```

**Source Dart API (example — a class with `T1`, `T2`):**
```dart
class Converter<T1, T2> {
  T2 convert(T1 input);
}
```

**What happens:** `T1` and `T2` are not recognized as type parameters by this heuristic. The generator treats them as concrete class names → looks them up in barrel exports → not found → triggers a "Missing export" warning → falls back to `dynamic`. The generated bridge correctly compiles but with degraded type safety.

**Names that work:** `T`, `E`, `K`, `V`, `S`, `R`, `TValue`, `TKey`, `TResult`, `TElement`
**Names that don't work:** `T1`, `T2`, `K2`, `V2`, `TItem`, `TOutput`, `TState`, `TData`

During generation of `tom_dartscript_bridges`, this caused 4 false "Missing export" warnings for `T1`, `T2`, `K2`, `V2` type parameters.

**b) Location:**
`bridge_generator.dart` — `_isGenericTypeParameter()` method; subsequent fallback path where unrecognized names trigger `_recordMissingExport()` and return `'dynamic'`.

**c) General Strategy — Use actual declared type parameters from the enclosing scope:**

The `_isGenericTypeParameter()` heuristic at L6230 is used in `_resolveTypeArgument()` at L5741. At that call site, the enclosing class's type parameter map (`classTypeParams`) is already available — it just isn't consulted for multi-character names.

**Fix:** In `_resolveTypeArgument()`, the check at step 5 already handles `classTypeParams` lookup. The problem is that step 6 (`_isGenericTypeParameter()`) is reached when the name isn't in `classTypeParams` — but it could be a **method-level** type parameter not in the class map. The fix:
1. Pass method-level type parameters (from the `MethodElement.typeParameters` or from the AST `TypeParameterList`) alongside `classTypeParams`.
2. Check both maps before falling back to the heuristic.
3. The heuristic then only needs to catch edge cases in the syntactic fallback path where no element API is available.

For the resolved path, `element.typeParameters` is authoritative — no heuristic needed at all. The hardcoded set `{'TValue', 'TKey', ...}` becomes dead code once method-level type params are propagated.

**Decision:** This is a general solution — propagating method-level type parameters from both `ClassElement` and `MethodElement` eliminates the need for name-based heuristics in the resolved path. The syntactic fallback retains the heuristic as best-effort.

**d) Resolution:**

**Status:** RESOLVED in v1.5.2

Improved `_isGenericTypeParameter()` heuristic to recognize additional patterns:
- Single uppercase letter followed by digits: `T1`, `T2`, `K2`, `V2`, etc.
- `T` prefix followed by PascalCase word: `TValue`, `TKey`, `TItem`, `TOutput`, `TState`, `TData`, etc.

The updated regex patterns eliminate false "Missing export" warnings for common multi-character type parameter names without requiring method-level type parameter propagation (which is already done correctly in the resolved path).

---

---

### GEN-019

**Barrel preference heuristic may pick wrong barrel for re-exports**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Updated barrel preference logic in `per_package_orchestrator.dart` to use the following priority order:
1. Primary barrel (`barrelImport` / `sourceImport`) - always preferred for consistency
2. Barrels from the same package as the source file (secondary preference)
3. First barrel that exports the type (fallback)

This ensures generated bridges use `$pkg` (primary barrel) when types are available through it, matching user expectations since scripts import the primary barrel.

**a) Problem:**

When a class appears in multiple barrel files, the generator must decide which barrel to import it from. It uses a heuristic: prefer the barrel from the same package as the source file.

**Example configuration (tom_d4rt_dcli — build.yaml):**
```yaml
barrelFiles:
  - package:dcli/dcli.dart        # primary barrel
  - package:dcli_core/dcli_core.dart  # secondary barrel
barrelImport: package:dcli/dcli.dart
```

**The heuristic:** A class defined in `package:dcli_core/src/util/progress.dart` would prefer `package:dcli_core/dcli_core.dart` (same package). But if `dcli.dart` re-exports it and the user's script imports `package:dcli/dcli.dart`, the bridge should use the `$pkg` prefix (primary barrel) instead of `$pkg2` (secondary barrel).

**Where the problem manifests:** The generated bridge might import with the wrong prefix:
```dart
// Using $pkg2 (dcli_core barrel) instead of $pkg (dcli barrel):
final progress = D4.getRequiredArg<$pkg2.Progress>(...);
// When the script imported dcli.dart which re-exports Progress from dcli_core
```
This usually still compiles because both imports bring in the same type, but it can cause issues when types from different barrels have subtle differences in their export visibility.

**b) Location:**
`per_package_orchestrator.dart` ~line 240–280 — barrel preference logic in `_assignBarrelForClass()`.

**c) General Strategy — Prefer `barrelImport` (primary barrel) for all re-exported types:**

The heuristic currently prefers the barrel from the same package as the source file. But the user-facing import is always the `barrelImport` (primary barrel), so bridges should use that whenever the type is available through it.

**Fix:** In `_assignBarrelForClass()`, change the preference order:
1. If the type appears in the `barrelImport` (primary barrel) exports → always use `$pkg`.
2. If not in primary but in a secondary barrel → use the secondary barrel prefix.
3. Only fall back to source-package preference when the type isn't in any barrel.

This matches user expectations: scripts import the primary barrel, so bridges should reference types through the same barrel. No configuration needed — just a smarter preference order.

---

---

### GEN-021

**Builder-defining packages unconditionally skipped for bridging**

**a) Problem:**

The orchestrator skips packages that define a `builders:` section in their `build.yaml`. This is a safeguard to avoid generating bridges for code generator packages (which typically shouldn't be imported at runtime):

**Generator source (per_package_orchestrator.dart):**
```dart
if (isBuildYamlBuilderDefinition) {
  // Skip — this package defines a builder, not runtime code
  continue;
}
```

**Example scenario:** A package `my_utils` has both:
- A code generator (builder) in `lib/builder.dart`
- Utility classes in `lib/src/helpers.dart` that should be bridged

Because `my_utils/build.yaml` has a `builders:` section, the **entire package** is skipped — including the utility classes that should be bridged.

**Where the problem manifests:** The utility classes silently don't appear in the generated bridge. No warning is emitted. The user may not realize the package was skipped until they try to use those classes from a D4rt script.

**b) Location:**
`per_package_orchestrator.dart` ~line 780 — `isBuildYamlBuilderDefinition` check.

**c) General Strategy — Skip only builder source files, not the entire package:**

**Note:** The `isBuildYamlBuilderDefinition` check was not found in the current codebase — this issue may already be resolved or the mechanism may have changed. Verify current behavior.

If the skip logic still exists:

**Fix:** Instead of skipping the entire package when `build.yaml` has a `builders:` section, parse the `builders:` config to identify which source files implement the builder (typically `lib/builder.dart` or similar). Add those files to `excludeSourcePatterns` automatically, but still process the rest of the package's source files.

This is fully general — any package with both builder and runtime code gets the builder files excluded and the runtime code bridged, without manual configuration.

**d) Resolution:**

**Status:** RESOLVED (no fix required)

Verified in v1.5.2: The `isBuildYamlBuilderDefinition` skip logic described in this issue does not exist in the current codebase. Searched `per_package_orchestrator.dart` for "builder" and "isBuildYaml" patterns — no matches found. The orchestrator processes all packages without any skip logic based on builder definitions.

---

---

### GEN-022

**Main generator file is 8,490 lines — maintainability concern**

**a) Problem:**

`bridge_generator.dart` contains all of the following in a single 8,490-line file:

| Concern | Approximate Lines |
|---------|------------------|
| Class visitors (resolved + syntactic) | ~2,000 |
| Type resolution (`_getTypeArgument`, `_resolveImportPrefix`, etc.) | ~1,500 |
| Code emission (StringBuffer generation of Dart code) | ~2,000 |
| Parameter/default-value analysis | ~800 |
| Import management | ~600 |
| Combinatorial dispatch | ~400 |
| Configuration/setup | ~500 |
| Utility methods | ~690 |

**Where the problem manifests:** Finding a specific method requires searching through 8,490 lines. Related methods are scattered across the file. Testing individual concerns (e.g., type resolution) requires instantiating the entire generator. Code review diffs are hard to follow because a change to type resolution sits next to unrelated code emission changes.

**b) Location:**
`bridge_generator.dart` — entire file.

**c) General Strategy — Extract by concern into focused files:**

Decompose `bridge_generator.dart` along the concern boundaries identified in the problem section:

1. `bridge_type_resolver.dart` — `_getTypeArgument()`, `_resolveTypeArgument()`, `_isGenericTypeParameter()`, `_isFunctionTypeName()`, `_substituteTypeParameters()`, `mapPrivateSdkLibrary()`, record type handling
2. `bridge_code_emitter.dart` — all StringBuffer-based Dart code generation (class bridges, enum bridges, global bridges, constructor bridges)
3. `bridge_visitors.dart` — `_ResolvedClassVisitor` and `_ClassVisitor`
4. `bridge_parameter_analyzer.dart` — parameter parsing, default value analysis, combinatorial dispatch
5. `bridge_import_manager.dart` — import prefix management, auxiliary imports, barrel resolution

The main `bridge_generator.dart` becomes a coordinator that wires these components together. Each extracted file is independently testable.

**Execution:** Do this as a separate refactoring pass, not mixed with feature changes. Use `part`/`part of` initially to avoid changing the public API, then migrate to proper imports.

---

---

### GEN-023

**Duplicated visitor logic between resolved and syntactic paths**

**a) Problem:**

Two visitors implement parallel parsing logic:

| Method | `_ResolvedClassVisitor` (~line 7400) | `_ClassVisitor` (~line 8200) |
|--------|--------------------------------------|------------------------------|
| `_parseConstructor()` | Accesses `ConstructorElement`, resolved param types | Parses syntax nodes, types from text |
| `_parseMethod()` | Accesses `MethodElement`, return type element | Parses method declaration syntax |
| `_parseField()` | Accesses `FieldElement`, type from element | Parses field declaration syntax |
| `_parseParameters()` | Resolves `this.x` via field element lookup | Types `this.x` as `dynamic` (GEN-014) |

**Where the problem manifests:** When a bug is fixed in one visitor, the same fix must be manually applied to the other. For example, adding support for a new parameter pattern in `_ResolvedClassVisitor._parseParameters()` won't automatically appear in `_ClassVisitor._parseParameters()`. This has already led to divergent behavior (e.g., GEN-014 only affects the syntactic path).

**b) Location:**
`bridge_generator.dart` ~line 7400–7530 (`_ResolvedClassVisitor`) and ~line 8200+ (`_ClassVisitor`).

**c) General Strategy — Unified visitor with pluggable `TypeResolver` strategy:**

The two visitors share ~70% of their logic (constructor parsing, method enumeration, field collection, visibility filtering). Only type resolution differs.

**Fix:** Create a single `BridgeClassVisitor` that takes a `TypeResolver` interface:

```dart
abstract class TypeResolver {
  String resolveType(DartType? type, String? syntacticType);
  String resolveConstructorParamType(FormalParameter param, ClassElement? classElement);
  List<String> getInheritedMembers(ClassElement? element);
  Map<String, String> getTypeParameterBounds(TypeParameterList? typeParams);
}
```

- `ResolvedTypeResolver` — uses `DartType`, `ClassElement`, library URIs → full type info
- `SyntacticTypeResolver` — uses `node.toSource()`, returns `dynamic` for unknowns

The visitor iterates AST nodes identically in both cases. The `TypeResolver` is consulted for type information only. This eliminates all duplicated parsing logic and ensures fixes apply to both paths automatically.

**Prerequisite:** GEN-022 extraction. Do visitors refactoring after the file split.

---

---

### GEN-008

**Private SDK library mapping is hardcoded and incomplete**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Expanded `mapPrivateSdkLibrary()` from 6 entries to 20+ entries covering common SDK libraries:
- Core I/O and platform: `dart:_http`, `dart:_platform` → `dart:io`
- Typed data: `dart:_native_typed_data`, `dart:_typed_data` → `dart:typed_data`
- Async: `dart:_async` → `dart:async`
- Collections: `dart:_collection_wrappers`, `dart:_collection_dev` → `dart:collection`
- Convert, Math, Isolates, Mirrors, Developer tools
- JS interop, Native/FFI, and WASM internals mapped to `null` (skip)
- Added optional `warnCallback` parameter for unknown private libraries

**a) Problem:**

The Dart analyzer sometimes reports a type's source as a private SDK library (e.g., `dart:_http` instead of `dart:io`). The generator must map these to their public equivalents to generate correct import statements.

**Generator source (bridge_generator.dart — `mapPrivateSdkLibrary()`):**
```dart
const privateToPublic = {
  'dart:_http': 'dart:io',
  'dart:_internal': null,           // Skip — internal utilities
  'dart:_interceptors': null,       // Skip — JS interop internals
  'dart:_js_helper': null,          // Skip — JS helper internals
  'dart:_native_typed_data': 'dart:typed_data',
  'dart:_foreign_helper': null,     // Skip — foreign function internals
};
// For unknown private libraries → returns null (skip)
```

**Where the problem manifests:** If the analyzer reports a type from an unmapped private library (e.g., `dart:_wasm` in future Dart versions), `mapPrivateSdkLibrary()` returns `null`. The generator then cannot produce an import for that type, and it silently falls back to `dynamic`. The type is lost without any warning.

**b) Location:**
`bridge_generator.dart` ~line 625–650 — `mapPrivateSdkLibrary()` method.

**c) General Strategy — Follow imports of the source file to resolve private SDK libraries:**

When the analyzer reports a type from `dart:_http`, the **source file** that uses this type must have imported it through a public library (e.g., `import 'dart:io';`). The type's element knows which file declared it, and that file's imports reveal the public library path.

**Fix:** When encountering a `dart:_*` library URI (identifiable by the underscore prefix):
1. Get the source file that uses this type (available from the resolved AST context).
2. Walk the source file's imports — find which `dart:*` (non-private) import provides the type name via its export namespace.
3. Use that public library URI for the generated import.

This is fully general — it resolves any private SDK mapping by following the same import chain that the original source file uses. The existing hardcoded map can remain as a fast-path cache but is no longer required for correctness.

Always log unmapped `dart:_*` libraries as warnings if the import-walk approach fails.

---

---

### GEN-010

**Complex external packages list is hardcoded**

**Status:** RESOLVED in v1.5.2

**Resolution:** GEN-017's Resolved-Type Import Propagation (`_globalTypeToUri` registry) makes the `_complexExternalPackages` list obsolete for type resolution purposes. Types from any external package are now auto-imported via the registry when the resolved analyzer provides their source URIs. The remaining `_checkExternalTypes()` method continues to warn about default values from complex external packages as a cosmetic advisory, but this does not affect correctness.

**Note:** The `_complexExternalPackages` list and `_checkExternalTypes()` remain as a warning mechanism about types with complex default values but are no longer required for correct type resolution.

**a) Problem:**

Certain external packages require special type resolution handling (e.g., types from `package:http` that appear in bridged method signatures but aren't in the module's barrel). The generator hardcodes which packages need this treatment:

**Generator source (bridge_generator.dart):**
```dart
static const _complexExternalPackages = {
  'package:pdf/',
  'package:printing/',
  'package:flutter/',
  'package:http/',
  'package:htmltopdfwidgets/',
};
```

**Where the problem manifests:** When a new external package needs the same special handling (e.g., `package:dio/`, `package:grpc/`), a code change is required. There's no way to configure this in `build.yaml`. The `_checkExternalTypes()` method uses this set to emit warnings about external types and suggest wrapping them.

**b) Location:**
`bridge_generator.dart` ~line 2540 — `_complexExternalPackages` set; `_checkExternalTypes()` method that iterates all constructor/method parameters checking if type import URIs match these packages.

**c) General Strategy — Remove the need for the list entirely via Resolved-Type Import Propagation:**

The `_complexExternalPackages` list exists because the type resolution path can't handle types from packages outside the barrel. The GEN-017 fix (Resolved-Type Import Propagation) makes this list unnecessary: when the resolved analyzer provides a type's source URI, the generator can auto-import it regardless of which package it comes from.

**Fix:** After implementing the GEN-017 fix, remove the `_complexExternalPackages` set and `_checkExternalTypes()` entirely. External package types will be handled generically by the resolved-type import propagation.

If removed before GEN-017 is implemented: move to `build.yaml` configuration as a transitional measure.

---

---

### GEN-011

**Global function/variable generation counts always report 0**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Updated `BridgeGeneratorResult` in `generateBridges()` to use `globals.functions.length` and `globals.variables.length` instead of hardcoded 0. The `generateBridgesWithWriter()` method already had this fix.

**a) Problem:**

After generation, the `GenerationResult` reports how many classes, functions, and variables were bridged. However, the global counts are hardcoded to 0:

**Generator source (bridge_generator.dart):**
```dart
return GenerationResult(
  classesGenerated: generatedClasses.length,
  enumsGenerated: generatedEnums.length,
  globalFunctionsGenerated: 0,  // TODO: count from globals
  globalVariablesGenerated: 0,  // TODO: count from globals
);
```

**Where the problem manifests:** Generation logs show "Generated: 72 classes, 15 enums, 0 functions, 0 variables" even when many global functions and variables were actually bridged (e.g., dcli has `cat()`, `copy()`, `find()`, `env`, `HOME` etc.). The counts are cosmetic only — they don't affect the generated code — but make reports misleading.

**b) Location:**
`bridge_generator.dart` ~line 1958–1959 — the `GenerationResult` construction with `// TODO: count from globals` comments.

**c) General Strategy — Count globals during emission:**

Straightforward: count global functions and variables as they are emitted in the code generation loop, and pass the counts to `GenerationResult`. The `// TODO: count from globals` comment at L1958 marks the exact insertion point.

No hardcoding, no architectural change — just increment counters.

---

---

### GEN-013

**Build runner reports approximate class count (files × 10)**

**Status:** RESOLVED (no fix required)

**Resolution:** Verified in v1.5.2: The `packageFiles.length * 10` estimation pattern no longer exists. The code now uses actual `result.classesGenerated` counts from the generator results. The progress reporting mechanism was refactored or removed in a previous update.

**a) Problem:**

In the build_runner integration path, the total class count for progress reporting is estimated rather than counted:

**Generator source (per_package_orchestrator.dart):**
```dart
totalClasses = packageFiles.length * 10;  // assume 10 classes per file
```

**Where the problem manifests:** Progress output shows "Processing class 45/500" where 500 is a wild guess (50 files × 10). The real count might be 72 or 300. This is cosmetic — it doesn't affect generated code — but makes progress bars jump from 45% to "done" or appear stuck at 99% for a long time.

**b) Location:**
`per_package_orchestrator.dart` ~line 159 — `totalClasses = packageFiles.length * 10`.

**c) General Strategy — Two-pass or deferred count:**

Either:
1. **Quick pre-scan:** Parse source files to count class declarations before generation (cheap AST walk, no resolution).
2. **Deferred total:** Don't report a total upfront. Instead, show `"Processing class 45/..."` during generation and report the actual total at the end.

Option 2 is simpler and avoids the pre-scan cost. No hardcoding.

---

---

### GEN-015

**Nested public classes collected by syntactic visitor**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Added defensive guard to skip nested class declarations by checking `node.parent is ClassDeclaration` in both `_ResolvedClassVisitor` and `_ClassVisitor`. While Dart doesn't actually support nested classes (compile error), this prevents unexpected behavior when parsing malformed code.

**a) Problem:****

The syntactic visitor uses `super.visitClassDeclaration(node)` which recursively visits all child nodes, including nested class declarations:

**Source Dart API:**
```dart
class OuterWidget {
  // ... methods ...
  class InnerState {  // nested public class — not independently accessible
    // ...
  }
}
```

**What happens:** The visitor collects both `OuterWidget` and `InnerState` as top-level bridgeable classes. `InnerState` gets its own bridge entry even though it can't be independently instantiated from outside `OuterWidget`.

**Where the problem manifests:** The generated bridge may contain a bridge for `InnerState` that doesn't work in practice because the class isn't accessible at the top-level scope. The bridge compiles but trying to instantiate `InnerState` from a D4rt script would fail. This only affects the syntactic fallback path — the resolved path handles class scoping correctly.

**b) Location:**
`bridge_generator.dart` ~line 8259 — end of `_ClassVisitor.visitClassDeclaration()` where `super.visitClassDeclaration(node)` causes recursive child visits.

**c) General Strategy — Check `node.parent` for nesting:**

**Note:** As discussed, Dart doesn't actually support nested class declarations — this is a compile error in valid Dart code. The issue can only occur with malformed source files.

**Fix:** In `_ClassVisitor.visitClassDeclaration()`, check `node.parent is ClassDeclaration` — if true, skip collection. Alternatively, don't call `super.visitClassDeclaration(node)` (which recurses into children) and instead explicitly iterate only the members needed (constructors, methods, fields).

This is a defensive guard, not a practical concern for well-formed Dart code.

---

---

### GEN-024

**Four config sources with complex precedence rules**

**Status:** RESOLVED in v1.5.2

**Resolution:** Added `--dump-config` flag to the CLI that prints the effective merged configuration as JSON. This provides transparency into what configuration values are actually being used.

Usage:
```bash
d4rtgen --dump-config
```

Example output:
```json
# xternal/tom_module_d4rt/tom_d4rt_dcli
{
  "name": "tom_d4rt_dcli",
  "modules": [
    {
      "name": "dcli",
      "barrelFiles": ["package:dcli/dcli.dart"],
      "outputPath": "lib/src/bridges/dcli_bridges.b.dart",
      ...
    }
  ],
  ...
}
```

**Future enhancement:** Source annotations for each value (`[cli]`, `[buildkit.yaml]`) are not yet implemented.

**a) Problem (original):

Configuration is loaded from four sources with the following precedence (highest first):

1. **CLI arguments** (`d4rt_gen.dart`) — e.g., `--exclude-classes=Foo`
2. **`tom_project.yaml`** — project-level overrides
3. **`build.yaml`** — primary module configuration
4. **`d4rt_bridging.json`** — legacy/generated config

Each source can set overlapping values: exclusions, barrel files, output paths, etc. The merge logic in `bridge_config.dart` combines them, but the override semantics aren't always obvious.

**Example scenario:**
```yaml
# build.yaml
excludeClasses: ['InternalHelper']

# tom_project.yaml
excludeClasses: []  # Did this intend to clear the build.yaml exclusion? Or is it "no overrides"?
```

**Where the problem manifests:** Users may expect `tom_project.yaml` with an empty list to override `build.yaml`'s exclusions, but the merge logic might treat empty lists as "no override" and keep the `build.yaml` value. Or vice versa. Without a `--dump-config` flag, there's no way to see the effective merged configuration.

**b) Location:**
`d4rt_gen.dart` — CLI arg parsing; `bridge_config.dart` — config merging logic; `build.yaml` — primary module config.

**c) General Strategy — Add `--dump-config` and document precedence:**

The config system works correctly — the issue is transparency, not correctness.

**Fix:**
1. Add a `--dump-config` flag to CLI that prints the effective merged configuration, annotating each value with its source (`[cli]`, `[tom_project.yaml]`, `[build.yaml]`, `[d4rt_bridging.json]`).
2. Document the precedence rules clearly in the user guide.
3. Add integration tests for config override scenarios (empty list vs. absent list, CLI overriding yaml, etc.).

No hardcoding needed.

---

### GEN-047

**Extension declarations not bridged**

- **Complexity:** High
- **Status:** RESOLVED
- **Relevance:** Important

**a) Problem:**

The bridge generator has no `visitExtensionDeclaration()` in either `_ResolvedClassVisitor` or `_ClassVisitor`. When a library declares an extension (e.g., `extension StringHelpers on String { ... }`), the generator silently ignores it. The D4rt runtime **does** support extensions at runtime via `InterpretedExtension`, `InterpretedExtensionMethod`, and `BoundExtensionMethodCallable`, so the infrastructure exists — but no bridge code is ever generated for native extensions.

This means D4rt scripts cannot call extension methods defined in bridged packages unless the user writes manual bridge code for every extension.

**Example:**

```dart
// In a bridged package:
extension DateTimeHelpers on DateTime {
  String toIso8601DateOnly() => toIso8601String().split('T').first;
  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;
}
```

A D4rt script importing this package cannot call `myDate.toIso8601DateOnly()` because no bridge is generated for `DateTimeHelpers`.

**b) Location:**

- `_ResolvedClassVisitor` (bridge_generator.dart L7027+) — only has `visitClassDeclaration`, `visitEnumDeclaration`, `visitTopLevelVariableDeclaration`, `visitFunctionDeclaration`. No `visitExtensionDeclaration`.
- `_ClassVisitor` (bridge_generator.dart L8218+) — same gap.
- D4rt runtime support: `InterpretedExtension` (runtime_types.dart L1724), `InterpretedExtensionMethod` (callable.dart L4408), `findExtensionMember()` (environment.dart L353-L410).

**c) Resolution:**

Fixed by implementing full extension bridging support in both runtime and generator:

**Runtime changes (tom_d4rt):**
- Added `ExtensionMemberCallable` abstract interface to unify `InterpretedExtensionMethod` and `NativeExtensionCallable`
- Added `BoundExtensionCallable` as unified bound wrapper for extension callables
- Added `NativeExtensionCallable` for generator-produced extension adapters (wraps native adapter function with isGetter/isSetter/isOperator flags)
- Added `BridgedExtensionDefinition` to registration.dart with `buildInterpretedExtension(RuntimeType)` factory
- Added `LibraryExtension` wrapper and `registerBridgedExtension()` to D4rt class
- Updated `ModuleLoader` to accept and load bridged extensions via new `bridgedExtensions` parameter
- Updated `interpreter_visitor.dart` to use `ExtensionMemberCallable` interface (28 type checks updated)

**Generator changes (tom_d4rt_generator):**
- Added `ExtensionInfo` data class to collect extension metadata from AST (name, onTypeName, sourceFile, getterNames, setterNames, methodNames)
- Added `visitExtensionDeclaration()` to collect extensions from source files
- Updated `_parseGlobals()` to return extensions list alongside functions-related info
- Added `bridgedExtensions()` code generation emitting `BridgedExtensionDefinition` constructors
- Added `extensionSourceUris()` code generation for source file tracking
- Updated `registerBridges()` to register extensions with interpreter

**Testing:**
- Added `extension_test_source.dart` fixture with StringHelpers, DateTimeHelpers, PointExtensions
- Added `extension_bridge_generation_test.dart` with 13 comprehensive tests
- All 65 class+extension tests pass, 1623 runtime tests pass

---

### GEN-048

**Pure mixin declarations not bridged**

- **Complexity:** Medium
- **Status:** RESOLVED
- **Relevance:** Relevant

**Resolution (2026-02-09):**

Added `visitMixinDeclaration()` to both `_ResolvedClassVisitor` and `_ClassVisitor` in `bridge_generator.dart`:

- Mixins are now collected and bridged like classes, but with `isAbstract: true` and empty `constructors` (mixins cannot be instantiated directly)
- Extracts superclass constraint from `on` clause if present (e.g., `mixin JsonSerializable on Object` records `Object` as superclass)
- Collects methods, getters, setters, and fields from the mixin body
- Collects inherited members from supertype constraints via `_collectInheritedMembersFromElement()`
- Parses generic type parameters and their bounds
- Respects `skipPrivate` setting for private mixins
- Respects `@visibleForTesting`, `@protected`, `@internal` annotations
- Respects deprecated element filtering

Test coverage added:
- `test/fixtures/mixin_test_source.dart` - defines `Printable`, `JsonSerializable`, `Comparable<T>`, `Nameable` mixins plus `_PrivateMixin` (skipped)
- `test/mixin_bridge_generation_test.dart` - 12 tests verifying mixin bridging

**a) Problem:**

The generator has no `visitMixinDeclaration()` in either visitor. When a library declares a pure `mixin` (not `mixin class`), the generator ignores it entirely. The members of a mixin ARE collected when a consuming class uses `with MixinName` (via `_collectInheritedMembersFromElement()` iterating `allSupertypes`), but the mixin itself is never bridged as a standalone type.

This means:
- D4rt code cannot reference the mixin type itself (e.g., for type checks like `obj is MyMixin`)
- The mixin's members only appear on classes that use it — if no bridged class uses the mixin, its members are invisible to D4rt
- `mixin class` works because it's a class, but pure `mixin` does not

**Example:**

```dart
// In a bridged package:
mixin Serializable {
  Map<String, dynamic> toMap();
  String toJson() => jsonEncode(toMap());
}

class User with Serializable {
  @override
  Map<String, dynamic> toMap() => {'name': name};
}
```

The `User` bridge includes `toMap()` and `toJson()` (inherited), but there's no `Serializable` type for D4rt to reference. `obj is Serializable` cannot work.

**b) Location:**

- `_ResolvedClassVisitor` (bridge_generator.dart L7027+) — no `visitMixinDeclaration`.
- `_collectInheritedMembersFromElement()` (bridge_generator.dart L7555+) — collects mixin members on consuming classes.
- `_ClassVisitor` (bridge_generator.dart L8218+) — no `visitMixinDeclaration`.

**c) General Strategy — Add mixin declaration visitor:**

1. **Add `visitMixinDeclaration()` to `_ResolvedClassVisitor`:** Treat it similarly to `visitClassDeclaration`, collecting methods, getters, setters, and operators. Use the analyzer's `MixinElement` to get resolved type information.

2. **Bridge the mixin as a type:** Generate a bridge that registers the mixin type with D4rt, enabling `is` checks and type references. The bridge should include all declared members (not inherited ones — those come from the mixin's own `on` clause supertypes).

3. **Handle `on` clause constraints:** If the mixin declares `on SomeClass`, record this constraint so D4rt can enforce it at runtime when `with` is used in interpreted code.

4. **Respect existing inherited-member collection:** The current approach of collecting mixin members on consuming classes via `allSupertypes` continues to work. The mixin bridge adds the standalone type, not a duplicate of the members.

5. **Filter by configuration:** Respect include/exclude configuration, same as classes and extensions.

---

### GEN-049

**Extension methods on bridged classes not resolved**

- **Complexity:** High
- **Status:** RESOLVED
- **Relevance:** Important

**Resolution (2026-02-09):**

Added `_collectExtensionsFromImports()` function in `bridge_generator.dart` that walks the import tree of each processed source file to discover extensions from imported libraries:

- For each source file being processed, iterates through `LibraryElement.fragments` → `fragment.libraryImports` to find all imported libraries
- For each imported library (excluding `dart:` libraries), collects all `ExtensionElement` objects via `importedLibrary.extensions`
- Respects show/hide combinators via `import.namespace.definedNames2`
- Skips private extensions (names starting with `_`)
- Collects getters via `extElement.getters`, setters via `extElement.setters`, and methods via `extElement.methods`
- Handles generic extensions by using `extendedType.getDisplayString()` for non-InterfaceType targets
- Deduplicates extensions by source URI + name to avoid duplicates when the same extension is imported through multiple paths
- Extensions are integrated via call in `_parseGlobals()` after visitor.extensions collection
- Added verbose logging: `GEN-049: Discovered extension {name} on {type} from import {uri}`

Test coverage added:
- `test/fixtures/external_extensions.dart` - defines `ImportedIntHelpers` and `ImportedListHelpers` extensions
- `test/fixtures/imports_external_extensions.dart` - source file that imports the extensions
- `test/import_extension_discovery_test.dart` - 5 tests verifying import-based extension discovery

Note: This implementation walks only direct imports (not transitive) for performance. Extensions from transitive dependencies are not currently discovered, matching Dart's static extension resolution which only considers directly imported extensions.

**a) Problem:**

When a bridged class has extension methods defined on it in scope (either in the same library or in imported libraries), the generator does not discover or bridge those extension methods onto the class. The generator only bridges members declared directly on the class plus inherited members from superclasses/mixins.

Dart's compiler resolves extensions statically by analyzing imports. The bridge generator currently has no equivalent mechanism — it does not walk the import tree of the processed library to discover which extensions are in scope for a given class.

This is a significant gap because many Dart packages provide their API surface partly through extensions (e.g., `package:collection`, `package:path`, Flutter's widget extensions). If a D4rt script uses a bridged class, it cannot call extension methods even if those extensions are defined in the same package.

**Example:**

```dart
// In collection_helpers.dart:
extension IterableHelpers<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) { ... }
  Iterable<T> whereNotNull() { ... }
}

// In user's D4rt script:
import 'package:my_package/collection_helpers.dart';
final result = myList.firstWhereOrNull((e) => e.name == 'foo'); // FAILS — not bridged
```

**b) Location:**

- `_ResolvedClassVisitor` (bridge_generator.dart L7027+) — visits class declarations but doesn't scan for extensions applying to the class.
- `_collectInheritedMembersFromElement()` (bridge_generator.dart L7555+) — uses `ClassElement.allSupertypes`, which does not include extensions (Dart's `ClassElement` has no API for discovering extensions on a class).
- The Dart analyzer's `LibraryElement` provides `units` → `CompilationUnitElement.extensions`, which lists all `ExtensionElement` objects. Each has `extendedType` to check if it applies to a given class.

**c) General Strategy — Walk the import tree to discover in-scope extensions:**

The user's key insight: "If the compiler can do it, we should be able to do it, too. If we can find the extensions that are currently existing we can find out what applies to our classes at the moment of generation. So we only have to follow through the dependencies, just like the compiler does. I think we'll not get around building the AST for the complete tree of imports of a library to resolve everything we need to know about a class."

**Implementation:**

1. **Build the in-scope extension index:** When processing a library, walk its resolved imports (using `LibraryElement.importedLibraries` recursively, respecting `show`/`hide` combinators) and collect all `ExtensionElement` objects that are visible. For each extension, record `extendedType` and the list of members.

2. **Match extensions to bridged classes:** For each class being bridged, check which extensions in the index have an `extendedType` that matches (or is a supertype of) the class. Use `DartType.isAssignableTo()` or the type system's subtype check — not string matching.

3. **Emit extension-aware bridge code:** For each matching extension, add its methods/getters/setters to the class bridge's member list, annotated as extension members. Register them with D4rt's `findExtensionMember()` mechanism so the runtime can resolve them.

4. **Handle generic extensions:** Extensions like `extension on List<T>` must match `List<int>`, `List<String>`, etc. Use the analyzer's type system to check assignability, including generic type argument compatibility.

5. **Handle extension precedence:** When multiple extensions provide the same member name for a class, follow Dart's resolution rules (most specific type wins, then lexical scope order). Document cases where the bridge cannot fully replicate Dart's static resolution and falls back to a defined order.

6. **Scope the walk for performance:** Don't walk the entire transitive dependency graph. Walk only the direct and re-exported imports of the library being processed (matching how Dart's compiler resolves extensions). Cache the extension index per library to avoid redundant traversal.

This is the same "follow the imports like the compiler does" approach that also benefits GEN-008 (private SDK library mapping) and GEN-017 (barrel export resolution). Building this import-tree walker as a shared utility will pay dividends across multiple issues.

---

### GEN-050

**Operator methods emit invalid syntax (`t.<`, `t.>`)**

- **Complexity:** Medium
- **Status:** RESOLVED
- **Relevance:** Relevant

**Resolution (2026-02-09):**

Added operator detection and proper code generation in `bridge_generator.dart`:
- Added `_binaryOperators`, `_indexOperators`, `_unaryOperators` constant sets
- Added `_generateOperatorCall()` helper function that generates proper syntax:
  - Binary operators: `return (t as dynamic) $operatorName positional[0];`
  - Index operator `[]`: `return t[positional[0]];`
  - Index setter `[]=`: `t[positional[0]] = positional[1]; return null;`
  - Unary `~`: `return ~t;`
- Updated enum method generation (GEN-041) to use `_generateOperatorCall()`
- Updated extension method generation (GEN-047) to use `_generateOperatorCall()`
- The `as dynamic` cast is needed because we don't have parameter type info

**a) Problem:**

When the generator bridges comparison operators like `<`, `>`, `<=`, `>=`, `+`, `-`, etc., it emits method bridge code that is syntactically invalid. For example, for the `<` operator on `Comparable`, the generated code produces:

```dart
return Function.apply(t.<, positional, named?.map((k, v) => MapEntry(Symbol(k), v)));
```

This is invalid Dart syntax — `t.<` is not a valid expression. The operator method should be accessed via indexing syntax like `t.operator <` or the call should use a different bridging strategy (direct invocation or symbolic access).

**Example from `example_bridges.b.dart` line 96:**

```dart
'<': (t, positional, named) {
  return Function.apply(t.<, positional, named?.map((k, v) => MapEntry(Symbol(k), v)));
},
```

This causes compile errors:
- "Expected a type name"
- "Expected to find '>'"
- "Expected to find '['"

**b) Location:**

- Method bridging code generation in `bridge_generator.dart`
- Specifically where operator methods are emitted for classes implementing `Comparable`
- The issue is in how `_emitMethodBridge()` or similar handles operator names

**c) General Strategy:**

1. **Detect operator methods by name:** Check if the method name is an operator symbol (`<`, `>`, `+`, etc.)

2. **Use operator invocation syntax:** Instead of `Function.apply(t.<, ...)`, emit actual operator invocation:
   ```dart
   '<': (t, positional, named) {
     return t < positional[0];
   },
   ```

3. **Or use reflection-safe accessor:** If generic handling is needed, use `noSuchMethod` forwarding or a method reference accessor that doesn't require bare operator syntax.

4. **Consider skipping inherited operators:** The `<`, `>` operators come from `Comparable<T>` — if they're inherited and the class doesn't override them, they may not need explicit bridging since D4rt can dispatch via the type hierarchy.

---

### GEN-051

**Sealed class constructors incorrectly instantiated**

**Status:** RESOLVED (v1.5.2)

**Resolution:** Added `isSealed` property to `ClassInfo` and `_ParsedClass`. The generator now detects sealed classes by checking for `node.sealedKeyword != null` in both resolved and syntactic visitors. Constructor generation skips non-factory constructors for sealed classes, just like abstract classes.

**a) Problem:****

When the generator encounters a `sealed` class (Dart 3.0+), it generates a default factory accessor that attempts to call the class's default constructor. However, sealed classes are abstract by nature and cannot be directly instantiated — only their subtypes can be instantiated.

**Example from test output:**

```
lib/src/d4rt_bridges/dart_overview_bridges.b.dart:1699:21: Error: The class 
'SealedShape' is abstract and can't be instantiated.
    return $pkg.SealedShape();
                ^^^^^^^^^^^
```

This causes 46+ test failures in the dart_overview package tests because the generated bridge code contains invalid instantiation attempts.

**b) Location:**

- `bridge_generator.dart` — factory/constructor generation logic
- The generator needs to detect `sealed` class modifier and skip default constructor generation
- Similar to how `abstract` classes are handled, but requires checking for the `sealed` keyword

**c) General Strategy:**

1. **Detect sealed classes:** Check for `classDeclaration.sealedKeyword != null` or equivalent in the analyzer element

2. **Skip default constructor generation:** For sealed classes, do not emit factory accessors that attempt direct instantiation

3. **Consider subtype bridging:** The subtypes of a sealed class (final, base, or regular classes) should still be bridged normally

4. **Verification:** After fix, run `dart test` in `zom_workspaces/zom_analyzer_test/dart_overview` — all 46+ failures should be resolved

---

---

## Prompt

This document was generated by the prompt:

> Please convert the issues.md in a different format. I want a flat list: ID, description, complexity, status. Status can be: Won't Fix, TODO, Fixed. Then add a section with a) What exactly is the problem (clear description that illustrates the problem), b) Where does it appear/is it in the generator (if we can find out in reasonable time), c) Possible strategies how to fix this or at least improve this. The description in the table shall contain a link to the details section. Add this prompt to the bottom of the file.
