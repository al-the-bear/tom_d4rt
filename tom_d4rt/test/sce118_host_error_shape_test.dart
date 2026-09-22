// SCE118 — every host boundary hands over the same shape for the same script
// failure.
//
// THE TODO'S HEADLINE WAS ALREADY CLOSED, by SCD96: `throw StateError('x')` out
// of `execute()` reached the caller as a `BridgedInstance<Object>` whose
// `toString()` read `Bad state: x`, so every message-based assertion looked
// right and `on StateError` never matched. `throwAsHostFacingError` does both
// peels now and its doc records that exact symptom. Measured at 1.164.0 before
// anything was changed: `execute`, `eval`, the `onUncaughtError` hook and an
// embedder's own zone all hand over a real `StateError`.
//
// WHAT WAS STILL OPEN was the todo's own closing instruction — "worth asserting
// in the same commit: that all delivery paths hand over the IDENTICAL shape for
// the same script failure … no test currently states it". Stating it found a
// live divergence the todo did not name.
//
// `invoke()` IS THE FOURTH BOUNDARY AND WAS THE LAST ONE DECIDING FOR ITSELF.
// It goes through `_tryFunction`, whose catch peeled the interpreted-`throw`
// carrier by hand and stringified everything else into `"$error : $e"`. So a
// script method that hit an ordinary interpreter fault — `null.foo()` — handed
// the host a **String** reading
//
//     Error invoking interpreted Method or getter 'boom' on 'App' : Runtime …
//
// where `execute` and `eval` hand over a `RuntimeD4rtException`. Nothing could
// be caught by type, and nothing said so.
//
// FOUR HAND-ROLLED PEELS BECAME ONE SEAM. Two `eval` sites in this tree still
// carried their own, including a `RuntimeD4rtException` branch the todo's notes
// asked to measure before deleting: measured, its two arms are the same throw
// with different static types, so it bought nothing. `tom_d4rt_exec` had
// already converged its `eval` pair at SCD101 — the divergence ran the OTHER
// way from the one the todo recorded — and both trees' `_tryFunction` was still
// raw.
//
// ABLATED 2026-09-22, two ways:
//
//   | Reverted                        | Fails        |
//   | ------------------------------- | ------------ |
//   | `_tryFunction`'s own catch      | -2, -3       |
//   | the two `eval` peels            | NOTHING      |
//
// -1 and -4 pass under both, which is the point: -1 covers the three
// boundaries that were already converged, so it is the control that would have
// caught this change breaking them, and -4 is the DONE-WHEN clause about a
// script-declared class, which no peel should touch.
//
// THE SECOND ROW IS RECORDED RATHER THAN HIDDEN. Converging the `eval` pair
// changes no behaviour — that is what "the `RuntimeD4rtException` branch bought
// nothing" means, measured rather than argued, and it is why the notes asked
// for the measurement before the deletion. It is still worth doing: four
// hand-rolled copies of a two-level peel are four places for the next
// correction to miss, which is exactly how `eval` came to differ from the
// shared helper by one level in the first place (SCD96).
//
// THERE IS NO ANALYZER-FREE TWIN, and that is measured, not skipped.
// `tom_d4rt_ast`'s `D4rtRunner` has no `invoke` and no `_tryFunction` at all,
// and its only remaining `originalThrownValue` read is inside
// `unwrapScriptError` itself. Every boundary it has was already on the shared
// seam, so the mirror rule has nothing to carry across.

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A script declaring `App` with one failing method per shape, plus top-level
/// twins so the same failure can be reached from every boundary.
const _script = '''
  class MyErr { final String m; MyErr(this.m); String toString() => 'MyErr: ' + m; }
  class App {
    state() { throw StateError('x'); }
    format() { throw FormatException('x'); }
    scriptClass() { throw MyErr('x'); }
    plain() { throw 'x'; }
    fault() { var n = null; return n.foo(); }
  }
  main() => App();
''';

/// How a thrown value presents to a host: its type and what it prints.
///
/// Both, because the defect this file is about was invisible to the second
/// alone — a `BridgedInstance` wrapping a `StateError` prints `Bad state: x`.
(String, String) shapeOf(Object error) =>
    (error.runtimeType.toString(), '$error');

/// What escapes [body], as a [shapeOf] pair.
(String, String) caught(Object? Function() body) {
  try {
    body();
  } catch (e) {
    return shapeOf(e);
  }
  return ('<no throw>', '<no throw>');
}

D4rt _prepared({void Function(Object, StackTrace)? onUncaughtError}) {
  final d4rt = D4rt()..setDebug(false);
  if (onUncaughtError != null) d4rt.onUncaughtError = onUncaughtError;
  d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': _script},
  );
  return d4rt;
}

/// The shape each caller-facing boundary hands over for `App.<member>()`.
Map<String, (String, String)> boundaryShapes(String member) {
  final viaExecute = caught(() {
    final d4rt = D4rt()..setDebug(false);
    return d4rt.execute(
      library: 'package:test/main.dart',
      sources: {
        'package:test/main.dart': '$_script\nfail() { App().$member(); }',
      },
      name: 'fail',
    );
  });
  final viaEval = caught(() => _prepared().eval('App().$member()'));
  final viaInvoke = caught(() => _prepared().invoke(member, const []));
  return {'execute': viaExecute, 'eval': viaEval, 'invoke': viaInvoke};
}

void main() {
  group('SCE118: the host boundaries agree', () {
    test('F-SCE118-1 (control): the three already-converged shapes '
        '[2026-09-22] (PASS)', () {
      // `execute`, `eval` and `invoke` over the shapes SCD96 fixed. This is
      // the control for the change: it was green before it and has to stay
      // green after, because converging `_tryFunction` could have moved the
      // two boundaries that were already right.
      for (final member in ['state', 'format', 'plain']) {
        final shapes = boundaryShapes(member);
        expect(
          shapes.values.toSet(),
          hasLength(1),
          reason: 'the boundaries disagree for $member: $shapes',
        );
      }
      // And they are the SDK types, not a wrapper that prints like one — the
      // property `toString()` alone cannot see.
      expect(boundaryShapes('state')['execute']!.$1, 'StateError');
      expect(boundaryShapes('format')['execute']!.$1, 'FormatException');
      expect(boundaryShapes('plain')['execute']!.$1, 'String');
    });

    test('F-SCE118-2: an interpreter fault reaches every boundary as itself '
        '[2026-09-22] (PASS)', () {
      // The divergence stating the property found. `invoke` handed the host a
      // String built from `"$error : $e"`; the other two hand over a
      // `RuntimeD4rtException`.
      final shapes = boundaryShapes('fault');
      expect(
        shapes.values.toSet(),
        hasLength(1),
        reason: 'the boundaries disagree for an interpreter fault: $shapes',
      );
      expect(shapes['invoke']!.$1, 'RuntimeD4rtException');
      // Catchable by type from the host, which is the whole point of the
      // shape agreeing.
      expect(
        () => _prepared().invoke('fault', const []),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCE118-3: invoke no longer stringifies what it cannot classify '
        '[2026-09-22] (PASS)', () {
      // Pins the OLD shape as gone rather than only the new one as present:
      // a String carrying the method and class names is what a host used to
      // receive, and a later change that restores the hand-rolled catch would
      // pass F-SCE118-2's `hasLength(1)` if it broke all three boundaries the
      // same way.
      final (type, _) = caught(() => _prepared().invoke('fault', const []));
      expect(type, isNot('String'));
      expect(
        caught(() => _prepared().invoke('fault', const [])).$2,
        isNot(contains('Error invoking interpreted')),
      );
    });

    test('F-SCE118-4 (control): a script-declared class is untouched '
        '[2026-09-22] (PASS)', () {
      // The DONE-WHEN clause. No peel applies to an `InterpretedInstance` —
      // it is the value the script threw — and it renders its own `toString`
      // since SCD72, which is what makes it useful to a host that logs it.
      final shapes = boundaryShapes('scriptClass');
      expect(shapes.values.toSet(), hasLength(1), reason: '$shapes');
      expect(shapes['invoke']!.$1, 'InterpretedInstance');
      expect(shapes['invoke']!.$2, 'MyErr: x');
    });

    test('F-SCE118-5: the two ESCAPE paths agree with each other and with the '
        'caller-facing shape [2026-09-22] (PASS)', () async {
      // An error that escapes asynchronously reaches a host by one of two
      // routes — the hook, or the embedder's own zone when no hook is set.
      // SCD73 and SCD96 made each right on its own; nothing stated that they
      // and `execute` agree, which is the property a host actually relies on.
      const escaping = '''
        import 'dart:async';
        main() async {
          Future.value(1).then((v) { throw StateError('x'); });
          await Future.delayed(Duration(milliseconds: 20));
          return 'done';
        }
      ''';

      final hookSaw = <Object>[];
      final hooked = D4rt()..setDebug(false);
      hooked.onUncaughtError = (e, _) => hookSaw.add(e);
      await (hooked.execute(
            library: 'package:test/main.dart',
            sources: {'package:test/main.dart': escaping},
          )
          as Future);
      await Future<void>.delayed(const Duration(milliseconds: 40));

      final zoneSaw = <Object>[];
      final finished = Completer<void>();
      runZonedGuarded(() async {
        final d4rt = D4rt()..setDebug(false);
        await (d4rt.execute(
              library: 'package:test/main.dart',
              sources: {'package:test/main.dart': escaping},
            )
            as Future);
        finished.complete();
      }, (error, _) => zoneSaw.add(error));
      await finished.future;
      await Future<void>.delayed(const Duration(milliseconds: 40));

      expect(shapeOf(hookSaw.single), shapeOf(zoneSaw.single));
      expect(
        shapeOf(hookSaw.single),
        boundaryShapes('state')['execute'],
        reason:
            'the same `throw StateError` must not depend on which of the five '
            'routes carried it to the host',
      );
    });
  });
}
