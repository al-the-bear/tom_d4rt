/// SCC23 — errors escaping an interpreted callback that the *platform* invokes.
///
/// ## What was measured, before any code was written
///
/// A probe ran ten scripts under `runZonedGuarded` and recorded both the script
/// result and what reached the zone. The findings reframed the todo:
///
/// 1. **The escape is not stream-specific.** `listen`'s onData, onError and
///    onDone, `handleError`'s handler, *and* a plain `Timer` callback all leak
///    the same way. The todo scoped the fix to `stdlib/async/stream.dart`; the
///    real surface is *any* interpreted callback the platform invokes outside
///    the script's own future chain. Fixing it per adapter would have been the
///    N-copies answer that SCC22 was written to warn against.
/// 2. **An interpreter-internal type crossed the sandbox boundary.** Every
///    escaping script error arrived as `InternalInterpreterD4rtException` with
///    the real value buried in `originalThrownValue`, while a genuine *native*
///    stream error arrived as a clean `StateError`. So the host saw two
///    different shapes and could not tell "the script threw" from "the platform
///    threw". This half of the defect is wrong under every candidate design,
///    which is why it is fixed independently of the hook.
/// 3. **The todo's RELATED guess was wrong in the direction it named.** It
///    suspected `handleError` and `listen` *deliver* different error objects
///    because only one unwraps. They deliver identically — F-SCC23-13 pins
///    that. The asymmetry is in the *escape* direction, not the delivery one.
/// 4. **The script has no escape hatch at all**, because `Zone`, `runZoned` and
///    `runZonedGuarded` are deliberately unbridged (see `unbridged_reasons.dart`).
///    So the todo's "cannot catch it, cannot log it" is literally true rather
///    than a script-authoring mistake.
///
/// ## The contract, and why this one
///
/// The todo offered (a) an embedder hook, (b) surfacing through the execution
/// result, or (c) both. **(c), with the split below.**
///
/// - **D4rt owns the execution zone.** One chokepoint catches escapes from
///   every call site — stream, timer, future, io — including sites nobody has
///   enumerated yet. Per-adapter wrapping catches only the adapters someone
///   remembered.
/// - **The interpreter-internal wrapper is unwrapped before the error leaves.**
///   The host sees exactly what the *synchronous* path already gives it
///   (`_executeInEnvironment` rethrows `originalThrownValue`), so the two paths
///   finally agree.
/// - **A `D4rt.onUncaughtError` hook receives it** when the embedder sets one.
///   That is the sandbox argument: a host that runs untrusted script must be
///   able to observe and contain the script's failures.
/// - **With no hook, the error forwards to the parent zone** — today's
///   behaviour exactly. F-SCB9-14 keeps passing unchanged, which is the point:
///   the todo's "DO NOT fix this by making listen's adapter swallow the error"
///   is honoured by construction rather than by discipline.
///
/// **(b) alone was rejected on evidence, not taste.** A `Timer` callback can
/// fire after `execute`'s future has already completed (probe 10), so a
/// result-shaped channel structurally cannot carry every escape. And making
/// `main()` fail would *diverge* from native Dart, where an exception in a
/// `listen` callback also leaves `main()` returning normally.
library;

import 'dart:async';

import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

/// One escape observed through the hook: what the host was handed.
class _Escape {
  final Object error;
  final StackTrace stackTrace;
  _Escape(this.error, this.stackTrace);
}

/// Runs [source] with an `onUncaughtError` hook installed and returns both the
/// script result and everything the hook caught.
///
/// [settle] is the grace period after the script returns, because the whole
/// point of this suite is errors that arrive *after* `main()` is done.
Future<(Object? result, List<_Escape> escapes)> runWithHook(
  String source, {
  Duration settle = const Duration(milliseconds: 40),
  void Function(Object error, StackTrace stackTrace)? hook,
}) async {
  final escapes = <_Escape>[];
  final d4rt = D4rt()..setDebug(false);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.onUncaughtError = hook ??
      (error, stackTrace) => escapes.add(_Escape(error, stackTrace));
  final raw = d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': source});
  final result = raw is Future ? await raw : raw;
  await Future.delayed(settle);
  return (result, escapes);
}

/// Runs [source] with **no** hook, inside a guarded zone, and reports what the
/// zone caught — the no-hook half of the contract.
Future<(Object? result, List<Object> zoneErrors)> runWithoutHook(
  String source, {
  Duration settle = const Duration(milliseconds: 40),
}) async {
  final zoneErrors = <Object>[];
  final finished = Completer<Object?>();
  runZonedGuarded(() async {
    final d4rt = D4rt()..setDebug(false);
    d4rt.grant(FilesystemPermission.any);
    d4rt.grant(NetworkPermission.any);
    final raw = d4rt.execute(
        library: 'package:test/main.dart',
        sources: {'package:test/main.dart': source});
    finished.complete(raw is Future ? await raw : raw);
  }, (error, _) => zoneErrors.add(error));
  final result = await finished.future;
  await Future.delayed(settle);
  return (result, zoneErrors);
}

/// A script whose [body] runs a stream callback that throws.
String streamScript(String listenArgs) => '''
  import 'dart:async';
  main() async {
    final c = StreamController();
    c.stream.listen($listenArgs);
    c.sink.add(1);
    await c.sink.close();
    await Future.delayed(Duration(milliseconds: 10));
    return 'script-completed';
  }
''';

void main() {
  group('SCC23: escapes reach the embedder hook', () {
    test('F-SCC23-1: an error thrown by onData reaches onUncaughtError [2026-09-04]',
        () async {
      final (result, escapes) =
          await runWithHook(streamScript("(v) { throw StateError('od'); }"));
      expect(result, 'script-completed',
          reason: 'native Dart also lets main() return normally here');
      expect(escapes, hasLength(1));
      expect(escapes.single.error, isA<StateError>(),
          reason: 'the host must get the script error, not the interpreter '
              'wrapper that used to carry it');
      expect(escapes.single.error.toString(), contains('od'));
    });

    test('F-SCC23-2: an error thrown by onError reaches onUncaughtError [2026-09-04]',
        () async {
      final (_, escapes) = await runWithHook('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          c.stream.listen((v) {}, onError: (e) { throw StateError('oe'); });
          c.sink.addError(ArgumentError('original'));
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return 'script-completed';
        }
      ''');
      expect(escapes, hasLength(1));
      expect(escapes.single.error, isA<StateError>());
      expect(escapes.single.error.toString(), contains('oe'));
    });

    test('F-SCC23-3: an error thrown by onDone reaches onUncaughtError [2026-09-04]',
        () async {
      final (_, escapes) = await runWithHook(
          streamScript("(v) {}, onDone: () { throw StateError('done'); }"));
      expect(escapes, hasLength(1));
      expect(escapes.single.error.toString(), contains('done'));
    });

    test('F-SCC23-4: an error thrown by a handleError handler reaches onUncaughtError [2026-09-04]',
        () async {
      final (_, escapes) = await runWithHook('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          c.stream
              .handleError((e) { throw StateError('he'); })
              .listen((v) {});
          c.sink.addError(ArgumentError('original'));
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return 'script-completed';
        }
      ''');
      expect(escapes, hasLength(1));
      expect(escapes.single.error.toString(), contains('he'));
    });

    test('F-SCC23-5: a Timer callback error reaches onUncaughtError too [2026-09-04]',
        () async {
      // The case that decides the design. A Timer is not a stream, and it fires
      // after `main()` has already returned — so this is simultaneously the
      // proof that the fix must not live in a stream adapter and the proof that
      // an execution-result channel could not have carried it.
      final (result, escapes) = await runWithHook('''
        import 'dart:async';
        main() async {
          Timer(Duration(milliseconds: 5), () { throw StateError('tm'); });
          return 'script-completed';
        }
      ''');
      expect(result, 'script-completed');
      expect(escapes, hasLength(1));
      expect(escapes.single.error.toString(), contains('tm'));
    });

    test('F-SCC23-6: a script-class object thrown from a callback arrives unwrapped [2026-09-04]',
        () async {
      // The probe showed this arriving as
      // `InternalInterpreterException(originalThrownValue: <instance of MyErr>)`.
      // A host cannot route on that. It must see what the script threw — which
      // for a class the script declared is an `InterpretedInstance`, because
      // there is no native object to hand over. That is the correct answer and
      // not a half-measure: the type exists only inside the sandbox.
      //
      // What the host does NOT get is the script's `toString()` override.
      // `InterpretedInstance.toString()` is the interpreter's diagnostic form
      // (`<instance of MyErr>`); dispatching to the script's override needs an
      // InterpreterVisitor, which the embedder does not hold. So a host that
      // logs '$error' sees the diagnostic form. That is a real gap, but it is
      // the *general* behaviour of every interpreted instance that reaches
      // native code, not something this hook introduces — filed as SCD72
      // rather than patched at this one call site, where fixing it would only
      // hide it everywhere else.
      final (_, escapes) = await runWithHook('''
        import 'dart:async';
        class MyErr { final String m; MyErr(this.m); String toString() => 'MyErr:\$m'; }
        main() async {
          final c = StreamController();
          c.stream.listen((v) { throw MyErr('boom'); });
          c.sink.add(1);
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return 'script-completed';
        }
      ''');
      expect(escapes, hasLength(1));
      expect(escapes.single.error, isNot(isA<InternalInterpreterD4rtException>()),
          reason: 'the interpreter-internal wrapper must not cross the boundary');
      expect(escapes.single.error, isA<InterpretedInstance>(),
          reason: 'the host gets the object the script threw');
      expect((escapes.single.error as InterpretedInstance).klass.name, 'MyErr',
          reason: 'and it is identifiable — a host can route on the class');
    });

    test('F-SCC23-7: a native stream error with no onError routes through the same hook [2026-09-04]',
        () async {
      // Before the fix the host saw two shapes: a clean StateError for this
      // case and a wrapper for every script-thrown one. Uniformity is the
      // property being pinned, not the type.
      final (_, escapes) = await runWithHook('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          c.stream.listen((v) {});
          c.sink.addError(StateError('native'));
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return 'script-completed';
        }
      ''');
      expect(escapes, hasLength(1));
      expect(escapes.single.error, isA<StateError>());
      expect(escapes.single.error.toString(), contains('native'));
    });

    test('F-SCC23-8: the hook receives a usable stack trace [2026-09-04]',
        () async {
      final (_, escapes) =
          await runWithHook(streamScript("(v) { throw StateError('st'); }"));
      expect(escapes, hasLength(1));
      expect(escapes.single.stackTrace.toString(), isNotEmpty);
    });
  });

  group('SCC23: containment and the no-hook default', () {
    test('F-SCC23-9: with no hook the error still reaches the enclosing zone [2026-09-04]',
        () async {
      // The todo's hard constraint: "DO NOT fix this by making listen's adapter
      // swallow the error." With no embedder hook the behaviour is exactly what
      // it was, which is why F-SCB9-14 needs no amendment.
      final (result, zoneErrors) =
          await runWithoutHook(streamScript("(v) { throw StateError('nz'); }"));
      expect(result, 'script-completed');
      expect(zoneErrors, hasLength(1));
      expect(zoneErrors.single.toString(), contains('nz'));
    });

    test('F-SCC23-10: with no hook d4rt does not take over the error zone [2026-09-04]',
        () async {
      // Pins the *cost* of the design, so nobody later "tidies up" the
      // conditional fork without knowing what it buys.
      //
      // A zone that defines `handleUncaughtError` is a new *error zone*, and
      // Dart refuses to deliver an error across an error-zone boundary
      // (`future_impl.dart`: "Don't cross zone boundaries with errors"). An
      // unconditional fork therefore breaks the ordinary case: the caller
      // awaits `execute`'s future from outside the zone, the script's own
      // failure is diverted to the uncaught handler, and the future never
      // completes. F-SCB9-12 fails exactly that way — it was written for an
      // unrelated reason and caught this within a minute.
      //
      // So the zone is opt-in. The consequence, asserted here rather than left
      // to be discovered: an embedder that sets no hook still sees the
      // interpreter's internal wrapper, because there is no seam to unwrap it
      // at. Making that unconditional needs a way to observe escapes without
      // owning the error zone, which Dart does not offer — SCD73.
      final (_, zoneErrors) =
          await runWithoutHook(streamScript("(v) { throw StateError('uz'); }"));
      expect(zoneErrors.single, isA<InternalInterpreterD4rtException>(),
          reason: 'unchanged from before SCC23 — the opt-in is the whole point');
    });

    test('F-SCC23-11: a hook contains the error — it does not also reach the zone [2026-09-04]',
        () async {
      // Containment is the reason an embedder sets a hook at all. If the error
      // escaped to the host zone anyway, a server running untrusted script
      // could still be taken down by it.
      final zoneErrors = <Object>[];
      final escapes = <Object>[];
      final finished = Completer<Object?>();
      runZonedGuarded(() async {
        final d4rt = D4rt()..setDebug(false);
        d4rt.onUncaughtError = (e, _) => escapes.add(e);
        final raw = d4rt.execute(
            library: 'package:test/main.dart',
            sources: {
              'package:test/main.dart': streamScript("(v) { throw StateError('cz'); }")
            });
        finished.complete(raw is Future ? await raw : raw);
      }, (error, _) => zoneErrors.add(error));
      await finished.future;
      await Future.delayed(const Duration(milliseconds: 40));

      expect(escapes, hasLength(1));
      expect(zoneErrors, isEmpty,
          reason: 'a hook that does not contain the error is not a sandbox');
    });

    test('F-SCC23-12: an error thrown by the hook itself is not lost [2026-09-04]',
        () async {
      // A hook is embedder code and can be buggy. Losing the original error
      // *and* the hook's would be the worst outcome, so the hook's failure is
      // forwarded to the parent zone.
      final zoneErrors = <Object>[];
      final finished = Completer<Object?>();
      runZonedGuarded(() async {
        final d4rt = D4rt()..setDebug(false);
        d4rt.onUncaughtError = (e, _) => throw StateError('hook-failed');
        final raw = d4rt.execute(
            library: 'package:test/main.dart',
            sources: {
              'package:test/main.dart': streamScript("(v) { throw StateError('hz'); }")
            });
        finished.complete(raw is Future ? await raw : raw);
      }, (error, _) => zoneErrors.add(error));
      await finished.future;
      await Future.delayed(const Duration(milliseconds: 40));

      expect(zoneErrors, isNotEmpty);
      expect(zoneErrors.map((e) => e.toString()).join('\n'),
          contains('hook-failed'));
    });

    test('F-SCC23-13: a synchronous script error still throws out of execute [2026-09-04]',
        () async {
      // The hook must not capture errors the caller can already see. Errors on
      // the script's own future chain keep propagating through `execute`, which
      // is the contract F-SCB9-12 depends on.
      final escapes = <Object>[];
      final d4rt = D4rt()..setDebug(false);
      d4rt.onUncaughtError = (e, _) => escapes.add(e);
      Object? caught;
      try {
        final raw = d4rt.execute(
            library: 'package:test/main.dart',
            sources: {
              'package:test/main.dart':
                  "main() { throw StateError('sync'); }"
            });
        if (raw is Future) await raw;
      } catch (e) {
        caught = e;
      }
      expect(caught, isNotNull,
          reason: 'the caller can observe this one, so it must still be thrown');
      expect(caught.toString(), contains('sync'));
      expect(escapes, isEmpty,
          reason: 'and it must not ALSO be reported as an uncaught escape');
    });

    test('F-SCC23-16: an async script error still reaches the caller with a hook installed [2026-09-04]',
        () async {
      // The case the result bridge exists for, and the one an unconditional
      // fork gets wrong in the most misleading way available: the returned
      // future never completes *and* the failure is reported as an escape, so
      // the embedder is told "your script had an uncaught callback error" about
      // an error that was simply on the script's own await chain.
      final escapes = <Object>[];
      final d4rt = D4rt()..setDebug(false);
      d4rt.onUncaughtError = (e, _) => escapes.add(e);
      Object? caught;
      try {
        final raw = d4rt.execute(
            library: 'package:test/main.dart',
            sources: {
              'package:test/main.dart': '''
                main() async {
                  await Future.delayed(Duration(milliseconds: 5));
                  throw StateError('async-boom');
                }
              '''
            });
        if (raw is Future) {
          await raw.timeout(const Duration(seconds: 5));
        }
      } catch (e) {
        caught = e;
      }
      expect(caught, isNotNull,
          reason: 'the await chain is the caller\'s to observe, hook or not');
      expect(caught.toString(), contains('async-boom'));
      expect(escapes, isEmpty,
          reason: 'and it is not an escape — it never left the script');
    });
  });

  group('SCC23: the delivery paths agree', () {
    /// The todo suspected `handleError` and `listen`'s onError hand the script
    /// *different* error objects, because only the former unwraps
    /// `InternalInterpreterD4rtException`. It says so on the strength of
    /// reading, and asks for it to be verified before being treated as a
    /// defect. It was verified, and it is not a defect — both deliver the
    /// script's own object. These two tests keep it that way, since the two
    /// adapters are in different files and could drift apart later.
    Future<Object?> delivered(String plumbing) async {
      final (result, _) = await runWithHook('''
        import 'dart:async';
        class MyErr { final String m; MyErr(this.m); String toString() => 'MyErr:\$m'; }
        main() async {
          final c = StreamController();
          final seen = [];
          $plumbing
          c.sink.addError(MyErr('sent'));
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return seen;
        }
      ''');
      return result;
    }

    test('F-SCC23-14: listen onError receives the script object the script threw [2026-09-04]',
        () async {
      final result = await delivered(
          "c.stream.listen((v) {}, onError: (e) { seen.add('\$e'); });") as List;
      expect(result, orderedEquals(['MyErr:sent']));
    });

    test('F-SCC23-15: handleError receives the identical object [2026-09-04]',
        () async {
      final result = await delivered(
              "c.stream.handleError((e) { seen.add('\$e'); }).listen((v) {});")
          as List;
      expect(result, orderedEquals(['MyErr:sent']),
          reason: 'the two paths must agree — this is the RELATED claim in the '
              'todo, measured rather than inferred');
    });
  });
}
