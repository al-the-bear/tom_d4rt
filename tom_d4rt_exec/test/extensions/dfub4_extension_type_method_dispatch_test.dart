// DFUB4 (tom_d4rt_ast mirror): extension-type instances must dispatch INSTANCE
// METHODS (and store / dispatch SETTERS), not just getters. Same behaviour as
// the tom_d4rt suite — this exercises the analyzer-free ast interpreter through
// tom_d4rt_exec to keep the two trees in sync.

import 'package:test/test.dart';
import '../interpreter_test.dart';

void main() {
  group('DFUB4: extension type method dispatch (ast tree)', () {
    test(
      'F-DFUB4A-1: single method reading representation [2026-07-23] (PASS)',
      () {
        const code = '''
extension type UserId(int id) {
  String describe() => 'User #\${id}';
}

String main() {
  var u = UserId(42);
  return u.describe();
}
''';
        expect(execute(code), equals('User #42'));
      },
    );

    test('F-DFUB4A-2: multiple methods + getters [2026-07-23] (PASS)', () {
      const code = '''
extension type Price(double amount) {
  double get withTax => amount * 1.2;
  String get formatted => '\\\$\${amount}';
  String description() => 'Price: \${formatted} (with tax: \${withTax})';
}

List main() {
  var p = Price(10.5);
  return [p.withTax, p.formatted, p.description()];
}
''';
      final result = execute(code) as List;
      expect(result[0], closeTo(12.6, 1e-9));
      expect(result[1], equals('\$10.5'));
      expect(result[2], equals('Price: \$10.5 (with tax: 12.6)'));
    });

    test('F-DFUB4A-3: method accessing representation [2026-07-23] (PASS)', () {
      const code = '''
extension type Email(String address) {
  String domain() {
    var parts = address.split('@');
    return parts.length > 1 ? parts[1] : '';
  }
  bool isValid() => address.contains('@');
}

List main() {
  var email = Email('user@example.com');
  return [email.domain(), email.isValid()];
}
''';
      expect(execute(code), equals(['example.com', true]));
    });

    test('F-DFUB4A-4: method calling another method [2026-07-23] (PASS)', () {
      const code = '''
extension type UserId(int id) {
  bool isValid() => id > 0 && id < 1000000;
  String validate() {
    if (!isValid()) return 'Invalid ID';
    return 'Valid ID: \${id}';
  }
}

List main() {
  var valid = UserId(100);
  var invalid = UserId(-1);
  return [valid.validate(), invalid.validate()];
}
''';
      expect(execute(code), equals(['Valid ID: 100', 'Invalid ID']));
    });

    test('F-DFUB4A-5: method chaining [2026-07-23] (PASS)', () {
      const code = '''
extension type Value(int val) {
  Value double() => Value(val * 2);
  Value addTen() => Value(val + 10);
  Value triple() => Value(val * 3);
}

int main() {
  return Value(5).double().addTen().triple().val;
}
''';
      expect(execute(code), equals(60));
    });

    test('F-DFUB4A-6: setter mutates representation [2026-07-23] (PASS)', () {
      const code = '''
extension type Box(List<int> slot) {
  int get value => slot[0];
  set value(int v) { slot[0] = v * 10; }
}

int main() {
  var b = Box([1]);
  b.value = 5;
  return b.value;
}
''';
      expect(execute(code), equals(50));
    });

    // SCD19: F-DFUB4-5, -6 and -8 of the reference suite had no counterpart
    // here. Nothing about them is analyzer-specific — they are script-level
    // dispatch cases like the six above — so their absence was a shortfall
    // rather than a difference in kind, and the twin passed the presence check
    // while leaving a third of the suite unrun on this line.
    test(
      'F-DFUB4A-7: method with loops over representation [2026-09-12] (PASS)',
      () {
        const code = '''
extension type IntList(List<int> items) {
  int sum() {
    int total = 0;
    for (final item in items) {
      total = total + item;
    }
    return total;
  }
  int count() => items.length;
}

List main() {
  var list = IntList([1, 2, 3, 4, 5]);
  return [list.sum(), list.count()];
}
''';
        expect(execute(code), equals([15, 5]));
      },
    );

    test('F-DFUB4A-8: method with conditional logic [2026-09-12] (PASS)', () {
      const code = '''
extension type Score(int points) {
  String grade() {
    if (points >= 90) return 'A';
    if (points >= 80) return 'B';
    if (points >= 70) return 'C';
    return 'F';
  }
}

List main() {
  var s1 = Score(95);
  var s2 = Score(85);
  var s3 = Score(75);
  var s4 = Score(65);
  return [s1.grade(), s2.grade(), s3.grade(), s4.grade()];
}
''';
      expect(execute(code), equals(['A', 'B', 'C', 'F']));
    });

    test(
      'F-DFUB4A-9: method calling method for validation [2026-09-12] (PASS)',
      () {
        const code = '''
extension type UserId(int id) {
  bool isValid() => id > 0 && id < 1000000;
  String validate() {
    if (!isValid()) return 'Invalid ID';
    return 'Valid ID: \${id}';
  }
}

List main() {
  var valid = UserId(100);
  var invalid = UserId(-1);
  return [valid.validate(), invalid.validate()];
}
''';
        expect(execute(code), equals(['Valid ID: 100', 'Invalid ID']));
      },
    );
  });
}
