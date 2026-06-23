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

import 'bridges/material_bridges.b.dart';
import 'd4rt_runtime_registrations.dart';
import 'sample_source.dart';
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
    // Import-optimization step #19: pay the expensive bridge-registration cost
    // only the first time this package is seen in the process. `providePackage`
    // returns `false` on first sight (and opens the registration context so the
    // `register*` calls below land in the package pool) and `true` on later
    // instances, which reuse the pooled definitions. Every registration here
    // targets process-global tables — relaxers and interface proxies land in
    // static `D4` maps, the material bridges register lazy thunks into the
    // pooled bundle, and the extension callback is once-per-package-per-process
    // — so running this block exactly once is correct and sufficient.
    if (_interpreter.providePackage('tom_d4rt_flutter') == false) {
      registerRelaxers();
      registerD4rtRuntimeExtensions();
      FlutterMaterialBridges.register(_interpreter);
      _interpreter.registerExtensions(
        'tom_d4rt_flutter',
        registerD4rtInterfaceProxyOverrides,
      );
    }
    // `finalizeBridges()` runs on every instance: it builds this instance's
    // warm parent from the pooled definitions and fires any not-yet-fired
    // extension callbacks. It is cheap on later instances (its own
    // `_bridgesFinalized` / once-per-process guards short-circuit the work).
    _interpreter.finalizeBridges();
  }

  /// The underlying interpreter — exposed for advanced use (e.g., tests
  /// that want to inspect the environment directly).
  D4rt get interpreter => _interpreter;

  /// Import-optimization step #21 — pay the residual per-instance warm cost
  /// off the first frame.
  ///
  /// Construction already registers the (process-global) bridge surface, but
  /// the per-instance **warm parent** — the immutable `Environment` every
  /// [build] / [execute] chains a fresh child off — plus the stdlib
  /// registration and (source-side) the analyzer parser front-end are warmed
  /// lazily on the **first** real build, adding that one-time cost to the
  /// first on-screen frame. Calling [warmup] once after construction moves
  /// that cost off-frame so the first script build renders without the
  /// warm-up stall. The idiomatic call site is a post-first-frame callback
  /// (or a splash-screen / background microtask):
  ///
  /// ```dart
  /// final d4rt = SourceFlutterD4rt();
  /// WidgetsBinding.instance.addPostFrameCallback((_) => d4rt.warmup());
  /// ```
  ///
  /// Idempotent and script-neutral: the warm-up environment (and the
  /// throwaway `int main() => 0;` parse) is discarded and leaves no script
  /// declarations behind. Forwards to [D4rt.warmup].
  void warmup() => _interpreter.warmup();

  /// Execute [source] and extract the result as type [T].
  ///
  /// Calls the function named `'build'` with [buildContext] as the first
  /// positional argument when [buildContext] is provided. Most corpus
  /// scripts in `send_ast_via_http_scripts/` follow this shape.
  T build<T>(String source, [BuildContext? buildContext]) => _wrapUnwrap(() {
        final raw = _interpreter.execute(
          source: source,
          name: 'build',
          positionalArgs: buildContext != null ? [buildContext] : null,
        );
        // Pass the visitor so that InterpretedInstance proxy resolution
        // works when unwrapping is called after execute() returns (mirrors
        // D4rtRunner.executeBundleAs which always passes visitor: _visitor).
        return D4.unwrapAs<T>(raw, visitor: _interpreter.visitor);
      });

  /// Execute a multi-file Dart program rooted at [mainFilePath] and return
  /// the result of its `build` function as [T].
  ///
  /// Recursively resolves every relative `import 'xxx.dart';` directive
  /// inside [mainFilePath] and its transitive imports into the interpreter's
  /// in-memory sources map, then calls
  /// `D4rt.execute(library: <main>, sources: ..., name: 'build', ...)` with
  /// the supplied [buildContext]. `package:` and `dart:` imports are left
  /// to the bridge layer to resolve.
  ///
  /// This is the entry point for sample apps in `example/<name>/` whose
  /// gameplay logic spans more than one file.
  ///
  /// Reads from disk — desktop only. Mobile builds load the source set from
  /// bundled assets via [SampleSource] and run it through [buildProgram].
  T buildMultiFile<T>(
    String mainFilePath, {
    BuildContext? buildContext,
  }) =>
      buildProgram<T>(buildDiskProgram(mainFilePath),
          buildContext: buildContext);

  /// Run an already-resolved multi-file [program] and return the result of
  /// its `build` function as [T].
  ///
  /// The program's [SampleProgram.sources] map must already contain every
  /// transitively-imported file, so the interpreter performs no filesystem
  /// access (`allowFileSystemImports: false`). This is the platform-neutral
  /// core shared by the disk path ([buildMultiFile]) and the asset path used
  /// on iOS / iPadOS / Android.
  T buildProgram<T>(
    SampleProgram program, {
    BuildContext? buildContext,
  }) =>
      _wrapUnwrap(() {
        final raw = _interpreter.execute(
          library: program.libraryUri,
          sources: program.sources,
          basePath: program.basePath,
          allowFileSystemImports: false,
          name: 'build',
          positionalArgs: buildContext != null ? [buildContext] : null,
        );
        return D4.unwrapAs<T>(raw, visitor: _interpreter.visitor);
      });

  /// §U28 / TODO #14 — Evict script-declared entries from the underlying
  /// interpreter so a follower [build] / [execute] starts with the same
  /// global-environment name-set the last `execute` produced.
  ///
  /// Forwards to [D4rt.resetScriptDeclarations]. Intended to be called
  /// from the host app's `/clear` handler between test runs.
  ///
  /// Note: per `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md` §U28,
  /// the `tom_d4rt_flutter_test` source-direct path is NOT affected by
  /// the U28 wedge (only `tom_d4rt_flutter_ast`'s bundle-driven path
  /// is). The reset is provided here for parity so both app variants
  /// expose the same `/clear` contract; whether it's a no-op or
  /// useful depends entirely on the host app's lifecycle.
  ///
  /// See `D4rt.resetScriptDeclarations` for the architectural caveat
  /// (the analyzer-based interpreter already builds a fresh
  /// `ModuleLoader` per `execute*`).
  void resetScript() => _interpreter.resetScriptDeclarations();

  /// Generic execute — call the function [name] with the given arguments
  /// and unwrap the result as [T].
  T execute<T>(
    String source, {
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) =>
      _wrapUnwrap(() {
        final raw = _interpreter.execute(
          source: source,
          name: name,
          positionalArgs: positionalArgs,
          namedArgs: namedArgs,
        );
        return D4.unwrapAs<T>(raw, visitor: _interpreter.visitor);
      });

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
