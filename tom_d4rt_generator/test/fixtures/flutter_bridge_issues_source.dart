/// Test fixture for Flutter bridge issues found during essential classes testing.
///
/// Issues reproduced:
/// 1. BridgedInstance<Object> not unwrapping to Color/Offset
/// 2. Map<String, Function> type parameters not converting
/// 3. Missing hashCode/runtimeType on bridged classes
/// 4. Missing static const members on abstract classes (Curves pattern)
/// 5. TickerProvider interface not recognized (vsync parameter)
library;

// =============================================================================
// ISSUE 1: BridgedInstance unwrapping for native types
// Paint.color expects Color, but receives BridgedInstance<Object>
// =============================================================================

/// Simple color class similar to dart:ui Color.
class Color {
  final int value;

  const Color(this.value);

  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF00FF00);
  static const Color blue = Color(0xFF0000FF);
}

/// Simple offset class similar to dart:ui Offset.
class Offset {
  final double dx;
  final double dy;

  const Offset(this.dx, this.dy);

  static const Offset zero = Offset(0, 0);
}

/// Class that takes native types as parameters (like Paint).
class Paint {
  Color? _color;
  double _strokeWidth = 1.0;

  /// Property that accepts Color - should unwrap BridgedInstance<Color>.
  Color? get color => _color;
  set color(Color? value) => _color = value;

  /// Property that accepts double.
  double get strokeWidth => _strokeWidth;
  set strokeWidth(double value) => _strokeWidth = value;

  /// Constructor with optional color.
  Paint({Color? color, double strokeWidth = 1.0})
    : _color = color,
      _strokeWidth = strokeWidth;
}

/// Widget with Offset parameter.
class PositionedBox {
  final Offset position;
  final double width;
  final double height;

  const PositionedBox({
    required this.position,
    this.width = 100,
    this.height = 100,
  });
}

// =============================================================================
// ISSUE 2: Map<String, Function> type parameters
// Routes map with function values not converting InterpretedFunction
// =============================================================================

/// Placeholder for BuildContext.
class BuildContext {}

/// Placeholder for Widget.
abstract class Widget {
  const Widget();
}

/// Simple widget implementation.
class Text extends Widget {
  final String data;
  Text(this.data);
}

/// Typedef for route builder.
typedef WidgetBuilder = Widget Function(BuildContext context);

/// Class with Map<String, WidgetBuilder> parameter (like MaterialApp.routes).
class AppWithRoutes {
  final Map<String, WidgetBuilder>? routes;
  final Widget? home;

  AppWithRoutes({this.routes, this.home});

  /// Navigate to a route.
  Widget? buildRoute(String name, BuildContext context) {
    final builder = routes?[name];
    return builder?.call(context);
  }
}

/// Class with Map<CustomAction, VoidCallback> parameter (like Semantics).
class CustomAction {
  final String label;
  const CustomAction(this.label);
}

/// Class with complex map parameter.
class SemanticWidget {
  final Map<CustomAction, void Function()>? customActions;

  SemanticWidget({this.customActions});
}

// =============================================================================
// ISSUE 3: Missing hashCode/runtimeType on bridged classes
// UniqueKey.hashCode and instance.runtimeType not bridged
// =============================================================================

/// Key class with hashCode override.
abstract class Key {
  const Key();
}

/// UniqueKey must expose hashCode.
class UniqueKey extends Key {
  // ignore: hash_and_equals
  @override
  int get hashCode => super.hashCode; // Uses Object.hashCode

  /// runtimeType should also be accessible.
  @override
  Type get runtimeType => super.runtimeType;
}

/// ValueKey must expose hashCode and equality.
class ValueKey<T> extends Key {
  final T value;
  const ValueKey(this.value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ValueKey<T> && other.value == value);
}

// =============================================================================
// ISSUE 4: Abstract class with static const members (Curves pattern)
// "Undefined variable: Curves" - static members not accessible
// =============================================================================

/// Curve base class.
abstract class Curve {
  const Curve();
  double transform(double t);
}

/// Linear curve implementation.
class LinearCurve extends Curve {
  const LinearCurve();
  @override
  double transform(double t) => t;
}

/// Abstract class with static const members like Flutter's Curves.
abstract class Curves {
  /// Private constructor - cannot be instantiated.
  Curves._();

  /// Linear interpolation curve.
  static const Curve linear = LinearCurve();

  /// Ease-in curve (implemented as linear for simplicity).
  static const Curve easeIn = LinearCurve();

  /// Ease-out curve.
  static const Curve easeOut = LinearCurve();

  /// Factory to get curve by name.
  static Curve byName(String name) {
    switch (name) {
      case 'linear':
        return linear;
      case 'easeIn':
        return easeIn;
      case 'easeOut':
        return easeOut;
      default:
        return linear;
    }
  }
}

// =============================================================================
// ISSUE 5: Interface types (TickerProvider pattern)
// AnimationController expects TickerProvider, gets InterpretedInstance
// =============================================================================

/// Ticker callback type.
typedef TickerCallback = void Function(Duration elapsed);

/// Ticker interface.
abstract class Ticker {
  void start();
  void stop();
}

/// TickerProvider interface like Flutter's.
abstract interface class TickerProvider {
  Ticker createTicker(TickerCallback onTick);
}

/// Animation controller that requires TickerProvider.
class AnimationController {
  final TickerProvider vsync;
  final Duration? duration;
  double _value = 0.0;

  /// Constructor requires vsync parameter of interface type.
  AnimationController({required this.vsync, this.duration});

  double get value => _value;
  set value(double v) => _value = v.clamp(0.0, 1.0);

  void forward() {
    _value = 1.0;
  }

  void reverse() {
    _value = 0.0;
  }
}

// =============================================================================
// ISSUE 6: ChangeNotifier.hasListeners and addListener methods
// "Instance of 'CounterNotifier' has no method named 'addListener'"
// =============================================================================

/// Base ChangeNotifier class.
class ChangeNotifier {
  final List<void Function()> _listeners = [];

  /// Must be bridged - reported as missing.
  bool get hasListeners => _listeners.isNotEmpty;

  /// Must be bridged - reported as missing.
  void addListener(void Function() listener) => _listeners.add(listener);

  /// Must be bridged.
  void removeListener(void Function() listener) => _listeners.remove(listener);

  /// Notify all listeners.
  void notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Dispose and clear listeners.
  void dispose() => _listeners.clear();
}

/// ValueNotifier extends ChangeNotifier.
class ValueNotifier<T> extends ChangeNotifier {
  T _value;

  ValueNotifier(this._value);

  T get value => _value;
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}

// =============================================================================
// ISSUE 7: Required nullable callbacks
// ElevatedButton: required void Function()? onPressed
// The `required` means parameter must be PROVIDED, but `?` means null is valid
// Generator incorrectly rejects null for required nullable parameters
// =============================================================================

/// Button with required nullable callback (like Flutter's ElevatedButton).
/// The onPressed can be null to indicate disabled state.
class ElevatedButton extends Widget {
  final void Function()? onPressed;
  final Widget child;

  /// Required nullable callback - null means disabled.
  const ElevatedButton({required this.onPressed, required this.child});
}

/// Another button with required nullable onChanged.
class Switch extends Widget {
  final bool value;
  final void Function(bool)? onChanged;

  /// Required nullable callback - null means disabled.
  const Switch({required this.value, required this.onChanged});
}

/// Widget with multiple required nullable callbacks.
class FormField extends Widget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const FormField({this.onSaved, this.validator, this.onChanged});
}

/// Widget with required non-nullable callback for comparison.
class IconButton extends Widget {
  final void Function() onPressed;
  final Widget icon;

  /// Required non-nullable callback - must be provided and non-null.
  const IconButton({required this.onPressed, required this.icon});
}
