import 'package:test/test.dart';
import 'interpreter_test.dart';

void main() {
  group('Complex Generic Type Checking', () {
    test('I-TYPE-7: Simple generic List type checking. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var list = [1, 2, 3];
  
  // Basic List check should work
  if (list is List) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-4: Simple generic Map type checking. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var map = {'a': 1, 'b': 2};
  
  // Basic Map check should work
  if (map is Map) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-5: Generic List<int> type checking. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var list = [1, 2, 3];
  
  // Check if it's a List<int>
  if (list is List<int>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-6: Generic Map<String, int> type checking. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var map = {'a': 1, 'b': 2};
  
  // Check if it's a Map<String, int>
  if (map is Map<String, int>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-8: Nested generic Map<String, List<int>> type checking. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var map = {
    'a': [1, 2, 3],
    'b': [4, 5, 6]
  };
  
  // Check if it's a Map<String, List<int>>
  if (map is Map<String, List<int>>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-9: Negative type check - List<String> is not List<int>. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var list = ['a', 'b', 'c'];
  
  // Should NOT be List<int>
  if (list is! List<int>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-1: Complex nested generic List<Map<String, int>> type checking. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var list = [
    {'a': 1, 'b': 2},
    {'c': 3, 'd': 4}
  ];
  
  // Check if it's a List<Map<String, int>>
  if (list is List<Map<String, int>>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test(
        'triple nested generic Map<String, List<Map<String, int>>> type checking',
        () {
      const code = '''
int main() {
  var complexMap = {
    'group1': [
      {'a': 1, 'b': 2},
      {'c': 3}
    ],
    'group2': [
      {'d': 4, 'e': 5}
    ]
  };
  
  // Check if it's a Map<String, List<Map<String, int>>>
  if (complexMap is Map<String, List<Map<String, int>>>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-2: Type checking with nullable generics. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var list = [1, null, 3];
  
  // Check if it's a List<int?>
  if (list is List<int?>) {
    return 1;
  }
  return 0;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });

    test('I-TYPE-3: Generic type mismatch detection. [2026-02-10 06:37] (PASS)', () {
      const code = '''
int main() {
  var mapOfStrings = {'a': 'hello', 'b': 'world'};
  
  // Should NOT match Map<String, int>
  if (mapOfStrings is Map<String, int>) {
    return 0;
  }
  return 1;
}
''';
      final result = execute(code);
      expect(result, equals(1));
    });
  });
}
