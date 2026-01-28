import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Native class with operator overloads for testing
class Vector2 {
  final double x;
  final double y;

  Vector2(this.x, this.y);

  Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);
  Vector2 operator -(Vector2 other) => Vector2(x - other.x, y - other.y);
  Vector2 operator *(num scalar) => Vector2(x * scalar, y * scalar);
  Vector2 operator /(num scalar) => Vector2(x / scalar, y / scalar);
  Vector2 operator -() => Vector2(-x, -y);

  @override
  bool operator ==(Object other) =>
      other is Vector2 && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  double operator [](int index) {
    if (index == 0) return x;
    if (index == 1) return y;
    throw RangeError.index(index, this, 'index', null, 2);
  }

  @override
  String toString() => 'Vector2($x, $y)';
}

/// Native class with bitwise operators
class BitMask {
  final int value;

  BitMask(this.value);

  BitMask operator &(BitMask other) => BitMask(value & other.value);
  BitMask operator |(BitMask other) => BitMask(value | other.value);
  BitMask operator ^(BitMask other) => BitMask(value ^ other.value);
  BitMask operator ~() => BitMask(~value);
  BitMask operator <<(int shift) => BitMask(value << shift);
  BitMask operator >>(int shift) => BitMask(value >> shift);

  @override
  bool operator ==(Object other) =>
      other is BitMask && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'BitMask($value)';
}

/// Native class with comparison operators
class ComparableValue {
  final int value;

  ComparableValue(this.value);

  bool operator <(ComparableValue other) => value < other.value;
  bool operator >(ComparableValue other) => value > other.value;
  bool operator <=(ComparableValue other) => value <= other.value;
  bool operator >=(ComparableValue other) => value >= other.value;

  @override
  bool operator ==(Object other) =>
      other is ComparableValue && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ComparableValue($value)';
}

void main() {
  group('Bridged Operators', () {
    late D4rt interpreter;
    late BridgedClass vector2Bridge;
    late BridgedClass bitMaskBridge;
    late BridgedClass comparableBridge;

    setUp(() {
      interpreter = D4rt();

      vector2Bridge = BridgedClass(
        nativeType: Vector2,
        name: 'Vector2',
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final x = (positionalArgs[0] as num).toDouble();
            final y = (positionalArgs[1] as num).toDouble();
            return Vector2(x, y);
          },
        },
        getters: {
          'x': (visitor, target) => (target as Vector2).x,
          'y': (visitor, target) => (target as Vector2).y,
        },
        methods: {
          // Arithmetic operators
          '+': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final v = target as Vector2;
            final other = positionalArgs[0] as Vector2;
            return v + other;
          },
          '-': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final v = target as Vector2;
            final other = positionalArgs[0] as Vector2;
            return v - other;
          },
          '*': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final v = target as Vector2;
            final scalar = positionalArgs[0] as num;
            return v * scalar;
          },
          '/': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final v = target as Vector2;
            final scalar = positionalArgs[0] as num;
            return v / scalar;
          },
          // Index operator
          '[]': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final v = target as Vector2;
            final index = positionalArgs[0] as int;
            return v[index];
          },
          'toString': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            return (target as Vector2).toString();
          },
        },
      );

      bitMaskBridge = BridgedClass(
        nativeType: BitMask,
        name: 'BitMask',
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            return BitMask(positionalArgs[0] as int);
          },
        },
        getters: {
          'value': (visitor, target) => (target as BitMask).value,
        },
        methods: {
          // Bitwise operators
          '&': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final b = target as BitMask;
            final other = positionalArgs[0] as BitMask;
            return b & other;
          },
          '|': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final b = target as BitMask;
            final other = positionalArgs[0] as BitMask;
            return b | other;
          },
          '^': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final b = target as BitMask;
            final other = positionalArgs[0] as BitMask;
            return b ^ other;
          },
          '<<': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final b = target as BitMask;
            final shift = positionalArgs[0] as int;
            return b << shift;
          },
          '>>': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final b = target as BitMask;
            final shift = positionalArgs[0] as int;
            return b >> shift;
          },
          'toString': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            return (target as BitMask).toString();
          },
        },
      );

      comparableBridge = BridgedClass(
        nativeType: ComparableValue,
        name: 'ComparableValue',
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            return ComparableValue(positionalArgs[0] as int);
          },
        },
        getters: {
          'value': (visitor, target) => (target as ComparableValue).value,
        },
        methods: {
          // Comparison operators
          '<': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final c = target as ComparableValue;
            final other = positionalArgs[0] as ComparableValue;
            return c < other;
          },
          '>': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final c = target as ComparableValue;
            final other = positionalArgs[0] as ComparableValue;
            return c > other;
          },
          '<=': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final c = target as ComparableValue;
            final other = positionalArgs[0] as ComparableValue;
            return c <= other;
          },
          '>=': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final c = target as ComparableValue;
            final other = positionalArgs[0] as ComparableValue;
            return c >= other;
          },
          '==': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            final c = target as ComparableValue;
            final other = positionalArgs[0];
            if (other is ComparableValue) {
              return c == other;
            }
            return false;
          },
          'toString': (visitor, target, positionalArgs, namedArgs, typeArgs) {
            return (target as ComparableValue).toString();
          },
        },
      );

      interpreter.registerBridgedClass(vector2Bridge, 'package:test/vector.dart');
      interpreter.registerBridgedClass(bitMaskBridge, 'package:test/bitmask.dart');
      interpreter.registerBridgedClass(
          comparableBridge, 'package:test/comparable.dart');
    });

    group('arithmetic operators', () {
      test('operator + on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/vector.dart';
          
          main() {
            final v1 = Vector2(1.0, 2.0);
            final v2 = Vector2(3.0, 4.0);
            final sum = v1 + v2;
            return [sum.x, sum.y];
          }
        ''');

        expect(result, equals([4.0, 6.0]));
      });

      test('operator - on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/vector.dart';
          
          main() {
            final v1 = Vector2(5.0, 7.0);
            final v2 = Vector2(2.0, 3.0);
            final diff = v1 - v2;
            return [diff.x, diff.y];
          }
        ''');

        expect(result, equals([3.0, 4.0]));
      });

      test('operator * on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/vector.dart';
          
          main() {
            final v = Vector2(2.0, 3.0);
            final scaled = v * 2;
            return [scaled.x, scaled.y];
          }
        ''');

        expect(result, equals([4.0, 6.0]));
      });

      test('operator / on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/vector.dart';
          
          main() {
            final v = Vector2(6.0, 8.0);
            final divided = v / 2;
            return [divided.x, divided.y];
          }
        ''');

        expect(result, equals([3.0, 4.0]));
      });

      test('chained operators', () {
        final result = interpreter.execute(source: '''
          import 'package:test/vector.dart';
          
          main() {
            final v1 = Vector2(1.0, 1.0);
            final v2 = Vector2(2.0, 2.0);
            final v3 = Vector2(3.0, 3.0);
            final sum = v1 + v2 + v3;
            return [sum.x, sum.y];
          }
        ''');

        expect(result, equals([6.0, 6.0]));
      });
    });

    group('index operator', () {
      test('operator [] on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/vector.dart';
          
          main() {
            final v = Vector2(5.0, 10.0);
            return [v[0], v[1]];
          }
        ''');

        expect(result, equals([5.0, 10.0]));
      });
    });

    group('bitwise operators', () {
      test('operator & on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/bitmask.dart';
          
          main() {
            final a = BitMask(0xF0);
            final b = BitMask(0xFF);
            final result = a & b;
            return result.value;
          }
        ''');

        expect(result, equals(0xF0));
      });

      test('operator | on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/bitmask.dart';
          
          main() {
            final a = BitMask(0x0F);
            final b = BitMask(0xF0);
            final result = a | b;
            return result.value;
          }
        ''');

        expect(result, equals(0xFF));
      });

      test('operator ^ on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/bitmask.dart';
          
          main() {
            final a = BitMask(0xFF);
            final b = BitMask(0x0F);
            final result = a ^ b;
            return result.value;
          }
        ''');

        expect(result, equals(0xF0));
      });

      test('operator << on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/bitmask.dart';
          
          main() {
            final a = BitMask(1);
            final result = a << 4;
            return result.value;
          }
        ''');

        expect(result, equals(16));
      });

      test('operator >> on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/bitmask.dart';
          
          main() {
            final a = BitMask(16);
            final result = a >> 2;
            return result.value;
          }
        ''');

        expect(result, equals(4));
      });
    });

    group('comparison operators', () {
      test('operator < on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/comparable.dart';
          
          main() {
            final a = ComparableValue(5);
            final b = ComparableValue(10);
            return a < b;
          }
        ''');

        expect(result, equals(true));
      });

      test('operator > on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/comparable.dart';
          
          main() {
            final a = ComparableValue(10);
            final b = ComparableValue(5);
            return a > b;
          }
        ''');

        expect(result, equals(true));
      });

      test('operator <= on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/comparable.dart';
          
          main() {
            final a = ComparableValue(5);
            final b = ComparableValue(5);
            final c = ComparableValue(10);
            return [a <= b, a <= c];
          }
        ''');

        expect(result, equals([true, true]));
      });

      test('operator >= on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/comparable.dart';
          
          main() {
            final a = ComparableValue(10);
            final b = ComparableValue(10);
            final c = ComparableValue(5);
            return [a >= b, a >= c];
          }
        ''');

        expect(result, equals([true, true]));
      });

      test('operator == on bridged class', () {
        final result = interpreter.execute(source: '''
          import 'package:test/comparable.dart';
          
          main() {
            final a = ComparableValue(5);
            final b = ComparableValue(5);
            final c = ComparableValue(10);
            return [a == b, a == c];
          }
        ''');

        expect(result, equals([true, false]));
      });
    });
  });
}
