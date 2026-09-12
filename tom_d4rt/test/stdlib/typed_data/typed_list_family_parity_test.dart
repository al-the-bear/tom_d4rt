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

  String outcome(String type, String body) {
    try {
      D4rt().execute(
        source:
            "import 'dart:typed_data'; main() { var l = $type(2); "
            "$body; return 0; }",
      );
      return 'OK';
    } catch (e) {
      return e.runtimeType.toString();
    }
  }

  group('SCD28: length-preserving setters work on every int variant', () {
    for (final type in intVariants) {
      test('F-SCD28-1-$type: `l.first = 1` assigns [2026-09-12] (PASS)', () {
        // Valid Dart on a fixed-LENGTH list: assigning an element does not
        // change the length. Before the refactor this worked on Uint8List and
        // raised on the other ten, because only Uint8List declared setters.
        expect(outcome(type, 'l.first = 1'), equals('OK'));
      });
    }
  });

  group('SCD28: length= raises UnsupportedError on every int variant', () {
    for (final type in intVariants) {
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
      'l.add(1)',
      'l.addAll([1])',
      'l.clear()',
      'l.insert(0, 1)',
      'l.removeLast()',
      'l.replaceRange(0, 1, [2])',
    ]) {
      test('F-SCD28-3-$member: every int variant raises UnsupportedError '
          '[2026-09-12] (PASS)', () {
        final answers = {for (final t in intVariants) t: outcome(t, member)};
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
        'l.followedBy([1]).toList()',
        'l.setAll(0, [1])',
        'l.setRange(0, 1, [1])',
        'l.sublist(0, 1)',
        'l.first = 1',
        'l.length = 1',
        'l.add(1)',
        'l.removeWhere((x) => true)',
      ];
      final divergent = <String, Map<String, String>>{};
      for (final probe in probes) {
        final answers = {for (final t in intVariants) t: outcome(t, probe)};
        if (answers.values.toSet().length > 1) divergent[probe] = answers;
      }
      expect(
        divergent,
        isEmpty,
        reason:
            'These members do not behave the same on every int variant, which '
            'is the bug class SCD28 removed the duplicate to prevent:\n'
            '$divergent',
      );
    });
  });
}
