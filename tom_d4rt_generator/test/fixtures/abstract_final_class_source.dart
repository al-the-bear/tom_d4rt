/// Test fixture for Dart 3 abstract final classes
///
/// Tests the generator's handling of:
/// - abstract final class (like Flutter's Curves)
/// - final class (non-inheritable)
/// - base class (can only be extended in same library)
/// - interface class (can only be implemented)
library;

// =============================================================================
// Abstract final class pattern (like Flutter's Curves)
// Cannot be instantiated, cannot be extended
// =============================================================================

/// Base curve interface.
abstract class Curve {
  const Curve();
  double transform(double t);
}

/// Linear curve implementation.
class LinearCurve extends Curve {
  const LinearCurve._();
  @override
  double transform(double t) => t;
}

/// Exponential curve implementation.
class ExponentialCurve extends Curve {
  final double exponent;
  const ExponentialCurve._(this.exponent);
  @override
  double transform(double t) => (t == 0.0)
      ? 0.0
      : t == 1.0
      ? 1.0
      : t;
}

/// Abstract final class with only static members - like Flutter's Curves.
/// No constructor, no instance members - only static const values.
abstract final class Curves {
  /// Linear interpolation curve.
  static const Curve linear = LinearCurve._();

  /// Fast curve (exponential).
  static const Curve fast = ExponentialCurve._(2.0);

  /// Slow curve (exponential).
  static const Curve slow = ExponentialCurve._(0.5);

  /// Get curve by name.
  static Curve byName(String name) {
    switch (name) {
      case 'linear':
        return linear;
      case 'fast':
        return fast;
      case 'slow':
        return slow;
      default:
        return linear;
    }
  }
}

// =============================================================================
// Final class pattern - non-inheritable but instantiable
// =============================================================================

/// A final class cannot be extended outside its library.
final class FinalPoint {
  final double x;
  final double y;

  const FinalPoint(this.x, this.y);

  static const FinalPoint origin = FinalPoint(0, 0);

  double distanceTo(FinalPoint other) {
    final dx = other.x - x;
    final dy = other.y - y;
    return (dx * dx + dy * dy);
  }
}

// =============================================================================
// Interface class pattern - can only be implemented, not extended
// =============================================================================

/// An interface class can be implemented but not extended.
/// Using abstract interface class to allow abstract methods.
abstract interface class Drawable {
  void draw();
}

/// A class implementing the interface.
class Circle implements Drawable {
  final double radius;
  Circle(this.radius);

  @override
  void draw() {
    // Draw implementation
  }
}

// =============================================================================
// Base class pattern - can only be extended in this library
// =============================================================================

/// A base class can only be extended within this library.
base class BaseWidget {
  final String name;
  BaseWidget(this.name);

  void build() {
    // Build implementation
  }
}

/// A mixin class that can be used with 'with'.
base mixin class Loggable {
  void log(String message) {
    print(message);
  }
}
