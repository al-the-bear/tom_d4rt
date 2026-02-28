import 'package:flutter/widgets.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

import 'bridges/material_bridges.b.dart';

/// D4rt interpreter configured with Flutter Material bridges.
///
/// Wraps a [D4rt] interpreter with pre-registered Flutter Material bridges
/// and provides [build] / [buildAsync] methods to execute D4rt scripts
/// and extract native Flutter objects from the results.
///
/// ## Example
///
/// ```dart
/// final d4rt = FlutterD4rt();
///
/// // Sync build (script must be sync)
/// final widget = d4rt.build<Widget>(bundle, context);
///
/// // Async build
/// final widget = await d4rt.buildAsync<Widget>(bundle, context);
///
/// // Build without BuildContext (for non-widget objects)
/// final color = d4rt.build<Color>(bundle);
/// ```
class FlutterD4rt {
  final D4rt _interpreter;

  /// Creates a new [FlutterD4rt] instance with Flutter bridges registered.
  FlutterD4rt() : _interpreter = D4rt() {
    FlutterMaterialBridges.register(_interpreter);
  }

  /// Creates a [FlutterD4rt] wrapping an existing [D4rt] interpreter.
  ///
  /// Use this to add Flutter bridges to an interpreter that already has other
  /// bridges registered (e.g., tom_core_d4rt bridges).
  ///
  /// Bridges are registered immediately on construction.
  FlutterD4rt.withInterpreter(this._interpreter) {
    FlutterMaterialBridges.register(_interpreter);
  }

  /// The underlying [D4rt] interpreter.
  D4rt get interpreter => _interpreter;

  /// Execute a D4rt bundle and extract the result as type [T].
  ///
  /// The bundle's entry function (default: `build`) should return an object
  /// of type [T]. If [buildContext] is provided, it is passed as the first
  /// positional argument to the entry function.
  ///
  /// The result is automatically unwrapped from D4rt's [BridgedInstance]
  /// wrapper to return the native Dart/Flutter object.
  ///
  /// ## Example
  /// ```dart
  /// // D4rt script:
  /// // Widget build(BuildContext context) {
  /// //   return Center(child: Text('Hello from D4rt!'));
  /// // }
  ///
  /// final widget = d4rt.build<Widget>(bundle, context);
  /// ```
  T build<T>(AstBundle bundle, [BuildContext? buildContext]) {
    final positionalArgs = <Object?>[];
    if (buildContext != null) {
      positionalArgs.add(buildContext);
    }

    final result = _interpreter.executeBundle(
      bundle,
      name: 'build',
      positionalArgs: positionalArgs,
    );

    return _unwrap<T>(result);
  }

  /// Execute a D4rt bundle asynchronously and extract the result as type [T].
  ///
  /// Same as [build] but handles async entry functions (returning Future).
  Future<T> buildAsync<T>(
    AstBundle bundle, [
    BuildContext? buildContext,
  ]) async {
    final positionalArgs = <Object?>[];
    if (buildContext != null) {
      positionalArgs.add(buildContext);
    }

    final result = _interpreter.executeBundle(
      bundle,
      name: 'build',
      positionalArgs: positionalArgs,
    );

    final resolved = result is Future ? await result : result;
    return _unwrap<T>(resolved);
  }

  /// Execute a named function from the bundle and extract the result.
  ///
  /// More flexible than [build] — allows calling any function by name
  /// with arbitrary arguments.
  T execute<T>(
    AstBundle bundle, {
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    final result = _interpreter.executeBundle(
      bundle,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );

    return _unwrap<T>(result);
  }

  /// Async version of [execute].
  Future<T> executeAsync<T>(
    AstBundle bundle, {
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) async {
    final result = _interpreter.executeBundle(
      bundle,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );

    final resolved = result is Future ? await result : result;
    return _unwrap<T>(resolved);
  }

  /// Unwrap a D4rt result value to its native Dart type.
  T _unwrap<T>(Object? result) {
    if (result is BridgedInstance) {
      final native = result.nativeObject;
      if (native is T) return native as T;
      throw FlutterD4rtException(
        'Expected $T but got ${native.runtimeType} '
        '(unwrapped from BridgedInstance<${result.bridgedClass.name}>)',
      );
    }
    if (result is BridgedEnumValue) {
      final native = result.nativeValue;
      if (native is T) return native as T;
      throw FlutterD4rtException(
        'Expected $T but got ${native.runtimeType} (from BridgedEnumValue)',
      );
    }
    if (result is T) return result;
    if (result == null && null is T) return result as T;
    throw FlutterD4rtException('Expected $T but got ${result.runtimeType}');
  }
}

/// Exception thrown by [FlutterD4rt] operations.
class FlutterD4rtException implements Exception {
  final String message;
  const FlutterD4rtException(this.message);

  @override
  String toString() => 'FlutterD4rtException: $message';
}
