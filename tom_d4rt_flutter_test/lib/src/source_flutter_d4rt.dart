/// Source-based Flutter D4rt entry point.
///
/// Parallel to `FlutterD4rt` in `tom_d4rt_flutter_ast`, but driven by the
/// analyzer-based [D4rt] interpreter from `package:tom_d4rt`. Accepts raw
/// Dart source strings rather than pre-compiled `AstBundle` objects, so
/// scripts can be loaded straight from disk without an offline compile
/// step.
library;

import 'package:flutter/widgets.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'bridges/animation_bridges.b.dart' as flutter_animation_bridge;
import 'bridges/dart_ui_bridges.b.dart' as dart_ui_bridge;
import 'bridges/foundation_bridges.b.dart' as flutter_foundation_bridge;
import 'bridges/gestures_bridges.b.dart' as flutter_gestures_bridge;
import 'bridges/material_bridges.b.dart';
import 'bridges/material_widgets_bridges.b.dart' as flutter_material_bridge;
import 'bridges/painting_bridges.b.dart' as flutter_painting_bridge;
import 'bridges/physics_bridges.b.dart' as flutter_physics_bridge;
import 'bridges/rendering_bridges.b.dart' as flutter_rendering_bridge;
import 'bridges/scheduler_bridges.b.dart' as flutter_scheduler_bridge;
import 'bridges/semantics_bridges.b.dart' as flutter_semantics_bridge;
import 'bridges/services_bridges.b.dart' as flutter_services_bridge;
import 'bridges/widgets_bridges.b.dart' as flutter_widgets_bridge;
import 'd4rt_runtime_registrations.dart';
// ignore: unused_import — registers $RelaxedTween via top-level call below.
import 'bridges/flutter_relaxers.b.dart';

/// D4rt interpreter (source-based) configured with Flutter Material bridges.
///
/// On construction, registers the full Flutter bridge surface plus runtime
/// extensions, then calls [D4rt.finalizeBridges] so the interpreter is ready
/// to evaluate scripts via [build] or [execute].
///
/// All registrations target static maps on the `D4` class
/// (`D4._interfaceProxies`, `D4._genericTypeWrappers`, …), not the
/// interpreter instance — so even though we pass `_interpreter` to
/// [FlutterMaterialBridges.register] the relaxer/proxy hooks are
/// process-global. Constructing more than one [SourceFlutterD4rt] in a
/// single isolate is safe; later constructions are effectively idempotent
/// as long as the registration tables don't drift.
class SourceFlutterD4rt {
  final D4rt _interpreter;

  /// Creates a fresh [D4rt] interpreter with all bridges registered.
  SourceFlutterD4rt() : _interpreter = D4rt() {
    _registerBridges();
  }

  /// Use an existing [D4rt] instance — useful for tests that need to
  /// pre-seed the runner or share an interpreter across calls.
  SourceFlutterD4rt.withInterpreter(this._interpreter) {
    _registerBridges();
  }

  void _registerBridges() {
    registerRelaxers();
    registerD4rtRuntimeExtensions();
    FlutterMaterialBridges.register(_interpreter);
    // Register all Flutter bridge packages also under 'package:flutter/material.dart'.
    //
    // In real Flutter, `material.dart` transitively re-exports everything from
    // `widgets.dart`, `foundation.dart`, `rendering.dart`, etc. D4rt's module
    // loader looks up bridges by the exact import URI that the script uses.
    // Corpus scripts typically import only `package:flutter/material.dart`, so
    // all Flutter types (Widget, BuildContext, State, …) must be registered
    // under that URI too. The per-execute deduplication logic in ModuleLoader
    // prevents double-registration when a script also imports the individual
    // sub-package barrels.
    _registerMaterialAliases();
    _interpreter.registerExtensions(
      'tom_d4rt_flutter_test',
      registerD4rtInterfaceProxyOverrides,
    );
    _interpreter.finalizeBridges();
  }

  /// Registers every Flutter bridge package also under
  /// `'package:flutter/material.dart'`, simulating the transitive re-export
  /// chain that real Flutter provides.
  ///
  /// This is a one-time cost at interpreter construction. The entries are added
  /// to `D4rt._bridgedClases` so that when the module loader processes an
  /// `import 'package:flutter/material.dart'` directive in a script, it finds
  /// all Flutter types (not just material-specific ones).
  void _registerMaterialAliases() {
    const m = 'package:flutter/material.dart';
    dart_ui_bridge.DartUiBridge.registerBridges(_interpreter, m);
    flutter_painting_bridge.FlutterPaintingBridge.registerBridges(
        _interpreter, m);
    flutter_foundation_bridge.FlutterFoundationBridge.registerBridges(
        _interpreter, m);
    flutter_animation_bridge.FlutterAnimationBridge.registerBridges(
        _interpreter, m);
    flutter_physics_bridge.FlutterPhysicsBridge.registerBridges(
        _interpreter, m);
    flutter_scheduler_bridge.FlutterSchedulerBridge.registerBridges(
        _interpreter, m);
    flutter_semantics_bridge.FlutterSemanticsBridge.registerBridges(
        _interpreter, m);
    flutter_services_bridge.FlutterServicesBridge.registerBridges(
        _interpreter, m);
    flutter_gestures_bridge.FlutterGesturesBridge.registerBridges(
        _interpreter, m);
    flutter_rendering_bridge.FlutterRenderingBridge.registerBridges(
        _interpreter, m);
    flutter_widgets_bridge.FlutterWidgetsBridge.registerBridges(
        _interpreter, m);
    // FlutterMaterialBridge is already registered under `m` by
    // FlutterMaterialBridges.register — calling it again is idempotent
    // thanks to the sourceUri-based deduplication in ModuleLoader.
    flutter_material_bridge.FlutterMaterialBridge.registerBridges(
        _interpreter, m);
  }

  /// The underlying interpreter — exposed for advanced use (e.g., tests
  /// that want to inspect the environment directly).
  D4rt get interpreter => _interpreter;

  /// Execute [source] and extract the result as type [T].
  ///
  /// Calls the function named `'build'` with [buildContext] as the first
  /// positional argument when [buildContext] is provided. Most corpus
  /// scripts in `send_ast_via_http_scripts/` follow this shape.
  T build<T>(String source, [BuildContext? buildContext]) =>
      _wrapUnwrap(() => D4.unwrapAs<T>(_interpreter.execute(
            source: source,
            name: 'build',
            positionalArgs: buildContext != null ? [buildContext] : null,
          )));

  /// Generic execute — call the function [name] with the given arguments
  /// and unwrap the result as [T].
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

/// Thrown when [SourceFlutterD4rt.build] or [SourceFlutterD4rt.execute]
/// receives a value the interpreter cannot unwrap to the requested type.
class SourceFlutterD4rtException implements Exception {
  final String message;
  const SourceFlutterD4rtException(this.message);

  @override
  String toString() => 'SourceFlutterD4rtException: $message';
}
