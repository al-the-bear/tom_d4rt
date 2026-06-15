# tom_d4rt_flutter_ast

D4rt Flutter-Material bridge — execute D4rt scripts that return live Flutter widget trees, without an app-store republish.

## Overview

`tom_d4rt_flutter_ast` connects the D4rt sandboxed Dart interpreter to the full
Flutter-Material widget library. A D4rt script can import `package:flutter/material.dart`,
construct any widget tree it needs, and return it as a real `Widget` object that Flutter
renders natively inside the host application.

The interpreter runs entirely on the **analyzer-free** execution path
(`tom_d4rt_ast` + `tom_d4rt_exec`), so it can be embedded in a shipping Flutter app
with no Dart analyzer dependency and no platform-channel overhead. That makes this
package the right choice for **over-the-air UI updates** and **web** targets: ship
widget code in an `AstBundle`, execute it at runtime, and render the result — no
app-store cycle.

> **Which package should I use?** Start with the **source-based**
> [`tom_d4rt_flutter`](../tom_d4rt_flutter) (`SourceFlutterD4rt`) — it is the
> primary, recommended Flutter integration. It parses Dart source directly, has
> the simplest workflow, and covers desktop and mobile development. Reach for
> **this** AST-based package only when you specifically need the analyzer-free
> path: embedding in a shipping app for over-the-air updates, or running on the
> web (dart2js / dart2wasm). The two packages share the same bridge surface and
> script corpus; the AST variant trades the on-device parse step for a
> pre-compiled `AstBundle`.

### Source-based vs analyzer-free — which D4rt family

D4rt ships in two execution families, and `tom_d4rt_flutter_ast` is the
**analyzer-free** Flutter member:

- **Source-based (analyzer)** — `tom_d4rt`, `tom_d4rt_dcli`,
  **[`tom_d4rt_flutter`](../tom_d4rt_flutter)**. Parses Dart source with the
  analyzer, giving full type inference and precise error reporting. This is the
  **stable reference and usually the preferable choice**.
- **Analyzer-free (mirror AST)** — `tom_d4rt_ast`, `tom_ast_model`,
  `tom_ast_generator`, `tom_d4rt_exec`, `tom_dcli_exec`,
  **`tom_d4rt_flutter_ast`** (this package). Runs from pre-compiled `SAstNode`
  bundles with **no analyzer dependency at runtime**.

The analyzer-free path is what unlocks the two scenarios the source-based
runtime cannot serve:

- **Web** — the `analyzer` package is too large to ship via dart2js / dart2wasm,
  so the only way to interpret Dart UI in a browser is from a pre-compiled
  bundle.
- **Over-the-air UI updates** — compile a screen to an `AstBundle` on a server,
  download it into a shipping app, and render it at runtime — no app-store
  round trip and no user-side update.

Because generated AST bundles are large, prefer the source-based
[`tom_d4rt_flutter`](../tom_d4rt_flutter) unless one of those constraints
applies.

The bridge layer covers `dart:ui` plus the following Flutter library barrels:

| Library | Bridge file |
|---|---|
| `dart:ui` | `dart_ui_bridges.b.dart` |
| `flutter/painting.dart` | `painting_bridges.b.dart` |
| `flutter/foundation.dart` | `foundation_bridges.b.dart` |
| `flutter/animation.dart` | `animation_bridges.b.dart` |
| `flutter/physics.dart` | `physics_bridges.b.dart` |
| `flutter/scheduler.dart` | `scheduler_bridges.b.dart` |
| `flutter/semantics.dart` | `semantics_bridges.b.dart` |
| `flutter/services.dart` | `services_bridges.b.dart` |
| `flutter/gestures.dart` | `gestures_bridges.b.dart` |
| `flutter/rendering.dart` | `rendering_bridges.b.dart` |
| `flutter/widgets.dart` | `widgets_bridges.b.dart` |
| `flutter/material.dart` | `material_widgets_bridges.b.dart` |
| `flutter/cupertino.dart` | `cupertino_bridges.b.dart` |

## Installation

Add the package to your Flutter application's `pubspec.yaml`:

```yaml
dependencies:
  tom_d4rt_flutter_ast: ^0.1.1
```

Or via the command line:

```sh
dart pub add tom_d4rt_flutter_ast
```

The package pulls in its own transitive D4rt dependencies (`tom_d4rt_ast`,
`tom_d4rt_exec`, `tom_ast_generator`); nothing extra is needed in the consuming
project's `pubspec.yaml` for those.

## Usage

### Creating a FlutterD4rt instance

`FlutterD4rt` is the single entry point. Its default constructor creates a fresh
`D4rt` interpreter and immediately registers all Flutter-Material bridges:

```dart
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

final d4rt = FlutterD4rt();
```

If you already have a `D4rt` instance with other bridges registered (for example,
`tom_core_d4rt` bridges), wrap it instead of creating a second interpreter:

```dart
final base = D4rt();
// … register other bridges on base …
final d4rt = FlutterD4rt.withInterpreter(base);
```

### Building a widget from a D4rt script

A D4rt script that returns a widget must expose a top-level `build(BuildContext ctx)`
function. Compile the source into an `AstBundle`, then hand it to `FlutterD4rt.build`:

```dart
// Compile once, reuse the bundle as many times as needed.
final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Container(
    width: 200.0,
    height: 100.0,
    color: Colors.blue,
    child: const Center(
      child: Text('Hello from D4rt!'),
    ),
  );
}
''');

// Synchronous execution — wrap in a Builder to supply the BuildContext.
Widget myWidget = d4rt.build<Widget>(bundle, context);

// Or asynchronously (async entry function, or when called outside a build method).
Widget myWidget = await d4rt.buildAsync<Widget>(bundle, context);
```

### Returning non-widget values

The same API works for any bridged type. The `build` / `buildAsync` pair assumes the
entry function is named `build`; use `execute` / `executeAsync` for any other name:

```dart
// Return a Color.
final bundle = await d4rt.interpreter.createBundleFromSource('''
import 'package:flutter/painting.dart';

Color main() => Color.fromARGB(255, 100, 150, 200);
''');

final color = await d4rt.executeAsync<Color>(bundle);

// Call a named function with explicit arguments.
final result = await d4rt.executeAsync<Widget>(
  bundle,
  name: 'render',
  namedArgs: {'label': 'Hello'},
);
```

### Resetting between script runs

Call `resetScript()` between test runs to evict any script-declared top-level names
from the interpreter's environment, so successive calls see a clean global scope:

```dart
d4rt.resetScript();
```

### Error handling

Any unwrap mismatch (script returned a type that cannot be coerced to `T`) throws
`FlutterD4rtException`:

```dart
try {
  final widget = d4rt.build<Widget>(bundle, context);
} on FlutterD4rtException catch (e) {
  debugPrint('D4rt execution failed: $e');
}
```

## Features

### Full Flutter-Material surface

The bridge covers every class, constructor, named constructor, static method, and
property exposed by the thirteen library barrels listed in the overview table. Scripts
can use `StatelessWidget`, `StatefulWidget`, `State`, `AnimationController`, custom
painters, custom scroll physics, Cupertino widgets, and more.

### Proxy classes for abstract delegates

Flutter has several abstract delegate types (`CustomPainter`, `MultiChildLayoutDelegate`,
`SingleChildLayoutDelegate`, …) that scripts cannot subclass directly because D4rt
cannot instantiate abstract classes. The generated `flutter_proxies.b.dart` file
provides concrete `D4rtCustomPainter`, `D4rtMultiChildLayoutDelegate`, etc. wrappers
that accept callback closures from the interpreter and forward calls to native Flutter.

### Generic-type relaxers

The generated `flutter_relaxers.b.dart` file supplies `$Relaxed*` wrapper classes
(e.g. `$RelaxedAbstractLayoutBuilder<V>`, `$RelaxedTween<T>`) that bridge the gap
between D4rt's `<dynamic>` type arguments and Flutter's concrete generic expectations.
These are registered before `FlutterMaterialBridges` in `FlutterD4rt._registerBridges`
so that factories resolve in the correct order.

### Hand-written D4UserBridge overrides

Three classes in `lib/src/d4rt_user_bridges/` override specific auto-generated adapter
behaviour where the generator cannot produce a correct implementation:

| User bridge | Target | Why it overrides the generated code |
|---|---|---|
| `StateUserBridge` | `flutter/src/widgets/framework.dart :: State` | Defers `setState` calls that arrive mid-frame via `addPostFrameCallback`, avoiding `Build scheduled during frame` errors. |
| `StrutStyleUserBridge` | `dart:ui :: StrutStyle` | Always creates `painting.StrutStyle` instead of the opaque engine object so that property access (fontSize, height, fontWeight, …) works inside D4rt scripts. |
| `BasicMessageChannelUserBridge` | `flutter/src/services/platform_channel.dart :: BasicMessageChannel` | Bypasses the generic-typed `setMessageHandler` signature by installing the handler at the `BinaryMessenger` layer, avoiding a Dart runtime function-type check that the generator cannot satisfy. |

Each user bridge is a `D4UserBridge` subclass annotated with
`@D4rtUserBridge(libraryPath, className)`. The generator recognises these annotations
and routes the relevant method or constructor calls through the override instead of
the auto-generated adapter.

## Example applications

The companion **`tom_d4rt_flutter_ast_test`** project holds 33 self-contained
example apps under `tom_d4rt_flutter_ast_test/example/`, each a multi-file D4rt
program compiled to an `AstBundle` and rendered through `FlutterD4rt` on the
analyzer-free path. They are the broadest real-world exercise of the bridge
surface and the over-the-air UI scenario:

| | | | |
|---|---|---|---|
| `bezier_curve_editor` | `bottom_nav_shell` | `bouncing_balls_physics` | `calculator` |
| `card_swiper` | `carousel_pager` | `chat_ui` | `clock_face` |
| `color_picker_studio` | `conway_life` | `counter2` | `counter_app` |
| `drawing_pad` | `form_wizard` | `kanban_board` | `memory_match` |
| `note_app` | `particle_field` | `photo_gallery_hero` | `pomodoro_timer` |
| `slide_puzzle` | `snake_game` | `solitaire` | `solitaire2` |
| `stopwatch_laps` | `stpauls` | `stpeters` | `sudoku_app` |
| `tabbed_dashboard` | `tic_tac_toe` | `tip_calculator` | `todo_list` |
| `tron` | | | |

Run the demo application to browse and execute them interactively:

```bash
cd ../tom_d4rt_flutter_ast_test
flutter run            # native target
./run_web.sh           # dart2js web target
./run_wasm.sh          # dart2wasm web target (see script header for status)
```

Recompile the sample bundles after editing any sample:

```bash
flutter test tool/compile_samples_to_bundles.dart
```

The same sample set is mirrored in the source-direct sibling
(`tom_d4rt_flutter_test/example/`), so the two execution paths can be compared
app-for-app.

For a single, repo-curated starter see the
[`d4rt_flutter_sample`](../tom_d4rt_samples/d4rt_flutter_sample/README.md) in
the shared `tom_d4rt_samples` collection — a focused Flutter-Material script,
sitting alongside the interpreter, dcli, and advanced samples. This package's
own [`example/`](example/README.md) folder holds the minimal library-usage
snippet.

## Documentation

| Doc | What it covers |
|-----|----------------|
| [doc/tom_d4rt_flutter_ast_user_guide.md](doc/tom_d4rt_flutter_ast_user_guide.md) | **Differences-only guide** vs the source-based runtime — `FlutterD4rt`, bundle-driven execution, the sync/async entry points, and the web / over-the-air fit. |
| [doc/creating_fully_dynamic_applications.md](doc/creating_fully_dynamic_applications.md) | The over-the-air / fully-dynamic-app playbook — compiling UI to `AstBundle`s on a server, shipping them to a thin host app, and rendering them at runtime. |
| [doc/test_script_context.md](doc/test_script_context.md) | The script-side contract — the `build` / named-entry convention, the `BuildContext` argument, and what a bundle-driven script may assume. |
| [doc/tom_d4rt_flutter_ast_limitations.md](doc/tom_d4rt_flutter_ast_limitations.md) | AST-specific limitation deltas (no on-device parsing, bundle↔runtime version alignment, web) + backlinks to the base. |
| [../tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md](../tom_d4rt_flutter/doc/tom_d4rt_flutter_user_guide.md) | **Base Flutter-runtime guide** — shared bridge surface, registration order, performance/GC. Read this first. |
| [../tom_d4rt_flutter/doc/tom_d4rt_flutter_limitations.md](../tom_d4rt_flutter/doc/tom_d4rt_flutter_limitations.md) | Shared bridge-adapter limits catalogue with script workarounds. |
| [../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md](../tom_d4rt_ast/doc/tom_d4rt_ast_user_guide.md) | The analyzer-free interpreter core. |

## Architecture

### Generated bridges vs hand-written user bridges

```
lib/
  src/
    bridges/                  ← GENERATED — do not edit
      dart_ui_bridges.b.dart
      painting_bridges.b.dart
      foundation_bridges.b.dart
      animation_bridges.b.dart
      physics_bridges.b.dart
      scheduler_bridges.b.dart
      semantics_bridges.b.dart
      services_bridges.b.dart
      gestures_bridges.b.dart
      rendering_bridges.b.dart
      widgets_bridges.b.dart
      material_widgets_bridges.b.dart
      cupertino_bridges.b.dart
      flutter_bridges_barrel.b.dart   ← re-exports all bridge files
      flutter_proxies.b.dart          ← generated proxy/adapter subclasses
      flutter_relaxers.b.dart         ← generated generic-type relaxers
      material_bridges.b.dart         ← FlutterMaterialBridges.register(...)
    d4rt_user_bridges/        ← HAND-WRITTEN overrides
      basic_message_channel_user_bridge.dart
      state_user_bridge.dart
      strut_style_user_bridge.dart
    d4rt_runtime_registrations.dart   ← interface proxies, coercions, factories
    flutter_d4rt.dart                 ← FlutterD4rt + FlutterD4rtException
  tom_d4rt_flutter_ast.dart           ← public barrel export
tool/
  regenerate_bridges.dart             ← run to regenerate all *.b.dart files
```

Every `*.b.dart` file carries the comment `// D4rt Bridge - Generated file, do not edit`
at its top. They are produced by `tom_d4rt_generator` and must never be modified by hand.
Manual behaviour corrections belong exclusively in `lib/src/d4rt_user_bridges/` as
`D4UserBridge` subclasses.

### Regenerating bridges

Run from the project root whenever the Flutter SDK is upgraded or a bridge definition
needs updating:

```shell
dart run tool/regenerate_bridges.dart
```

The tool reads `buildkit.yaml` in the project root, invokes
`tom_d4rt_generator.generateBridges(...)`, and rewrites all `*.b.dart` files in
`lib/src/bridges/`. After regeneration, run `dart analyze` and the Flutter test
suite to verify correctness.

### Bridge registration order

`FlutterD4rt._registerBridges()` registers in a deliberate sequence:

1. `registerRelaxers()` — generic-type relaxers first so their factories appear
   below material on the newest-first chain.
2. `registerD4rtRuntimeExtensions()` — interface proxies, type coercions, and generic
   constructor factories (e.g. `GlobalKey`, `ValueNotifier<int>`).
3. `FlutterMaterialBridges.register(interpreter)` — all thirteen bridge barrels.
4. `interpreter.registerExtensions('tom_d4rt_flutter_ast', registerD4rtInterfaceProxyOverrides)`
   — post-material proxy overrides that depend on material's registrations being in place.
5. `interpreter.finalizeBridges()` — seals the bridge table.

Altering this order will break scripts that use generic-parameterised types.

## Ecosystem

The package sits at the top of the D4rt interpreter stack:

```
tom_ast_model
     |
tom_d4rt_ast          (analyzer-free AST interpreter runtime)
     |
tom_ast_generator     (AST bundle compiler)
     |
tom_d4rt_exec         (execution engine, D4rt, D4rtRunner)
     |
tom_d4rt_flutter_ast  (THIS — Flutter-Material bridge layer)

tom_d4rt_generator    (bridge generator — dev dependency only)
```

All packages are in the same git repository:
[github.com/al-the-bear/tom_d4rt](https://github.com/al-the-bear/tom_d4rt),
under the `tom_ai/d4rt/` sub-tree.

### Related packages

| Package | Relationship |
|---|---|
| [`tom_d4rt_flutter`](../tom_d4rt_flutter/README.md) | Source-based twin — same bridge surface and script corpus on the analyzer path. |
| [`tom_d4rt_ast`](../tom_d4rt_ast/README.md) | The zero-dependency analyzer-free interpreter core this package runs on. |
| [`tom_ast_generator`](../tom_ast_generator/README.md) | Compiles Dart source into the `AstBundle`s this package executes. |
| [`tom_d4rt_flutter_ast_test`](../tom_d4rt_flutter_ast_test/README.md) | The demo/test app and the 33-sample conformance corpus. |
| [`tom_d4rt_generator`](../tom_d4rt_generator/README.md) | Generates the `*.b.dart` bridges (dev dependency only). |

## Status

- Version: `0.1.1`
- Requires Flutter `>=3.27.0`, Dart SDK `^3.10.4`
- D4rt interpreter limits with recommended script-level workarounds live in
  this package's
  [`doc/tom_d4rt_flutter_ast_limitations.md`](doc/tom_d4rt_flutter_ast_limitations.md)
  delta and the shared base
  [`../tom_d4rt_flutter/doc/tom_d4rt_flutter_limitations.md`](../tom_d4rt_flutter/doc/tom_d4rt_flutter_limitations.md).
- A planned consolidation will move generic D4rt machinery upstream into
  `tom_d4rt_ast`/`tom_d4rt_exec`, keeping only the Flutter-specific surface in
  this package.

> The `doc/flutter_bugs.md`, `interpreter_issues.md`,
> `interpreter_unfixable.md`, `interpreter_generator_open_issues.md`, and
> `generator_issues.md` files are **internal development logs**, not user
> documentation — they ship for development context only.

Repository:
[https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_flutter_ast](https://github.com/al-the-bear/tom_d4rt/tree/main/tom_d4rt_flutter_ast)
