// GEN-074: Test fixture for type alias (typedef) bridging
// This file tests that type aliases pointing to classes are properly bridged

/// Base class that will be aliased
class WidgetStateProperty<T> {
  final T value;
  WidgetStateProperty(this.value);

  T resolve(Set<String> states) => value;

  static WidgetStateProperty<T> all<T>(T value) =>
      WidgetStateProperty<T>(value);

  static WidgetStateProperty<T?> resolveWith<T>(
          T? Function(Set<String> states) callback) =>
      _ResolveWithProperty<T>(callback);
}

class _ResolveWithProperty<T> extends WidgetStateProperty<T?> {
  final T? Function(Set<String> states) callback;

  _ResolveWithProperty(this.callback) : super(null);

  @override
  T? resolve(Set<String> states) => callback(states);
}

/// GEN-074: Type alias that should be bridged as an alias to WidgetStateProperty
typedef MaterialStateProperty<T> = WidgetStateProperty<T>;

/// GEN-074: Another alias pattern
typedef ButtonStateProperty<T> = WidgetStateProperty<T>;

/// Simple non-generic alias
class SimpleContainer {
  final String name;
  SimpleContainer(this.name);
}

typedef Box = SimpleContainer;
typedef Container = SimpleContainer;

/// GEN-074: Nested alias test - alias pointing to alias (should resolve to base)
typedef StateProperty<T> = MaterialStateProperty<T>;

/// Example class using the aliases
class ButtonTheme {
  final MaterialStateProperty<double?>? elevation;
  final ButtonStateProperty<Color?>? backgroundColor;

  ButtonTheme({
    this.elevation,
    this.backgroundColor,
  });
}

// Helper type for testing
class Color {
  final int value;
  Color(this.value);
}
