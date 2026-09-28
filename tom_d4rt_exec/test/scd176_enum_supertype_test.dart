// `x is Enum` answers what Dart answers, for every bridged value.
//
// THE DEFECT. `Enum` is bridged but declared no `isAssignable`, and
// `_valueHasType`'s bridged branch only reaches its native-predicate fallback
// when the bridge has one. So `is Enum` was FALSE for every bridged value —
// false by omission, not by any decision.
//
// THE SCOPE IS ONE CLASS, NOT "EVERY ENUM-SHAPED BRIDGE", and that is the
// measurement this file is built on. SCD176 named five and proposed declaring
// an `-> Enum` supertype edge on each. Against Dart, four of them are not
// enums:
//
//     StdioType                            final class      is Enum => false
//     ProcessSignal                        interface class  is Enum => false
//     InternetAddressType                  final class      is Enum => false
//     FileMode                             class            is Enum => false
//     HttpClientResponseCompressionState   enum             is Enum => TRUE
//
// They are classes with static const instances, which LOOK like enums from a
// script and are not. Hand-declaring the edge would have turned four correct
// answers into wrong ones — so the fix asks the native value instead
// (`isAssignable: (v) => v is Enum`), which classifies each correctly without
// anyone having to.
//
// `is Comparable` IS NOT PART OF THE FIX, and that is also measured. SCD176
// states that "`Enum` extends `Comparable<Enum>`" and that a script sorting
// bridged enums "gets a type test that says no while `compareTo` itself
// works". Neither holds: Dart answers FALSE to `is Comparable` for all five,
// including the genuine enum, and the bridge has no `compareTo` at all. The
// interpreter's `false` is therefore already right, and declaring the edge
// would advertise a capability that is absent — the inversion of the defect
// the todo was worried about. F-SCD176-3 pins it, on both sides.
//
// EVERY EXPECTATION IS COMPUTED, for the reason SCD174 established: the fix's
// justification is "match the platform", so the assertion has to ask the
// platform rather than restate today's answers as literals.

import 'dart:io';

import 'package:test/test.dart';

import 'interpreter_test.dart';

/// Script expression -> the same value, natively.
final Map<String, Object> _subjects = {
  'HttpClientResponseCompressionState.compressed':
      HttpClientResponseCompressionState.compressed,
  'StdioType.terminal': StdioType.terminal,
  'ProcessSignal.sigint': ProcessSignal.sigint,
  'InternetAddressType.IPv4': InternetAddressType.IPv4,
  'FileMode.read': FileMode.read,
};

void main() {
  group('SCD176: `is Enum` matches Dart', () {
    test('F-SCD176-1: the subjects split both ways in Dart '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity, and specific: a table whose members all answer the same
      // way cannot tell a predicate that classifies from one that returns a
      // constant. Dart must say true for at least one and false for at least
      // one, or the cases below prove nothing.
      final enums = _subjects.values.whereType<Enum>();
      final nonEnums = _subjects.values.where((v) => v is! Enum);
      expect(enums, isNotEmpty, reason: 'no genuine SDK enum in the table');
      expect(
        nonEnums,
        isNotEmpty,
        reason:
            'no enum-LOOKING non-enum in the table — the four that made '
            'SCD176\'s proposed fix wrong',
      );
    });

    for (final entry in _subjects.entries) {
      test('F-SCD176-2-${entry.key}: is Enum matches Dart '
          '[2026-09-15] (PASS)', () {
        expect(
          execute("import 'dart:io';\nmain() => ${entry.key} is Enum;"),
          entry.value is Enum,
          reason:
              'Dart says ${entry.value is Enum} for ${entry.key}. Before this '
              'fix the interpreter said false for every one of them, '
              'including the genuine enum.',
        );
      });
    }

    test('F-SCD176-3: `is Comparable` also matches Dart, which says no '
        '[2026-09-15] (PASS)', () {
      // The half SCD176 got backwards. Kept as a case rather than a comment
      // because "Enum extends Comparable" is a plausible-sounding claim that
      // someone will make again, and this is where they will find it checked.
      for (final entry in _subjects.entries) {
        expect(
          entry.value is Comparable,
          isFalse,
          reason: 'Dart, ${entry.key}',
        );
        expect(
          execute("import 'dart:io';\nmain() => ${entry.key} is Comparable;"),
          isFalse,
          reason: 'interpreter, ${entry.key}',
        );
      }
    });

    test('F-SCD176-4: the bridge still answers its own type, and `.name` '
        'still works [2026-09-15] (PASS)', () {
      // A predicate added to `Enum` must not disturb what already worked —
      // `is <the enum\'s own type>` goes through the bridge name, not through
      // this fallback, and `.name` is the member the whole capability exists
      // for.
      expect(
        execute(
          "import 'dart:io';\n"
          'main() => [\n'
          '  HttpClientResponseCompressionState.compressed is '
          'HttpClientResponseCompressionState,\n'
          '  HttpClientResponseCompressionState.compressed.name,\n'
          '  StdioType.terminal is StdioType,\n'
          '  StdioType.terminal.name,\n'
          '];',
        ),
        [true, 'compressed', true, 'terminal'],
      );
    });
  });
}
