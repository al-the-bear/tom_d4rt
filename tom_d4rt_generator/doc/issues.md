# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-14
> 
> Identified from DCli scripting guide e2e test failures.

---

## Issue Index

| ID | Description | Complexity | Component | Status |
|----|-------------|------------|-----------|--------|
| [G-DCLI-05](#g-dcli-05) | ProgressBothImpl.lines not accessible via bridge | Medium | Interpreter | Open |
| [G-DCLI-07](#g-dcli-07) | Generator picks wrong find() function (dcli_core vs dcli) | Medium | Generator | Open |
| [G-DCLI-08](#g-dcli-08) | RunException not caught in try/catch blocks | Medium | Interpreter | Open |
| [G-DCLI-11](#g-dcli-11) | find().forEach() fails - wrong function resolved | Medium | Generator | Open |
| [G-DCLI-12](#g-dcli-12) | CopyException not caught in try/catch blocks | Medium | Interpreter | Open |
| [G-DCLI-14](#g-dcli-14) | Shell pipe execution with runInShell: true broken | Medium | Interpreter | Open |
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

## Issue Details

### DCli Scripting Guide E2E Tests

These tests exercise DCli package functionality through the D4rt bridge. Test scripts are located in `example/d4_test_scripts/bin/dcli_scripting_guide/`.

---

#### G-DCLI-05

**ProgressBothImpl.lines not accessible via bridge**

**a) Problem:**

When calling `run()` to execute a shell command that returns `Progress`, accessing `.lines` fails because DCli returns a `ProgressBothImpl` internal class which is a subclass of `ProgressImpl`. The interpreter cannot find the `lines` property because no bridge is registered for `ProgressBothImpl`.

**Error:**
```
Error: Failed to find property 'lines' for [object ProgressBothImpl]
```

**Test script:** `05_capturing_output.dart`
```dart
final Progress result = run('ls -la', progress: Progress.print());
print('Output lines: ${result.lines.length}');
```

**b) Root Cause:**

The interpreter's property access logic looks up the bridge for the exact runtime type (`ProgressBothImpl`). DCli's internal implementation classes are not exported or bridged. The interpreter should fall back to checking parent class bridges when the exact type isn't found.

**c) Location:**
- Interpreter: `tom_d4rt/lib/src/interpreter_visitor.dart` — property access resolution
- Related: `BridgedInstance` type hierarchy handling

**d) Resolution Strategy:**
1. Modify interpreter property access to walk the type hierarchy
2. When `BridgedClass` for exact type isn't found, check `superclass` and `interfaces`
3. Find first ancestor with a registered bridge and use that bridge's property accessor

---

#### G-DCLI-07

**Generator picks wrong find() function (dcli_core vs dcli)**

**a) Problem:**

The bridge generator incorrectly resolves `find()` to `dcli_core`'s version which requires a `progress` callback parameter, instead of `dcli`'s version which returns a `FindProgress` object.

**Error:**
```
Error: find: Missing required named argument (progress)
```

**Test script:** `07_file_operations.dart`
```dart
final files = find('*.txt', workingDirectory: testDir);
for (final file in files) {
  print('Found: $file');
}
```

**b) Root Cause:**

Both `dcli` and `dcli_core` export a `find()` function:
- `dcli_core`: `void find(String pattern, {required void Function(FindItem) progress, ...})`
- `dcli`: `FindProgress find(String pattern, {...})` — returns iterable result

The generator picks `dcli_core`'s version (possibly due to alphabetical ordering or import order). The bridge code calls `ext_dcli_core_find.find()` which has a different signature than what scripts expect.

**c) Location:**
- Generator: `lib/src/bridge_generator.dart` — global function resolution when multiple packages export same name
- Generated bridge: `dcli_bridges.b.dart` lines ~478-520

**d) Resolution Strategy:**
1. Add disambiguation logic to prefer the "main" package (`dcli`) over its helper package (`dcli_core`)
2. Or: Add explicit package preference configuration in bridge generation config
3. Or: Generate overloads for both signatures (complex)

**Related:** G-DCLI-11 (same root cause)

---

#### G-DCLI-08

**RunException not caught in try/catch blocks**

**a) Problem:**

When a command fails via `run()`, DCli throws `RunException`. The interpreter's try/catch block doesn't catch this exception, and it propagates as an unhandled error.

**Error:**
```
Error: 'package:dcli_core/src/functions/run.dart': Failed to import 'run.dart': 
Exception: false_command: No such file or directory
```

**Test script:** `08_error_handling.dart`
```dart
try {
  run('false_command');
} on RunException catch (e) {
  print('Command failed: ${e.message}');
}
```

**b) Root Cause:**

The interpreter's exception handling doesn't properly match bridged exception types against `on Type catch` clauses. When the native DCli code throws `RunException`, the interpreter doesn't recognize it should be caught by the `on RunException catch` handler.

**c) Location:**
- Interpreter: `tom_d4rt/lib/src/interpreter_visitor.dart` — try/catch exception matching
- Related: Exception type comparison between native and bridged types

**d) Resolution Strategy:**
1. In catch clause evaluation, compare exception's `runtimeType` against bridged type
2. Use `BridgedClass.nativeType` for comparison when catch type is a bridged class
3. Ensure exception is properly wrapped/unwrapped for catch block evaluation

**Related:** G-DCLI-12 (same root cause)

---

#### G-DCLI-11

**find().forEach() fails - wrong function resolved**

**a) Problem:**

Same root cause as G-DCLI-07. Script uses `find()` expecting `FindProgress` return type which supports iteration, but generator bridges `dcli_core.find()` which requires callback.

**Error:**
```
Error: find: Missing required named argument (progress)
```

**Test script:** `11_find_files.dart`
```dart
find('*.dart', workingDirectory: testDir).forEach((file) {
  print('Dart file: $file');
});
```

**b) Location:**
- Same as G-DCLI-07

**c) Resolution Strategy:**
- Same as G-DCLI-07

---

#### G-DCLI-12

**CopyException not caught in try/catch blocks**

**a) Problem:**

Same root cause as G-DCLI-08. When `copy()` fails with invalid path, DCli throws `CopyException` which isn't caught.

**Error:**
```
Error: 'package:dcli/src/functions/copy.dart': Failed to import 'copy.dart': 
CopyException: The from file /non/existent/file.txt does not exist.
/non/existent/file.txt -> /tmp/backup.txt
```

**Test script:** `12_copy_operations.dart`
```dart
try {
  copy('/non/existent/file.txt', '/tmp/backup.txt');
} on CopyException catch (e) {
  print('Copy failed: ${e.message}');
}
```

**b) Location:**
- Same as G-DCLI-08

**c) Resolution Strategy:**
- Same as G-DCLI-08

---

#### G-DCLI-14

**Shell pipe execution with runInShell: true broken**

**a) Problem:**

Using shell features like pipes (`|`) with `runInShell: true` doesn't execute correctly. The command output doesn't show expected piped results.

**Test script:** `14_shell_execution.dart`
```dart
final result = run(
  'echo "hello world" | tr a-z A-Z',
  runInShell: true,
  progress: Progress.capture(),
);
print('Result: ${result.lines.join()}');
```

**b) Root Cause:**

The `runInShell: true` parameter may not be properly passed through the bridge, or the shell invocation doesn't correctly process the piped command string.

**c) Location:**
- Bridge: `dcli_bridges.b.dart` — `run()` function bridge
- Interpreter: Process execution handling

**d) Resolution Strategy:**
1. Verify `runInShell` parameter is correctly extracted and passed to native `run()`
2. Check if shell invocation wraps command correctly for the target platform
3. Test native DCli `run()` directly to confirm expected behavior

---

## Summary

**Total open issues:** 6

| Component | Count | Issues |
|-----------|-------|--------|
| Interpreter | 4 | G-DCLI-05, G-DCLI-08, G-DCLI-12, G-DCLI-14 |
| Generator | 2 | G-DCLI-07, G-DCLI-11 |

**Issue Categories:**

| Category | Issues | Description |
|----------|--------|-------------|
| Type hierarchy | G-DCLI-05 | Interpreter doesn't find parent class bridge for internal subclasses |
| Function resolution | G-DCLI-07, G-DCLI-11 | Generator picks wrong function when multiple packages export same name |
| Exception handling | G-DCLI-08, G-DCLI-12 | Interpreter doesn't match bridged exception types in catch clauses |
| Shell execution | G-DCLI-14 | Shell pipe processing with runInShell parameter |

**Current test status (2026-02-13):**
- DCli scripting guide tests: 7 passed, 6 failed
- Overall tom_d4rt_generator tests: 438 passed, 6 failed
