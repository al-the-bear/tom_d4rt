/// Global function and variable examples for bridge generation testing.
/// 
/// This file demonstrates global member bridging capabilities:
/// - Global functions (top-level functions)
/// - Global variables and constants
/// - Generic global functions
/// - Async global functions
library;

// ============================================================================
// Global Constants
// ============================================================================

/// Application version constant.
const String appVersion = '1.0.0';

/// Application name constant.
const String appName = 'D4rt Example';

/// Default timeout in milliseconds.
const int defaultTimeout = 5000;

/// Mathematical constant PI.
const double pi = 3.14159265359;

// ============================================================================
// Global Variables
// ============================================================================

/// Mutable counter variable.
int globalCounter = 0;

/// List of registered names.
final List<String> registeredNames = [];

// ============================================================================
// Simple Global Functions
// ============================================================================

/// Simple greeting function.
String greet(String name) => 'Hello, $name!';

/// Add two numbers.
int add(int a, int b) => a + b;

/// Multiply with optional factor.
double multiply(double value, [double factor = 1.0]) => value * factor;

/// Calculate circle area using global pi.
double circleArea(double radius) => pi * radius * radius;

/// Format a message with named parameters.
String formatMessage({
  required String message,
  String prefix = '',
  String suffix = '',
}) {
  return '$prefix$message$suffix';
}

// ============================================================================
// Generic Global Functions
// ============================================================================

/// Identity function - returns value unchanged.
T identity<T>(T value) => value;

/// Create a pair from two values.
(A, B) makePair<A, B>(A first, B second) => (first, second);

/// Get first element of a list.
T? firstOrNull<T>(List<T> items) => items.isEmpty ? null : items.first;

/// Find element matching predicate.
T? findWhere<T>(List<T> items, bool Function(T) predicate) {
  for (final item in items) {
    if (predicate(item)) return item;
  }
  return null;
}

/// Map list elements with transformer.
List<R> mapList<T, R>(List<T> items, R Function(T) mapper) {
  return items.map(mapper).toList();
}

/// Filter list with predicate.
List<T> filterList<T>(List<T> items, bool Function(T) predicate) {
  return items.where(predicate).toList();
}

/// Reduce list with combiner.
T reduceList<T>(List<T> items, T Function(T, T) combiner) {
  return items.reduce(combiner);
}

// ============================================================================
// Bounded Generic Functions
// ============================================================================

/// Sort comparable items.
List<T> sortItems<T extends Comparable<T>>(List<T> items) {
  final sorted = List<T>.from(items);
  sorted.sort();
  return sorted;
}

/// Find minimum value.
T minValue<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) <= 0 ? a : b;
}

/// Find maximum value.
T maxValue<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) >= 0 ? a : b;
}

// ============================================================================
// Async Global Functions
// ============================================================================

/// Delay execution and return message.
Future<String> delayedGreeting(String name, int delayMs) async {
  await Future.delayed(Duration(milliseconds: delayMs));
  return 'Hello after delay, $name!';
}

/// Fetch simulated data.
Future<Map<String, dynamic>> fetchData(String id) async {
  await Future.delayed(const Duration(milliseconds: 10));
  return {
    'id': id,
    'timestamp': DateTime.now().toIso8601String(),
    'data': 'Sample data for $id',
  };
}

/// Process items with async operation.
Future<List<R>> processAsync<T, R>(
  List<T> items,
  Future<R> Function(T) processor,
) async {
  final results = <R>[];
  for (final item in items) {
    results.add(await processor(item));
  }
  return results;
}

// ============================================================================
// Utility Functions
// ============================================================================

/// Increment global counter and return new value.
int incrementCounter() => ++globalCounter;

/// Reset global counter to zero.
void resetCounter() => globalCounter = 0;

/// Register a name and return success.
bool registerName(String name) {
  if (registeredNames.contains(name)) return false;
  registeredNames.add(name);
  return true;
}

/// Get all registered names.
List<String> getRegisteredNames() => List.unmodifiable(registeredNames);

/// Clear all registered names.
void clearNames() => registeredNames.clear();
