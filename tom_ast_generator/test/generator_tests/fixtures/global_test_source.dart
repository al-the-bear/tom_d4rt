/// Test fixtures for bridge generator global function and variable tests.
///
/// This file contains various top-level definitions to test:
/// - Global functions with different parameter types
/// - Global variables (final, const, mutable)
/// - Functions with complex return types
library;

// ignore_for_file: unused_element

// =============================================================================
// Global Constants
// =============================================================================

/// A simple string constant.
const String appName = 'TestApp';

/// A numeric constant.
const int maxRetries = 3;

/// A double constant.
const double defaultTimeout = 30.0;

/// A boolean constant.
const bool debugMode = false;

// =============================================================================
// Global Final Variables
// =============================================================================

/// Final variable initialized with expression.
final String version = '1.0.0';

/// Final list.
final List<String> supportedFormats = ['json', 'yaml', 'xml'];

/// Final map.
final Map<String, int> errorCodes = {
  'NOT_FOUND': 404,
  'FORBIDDEN': 403,
  'SERVER_ERROR': 500,
};

// =============================================================================
// Global Mutable Variables
// =============================================================================

/// Mutable counter variable.
int requestCount = 0;

/// Mutable string variable.
String lastError = '';

/// Nullable mutable variable.
DateTime? lastRunTime;

// =============================================================================
// Simple Global Functions
// =============================================================================

/// A simple void function with no parameters.
void resetState() {
  requestCount = 0;
  lastError = '';
  lastRunTime = null;
}

/// A simple function returning a value.
int getRequestCount() {
  return requestCount;
}

/// A function with a single parameter.
String greet(String name) {
  return 'Hello, $name!';
}

/// A function with multiple parameters.
int add(int a, int b) {
  return a + b;
}

/// A function returning a boolean.
bool isValidName(String name) {
  return name.isNotEmpty && name.length <= 100;
}

// =============================================================================
// Functions with Optional Parameters
// =============================================================================

/// Function with optional positional parameter.
String formatMessage(String message, [String? prefix]) {
  if (prefix != null) {
    return '$prefix: $message';
  }
  return message;
}

/// Function with optional positional parameters and defaults.
String buildUrl(String host, [String path = '/', int port = 80]) {
  if (port == 80) {
    return 'http://$host$path';
  }
  return 'http://$host:$port$path';
}

/// Function with named parameters.
String formatRecord({
  required String name,
  required int id,
  String? description,
  bool active = true,
}) {
  final status = active ? 'active' : 'inactive';
  final desc = description ?? 'No description';
  return 'Record #$id: $name ($status) - $desc';
}

/// Function with mixed parameters.
String createEntry(
  String type,
  String value, {
  int priority = 0,
  bool validate = true,
}) {
  final suffix = validate ? ' [validated]' : '';
  return '[$priority] $type: $value$suffix';
}

// =============================================================================
// Functions with Complex Types
// =============================================================================

/// Function returning a list.
List<int> range(int start, int end) {
  return List.generate(end - start, (i) => start + i);
}

/// Function taking a list parameter.
int sumList(List<int> numbers) {
  return numbers.fold(0, (sum, n) => sum + n);
}

/// Function returning a map.
Map<String, dynamic> createConfig(String name, int version) {
  return {
    'name': name,
    'version': version,
    'timestamp': DateTime.now().toIso8601String(),
  };
}

/// Function with nullable return.
String? findMatch(List<String> items, String pattern) {
  for (final item in items) {
    if (item.contains(pattern)) {
      return item;
    }
  }
  return null;
}

// =============================================================================
// Higher-Order Functions (may need special handling)
// =============================================================================

/// Function that takes a function parameter.
/// Note: Function types may be converted to dynamic in bridges.
List<T> mapItems<T>(List<T> items, T Function(T) transform) {
  return items.map(transform).toList();
}

/// Function that returns a function.
/// Note: This creates a closure.
int Function(int) createMultiplier(int factor) {
  return (int x) => x * factor;
}

// =============================================================================
// Async Functions
// =============================================================================

/// Async function returning Future.
Future<String> fetchData(String url) async {
  // Simulated async operation
  await Future.delayed(Duration(milliseconds: 10));
  return 'Data from $url';
}

/// Async function with parameters.
Future<int> computeAsync(int a, int b, {bool multiply = false}) async {
  await Future.delayed(Duration(milliseconds: 5));
  return multiply ? a * b : a + b;
}

// =============================================================================
// Private Functions (should be skipped)
// =============================================================================

/// Private function should be skipped.
String _internalHelper(String input) {
  return input.trim().toLowerCase();
}

/// Another private function.
int _calculateInternal(int x) {
  return x * 2;
}

// =============================================================================
// Error Handling Functions
// =============================================================================

/// Function that may throw.
int divideStrict(int a, int b) {
  if (b == 0) {
    throw ArgumentError('Cannot divide by zero');
  }
  return a ~/ b;
}

/// Function with try-catch.
int divideSafe(int a, int b) {
  try {
    return a ~/ b;
  } catch (_) {
    return 0;
  }
}

// =============================================================================
// Global Getters (should use registerGlobalGetter for lazy evaluation)
// =============================================================================

/// A global singleton that may not be initialized at registration time.
class GlobalService {
  static GlobalService? _instance;
  static GlobalService get instance => _instance ??= GlobalService._();
  GlobalService._();
  
  String get status => 'running';
}

/// Top-level getter returning the singleton instance.
GlobalService get globalService => GlobalService.instance;

/// Top-level getter returning computed value.
DateTime get currentTime => DateTime.now();

/// Top-level getter with nullable return.
String? get lastLogMessage => lastError.isNotEmpty ? lastError : null;

/// Top-level getter depending on mutable state.
int get doubleRequestCount => requestCount * 2;
