# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-07

---

## Issue Index

| ID | Description | Complexity | Status |
|----|-------------|------------|--------|
| [GEN-028](#gen-028) | [CLI didn't pass export filtering params to generator](#gen-028) | Medium | Fixed |
| [GEN-029](#gen-029) | [CLI path missing export info filtering for globals](#gen-029) | Medium | Fixed |
| [GEN-030](#gen-030) | [Multi-barrel modules only registered under primary barrel](#gen-030) | High | Fixed |
| [GEN-001](#gen-001) | [Generic methods lose type parameters (type erasure)](#gen-001) | Fundamental | Won't Fix |
| [GEN-003](#gen-003) | [Complex default values cannot be represented in generated code](#gen-003) | Fundamental | Won't Fix |
| [GEN-004](#gen-004) | [Combinatorial dispatch capped at 4 non-wrappable params](#gen-004) | Medium | Won't Fix |
| [GEN-006](#gen-006) | [Syntactic fallback loses all resolved type information](#gen-006) | Fundamental | Won't Fix |
| [GEN-014](#gen-014) | [Syntactic fallback: this.x params always typed as dynamic](#gen-014) | Fundamental | Won't Fix |
| [GEN-002](#gen-002) | [Recursive type bounds dispatched to only 3 hardcoded types](#gen-002) | Low | TODO |
| [GEN-005](#gen-005) | [Function types inside collections are unbridgeable](#gen-005) | High | TODO |
| [GEN-007](#gen-007) | [Function type alias detection limited to 7 hardcoded names](#gen-007) | Low | TODO |
| [GEN-008](#gen-008) | [Private SDK library mapping is hardcoded and incomplete](#gen-008) | Low | TODO |
| [GEN-009](#gen-009) | [Generic type parameter detection uses hardcoded name set](#gen-009) | Low | TODO |
| [GEN-010](#gen-010) | [Complex external packages list is hardcoded](#gen-010) | Low | TODO |
| [GEN-011](#gen-011) | [Global function/variable generation counts always report 0](#gen-011) | Low | TODO |
| [GEN-012](#gen-012) | [Type parameter substitution uses fragile regex text replacement](#gen-012) | Medium | TODO |
| [GEN-013](#gen-013) | [Build runner reports approximate class count (files × 10)](#gen-013) | Low | TODO |
| [GEN-015](#gen-015) | [Nested public classes collected by syntactic visitor](#gen-015) | Low | TODO |
| [GEN-016](#gen-016) | [Auxiliary imports may resolve wrong type on name collision](#gen-016) | Medium | TODO |
| [GEN-017](#gen-017) | [Missing barrel export silently downgrades to dynamic](#gen-017) | Medium | TODO |
| [GEN-018](#gen-018) | [Parameterized typedef expansion may produce incorrect types](#gen-018) | Medium | TODO |
| [GEN-019](#gen-019) | [Barrel preference heuristic may pick wrong barrel for re-exports](#gen-019) | Medium | TODO |
| [GEN-020](#gen-020) | [Global exclusions merge across modules — accidental cross-filtering](#gen-020) | Medium | TODO |
| [GEN-021](#gen-021) | [Builder-defining packages unconditionally skipped for bridging](#gen-021) | Low | TODO |
| [GEN-022](#gen-022) | [Main generator file is 8,490 lines — maintainability concern](#gen-022) | High | TODO |
| [GEN-023](#gen-023) | [Duplicated visitor logic between resolved and syntactic paths](#gen-023) | High | TODO |
| [GEN-024](#gen-024) | [Four config sources with complex precedence rules](#gen-024) | Medium | TODO |
| [GEN-025](#gen-025) | [Record types with nested functions may have edge cases](#gen-025) | Medium | TODO |
| [GEN-026](#gen-026) | [14 concrete types across projects silently downgraded to dynamic](#gen-026) | Medium | TODO |
| [GEN-027](#gen-027) | [InvalidType warnings indicate analyzer resolution failures](#gen-027) | Medium | TODO |

---

## Issue Details

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

### GEN-002

**Recursive type bounds dispatched to only 3 hardcoded types**

**a) Problem:**

When a method has a type parameter with a recursive bound like `T extends Comparable<T>`, the generator cannot use `<dynamic>` (since `dynamic` doesn't implement `Comparable<dynamic>`). Instead, it generates concrete dispatch variants that test the runtime type and call the method with the matching type argument. However, only 3 types are dispatched by default:

**Generator source (bridge_generator.dart):**
```dart
static const List<String> _defaultRecursiveBoundTypes = [
  'num',
  'String',
  'DateTime',
];
```

**Generated dispatch code pattern:**
```dart
final sample = positional[0];
if (sample is num) {
  return someMethod<num>(sample);
}
if (sample is String) {
  return someMethod<String>(sample);
}
if (sample is DateTime) {
  return someMethod<DateTime>(sample);
}
throw ArgumentError('someMethod: Unsupported type for Comparable<T>: ${sample.runtimeType}');
```

**Where the problem manifests:** If a D4rt script calls a method requiring `T extends Comparable<T>` with a `Duration` value (which implements `Comparable<Duration>`), the dispatch won't find a matching variant and throws an `ArgumentError` at runtime. The same applies to `BigInt`, `bool`, or any custom `Comparable` implementation.

**b) Location:**
`bridge_generator.dart` ~line 730–760 — `_defaultRecursiveBoundTypes` list; recursive bound detection in `_getRecursiveBoundTypeParams()`; dispatch generation that iterates `recursiveBoundTypes` and generates `if (sample is X)` blocks with a final `throw ArgumentError(...)` fallback.

**c) Strategies:**
- Make `recursiveBoundTypes` configurable per-module in `build.yaml` / `BridgeConfig`. Users can add `Duration`, `BigInt`, or custom types as needed.
- Scan the bridged packages' own source for concrete types implementing the recursive bound and auto-add them.

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

**c) Strategies:**
- Generate a `.map()` wrapper that converts each element through `_wrapFunction()`, similar to how single function parameters are already wrapped.
- For `List<FnType>` and `Set<FnType>`, iterate and wrap. For `Map<K, FnType>`, wrap values (or keys if they're function types).
- Complexity is medium-high due to nested generics (e.g., `Map<String, List<void Function()>>`).

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

**c) Strategies:**
- Extend the hardcoded set with commonly used aliases from Flutter, dart:async, etc.
- Better: in the resolved path (which already handles this correctly), collect all encountered function typedefs and write them to a cache file. The syntactic fallback can then read this cache.
- Best: detect function type aliases dynamically by checking if the resolved type is a `FunctionType` regardless of its alias name.

---

### GEN-008

**Private SDK library mapping is hardcoded and incomplete**

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

**c) Strategies:**
- Maintain the mapping as a configuration file rather than hardcoded map, making it easy to update per Dart SDK version.
- Log unmapped `dart:_*` libraries as warnings so users are aware of potential type information loss.
- Research: the Dart SDK's `package:_fe_analyzer_shared` may provide an authoritative mapping.

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

**c) Strategies:**
- Check against the enclosing class's or method's actual declared type parameters instead of using a name-based heuristic.
- As a quick fix: extend the heuristic to include numbered variants (`T1`, `T2`, `K2`, `V2`) and any name starting with `T` followed by an uppercase letter.
- In the resolved path, use `element.typeParameters` from the `ClassElement` or `MethodElement` for authoritative detection.

---

### GEN-010

**Complex external packages list is hardcoded**

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

**c) Strategies:**
- Move to `build.yaml` configuration as a `complexExternalPackages` list in the module config.
- Or remove the special handling entirely by making the general resolution path robust enough to handle these packages.

---

### GEN-011

**Global function/variable generation counts always report 0**

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

**c) Strategies:**
- Count globals during the generation loop and pass the counts to `GenerationResult`. Straightforward fix.

---

### GEN-012

**Type parameter substitution uses fragile regex text replacement**

**a) Problem:**

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

**c) Strategies:**
- Walk the `FunctionType` structurally: iterate over `parameters` and `returnType`, substituting `TypeParameterType` instances directly rather than doing string replacement.
- Use the Dart analyzer's `Substitution.fromPairs()` utility if available.

---

### GEN-013

**Build runner reports approximate class count (files × 10)**

**a) Problem:**

In the build_runner integration path, the total class count for progress reporting is estimated rather than counted:

**Generator source (per_package_orchestrator.dart):**
```dart
totalClasses = packageFiles.length * 10;  // assume 10 classes per file
```

**Where the problem manifests:** Progress output shows "Processing class 45/500" where 500 is a wild guess (50 files × 10). The real count might be 72 or 300. This is cosmetic — it doesn't affect generated code — but makes progress bars jump from 45% to "done" or appear stuck at 99% for a long time.

**b) Location:**
`per_package_orchestrator.dart` ~line 159 — `totalClasses = packageFiles.length * 10`.

**c) Strategies:**
- Accumulate actual class counts from each `GenerationResult` returned by `generateBridgesWithWriter()` and sum them.

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

### GEN-015

**Nested public classes collected by syntactic visitor**

**a) Problem:**

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

**c) Strategies:**
- Track nesting depth: only collect classes at depth 0 (top-level).
- Check `node.parent` — if it's another `ClassDeclaration`, skip collection.

---

### GEN-016

**Auxiliary imports may resolve wrong type on name collision**

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

**c) Strategies:**
- When multiple candidates exist, prefer the one from a package already in the module's `barrelFiles`.
- Emit a warning when ambiguous resolution occurs so users can add an explicit import mapping.

---

### GEN-017

**Missing barrel export silently downgrades to dynamic**

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

### GEN-018

**Parameterized typedef expansion may produce incorrect types**

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

**c) Strategies:**
- Use the resolved `FunctionType` from the analyzer (which already has type arguments applied) rather than manually expanding the typedef.
- Add test cases for parameterized typedef expansion.

---

### GEN-019

**Barrel preference heuristic may pick wrong barrel for re-exports**

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

**c) Strategies:**
- Allow explicit barrel assignment overrides in `build.yaml` for specific classes.
- Consider the module's `barrelImport` as the primary barrel and always prefer it for types that appear in its export list.

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

**c) Strategies:**
- Apply exclusions per-module rather than globally: each module's exclusion patterns should only affect classes from that module's barrel packages.
- As a workaround, use `excludeSourcePatterns` (which filters by source URI) instead of `exclude` (which filters by class name) for module-specific exclusions.

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

**c) Strategies:**
- Add a `forceInclude` list in module config to override the builder-definition skip for specific packages.
- Or only skip the builder's own source files, not the entire package.

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

**c) Strategies:**
- Extract `_ResolvedClassVisitor` and `_ClassVisitor` into separate files.
- Extract code emission (the actual Dart code string generation) into a `bridge_code_emitter.dart`.
- Extract type resolution logic (`_getTypeArgument`, `_resolveImportPrefix`, etc.) into `bridge_type_resolver.dart`.
- Extract parameter/default-value analysis into `bridge_parameter_analyzer.dart`.

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

**c) Strategies:**
- Create a shared base class or strategy pattern where the parsing logic is shared and only the type-resolution hooks differ.
- Alternatively, use a single visitor that receives a `TypeResolver` interface — the resolved version uses the analyzer, the syntactic version returns `dynamic`.

---

### GEN-024

**Four config sources with complex precedence rules**

**a) Problem:**

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

**c) Strategies:**
- Add a `--dump-config` flag that prints the effective merged configuration, showing which source each value came from.
- Document the precedence rules in the user guide.
- Add integration tests covering config override scenarios.

---

### GEN-025

**Record types with nested functions may have edge cases**

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

**c) Strategies:**
- Add comprehensive test cases for records with function fields, nested records, named record fields, and record type aliases.
- Verify that record types in method signatures, return types, and default values all work correctly.

---

### GEN-026

**14 concrete types across projects silently downgraded to dynamic**

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

**c) Strategies:**
- For types from packages you control (`MdPdfConverterOptions`, `LedgerData`): add them to the barrel file's exports.
- For third-party types (`RSAPublicKey`, `JWT`, etc.): add the third-party package as an additional `barrelFiles` entry in the module config.
- For types that are rarely accessed from scripts: accept the `dynamic` fallback and document which methods are affected.

---

### GEN-027

**InvalidType warnings indicate analyzer resolution failures**

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

**c) Strategies:**
- Investigate which specific methods trigger `InvalidType` and check their dependencies are properly resolvable.
- Ensure `dart pub get` has been run and all dependencies are available.
- If caused by analyzer bugs, consider filing issues against `package:analyzer`.

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

## Prompt

This document was generated by the prompt:

> Please convert the issues.md in a different format. I want a flat list: ID, description, complexity, status. Status can be: Won't Fix, TODO, Fixed. Then add a section with a) What exactly is the problem (clear description that illustrates the problem), b) Where does it appear/is it in the generator (if we can find out in reasonable time), c) Possible strategies how to fix this or at least improve this. The description in the table shall contain a link to the details section. Add this prompt to the bottom of the file.
