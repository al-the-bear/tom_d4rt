# D4rt Bridge Generator - TODO Items

This document tracks unbridgeable parameter types reported during bridge generation that may need manual intervention or future generator improvements.

**Log file:** [tom_generation_log.txt](tom_generation_log.txt)

---

## Summary of Unbridgeable Function Types

The generator currently cannot automatically bridge parameters with function types. These require either:
1. Manual UserBridge overrides
2. Future generator enhancements to support function type bridging
3. Wrapper classes that convert function types

---

## Issues by Project

### tom_core_kernel

| Class/Method | Parameter | Function Type | Priority |
|--------------|-----------|---------------|----------|
| `firstWhere` | `orElse` | `dynamic Function()?` | Medium |
| `lastWhere` | `orElse` | `dynamic Function()?` | Medium |
| `singleWhere` | `orElse` | `dynamic Function()?` | Medium |
| `update` | `ifAbsent` | `V Function()?` | Medium |

**Analysis:** These are standard Dart collection methods. The `orElse` parameter provides a fallback value when no match is found. Scripts can work around this by catching exceptions or checking conditions before calling.

---

### tom_core_server

| Class | Parameter | Function Type | Priority |
|-------|-----------|---------------|----------|
| `TomDbColumn` | `fromDbConverter` | `DART_TYPE Function(COL_TYPE)?` | Low |
| `TomDbColumn` | `toDbConverter` | `COL_TYPE Function(DART_TYPE)?` | Low |
| `TomPersistenceEventHandler` | `postPersist` | `void Function(DBTYPE)?` | Low |
| `TomPersistenceEventHandler` | `postLoad` | `void Function(DBTYPE)?` | Low |
| `TomPersistenceEventHandler` | `preLoad` | `void Function(DBTYPE)?` | Low |
| `TomPersistenceEventHandler` | `prePersist` | `void Function(DBTYPE)?` | Low |

**Analysis:** These are ORM/persistence configuration classes with generic type parameters. Function callbacks are used for type conversion and lifecycle hooks. Low priority as these are typically configured in native Dart code, not scripts.

---

### tom_core_flutter

| Class | Parameter | Function Type | Priority |
|-------|-----------|---------------|----------|
| `TomObservingWidget` | `child` | `Widget Function(T)` | Medium |
| `TomObservingWidgetState` | `child` | `Widget Function(T)` | Medium |
| `TomField` | `valueConverter` | `T Function(String)?` | Medium |
| `TomField` | `valueToTextConverter` | `String Function(T)?` | Medium |
| `TomField` | `inputValidator` | `String? Function(String)?` | Medium |
| `TomField` | `valueValidator` | `String? Function(String)?` | Medium |

**Analysis:** Flutter widget builders and form field validators. These are commonly needed in UI scripting scenarios. Consider:
- Adding support for simple `Widget Function(T)` patterns
- Providing pre-built validator functions that can be selected by name

---

### tom_build

| Class | Parameter | Function Type | Priority |
|-------|-----------|---------------|----------|
| `D4rtRunner` | `evaluator` | `D4rtEvaluator?` | Low |

**Analysis:** This is a type alias for an evaluator function. Low priority as this is infrastructure code.

---

## Potential Solutions

### Option 1: Function Wrapper Bridge

Create a `BridgedFunction` class that wraps D4rt-interpreted functions and allows them to be passed as callbacks:

```dart
// Native side
class BridgedFunction<R, A> {
  final D4rt interpreter;
  final String functionName;
  
  R call(A arg) {
    return interpreter.eval('$functionName($arg)') as R;
  }
}
```

### Option 2: Named Callback Registry

Register named callbacks that scripts can reference by string:

```dart
// Script
widget.setCallback('onTap', 'myTapHandler');

// Generated bridge
interpreter.registerCallback('myTapHandler', () => handleTap());
```

### Option 3: UserBridge Overrides

For specific high-priority cases, provide pre-built UserBridge overrides:

```dart
class IterableUserBridge extends D4UserBridge {
  static Object? overrideMethodFirstWhere(...) {
    // Handle orElse by catching exceptions
  }
}
```

---

## Action Items

- [ ] Investigate feasibility of BridgedFunction approach for simple function types
- [ ] Consider adding `orElse` overrides for collection methods as they're commonly used
- [ ] Document workarounds for function-type parameters in user guide
- [ ] Add configuration option to suppress function-type warnings for known patterns

---

## Non-Wrappable Default Values

### The Problem

When a function/method parameter has a default value, the generator needs to copy that default value into the generated bridge code. However, not all default values can be safely copied because they may reference symbols that:

1. Are not accessible from the generated bridge code
2. Require specific import prefixes
3. Are private to the source package
4. Involve complex expressions that can't be evaluated at code-generation time

### What Can Be Wrapped (Literals)

The following default values can be safely copied to generated code:

- **Null literals**: `null`
- **Boolean literals**: `true`, `false`
- **String literals**: `'hello'`, `"world"`
- **Numeric literals**: `42`, `3.14`
- **Empty collections**: `[]`, `{}`, `<String>[]`, `<String, int>{}`

These are self-contained and don't depend on any external symbols.

### What Cannot Be Wrapped

The following default values cannot be safely copied:

| Type | Example | Reason |
|------|---------|--------|
| Static members | `TomUser.guestUsername` | Requires import prefix and may not be exported |
| Const constructors | `const Duration(seconds: 30)` | Requires import and class access |
| Function calls | `DateTime.now()` | Cannot evaluate at generation time |
| Private identifiers | `_defaultValue` | Not accessible from generated code |
| Expressions with operators | `1 + 2`, `a ?? b` | May reference external symbols |
| Qualified identifiers | `math.pi` | Requires specific import prefix |
| Const collections with values | `const ['a', 'b']` | May contain non-wrappable values |

### Current Behavior

When a non-wrappable default is encountered, the generator:

1. Adds a TODO comment in the generated code
2. Uses `D4.getRequiredNamedArgTodoDefault<T>()` or `D4.getRequiredArgTodoDefault<T>()` helper
3. This makes the parameter **required** in the bridge, even though it's optional in the original

```dart
// Generated code for non-wrappable default
// TODO: Non-wrappable default: TomUser.guestUsername
final username = D4.getRequiredNamedArgTodoDefault<String>(
  named, 'username', 'createUser', 'TomUser.guestUsername');
```

### Impact

Scripts calling bridged functions with non-wrappable defaults must provide a value, even if the original function had a default. This is a breaking API change from the script's perspective.

### Potential Solutions

1. **Prefix resolution**: Extend `_prefixDefaultValue()` to handle static members from the source package by adding the `$source.` prefix
2. **Const expression evaluation**: Evaluate simple const expressions at generation time
3. **UserBridge overrides**: Allow users to provide the correct default in a UserBridge class
4. **Configuration file**: Allow specifying default values in a configuration file for common cases

### Action Items

- [ ] Emit warnings during generation for non-wrappable defaults (not just TODO comments)
- [ ] Consider extending `_prefixDefaultValue()` to handle source package static members
- [ ] Document workarounds in user guide
- [ ] Add configuration option to specify defaults for known cases

---

## Missing Exports Problem

### The Problem

The bridge generator scans all files referenced by the barrel export file, but not all types used in public APIs are necessarily exported from the barrel. When a type is:

1. Used as a parameter type, return type, or field type in a bridged class
2. Not exported from the barrel file

The generator cannot resolve its type correctly because it imports the barrel file, not individual source files.

### Current Behavior

The generator tries to prefix types with `$source.` but if the type isn't exported, Dart compilation fails with "Undefined name 'TypeName'" or similar errors.

### Recommended Solution

1. Detect when a type is referenced but not exported from the barrel
2. Add a TODO comment in generated code
3. Fall back to using `dynamic` as the type
4. Output a warning during generation

```dart
// TODO: Type 'ParsedHeadline' is not exported from barrel file
final headline = D4.getRequiredArg<dynamic>(positional, 0, 'headline', 'parseSection');
```

### Action Items

- [ ] Add detection for missing exports during generation
- [ ] Emit warning for each missing export
- [ ] Fall back to `dynamic` for missing types
- [ ] Consider adding `@export` annotation support for explicit inclusion

---

## Duplicate Class Names

### The Problem

When two classes with the same name exist in different files within a package, the bridge generator cannot disambiguate them because it imports through a single barrel file.

### How D4rt Handles Import Prefixes

D4rt **fully supports** import prefixes, hide, and show combinators:

1. **Prefixed imports**: When a script uses `import 'package:foo/bar.dart' as bar;`, D4rt creates a prefixed environment and stores it in `_prefixedImports` map

2. **Symbol resolution**: When encountering `bar.SomeClass`, the `visitPrefixedIdentifier` method:
   - Resolves the prefix to an Environment
   - Looks up `SomeClass` within that prefixed environment
   - Returns the correct class/function/value

3. **Show/Hide combinators**: The `ModuleLoader` processes `ShowCombinator` and `HideCombinator` to filter which symbols are imported

### Bridge Registration Model

Bridged classes are registered with a **library URI**:

```dart
interpreter.registerBridgedClass(myBridgedClass, 'package:myapp/types.dart');
```

When the script imports that library, the class becomes available. If two classes have the same name but different library URIs, they can both be registered - but scripts must use different import URIs to access them.

### The Generator's Limitation

The current generator uses a single barrel file for all classes, which means:

1. All bridged classes get registered under the same library URI
2. If two source classes have the same name, they conflict
3. Even with prefixes, the barrel re-exports can't distinguish them

### Solutions

| Approach | Description | Complexity |
|----------|-------------|------------|
| **Rename in source** | Ensure unique class names across the package | Source change |
| **Consolidate duplicates** | If classes are truly duplicates, merge them | Source change |
| **Multi-barrel generation** | Generate separate bridge files for each sub-barrel | Generator change |
| **Per-file registration** | Register classes with their actual file URIs, not barrel | Generator change |
| **Namespace prefixes** | Add package/folder prefix to bridged class names | Generator change |
| **Exclude duplicates** | Skip duplicate classes with a warning | Generator change |

### Recommendation

For the tom_build package specifically:
- `ValidationError` and `ProcessedTemplate` appear to be actual duplicates that should be renamed or consolidated
- `ProjectInfo` and `WorkspaceModes` may need domain-specific naming

For the generator long-term, consider supporting per-file or sub-barrel registration.

---

## Notes

- Function types with generic parameters (e.g., `T Function(String)`) are particularly challenging
- Void callbacks (`void Function()`) are simpler and may be addressable first
- Some function types could potentially be bridged if D4rt supports callable objects
