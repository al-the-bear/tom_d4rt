// DFUB9: dispatch operators + call() on extension-type instances.
//
// Ports the operator/call groups from upstream kodjodevf/d4rt
// test/extension_types_advanced_test.dart (commit 2f519cd). Operator and
// `call` methods are already stored on InterpretedExtensionType.methods (keyed
// by the operator lexeme / `call`), but the dispatch sites
// (visitBinaryExpression, compound assignment, visitPrefixExpression, index
// `[]`/`[]=`, and instance-invocation for `call`) did not recognise an
// InterpretedExtensionTypeInstance operand/target. The fix routes each site to
// the extension type's operator/`call` method, binding `this`.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? execute(String code) {
  final d4rt = D4rt();
  return d4rt.execute(source: code);
}

void main() {
  group('DFUB9: extension-type operator + call dispatch', () {
    test('F-DFUB9-1: binary operator + [2026-07-23] (RED)', () {
      const code = '''
extension type Amount(int cents) {
  Amount operator +(Amount other) => Amount(cents + other.cents);
}
int main() {
  var a1 = Amount(100);
  var a2 = Amount(200);
  var result = a1 + a2;
  return result.cents;
}
''';
      expect(execute(code), equals(300));
    });

    test('F-DFUB9-2: binary operator * [2026-07-23] (RED)', () {
      const code = '''
extension type Distance(double meters) {
  Distance operator *(double factor) => Distance(meters * factor);
}
double main() {
  var d = Distance(10.0);
  var scaled = d * 2.5;
  return scaled.meters;
}
''';
      expect(execute(code), equals(25.0));
    });

    test('F-DFUB9-3: binary operator > [2026-07-23] (RED)', () {
      const code = '''
extension type Priority(int level) {
  bool operator >(Priority other) => level > other.level;
}
bool main() {
  var high = Priority(10);
  var low = Priority(5);
  return high > low;
}
''';
      expect(execute(code), isTrue);
    });

    test('F-DFUB9-4: compound += via operator + [2026-07-23] (RED)', () {
      const code = '''
extension type Counter(int count) {
  Counter operator +(int amount) => Counter(count + amount);
}
int main() {
  var c = Counter(10);
  c += 5;
  return c.count;
}
''';
      expect(execute(code), equals(15));
    });

    test('F-DFUB9-5: compound *= via operator * [2026-07-23] (RED)', () {
      const code = '''
extension type Value(int val) {
  Value operator *(int factor) => Value(val * factor);
}
int main() {
  var v = Value(10);
  v *= 4;
  return v.val;
}
''';
      expect(execute(code), equals(40));
    });

    test('F-DFUB9-6: unary operator - [2026-07-23] (RED)', () {
      const code = '''
extension type Temperature(double celsius) {
  Temperature operator -() => Temperature(-celsius);
}
double main() {
  var temp = Temperature(25.0);
  var inverted = -temp;
  return inverted.celsius;
}
''';
      expect(execute(code), equals(-25.0));
    });

    test('F-DFUB9-7: unary operator ~ [2026-07-23] (RED)', () {
      const code = '''
extension type Flags(int value) {
  Flags operator ~() => Flags(~value);
}
int main() {
  var f = Flags(0);
  var inverted = ~f;
  return inverted.value;
}
''';
      expect(execute(code), equals(-1));
    });

    test('F-DFUB9-8: call() single arg [2026-07-23] (RED)', () {
      const code = '''
extension type Calculator(int base) {
  int call(int x) => base + x;
}
int main() {
  var calc = Calculator(10);
  return calc(5);
}
''';
      expect(execute(code), equals(15));
    });

    test('F-DFUB9-9: call() multiple args [2026-07-23] (RED)', () {
      const code = '''
extension type Multiplier(int factor) {
  int call(int a, int b) => (a * b) * factor;
}
int main() {
  var mult = Multiplier(2);
  return mult(3, 4);
}
''';
      expect(execute(code), equals(24));
    });

    test('F-DFUB9-10: call() named args [2026-07-23] (RED)', () {
      const code = '''
extension type Formula(int base) {
  int call({required int add, required int multiply}) {
    return (base + add) * multiply;
  }
}
int main() {
  var f = Formula(10);
  return f(add: 5, multiply: 2);
}
''';
      expect(execute(code), equals(30));
    });

    test('F-DFUB9-11: index operator [] [2026-07-23] (RED)', () {
      const code = '''
extension type IntArray(List<int> items) {
  int operator [](int index) => items[index] * 2;
}
int main() {
  var arr = IntArray([10, 20, 30]);
  return arr[1];
}
''';
      expect(execute(code), equals(40));
    });

    test('F-DFUB9-12: index operator []= [2026-07-23] (RED)', () {
      const code = '''
extension type MutableArray(List<int> items) {
  int operator [](int index) => items[index];
  void operator []=(int index, int value) {
    items[index] = value + 10;
  }
}
int main() {
  var arr = MutableArray([1, 2, 3]);
  arr[0] = 5;
  return arr[0];
}
''';
      expect(execute(code), equals(15));
    });
  });
}
