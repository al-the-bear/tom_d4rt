// DFUB9 conformance (DGUB13): operator + `call()` dispatch on extension-type
// instances — verified against the ANALYZER-FREE interpreter.
//
// Mirror of tom_d4rt/test/dfub9_extension_type_operator_dispatch_test.dart.
// Operator methods are stored on `InterpretedExtensionType.methods` keyed by
// the operator lexeme; the fix teaches the seven dispatch sites (binary,
// compound-assign, prefix `-`, prefix `~`, index get, index set, and the two
// invocation paths) to recognise `InterpretedExtensionTypeInstance`. This file
// is the guard that the ast tree dispatches identically to the analyzer tree.

import 'package:test/test.dart';
import 'interpreter_test.dart';

void main() {
  group('DFUB9 (exec): extension-type operator + call dispatch', () {
    test('F-DFUB9-EXEC-1: binary operator + [2026-07-27]', () {
      const code = '''
extension type Amount(int cents) {
  Amount operator +(Amount other) => Amount(cents + other.cents);
}

int main() {
  var a = Amount(100);
  var b = Amount(200);
  return (a + b).cents;
}
''';
      expect(execute(code), equals(300));
    });

    test('F-DFUB9-EXEC-2: binary operator * [2026-07-27]', () {
      const code = '''
extension type Distance(double meters) {
  Distance operator *(double factor) => Distance(meters * factor);
}

double main() {
  var d = Distance(10.0);
  return (d * 2.5).meters;
}
''';
      expect(execute(code), equals(25.0));
    });

    test('F-DFUB9-EXEC-3: binary operator > [2026-07-27]', () {
      const code = '''
extension type Priority(int level) {
  bool operator >(Priority other) => level > other.level;
}

bool main() {
  return Priority(5) > Priority(3);
}
''';
      expect(execute(code), isTrue);
    });

    test('F-DFUB9-EXEC-4: compound += via operator + [2026-07-27]', () {
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

    test('F-DFUB9-EXEC-5: compound *= via operator * [2026-07-27]', () {
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

    test('F-DFUB9-EXEC-6: unary operator - [2026-07-27]', () {
      const code = '''
extension type Temperature(double celsius) {
  Temperature operator -() => Temperature(-celsius);
}

double main() {
  var t = Temperature(25.0);
  return (-t).celsius;
}
''';
      expect(execute(code), equals(-25.0));
    });

    test('F-DFUB9-EXEC-7: unary operator ~ [2026-07-27]', () {
      const code = '''
extension type Flags(int value) {
  Flags operator ~() => Flags(~value);
}

int main() {
  var f = Flags(0);
  return (~f).value;
}
''';
      expect(execute(code), equals(-1));
    });

    test('F-DFUB9-EXEC-8: call() single arg [2026-07-27]', () {
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

    test('F-DFUB9-EXEC-9: call() multiple args [2026-07-27]', () {
      const code = '''
extension type Multiplier(int factor) {
  int call(int a, int b) => (a * b) * factor;
}

int main() {
  var m = Multiplier(2);
  return m(3, 4);
}
''';
      expect(execute(code), equals(24));
    });

    test('F-DFUB9-EXEC-10: call() named args [2026-07-27]', () {
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

    test('F-DFUB9-EXEC-11: index operator [] [2026-07-27]', () {
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

    test('F-DFUB9-EXEC-12: index operator []= [2026-07-27]', () {
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
