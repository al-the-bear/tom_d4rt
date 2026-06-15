/// A 2D vector — the foundational native type the scripts manipulate.
///
/// This is ordinary, compiled Dart. The bridge generator reads it (via the
/// package barrel) and emits a `BridgedClass` registration so D4rt scripts can
/// construct `Vector2`, read its fields, call its methods, and use its
/// operators — all without the script knowing it is talking to native code.
library;

import 'dart:math' as math;

/// An immutable 2D vector with the usual arithmetic.
class Vector2 {
  final double x;
  final double y;

  const Vector2(this.x, this.y);

  /// The zero vector.
  const Vector2.zero()
      : x = 0,
        y = 0;

  /// Vector addition (bridged as the `+` operator).
  Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);

  /// Vector subtraction (bridged as the `-` operator).
  Vector2 operator -(Vector2 other) => Vector2(x - other.x, y - other.y);

  /// Scalar multiplication (bridged as the `*` operator).
  Vector2 operator *(double scalar) => Vector2(x * scalar, y * scalar);

  /// The Euclidean length of this vector.
  double get magnitude => math.sqrt(x * x + y * y);

  /// A unit vector in the same direction (or zero if this is the zero vector).
  Vector2 normalized() {
    final m = magnitude;
    return m == 0 ? const Vector2.zero() : Vector2(x / m, y / m);
  }

  /// The dot product with [other].
  double dot(Vector2 other) => x * other.x + y * other.y;

  @override
  String toString() => 'Vector2(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})';
}
