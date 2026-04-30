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
| `registerD4rtRuntimeExtensions()` no-arg pattern resolved? | **Yes** — uses static maps on `D4` class, no interpreter instance needed |
| Sync gap between `tom_d4rt` and `tom_d4rt_ast` bridge-facing APIs? | **None** — import swap works as-is (see analysis note) |

---

## Analysis note — `registertopLevelFunction` spelling

A sync audit compared the method names used by the bridge generator against
`tom_d4rt.D4rt` and `tom_d4rt_ast.D4rtRunner`. The findings:

| Class | Method at public API | Bridge-facing? |
|-------|---------------------|---------------|
| `tom_d4rt_ast.D4rtRunner:318` | `registerTopLevelFunction` (correct) | No — bridges never call `D4rtRunner` directly |
| `tom_d4rt_exec.D4rt:254` | `registertopLevelFunction` (typo) | Yes — `tom_d4rt_flutter_ast` bridges target this |
| `tom_d4rt.D4rt:348` | `registertopLevelFunction` (typo) | Yes — `tom_d4rt_dcli` bridges target this |
| Generator emits | `registertopLevelFunction` (typo) | — |

Both `D4rt` wrapper classes have the typo and the generator emits the typo.
The spelling inconsistency only exists between `D4rtRunner` (the inner AST
layer) and the two outer `D4rt` wrappers. Bridge code never reaches
`D4rtRunner` directly; `tom_d4rt_exec.D4rt` bridges the name difference
internally (`registertopLevelFunction` wrapper calls
`_runner.registerTopLevelFunction`). The bridge-facing API is **consistent
across both packages** — no step 0 needed, import swap works as-is.

The `registertopLevelFunction` name is existing technical debt (should be
`registerTopLevelFunction`) but fixing it requires a coordinated rename of
all three sites plus regenerating all bridge packages and is out of scope
for this project.

---

## Implementation Steps

### Step 1 — `pubspec.yaml` [x]

Replace the default Flutter template dependencies with:

```yaml
name: tom_d4rt_flutter_test
dependencies:
  flutter:
    sdk: flutter
  tom_d4rt:
    path: ../tom_d4rt
  path: ^1.9.0
  file_picker: ^8.0.0
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  tom_d4rt_generator:
    path: ../tom_d4rt_generator
```

No `tom_d4rt_ast`, no `tom_d4rt_exec`, no `tom_ast_generator`, no `archive`.

**Pub override required.** `tom_d4rt_generator` (dev dep from path)
declares `tom_d4rt: any` against pub.dev, which the solver treats as
incompatible with our path dep. Following the sibling
`tom_d4rt_flutter_ast` convention, two override files are committed:

- `pubspec_overrides.dev.yaml` — committed template
- `pubspec_overrides.yaml` — active local copy (mirrors the template)

Both override `tom_d4rt → path: ../tom_d4rt` and
`tom_analyzer_shared → path: ../../basics/tom_analyzer_shared`
(transitive dep of the generator's regenerator tool, not on pub.dev).

---

### Step 2 — `buildkit.yaml` [x]

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

### Step 6 — Script loader + path state [ ]

Two new files.

#### `lib/src/test_script_loader.dart`

Default path is expressed as an absolute path resolved from the executable
location — this keeps the app working when launched from any CWD.
`Platform.resolvedExecutable` points inside the macOS app bundle; walking up
to the `.app` parent and then to the sibling project directory gives a
stable anchor. A `rootExists` check lets the UI show a "path not found"
banner without crashing.

```dart
import 'dart:io';
import 'package:path/path.dart' as p;

class TestScript {
  final String name;   // path relative to the chosen root
  final String source; // raw Dart source

  const TestScript({required this.name, required this.source});
}

class TestScriptLoader {
  /// Default script root: resolved relative to the executable so the app
  /// works whether launched from Xcode, `flutter run`, or Finder.
  ///
  /// Layout assumption:
  ///   <workspace>/tom_ai/d4rt/tom_d4rt_flutter_test/   ← this project
  ///   <workspace>/tom_ai/d4rt/tom_d4rt_flutter_ast/    ← sibling
  ///
  /// The macOS bundle sits at:
  ///   <project>/build/macos/Build/Products/Debug/tom_d4rt_flutter_test.app/
  /// Walking up 6 levels from the executable reaches the project root, then
  /// up one more reaches the d4rt directory where the sibling lives.
  static String get defaultRoot {
    // Walk up from the executable to the project directory, then to sibling.
    // Fallback: use CWD-relative path so `flutter run` from the project dir
    // also works.
    final exeDir = File(Platform.resolvedExecutable).parent;
    // Try executable-relative path first (works for built app bundles)
    for (var up = 0; up < 8; up++) {
      final candidate = p.join(
        exeDir.path,
        '../' * up,
        '../tom_d4rt_flutter_ast/test'
        '/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts',
      );
      final resolved = p.normalize(candidate);
      if (Directory(resolved).existsSync()) return resolved;
    }
    // Fallback: CWD-relative (works when launched with `flutter run` from the
    // project directory)
    return p.normalize(
      '../tom_d4rt_flutter_ast/test'
      '/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts',
    );
  }

  /// Whether [root] points to an existing directory.
  static bool rootExists(String root) => Directory(root).existsSync();

  /// Load all `.dart` files under [root], sorted by relative path.
  /// Returns an empty list (not an error) if the directory does not exist —
  /// callers should check [rootExists] and show a banner instead of crashing.
  static List<TestScript> loadAll(String root) {
    final dir = Directory(root);
    if (!dir.existsSync()) return const [];
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .map((f) => TestScript(
              name: p.relative(f.path, from: root),
              source: f.readAsStringSync(),
            ))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
```

#### `lib/src/script_root_notifier.dart`

Holds the currently selected root path and exposes a method to open a native
directory picker. The `TestRunner` listens to this and reloads its script list
whenever the path changes.

```dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'test_script_loader.dart';

class ScriptRootNotifier extends ChangeNotifier {
  String _root;

  ScriptRootNotifier() : _root = TestScriptLoader.defaultRoot;

  String get root => _root;

  bool get exists => TestScriptLoader.rootExists(_root);

  /// Opens a native directory picker. Updates [root] and notifies listeners
  /// only if the user actually selects a folder.
  Future<void> pickDirectory() async {
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select D4rt test script folder',
      initialDirectory: Directory(_root).existsSync() ? _root : null,
    );
    if (result != null && result != _root) {
      _root = result;
      notifyListeners();
    }
  }

  void setRoot(String path) {
    if (path == _root) return;
    _root = path;
    notifyListeners();
  }
}
```

Add `file_picker: ^8.0.0` to `pubspec.yaml` dependencies (supports macOS,
Linux, Windows directory pickers out of the box; no entitlement changes
needed for local file reads on macOS debug builds).

**`TestRunner` wires into `ScriptRootNotifier`:**

```dart
class TestRunner extends ChangeNotifier {
  final ScriptRootNotifier rootNotifier;
  // ...
  TestRunner(this.rootNotifier) {
    rootNotifier.addListener(_onRootChanged);
    _reload();
  }

  void _onRootChanged() {
    _reload();
    notifyListeners();
  }

  void _reload() {
    currentIndex = 0;
    status = RunnerStatus.idle;
    lastResult = null;
    scripts = TestScriptLoader.loadAll(rootNotifier.root);
  }

  @override
  void dispose() {
    rootNotifier.removeListener(_onRootChanged);
    super.dispose();
  }
}
```

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

Wire `ScriptRootNotifier` and `TestRunner` as `ChangeNotifier`s at the top of
the widget tree (e.g., with `MultiProvider` from `package:provider`, or plain
`ListenableBuilder` stacking — whichever is already in the pubspec).

Key layout:

```
MaterialApp
  └─ Scaffold
       ├─ AppBar: "D4rt Test Runner"  [script-count badge]
       ├─ body: Column
       │    ├─ PathBar                ← new
       │    │    ├─ [folder icon] current root path (truncated, monospace)
       │    │    ├─ [📂 Browse] button → ScriptRootNotifier.pickDirectory()
       │    │    └─ if !exists: amber warning chip "Path not found"
       │    ├─ ScriptInfoPanel        (cluster/name, index/total)
       │    │    disabled / greyed when !exists
       │    └─ ResultPanel            (pass/fail badge, output / error, scrollable)
       └─ bottomNavigationBar: ControlBar
            [ ← back ] [ ▶ play / ‖ pause ] [ next → ]
            all buttons disabled when !exists or scripts.isEmpty
```

**PathBar widget sketch:**

```dart
class PathBar extends StatelessWidget {
  final ScriptRootNotifier notifier;
  const PathBar({super.key, required this.notifier});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        final exists = notifier.exists;
        return Container(
          color: exists
              ? Theme.of(context).colorScheme.surfaceContainerLow
              : Theme.of(context).colorScheme.errorContainer.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              const Icon(Icons.folder_outlined, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  notifier.root,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!exists) ...[
                const SizedBox(width: 8),
                const Chip(
                  label: Text('Path not found',
                      style: TextStyle(fontSize: 11)),
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ],
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: notifier.pickDirectory,
                child: const Text('Browse'),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

`ListenableBuilder(listenable: runner, ...)` drives the rest of the UI
reactively. Controls in `ControlBar` check `runner.scripts.isEmpty` and
`rootNotifier.exists` before enabling.

---

### Step 9 — Smoke test [ ]

Run on Linux desktop first; macOS to follow later.

```bash
cd tom_d4rt_flutter_test
flutter run -d linux
```

Verify:
- App launches and script list loads
- PathBar shows the default path; "Path not found" chip appears if the
  sibling `tom_d4rt_flutter_ast/` directory is not resolved correctly
- Browse button opens the native folder picker and reloads the script list
- Play advances through scripts automatically
- Pause stops mid-run, Next/Back step individually
- At least a handful of scripts in the `animation/` or `dart_ui/` clusters
  pass (simpler, fewer Flutter-widget dependencies)
- Failures show readable error messages

**macOS follow-up** — repeat with `flutter run -d macos` once Linux is green.
The `Platform.resolvedExecutable` walk-up path may need a different number of
`../` steps for the macOS `.app` bundle layout vs the Linux ELF binary; adjust
`defaultRoot` in `TestScriptLoader` if needed.

---

## File inventory

| # | File | Action |
|---|------|--------|
| 1 | `pubspec.yaml` | Edit — add `tom_d4rt`, `path`, `file_picker`; remove defaults |
| 2 | `buildkit.yaml` | New — copy from `tom_d4rt_flutter_ast`, 2-line change |
| 3 | `tool/regenerate_bridges.dart` | New — copy verbatim |
| 4 | `lib/src/bridges/*.b.dart` (16 files) | Generated — `dart run tool/regenerate_bridges.dart` |
| 5 | `lib/src/d4rt_runtime_registrations.dart` | New — copy + import rewrite |
| 6 | `lib/src/d4rt_user_bridges/state_user_bridge.dart` | New — copy + import rewrite |
| 7 | `lib/src/d4rt_user_bridges/basic_message_channel_user_bridge.dart` | New — copy + import rewrite |
| 8 | `lib/src/d4rt_user_bridges/strut_style_user_bridge.dart` | New — copy + import rewrite |
| 9 | `lib/src/source_flutter_d4rt.dart` | New |
| 10 | `lib/src/test_script_loader.dart` | New |
| 11 | `lib/src/script_root_notifier.dart` | New |
| 12 | `lib/src/test_runner.dart` | New (updated to accept `ScriptRootNotifier`) |
| 13 | `lib/main.dart` | Replace |

---

## Resolved open questions

- **`registerD4rtRuntimeExtensions()` no-arg pattern** — resolved. The
  function calls eight sub-functions that register static factories into maps
  on the `D4` class (`D4._interfaceProxies`, `D4._genericTypeWrappers`, etc.).
  No interpreter instance is needed. The `D4` class in `package:tom_d4rt`
  has identical static API to `tom_d4rt_ast`'s `D4`. Import rewrite is
  sufficient — no signature changes needed.

- **`registertopLevelFunction` spelling** — not a blocker. Both `D4rt`
  wrapper classes (`tom_d4rt.D4rt` and `tom_d4rt_exec.D4rt`) expose the
  method under the typo spelling and the generator emits the typo
  consistently. Bridge code never calls `D4rtRunner` directly, so the
  spelling difference at the AST layer is invisible to generated bridges.
  The import swap works as-is.

## Remaining open question

- **`build(BuildContext)` vs `main()`**: corpus scripts define
  `build(BuildContext context)`. `SourceFlutterD4rt.execute<dynamic>(source)`
  calls `name: 'main'` by default; use `build<dynamic>(source, context)` or
  `execute<dynamic>(source, name: 'build')` as appropriate per cluster.
  Scripts that define `main()` instead of `build()` need special-casing or a
  cluster-level name override.
