import 'package:test/test.dart';

import 'interpreter_test.dart';

/// GEN-C3c: Every Dart Object exposes `toString`, `hashCode`, and
/// `runtimeType`. These must always resolve in interpreted scripts —
/// regardless of whether the runtime type has a registered bridge.
///
/// Regression cases motivating these tests:
///
///   * Catching a native `RuntimeD4rtException` and calling `e.toString()`,
///     `e.hashCode`, or `e.runtimeType` previously failed with
///     "Undefined property or method 'X' on RuntimeD4rtException" because
///     the visitor's PrefixedIdentifier / PropertyAccess fallthroughs
///     didn't expose the universal Object members.
///
/// The interpreter now applies a universal Object-member fallback in both
/// `visitPropertyAccess` and `visitPrefixedIdentifier` (mirrored in the
/// equivalent SAst visitors) right before throwing
/// "Undefined property or method '…'".
void main() {
  group('Object universal members — toString / hashCode / runtimeType', () {
    test('I-OBJ-UNI-1: e.toString() in catch block resolves '
        '[2026-05-04 09:00] (PASS)', () {
      const source = '''
        main() {
          try {
            int.parse("not a number");
          } catch (e) {
            return e.toString();
          }
          return "no throw";
        }
      ''';
      final result = execute(source) as String;
      // The exact message is interpreter-internal; we only assert that
      // toString resolved (returned a non-empty String).
      expect(result, isNotEmpty);
      expect(result, isNot(equals("no throw")));
    });

    test('I-OBJ-UNI-2: e.hashCode in catch block resolves to int '
        '[2026-05-04 09:00] (PASS)', () {
      const source = '''
        main() {
          try {
            int.parse("not a number");
          } catch (e) {
            return e.hashCode;
          }
          return 0;
        }
      ''';
      expect(execute(source), isA<int>());
    });

    test('I-OBJ-UNI-3: e.runtimeType in catch block resolves to a Type '
        '[2026-05-04 09:00] (PASS)', () {
      const source = '''
        main() {
          try {
            int.parse("not a number");
          } catch (e) {
            return e.runtimeType.toString();
          }
          return "no throw";
        }
      ''';
      // Just assert it produces a non-empty type-name string.
      final result = execute(source) as String;
      expect(result, isNotEmpty);
      expect(result, isNot(equals("no throw")));
    });

    test('I-OBJ-UNI-4: toString tear-off invocation '
        '[2026-05-04 09:00] (PASS)', () {
      const source = '''
        main() {
          try {
            int.parse("not a number");
          } catch (e) {
            final f = e.toString;
            return f();
          }
          return "no throw";
        }
      ''';
      final result = execute(source) as String;
      expect(result, isNotEmpty);
      expect(result, isNot(equals("no throw")));
    });
  });
}
