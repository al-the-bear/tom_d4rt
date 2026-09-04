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
  });
}
