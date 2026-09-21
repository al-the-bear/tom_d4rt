// SCE67: a missing member is one failure, and a script catches it one way.
//
// Measured 2026-09-12 while pinning the members scd24 removed: asking a
// receiver for something it does not have reported TWO ways, decided by the
// member KIND rather than by anything a script can see.
//
//   InternetAddressType.IPv4.host     -> UndefinedMemberD4rtException
//   InternetAddressType.IPv4.lookup() -> D4rtNoSuchMethodError
//
// Only the second `implements NoSuchMethodError`, so
// `try { ... } on NoSuchMethodError catch (_)` handled the method half of the
// same failure and missed the getter half. F-SCC8-5's reasoning — "a missing
// member is the same failure real Dart reports at runtime, and asserting the
// SDK supertype means a script can catch it the way it would catch the real
// one" — does not stop applying at getters.
//
// WHY THESE CASES AND NOT EVERY ABSENCE. Measured across the seven ways the
// interpreter reports one, five were uncatchable as `NoSuchMethodError`. The
// line drawn here is not "make them all catchable", it is what real Dart does:
//
//   * INSTANCE member absence is a runtime `NoSuchMethodError` in Dart when the
//     receiver is dynamic, and d4rt receivers are effectively dynamic. Those
//     are the cases below, bridged and interpreted alike.
//   * STATIC member absence (`Klass.missing`) and a bare undefined NAME are
//     COMPILE errors in Dart. There is no runtime error for a script to catch,
//     so giving them the supertype would make d4rt strictly MORE catchable
//     than the platform — the mistake `D4rtRangeError` records for
//     `IndexError`, and the reason scc31 keeps the undefined-name case
//     deliberately uncatchable. F-SCE67-3 pins that they stay out.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String body) =>
    (D4rt()..grant(FilesystemPermission.any)).execute(source: body);

void main() {
  group('SCE67: a missing member reports one way', () {
    test('F-SCE67-1: a missing GETTER and a missing METHOD are both '
        'NoSuchMethodError [2026-09-21]', () {
      // Bridged and interpreted receivers, getter and method each. Before the
      // fix the two getter rows threw something a script could not name.
      for (final expression in const [
        "'abc'.noSuchGetterHere",
        "'abc'.noSuchMethodHere()",
        'A().noSuchGetterHere',
        'A().noSuchMethodHere()',
      ]) {
        expect(
          () => run('class A {}\nmain() => $expression;'),
          throwsA(isA<NoSuchMethodError>()),
          reason: expression,
        );
      }
    });

    test('F-SCE67-2: a script catches both halves with one clause '
        '[2026-09-21]', () {
      // The case that motivated this: what the SCRIPT can do, not what the
      // host sees. A host-side `isA<NoSuchMethodError>` would pass on a type
      // the interpreter never lets a catch clause match.
      for (final expression in const [
        "'abc'.noSuchGetterHere",
        "'abc'.noSuchMethodHere()",
      ]) {
        expect(
          run(
            'main() { try { $expression; return "not thrown"; } '
            'on NoSuchMethodError catch (_) { return "caught"; } '
            'catch (e) { return "escaped"; } }',
          ),
          'caught',
          reason: expression,
        );
      }
    });

    test('F-SCE67-3 (control): static absence and undefined names stay OUT '
        '[2026-09-21]', () {
      // Real Dart rejects both at compile time, so there is no runtime
      // NoSuchMethodError to model. This case is what stops the fix being
      // widened into "every absence is catchable", which would make d4rt more
      // catchable than the platform.
      expect(
        () => run('main() => int.noSuchStaticHere;'),
        throwsA(isNot(isA<NoSuchMethodError>())),
        reason: 'static member absence',
      );
      expect(
        () => run('main() => totallyUnknownNameHere;'),
        throwsA(isNot(isA<NoSuchMethodError>())),
        reason: 'undefined name — scc31 keeps this deliberately uncatchable',
      );
    });

    test('F-SCE67-4: the supertype was added, not swapped [2026-09-21]', () {
      // Every internal extension-lookup decision tests
      // `is UndefinedMemberD4rtException`, and `on RuntimeD4rtException`
      // clauses exist in both trees. Swapping the hierarchy instead of adding
      // to it would have broken both silently.
      expect(
        () => run("main() => 'abc'.noSuchGetterHere;"),
        throwsA(
          allOf(
            isA<NoSuchMethodError>(),
            isA<RuntimeD4rtException>(),
            isA<UndefinedMemberD4rtException>().having(
              (e) => e.memberName,
              'memberName',
              'noSuchGetterHere',
            ),
          ),
        ),
      );
    });
  });
}
