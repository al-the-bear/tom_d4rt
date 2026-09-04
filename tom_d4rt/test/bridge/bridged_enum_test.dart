import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

// 1. Define a simple native enum
enum NativeColor { red, green, blue }

// 2. Define a complex native enum
enum ComplexEnum {
  itemA('Data A', 10),
  itemB('Data B', 20);

  final String data;
  final int number;
  const ComplexEnum(this.data, this.number);

  String get info => '$data-$number';
  int multiply(int factor) => number * factor;
  bool isItemA() => this == ComplexEnum.itemA;
}

// 3. Enum with operator overloads (`&`, `|`, `~`). Mirrors Flutter's
// `WidgetState`, which gains `&`/`|`/`~` from the `WidgetStateOperators` mixin
// and is bridged as an enum carrying operator adapters. The operators return a
// String representation so the result is inspectable from interpreted code
// without a separate bridged result class.
enum FlagState {
  alpha,
  beta,
  gamma;

  String operator &(Object other) => '($name & ${_repr(other)})';
  String operator |(Object other) => '($name | ${_repr(other)})';
  String operator ~() => '(~$name)';

  static String _repr(Object other) =>
      other is FlagState ? other.name : other.toString();
}

// 4. Enum with a STATIC factory method. Mirrors the `PageFormat.fromString`
// shape from GitHub issue #2: a `static PageFormat fromString(String name)`
// on the enum must be reachable as `EnumType.fromString(args)` from
// interpreted code.
enum SizeEnum {
  small,
  medium,
  large;

  static SizeEnum fromString(String name) => SizeEnum.values.firstWhere(
    (e) => e.name == name,
    orElse: () => SizeEnum.small,
  );

  static SizeEnum get largest => SizeEnum.large;
}

void main() {
  group('Bridged Enum Tests - Static methods (issue #2)', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
      final sizeDefinition = BridgedEnumDefinition<SizeEnum>(
        name: 'SizeEnum',
        values: SizeEnum.values,
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) =>
              SizeEnum.fromString(positional[0] as String),
        },
        staticGetters: {'largest': () => SizeEnum.largest},
      );
      interpreter.registerBridgedEnum(sizeDefinition, 'package:test/size.dart');
    });

    test('I-ENUM-STATIC-1: call static method on bridged enum', () {
      final code = '''
        import 'package:test/size.dart';
        main() => SizeEnum.fromString('medium');
      ''';
      final result = interpreter.execute(source: code);
      expect(result, equals(SizeEnum.medium));
    });

    test('I-ENUM-STATIC-2: static method result feeds back into script', () {
      final code = '''
        import 'package:test/size.dart';
        main() {
          var s = SizeEnum.fromString('large');
          return s.index;
        }
      ''';
      final result = interpreter.execute(source: code);
      expect(result, equals(2));
    });

    test('I-ENUM-STATIC-3: static getter still resolves alongside methods', () {
      final code = '''
        import 'package:test/size.dart';
        main() => SizeEnum.largest;
      ''';
      final result = interpreter.execute(source: code);
      expect(result, equals(SizeEnum.large));
    });
  });

  group('Bridged Enum Tests - Simple', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
      // Register the simple enum
      final colorDefinition = BridgedEnumDefinition<NativeColor>(
        name: 'BridgedColor',
        values: NativeColor.values,
        // No adapters for the simple enum initially
      );
      interpreter.registerBridgedEnum(
        colorDefinition,
        'package:test/color.dart',
      );
    });

    test(
      'I-ENUM-13: Register and access bridged enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        var color = BridgedColor.green;
        main() { return color; }
      ''';
        final result = interpreter.execute(source: code);
        final value = result as NativeColor;
        expect(value.name, equals('green'));
        expect(value.index, equals(1));
        expect(value, equals(NativeColor.green));
      },
    );

    test(
      'I-ENUM-14: Access standard property (.index) on bridged enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        main() { return BridgedColor.blue.index; }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals(2));
      },
    );

    test(
      'I-ENUM-15: Access toString() on bridged enum value via get. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        main() {
          var color = BridgedColor.red;
          return color.toString(); // Should return 'BridgedColor.red'
        }
      ''';
        final result = interpreter.execute(source: code);
        // Ensure that the get() implementation returns the expected string
        expect(result, equals('BridgedColor.red'));
      },
    );

    test(
      'I-ENUM-16: Call toString() method on bridged enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
         main() {
           var color = BridgedColor.blue;
           return color.toString();
         }
       ''';
        final result = interpreter.execute(source: code);
        expect(result, equals('BridgedColor.blue'));
      },
    );

    test(
      'I-ENUM-17: Compare bridged enum values. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        main() {
          var c1 = BridgedColor.green;
          var c2 = BridgedColor.blue;
          var c3 = BridgedColor.green;
          return [c1 == c2, c1 == c3, c1 != c2];
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals([false, true, true]));
      },
    );

    test(
      'I-ENUM-18: Access .values static getter on bridged enum. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        main() {
          var vals = BridgedColor.values;
          return vals.length;
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals(3)); // red, green, blue
      },
    );

    test('I-ENUM-19: toString() on a bridged enum TYPE via runtimeType. (RCJ12)', () {
      // Reproduces flutter_extended_23 (dropdown_menu_close_behavior): a script
      // does `v.runtimeType.toString()` where `v` is a bridged enum value.
      // `v.runtimeType` yields the enum TYPE (a BridgedEnum), and calling
      // toString() on the TYPE previously misresolved as a static-method lookup
      // and threw "Undefined static method 'toString' on bridged enum". Dart's
      // Type.toString() returns the type name, so this must yield 'BridgedColor'.
      final code = '''
        import 'package:test/color.dart';
        main() {
          var color = BridgedColor.green;
          return color.runtimeType.toString();
        }
      ''';
      final result = interpreter.execute(source: code);
      expect(result, equals('BridgedColor'));
    });

    test(
      'I-ENUM-1: Access .values and index into it. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        main() {
          return BridgedColor.values[0].name;
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals('red'));
      },
    );

    test(
      'I-ENUM-2: Iterate .values with for-in. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/color.dart';
        main() {
          var names = <String>[];
          for (var c in BridgedColor.values) {
            names.add(c.name);
          }
          return names;
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals(['red', 'green', 'blue']));
      },
    );
  });

  group('Bridged Enum Tests - Complex', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();

      // Define the adapters for ComplexEnum
      final complexEnumDefinition = BridgedEnumDefinition<ComplexEnum>(
        name: 'MyComplexEnum', // Name in the interpreter
        values: ComplexEnum.values,
        getters: {
          // Accessor for the 'data' field
          'data': (InterpreterVisitor? visitor, Object target) {
            if (target is ComplexEnum) {
              return target.data; // Return the native value
            }
            throw Exception('Target is not ComplexEnum');
          },
          // Accessor for the 'number' field
          'number': (InterpreterVisitor? visitor, Object target) {
            if (target is ComplexEnum) {
              return target.number;
            }
            throw Exception('Target is not ComplexEnum');
          },
          // Accessor for the 'info' getter
          'info': (InterpreterVisitor? visitor, Object target) {
            if (target is ComplexEnum) {
              return target.info; // Call the native getter
            }
            throw Exception('Target is not ComplexEnum');
          },
        },
        methods: {
          // Adapter for the 'multiply' method
          'multiply':
              (
                InterpreterVisitor visitor,
                Object target,
                List<Object?> positionalArgs,
                Map<String, Object?> namedArgs,
                typeArgs,
              ) {
                if (target is ComplexEnum &&
                    positionalArgs.length == 1 &&
                    positionalArgs[0] is int) {
                  final factor = positionalArgs[0] as int;
                  return target.multiply(factor); // Calls the native method
                }
                // Provide a more specific error message
                String errorDetails;
                if (target is! ComplexEnum) {
                  errorDetails =
                      'Target is not ComplexEnum (${target.runtimeType})';
                } else if (positionalArgs.length != 1) {
                  errorDetails =
                      'Expected 1 argument, got ${positionalArgs.length}';
                } else {
                  errorDetails =
                      'Argument must be an integer, got ${positionalArgs[0]?.runtimeType}';
                }
                throw ArgumentError(
                  'Invalid arguments for multiply: $errorDetails',
                );
              },
          // Adapter for the 'isItemA' method
          'isItemA':
              (
                InterpreterVisitor visitor,
                Object target,
                List<Object?> positionalArgs,
                Map<String, Object?> namedArgs,
                typeArgs,
              ) {
                if (target is ComplexEnum &&
                    positionalArgs.isEmpty &&
                    namedArgs.isEmpty) {
                  return target.isItemA(); // Calls the native method
                }
                throw ArgumentError(
                  'Invalid arguments for isItemA: Expected 0 arguments',
                );
              },
          // Adapter for 'toString'
          // This adapter will be used by invoke() if we do item.toString()
          'toString':
              (
                InterpreterVisitor visitor,
                Object target,
                List<Object?> positionalArgs,
                Map<String, Object?> namedArgs,
                typeArgs,
              ) {
                if (target is ComplexEnum &&
                    positionalArgs.isEmpty &&
                    namedArgs.isEmpty) {
                  // We could return target.toString() if the native enum overrides it,
                  // but for consistency with simple enums, let's return the bridged name.
                  return 'MyComplexEnum.${target.name}';
                }
                throw ArgumentError('Invalid arguments for toString');
              },
        },
      );

      // Register the complex definition
      interpreter.registerBridgedEnum(
        complexEnumDefinition,
        'package:test/complex_enum.dart',
      );
    });

    test('I-ENUM-3: Access complex enum value. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        import 'package:test/complex_enum.dart';
        main() { return MyComplexEnum.itemB; }
      ''';
      final result = interpreter.execute(source: code);
      final bridgedValue = result as ComplexEnum;
      expect(bridgedValue.name, equals('itemB'));
      expect(bridgedValue.index, equals(1));
      expect(bridgedValue, equals(ComplexEnum.itemB));
    });

    test(
      'I-ENUM-4: Access field on complex enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
        main() {
          var item = MyComplexEnum.itemA;
          return item.data; // Access the 'data' field
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals('Data A'));
      },
    );

    test(
      'I-ENUM-5: Access getter on complex enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
        main() {
          var item = MyComplexEnum.itemB;
          return item.info; // Access the 'info' getter
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals('Data B-20'));
      },
    );

    test(
      'I-ENUM-6: Call method with argument on complex enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
        main() {
          var item = MyComplexEnum.itemA;
          return item.multiply(5); // Call the 'multiply' method
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals(50)); // 10 * 5
      },
    );

    test(
      'I-ENUM-7: Call method without argument on complex enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
        main() {
          var item1 = MyComplexEnum.itemA;
          var item2 = MyComplexEnum.itemB;
          return [item1.isItemA(), item2.isItemA()]; // Appel de 'isItemA'
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals([true, false]));
      },
    );

    test(
      'I-ENUM-8: Call toString() method on complex enum value. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
         main() {
           var item = MyComplexEnum.itemA;
           return item.toString();
         }
       ''';
        final result = interpreter.execute(source: code);
        expect(result, equals('MyComplexEnum.itemA'));
      },
    );

    test(
      'I-ENUM-9: Compare complex bridged enum values. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
        main() {
          var v1 = MyComplexEnum.itemA;
          var v2 = MyComplexEnum.itemB;
          var v3 = MyComplexEnum.itemA;
          return [v1 == v2, v1 == v3, v1 != v2];
        }
      ''';
        final result = interpreter.execute(source: code);
        expect(result, equals([false, true, true]));
      },
    );

    test(
      'I-ENUM-10: Error on calling non-existent method. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
         main() {
           var item = MyComplexEnum.itemA;
           return item.nonExistentMethod();
         }
       ''';
        expect(
          () => interpreter.execute(source: code),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              contains('Method "nonExistentMethod" not found'),
            ),
          ),
        );
      },
    );

    test(
      'I-ENUM-11: Error on accessing non-existent property. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
         main() {
           var item = MyComplexEnum.itemB;
           return item.nonExistentProp;
         }
       ''';
        expect(
          () => interpreter.execute(source: code),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              contains('Property "nonExistentProp" not found'),
            ),
          ),
        );
      },
    );

    test(
      'I-ENUM-12: Error on calling method with wrong arguments. [2026-02-10 06:37] (PASS)',
      () {
        final code = '''
        import 'package:test/complex_enum.dart';
         main() {
           var item = MyComplexEnum.itemA;
           return item.multiply('wrong_type'); // Argument invalide
         }
       ''';
        expect(
          () => interpreter.execute(source: code),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              contains('Error executing bridged method "multiply"'),
            ),
          ),
        );
      },
    );
  });

  group('Bridged Enum Tests - Operator overloads (GEN-WidgetState)', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
      final flagDefinition = BridgedEnumDefinition<FlagState>(
        name: 'FlagState',
        values: FlagState.values,
        methods: {
          '&': (visitor, target, positional, named, typeArgs) =>
              (target as FlagState) & positional[0]!,
          '|': (visitor, target, positional, named, typeArgs) =>
              (target as FlagState) | positional[0]!,
          '~': (visitor, target, positional, named, typeArgs) =>
              ~(target as FlagState),
        },
      );
      interpreter.registerBridgedEnum(flagDefinition, 'package:test/flag.dart');
    });

    test('I-ENUM-OP-1: binary & on two bridged enum values', () {
      final code = '''
        import 'package:test/flag.dart';
        main() => FlagState.alpha & FlagState.beta;
      ''';
      expect(interpreter.execute(source: code), equals('(alpha & beta)'));
    });

    test('I-ENUM-OP-2: binary | on two bridged enum values', () {
      final code = '''
        import 'package:test/flag.dart';
        main() => FlagState.alpha | FlagState.gamma;
      ''';
      expect(interpreter.execute(source: code), equals('(alpha | gamma)'));
    });

    test('I-ENUM-OP-3: unary ~ on a bridged enum value', () {
      final code = '''
        import 'package:test/flag.dart';
        main() => ~FlagState.beta;
      ''';
      expect(interpreter.execute(source: code), equals('(~beta)'));
    });

    test('I-ENUM-OP-4: combined & with unary ~ right operand', () {
      final code = '''
        import 'package:test/flag.dart';
        main() => FlagState.alpha & ~FlagState.beta;
      ''';
      expect(interpreter.execute(source: code), equals('(alpha & (~beta))'));
    });

    test('I-ENUM-OP-5: bitwise operators as Map literal keys', () {
      // The exact failing shape from flutter_extended_20: WidgetStateMapper
      // builds `<WidgetStatesConstraint, T>{ WidgetState.x & y: ... }`.
      final code = '''
        import 'package:test/flag.dart';
        main() {
          final m = {
            FlagState.alpha & FlagState.beta: 'first',
            ~FlagState.gamma: 'second',
          };
          return m.values.toList();
        }
      ''';
      expect(interpreter.execute(source: code), equals(['first', 'second']));
    });
  });
}
