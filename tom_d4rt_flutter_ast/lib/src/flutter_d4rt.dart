import 'package:flutter/widgets.dart';
import 'package:tom_d4rt_ast/d4rt.dart';

import 'bridges/material_bridges.b.dart';
import 'bridges/flutter_relaxers.b.dart';
import 'd4rt_runtime_registrations.dart';

/// D4rt interpreter configured with Flutter Material bridges.
///
/// Wraps a [D4rt] interpreter with pre-registered Flutter Material bridges
/// and provides [build] / [buildAsync] methods to execute D4rt scripts
/// and extract native Flutter objects from the results.
///
/// ```dart
/// final d4rt = FlutterD4rt();
/// final widget = d4rt.build<Widget>(bundle, context);          // sync
/// final widget = await d4rt.buildAsync<Widget>(bundle, context); // async
/// final color  = d4rt.build<Color>(bundle);                     // no context
/// ```
///
/// All four entry points ([build], [buildAsync], [execute], [executeAsync])
/// route through `D4rt.executeBundleAs<T>` / `executeBundleAsAsync<T>`,
/// which apply the shared `D4.unwrapAs<T>` helper. Any `D4UnwrapException`
/// surfacing from the runner is re-thrown as [FlutterD4rtException] so
/// the public exception contract is preserved.
class FlutterD4rt {
  final D4rt _interpreter;

  /// Creates a new [FlutterD4rt] instance with Flutter bridges registered.
  FlutterD4rt() : _interpreter = D4rtRunner() {
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
    // Pre-material: user-bridge relaxers and runtime extensions must
    // register their generic-constructor factories BEFORE material so
    // material's auto-gen factory ends up on top of the
    // newest-first chain. Putting them after material flips the chain
    // and breaks scripts like `ValueNotifier<int>(0)` (the user-bridge
    // factory hard-casts to `double?`).
    registerRelaxers();
    registerD4rtRuntimeExtensions();
    FlutterMaterialBridges.register(_interpreter);
    // Post-material: `registerD4rtInterfaceProxyOverrides` rewrites a
    // handful of `<dynamic>`-parameterised proxies with concrete type
    // arguments and depends on material's proxy registrations being in
    // place. The extension hook fires it after material at finalize
    // time (explicit below, or implicitly on the first execute).
    _interpreter.registerExtensions(
      'tom_d4rt_flutter_ast',
      registerD4rtInterfaceProxyOverrides,
    );
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

  /// §U28 / TODO #14 — Evict script-declared entries from the underlying
  /// interpreter so a follower [build] / [execute] starts with the same
  /// global-environment name-set the first build saw.
  ///
  /// Forwards to [D4rt.resetScriptDeclarations]. Intended to be called
  /// from the host app's `/clear` handler between test runs.
  ///
  /// See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` §U28 for
  /// the architectural caveat: the underlying runner already builds a
  /// fresh `Environment` per `executeBundle`, so this is a forward-
  /// compatibility hook rather than the §U28 wedge fix. The existing
  /// `SendTestRunner.requestRecycle()` hook in
  /// `interactive_tests_test.dart` is preserved as the actual wedge
  /// workaround.
  void resetScript() => _interpreter.resetScriptDeclarations();

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
