// SCD28: the eleven typed lists share one code path, so they cannot disagree.
//
// `Uint8List` hand-rolled the whole inherited-`List` adapter map that the other
// ten reached through `inheritedListMethods<E>()`. That single structural fact
// produced two defects in opposite directions — SCB3 gave `Uint8List`
// `sort`/`shuffle`/`asUnmodifiableView` that the other ten lacked; SCC9 gave it
// a `_TypeError` where the other ten raised a catchable `UnsupportedError` —
// and both were hard to see for the same reason:
//
//   Uint8List is the variant most likely to be probed and the one LEAST
//   representative of the others, so every spot-check of "typed lists" was a
//   spot-check of the special case.
//
// The refactor removes the duplicate rather than changing behaviour. Measured
// before and after through the interpreter, `Uint8List`'s resolvable surface is
// identical on all 24 probes. What DID change is that the other ten gained the
// three `List` setters they never had — and there `Uint8List` was the correct
// one, which is the reverse of the assumption the work started from.
//
// These cases assert the property the refactor buys: PARITY. A member that
// behaves one way on one variant and another way on its siblings is the bug
// class, so the assertion is about agreement rather than about any one answer.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  const intVariants = [
    'Int8List',
    'Int16List',
    'Int32List',
    'Int64List',
    'Uint8List',
    'Uint8ClampedList',
    'Uint16List',
    'Uint32List',
    'Uint64List',
  ];
  const floatVariants = ['Float32List', 'Float64List'];
  const variants = [...intVariants, ...floatVariants];

  /// The element literal `type` accepts.
  ///
  /// SCE71. The two float variants were excluded from these groups because the
  /// probe bodies hardcoded `1`, and an `int` into a double list is a type
  /// error in Dart — correctly rejected, so one literal could not drive both
  /// families. The exclusion was the right call for a shared literal and the
  /// wrong one for the property: the floats reach the same
  /// `inheritedListMethods<E>()` helper and the same setters as the other
  /// nine, and nothing asserted that they do. A hand-rolled adapter on
  /// `Float64List` is the SCD28 shape repeating, and F-SCD28-4 would not see
  /// it. Parameterising the literal is all that was in the way.
  String lit(String type) => type.startsWith('Float') ? '1.0' : '1';

  /// Runs `body` on `type`, with `{v}` replaced by an element literal the
  /// type accepts, so one probe drives all eleven variants.
  String outcome(String type, String body) {
    final source = body.replaceAll('{v}', lit(type));
    try {
      D4rt().execute(
        source:
            "import 'dart:typed_data'; main() { var l = $type(2); "
            "$source; return 0; }",
      );
      return 'OK';
    } catch (e) {
      return e.runtimeType.toString();
    }
  }

  group('SCD28: length-preserving setters work on every variant', () {
    for (final type in variants) {
      test('F-SCD28-1-$type: `l.first = <element>` assigns [2026-09-12] '
          '(PASS)', () {
        // Valid Dart on a fixed-LENGTH list: assigning an element does not
        // change the length. Before the refactor this worked on Uint8List and
        // raised on the other ten, because only Uint8List declared setters.
        expect(outcome(type, 'l.first = {v}'), equals('OK'));
      });
    }
  });

  group('SCD28: length= raises UnsupportedError on every variant', () {
    for (final type in variants) {
      test('F-SCD28-2-$type: `l.length = 1` is unsupported, not unknown '
          '[2026-09-12] (PASS)', () {
        // The distinction that matters: `length` EXISTS on a fixed-length list
        // and throws, which a script can catch. Reporting it as a missing
        // member instead — which is what the ten did — sends a script written
        // `try { … } on UnsupportedError { … }` down the wrong path.
        expect(outcome(type, 'l.length = 1'), equals('UnsupportedError'));
      });
    }
  });

  group('SCD28: the length-changing members agree across the family', () {
    for (final member in const [
      'l.add({v})',
      'l.addAll([{v}])',
      'l.clear()',
      'l.insert(0, {v})',
      'l.removeLast()',
      'l.replaceRange(0, 1, [{v}])',
    ]) {
      final label = member.replaceAll('{v}', '<e>');
      test('F-SCD28-3-$label: every variant raises UnsupportedError '
          '[2026-09-12] (PASS)', () {
        final answers = {for (final t in variants) t: outcome(t, member)};
        expect(
          answers.values.toSet(),
          equals({'UnsupportedError'}),
          reason:
              'The eleven must agree. Disagreement here is the SCC9 shape: '
              'one variant casting its argument where the others coerce. '
              'Answers: $answers',
        );
      });
    }
  });

  group('SCE71: the float variants reject an int element, by name', () {
    for (final type in floatVariants) {
      test('F-SCE71-1-$type: `l.first = 1` is refused with the named message '
          '[2026-09-21]', () {
        // THE MUST-NOT-WIDEN HALF, in the same family as scd26's
        // F-SCD26-6/-7/-8. The groups above assert that every variant ACCEPTS
        // an element of its own type; this asserts that the floats still
        // REFUSE one of the wrong type. Coercing an `int` into a double list
        // would make a script green here that does not compile as Dart, which
        // is the one bridge defect a passing test cannot catch.
        //
        // The MESSAGE is asserted, not merely the throw. A raw `_TypeError`
        // from a failed cast and the named refusal SCD28 added are both
        // failures, and only one of them tells a script author what is wrong.
        // Matching on the type alone would go green if the named message were
        // lost to a refactor — which is exactly how it would be lost.
        String message(String body) {
          try {
            D4rt().execute(
              source:
                  "import 'dart:typed_data'; main() { var l = $type(2); "
                  '$body; return 0; }',
            );
            return '<no throw>';
          } catch (e) {
            return e.toString();
          }
        }

        expect(
          message('l.first = 1'),
          allOf(
            contains('Cannot assign int to first'),
            contains('this list holds double'),
          ),
          reason:
              'An int assigned into a $type must be refused with the message '
              'SCD28 named, not with a bare cast error.',
        );
      });
    }

    test('F-SCE71-2 (control): the same assignment SUCCEEDS on the int '
        'variants [2026-09-21]', () {
      // Anti-vacuity, and it is the case that makes F-SCE71-1 mean something:
      // `l.first = 1` must be refused on a double list *because it is the
      // wrong element type*, not because `first =` is broken everywhere. If
      // the setter were simply unimplemented, F-SCE71-1 would still pass.
      for (final type in intVariants) {
        expect(outcome(type, 'l.first = 1'), equals('OK'), reason: type);
      }
    });
  });

  group('SCD28: Uint8List is no longer the special case', () {
    test('F-SCD28-4: Uint8List answers identically to its siblings across the '
        'inherited surface [2026-09-12] (PASS)', () {
      // The whole point of the refactor, stated as one assertion. If a future
      // edit re-introduces a hand-rolled adapter on any single variant, this is
      // what catches it — and it catches it wherever the divergence appears,
      // not only at the members someone thought to list.
      const probes = [
        'l.sort()',
        'l.shuffle()',
        'l.asUnmodifiableView()',
        'l.followedBy([{v}]).toList()',
        'l.setAll(0, [{v}])',
        'l.setRange(0, 1, [{v}])',
        'l.sublist(0, 1)',
        'l.first = {v}',
        'l.length = 1',
        'l.add({v})',
        'l.removeWhere((x) => true)',
      ];
      final divergent = <String, Map<String, String>>{};
      for (final probe in probes) {
        final answers = {for (final t in variants) t: outcome(t, probe)};
        if (answers.values.toSet().length > 1) divergent[probe] = answers;
      }
      expect(
        divergent,
        isEmpty,
        reason:
            'These members do not behave the same on every variant, which '
            'is the bug class SCD28 removed the duplicate to prevent:\n'
            '$divergent',
      );
    });
  });
}
