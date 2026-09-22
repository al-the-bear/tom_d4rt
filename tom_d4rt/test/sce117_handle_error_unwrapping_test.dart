// SCE117 — the last escape route that handed an embedder the interpreter's
// internal wrapper.
//
// SCD73 made the unwrapping unconditional for every callback the zone REGISTERS
// and pinned the one shape it could not reach: a handler passed to
// `Stream.handleError`. The SDK invokes that handler with no zone registration
// at all, so there is no `register*Callback` seam to wrap — adding `runUnary`
// and `runBinary` to the specification was tried and changed nothing except
// double-wrapping the `Stream.listen` case. An embedder with their own
// `runZonedGuarded` and no `onUncaughtError` therefore still received
// `InternalInterpreterD4rtException` from that one path.
//
// `Zone.errorCallback` DOES fire for it, and — this is why it is the right seam
// rather than merely an available one — IT IS NOT AN ERROR-ZONE HOOK.
// Specifying it leaves `Zone.errorZone` resolving to the parent's, so the
// property SCC23 and SCD73 both measured as ruled out for `handleUncaughtError`
// does not arise: an awaiting caller outside the zone still receives an
// ordinary script failure rather than hanging. F-SCD73-6 and F-SCB9-12 hold
// unchanged and are not re-asserted here.
//
// THE BLAST RADIUS IS THE REASON THIS FILE EXISTS. `errorCallback` is consulted
// for errors entering futures generally, not just for this one shape, so the
// question was whether an interpreted `catch` would start seeing a different
// value. SCD73's header records a twelve-case in-script matrix measured by hand
// "before the change and byte-identical after it" — and NOTHING PINNED IT. A
// measurement nobody can re-run is a claim, so the matrix is a standing test
// now: F-SCE117-2 below, thirteen rows, each asserted to the value measured
// with the seam absent.
//
// ABLATED 2026-09-22 by removing `errorCallback` from `_scriptZoneSpecification`:
// F-SCE117-1 fails and F-SCE117-2 and -3 pass. That split is the point —
// -2 is the control that would have caught a regression in what a script sees,
// and it is insensitive to the fix BY MEASUREMENT rather than by assertion.

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [source] with **no** hook inside the embedder's own guarded zone and
/// reports what that zone caught — the configuration SCD73 is about.
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

/// Runs [source] to completion and returns what it produced, or a description
/// of what escaped. Used by the in-script matrix, where the question is always
/// what the SCRIPT saw.
Future<Object?> scriptResult(String source) async {
  final d4rt = D4rt()..setDebug(false);
  try {
    final raw = d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': source},
    );
    return raw is Future ? await raw : raw;
  } catch (e) {
    return 'THREW ${e.runtimeType}: $e';
  }
}

/// The in-script matrix. Every row is a shape in which an interpreted `catch`
/// or `on` clause observes an error that travelled through the async
/// machinery — which is exactly the population `errorCallback` could have
/// disturbed.
const _inScriptMatrix = <String, (String source, String expected)>{
  'then/catch': (
    '''
    main() async {
      try { await Future.error(StateError('x')).then((v) => v); }
      catch (e) { return e.runtimeType.toString() + '|' + e.toString(); }
    }''',
    'StateError|Bad state: x',
  ),
  'then/on native': (
    '''
    main() async {
      try { await Future.error(StateError('x')).then((v) => v); }
      on StateError catch (e) { return 'on-StateError|' + e.message.toString(); }
      catch (e) { return 'fellthrough|' + e.toString(); }
    }''',
    'on-StateError|x',
  ),
  'then-throws/catch': (
    '''
    main() async {
      try { await Future.value(1).then((v) { throw StateError('t'); }); }
      catch (e) { return e.runtimeType.toString() + '|' + e.toString(); }
    }''',
    'StateError|Bad state: t',
  ),
  'then-throws/on native': (
    '''
    main() async {
      try { await Future.value(1).then((v) { throw ArgumentError('t'); }); }
      on ArgumentError catch (e) { return 'on-ArgumentError|' + e.message.toString(); }
      catch (e) { return 'fellthrough|' + e.toString(); }
    }''',
    'on-ArgumentError|t',
  ),
  'script class/on': (
    '''
    class MyErr { final String m; MyErr(this.m); String toString() => 'MyErr: ' + m; }
    main() async {
      try { await Future.value(1).then((v) { throw MyErr('s'); }); }
      on MyErr catch (e) { return 'on-MyErr|' + e.m; }
      catch (e) { return 'fellthrough|' + e.toString(); }
    }''',
    'on-MyErr|s',
  ),
  'script class/catch + toString': (
    '''
    class MyErr { final String m; MyErr(this.m); String toString() => 'MyErr: ' + m; }
    main() async {
      try { await Future.value(1).then((v) { throw MyErr('s'); }); }
      catch (e) { return 'caught|' + e.toString(); }
    }''',
    'caught|MyErr: s',
  ),
  'rethrow': (
    '''
    main() async {
      try {
        try { await Future.value(1).then((v) { throw StateError('r'); }); }
        catch (e) { rethrow; }
      } catch (e) { return 'outer|' + e.runtimeType.toString() + '|' + e.toString(); }
    }''',
    'outer|StateError|Bad state: r',
  ),
  'try/catch inside a Timer body': (
    '''
    import 'dart:async';
    main() async {
      var seen = '';
      Timer(Duration(milliseconds: 1), () {
        try { throw StateError('tm'); } catch (e) { seen = 'timer|' + e.toString(); }
      });
      await Future.delayed(Duration(milliseconds: 20));
      return seen;
    }''',
    'timer|Bad state: tm',
  ),
  'try/catch inside a listen handler': (
    '''
    import 'dart:async';
    main() async {
      var seen = '';
      final c = StreamController();
      c.stream.listen((v) {
        try { throw StateError('ls'); } catch (e) { seen = 'listen|' + e.toString(); }
      });
      c.sink.add(1);
      await Future.delayed(Duration(milliseconds: 20));
      return seen;
    }''',
    'listen|Bad state: ls',
  ),
  'stream onError handler': (
    '''
    import 'dart:async';
    main() async {
      var seen = '';
      final c = StreamController();
      c.stream.listen((v) {}, onError: (e) { seen = 'onError|' + e.toString(); });
      c.addError(ArgumentError('oe'));
      await Future.delayed(Duration(milliseconds: 20));
      return seen;
    }''',
    'onError|Invalid argument(s): oe',
  ),
  'catchError': (
    '''
    main() async {
      return await Future.error(StateError('ce'))
        .catchError((e) => 'catchError|' + e.runtimeType.toString() + '|' + e.toString());
    }''',
    'catchError|StateError|Bad state: ce',
  ),
  'await-for over an erroring stream': (
    '''
    import 'dart:async';
    main() async {
      final c = StreamController();
      c.addError(StateError('af'));
      c.close();
      try { await for (final v in c.stream) { } }
      catch (e) { return 'awaitfor|' + e.runtimeType.toString() + '|' + e.toString(); }
    }''',
    'awaitfor|StateError|Bad state: af',
  ),
  'handleError handler, in-script': (
    '''
    import 'dart:async';
    main() async {
      var seen = '';
      final c = StreamController();
      c.stream.handleError((e) { seen = 'he|' + e.runtimeType.toString() + '|' + e.toString(); })
        .listen((_) {});
      c.addError(ArgumentError('orig'));
      await Future.delayed(Duration(milliseconds: 20));
      return seen;
    }''',
    'he|ArgumentError|Invalid argument(s): orig',
  ),
};

void main() {
  group('SCE117: the handleError seam', () {
    test('F-SCE117-1: a handleError handler that throws arrives unwrapped '
        '[2026-09-22] (PASS)', () async {
      // The case SCD73 pinned as its residue, inverted. `F-SCD73-5` in that
      // file now asserts the same thing from the other side.
      final (result, zoneErrors) = await noHook('''
          import 'dart:async';
          main() async {
            final c = StreamController();
            c.stream.handleError((e) { throw StateError('he'); }).listen((_) {});
            c.addError(ArgumentError('orig'));
            await Future.delayed(Duration(milliseconds: 30));
            return 'script-completed';
          }
        ''');

      expect(result, 'script-completed');
      expect(zoneErrors.single, isNot(isA<InternalInterpreterD4rtException>()));
      expect(zoneErrors.single, isA<StateError>());
      expect((zoneErrors.single as StateError).message, 'he');
      // `unwrapScriptError` remains correct on an already-unwrapped value, so
      // an embedder's defensive call is not now a bug.
      expect(unwrapScriptError(zoneErrors.single), same(zoneErrors.single));
    });

    test('F-SCE117-2 (control): the in-script matrix is unchanged '
        '[2026-09-22] (PASS)', () async {
      // Thirteen shapes in which an interpreted handler observes an error that
      // crossed the async machinery. `errorCallback` is consulted for errors
      // entering futures GENERALLY, so this is where a regression would land —
      // and every expectation here was measured with the seam ABSENT, which is
      // what makes it a control rather than a restatement of the new
      // behaviour.
      final actual = <String, Object?>{};
      for (final entry in _inScriptMatrix.entries) {
        actual[entry.key] = await scriptResult(entry.value.$1);
      }
      expect(
        actual,
        _inScriptMatrix.map((name, row) => MapEntry(name, row.$2)),
      );
    });

    test('F-SCE117-3 (control): a non-interpreter error is delegated, not '
        'rewritten [2026-09-22] (PASS)', () async {
      // The seam replaces the error only when there is a wrapper to shed;
      // otherwise it hands the decision to the parent zone. A host error
      // raised from a bridge callback must arrive as itself, with the same
      // identity — not repackaged into a fresh `AsyncError`.
      final marker = StateError('host-raised');
      final zoneErrors = <Object>[];
      final finished = Completer<void>();
      runZonedGuarded(() async {
        scheduleMicrotask(() => throw marker);
        await Future.delayed(const Duration(milliseconds: 10));
        finished.complete();
      }, (error, _) => zoneErrors.add(error));
      await finished.future;
      await Future.delayed(const Duration(milliseconds: 20));
      expect(zoneErrors.single, same(marker));
    });
  });
}
