# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-07

This document catalogs known issues, limitations, workarounds, and fundamental technical constraints in the D4rt bridge generator.

---

## 1. Fundamental Technical Constraints

These are inherent to bridging a Dart-in-Dart interpreter with host Dart and **cannot be fully solved**.

### 1.1 Type Erasure for Generic Methods

**File:** `bridge_generator.dart` ~line 82–87

Methods with type parameters (`<T>`) are bridged using their bounds, falling back to `dynamic`. The D4rt interpreter cannot perform full generic dispatch at runtime because there is no way to receive reified type arguments from the bridged call.

**Impact:** Generic methods work but lose type safety — `List<T>` becomes `List<dynamic>` at the bridge boundary.

### 1.2 Recursive Type Bound Dispatch Limited to 3 Types

**File:** `bridge_generator.dart` ~line 730–760

For patterns like `T extends Comparable<T>`, the generator dispatches to a hardcoded set of `[num, String, DateTime]`. Any other type satisfying the recursive bound (e.g., `Duration`) won't be dispatched correctly.

**Partially fixable:** The set is configurable, but a fully general solution would require runtime type introspection the interpreter doesn't support.

### 1.3 Non-Wrappable Default Values

**File:** `bridge_generator.dart` ~line 2820–2890

Complex default values that involve function calls (e.g., `DateTime.now()`), class static members, private identifiers, or const collections cannot be represented in generated code. The generator detects these and either:
- Uses **combinatorial dispatch** (generates 2^N call variants that omit/include the parameter)
- Emits a `// TODO: Non-wrappable default` comment in the generated code

**Unfixable in general:** Dart's default value expressions are compile-time only; generated code in a different library can't evaluate arbitrary expressions from the source library.

### 1.4 Combinatorial Dispatch Capped at ≤4 Non-Wrappable Params

**File:** `bridge_generator.dart` ~line 4440–4500

When a method has named parameters with non-wrappable defaults, the generator produces 2^N call variants. This is limited to `N ≤ 4` (16 variants max). Methods exceeding 4 non-wrappable defaults get no combinatorial dispatch — they use the TODO fallback instead.

**Trade-off by design:** Raising the limit causes exponential code growth.

### 1.5 Function Types Inside Collections Are Unbridgeable

**File:** `bridge_generator.dart` ~line 5050–5070

`List<SomeFunctionType>` (and similar collection-of-function-type patterns) throws `UnimplementedError` at runtime. The bridge cannot map between interpreter function objects and host Dart function types within collection elements.

**Hard to fix:** Would require deep per-element conversion logic mapping through function wrappers.

### 1.6 Syntactic Fallback Loses All Resolved Type Info

**File:** `bridge_generator.dart` ~line 2600–2630

When the Dart analyzer fails to produce a resolved AST for a source file, the generator falls back to `_ClassVisitor` (syntactic-only parsing). This loses:
- Type import URIs
- Superclass/mixin URIs
- `this.x` / `super.x` parameter types (fall back to `dynamic`)
- Typedef expansion info
- Inherited member collection

**Unfixable for the fallback path** — the fallback exists precisely because analysis failed. Mitigation: improve analyzer reliability or configuration.

---

## 2. Hardcoded Values / Magic Constants

Maintenance-sensitive values that may need updating when new Dart APIs or patterns are encountered.

### 2.1 Known Function Type Aliases — Fixed Set of 7

**File:** `bridge_generator.dart` ~line 6500–6510

Only these function type aliases are recognized for wrapper generation:
`BridgeRegistrar`, `D4rtEvaluator`, `VoidCallback`, `ValueChanged`, `ValueGetter`, `ValueSetter`, `WidgetBuilder`

Any other typedef resolving to a function type (e.g., `MapEventCallback`, `ErrorHandler`) won't get proper wrapper generation in the syntactic fallback path. The resolved path handles these better.

**Fix:** Extend the set, or detect function type aliases dynamically from resolved types.

### 2.2 Private SDK Library Mapping

**File:** `bridge_generator.dart` ~line 625–650

`mapPrivateSdkLibrary()` maps private SDK libraries to their public equivalents:
- `dart:_http` → `dart:io`
- `dart:_internal` → `dart:core`
- etc.

Unknown `dart:_*` libraries are silently skipped, potentially losing type information. This mapping may need updating across Dart SDK versions.

### 2.3 Generic Type Parameter Detection Uses Hardcoded Names

**File:** `bridge_generator.dart` ~line 6210–6220

`_isGenericTypeParameter` checks for single uppercase letters OR specific names: `{TValue, TKey, TResult, TElement}`.

Multi-character type parameter names not in this set (e.g., `TItem`, `TOutput`, `TState`) will **not** be recognized as generic parameters, causing them to be treated as concrete types and potentially generating incorrect imports or casts.

**Fix:** Use a heuristic (e.g., starts with `T` followed by uppercase) or check against the class's declared type parameters.

### 2.4 Complex External Packages — Fixed List

**File:** `bridge_generator.dart` ~line 2540

`_complexExternalPackages` hardcodes: `pdf`, `printing`, `flutter`, `http`, `htmltopdfwidgets`. These packages get special handling for complex type resolution. Adding a new complex external package requires a code change.

**Fix:** Move to build.yaml configuration.

### 2.5 Recursive Bound Types — Default Set

**File:** `bridge_generator.dart` ~line 730–760

Default dispatch types `[num, String, DateTime]` for recursive bounds like `T extends Comparable<T>`. Should be configurable per-module in `BridgeConfig`.

---

## 3. Known Bugs / Incomplete Implementations

### 3.1 Global Function/Variable Count Not Tracked

**File:** `bridge_generator.dart` ~line 1958–1959

```dart
globalFunctionsGenerated: 0, // TODO: count from globals
globalVariablesGenerated: 0, // TODO: count from globals
```

`GenerationResult` always reports 0 for global counts. The actual count is never computed.

**Severity:** Low — cosmetic/reporting only.

### 3.2 Type Parameter Substitution Uses Regex Text Replacement

**File:** `bridge_generator.dart` ~line 7640–7650

`_substituteTypeParameters` for `FunctionType` uses regex replacement on the display string rather than structural substitution through the type tree. This can produce incorrect substitutions when:
- Names are substrings of other identifiers
- Names appear in string literals

**Fix:** Recursively substitute through `FunctionType` parameter/return types structurally.

### 3.3 Build Runner Reports Approximate Class Count

**File:** `per_package_orchestrator.dart` ~line 159

```dart
totalClasses = packageFiles.length * 10; // Approximation for now
```

The builder reports an approximate class count by multiplying file count by 10. Misleading in logs.

### 3.4 Syntactic Fallback: `this.x` Parameters Always Get `dynamic`

**File:** `bridge_generator.dart` ~line 8390–8400

In the syntactic fallback, `FieldFormalParameter` without an explicit type annotation always gets `dynamic` instead of the field's actual type. The resolved visitor handles this correctly.

**Inherent to fallback** — can't resolve field types without full analysis.

### 3.5 Nested Public Classes May Be Collected by Syntactic Visitor

**File:** `bridge_generator.dart` ~line 8259

`super.visitClassDeclaration(node)` recursively visits nested classes. If a public class is nested inside another class, it will be collected even though nested classes aren't independently accessible from the bridge.

**Severity:** Low — nested public classes are rare in practice.

---

## 4. Workarounds & Engineering Compromises

### 4.1 Auxiliary Imports System

**File:** `bridge_generator.dart` ~line 3040–3100

Types not exported from a barrel but used in default values get auto-resolved from the source file's own imports. This works around packages that don't re-export all types used in their public API.

**Risk:** May resolve the wrong type if multiple packages export the same name.

### 4.2 Missing Export → `dynamic` Fallback

**File:** `bridge_generator.dart` ~line 3060

When a type used in a method signature isn't found in the barrel exports, a warning is logged and `dynamic` is used instead.

**Risk:** Silently degrades type safety. Users may not notice warnings.

### 4.3 Typedef Expansion Fallback

**File:** `bridge_generator.dart` ~line 5830–5910

When a typedef is not exported from the barrel, the generator expands it to its underlying function type (e.g., `VoidCallback` → `void Function()`).

**Risk:** Works for simple typedefs; parameterized typedefs may expand incorrectly.

### 4.4 Barrel Preference Heuristic

**File:** `per_package_orchestrator.dart` ~line 240–280

When a class appears in multiple barrels, the generator prefers the barrel from the same package as the source file.

**Risk:** May pick the wrong barrel for re-exported types intentionally exposed under a different import.

### 4.5 Global Exclusion Aggregation

**File:** `per_package_orchestrator.dart` ~line 170–175

All module-level exclusion patterns are merged globally when generating per-package bridges.

**Risk:** An exclusion intended for one module may accidentally exclude a class that another module needs.

### 4.6 Builder Definition Skip

**File:** `per_package_orchestrator.dart` ~line 780

`isBuildYamlBuilderDefinition` skips packages whose `build.yaml` defines a builder (to avoid generating bridges for generator packages themselves).

**Risk:** A package that both defines a builder AND needs bridges would be incorrectly skipped.

---

## 5. Maintenance Concerns

### 5.1 Main Generator File Size

`bridge_generator.dart` is ~8,490 lines. The `_ResolvedClassVisitor` and code-generation logic are tightly coupled. Extracting type resolution, code emission, and parameter parsing into separate files would improve maintainability.

### 5.2 Duplicated Visitor Logic

**File:** `bridge_generator.dart` ~line 7400–7530

Both `_ResolvedClassVisitor` (resolved AST) and `_ClassVisitor` (syntactic AST) have their own `_parseConstructor`, `_parseMethod`, `_parseField`, and `_parseParameters` implementations. A shared base class or strategy pattern could reduce duplication.

### 5.3 Configuration Precedence Complexity

**File:** `d4rt_gen.dart`, `bridge_config.dart`

Four config sources with subtle override semantics: CLI args > `tom_project.yaml` > `build.yaml` > `d4rt_bridging.json`. Not all paths are equally tested.

### 5.4 Record Type Support

**File:** `bridge_generator.dart` ~line 6130–6200

Dart 3 record type resolution is a newer code path that may have edge cases with deeply nested records or records containing function types.

---

## 6. Recently Fixed Issues (2026-02-07)

These were discovered and fixed in the current session:

| Bug | Description | Fix |
|-----|-------------|-----|
| **CLI missing parameters** | `d4rt_gen.dart` `_generateBridges()` didn't pass `followAllReExports`, `skipReExports`, `followReExports`, `excludeSourcePatterns` | Parameters now passed through |
| **Export info filtering for globals** | `generateBridges()` (CLI path) didn't filter global functions/variables/enums by export info show/hide | Filtering added, matching `generateBridgesWithWriter()` |
| **Multi-barrel registration** | Only primary `barrelImport` was registered with interpreter; secondary barrel paths caused runtime `SourceCodeException` | All barrel import paths now registered; `getImportBlock()` returns all barrel imports |
