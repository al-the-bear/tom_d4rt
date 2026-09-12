// SCD30: an empty queue must fail the way Dart fails.
//
// `Queue.removeFirst` / `removeLast` guarded the empty case by hand and threw
// `RuntimeD4rtException` with prose of their own invention ("Cannot removeFirst
// from an empty queue."). Dart throws `StateError` with `Bad state: No element`.
// So a script written the idiomatic way —
//
//     try { q.removeFirst(); } on StateError { … }
//
// did not catch, and the failure surfaced as an uncaught interpreter error
// instead of the recovery path its author wrote.
//
// THIS IS A BETTER HIDING PLACE THAN THE SIBLING DEFECT IT CAME FROM. The
// SplayTreeMap guard SCC10 fixed threw where Dart RETURNS, so it changed the
// value contract and one probe found it. This one throws where Dart THROWS, so
// the two behave identically until a script tries to CATCH — every reasonable
// "does it fail on empty?" test passed the whole time.
//
// WHICH IS WHY THESE CASES ASSERT THE CATCH, NOT THE THROW. A host-side
// `throwsA(isA<StateError>())` is not sufficient either: the interpreter may
// wrap on the way out, so the assertion has to be made INSIDE the interpreted
// script, in a `try` / `on StateError` block whose recovery path returns a
// value the test reads. `throwsA(anything)` would have passed before the fix,
// and so would most of what a careful author would write instead.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  const types = ['Queue', 'ListQueue', 'DoubleLinkedQueue'];
  const members = {
    'removeFirst': 'q.removeFirst()',
    'removeLast': 'q.removeLast()',
    'first': 'q.first',
    'last': 'q.last',
  };

  /// Runs [expression] on an empty [type] and reports what the SCRIPT saw.
  String outcome(String type, String expression) =>
      D4rt().execute(
            source:
                """
import 'dart:collection';
main() {
  var q = $type();
  try { $expression; return 'no-throw'; }
  on StateError catch (e) { return 'StateError: \${e.toString()}'; }
  catch (e) { return 'not-a-StateError: \${e.runtimeType}'; }
}
""",
          )
          as String;

  group('SCD30: an empty queue raises a catchable StateError', () {
    for (final type in types) {
      for (final member in members.entries) {
        test('F-SCD30-1-$type.${member.key}: `on StateError` catches it '
            '[2026-09-12] (PASS)', () {
          expect(
            outcome(type, member.value),
            equals('StateError: Bad state: No element'),
            reason:
                'A script catching StateError must take its recovery path, '
                'and must see the SDK message rather than one the bridge '
                'invented.',
          );
        });
      }
    }
  });

  group('SCD30: the non-empty path is untouched', () {
    for (final type in types) {
      test('F-SCD30-2-$type: removeFirst still returns the element '
          '[2026-09-12] (PASS)', () {
        // Anti-vacuity. Every case above would pass just as happily against a
        // bridge that had lost `removeFirst` altogether and was raising for a
        // different reason — which is the shape this whole todo is about.
        expect(
          D4rt().execute(
            source:
                "import 'dart:collection'; main() { var q = $type(); "
                'q.addLast(7); q.addLast(8); return q.removeFirst(); }',
          ),
          equals(7),
        );
      });
    }
  });
}
