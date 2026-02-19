import 'test_helpers.dart';
import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';

// Simple test enum
enum _Color { red, green, blue }

void main() {
  group('INTER-005: BridgedEnumValue comparison operators', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt(parseSourceCallback: parseSource)..setDebug(false);

      // Register the Color enum bridge
      d4rt.registerBridgedEnum(
        BridgedEnumDefinition(
          name: 'Color',
          values: _Color.values,
        ),
        'package:test_lib/test_lib.dart',
      );
    });

    test(
        'I-ENUM-1: == between two identical enum constants returns true. [2026-02-10] (PASS)',
        () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              final a = Color.red;
              final b = Color.red;
              return a == b;
            }
          ''',
        },
      );
      expect(result, isTrue);
    });

    test(
        'I-ENUM-2: != between two different enum constants returns true. [2026-02-10] (PASS)',
        () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              final a = Color.red;
              final b = Color.blue;
              return a != b;
            }
          ''',
        },
      );
      expect(result, isTrue);
    });

    test(
        'I-ENUM-3: != between two identical enum constants returns false. [2026-02-10] (PASS)',
        () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              final a = Color.green;
              final b = Color.green;
              return a != b;
            }
          ''',
        },
      );
      expect(result, isFalse);
    });

    test(
        'I-ENUM-4: == between different enum constants returns false. [2026-02-10] (PASS)',
        () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              return Color.red == Color.blue;
            }
          ''',
        },
      );
      expect(result, isFalse);
    });

    test(
        'I-ENUM-5: Enum comparison in if-statement works. [2026-02-10] (PASS)',
        () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              final c = Color.green;
              if (c == Color.green) {
                return 'match';
              }
              return 'no match';
            }
          ''',
        },
      );
      expect(result, equals('match'));
    });

    test(
        'I-ENUM-6: Enum != in if-statement works. [2026-02-10] (PASS)',
        () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              final c = Color.red;
              if (c != Color.blue) {
                return 'different';
              }
              return 'same';
            }
          ''',
        },
      );
      expect(result, equals('different'));
    });
  });
}
