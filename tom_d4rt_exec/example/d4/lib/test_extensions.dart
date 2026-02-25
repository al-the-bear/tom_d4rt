/// Test extensions on core types for D4rt bridge generation.
///
/// This file tests the generator's handling of:
/// - Extensions on dart:core types (String, int, List, etc.)
/// - Callback parameters with non-nullable function types
library;

// =============================================================================
// Extensions on dart:core String
// =============================================================================

/// Extension on String to test core type handling.
extension StringExtension on String {
  /// Reverses the string.
  String get reversed => split('').reversed.join();
  
  /// Checks if string is blank (empty or only whitespace).
  bool get isBlank => trim().isEmpty;
  
  /// Checks if string is not blank.
  bool get isNotBlank => !isBlank;
  
  /// Wraps the string in parentheses.
  String get inParens => '($this)';
  
  /// Repeats the string n times with separator.
  String repeatWith(int times, {String separator = ''}) {
    if (times <= 0) return '';
    return List.filled(times, this).join(separator);
  }
}

// =============================================================================
// Extensions on dart:core int
// =============================================================================

/// Extension on int to test numeric core type handling.
extension IntExtension on int {
  /// Checks if the number is even.
  bool get isEven => this % 2 == 0;
  
  /// Checks if the number is odd.
  bool get isOdd => this % 2 != 0;
  
  /// Returns the factorial of the number.
  int get factorial {
    if (this < 0) throw ArgumentError('Cannot compute factorial of negative number');
    if (this <= 1) return 1;
    return this * (this - 1).factorial;
  }
  
  /// Clamps the value between min and max.
  int clampTo(int min, int max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
}

// =============================================================================
// Extensions on dart:core List
// =============================================================================

/// Extension on `List<T>` to test generic core type handling.
extension ListExtension<T> on List<T> {
  /// Returns the first element or null if empty.
  T? get firstOrNull => isEmpty ? null : first;
  
  /// Returns the last element or null if empty.
  T? get lastOrNull => isEmpty ? null : last;
  
  /// Returns true if the list has exactly one element.
  bool get isSingle => length == 1;
}

// =============================================================================
// Functions with callback parameters
// =============================================================================

/// Processes items with a required callback.
/// Tests non-nullable callback parameter handling.
List<R> processItems<T, R>(
  List<T> items,
  R Function(T item) transform,
) {
  return items.map(transform).toList();
}

/// Processes items with an optional callback.
/// Tests nullable callback parameter handling.
List<T> filterItems<T>(
  List<T> items, {
  bool Function(T item)? predicate,
}) {
  if (predicate == null) return items;
  return items.where(predicate).toList();
}

/// Prompts with a custom prompt function (tests dcli-like pattern).
/// The customPrompt parameter has a default value but is a function type.
String promptUser(
  String message, {
  String Function(String prompt, String? defaultValue, bool required)? customPrompt,
  String? defaultValue,
  bool required = true,
}) {
  if (customPrompt != null) {
    return customPrompt(message, defaultValue, required);
  }
  // Default behavior
  final suffix = required ? ' (required)' : '';
  final defaultSuffix = defaultValue != null ? ' [$defaultValue]' : '';
  return '$message$suffix$defaultSuffix: ';
}

// =============================================================================
// Test class with callback constructor parameter
// =============================================================================

/// A processor class with callback parameter in constructor.
class ItemProcessor<T> {
  /// The transformation function.
  final T Function(T) transform;
  
  /// Creates an ItemProcessor with the given transform function.
  ItemProcessor(this.transform);
  
  /// Creates an ItemProcessor that returns items unchanged.
  ItemProcessor.identity() : transform = ((T x) => x);
  
  /// Processes a single item.
  T process(T item) => transform(item);
  
  /// Processes a list of items.
  List<T> processAll(List<T> items) => items.map(transform).toList();
}

// =============================================================================
// Simple test class for basic bridging
// =============================================================================

/// A simple point class for testing basic bridging.
/// Named TestPoint to avoid collision with dart:math Point.
class TestPoint {
  /// The x coordinate.
  final int x;
  
  /// The y coordinate.
  final int y;
  
  /// Creates a new point.
  const TestPoint(this.x, this.y);
  
  /// Creates the origin point.
  const TestPoint.origin() : x = 0, y = 0;
  
  /// Returns the distance from origin.
  double get distanceFromOrigin => (x * x + y * y).toDouble();
  
  /// Adds another point.
  TestPoint operator +(TestPoint other) => TestPoint(x + other.x, y + other.y);
  
  /// Returns a string representation.
  @override
  String toString() => 'TestPoint($x, $y)';
}
