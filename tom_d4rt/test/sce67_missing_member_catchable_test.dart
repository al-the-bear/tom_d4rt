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
//
// HOW MUCH OF THE SUITE WAS STILL PINNING THE INVENTED TYPE. Measured
// 2026-09-21 across the whole `tom_d4rt` suite: 119 assertions expect
// `RuntimeD4rtException`, spread over 38 files. Whether an assertion sits on
// an SDK-specified failure cannot be decided by reading the script — a keyword
// pass over the surrounding source proposed 16 candidates and 15 of them were
// false (`list.add(entry)` matching a fixed-length-list pattern, and so on).
// It CAN be decided mechanically, because `UndefinedMemberD4rtException` is
// the only interpreter exception carrying an SDK type: strengthen every
// assertion to `isA<UndefinedMemberD4rtException>` and run the suite, and the
// ones that still pass are exactly the ones already throwing an SDK error.
// 113 of the 119 failed — they are undefined NAMES, import/export conflicts,
// wrong arity, bridge-target mismatches, type-bound violations and permission
// denials, none of which real Dart reports at runtime at all. Of the six that
// survived, four exist to assert this hierarchy (F-SCC28-2, F-SCE67-4 and the
// two in scc28/internet_address) and one was a helper definition rather than
// a case. The single genuine finding was `I-MISC-335` in
// `interpreter2_test.dart`, a tear-off of an absent instance method, which now
// asserts the script-level catch.
//
// The remaining 118 are confirmed interpreter-owned. The corroboration that
// this is a real boundary rather than an artefact of the experiment is the
// pair `I-MISC-335` / `I-MISC-336`: two tests differing by one word of source,
// landing on opposite sides of the line drawn above, and each the other's
// control.
//
// The stdlib assertions deserve their own note, because they look like
// candidates and are not. Every one of them — `JsonUtf8Encoder(42)`,
// `Int32List(2).setAll(0, [7.5])`, `Runes('ab').followedBy(7)`,
// `utf8.decoder.startChunkedConversion(42)` — is an ARGUMENT-TYPE mismatch,
// which real Dart rejects at compile time. The SDK method never runs, so there
// is no runtime SDK error to re-point at; the interpreter is reporting a
// failure the platform reports earlier and differently. `LinkedListEntry`
// unlinked twice is the one that genuinely reaches SDK code, and measuring it
// gives `_TypeError: Null check operator used on a null value` — an
// implementation leak of `_list!` rather than a specified contract, so pinning
// it would be worse than what is there.

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
