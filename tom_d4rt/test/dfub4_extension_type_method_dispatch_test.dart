// DFUB4: extension-type instances must dispatch INSTANCE METHODS (and store /
// dispatch SETTERS), not just getters.
//
// Ports upstream kodjodevf/d4rt 2f519cd (Extension Type Support 0.2.2). The
// member store was already present — InterpretedExtensionType carries a
// `methods` map and InterpretedExtensionTypeInstance.get() binds `this` to the
// method — but the call site never recognised the instance: visitMethodInvocation
// had no InterpretedExtensionTypeInstance branch, so `inst.describe()` threw
// "Undefined property or method 'describe'". SECONDARY gap: setters were dropped
// at declaration (visitExtensionTypeDeclaration stored getters + methods but
// skipped isSetter) and the instance's set() always threw.
//
// These tests observe both directly: methods that read the representation, and a
// setter that mutates through the representation object.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? execute(String code) {
  final d4rt = D4rt();
  return d4rt.execute(source: code);
}

void main() {
  group('DFUB4: extension type method dispatch', () {
    test(
      'F-DFUB4-1: single method reading representation [2026-07-23] (PASS)',
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

    test('F-DFUB4-2: multiple methods + getters [2026-07-23] (PASS)', () {
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

    test(
      'F-DFUB4-3: method accessing representation directly [2026-07-23] (PASS)',
      () {
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
      },
    );

    test('F-DFUB4-4: method calling another method [2026-07-23] (PASS)', () {
      const code = '''
extension type UserId(int id) {
  String describe() => 'User #\${id}';
  bool isSpecial() => id == 1 || id == 42;
}

List main() {
  var u1 = UserId(1);
  var u2 = UserId(42);
  var u3 = UserId(10);
  return [u1.describe(), u1.isSpecial(), u2.isSpecial(), u3.isSpecial()];
}
''';
      expect(execute(code), equals(['User #1', true, true, false]));
    });

    test(
      'F-DFUB4-5: method with loops over representation [2026-07-23] (PASS)',
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

    test('F-DFUB4-6: method with conditional logic [2026-07-23] (PASS)', () {
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

    test('F-DFUB4-7: method chaining [2026-07-23] (PASS)', () {
      const code = '''
extension type Value(int val) {
  Value double() => Value(val * 2);
  Value addTen() => Value(val + 10);
  Value triple() => Value(val * 3);
}

int main() {
  var result = Value(5).double().addTen().triple().val;
  return result;
}
''';
      // 5 * 2 = 10, 10 + 10 = 20, 20 * 3 = 60
      expect(execute(code), equals(60));
    });

    test(
      'F-DFUB4-8: method calling method for validation [2026-07-23] (PASS)',
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

    test('F-DFUB4-9: setter mutates through the representation object '
        '[2026-07-23] (PASS)', () {
      // Setters are proactively supported (no upstream test): the setter body
      // runs with `this` bound and mutates the mutable representation object.
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
  });
}
