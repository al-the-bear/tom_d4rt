# D4rt Bridge Generator — Testing Strategy

This document describes the end-to-end testing strategy for the D4rt bridge generator (`tom_d4rt_generator`). It covers the D4rtTester infrastructure, test script conventions, user bridge verification, and issue tracking workflow.

---

## Overview

The bridge generator tests use a **subprocess-based end-to-end strategy**: bridges are generated in-memory, a test runner is produced, and D4rt scripts are executed in a subprocess with structured output capture. This validates the full pipeline from config loading through bridge generation to runtime execution.

**Key principle:** Tests exist to find bugs, not to work around them. When a test reveals a generator defect, document it in `doc/issues.md` — do not modify tests to avoid the failure.

**Test coverage tracking:** See `tom_d4rt_generator/doc/test_coverage.md` for the complete feature inventory, coverage status per feature, and gap analysis. Update it when adding new tests.

---

## Environment Reconstruction Framing

The bridge generator's purpose is to **reconstruct the full API surface** of host Dart packages so that interpreted scripts see the exact same environment as compiled code. This framing is critical when evaluating bugs, missing features, and test requirements.

### The Core Principle

> **If it works in compiled Dart, it must work in the bridged environment too.**

When a script runs against generated bridges, it should behave identically to the same code compiled natively. Every class, method, constructor, operator, constant, and type relationship that the script can access in compiled Dart must be present and functional in the bridged environment.

### Applying the Principle to Bugs and Requirements

When evaluating whether something is a bug or a missing feature, ask:

1. **Does this work in compiled Dart?** If yes → the bridge generator must support it.
2. **What would the script author expect?** They write standard Dart — they don't know or care about bridging internals.
3. **Is the generated environment complete?** Missing members mean the script will fail at runtime with "not found" errors, even though the code is syntactically and semantically correct.

### Examples

| Scenario | Compiled Dart | Bridge Requirement |
|----------|---------------|--------------------|
| `await obj.fetchData()` | Works — async method returns Future | Bridge must return the Future from the host method |
| `for (var x in obj.items())` | Works — sync* method returns Iterable | Bridge must return the Iterable from the host generator method |
| `await for (var e in obj.events())` | Works — async* method returns Stream | Bridge must return the Stream from the host generator method |
| `print(MyClass.maxCount)` | Works — static const is accessible | Bridge must expose the const value (override not needed — would violate const contract) |
| `var s = Stack()` | Works — implicit default constructor | Bridge must emit constructor bridge (GEN-042) |
| `transform(list, (x) => x * 2)` | Works — closure passed as argument | Bridge must wrap InterpretedFunction into native closure (GEN-005) |

### Generators Are Just Methods

Dart generators (`sync*`/`async*`) are not special declarations — they are **regular methods with a body modifier** that changes the return mechanism. They can appear as:

- **Top-level functions** (ASYNC02, ASYNC03)
- **Instance methods** on classes (ASYNC06, ASYNC07)
- **Static methods** on classes (ASYNC08)

The generator's class analysis must recognize these return types (`Iterable<T>`, `Stream<T>`) and produce method bridge adapters that correctly pass through the returned iterable or stream. The interpreter already supports `for-in` and `await for` — the bridge just needs to wire the host method into the environment so its return value reaches the script.

### What This Means for Testing

Tests should verify that the **script-visible behavior** matches compiled Dart, not just that the generator produces syntactically valid code. A test passes when the script runs identically to how it would run if compiled. A test fails when the bridged environment is incomplete or behaves differently from the compiled version — this is always a generator bug, not a test problem.

---

## Architecture

```
D4rtTester (test process)              Subprocess (generated test runner)
───────────────────────                ──────────────────────────────────
1. generateBridges(config)
   → bridge files + test runner
   (in-memory, same process)

2. Process.start('dart',
   ['run', 'bin/d4rtrun.b.dart',
    '--test', scriptFile])             → _runTestScript(scriptFile)
                                           │
                                           ├─ runZonedGuarded(
                                           │    () { d4rt.execute(source) },
                                           │    onError: capture exceptions,
                                           │    zoneSpec: capture print(),
                                           │  )
                                           │
   ← stdout: ###D4RT_TEST_RESULT###    ← _emitTestResult(output, exceptions)
     {"output":"...","exceptions":[]}

3. timeout? → process.kill()

4. D4rtTestResult.fromTestProcess()
     → .success / .timedOut / .exceptions / .processOutput
```

### Components

| Component | Location | Purpose |
|-----------|----------|---------|
| `D4rtTester` | `lib/src/testing/d4rt_tester.dart` | Generates bridges in-memory, spawns subprocess, enforces timeout |
| `D4rtTestResult` | `lib/src/testing/d4rt_test_result.dart` | Parses `###D4RT_TEST_RESULT###` JSON marker from subprocess stdout |
| `BuildConfigLoader` | `lib/src/build_config_loader.dart` | Loads `BridgeConfig` from a project's `buildkit.yaml` |
| `d4rt_tester_test.dart` | `test/d4rt_tester_test.dart` | Main test file with groups for each example project |

---

## Example Projects

Each example project in `example/` is a standalone Dart project with:

- `pubspec.yaml` — depends on `tom_d4rt` (path dependency)
- `buildkit.yaml` — bridge generation config (`d4rtgen:` section)
- `lib/` — source code to be bridged
- `test/` — D4rt test scripts (not `package:test` tests — plain Dart scripts run by the interpreter)

| Project | What It Tests |
|---------|---------------|
| `example_project` | Classes, constructors, enums, enum fields |
| `user_guide` | Calculator/Greeter classes (basic bridging) |
| `user_reference` | User, Product, Order models (complex types) |
| `userbridge_override` | User bridges: MyList, globals, top-level functions |
| `dart_overview` | Declarations, generics, implicit constructors, enhanced enums |
| `userbridge_user_guide` | User bridges: Vector2D/Matrix2x2 operators with print markers |

---

## Test Script Conventions

D4rt test scripts are **plain Dart files** executed by the D4rt interpreter, not `package:test` tests. They follow this pattern:

### Structure

```dart
// D4rt test script for <project>
// Tests <what is being tested>

import 'package:<project>/<barrel>.dart';

void main() {
  var errors = <String>[];

  // ── Test section ─────────────────────────────────────────────────

  var result = someOperation();
  if (result != expected) errors.add('description, got $result');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('ALL_TESTS_PASSED');
  } else {
    print('FAILURES:');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
```

### Rules

1. **Error collection pattern** — Collect errors in a `List<String>`, report at the end
2. **Success marker** — Print `ALL_TESTS_PASSED` (or a specific marker like `ALL_ENUM_FIELD_TESTS_PASSED`) on success
3. **Section comments** — Use `// ── Section Name ──` dividers for readability
4. **No test framework** — These run inside D4rt, not with `package:test`
5. **Import the barrel** — Use the project's barrel export, not individual source files
6. **File location** — Place in `<project>/test/d4rt_test_<name>.dart`

---

## Test File (d4rt_tester_test.dart)

The main test file uses `package:test` and runs all example projects:

### Pattern per Project

```dart
group('<project_name>', () {
  late D4rtTester tester;
  late BridgeConfig config;

  setUpAll(() {
    final projectPath = p.join(_exampleRoot, '<project_name>');
    config = BuildConfigLoader.loadFromTomBuildYaml(projectPath)!;
    tester = D4rtTester(
      projectPath: projectPath,
      defaultTimeout: const Duration(seconds: 30),
    );
  });

  test('<descriptive name>', () async {
    final result = await tester.runScript(
      config,
      'test/d4rt_test_<name>.dart',
    );
    _expectSuccess(result, '<project_name>');
    expect(result.processOutput, contains('ALL_TESTS_PASSED'));
  });
});
```

### Helper

The `_expectSuccess()` helper provides detailed failure diagnostics:

```dart
void _expectSuccess(D4rtTestResult result, String projectName) {
  if (!result.success) {
    final buf = StringBuffer('$projectName test failed:\n');
    buf.writeln('  timedOut: ${result.timedOut}');
    buf.writeln('  exitCode: ${result.exitCode}');
    // ... exceptions, processOutput, processError
    fail(buf.toString());
  }
}
```

### Test Annotations

```dart
@TestOn('vm')          // Subprocess execution requires VM
@Timeout(Duration(minutes: 2))  // Bridge generation + subprocess needs time
```

---

## User Bridge Verification

User bridges override specific methods/operators in generated bridge code with custom implementations. The testing strategy uses **print markers** to verify that user bridge code runs instead of generated code.

### How It Works

1. **User bridge classes** print a marker when their override methods execute:

   ```dart
   @override
   BridgedMethodAdapter? get overrideOperatorPlus => (visitor, instance, args, namedArgs, typeArgs) {
     print('[Vector2DUserBridge] operator+ called');
     // actual implementation...
   };
   ```

2. **D4rt test scripts** exercise the bridged operators/methods, which triggers the print markers

3. **Test assertions** verify both correctness AND that user bridge code ran:

   ```dart
   // Verify functional correctness
   expect(result.processOutput, contains('ALL_TESTS_PASSED'));

   // Verify user bridge code executed (not generated code)
   expect(
     result.processOutput,
     contains('[Vector2DUserBridge] operator+ called'),
     reason: 'Vector2D operator+ should use user bridge code',
   );
   ```

### Print Marker Convention

```
[<UserBridgeClassName>] <operation> called
```

Examples:

- `[Vector2DUserBridge] operator+ called`
- `[Vector2DUserBridge] binary operator- called`
- `[Vector2DUserBridge] unary operator- called`
- `[Matrix2x2UserBridge] operator[] called`
- `[Vector2DUserBridge] dot() called`

### User Bridge Requirements

User bridge classes **must** have:

1. `extends D4UserBridge` — base class for user bridge overrides
2. `@D4rtUserBridge('package:<pkg>/src/<file>.dart')` — annotation linking to the bridged source file (required by the scanner — without it the class is ignored with a warning)

### User Bridge Method Signatures

Override methods must match the bridge system's adapter typedefs:

| Override Type | Signature |
|---------------|-----------|
| Method/Operator | `BridgedMethodAdapter`: `(InterpreterVisitor, Object, List<Object?>, Map<String, Object?>, List<RuntimeType>?)` |
| Instance Getter | `BridgedInstanceGetterAdapter`: `(InterpreterVisitor?, Object)` |
| Constructor | `BridgedConstructorCallable`: `(InterpreterVisitor, List<Object?>, Map<String, Object?>)` |

### Override Naming Conventions

**Per-class overrides** (in `FooUserBridge extends D4UserBridge`):

| Dart Member | Override Property Name |
|-------------|----------------------|
| `Foo()` (default ctor) | `overrideConstructor` |
| `Foo.named()` | `overrideConstructorNamed` |
| `myMethod()` | `overrideMethodMyMethod` |
| `get myProp` | `overrideGetterMyProp` |
| `set myProp=` | `overrideSetterMyProp` |
| `static get instance` | `overrideStaticGetterInstance` |
| `static set config=` | `overrideStaticSetterConfig` |
| `static create()` | `overrideStaticMethodCreate` |
| `toString()` | `overrideMethodToString` |
| `operator+` | `overrideOperatorPlus` |
| `operator-` | `overrideOperatorMinus` |
| `operator- (unary)` | `overrideOperatorUnaryMinus` |
| `operator*` | `overrideOperatorMultiply` |
| `operator[]` | `overrideOperatorIndex` |
| `operator[]=` | `overrideOperatorIndexAssign` |
| `nativeNames` | `List<String> get nativeNames` |

**Global overrides** (in `GlobalsUserBridge extends D4UserBridge`):

| Global Member | Override Property Name |
|---------------|----------------------|
| Global variable `appName` | `overrideGlobalVariableAppName` |
| Global getter `vscode` | `overrideGlobalGetterVscode` |
| Top-level function `greet()` | `overrideGlobalFunctionGreet` |

### User Bridge Design Gaps

The following features are **not yet covered** by the user bridge override design (`userbridge_override_design.md`):

| Gap | Description | Affected Features |
|-----|-------------|-------------------|
| Global setter override | No `overrideGlobalSetter{Name}` pattern for top-level setters | TOP28 |
| Enhanced enum overrides | Not explicitly documented, but should work via standard `overrideMethod{Name}` on enum bridges | TOP09–TOP12 |

**Reference documents:**
- `doc/user_bridge_user_guide.md` — practical user guide
- `doc/userbridge_override_design.md` — full design specification

---

## Dual Testing: Generator Coverage vs User Bridge Tests

Bridge generator testing involves **two distinct concerns** that are tested separately:

### Generator Coverage Tests

Coverage tests verify that the **generator output works correctly** for each Dart language feature. They test whether the bridge generator properly handles classes, constructors, enums, mixins, generics, operators, etc.

- **What they test:** The generated bridge code itself — can a D4rt script instantiate a bridged class, call its methods, read its fields, use its operators?
- **Test location:** `example/dart_overview/test/` (feature-specific scripts like `top01_concrete_class.dart`, `cls07_static_field.dart`)
- **Tracked in:** `doc/test_coverage.md` → "Coverage Test" column
- **Feature IDs:** TOP, CLS, CTOR, OP, PAR, GNRC, INH, ASYNC, TYPE, VIS (11 categories)
- **Test runner:** `test/d4rt_coverage_test.dart` — uses `D4rtTester.runScriptOnly()` (no regeneration per test)

### User Bridge Tests

User bridge tests verify that the **override mechanism works** — that user-written bridge code is invoked instead of the generated code. This is a separate concern from whether the generator output is correct.

- **What they test:** The user bridge override system — does `overrideOperatorPlus` actually run when `+` is used? Does `overrideMethodMyMethod` intercept method calls?
- **Test location:** `example/userbridge_user_guide/test/` and `example/userbridge_override/test/`
- **Tracked in:** `doc/test_coverage.md` → "UB Test" column
- **Verification:** Print markers (e.g., `[Vector2DUserBridge] operator+ called`) confirm user bridge code executed

### Which Features Need Which Tests

| Feature Category | Coverage Test | User Bridge Test | Rationale |
|-----------------|---------------|------------------|-----------|
| Concrete class | ✅ Yes | ✅ Yes | Methods, getters, constructors can all be overridden |
| Abstract class | ✅ Yes | ✅ Yes | Subclass methods/getters can be overridden on the abstract bridge |
| Sealed/base/interface/final class | ✅ Yes | ✅ Yes | Same as concrete — subtypes have overridable members |
| Mixin class | ✅ Yes | ✅ Yes | Methods and getters applied via mixin can be overridden |
| Mixin | ✅ Yes | ✅ Yes | Mixin methods/getters can be overridden on the mixin bridge |
| Simple enum | ✅ Yes | not needed | Simple enums have no custom methods to override |
| Enhanced enum (fields/methods) | ✅ Yes | ✅ Yes | Custom methods on enhanced enums can be overridden |
| Constructors | ✅ Yes | ✅ Yes | Constructors can be overridden via `overrideConstructor{Name}` |
| Instance methods | ✅ Yes | ✅ Yes | Methods can be overridden via `overrideMethod{Name}` |
| Instance fields/getters | ✅ Yes | ✅ Yes | Getters can be overridden via `overrideGetter{Name}` |
| Operators | ✅ Yes | ✅ Yes | Operators are a primary user bridge use case |
| Static members | ✅ Yes | ✅ Yes | Static getters/setters/methods overridable via `overrideStaticGetter/Setter/Method{Name}` |
| Top-level functions | ✅ Yes | ✅ Yes | Can be overridden via `overrideGlobalFunction{Name}` |
| Top-level variables | ✅ Yes | ✅ Yes | Can be overridden via `overrideGlobalVariable{Name}` |
| Top-level getters | ✅ Yes | ✅ Yes | Can be overridden via `overrideGlobalGetter{Name}` |
| Top-level setters | ✅ Yes | — | Design gap: no `overrideGlobalSetter{Name}` pattern defined yet |
| Top-level consts | ✅ Yes | not needed | Constants cannot be overridden |
| Extensions / extension types | ✅ Yes | not supported | Extensions use static dispatch, not overridable |
| Typedefs | ✅ Yes | not needed | Type aliases have no behavior to override |
| Parameters | ✅ Yes | not needed | Parameter styles tested via method/constructor UB tests |
| Generics | ✅ Yes | ✅ Yes | Generic classes have overridable methods and constructors |
| Inheritance | ✅ Yes | ✅ Yes | Inherited/overridden methods can be overridden via user bridges |
| Special types (records, nullable) | ✅ Yes | not needed | Type handling is a generator concern |
| Visibility & exports | ✅ Yes | not needed | Infrastructure feature, no runtime behavior to override |

### UB Test Column Values

The "UB Test" column in `doc/test_coverage.md` uses these values:

| Value | Meaning |
|-------|---------|
| `e2e: <project>` | Covered by an existing e2e test in the named example project |
| `ub_<name>` | Covered by a dedicated user bridge test script |
| `not needed` | Feature has no user-overridable behavior |
| `not supported` | Generator doesn't support user bridging for this feature |
| `—` | Not yet tested (needs a user bridge test) |
| `🔲` | Cannot test yet (blocked by unimplemented generator feature) |

---

## Issue Tracking Workflow

When a test reveals a generator bug:

1. **Do NOT modify the test** to work around the failure
2. **Document the issue** in `tom_d4rt_generator/doc/issues.md`:
   - Add entry to the index table at the top (GEN-NNN, title, status, date)
   - Add detailed section with: description, root cause, affected constructs, reproduction steps
3. **Leave the test failing** — it serves as a regression test for when the fix is implemented
4. **Label tests with the issue ID** in the test name (e.g., `'GEN-041: enhanced enum fields'`)

### Issue ID Format

```
GEN-NNN
```

Sequential numbering. Current issues file: `tom_d4rt_generator/doc/issues.md`.

---

## Running Tests

```bash
# Run all D4rtTester e2e tests
cd xternal/tom_module_d4rt/tom_d4rt_generator
dart test test/d4rt_tester_test.dart

# Run a specific group
dart test test/d4rt_tester_test.dart --name "userbridge_user_guide"

# Run with verbose output
dart test test/d4rt_tester_test.dart -r expanded
```

### Expected Results

Tests for known bugs (GEN-041, GEN-042) are expected to fail. The passing baseline is all tests not tagged with a GEN issue ID.

---

## Adding a New Example Project

1. **Create the project** in `example/<name>/`:
   - `pubspec.yaml` with `tom_d4rt` path dependency
   - `analysis_options.yaml` including the workspace root config
   - `lib/` with source code and barrel file
   - `buildkit.yaml` with `d4rtgen:` section

2. **Generate bridges**:
   ```bash
   cd example/<name>
   dart run tom_d4rt_generator:d4rtgen
   ```

3. **Create D4rt test script** in `test/d4rt_test_<name>.dart`:
   - Use the error collection pattern
   - Print `ALL_TESTS_PASSED` on success
   - For user bridges, add print markers in override methods

4. **Add test group** in `test/d4rt_tester_test.dart`:
   - `setUpAll`: load config, create tester
   - `test`: run script, assert `_expectSuccess` + `contains('ALL_TESTS_PASSED')`
   - For user bridges: also assert print markers appear in output

5. **Run `dart analyze`** on both the example project and the generator
6. **Run `dart test`** to verify
