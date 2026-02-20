/// A 2D vector class that needs operator overrides via UserBridge.
///
/// The bridge generator cannot always handle operator overloading correctly,
/// so we provide a [Vector2DUserBridge] with manual operator implementations.
library;

/// A 2D vector with arithmetic operators.
class Vector2D {
  final double x;
  final double y;

  /// Create a vector from x and y components.
  Vector2D(this.x, this.y);

  /// Create a zero vector.
  Vector2D.zero()
      : x = 0,
        y = 0;

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

  /// Get the magnitude (length) of the vector.
  double get magnitude {
    // Simple sqrt via Newton's method
    final n = x * x + y * y;
    if (n <= 0) return 0;
    var guess = n / 2;
    for (var i = 0; i < 20; i++) {
      guess = (guess + n / guess) / 2;
    }
    return guess;
  }

  /// Get a normalized version of this vector.
  Vector2D get normalized {
    final mag = magnitude;
    if (mag == 0) return Vector2D(0, 0);
    return Vector2D(x / mag, y / mag);
  }

  /// Dot product with another vector.
  double dot(Vector2D other) => x * other.x + y * other.y;

  /// Scale this vector by a factor.
  Vector2D scale(double factor) => Vector2D(x * factor, y * factor);

  @override
  String toString() => 'Vector2D($x, $y)';
}
