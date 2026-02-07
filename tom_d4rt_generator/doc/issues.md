# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-07

---

## Issue Index

| ID | Description | Complexity | Status |
|----|-------------|------------|--------|
| [GEN-001](#gen-001) | [Generic methods lose type parameters (type erasure)](#gen-001) | Fundamental | Won't Fix |
| [GEN-002](#gen-002) | [Recursive type bounds dispatched to only 3 hardcoded types](#gen-002) | Low | TODO |
| [GEN-003](#gen-003) | [Complex default values cannot be represented in generated code](#gen-003) | Fundamental | Won't Fix |
| [GEN-004](#gen-004) | [Combinatorial dispatch capped at 4 non-wrappable params](#gen-004) | Medium | Won't Fix |
| [GEN-005](#gen-005) | [Function types inside collections are unbridgeable](#gen-005) | High | TODO |
| [GEN-006](#gen-006) | [Syntactic fallback loses all resolved type information](#gen-006) | Fundamental | Won't Fix |
| [GEN-007](#gen-007) | [Function type alias detection limited to 7 hardcoded names](#gen-007) | Low | TODO |
| [GEN-008](#gen-008) | [Private SDK library mapping is hardcoded and incomplete](#gen-008) | Low | TODO |
| [GEN-009](#gen-009) | [Generic type parameter detection uses hardcoded name set](#gen-009) | Low | TODO |
| [GEN-010](#gen-010) | [Complex external packages list is hardcoded](#gen-010) | Low | TODO |
| [GEN-011](#gen-011) | [Global function/variable generation counts always report 0](#gen-011) | Low | TODO |
| [GEN-012](#gen-012) | [Type parameter substitution uses fragile regex text replacement](#gen-012) | Medium | TODO |
| [GEN-013](#gen-013) | [Build runner reports approximate class count (files × 10)](#gen-013) | Low | TODO |
| [GEN-014](#gen-014) | [Syntactic fallback: this.x params always typed as dynamic](#gen-014) | Fundamental | Won't Fix |
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
| [GEN-028](#gen-028) | [CLI didn't pass export filtering params to generator](#gen-028) | Medium | Fixed |
| [GEN-029](#gen-029) | [CLI path missing export info filtering for globals](#gen-029) | Medium | Fixed |
| [GEN-030](#gen-030) | [Multi-barrel modules only registered under primary barrel](#gen-030) | High | Fixed |

---

## Issue Details

---

### GEN-001

**Generic methods lose type parameters (type erasure)**

**a) Problem:**
When a Dart method has type parameters like `T add<T>(T item)`, the bridge generator cannot pass the actual type argument from the D4rt interpreter to the host Dart method. The generated bridge uses the type parameter's bound (or `dynamic` if unbounded). So `List<T>` becomes `List<dynamic>` at the bridge boundary. Scripts calling `list.cast<int>()` will compile in D4rt but the `int` type argument is lost when crossing to host Dart.

**b) Location:**
`bridge_generator.dart` ~line 82–87 — fields `hasTypeParameters` and `methodTypeParameters` on `BridgedMethodInfo`. The type parameter erasure happens throughout `_generateMethodBridge()` and `_getTypeArgument()`.

**c) Strategies:**
- **Won't Fix (fundamental):** Dart's reified generics require the type argument to be known at compile time at the call site. The interpreter dispatches at runtime and cannot synthesize a `Type` object that the host Dart VM accepts as a generic argument.
- **Mitigation:** For common cases, the generator already produces specialized overloads (e.g., `cast<int>`, `cast<String>`). Could extend the set of pre-specialized types via configuration.

---

### GEN-002

**Recursive type bounds dispatched to only 3 hardcoded types**

**a) Problem:**
For patterns like `T extends Comparable<T>`, the generator produces concrete dispatch variants for `num`, `String`, and `DateTime` only. If a D4rt script calls a method with `Duration` (which also implements `Comparable<Duration>`), the dispatch won't find a matching variant and will fall back to the `dynamic` path, potentially causing runtime type errors.

**b) Location:**
`bridge_generator.dart` ~line 730–760 — `recursiveBoundTypes` default list.

**c) Strategies:**
- Make `recursiveBoundTypes` configurable per-module in `build.yaml` / `BridgeConfig`. Users can add `Duration`, `BigInt`, or custom types as needed.
- Scan the bridged packages' own source for concrete types implementing the recursive bound and auto-add them.

---

### GEN-003

**Complex default values cannot be represented in generated code**

**a) Problem:**
Dart allows arbitrary compile-time constant expressions as default values, e.g. `void foo({Duration timeout = const Duration(seconds: 30)})` or `void bar({String id = _generateId()})`. The bridge generator lives in a different library and cannot evaluate these expressions. It can only represent simple literals (`42`, `'hello'`, `true`, `null`) and public const references. Anything else is a "non-wrappable default" — the generated code either omits the parameter (using combinatorial dispatch) or emits a `// TODO` comment.

**b) Location:**
`bridge_generator.dart` ~line 2820–2890 — default value analysis in `_analyzeDefaultValue()`. Non-wrappable defaults tracked in `_nonWrappableDefaultWarnings`.

**c) Strategies:**
- **Won't Fix (fundamental):** Cross-library default value evaluation is not possible in Dart without code generation that imports the original library — but the bridge *is* that generated code, creating a circular problem for private defaults.
- **Mitigation:** Combinatorial dispatch (2^N variants) works for up to 4 params (see GEN-004). Could also generate a thin forwarding function in the source package that exposes defaults explicitly.

---

### GEN-004

**Combinatorial dispatch capped at 4 non-wrappable params**

**a) Problem:**
When a method has N named parameters with non-wrappable defaults, the generator produces 2^N call variants (each variant either includes or omits each parameter). At N=4 this is 16 variants; at N=5 it's 32, growing exponentially. The generator caps at N≤4 — methods with 5+ non-wrappable defaults get no combinatorial dispatch at all.

**b) Location:**
`bridge_generator.dart` ~line 4440–4500 — the `nonWrappableDefaults.length <= 4` guard in `_generateMethodCallVariants()`.

**c) Strategies:**
- **Won't Fix (trade-off):** Raising the limit causes massive generated code bloat. 2^8 = 256 variants for a single method is impractical.
- **Alternative:** Generate a single call variant that uses `Function.apply` with a `Map<Symbol, dynamic>` for named params. This avoids the combinatorial explosion but loses compile-time type safety in the generated code.

---

### GEN-005

**Function types inside collections are unbridgeable**

**a) Problem:**
A parameter typed `List<void Function(int)>` requires converting each list element between a D4rt interpreter function and a host Dart closure. The bridge currently throws `UnimplementedError('Bridge cannot handle function types in collections')` at runtime when this is encountered.

**b) Location:**
`bridge_generator.dart` ~line 5050–5070 — in `_convertCollectionArgument()`.

**c) Strategies:**
- Generate a `.map()` wrapper that converts each element through `_wrapFunction()`, similar to how single function parameters are already wrapped.
- For `List<FnType>` and `Set<FnType>`, iterate and wrap. For `Map<K, FnType>`, wrap values (or keys if they're function types).
- Complexity is medium-high due to nested generics (e.g., `Map<String, List<void Function()>>`).

---

### GEN-006

**Syntactic fallback loses all resolved type information**

**a) Problem:**
When the Dart analyzer cannot produce a resolved AST for a source file (e.g., missing dependencies, analysis errors), the generator falls back to `_ClassVisitor` which parses the raw syntax tree only. This loses: type import URIs (so import prefixes can't be resolved), superclass/mixin type resolution, `this.x` and `super.x` parameter types (become `dynamic`), typedef expansion, and inherited members.

**b) Location:**
`bridge_generator.dart` ~line 2600–2630 — the fallback path in `_processSourceFile()`. `_ClassVisitor` defined at ~line 8200+.

**c) Strategies:**
- **Won't Fix (fundamental for the fallback path):** The fallback exists because analysis failed. By definition, resolved type info is unavailable.
- **Mitigation:** Improve analyzer reliability by ensuring all dependencies are resolvable. Add a `--strict` flag that fails instead of falling back, so users know when quality is degraded.
- Log which files used the fallback so users can investigate and fix the underlying analysis issue.

---

### GEN-007

**Function type alias detection limited to 7 hardcoded names**

**a) Problem:**
The syntactic fallback path recognizes only 7 function type aliases: `BridgeRegistrar`, `D4rtEvaluator`, `VoidCallback`, `ValueChanged`, `ValueGetter`, `ValueSetter`, `WidgetBuilder`. Any other typedef that resolves to a function type (e.g., `ErrorHandler`, `MapEventCallback`) won't get proper wrapper generation in the syntactic path, causing the parameter to be typed as the typedef name (which doesn't exist in the bridge's scope) rather than the expanded `Function` signature.

**b) Location:**
`bridge_generator.dart` ~line 6500–6510 — `_knownFunctionTypeAliases` set.

**c) Strategies:**
- Extend the hardcoded set with commonly used aliases from Flutter, dart:async, etc.
- Better: in the resolved path (which already handles this correctly), collect all encountered function typedefs and write them to a cache file. The syntactic fallback can then read this cache.
- Best: detect function type aliases dynamically by checking if the resolved type is a `FunctionType` regardless of its alias name.

---

### GEN-008

**Private SDK library mapping is hardcoded and incomplete**

**a) Problem:**
Dart types sometimes report their source as private SDK libraries like `dart:_http` or `dart:_internal`. The generator maps these to public equivalents (`dart:io`, `dart:core`). Unknown `dart:_*` libraries are silently skipped, meaning types originating from unmapped private libraries lose their import information.

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
`_isGenericTypeParameter` recognizes single uppercase letters (`T`, `E`, `K`, `V`, etc.) and a fixed set of multi-character names (`TValue`, `TKey`, `TResult`, `TElement`). Type parameters named `T1`, `T2`, `K2`, `V2`, `TItem`, `TOutput`, `TState`, etc. are **not recognized** and get treated as concrete types. This triggers false "Missing export" warnings and causes the type to be looked up in barrel exports (where it won't be found), falling back to `dynamic`.

**b) Location:**
`bridge_generator.dart` ~line 6210–6220 — `_isGenericTypeParameter()` method.

**c) Strategies:**
- Check against the enclosing class's or method's actual declared type parameters instead of using a name-based heuristic.
- As a quick fix: extend the heuristic to include numbered variants (`T1`, `T2`, `K2`, `V2`) and any name starting with `T` followed by an uppercase letter.
- In the resolved path, use `element.typeParameters` from the `ClassElement` or `MethodElement` for authoritative detection.

---

### GEN-010

**Complex external packages list is hardcoded**

**a) Problem:**
`_complexExternalPackages` hardcodes `pdf`, `printing`, `flutter`, `http`, `htmltopdfwidgets` for special type resolution handling. Any new external package requiring similar treatment needs a code change.

**b) Location:**
`bridge_generator.dart` ~line 2540 — `_complexExternalPackages` set.

**c) Strategies:**
- Move to `build.yaml` configuration as a `complexExternalPackages` list in the module config.
- Or remove the special handling entirely by making the general resolution path robust enough to handle these packages.

---

### GEN-011

**Global function/variable generation counts always report 0**

**a) Problem:**
`GenerationResult` hardcodes `globalFunctionsGenerated: 0` and `globalVariablesGenerated: 0` even though global functions and variables are actually generated. This makes generation reports inaccurate.

**b) Location:**
`bridge_generator.dart` ~line 1958–1959 — the `// TODO: count from globals` comments.

**c) Strategies:**
- Count globals during the generation loop and pass the counts to `GenerationResult`. Straightforward fix.

---

### GEN-012

**Type parameter substitution uses fragile regex text replacement**

**a) Problem:**
`_substituteTypeParameters` converts a `FunctionType`'s display string and uses `RegExp(r'\b' + name + r'\b')` to replace type parameter names with their concrete substitutions. This text-based approach can produce incorrect results when a type parameter name is a substring of another identifier (e.g., `T` matching inside `DateTime`) or appears in unexpected positions.

**b) Location:**
`bridge_generator.dart` ~line 7640–7650 — `_substituteTypeParameters()`.

**c) Strategies:**
- Walk the `FunctionType` structurally: iterate over `parameters` and `returnType`, substituting `TypeParameterType` instances directly rather than doing string replacement.
- Use the Dart analyzer's `Substitution.fromPairs()` utility if available.

---

### GEN-013

**Build runner reports approximate class count (files × 10)**

**a) Problem:**
In the build_runner integration path, the total class count is estimated as `packageFiles.length * 10`, which can be wildly inaccurate (a package with 5 files but 100 classes, or 50 files with 1 class each).

**b) Location:**
`per_package_orchestrator.dart` ~line 159 — `totalClasses = packageFiles.length * 10`.

**c) Strategies:**
- Accumulate actual class counts from each `GenerationResult` returned by `generateBridgesWithWriter()` and sum them.

---

### GEN-014

**Syntactic fallback: this.x params always typed as dynamic**

**a) Problem:**
In the syntactic fallback visitor, `FieldFormalParameter` (i.e., `this.fieldName`) without an explicit type annotation gets typed as `dynamic` because the visitor can't resolve the field's type without full analysis. The resolved visitor handles this correctly by looking up the field's declared type.

**b) Location:**
`bridge_generator.dart` ~line 8390–8400 — `_ClassVisitor._parseParameters()`.

**c) Strategies:**
- **Won't Fix (inherent to fallback):** Without a resolved AST, the field type is unknown. The syntactic visitor would need to find and parse the field declaration in the same class, which is fragile and incomplete for inherited fields.
- The resolved path handles this correctly, so the real mitigation is ensuring analysis succeeds.

---

### GEN-015

**Nested public classes collected by syntactic visitor**

**a) Problem:**
The syntactic visitor calls `super.visitClassDeclaration(node)` which recursively visits child nodes, including nested class declarations. A public class defined inside another class will be collected and bridged, even though it's not independently accessible from outside the enclosing class.

**b) Location:**
`bridge_generator.dart` ~line 8259 — end of `_ClassVisitor.visitClassDeclaration()`.

**c) Strategies:**
- Track nesting depth: only collect classes at depth 0 (top-level).
- Check `node.parent` — if it's another `ClassDeclaration`, skip collection.

---

### GEN-016

**Auxiliary imports may resolve wrong type on name collision**

**a) Problem:**
When a type isn't found in barrel exports, the generator falls back to resolving it from the source file's own imports (auxiliary imports). If two different packages export a type with the same name (e.g., both `package:http` and `package:dio` export `Response`), the auxiliary import system may pick the wrong one.

**b) Location:**
`bridge_generator.dart` ~line 3040–3100 — auxiliary import resolution in `_resolveAuxiliaryType()`.

**c) Strategies:**
- When multiple candidates exist, prefer the one from a package already in the module's `barrelFiles`.
- Emit a warning when ambiguous resolution occurs so users can add an explicit import mapping.

---

### GEN-017

**Missing barrel export silently downgrades to dynamic**

**a) Problem:**
When a type used in a method signature (parameter type, return type, or type argument) isn't exported from the module's barrel file, the generator logs a warning but proceeds with `dynamic`. The generated bridge compiles and runs, but loses type safety for that parameter. Users may not notice the warning among other generation output.

**b) Location:**
`bridge_generator.dart` ~line 3060 — `_recordMissingExport()` and the `dynamic` fallback.

**c) Strategies:**
- Add a `--strict-exports` flag that fails generation instead of falling back to `dynamic`.
- Generate a summary report at the end listing all dynamic fallbacks, grouped by affected class/method.
- In the generated bridge code, add a comment `/* was: OriginalType */` next to `dynamic` so the degradation is visible in code review.

---

### GEN-018

**Parameterized typedef expansion may produce incorrect types**

**a) Problem:**
When a typedef not exported from the barrel is expanded to its underlying function type, simple cases work (`VoidCallback` → `void Function()`). But parameterized typedefs like `typedef Converter<S, T> = T Function(S input)` may not expand correctly if the type arguments aren't properly substituted.

**b) Location:**
`bridge_generator.dart` ~line 5830–5910 — typedef expansion in `_expandTypedef()`.

**c) Strategies:**
- Use the resolved `FunctionType` from the analyzer (which already has type arguments applied) rather than manually expanding the typedef.
- Add test cases for parameterized typedef expansion.

---

### GEN-019

**Barrel preference heuristic may pick wrong barrel for re-exports**

**a) Problem:**
When a class is found in multiple barrel files, the generator prefers the barrel from the same package as the source file. This heuristic breaks when a type is intentionally re-exported under a different package's barrel (e.g., `package:flutter/material.dart` re-exporting `dart:ui` types — a script importing `material.dart` expects to find them there).

**b) Location:**
`per_package_orchestrator.dart` ~line 240–280 — barrel preference logic in `_assignBarrelForClass()`.

**c) Strategies:**
- Allow explicit barrel assignment overrides in `build.yaml` for specific classes.
- Consider the module's `barrelImport` as the primary barrel and always prefer it for types that appear in its export list.

---

### GEN-020

**Global exclusions merge across modules — accidental cross-filtering**

**a) Problem:**
All module-level `exclude` patterns are merged into a single global exclusion set before generation. An exclusion pattern like `*Exception` intended for one module will also exclude exception classes from every other module in the same project.

**b) Location:**
`per_package_orchestrator.dart` ~line 170–175 — exclusion aggregation.

**c) Strategies:**
- Apply exclusions per-module rather than globally: each module's exclusion patterns should only affect classes from that module's barrel packages.
- As a workaround, use `excludeSourcePatterns` (which filters by source URI) instead of `exclude` (which filters by class name) for module-specific exclusions.

---

### GEN-021

**Builder-defining packages unconditionally skipped for bridging**

**a) Problem:**
Packages whose `build.yaml` defines a `builders:` section are skipped entirely during bridge generation, to avoid generating bridges for code generator packages. However, a package that both defines a builder AND contains types that should be bridged (e.g., a package exposing both a generator and utility classes) will have its utility classes silently skipped.

**b) Location:**
`per_package_orchestrator.dart` ~line 780 — `isBuildYamlBuilderDefinition` check.

**c) Strategies:**
- Add a `forceInclude` list in module config to override the builder-definition skip for specific packages.
- Or only skip the builder's own source files, not the entire package.

---

### GEN-022

**Main generator file is 8,490 lines — maintainability concern**

**a) Problem:**
`bridge_generator.dart` contains the class visitor, type resolution, code emission, parameter parsing, import management, and combinatorial dispatch all in one file. This makes navigation, testing, and code review difficult.

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
Both `_ResolvedClassVisitor` and `_ClassVisitor` implement their own `_parseConstructor`, `_parseMethod`, `_parseField`, and `_parseParameters`. The resolved version is richer (accesses type elements, resolved types, source URIs) but the structural code is duplicated, making changes error-prone — a fix in one visitor may not be applied to the other.

**b) Location:**
`bridge_generator.dart` ~line 7400–7530 (resolved) and ~line 8200+ (syntactic).

**c) Strategies:**
- Create a shared base class or strategy pattern where the parsing logic is shared and only the type-resolution hooks differ.
- Alternatively, use a single visitor that receives a `TypeResolver` interface — the resolved version uses the analyzer, the syntactic version returns `dynamic`.

---

### GEN-024

**Four config sources with complex precedence rules**

**a) Problem:**
Configuration can come from CLI args, `tom_project.yaml`, `build.yaml`, and `d4rt_bridging.json`, with CLI taking highest precedence. The override semantics are subtle and not all combinations are tested — e.g., a `build.yaml` exclusion overridden by a `tom_project.yaml` inclusion may behave unexpectedly.

**b) Location:**
`d4rt_gen.dart` — CLI arg parsing. `bridge_config.dart` — config merging. `build.yaml` — primary module config.

**c) Strategies:**
- Add a `--dump-config` flag that prints the effective merged configuration, showing which source each value came from.
- Document the precedence rules in the user guide.
- Add integration tests covering config override scenarios.

---

### GEN-025

**Record types with nested functions may have edge cases**

**a) Problem:**
Dart 3 record type support was added relatively recently. Records containing function types as fields (e.g., `(int, void Function())`) or deeply nested records may not be fully handled, as the record type resolution code path is newer and less battle-tested.

**b) Location:**
`bridge_generator.dart` ~line 6130–6200 — record type handling in `_resolveRecordType()`.

**c) Strategies:**
- Add comprehensive test cases for records with function fields, nested records, named record fields, and record type aliases.
- Verify that record types in method signatures, return types, and default values all work correctly.

---

### GEN-026

**14 concrete types across projects silently downgraded to dynamic**

**a) Problem:**
During generation, 14 distinct concrete types produce "Missing export" warnings and get replaced with `dynamic`. These are types used in method signatures of bridged classes where the type comes from a dependency not included in the module's barrel exports.

Affected types:
- **tom_d4rt_dcli:** `Trace`, `SettingsYaml`, `ColumnComparator`, `CancelableLineAction`
- **tom_dartscript_bridges:** `RSAPublicKey`, `RSAPrivateKey`, `SecureRandom`, `JWT`, `JWTKey`, `JWTAlgorithm`, `Argon2Parameters`, `Invocation`, `MdPdfConverterOptions`, `LedgerData`

**b) Location:**
These warnings appear at generation runtime. The generator's `_recordMissingExport()` (see GEN-017) is triggered for each.

**c) Strategies:**
- For types from packages you control (`MdPdfConverterOptions`, `LedgerData`): add them to the barrel file's exports.
- For third-party types (`RSAPublicKey`, `JWT`, etc.): add the third-party package as an additional `barrelFiles` entry in the module config.
- For types that are rarely accessed from scripts: accept the `dynamic` fallback and document which methods are affected.

---

### GEN-027

**InvalidType warnings indicate analyzer resolution failures**

**a) Problem:**
`InvalidType` appears in warnings when the Dart analyzer cannot resolve a type at all. This is different from "missing export" — it means the analyzer itself failed to determine what the type is, possibly due to missing dependencies, circular imports, or analyzer bugs. The affected parameter becomes `dynamic`.

**b) Location:**
Appears at generation runtime across multiple projects (tom_d4rt_dcli, tom_dartscript_bridges). The generator encounters `InvalidType` from the analyzer's resolved AST.

**c) Strategies:**
- Investigate which specific methods trigger `InvalidType` and check their dependencies are properly resolvable.
- Ensure `dart pub get` has been run and all dependencies are available.
- If caused by analyzer bugs, consider filing issues against `package:analyzer`.

---

### GEN-028

**CLI didn't pass export filtering params to generator**

**a) Problem:**
The `_generateBridges` method in `d4rt_gen.dart` did not pass `followAllReExports`, `skipReExports`, `followReExports`, or `excludeSourcePatterns` from the module config to `generateBridgesFromExports()`. This meant the CLI code path always used defaults (`followAllReExports: true`), causing re-exports to be followed even when the config said not to — resulting in types from skipped packages appearing in generated code and causing compile errors.

**b) Location:**
`d4rt_gen.dart` ~line 764 — the `generateBridgesFromExports()` call in `_generateBridges()`.

**c) Resolution:**
Fixed 2026-02-07. All four parameters are now passed through from the module config.

---

### GEN-029

**CLI path missing export info filtering for globals**

**a) Problem:**
The `generateBridges()` method (used by the CLI code path) did not filter global functions, variables, or enums by export info show/hide clauses. The `generateBridgesWithWriter()` method (used by build_runner) already had this filtering. This meant the CLI path would generate bridges for globals that weren't actually exported from the barrel file, causing compile errors when the generated code referenced undefined names.

**b) Location:**
`bridge_generator.dart` ~line 1800–1830 — the globals processing loop in `generateBridges()`.

**c) Resolution:**
Fixed 2026-02-07. Added export info filtering for enums, functions, and variables in `generateBridges()`, matching the existing logic in `generateBridgesWithWriter()`.

---

### GEN-030

**Multi-barrel modules only registered under primary barrel**

**a) Problem:**
When a module has multiple barrel files (e.g., `package:dcli/dcli.dart` + `package:dcli_core/dcli_core.dart`), the generated `dartscript.b.dart` only called `registerBridges()` for the primary `barrelImport`. D4rt scripts that imported the secondary barrel path (e.g., `import 'package:dcli_core/dcli_core.dart'`) got a runtime `SourceCodeException: Module source not preloaded for URI`. Additionally, `getImportBlock()` only returned the primary barrel's import statement.

**b) Location:**
`file_generators.dart` ~line 107 — `generateDartscriptFileContent()`. `bridge_generator.dart` ~line 3870 — `getImportBlock()`.

**c) Resolution:**
Fixed 2026-02-07. `dartscript.b.dart` now registers bridges under ALL barrel import paths, and `getImportBlock()` generates import statements for all barrel files.

---

## Prompt

This document was generated by the prompt:

> Please convert the issues.md in a different format. I want a flat list: ID, description, complexity, status. Status can be: Won't Fix, TODO, Fixed. Then add a section with a) What exactly is the problem (clear description that illustrates the problem), b) Where does it appear/is it in the generator (if we can find out in reasonable time), c) Possible strategies how to fix this or at least improve this. The description in the table shall contain a link to the details section. Add this prompt to the bottom of the file.
