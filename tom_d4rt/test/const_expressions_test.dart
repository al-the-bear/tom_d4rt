import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

void main() {
  group('Const Expressions', () {
    test(
      'I-EXPR-30: Const List with simple values. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const list = [1, 2, 3];
  return list.length;
}
''';
        final result = execute(code);
        expect(result, equals(3));
      },
    );

    test(
      'I-EXPR-26: Const List with typed declaration. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const List<int> numbers = [10, 20, 30];
  return numbers[1];
}
''';
        final result = execute(code);
        expect(result, equals(20));
      },
    );

    test(
      'I-EXPR-27: Const Map with simple key-value pairs. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const map = {'name': 'John', 'age': 30};
  return map['name'];
}
''';
        final result = execute(code);
        expect(result, equals('John'));
      },
    );

    test(
      'I-EXPR-28: Const Map with typed declaration. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const Map<String, int> scores = {'Alice': 95, 'Bob': 87};
  return scores['Alice'];
}
''';
        final result = execute(code);
        expect(result, equals(95));
      },
    );

    test(
      'I-EXPR-29: Const Set with simple values. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const set = {1, 2, 3, 2, 1};
  return set.length;
}
''';
        final result = execute(code);
        expect(result, equals(3)); // Duplicates removed
      },
    );

    test(
      'I-EXPR-31: Const Set with typed declaration. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const Set<String> fruits = {'apple', 'banana', 'orange'};
  return fruits.contains('banana');
}
''';
        final result = execute(code);
        expect(result, equals(true));
      },
    );

    test(
      'I-EXPR-32: Const List with expressions. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const list = [1 + 1, 2 * 3, 10 - 5];
  return list[0] + list[1] + list[2];
}
''';
        final result = execute(code);
        expect(result, equals(2 + 6 + 5)); // 13
      },
    );

    test('I-EXPR-33: Const nested List. [2026-02-10 06:37] (PASS)', () {
      const code = '''
main() {
  const nested = [[1, 2], [3, 4], [5, 6]];
  return nested[1][0];
}
''';
      final result = execute(code);
      expect(result, equals(3));
    });

    test('I-EXPR-34: Const nested Map. [2026-02-10 06:37] (PASS)', () {
      const code = '''
main() {
  const data = {
    'user1': {'name': 'Alice', 'age': 25},
    'user2': {'name': 'Bob', 'age': 30}
  };
  return data['user1']['name'];
}
''';
      final result = execute(code);
      expect(result, equals('Alice'));
    });

    test(
      'I-EXPR-20: Const List with String concatenation. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const list = ['Hello' + ' ' + 'World', 'Dart'];
  return list[0];
}
''';
        final result = execute(code);
        expect(result, equals('Hello World'));
      },
    );

    test('I-EXPR-21: Const empty collections. [2026-02-10 06:37] (PASS)', () {
      const code = '''
main() {
  const emptyList = <int>[];
  const emptyMap = <String, int>{};
  const emptySet = <double>{};
  
  return emptyList.length + emptyMap.length + emptySet.length;
}
''';
      final result = execute(code);
      expect(result, equals(0));
    });

    test(
      'I-EXPR-22: Const with conditional expression. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  const value = true ? 42 : 0;
  return value;
}
''';
        final result = execute(code);
        expect(result, equals(42));
      },
    );

    test(
      'I-EXPR-23: Const List with const keyword on literal. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  // Test with const directly on the literal
  final list = const [1, 2, 3];
  return list.length;
}
''';
        final result = execute(code);
        expect(result, equals(3));
      },
    );

    test(
      'I-EXPR-24: Const Map with const keyword on literal. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  final map = const {'key': 'value', 'key2': 'value2'};
  return map.length;
}
''';
        final result = execute(code);
        expect(result, equals(2));
      },
    );

    test(
      'I-EXPR-25: Const Set with const keyword on literal. [2026-02-10 06:37] (PASS)',
      () {
        const code = '''
main() {
  final set = const {1, 2, 3};
  return set.length;
}
''';
        final result = execute(code);
        expect(result, equals(3));
      },
    );

    test(
      'I-EXPR-31: Const Set literal canonicalizes to one instance (T3). [2026-06-09 00:00] (PASS)',
      () {
        // A const set literal is a compile-time constant; evaluating the same
        // literal node twice must return the identical canonical instance
        // (matching real Dart). T3 caches the evaluated const literal so the
        // interpreter no longer re-allocates a fresh UnmodifiableSetView per
        // visit. Guards the canonicalization cache in visitSetOrMapLiteral.
        const code = '''
Set<int> makeSet() => const {1, 2, 3};
main() {
  final a = makeSet();
  final b = makeSet();
  return identical(a, b);
}
''';
        final result = execute(code);
        expect(result, isTrue);
      },
    );

    test(
      'I-EXPR-32: Const Map literal canonicalizes to one instance (T3). [2026-06-09 00:00] (PASS)',
      () {
        const code = '''
Map<String, int> makeMap() => const {'a': 1, 'b': 2};
main() {
  final a = makeMap();
  final b = makeMap();
  return identical(a, b);
}
''';
        final result = execute(code);
        expect(result, isTrue);
      },
    );

    test(
      'I-EXPR-33: Non-const set literal still allocates fresh instances (T3). [2026-06-09 00:00] (PASS)',
      () {
        // The cache must apply ONLY to const literals — a plain set literal is
        // mutable and identity-distinct on each evaluation.
        const code = '''
Set<int> makeSet() => {1, 2, 3};
main() {
  final a = makeSet();
  final b = makeSet();
  return identical(a, b);
}
''';
        final result = execute(code);
        expect(result, isFalse);
      },
    );

    test(
      'I-EXPR-34: Cached const set remains unmodifiable (T3). [2026-06-09 00:00] (PASS)',
      () {
        // Sharing one instance across hits is safe because const collections are
        // unmodifiable; attempting to mutate the cached view must still throw.
        const code = '''
main() {
  final set = const {1, 2, 3};
  try {
    set.add(4);
    return 'mutated';
  } catch (e) {
    return 'threw';
  }
}
''';
        final result = execute(code);
        expect(result, equals('threw'));
      },
    );
  });
}
