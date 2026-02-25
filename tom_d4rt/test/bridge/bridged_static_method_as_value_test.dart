import 'package:test/test.dart';
import '../interpreter_test.dart';

void main() {
  group('Bridged Static Method as Value', () {
    test('I-BRIDGE-9: Can pass bridged static method as value - int.parse. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  // Get the static method as a value
  var parseFunc = int.parse;
  
  // Call it with a string
  var result = parseFunc('42');
  
  return result; // 42
}
''';
      final result = execute(code);
      expect(result, equals(42));
    });

    test('I-BRIDGE-6: Can pass bridged static method to higher-order function. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int applyToString(Function f, String s) {
  return f(s);
}

int main() {
  // Pass int.parse as a function value
  return applyToString(int.parse, '100');
}
''';
      final result = execute(code);
      expect(result, equals(100));
    });

    test('I-BRIDGE-7: Can store bridged static methods in collections. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  // Store static methods in a list
  var parsers = [int.parse, double.parse];
  
  // Call them
  var intResult = parsers[0]('42');
  var doubleResult = parsers[1]('3.14');
  
  return intResult + doubleResult.toInt();
}
''';
      final result = execute(code);
      expect(result, equals(45)); // 42 + 3
    });

    test('I-BRIDGE-8: Can map with bridged static method. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var strings = ['1', '2', '3'];
  var numbers = strings.map(int.parse).toList();
  
  return numbers.length;
}
''';
      final result = execute(code);
      expect(result, equals(3));
    });

    test('I-BRIDGE-10: Can use multiple bridged static methods. [2026-02-10 06:37] (PASS)', () {
      const code = '''
import 'dart:math';

int main() {
  // Get static methods as values
  var maxFunc = max;
  var minFunc = min;
  
  var maxResult = maxFunc(10, 20);
  var minResult = minFunc(10, 20);
  
  return maxResult + minResult;
}
''';
      final result = execute(code);
      expect(result, equals(30)); // 20 + 10
    });
  });
}
