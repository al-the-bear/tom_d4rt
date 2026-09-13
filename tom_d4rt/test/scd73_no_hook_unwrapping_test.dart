/// SCD73 — what a no-hook embedder receives when a script error escapes.
///
/// ## The claim this file overturns
///
/// SCD73 was filed stating that unconditional unwrapping was **unavailable**:
/// "unwrapping requires intercepting the error, and the only interception point
/// Dart offers is `ZoneSpecification.handleUncaughtError` — which makes the zone
/// a new ERROR zone". The first half is true. The second is false, and the
/// distinction is the whole fix: an escaping error has to be *observed*, but a
/// callback can be observed **at registration** rather than by handling what it
/// throws. A zone that specifies only the `register*Callback` hooks is not an
/// error zone — `Zone.errorZone` still resolves to the parent's — so those
/// hooks cost nothing in error routing and can be installed always.
///
/// Measured before anything was written, on a fork specifying only the three
/// register hooks: `identical(z.errorZone, root.errorZone)` was `true`, and an
/// ordinary future error still crossed to an awaiter outside the zone. That is
/// exactly the property F-SCB9-12 failed on when the *error-zone* half was made
/// unconditional, so the two halves are now separate: the fork is
/// unconditional, the error-zone ownership stays opt-in.
///
/// ## Coverage, and the two seams it needed
///
/// What the register hooks actually buy was measured by reverting them, not
/// inferred: escapes where an interpreted callback **throws** out of a
/// zone-registered callback — `Stream.listen`'s handlers, and a `Future.then`
/// continuation.
///
/// Two shapes were already arriving unwrapped at HEAD and are rails here rather
/// than wins: an unawaited async function body, and an unawaited
/// `Future.error`. The interpreter's own async machinery sheds the wrapper when
/// it completes a future with an error, so those never needed a zone seam.
/// F-SCD73-3 pins one of them, because nothing else does.
///
/// A `Timer` body needed a second seam, and finding that out took a failing
/// test rather than a probe: a synthetic `Timer(d, () => throw ...)` *is*
/// wrapped at registration, but d4rt's own adapter is
/// `() async { callback.call(...); await _yieldEventLoop(); }`, so the throw
/// never escapes the registered callback — it completes the adapter's own
/// future, which nothing holds. `Zone.errorCallback` was tried and is not
/// consulted for an `async` body's completion. So the three `Timer` adapters
/// (`Timer`, `Timer.periodic`, `Timer.run`) shed the wrapper themselves. That
/// set is bounded and was counted, not guessed: five stdlib adapters invoke a
/// `Callable` inside a native `async` closure, and the other two
/// (`Future.doWhile`, the `HttpClient` handler adapter) hand their future to
/// someone who can hold it, so unwrapping there could change what an
/// interpreted `catch` receives.
///
/// One shape stays wrapped: `Stream.handleError`'s handler, which the SDK
/// invokes with no zone registration at all — wrapping `runUnary` and
/// `runBinary` too was tried and changed nothing except double-wrapping the
/// stream case. F-SCD73-5 pins that residue rather than leaving it to be
/// discovered, and names the remedy.
///
/// ## Why the transform is the FULL unwrap and not just the wrapper
///
/// The register hooks fire on every callback registered while a script is
/// executing — including callbacks belonging to native code a bridge called —
/// so the first draft shed only `InternalInterpreterD4rtException` and left a
/// bare `BridgedInstance` alone, on the theory that reducing it to its native
/// object was wrong for a value still travelling through interpreted frames.
/// **That theory was measured and was unfounded.** A `Future.then` callback
/// that throws is the one registered-callback escape an interpreted `catch` can
/// still receive; twelve in-script cases — `catch`, `on`-clause matching on
/// both native and script-declared types, `e.message` member access, `rethrow`,
/// and in-callback `try`/`catch` inside timers and stream handlers — were
/// recorded before the change and were byte-identical after it, under the shed
/// AND under the full unwrap. Shedding only the wrapper would have handed the
/// zone a `BridgedInstance` where the hook path hands it a `StateError`, which
/// is the two-shapes defect `unwrapScriptError` exists to prevent.
///
/// ## Control
///
/// Three edits, each reverted on its own and the failures recorded. Dropping
/// the `register*Callback` half of `_scriptZoneSpecification` fails F-SCD73-1
/// and -4; restoring the `if (onUncaughtError == null) return run();` early
/// return in `_executeInEnvironment` fails the same two; removing the
/// `try`/`catch` from the three `Timer` adapters fails F-SCD73-2 alone. So the
/// two halves of the zone change are not independently testable from here —
/// they buy the same two cases, because either one alone leaves no seam.
///
/// F-SCD73-3 and -5..8 are rails: they hold before and after. They exist so
/// that a later change which buys the unwrapping by taking over the error zone,
/// by isolating the script's zone, by regressing the async machinery's own
/// unwrapping, or by breaking `unwrapScriptError`'s pass-through fails here
/// instead of in an embedder.
library;

import 'dart:async';

import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

/// Runs [source] with **no** hook inside the embedder's own guarded zone — the
/// configuration this whole file is about — and reports what the zone caught.
Future<(Object? result, List<Object> zoneErrors)> noHook(
  String source, {
  Duration settle = const Duration(milliseconds: 60),
}) async {
  final zoneErrors = <Object>[];
  final finished = Completer<Object?>();
  runZonedGuarded(() async {
    final d4rt = D4rt()..setDebug(false);
    final raw = d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': source},
    );
    finished.complete(raw is Future ? await raw : raw);
  }, (error, _) => zoneErrors.add(error));
  final result = await finished.future;
  await Future.delayed(settle);
  return (result, zoneErrors);
}

void main() {
  group('SCD73: the wrapper no longer reaches a no-hook embedder', () {
    test(
      'F-SCD73-1: a stream handler that throws arrives as the script threw it '
      '[2026-09-13]',
      () async {
        final (result, zoneErrors) = await noHook('''
          import 'dart:async';
          main() async {
            final c = StreamController();
            c.stream.listen((v) { throw StateError('od'); });
            c.sink.add(1);
            await Future.delayed(Duration(milliseconds: 10));
            return 'script-completed';
          }
        ''');

        expect(result, 'script-completed');
        expect(
          zoneErrors.single,
          isA<StateError>(),
          reason:
              'the hook path already delivered a StateError here; the zone '
              'path now agrees, which is the entire point of SCD73',
        );
        expect(
          zoneErrors.single,
          isNot(isA<InternalInterpreterD4rtException>()),
          reason: 'the interpreter-internal wrapper is what SCD73 reported',
        );
        expect(
          zoneErrors.single,
          isNot(isA<BridgedInstance>()),
          reason:
              'BridgedInstance is interpreter-internal too — a host cannot '
              '`catch` on it, so stopping one peel short fixes nothing',
        );
        expect((zoneErrors.single as StateError).message, 'od');
      },
    );

    test(
      'F-SCD73-2: a Timer body that throws arrives unwrapped [2026-09-13]',
      () async {
        // The one case the zone seam does NOT buy, and the only test here that
        // the `Timer` adapters' own `try`/`catch` is load-bearing for. It
        // failed first, which is how the adapter's `async` wrapper was found:
        // a timer body's throw completes that wrapper's unheld future instead
        // of escaping the callback the zone registered.
        final (_, zoneErrors) = await noHook('''
          import 'dart:async';
          main() async {
            Timer(Duration.zero, () { throw StateError('tb'); });
            await Future.delayed(Duration(milliseconds: 30));
            return 'script-completed';
          }
        ''');

        expect(zoneErrors.single, isA<StateError>());
        expect((zoneErrors.single as StateError).message, 'tb');
      },
    );

    test('F-SCD73-3: an unawaited async body that throws arrives unwrapped '
        '[2026-09-13]', () async {
      // Recorded because it was the shape predicted to be UNREACHABLE: an
      // error abandoned in a future nobody awaits is reported by Dart
      // through the error zone, not thrown at a callback. It arrives
      // unwrapped anyway, because the interpreter drives an async body's
      // state machine through continuations it registers in this zone — so
      // the throw does come out of a registered callback. If a future
      // rewrite of the async machinery stops using zone-registered
      // continuations, this is the test that will say so.
      final (_, zoneErrors) = await noHook('''
          main() async {
            f() async {
              await Future.delayed(Duration(milliseconds: 5));
              throw StateError('ua');
            }
            f();
            await Future.delayed(Duration(milliseconds: 40));
            return 'script-completed';
          }
        ''');

      expect(zoneErrors.single, isA<StateError>());
      expect((zoneErrors.single as StateError).message, 'ua');
    });

    test('F-SCD73-4: a script-declared exception class arrives as itself and '
        'renders its own toString [2026-09-13]', () async {
      // The two halves of the boundary meet here. SCD73 gets the value out
      // without the wrapper; SCD72 makes `'$e'` on that value reach the
      // script's own `toString`. Either one alone still logs uselessly.
      final (_, zoneErrors) = await noHook('''
          import 'dart:async';
          class MyErr { final String m; MyErr(this.m); String toString() => 'MyErr: \$m'; }
          main() async {
            final c = StreamController();
            c.stream.listen((v) { throw MyErr('boom'); });
            c.sink.add(1);
            await Future.delayed(Duration(milliseconds: 10));
            return 'script-completed';
          }
        ''');

      final escaped = zoneErrors.single;
      expect(escaped, isNot(isA<InternalInterpreterD4rtException>()));
      expect(
        '$escaped',
        'MyErr: boom',
        reason: 'the first thing embedder code does with an error is log it',
      );
    });

    test('F-SCD73-5: the one residue — a handleError handler still arrives '
        'wrapped, and unwrapScriptError is the remedy [2026-09-13]', () async {
      // Pins the LIMIT of the mechanism so nobody reads the four tests above
      // as "d4rt always unwraps" and drops the defensive call. The SDK
      // invokes a `handleError` handler without registering it with the
      // zone, so there is no seam to wrap; reaching it needs either the
      // error zone (which would break F-SCB9-12) or a guard inside the
      // `handleError` adapter itself, which is the per-adapter answer SCC23
      // rejected on purpose. Tracked as sce117_aiml.
      final (_, zoneErrors) = await noHook('''
          import 'dart:async';
          main() async {
            final c = StreamController();
            c.stream.handleError((e) { throw StateError('he'); }).listen((_) {});
            c.addError(ArgumentError('orig'));
            await Future.delayed(Duration(milliseconds: 30));
            return 'script-completed';
          }
        ''');

      expect(
        zoneErrors.single,
        isA<InternalInterpreterD4rtException>(),
        reason:
            'unchanged, and documented on unwrapScriptError rather than '
            'left for an embedder to hit',
      );
      expect(
        unwrapScriptError(zoneErrors.single),
        isA<StateError>(),
        reason: 'the documented one-line remedy has to actually work',
      );
      expect(
        (unwrapScriptError(zoneErrors.single) as StateError).message,
        'he',
      );
    });

    test('F-SCD73-6: forking always did not make d4rt the error zone '
        '[2026-09-13]', () async {
      // The failure mode this guards is not hypothetical: F-SCB9-12 caught
      // it when the error-zone half was made unconditional during SCC23. An
      // awaiting caller registered its listener outside the zone, Dart
      // refused to carry the error across the boundary, and the returned
      // future never completed — a hang, not a failure. Asserted here as
      // well as there, because the fork is now unconditional and this file
      // is what made it so.
      final d4rt = D4rt()..setDebug(false);
      expect(
        () => d4rt.execute(
          library: 'package:test/main.dart',
          sources: {
            'package:test/main.dart': "main() { throw StateError('s'); }",
          },
        ),
        throwsA(anything),
        reason: 'a synchronous script failure still belongs to the caller',
      );

      final async = D4rt()..setDebug(false);
      final raw = async.execute(
        library: 'package:test/main.dart',
        sources: {
          'package:test/main.dart':
              "main() async { await Future.delayed(Duration(milliseconds: 5));"
              " throw StateError('a'); }",
        },
      );
      await expectLater(
        raw as Future,
        throwsA(anything),
        reason:
            'an async script failure reaches the awaiting caller, rather '
            'than being diverted to an uncaught handler and hanging',
      );
    });

    test('F-SCD73-7: the fork delegates everything it does not specify '
        '[2026-09-13]', () {
      // A fork that isolated the script would break far more than errors,
      // and silently. `print` is the cheapest observable proof that the
      // embedder's own zone is still in the chain.
      final captured = <String>[];
      final result = runZoned(
        () => (D4rt()..setDebug(false)).execute(
          library: 'package:test/main.dart',
          sources: {
            'package:test/main.dart':
                "main() { print('from script'); return 3; }",
          },
        ),
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) => captured.add(line),
        ),
      );

      expect(result, 3);
      expect(captured, ['from script']);
    });

    test('F-SCD73-8: unwrapScriptError passes non-interpreter values through '
        'untouched and is idempotent [2026-09-13]', () {
      // It runs on every callback registered while a script executes,
      // including callbacks belonging to native code a bridge called, so
      // "leaves everything else alone" is a safety property and not a
      // nicety.
      final native = StateError('native');
      expect(identical(unwrapScriptError(native), native), isTrue);
      expect(unwrapScriptError('a string'), 'a string');

      final wrapped = InternalInterpreterD4rtException(native);
      final once = unwrapScriptError(wrapped);
      expect(identical(once, native), isTrue);
      expect(
        identical(unwrapScriptError(once), native),
        isTrue,
        reason:
            'the zone seam and the hook both apply it, so an error that '
            'escapes through a registered callback is unwrapped twice',
      );
    });
  });
}
