import 'package:flutter/widgets.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

import 'bridges/material_bridges.b.dart';
import 'bridges/flutter_relaxers.b.dart';
import 'd4rt_runtime_registrations.dart';

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
///
/// All four entry points (`build`, `buildAsync`, `execute`, `executeAsync`)
/// route through `D4rt.executeBundleAs<T>` / `executeBundleAsAsync<T>`,
/// which apply the shared `D4.unwrapAs<T>` helper. The local
/// [FlutterD4rtException] type is preserved as the public exception
/// contract — any [D4UnwrapException] surfacing from the runner is
/// re-thrown wrapped in [FlutterD4rtException].
class FlutterD4rt {
  final D4rt _interpreter;

  /// Creates a new [FlutterD4rt] instance with Flutter bridges registered.
  FlutterD4rt() : _interpreter = D4rt() {
    _registerBridges();
  }

  /// Creates a [FlutterD4rt] wrapping an existing [D4rt] interpreter.
  ///
  /// Use this to add Flutter bridges to an interpreter that already has other
  /// bridges registered (e.g., tom_core_d4rt bridges).
  ///
  /// Bridges are registered immediately on construction.
  FlutterD4rt.withInterpreter(this._interpreter) {
    _registerBridges();
  }

  void _registerBridges() {
    // Step 6: bridge registration uses the runner's extension hook for
    // the post-material work — the comment-driven "must run AFTER
    // bridges" rule is now enforced by the runner.
    //
    // Important ordering: user-bridge relaxers and runtime extensions
    // run BEFORE FlutterMaterialBridges.register. Generic constructor
    // factories chain newest-first; if the user-bridge factory for a
    // type like `ValueNotifier<T>` registers AFTER material's
    // auto-generated factory, the user-bridge factory becomes the
    // primary and breaks scripts whose `T` differs from the
    // user-bridge's hard-coded cast (e.g. `ValueNotifier<int>(0)`
    // hitting a `double?` cast). Keeping user-bridge registrations
    // first puts material's auto-gen factory on top of the chain,
    // matching the order proven by the step-5 baseline.
    //
    // GEN-079: auto-generated generic type relaxers.
    registerRelaxers();
    // RC-2 (TODO): once d4rtgen emits `registerGenericConstructors()` in
    // flutter_relaxers.b.dart, uncomment the call below. Today the
    // generic constructor factories live in
    // `registerD4rtRuntimeExtensions()`.
    // registerGenericConstructors();
    registerD4rtRuntimeExtensions();
    FlutterMaterialBridges.register(_interpreter);
    // Bug-103: registerD4rtInterfaceProxyOverrides re-registers a
    // handful of <dynamic>-parameterised proxies with concrete type
    // arguments and must run AFTER FlutterMaterialBridges.register.
    // The runner runs the queued callback at finalize time — either via
    // the explicit `finalizeBridges()` below, or implicitly on the
    // first script execution if the embedder skips it.
    _interpreter.registerExtensions('tom_d4rt_flutterm', () {
      registerD4rtInterfaceProxyOverrides();
    });
    _interpreter.finalizeBridges();
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
  T build<T>(AstBundle bundle, [BuildContext? buildContext]) =>
      _wrapUnwrap(() => _interpreter.executeBundleAs<T>(
            bundle,
            name: 'build',
            positionalArgs: _argsForContext(buildContext),
          ));

  /// Execute a D4rt bundle asynchronously and extract the result as type [T].
  ///
  /// Same as [build] but handles async entry functions (returning Future).
  Future<T> buildAsync<T>(
    AstBundle bundle, [
    BuildContext? buildContext,
  ]) =>
      _wrapUnwrapAsync(() => _interpreter.executeBundleAsAsync<T>(
            bundle,
            name: 'build',
            positionalArgs: _argsForContext(buildContext),
          ));

  /// Execute a named function from the bundle and extract the result.
  ///
  /// More flexible than [build] — allows calling any function by name
  /// with arbitrary arguments.
  T execute<T>(
    AstBundle bundle, {
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) =>
      _wrapUnwrap(() => _interpreter.executeBundleAs<T>(
            bundle,
            name: name,
            positionalArgs: positionalArgs,
            namedArgs: namedArgs,
          ));

  /// Async version of [execute].
  Future<T> executeAsync<T>(
    AstBundle bundle, {
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) =>
      _wrapUnwrapAsync(() => _interpreter.executeBundleAsAsync<T>(
            bundle,
            name: name,
            positionalArgs: positionalArgs,
            namedArgs: namedArgs,
          ));

  static List<Object?>? _argsForContext(BuildContext? buildContext) =>
      buildContext == null ? null : <Object?>[buildContext];

  /// Run [body] and re-throw any [D4UnwrapException] as
  /// [FlutterD4rtException] so the public exception contract is preserved.
  static T _wrapUnwrap<T>(T Function() body) {
    try {
      return body();
    } on D4UnwrapException catch (e) {
      throw FlutterD4rtException(e.message);
    }
  }

  /// Async variant of [_wrapUnwrap].
  static Future<T> _wrapUnwrapAsync<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on D4UnwrapException catch (e) {
      throw FlutterD4rtException(e.message);
    }
  }
}

/// Exception thrown by [FlutterD4rt] operations.
class FlutterD4rtException implements Exception {
  final String message;
  const FlutterD4rtException(this.message);

  @override
  String toString() => 'FlutterD4rtException: $message';
}
