# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-14
> 
> Identified from DCli scripting guide e2e test failures.

---

## Issue Index

| ID | Description | Complexity | Component | Status |
|----|-------------|------------|-----------|--------|
| [G-DCLI-05](#g-dcli-05) | ProgressBothImpl.lines not accessible via bridge | Medium | Interpreter | **FIXED** |
| [G-DCLI-07](#g-dcli-07) | forEach callback cast fails for NativeFunction | Medium | Generator | **FIXED** |
| [G-DCLI-08](#g-dcli-08) | RunException not caught in try/catch blocks | Medium | Interpreter | **FIXED** |
| [G-DCLI-11](#g-dcli-11) | find() types parameter list coercion fails | Medium | Generator | **FIXED** |
| [G-DCLI-12](#g-dcli-12) | CopyException not caught in try/catch blocks | Medium | Interpreter | **FIXED** |
| [G-DCLI-13](#g-dcli-13) | Which class not bridged (which().path fails) | Medium | Generator | **FIXED** |
| [G-DCLI-14](#g-dcli-14) | Test expectations wrong for runInShell behavior | Low | Test | **FIXED** |
| [GEN-055](#gen-055) | Return types not collected from API surface | Medium | Generator | **FIXED** |
| [GEN-056](#gen-056) | Extension on-type not resolvable at runtime | Medium | Interpreter | **FIXED** |

---

## Resolved Issues

### GEN-055

**Return types not collected from API surface**

**Status:** FIXED (2026-02-13)

**a) Problem:**

Types returned by bridged functions (e.g., `FindProgress` from `find()`) were not being collected and bridged because they weren't in the barrel's show clause.

**b) Root Cause:**

`_collectAuxiliaryImportsFromTypes()` only processed parameter types, not return types.

**c) Resolution:**

Added `_collectApiSurfaceTypeDependencies()` helper to collect return types and parameter types from kept functions. Also added `_forceCreateAuxiliaryPrefix()` to create direct imports bypassing barrel prefix.

---

### GEN-056

**Extension on-type not resolvable at runtime**

**Status:** FIXED (2026-02-14)

**a) Problem:**

Extensions on types from external libraries (e.g., `extension PlatformEx on Platform`) cannot be used because the interpreter cannot resolve the on-type at runtime. When a bridged package (e.g., DCli) defines an extension on a type from a different module (e.g., `Platform` from `dart:io`), and the user script doesn't explicitly import that module, the on-type resolution fails.

**Error:**
```
Could not resolve type 'Platform' for extension 'PlatformEx'.
```

**b) Root Cause:**

The module_loader's extension registration code tried `globalEnvironment.get(onTypeName)` to find the RuntimeType for the extension's on-type. But stdlib types (like `Platform` from `dart:io`) are only loaded when their module is explicitly imported. Bridge packages that depend on stdlib types transitively (as DCli depends on dart:io) couldn't resolve their extension on-types.

**c) Resolution:**

Added `_resolveTypeForExtension()` fallback method to ModuleLoader that:
1. Searches all registered BridgedClass definitions from `bridgedClases` list
2. Auto-loads known stdlib modules (dart:io, dart:math, dart:convert, dart:collection, dart:typed_data) until the type is found

This mirrors real Dart behavior where transitive dependencies are automatically available.

**d) Tests:**
- `tom_d4rt/test/bridge/extension_on_stdlib_type_test.dart` — 5 test cases covering stdlib types, bridge-to-bridge types, and unknown types

---

## Open Issues

None — all issues resolved.

---

## Issue Details

### DCli Scripting Guide E2E Tests

These tests exercise DCli package functionality through the D4rt bridge. Test scripts are located in `example/d4_test_scripts/bin/dcli_scripting_guide/`.

---

#### G-DCLI-05

**ProgressBothImpl.lines not accessible via bridge**

**Status:** FIXED (2026-02-14)

**a) Problem:**

When calling `run()` to execute a shell command that returns `Progress`, accessing `.lines` fails because DCli returns a `ProgressBothImpl` internal class which is a subclass of `ProgressImpl`. The interpreter cannot find the `lines` property because no bridge is registered for `ProgressBothImpl`.

**b) Root Cause:**

`environment.dart`'s `toBridgedClass()` couldn't match `ProgressBothImpl` to the `Progress` bridge. The type doesn't start with `_` so the underscore-stripping logic was skipped.

**c) Resolution:**

Added prefix-matching fallback to `toBridgedClass()` in `environment.dart`. When all existing lookups fail, it tries to find a registered bridge whose name (>= 3 chars) is a prefix of the native type name. E.g., `ProgressBothImpl` matches bridge `Progress`.

---

#### G-DCLI-07

**forEach callback cast fails for NativeFunction**

**Status:** FIXED (2026-02-14)

**a) Problem:**

The `forEach()` bridge for StringAsProcess, Progress, FindProgress, HeadProgress, and TailProgress casts callbacks as `InterpretedFunction`. But built-in functions like `print` are `NativeFunction`, causing cast failures.

**Error:**
```
type 'NativeFunction' is not a subtype of type 'InterpretedFunction' in type cast
```

**b) Root Cause:**

Generated bridge code used `(callbackRaw as InterpretedFunction).call(visitor, args)` which fails for any non-interpreted callback (NativeFunction, or any Callable).

**c) Resolution:**

1. Added `D4.callInterpreterCallback(visitor, callback, args)` helper to `d4.dart` that handles `InterpretedFunction`, `NativeFunction`, and any `Callable`
2. Updated all forEach bridges in `dcli_bridges.b.dart` to use `D4.callInterpreterCallback()` instead of direct casts
3. **Note:** This is a manual patch to generated code. The generator should be updated to produce `D4.callInterpreterCallback()` for callback parameters.

---

#### G-DCLI-08

**RunException not caught in try/catch blocks**

**Status:** FIXED (2026-02-14)

**a) Problem:**

When a command fails via `run()`, DCli throws `RunException`. The interpreter's try/catch block doesn't catch this exception.

**b) Root Cause:**

`visitTryStatement` in `interpreter_visitor.dart` only handled `InterpretedClass` in the default case of catch clause type matching. Native exceptions like `RunException` have `BridgedClass` registrations, not `InterpretedClass`.

**c) Resolution:**

Added `else if (targetType is BridgedClass)` branch in `visitTryStatement` that uses `globalEnvironment.toBridgedClass(originalThrownValue.runtimeType)` to match native exceptions against bridged types. Also added special cases for common exception types (`Exception`, `Error`, `FormatException`, `StateError`, `ArgumentError`, `RangeError`, `TypeError`, `UnsupportedError`).

**Related:** G-DCLI-12 (same fix)

---

#### G-DCLI-11

**find() types parameter list coercion fails**

**Status:** FIXED (2026-02-14)

**a) Problem:**

The `find()` function bridge uses `D4.getRequiredNamedArg<List<FileSystemEntityType>>()` for the `types` parameter, which fails because the interpreter creates `List<Object?>` with `BridgedEnumValue` elements.

**Error:**
```
Invalid parameter "types": expected List<FileSystemEntityType>, got List<Object?>
```

**b) Root Cause:**

Two issues: (1) `getRequiredNamedArg` does a direct type cast which fails for `List<Object?>`→`List<FileSystemEntityType>`, and (2) enum values come through as `BridgedEnumValue` wrappers, not native enum values.

**c) Resolution:**

1. Used `D4.coerceList<FileSystemEntityType>()` instead of `getRequiredNamedArg<List<...>>()` for both the `find()` function and `FindProgress` constructor bridges
2. Added `BridgedEnumValue` unwrapping (via `.nativeValue`) to `D4.extractBridgedArg()` and `D4.coerceList()`

---

#### G-DCLI-12

**CopyException not caught in try/catch blocks**

**Status:** FIXED (2026-02-14)

**a) Problem:**

Same root cause as G-DCLI-08. When `copy()` fails with invalid path, DCli throws `CopyException` which isn't caught.

**b) Resolution:**

Same fix as G-DCLI-08. Also updated test script to work around DCli `nothrow` behavior (which only suppresses non-zero exit codes, not "command not found" errors).

---

#### G-DCLI-13

**Which class not bridged (which().path fails)**

**Status:** FIXED (2026-02-14)

**a) Problem:**

The `which()` function returns a native `Which` object, but no `BridgedClass` was generated for `Which`. Accessing `.path`, `.found`, `.paths`, or `.notfound` on the result failed.

**Error:**
```
Undefined property or method 'path' on Which.
```

**b) Root Cause:**

The `Which` class is exported from `dcli_core` but not from `dcli`'s barrel (it's commented out in the show clause). The generator didn't generate a bridge for it.

**c) Resolution:**

Manually added `_createWhichBridge()` to `dcli_bridges.b.dart` with getters for `path`, `paths`, `found`, and `notfound`. Added import for `package:dcli_core/src/functions/which.dart`.

**Note:** The generator should be updated to detect return types of bridged functions and automatically bridge them even when not in the barrel's show clause.

---

#### G-DCLI-14

**Test expectations wrong for runInShell behavior**

**Status:** FIXED (2026-02-14)

**a) Problem:**

Test script expected DCli's `runInShell: true` to enable shell features (pipes, variable expansion, redirects), but DCli's `runInShell` doesn't actually route through a shell. This was verified by testing natively — same behavior.

**b) Root Cause:**

Test script had incorrect expectations about DCli's API behavior. The `runInShell` parameter in DCli doesn't correspond to `Process.start(runInShell: true)` — it's a DCli-level concept.

**c) Resolution:**

Rewrote test script to demonstrate what DCli actually supports: `.run` extension, `run()` with `nothrow`, `start()` with `Progress.capture()`, and `run()` with `workingDirectory`.

---

## Summary

**Total open issues:** 0 (all resolved)

**Current test status (2026-02-14):**
- DCli scripting guide tests: 13 passed, 0 failed
- All 9 issues resolved (GEN-055, GEN-056, G-DCLI-05/07/08/11/12/13/14)

### Fix Locations

| Fix | File | Description |
|-----|------|-------------|
| G-DCLI-05 | `tom_d4rt/lib/src/environment.dart` | Prefix-matching fallback in `toBridgedClass()` |
| G-DCLI-07 | `dcli_bridges.b.dart` + `d4.dart` | `D4.callInterpreterCallback()` for forEach |
| G-DCLI-08/12 | `tom_d4rt/lib/src/interpreter_visitor.dart` | BridgedClass handling in `visitTryStatement` catch |
| G-DCLI-11 | `dcli_bridges.b.dart` + `d4.dart` | `D4.coerceList()` + BridgedEnumValue unwrapping |
| G-DCLI-13 | `dcli_bridges.b.dart` | Added `_createWhichBridge()` |
| G-DCLI-14 | `14_shell_execution.dart` | Fixed test expectations |
| GEN-055 | `bridge_generator.dart` | Return type collection |
| GEN-056 | `module_loader.dart` | `_resolveTypeForExtension()` |

### Generator Improvements Needed

The following manual bridge patches should be addressed in the generator long-term:

1. **Callback parameters**: Generator should emit `D4.callInterpreterCallback()` instead of `(x as InterpretedFunction).call()` for function-typed parameters
2. **Typed list parameters**: Generator should use `D4.coerceList<T>()` for `List<T>` parameters where T is a bridged type
3. **Return type bridging**: Generator should detect and bridge return types even when not in barrel show clauses (partially fixed by GEN-055)
