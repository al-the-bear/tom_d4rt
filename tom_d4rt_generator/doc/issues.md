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
| [GEN-065](#gen-065) | Super/field formals resolve to literal "InvalidType" | Medium | Generator | **OPEN** |
| [GEN-066](#gen-066) | Transitive dep types not replaced with dynamic | Medium | Generator | **OPEN** |
| [GEN-067](#gen-067) | Type erasure tests expect wrong import prefix | Low | Tests | **OPEN** |

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

## Open Issues

### GEN-065

**Super/field formal parameters resolve to literal "InvalidType"**

**Status:** FIXED (2026-02-15)

**a) Problem:**

When a constructor uses `super.paramName` or `this.paramName` syntax without an explicit type annotation, the Dart analyzer may return `InvalidType` for the resolved type. The generator then calls `getDisplayString()` on this, producing the literal string `"InvalidType"` in the generated code.

**b) Observed In:**

- `CatException(super.message, [super.stacktrace])` → generates `D4.getOptionalArg<$dcli_core_1.InvalidType>(...)`
- `DCliFunctionException(super.message, [super.stackTrace])` → same issue
- `DCliException.from(this.cause, this.stackTrace)` → `InvalidType` for `this.stackTrace` field formal
- Callback parameter types (shelf's `hijack`, mysql_client's connection params)

**c) Root Cause:**

Multiple code paths could produce `InvalidType`:
1. `SuperFormalParameter` and `FieldFormalParameter` handlers without `InvalidType` guard
2. Callback parameter types from `funcInfo.positionalParamTypes` used directly without resolution
3. Any code path through `_resolveTypeArgument` that receives `InvalidType`

**d) Fix Applied:**

- Added comprehensive `InvalidType` guard at TOP of `_resolveTypeArgument`: `if (baseType == 'InvalidType' || baseType.contains('InvalidType')) return 'dynamic'`
- Added defense-in-depth `InvalidType` checks in callback `typedParams` generation (2 locations)
- This catches ALL code paths: constructors, callbacks, type arguments, parameter types

---

### GEN-066

**Transitive dependency types not replaced with dynamic**

**Status:** FIXED (2026-02-15)

**a) Problem:**

Types from transitive dependencies (e.g., `Trace` from `package:stack_trace`, `SettingsYaml` from `package:settings_yaml`, `RSAPublicKey` from `package:pointycastle`) that are used as parameter or return types but not exported from the barrel file are emitted with import prefixes that don't actually export those types.

**b) Observed In:**

- `DCliException(this.message, [Trace? stackTrace])` → generates `$dcli_core_17.Trace?` but that import doesn't export `Trace`
- `RSAPublicKey`, `RSAPrivateKey`, `SecureRandom` from pointycastle used in tom_crypto

**c) Root Cause:**

Multiple sub-issues:
1. Import regex only matched single-quoted imports; `rsa_encryption.dart` uses double quotes
2. `_barrelExportsType` only followed 1 level of exports; pointycastle has 2-level chain
3. `SecureRandom` defined via `part` directives not scanned

**d) Fixes Applied:**

- Updated import regex in `_resolveTypeByImportTextScan` to match both `'` and `"` quotes
- Updated export regex in `_barrelExportsType` similarly
- Made `_barrelExportsType` recursive with `maxDepth=3`
- Added `part` file scanning in `_barrelExportsType`

---

### GEN-067

**Type erasure tests expect wrong import prefix for bounded generics**

**Status:** FIXED (2026-02-15)

**a) Problem:**

Three type_erasure_test.dart tests failed because bounded generic type parameters resolved through auxiliary imports instead of existing direct imports.

**c) Root Cause:**

`_globalTypeToUri` returned `file://` URIs but `_importPrefixes` keys used `package:` URIs. The mismatch caused `_getOrCreateAuxiliaryPrefix` to create unnecessary auxiliary prefixes.

**d) Fix Applied (GEN-068):**

Normalized `file://` URIs to `package:` URIs in the `_globalTypeToUri` code path before checking `_importPrefixes`. Types now correctly resolve to existing import prefixes.

---

### GEN-068

**Global URI normalization: file:// vs package:// mismatch creates unnecessary auxiliary imports**

**Status:** FIXED (2026-02-15)

**a) Problem:**

When the generator resolved types through `_globalTypeToUri`, the returned URIs were `file://` format from the analyzer, but `_importPrefixes` keys used `package:` format. The mismatch caused unnecessary `$aux_*` prefixes (e.g., `$aux_tom_core_kernel`) even when the type's file was already imported with a numbered prefix (e.g., `$tom_core_kernel_28`).

**b) Sub-issue (GEN-068b):**

`_resolveTypeFromSourceImports` sometimes returned barrel URIs (e.g., `package:tom_core_kernel/tom_core_kernel.dart`) which had no prefix in `_importPrefixes`. Before creating an auxiliary prefix, the code now checks `_globalTypeToUri` for the actual source file URI that may already be imported.

**c) Fix Applied:**

- Normalize `file://` → `package:` URI via `Uri.parse(globalUri).toFilePath()` → `_getPackageUri(localPath)` before checking `_importPrefixes`
- When `_resolveTypeFromSourceImports` returns a URI not in `_importPrefixes`, check `_globalTypeToUri` for a more specific URI that's already imported
- Check `_importPrefixes[resolvedGlobalUri]` BEFORE creating auxiliary imports

---

### GEN-069

**Exported types in record types with empty typeToUri resolve to dynamic**

**Status:** FIXED (2026-02-15)

**a) Problem:**

Types used inside record type fields (e.g., `ParsedHeadline` in `List<(ParsedHeadline, int, int)>`) resolved to `dynamic` when:
- `typeToUri` was empty (analyzer didn't provide type→URI mappings for the method)
- The type was defined in the same file as `sourceFilePath`
- `_isTypeExported()` returned true, causing the sourceFilePath prefix block to be skipped

**b) Observed In:**

`MarkdownParser.calculateMaxDepth(List<(ParsedHeadline, int, int)> headlines)` → generated `D4.coerceList<(dynamic, int startLine, int endLine)>` instead of `D4.coerceList<($tom_build_4.ParsedHeadline, int startLine, int endLine)>`

**c) Root Cause:**

For exported types, the code skipped the sourceFilePath prefix (assuming sourceFilePath points to the using class, not the type's file). But when the type is defined in the SAME file as the using class, sourceFilePath IS correct. The secondary fallback `sourceFilePath.startsWith(workspacePath)` also failed because `workspacePath` was relative (`.`) while `sourceFilePath` was absolute.

**d) Fix Applied:**

Added unconditional last-resort check of `_importPrefixes[_getPackageUri(sourceFilePath)]` before falling through to `dynamic`. This catches types defined in the same file as the method being bridged.

---

## Summary

**Total open issues:** 0

**Total fixed issues:** 15 (GEN-055 through GEN-069, G-DCLI-05/07/08/11/12/13/14)

**Current test status (2026-02-15):**
- D4rt generator tests: 461 passed, 0 failed
- DCli scripting guide tests: 13 passed, 0 failed
- All bridge files compile clean (0 errors in dcli, tom_core_kernel, tom_core_server, tom_build bridges)
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
| GEN-065 | `bridge_generator.dart` | Comprehensive `InvalidType` guard in `_resolveTypeArgument` + callback typedParams |
| GEN-066 | `bridge_generator.dart` | Double-quote import regex, recursive `_barrelExportsType` with part scanning |
| GEN-067 | `bridge_generator.dart` + `type_erasure_test.dart` | Fixed by GEN-068 URI normalization |
| GEN-068 | `bridge_generator.dart` | `file://` → `package:` URI normalization in `_globalTypeToUri` path |
| GEN-068b | `bridge_generator.dart` | Barrel URI fallback through `_globalTypeToUri` in `_resolveTypeFromSourceImports` path |
| GEN-069 | `bridge_generator.dart` | Last-resort sourceFilePath prefix for exported types in record types |

### Generator Improvements Needed

The following manual bridge patches should be addressed in the generator long-term:

1. **Callback parameters**: Generator should emit `D4.callInterpreterCallback()` instead of `(x as InterpretedFunction).call()` for function-typed parameters
2. **Typed list parameters**: Generator should use `D4.coerceList<T>()` for `List<T>` parameters where T is a bridged type
3. **Return type bridging**: Generator should detect and bridge return types even when not in barrel show clauses (partially fixed by GEN-055)
