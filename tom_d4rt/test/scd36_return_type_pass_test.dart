@Timeout(Duration(minutes: 5))
library;

import 'package:test/test.dart';

import '../tool/stdlib_member_diff.dart';

/// SCD36 — the return-type pass, and the two ways it can go quietly useless.
///
/// A member can be registered correctly, export cleanly and analyse cleanly and
/// still be unusable, because the value it RETURNS reaches no bridge. The
/// member diff cannot see this by construction: it compares member *names*, and
/// the member is present in both maps whatever its return type. SCC11 hit it
/// twice in one afternoon (`Iterable.castFrom`, `LineSplitter.split`) and both
/// times only an end-to-end test that *used* the value could tell.
///
/// ## Why the pass is a runtime one
///
/// SCD36 proposed reading the SDK return type from the mirror and
/// cross-referencing it against `nativeNames`. That cannot work, and this file
/// pins the reason: both motivating members DECLARE `Iterable`, which is
/// bridged. The offending types — `_EfficientLengthCastIterable`,
/// `_LineSplitIterable` — appear in no static signature anywhere. A declared
/// return type pass reports zero for both, which is the same blindness wearing
/// a new instrument.
///
/// ## The two failure modes this file guards
///
/// **Vacuity.** The pass currently reports zero gaps. A zero is only worth
/// anything if the instrument could have said otherwise, and this one silently
/// could not at first: it classifies on the interpreter's wording, and the
/// wording an unbridged native target actually produces — `Cannot access
/// property 'x' on target of type _Foo` — was missing from the audit's shared
/// `_isUnreachableError`. The pass reported 0/411 while blind. F-SCD36-1..4
/// pin the vocabulary.
///
/// **Coverage drift.** The pass only covers a member if it can synthesise the
/// member's arguments. Both motivating members take one argument, so a pass
/// restricted to no-argument members would miss both — and a later edit to the
/// argument table could quietly put them back out of range. F-SCD36-5 asserts
/// they are still probed, by name.
void main() {
  group('SCD36: the return-type pass', () {
    group('the classifier knows the wording an unbridged target produces', () {
      const bridges = {'Iterable', 'Map', 'List'};

      test('F-SCD36-1: `Cannot access property ... on target of type _Foo` '
          'names an unbridged receiver [2026-09-12]', () {
        // The exact wording `core/map.dart` documents against `_ConstMap`, and
        // the one the audit's shared classifier never recognised.
        const message =
            "Runtime Error: Cannot access property 'isEmpty' on target of "
            "type _LineSplitIterable.";
        expect(lookupFailureReceiver(message), '_LineSplitIterable');
        expect(namesAnUnbridgedReceiver(message, bridges), isTrue);
      });

      test('F-SCD36-2: a bridged receiver is NOT reported, so the pass does '
          'not double-count member gaps [2026-09-12]', () {
        // `Iterable has no getter named 'foo'` is an ordinary member gap. The
        // member diff already reports it and this pass must not.
        const message = "Iterable has no getter named 'foo'";
        expect(lookupFailureReceiver(message), 'Iterable');
        expect(namesAnUnbridgedReceiver(message, bridges), isFalse);
      });

      test('F-SCD36-3: a bridge name appearing INSIDE an SDK implementation '
          'name does not rescue it [2026-09-12]', () {
        // The reason the receiver is extracted rather than matched by
        // substring: `_EfficientLengthCastIterable` ends with `Iterable`, so a
        // "does the message mention a bridge name" test answers yes for
        // precisely the case that is a gap.
        const message =
            "Runtime Error: Cannot access property 'isEmpty' on target of "
            "type _EfficientLengthCastIterable<dynamic, dynamic>.";
        expect(namesAnUnbridgedReceiver(message, bridges), isTrue);
      });

      test('F-SCD36-4: a null receiver is not an unbridged type '
          '[2026-09-12]', () {
        // `BigInt.tryParse('ab')` answers null for a synthesised argument that
        // is not a valid input. The witness read then fails on null, which is
        // the SDK behaving correctly. Four members reported as gaps this way
        // before the pass distinguished it.
        const message =
            "Runtime Error: Cannot access property 'bitLength' on target of "
            "type null.";
        expect(lookupFailureReceiver(message), 'null');
      });
    });

    test('F-SCD36-5: the two members that motivated SCD36 are actually '
        'probed [2026-09-12]', () async {
      // Not "do they pass" — they do, and they would pass just as readily if
      // the pass had skipped them. This asserts they are in RANGE of the
      // instrument, which is what an argument-table edit could silently undo.
      final env = buildFullyRegisteredEnvironment();
      final results = await auditReturnTypes(
        env,
        only: {'Iterable', 'LineSplitter'},
      );

      for (final member in ['castFrom', 'split']) {
        final row = results.firstWhere(
          (r) => r.member == member,
          orElse: () => fail(
            'SCD36 was created because `$member` returns a type no bridge '
            'knew. The pass no longer plans a probe for it, so it would not '
            'notice a recurrence.',
          ),
        );
        expect(
          row.reach,
          ReturnReach.usable,
          reason:
              '$member was probed and its returned value could not be used. '
              'Its runtime type reaches no bridge — add it to the owning '
              "bridge's nativeNames, as SCC11 did.",
        );
      }
    });
  });
}
