/// Test fixture for num type conversion in generated bridges.
///
/// Tests the following scenarios:
/// - Nullable double parameters (should accept int values)
/// - Nullable num parameters (should accept int/double)
/// - Required double parameters (should accept int values)
/// - Lists/Sets/Maps with double/num types
library;

// =============================================================================
// Simple class with nullable double parameters
// =============================================================================

/// A widget-like class with optional elevation parameter (like AppBar).
class ElevatedWidget {
  final double? elevation;
  final double? width;
  final double? height;

  /// Constructor with nullable double parameters.
  /// In Flutter, these often receive int literals like `elevation: 4`.
  const ElevatedWidget({this.elevation, this.width, this.height});
}

/// Class with required double parameter.
class SizedWidget {
  final double size;

  /// Must handle int→double promotion for required params.
  const SizedWidget({required this.size});
}

/// Class with required positional double parameter.
class PositionalDoubleWidget {
  final double value;

  /// Must handle int→double promotion for positional params.
  PositionalDoubleWidget(this.value);
}

// =============================================================================
// Class with num type parameters
// =============================================================================

/// Class that accepts num type (int or double).
class NumericWidget {
  final num? numeric;
  final num required_;

  NumericWidget(this.required_, {this.numeric});
}

// =============================================================================
// Class with double in collections
// =============================================================================

/// Class with List<double> parameter.
class DoubleListWidget {
  final List<double> values;
  final List<double>? optionalValues;

  DoubleListWidget(this.values, {this.optionalValues});
}

/// Class with Map containing double values.
class DoubleMapWidget {
  final Map<String, double> values;

  DoubleMapWidget(this.values);
}

// =============================================================================
// Abstract class with static members (like Curves)
// =============================================================================

/// Abstract class with static const members.
/// Similar to Flutter's Curves class.
abstract class Curves {
  /// Cannot be instantiated.
  Curves._();

  /// Linear curve.
  static const Curve linear = _LinearCurve._();

  /// Ease in curve.
  static const Curve easeIn = _EaseInCurve._();

  /// Ease out curve.
  static const Curve easeOut = _EaseOutCurve._();

  /// Ease in-out curve.
  static const Curve easeInOut = _EaseInOutCurve._();

  /// Bounce in curve.
  static Curve bounceIn() => const _BounceInCurve._();
}

/// Base curve type.
abstract class Curve {
  const Curve();

  /// Transform a value from 0.0 to 1.0.
  double transform(double t);
}

class _LinearCurve extends Curve {
  const _LinearCurve._();

  @override
  double transform(double t) => t;
}

class _EaseInCurve extends Curve {
  const _EaseInCurve._();

  @override
  double transform(double t) => t * t;
}

class _EaseOutCurve extends Curve {
  const _EaseOutCurve._();

  @override
  double transform(double t) => 1 - (1 - t) * (1 - t);
}

class _EaseInOutCurve extends Curve {
  const _EaseInOutCurve._();

  @override
  double transform(double t) => t < 0.5 ? 2 * t * t : 1 - 2 * (1 - t) * (1 - t);
}

class _BounceInCurve extends Curve {
  const _BounceInCurve._();

  @override
  double transform(double t) => 1 - _bounce(1 - t);

  double _bounce(double t) {
    if (t < 0.5) return 2 * t * t;
    return 1 - 2 * (1 - t) * (1 - t);
  }
}

// =============================================================================
// Generic class (like Tween<T>)
// =============================================================================

/// Generic class similar to Flutter's Tween.
abstract class Tween<T> {
  final T begin;
  final T end;

  Tween({required this.begin, required this.end});

  /// Interpolate between begin and end.
  T lerp(double t);
}

/// Specialized tween for double values.
class DoubleTween extends Tween<double> {
  DoubleTween({required super.begin, required super.end});

  @override
  double lerp(double t) => begin + (end - begin) * t;
}

/// Specialized tween for int values.
class IntTween extends Tween<int> {
  IntTween({required super.begin, required super.end});

  @override
  int lerp(double t) => (begin + (end - begin) * t).round();
}

// =============================================================================
// Class with methods to test method bridging
// =============================================================================

/// Class with various methods that should all be bridged.
class FullyBridgedClass {
  int _value = 0;

  /// Constructor.
  FullyBridgedClass([this._value = 0]);

  /// Getter - should be bridged.
  int get value => _value;

  /// Setter - should be bridged.
  set value(int v) => _value = v;

  /// Public method - should be bridged.
  void increment() => _value++;

  /// Method returning bool - should be bridged.
  bool get hasValue => _value > 0;

  /// Method taking callback - should be bridged.
  void withCallback(void Function(int) callback) => callback(_value);

  /// Static method - should be bridged.
  static FullyBridgedClass create() => FullyBridgedClass();

  /// Override of Object method - may need special handling.
  @override
  String toString() => 'FullyBridgedClass($_value)';

  /// runtimeType getter test - often missing.
  Type get myType => runtimeType;
}

/// ValueNotifier-like class to test hasListeners bridging.
class ValueNotifier<T> {
  T _value;
  final List<void Function()> _listeners = [];

  ValueNotifier(this._value);

  T get value => _value;
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      for (final listener in _listeners) {
        listener();
      }
    }
  }

  /// Should be bridged - this was reported as missing.
  bool get hasListeners => _listeners.isNotEmpty;

  void addListener(void Function() listener) => _listeners.add(listener);
  void removeListener(void Function() listener) => _listeners.remove(listener);
  void dispose() => _listeners.clear();
}
