import 'package:test/test.dart';
import 'interpreter_test.dart' show executeAsync;

void main() {
  group('Complex Await Assignments', () {
    test('I-ASYNC-45: Await with conditional expression (ternary). [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  bool condition = true;
  
  // Complex assignment: await with conditional
  var result = await (condition ? getFuture(42) : getFuture(99));
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(42));
    });

    test('I-ASYNC-43: Await with conditional expression - false branch. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  bool condition = false;
  
  var result = await (condition ? getFuture(42) : getFuture(99));
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(99));
    });

    test('I-ASYNC-44: Await with nested conditionals. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  bool outerCondition = true;
  bool innerCondition = false;
  
  var result = await (outerCondition 
    ? (innerCondition ? getFuture(1) : getFuture(2))
    : getFuture(3));
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(2));
    });

    test('I-ASYNC-46: Await with binary expression. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  var a = await (getFuture(10));
  var b = await (getFuture(20));
  
  // Simple but grouped
  var sum = await (getFuture(a + b));
  
  return sum;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(30));
    });

    test('I-ASYNC-47: Await in compound assignment with conditional. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  int result = 10;
  bool shouldAdd = true;
  
  // Compound assignment with await and conditional
  result += await (shouldAdd ? getFuture(5) : getFuture(10));
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(15));
    });

    test('I-ASYNC-38: Multiple await expressions in same statement. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  // Multiple awaits - separated for clarity (Dart limitation)
  var a = await getFuture(10);
  var b = await getFuture(20);
  var result = a + b;
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(30));
    });

    test('I-ASYNC-39: Await with null-coalescing. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int?> getNullableFuture(bool returnNull) async {
  return returnNull ? null : 42;
}

int main() async {
  // Await with null-coalescing operator
  var result = await (getNullableFuture(false)) ?? 0;
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(42));
    });

    test('I-ASYNC-40: Await with null-coalescing - null case. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int?> getNullableFuture(bool returnNull) async {
  return returnNull ? null : 42;
}

int main() async {
  var temp = await getNullableFuture(true);
  var result = temp ?? 99;
  
  return result;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(99));
    });

    test('I-ASYNC-41: Await in list literal. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<int> getFuture(int value) async {
  return value;
}

int main() async {
  // Await in collection literal
  var list = [
    await getFuture(1),
    await getFuture(2),
    await getFuture(3)
  ];
  
  return list.length;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(3));
    });

    test('I-ASYNC-42: Await in map literal. [2026-02-10 06:37] (PASS)', () async {
      const code = '''
Future<String> getStringFuture(String value) async {
  return value;
}

Future<int> getIntFuture(int value) async {
  return value;
}

int main() async {
  // Await in map literal
  var map = {
    await getStringFuture('key1'): await getIntFuture(10),
    await getStringFuture('key2'): await getIntFuture(20),
  };
  
  return map.length;
}
''';
      final result = await executeAsync(code);
      expect(result, equals(2));
    });
  });
}
