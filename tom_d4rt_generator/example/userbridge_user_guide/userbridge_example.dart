/// UserBridge User Guide Example
///
/// Demonstrates the D4UserBridge pattern for creating custom overrides
/// when the generator cannot handle certain patterns automatically.
///
/// Common use cases:
/// - Operators ([], []=, +, -, etc.) with complex parameters
/// - Generic type handling
/// - Complex parameter validation
/// - Native type mappings (nativeNames)
///
/// Run with: dart run example/userbridge_user_guide/userbridge_example.dart
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

// =============================================================================
// Source Classes
// =============================================================================

/// A vector class that needs operator overrides.
class Vector2D {
  final double x;
  final double y;

  Vector2D(this.x, this.y);

  /// Vector addition.
  Vector2D operator +(Vector2D other) => Vector2D(x + other.x, y + other.y);

  /// Vector subtraction.
  Vector2D operator -(Vector2D other) => Vector2D(x - other.x, y - other.y);

  /// Scalar multiplication.
  Vector2D operator *(double scalar) => Vector2D(x * scalar, y * scalar);

  /// Unary negation.
  Vector2D operator -() => Vector2D(-x, -y);

  /// Equality check.
  @override
  bool operator ==(Object other) =>
      other is Vector2D && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  /// Get the magnitude of the vector.
  double get magnitude => _sqrt(x * x + y * y);

  /// Get a normalized version of this vector.
  Vector2D get normalized {
    final mag = magnitude;
    if (mag == 0) return Vector2D(0, 0);
    return Vector2D(x / mag, y / mag);
  }

  /// Dot product with another vector.
  double dot(Vector2D other) => x * other.x + y * other.y;

  @override
  String toString() => 'Vector2D($x, $y)';

  // Simple square root implementation
  double _sqrt(double n) {
    if (n <= 0) return 0;
    double guess = n / 2;
    for (int i = 0; i < 20; i++) {
      guess = (guess + n / guess) / 2;
    }
    return guess;
  }
}

/// A matrix class with index operators.
class Matrix2x2 {
  final List<List<double>> _data;

  Matrix2x2(double a, double b, double c, double d)
      : _data = [
          [a, b],
          [c, d]
        ];

  /// Get element at row, col.
  double operator [](List<int> indices) {
    return _data[indices[0]][indices[1]];
  }

  /// Set element at row, col.
  void operator []=(List<int> indices, double value) {
    _data[indices[0]][indices[1]] = value;
  }

  /// Get a row of the matrix.
  List<double> row(int index) => List.from(_data[index]);

  /// Get the determinant.
  double get determinant =>
      _data[0][0] * _data[1][1] - _data[0][1] * _data[1][0];

  @override
  String toString() => 'Matrix2x2([${_data[0]}, ${_data[1]}])';
}

// =============================================================================
// UserBridge Override Classes
// =============================================================================

/// User bridge overrides for Vector2D.
///
/// This demonstrates how to override operators that the generator
/// might not handle optimally, or when you need custom behavior.
class Vector2DUserBridge extends D4UserBridge {
  /// Override operator+
  static Object? overrideOperatorPlus(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
    return vec + other;
  }

  /// Override operator- (handles both binary subtraction and unary negation)
  ///
  /// The interpreter uses the same '-' key for both binary (v1 - v2) and unary (-v1)
  /// operations. For unary negation, positional will be empty.
  static Object? overrideOperatorMinus(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    // Check if this is unary (negation) or binary (subtraction)
    if (positional.isEmpty) {
      // Unary negation: -vector
      return -vec;
    } else {
      // Binary subtraction: vector1 - vector2
      final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
      return vec - other;
    }
  }

  /// Override operator* (scalar multiplication)
  static Object? overrideOperatorMultiply(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
    final scalar = D4.extractBridgedArg<double>(positional[0], 'scalar');
    return vec * scalar;
  }
}

/// User bridge overrides for Matrix2x2.
///
/// Demonstrates handling of complex index operators where the parameter
/// is a `List<int>` for multi-dimensional access.
class Matrix2x2UserBridge extends D4UserBridge {
  /// Override operator[] for index access.
  static Object? overrideOperatorIndex(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
    // D4rt passes a List for the indices - needs coercion
    final indices = D4.coerceList<int>(positional[0], 'indices');
    return matrix[indices];
  }

  /// Override operator[]= for index assignment.
  static Object? overrideOperatorIndexAssign(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
    final indices = D4.coerceList<int>(positional[0], 'indices');
    final value = D4.extractBridgedArg<double>(positional[1], 'value');
    matrix[indices] = value;
    return null;
  }
}

// =============================================================================
// Bridge Implementation with UserBridge Overrides
// =============================================================================

BridgedClass createVector2DBridge() {
  return BridgedClass(
    nativeType: Vector2D,
    name: 'Vector2D',
    constructors: {
      '': (visitor, positional, named) {
        final x = D4.getRequiredArg<double>(positional, 0, 'x', 'Vector2D');
        final y = D4.getRequiredArg<double>(positional, 1, 'y', 'Vector2D');
        return Vector2D(x, y);
      },
    },
    getters: {
      'x': (visitor, target) =>
          D4.validateTarget<Vector2D>(target, 'Vector2D').x,
      'y': (visitor, target) =>
          D4.validateTarget<Vector2D>(target, 'Vector2D').y,
      'magnitude': (visitor, target) =>
          D4.validateTarget<Vector2D>(target, 'Vector2D').magnitude,
      'normalized': (visitor, target) =>
          D4.validateTarget<Vector2D>(target, 'Vector2D').normalized,
    },
    methods: {
      // Operators using UserBridge overrides
      // Note: '-' handles both binary subtraction and unary negation
      '+': (visitor, target, positional, named, typeArgs) =>
          Vector2DUserBridge.overrideOperatorPlus(
              visitor, target, positional, named),
      '-': (visitor, target, positional, named, typeArgs) =>
          Vector2DUserBridge.overrideOperatorMinus(
              visitor, target, positional, named),
      '*': (visitor, target, positional, named, typeArgs) =>
          Vector2DUserBridge.overrideOperatorMultiply(
              visitor, target, positional, named),

      // Regular method
      'dot': (visitor, target, positional, named, typeArgs) {
        final vec = D4.validateTarget<Vector2D>(target, 'Vector2D');
        final other = D4.extractBridgedArg<Vector2D>(positional[0], 'other');
        return vec.dot(other);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        return D4.validateTarget<Vector2D>(target, 'Vector2D').toString();
      },
    },
  );
}

BridgedClass createMatrix2x2Bridge() {
  return BridgedClass(
    nativeType: Matrix2x2,
    name: 'Matrix2x2',
    constructors: {
      '': (visitor, positional, named) {
        final a = D4.getRequiredArg<double>(positional, 0, 'a', 'Matrix2x2');
        final b = D4.getRequiredArg<double>(positional, 1, 'b', 'Matrix2x2');
        final c = D4.getRequiredArg<double>(positional, 2, 'c', 'Matrix2x2');
        final d = D4.getRequiredArg<double>(positional, 3, 'd', 'Matrix2x2');
        return Matrix2x2(a, b, c, d);
      },
    },
    getters: {
      'determinant': (visitor, target) =>
          D4.validateTarget<Matrix2x2>(target, 'Matrix2x2').determinant,
    },
    methods: {
      // Index operators using UserBridge overrides
      '[]': (visitor, target, positional, named, typeArgs) =>
          Matrix2x2UserBridge.overrideOperatorIndex(
              visitor, target, positional, named),
      '[]=': (visitor, target, positional, named, typeArgs) =>
          Matrix2x2UserBridge.overrideOperatorIndexAssign(
              visitor, target, positional, named),

      'row': (visitor, target, positional, named, typeArgs) {
        final matrix = D4.validateTarget<Matrix2x2>(target, 'Matrix2x2');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'row');
        return matrix.row(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        return D4.validateTarget<Matrix2x2>(target, 'Matrix2x2').toString();
      },
    },
  );
}

// =============================================================================
// Demonstration
// =============================================================================

void main() async {
  print('UserBridge User Guide Example');
  print('=' * 60);

  final d4rt = D4rt();
  d4rt.registerBridgedClass(
      createVector2DBridge(), 'package:example/example.dart');
  d4rt.registerBridgedClass(
      createMatrix2x2Bridge(), 'package:example/example.dart');

  final script = '''
import 'package:example/example.dart';

void main() {
  // Vector operations
  final v1 = Vector2D(3.0, 4.0);
  final v2 = Vector2D(1.0, 2.0);
  
  print('Vector Operations:');
  print('  v1 = \$v1');
  print('  v2 = \$v2');
  print('  v1 + v2 = \${v1 + v2}');
  print('  v1 - v2 = \${v1 - v2}');
  print('  v1 * 2.0 = \${v1 * 2.0}');
  print('  -v1 = \${-v1}');
  print('  v1.magnitude = \${v1.magnitude}');
  print('  v1.normalized = \${v1.normalized}');
  print('  v1.dot(v2) = \${v1.dot(v2)}');
  
  // Matrix operations
  print('\\nMatrix Operations:');
  final m = Matrix2x2(1.0, 2.0, 3.0, 4.0);
  print('  m = \$m');
  print('  m[[0, 0]] = \${m[[0, 0]]}');
  print('  m[[0, 1]] = \${m[[0, 1]]}');
  print('  m[[1, 0]] = \${m[[1, 0]]}');
  print('  m[[1, 1]] = \${m[[1, 1]]}');
  print('  m.determinant = \${m.determinant}');
  print('  m.row(0) = \${m.row(0)}');
  print('  m.row(1) = \${m.row(1)}');
  
  // Modify matrix
  m[[0, 0]] = 10.0;
  print('\\nAfter m[[0, 0]] = 10.0:');
  print('  m = \$m');
  print('  m.determinant = \${m.determinant}');
}
''';

  print('\nExecuting script...\n');
  await d4rt.execute(source: script);

  print('\n${'=' * 60}');
  print('Example completed!');
}
