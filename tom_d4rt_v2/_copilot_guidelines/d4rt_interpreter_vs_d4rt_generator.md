# D4rt Interpreter vs Generator Boundary

This document clarifies which code in tom_d4rt is **generator support code** (placed here for convenience) versus **pure interpreter logic**.

---

## Why This Matters

When bugs are found, they need to be tracked in the correct issue tracker:

| Issue Type | Track In |
|------------|----------|
| Generator support code bugs | `tom_d4rt_generator/doc/issues.md` |
| Interpreter logic bugs | `tom_d4rt/doc/issues.md` or `tom_d4rt/doc/d4rt_limitations.md` |

---

## Generator Support Code (in this package)

The `lib/src/generator/` folder contains code that **supports generated bridges**, not the interpreter itself.

### `generator/d4.dart` — D4 Helper Class

Static methods used by all generated bridge code:

```dart
// In generated bridge code:
final t = D4.validateTarget<MyClass>(target, 'MyClass');
final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MyClass');
final items = D4.coerceList<Item>(positional[0], 'items');
```

**Key methods:**
- `D4.validateTarget<T>()` — Validate instance method target
- `D4.getRequiredArg<T>()` / `D4.getOptionalArg<T>()` — Extract positional args
- `D4.getNamedArg<T>()` — Extract named args
- `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` — Type coercion for collections
- `D4.extractBridgedArg<T>()` — Extract and validate bridged argument

**Current issues in D4 class:**
- `extractBridgedArg<double>` doesn't handle int→double promotion
- `extractBridgedArg<List<T>>` doesn't handle collection type casting
- `extractBridgedArg` doesn't handle InterpretedRecord→native record conversion

These are logged in `tom_d4rt_generator/doc/issues.md` (not here) because they affect bridge behavior.

### `generator/d4rt_user_bridge_annotation.dart`

Annotations for user-defined bridge overrides:

- `@D4rtUserBridge(libraryPath)` — Mark a class as a user bridge override
- `@D4rtGlobalsUserBridge(libraryPath)` — Mark a class as a globals bridge override
- `D4UserBridge` — Base class for user bridge implementations

---

## Bridge Type Infrastructure

These files define types used by **both** generated code and the interpreter:

### `bridge/registration.dart`

Adapter type definitions:
- `BridgedConstructorCallable` — Constructor adapters
- `BridgedMethodAdapter` — Instance method adapters
- `BridgedStaticMethodAdapter` — Static method adapters
- `BridgedInstanceGetterAdapter` / `BridgedInstanceSetterAdapter` — Property adapters
- `BridgedStaticGetterAdapter` / `BridgedStaticSetterAdapter` — Static property adapters

### `bridge/bridged_types.dart`

Core bridge types:
- `BridgedClass` — Definition of a bridged native class
- `BridgedInstance` — Runtime wrapper for bridged object instances
- `BridgedMixin` — Definition of a bridged native mixin
- `BridgedExtension` — Definition of a bridged extension

### `bridge/bridged_enum.dart`

Enum types:
- `BridgedEnum` — Definition of a bridged enum
- `BridgedEnumValue` — Runtime wrapper for enum values

---

## Script Execution Support

The `script_execution.dart` file provides utilities for file-based script execution, useful for **testing**:

- `executeFile()` — Execute a script file with fresh interpreter state
- `executeFileContinued()` — Execute a script file in current environment
- `resolveImportsRecursively()` — Resolve relative imports
- `ScriptExecutionResult` — Result container

---

## Pure Interpreter Logic

Everything else in `lib/src/` is pure interpreter code:

| File | Purpose |
|------|---------|
| `interpreter_visitor.dart` | Main AST evaluation visitor |
| `runtime_types.dart` | Interpreted class/function runtime types |
| `environment.dart` | Variable binding and scope management |
| `callable.dart` | Function/method invocation handling |
| `declaration_visitor.dart` | Declaration processing |
| `module_loader.dart` | Import/export handling |
| `stdlib/` | Standard library bridges |

Bugs in these files should be tracked in `tom_d4rt/doc/issues.md` or `tom_d4rt/doc/d4rt_limitations.md`.

---

## See Also

- Global guidelines: `_copilot_guidelines/d4rt_interpreter_vs_d4rt_generator.md`
- Generator issues: `tom_d4rt_generator/doc/issues.md`
- Interpreter issues: `tom_d4rt/doc/issues.md`
- Fixed bugs/limitations: `tom_d4rt/doc/d4rt_limitations.md`
