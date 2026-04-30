# tom_d4rt_flutter_test — Implementation Plan

**Created:** 2026-04-30
**Status:** Pending

## Goal

Build an interactive Flutter app that runs the same D4rt test scripts as the
`tom_d4rt_flutter_ast` flutter-driver corpus, but using `tom_d4rt`
(source-based interpreter, no `AstBundle`, no `tom_d4rt_ast` dependency) and
controlled through in-app playback UI instead of an external test driver.

Scripts are loaded directly from disk out of
`tom_d4rt_flutter_ast/test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/`.

---

## Viability Summary

| Question | Answer |
|----------|--------|
| `tom_d4rt.D4rt.execute()` supports named function calls? | **Yes** — `execute(source:, name: 'build', positionalArgs: [context])` |
| Bridges can be regenerated targeting `tom_d4rt`? | **Yes** — change `d4rtImport` + `helpersImport` in `buildkit.yaml` |
| `D4`, `BridgedClass`, `InterpreterVisitor`, etc. exported by `tom_d4rt/d4rt.dart`? | **Yes** — full API surface exported |
| Zero `tom_d4rt_ast` / `tom_d4rt_exec` / `tom_ast_generator` dependency? | **Yes** — only `tom_d4rt` + Flutter SDK |
| Scripts loadable from disk without bundling? | **Yes** — plain `dart:io` `File.readAsStringSync()` |
| `registerD4rtRuntimeExtensions()` no-arg pattern resolved? | **Yes** — uses static maps on `D4` class, no interpreter instance needed (see step 0) |
| Sync gap between `tom_d4rt` and `tom_d4rt_ast`? | **One gap found and fixed in step 0**: `registertopLevelFunction` typo |

---

## Implementation Steps

### Step 0 — Sync fix: `registertopLevelFunction` typo [ ]

**Must be done before bridge regeneration.** A naming inconsistency exists
across the interpreter stack:

| Location | Method name | Status |
|----------|-------------|--------|
| `tom_d4rt_ast/lib/src/runtime/d4rt_runner.dart:318` | `registerTopLevelFunction` | **correct** |
| `tom_d4rt_exec/lib/src/d4rt_base.dart:254` | `registertopLevelFunction` | **typo** |
| `tom_d4rt/lib/src/d4rt_base.dart:348` | `registertopLevelFunction` | **typo** |
| `tom_d4rt_generator/lib/src/bridge_generator.dart:6569` | emits `registertopLevelFunction` | **typo** |

`D4rtRunner` (the AST layer) already has the correct spelling. The two `D4rt`
wrapper classes and the generator consistently use the typo. After bridge
regeneration the generated code calls `registertopLevelFunction` on a
`tom_d4rt.D4rt` — which does have it — so the current code compiles. But the
gap means `tom_d4rt.D4rt` is not name-for-name in sync with `D4rtRunner`.

**Fix — three files, one string each:**

#### `tom_d4rt/lib/src/d4rt_base.dart` (line 348)
```dart
// before
void registertopLevelFunction(
// after
void registerTopLevelFunction(
```

#### `tom_d4rt_exec/lib/src/d4rt_base.dart` (line 254)
```dart
// before
void registertopLevelFunction(
// after
void registerTopLevelFunction(
```
(The internal delegation on line 261 already calls `_runner.registerTopLevelFunction`
with the correct name — no change needed there.)

#### `tom_d4rt_generator/lib/src/bridge_generator.dart` (line 6569)
```dart
// before
'      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);',
// after
'      interpreter.registerTopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);',
```

**After the fixes:**

1. Regenerate `tom_d4rt_flutter_ast` bridges (now emits correct spelling):
   ```bash
   cd tom_d4rt_flutter_ast
   dart run tool/regenerate_bridges.dart
   ```

2. Run test suites to confirm no regression:
   ```bash
   cd tom_d4rt       && dart test
   cd tom_d4rt_ast   && dart test
   cd tom_d4rt_generator && dart test
   cd tom_d4rt_flutter_ast && flutter test test/essential_classes_test.dart
   ```

   Expected: same counts as pre-fix (method rename is pure rename, no
   behaviour change). `tom_d4rt_flutter_ast` essential must pass clean.

3. Commit and push.

---

### Step 1 — `pubspec.yaml` [ ]

Replace the default Flutter template dependencies with:

```yaml
name: tom_d4rt_flutter_test
dependencies:
  flutter:
    sdk: flutter
  tom_d4rt:
    path: ../tom_d4rt
  path: ^1.9.0
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  tom_d4rt_generator:
    path: ../tom_d4rt_generator
```

No `tom_d4rt_ast`, no `tom_d4rt_exec`, no `tom_ast_generator`, no `archive`.

---

### Step 2 — `buildkit.yaml` [ ]

Copy `tom_d4rt_flutter_ast/buildkit.yaml` verbatim and change two keys:

```yaml
d4rtgen:
  name: flutter_material_bridges
  d4rtImport: package:tom_d4rt/d4rt.dart        # was: package:tom_d4rt_exec/d4rt.dart
  helpersImport: package:tom_d4rt/d4rt.dart      # was: package:tom_d4rt_ast/tom_d4rt_ast.dart
  generateBarrel: true
  barrelPath: lib/src/bridges/flutter_bridges_barrel.b.dart
  generateDartscript: true
  dartscriptPath: lib/src/bridges/material_bridges.b.dart
  registrationClass: FlutterMaterialBridges
  generateTestRunner: false      # no test runner needed in interactive app
  generateProxies: true
  proxiesOutputPath: lib/src/bridges/flutter_proxies.b.dart
  relaxerOutputPath: lib/src/bridges/flutter_relaxers.b.dart
  proxyClasses:
    - CustomPainter
    - CustomClipper
    - FlowDelegate
    - MultiChildLayoutDelegate
    - SingleChildLayoutDelegate
    - SliverPersistentHeaderDelegate
    - DataTableSource
    - TransitionDelegate
    - GradientTransform
  modules:
    - name: dart_ui
      barrelImport: dart:ui
      outputPath: lib/src/bridges/dart_ui_bridges.b.dart
    - name: flutter_painting
      barrelImport: package:flutter/painting.dart
      outputPath: lib/src/bridges/painting_bridges.b.dart
      skipReExports: [dart:ui]
    - name: flutter_foundation
      barrelImport: package:flutter/foundation.dart
      outputPath: lib/src/bridges/foundation_bridges.b.dart
      skipReExports: [dart:ui, package:flutter/painting.dart]
    - name: flutter_animation
      barrelImport: package:flutter/animation.dart
      outputPath: lib/src/bridges/animation_bridges.b.dart
      skipReExports: [dart:ui, package:flutter/painting.dart, package:flutter/foundation.dart]
    - name: flutter_physics
      barrelImport: package:flutter/physics.dart
      outputPath: lib/src/bridges/physics_bridges.b.dart
    - name: flutter_scheduler
      barrelImport: package:flutter/scheduler.dart
      outputPath: lib/src/bridges/scheduler_bridges.b.dart
    - name: flutter_semantics
      barrelImport: package:flutter/semantics.dart
      outputPath: lib/src/bridges/semantics_bridges.b.dart
    - name: flutter_services
      barrelImport: package:flutter/services.dart
      outputPath: lib/src/bridges/services_bridges.b.dart
    - name: flutter_gestures
      barrelImport: package:flutter/gestures.dart
      outputPath: lib/src/bridges/gestures_bridges.b.dart
    - name: flutter_rendering
      barrelImport: package:flutter/rendering.dart
      outputPath: lib/src/bridges/rendering_bridges.b.dart
    - name: flutter_widgets
      barrelImport: package:flutter/widgets.dart
      outputPath: lib/src/bridges/widgets_bridges.b.dart
    - name: flutter_material
      barrelImport: package:flutter/material.dart
      outputPath: lib/src/bridges/material_widgets_bridges.b.dart
    - name: flutter_cupertino
      barrelImport: package:flutter/cupertino.dart
      outputPath: lib/src/bridges/cupertino_bridges.b.dart
```

---

### Step 3 — `tool/regenerate_bridges.dart` [ ]

Copy `tom_d4rt_flutter_ast/tool/regenerate_bridges.dart` verbatim (no changes
needed — it reads `buildkit.yaml` from the project root). Then run:

```bash
cd tom_d4rt_flutter_test
dart pub get
dart run tool/regenerate_bridges.dart
```

This produces 16 output files (same as `tom_d4rt_flutter_ast` minus the
`test_runner`, which is omitted). All generated `import` lines will
reference `package:tom_d4rt/d4rt.dart` instead of `tom_d4rt_ast`/`tom_d4rt_exec`.
All `registerTopLevelFunction` calls (correct spelling after step 0) will
resolve against `tom_d4rt.D4rt`.

---

### Step 4 — Copy and rewrite runtime registrations [ ]

#### 4a — `lib/src/d4rt_runtime_registrations.dart`

Copy from `tom_d4rt_flutter_ast/lib/src/d4rt_runtime_registrations.dart`.

Replace the five `tom_d4rt_ast` / `tom_d4rt_exec` import lines:

```dart
// Remove:
import 'package:tom_d4rt_exec/d4rt.dart' show D4;
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart'
    show BridgedClass, BridgedInstance;
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/runtime_interfaces.dart'
    show D4InterpretedProxy, RuntimeType;
import 'package:tom_d4rt_ast/src/runtime/runtime_types.dart';

// Add:
import 'package:tom_d4rt/d4rt.dart'
    show D4, BridgedClass, BridgedInstance,
         D4InterpretedProxy, RuntimeType,
         InterpreterVisitor;
import 'package:tom_d4rt/d4rt.dart';
```

**Why the no-arg pattern works:** `registerD4rtRuntimeExtensions()` and
`registerRelaxers()` register into **static maps on the `D4` class**
(`D4._interfaceProxies`, `D4._genericTypeWrappers`, etc.) — no interpreter
instance is involved. The `D4` class in `package:tom_d4rt/d4rt.dart` has
the identical static API (`registerInterfaceProxy`, `registerGenericTypeWrapper`,
`registerGenericConstructor`, `registerTypeCoercion`) as `tom_d4rt_ast`'s
`D4`. After the import rewrite, the no-arg calls compile and register into
`tom_d4rt`'s static maps — no changes to function signatures needed.

#### 4b — User bridge files (copy + rewrite, 3 files)

Apply the same import rewrite to each:

| Source | Destination |
|--------|-------------|
| `tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/state_user_bridge.dart` | `lib/src/d4rt_user_bridges/state_user_bridge.dart` |
| `tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart` | `lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart` |
| `tom_d4rt_flutter_ast/lib/src/d4rt_user_bridges/strut_style_user_bridge.dart` | `lib/src/d4rt_user_bridges/strut_style_user_bridge.dart` |

---

### Step 5 — `SourceFlutterD4rt` class [ ]

New file `lib/src/source_flutter_d4rt.dart`. Replaces `FlutterD4rt` from
`tom_d4rt_flutter_ast` — uses `execute(source:, name:, positionalArgs:)`
instead of `executeBundleAs(bundle, name:, positionalArgs:)`.

```dart
import 'package:flutter/widgets.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'bridges/material_bridges.b.dart';
import 'bridges/flutter_relaxers.b.dart';
import 'd4rt_runtime_registrations.dart';

/// D4rt interpreter (source-based) configured with Flutter Material bridges.
///
/// Parallel to [FlutterD4rt] in tom_d4rt_flutter_ast, but runs against the
/// analyzer-based [D4rt] interpreter from package:tom_d4rt. Accepts raw
/// Dart source strings rather than pre-compiled [AstBundle] objects.
class SourceFlutterD4rt {
  final D4rt _interpreter;

  SourceFlutterD4rt() : _interpreter = D4rt() {
    _registerBridges();
  }

  SourceFlutterD4rt.withInterpreter(this._interpreter) {
    _registerBridges();
  }

  void _registerBridges() {
    registerRelaxers();
    registerD4rtRuntimeExtensions();
    FlutterMaterialBridges.register(_interpreter);
    _interpreter.registerExtensions(
      'tom_d4rt_flutter_test',
      registerD4rtInterfaceProxyOverrides,
    );
    _interpreter.finalizeBridges();
  }

  D4rt get interpreter => _interpreter;

  /// Execute a D4rt source script and extract the result as type [T].
  ///
  /// Calls the function named [name] (default: `'build'`) with
  /// [buildContext] as the first positional argument if provided.
  T build<T>(String source, [BuildContext? buildContext]) =>
      _wrapUnwrap(() => D4.unwrapAs<T>(_interpreter.execute(
            source: source,
            name: 'build',
            positionalArgs: buildContext != null ? [buildContext] : null,
          )));

  T execute<T>(
    String source, {
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) =>
      _wrapUnwrap(() => D4.unwrapAs<T>(_interpreter.execute(
            source: source,
            name: name,
            positionalArgs: positionalArgs,
            namedArgs: namedArgs,
          )));

  static T _wrapUnwrap<T>(T Function() body) {
    try {
      return body();
    } on D4UnwrapException catch (e) {
      throw SourceFlutterD4rtException(e.message);
    }
  }
}

class SourceFlutterD4rtException implements Exception {
  final String message;
  const SourceFlutterD4rtException(this.message);
  @override
  String toString() => 'SourceFlutterD4rtException: $message';
}
```

---

### Step 6 — Script loader [ ]

New file `lib/src/test_script_loader.dart`.

```dart
import 'dart:io';
import 'package:path/path.dart' as p;

class TestScript {
  final String name;   // relative path within send_ast_via_http_scripts/
  final String source; // raw Dart source

  const TestScript({required this.name, required this.source});
}

class TestScriptLoader {
  /// Root of the test script corpus, relative to the project's working dir.
  /// Default assumes `flutter run` / `flutter test` is launched from inside
  /// the `tom_d4rt_flutter_test` project directory.
  static const _relativeRoot =
      '../tom_d4rt_flutter_ast/test'
      '/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts';

  static List<TestScript> loadAll({String? rootOverride}) {
    final root = Directory(rootOverride ?? _relativeRoot);
    if (!root.existsSync()) {
      throw StateError(
          'Script root not found: ${root.absolute.path}\n'
          'Pass scriptRootOverride or launch from tom_d4rt_flutter_test/.');
    }
    final scripts = root
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .map((f) => TestScript(
              name: p.relative(f.path, from: root.path),
              source: f.readAsStringSync(),
            ))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return scripts;
  }
}
```

The default `_relativeRoot` is relative to the project dir (sibling of
`tom_d4rt_flutter_ast/`). If `flutter run` sets a different CWD, pass an
absolute override via `Platform.script.resolve('../...')` or a
`String.fromEnvironment('SCRIPT_ROOT')` constant.

---

### Step 7 — Test runner service [ ]

New file `lib/src/test_runner.dart`. `ChangeNotifier`-based state machine
with play / pause / next / back controls.

```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'source_flutter_d4rt.dart';
import 'test_script_loader.dart';

enum RunnerStatus { idle, running, paused }

class TestResult {
  final String scriptName;
  final bool passed;
  final String info;       // result type name on pass, error message on fail
  final StackTrace? stack;

  const TestResult.pass(this.scriptName, this.info)
      : passed = true, stack = null;
  const TestResult.fail(this.scriptName, this.info, [this.stack])
      : passed = false;
}

class TestRunner extends ChangeNotifier {
  final SourceFlutterD4rt _d4rt = SourceFlutterD4rt();
  late final List<TestScript> scripts;

  int currentIndex = 0;
  RunnerStatus status = RunnerStatus.idle;
  TestResult? lastResult;
  bool _paused = false;

  TestRunner({String? scriptRootOverride}) {
    scripts = TestScriptLoader.loadAll(rootOverride: scriptRootOverride);
  }

  TestScript? get current =>
      scripts.isEmpty ? null : scripts[currentIndex];

  void play() {
    if (status == RunnerStatus.running) return;
    _paused = false;
    _runLoop();
  }

  void pause() {
    _paused = true;
    status = RunnerStatus.paused;
    notifyListeners();
  }

  Future<void> next() async {
    if (currentIndex < scripts.length - 1) {
      currentIndex++;
      await _runCurrent();
      notifyListeners();
    }
  }

  Future<void> back() async {
    if (currentIndex > 0) {
      currentIndex--;
      await _runCurrent();
      notifyListeners();
    }
  }

  Future<void> _runLoop() async {
    status = RunnerStatus.running;
    notifyListeners();
    while (currentIndex < scripts.length && !_paused) {
      await _runCurrent();
      if (!_paused) currentIndex++;
      notifyListeners();
      // yield to Flutter frame pump between scripts
      await Future<void>.delayed(Duration.zero);
    }
    if (!_paused) status = RunnerStatus.idle;
    notifyListeners();
  }

  Future<void> _runCurrent() async {
    final script = scripts[currentIndex];
    try {
      final raw = _d4rt.execute<dynamic>(script.source);
      lastResult = TestResult.pass(script.name, raw.runtimeType.toString());
    } catch (e, st) {
      lastResult = TestResult.fail(script.name, e.toString(), st);
    }
  }
}
```

---

### Step 8 — Main app UI [ ]

Replace `lib/main.dart` with the interactive playback shell.

Key layout:

```
MaterialApp
  └─ Scaffold
       ├─ AppBar: title "D4rt Test Runner", progress badge
       ├─ body: Column
       │    ├─ ScriptInfoPanel   (cluster/name, index/total)
       │    └─ ResultPanel       (pass/fail badge, output / error text, scrollable)
       └─ bottomNavigationBar: ControlBar
            [ ← back ] [ ▶ play / ‖ pause ] [ next → ]
```

`ListenableBuilder(listenable: runner, ...)` drives re-renders reactively.

---

### Step 9 — Smoke test [ ]

Run the app on macOS desktop:

```bash
cd tom_d4rt_flutter_test
flutter run -d macos
```

Verify:
- App launches and script list loads
- Play advances through scripts automatically
- Pause stops mid-run, Next/Back step individually
- At least a handful of scripts in the `animation/` or `dart_ui/` clusters
  pass (simpler, fewer Flutter-widget dependencies)
- Failures show readable error messages

---

## File inventory

| # | File | Action |
|---|------|--------|
| 0a | `tom_d4rt/lib/src/d4rt_base.dart:348` | Edit — rename `registertopLevelFunction` → `registerTopLevelFunction` |
| 0b | `tom_d4rt_exec/lib/src/d4rt_base.dart:254` | Edit — rename `registertopLevelFunction` → `registerTopLevelFunction` |
| 0c | `tom_d4rt_generator/lib/src/bridge_generator.dart:6569` | Edit — fix generated string to `registerTopLevelFunction` |
| 0d | `tom_d4rt_flutter_ast/lib/src/bridges/*.b.dart` | Regenerate — `dart run tool/regenerate_bridges.dart` |
| 1 | `pubspec.yaml` | Edit — add `tom_d4rt`, `path`; remove defaults |
| 2 | `buildkit.yaml` | New — copy from `tom_d4rt_flutter_ast`, 2-line change |
| 3 | `tool/regenerate_bridges.dart` | New — copy verbatim |
| 4 | `lib/src/bridges/*.b.dart` (16 files) | Generated — `dart run tool/regenerate_bridges.dart` |
| 5 | `lib/src/d4rt_runtime_registrations.dart` | New — copy + import rewrite |
| 6 | `lib/src/d4rt_user_bridges/state_user_bridge.dart` | New — copy + import rewrite |
| 7 | `lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart` | New — copy + import rewrite |
| 8 | `lib/src/d4rt_user_bridges/strut_style_user_bridge.dart` | New — copy + import rewrite |
| 9 | `lib/src/source_flutter_d4rt.dart` | New |
| 10 | `lib/src/test_script_loader.dart` | New |
| 11 | `lib/src/test_runner.dart` | New |
| 12 | `lib/main.dart` | Replace |

---

## Resolved open questions

- **`registerD4rtRuntimeExtensions()` no-arg pattern** — resolved. The
  function calls eight sub-functions that register static factories into maps
  on the `D4` class (`D4._interfaceProxies`, `D4._genericTypeWrappers`, etc.).
  No interpreter instance is needed. The `D4` class in `package:tom_d4rt`
  has identical static API to `tom_d4rt_ast`'s `D4`. Import rewrite is
  sufficient — no signature changes needed.

- **`registertopLevelFunction` typo** — resolved in step 0. After rename,
  both `D4rt` classes and the generator use `registerTopLevelFunction`
  (correct case), matching `D4rtRunner`.

## Remaining open question

- **Working directory for script loading**: `TestScriptLoader` defaults to
  `../tom_d4rt_flutter_ast/test/...` (sibling-relative). If `flutter run`
  sets a different CWD, pass `scriptRootOverride` from `main()` using
  `Platform.script` or `String.fromEnvironment('SCRIPT_ROOT')`.
- **`build(BuildContext)` vs `main()`**: corpus scripts define
  `build(BuildContext context)`. `SourceFlutterD4rt.execute<dynamic>(source)`
  calls `name: 'main'` by default; use `build<dynamic>(source, context)` or
  `execute<dynamic>(source, name: 'build')` as appropriate per cluster.
  Scripts that define `main()` instead of `build()` need special-casing or a
  cluster-level name override.
