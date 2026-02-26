/// Test fixtures for bridge generator edge cases and difficult scenarios.
///
/// This file contains definitions that test edge cases:
/// - Reserved word parameter names
/// - Complex nested generic types
/// - Classes with many overloads
/// - Default values referencing statics
/// - Typedefs and function types
/// - Extension types (if supported)
library;

// =============================================================================
// Reserved Word Parameter Names
// =============================================================================

/// Class with Dart reserved words as parameter names.
/// These require special handling in generated code.
class ReservedWordsClass {
  final String class_;
  final int for_;
  final bool in_;

  ReservedWordsClass({
    required this.class_,
    required this.for_,
    this.in_ = false,
  });

  /// Method with reserved word parameter.
  String process(String if_, {String? else_}) {
    return '$if_ - ${else_ ?? 'none'}';
  }
}

// =============================================================================
// Complex Nested Generic Types
// =============================================================================

/// Class with deeply nested generic types.
class NestedGenericsClass {
  final Map<String, List<int>> mappedLists;
  final List<Map<String, dynamic>> listOfMaps;
  final Map<String, Map<String, List<Set<int>>>> deeplyNested;

  NestedGenericsClass({
    required this.mappedLists,
    required this.listOfMaps,
    this.deeplyNested = const {},
  });

  /// Method returning nested generic.
  List<Map<String, int>> getItems() {
    return [];
  }

  /// Method taking nested generic parameter.
  void addEntry(Map<String, List<String>> entry) {
    // Process entry
  }
}

/// A result type with generic error handling.
class Result<T, E> {
  final T? value;
  final E? error;
  final bool isSuccess;

  const Result.success(T this.value)
      : error = null,
        isSuccess = true;

  const Result.failure(E this.error)
      : value = null,
        isSuccess = false;

  R fold<R>(R Function(T) onSuccess, R Function(E) onFailure) {
    if (isSuccess && value != null) {
      return onSuccess(value as T);
    }
    return onFailure(error as E);
  }
}

// =============================================================================
// Default Values with Static References
// =============================================================================

/// Class with default values referencing static constants.
class DefaultValuesClass {
  static const String defaultPrefix = 'default';
  static const int defaultTimeout = 30;
  static const List<String> defaultTags = ['auto'];

  final String prefix;
  final int timeout;
  final List<String> tags;

  DefaultValuesClass({
    this.prefix = defaultPrefix,
    this.timeout = defaultTimeout,
    this.tags = const ['auto'],
  });

  /// Method with default referencing static.
  String format(String input, {String prefix = defaultPrefix}) {
    return '$prefix: $input';
  }
}

// =============================================================================
// Function Types and Typedefs
// =============================================================================

/// Typedef for a simple callback.
typedef VoidCallback = void Function();

/// Typedef for a function with parameters.
typedef StringTransformer = String Function(String input);

/// Typedef for generic function.
typedef Comparator<T> = int Function(T a, T b);

/// Typedef for async function.
typedef AsyncLoader = Future<String> Function(String url);

/// Class using typedefs.
class CallbackHolder {
  VoidCallback? onComplete;
  StringTransformer? transformer;

  CallbackHolder({this.onComplete, this.transformer});

  void execute() {
    onComplete?.call();
  }

  String? transform(String input) {
    return transformer?.call(input);
  }
}

/// Class with function-typed parameters.
class FunctionParamsClass {
  final String name;

  FunctionParamsClass(this.name);

  /// Method taking a function parameter.
  /// Note: Function types are typically converted to dynamic in bridges.
  void forEach(void Function(String item) callback) {
    callback(name);
  }

  /// Method with complex function parameter.
  T transform<T>(T Function(String) mapper) {
    return mapper(name);
  }

  /// Method taking nullable function.
  String process(String input, String Function(String)? modifier) {
    if (modifier != null) {
      return modifier(input);
    }
    return input;
  }
}

// =============================================================================
// Operators (Custom Operators)
// =============================================================================

/// Class with operator overloading.
/// Note: Operators may have special bridge handling.
class Vector2D {
  final double x;
  final double y;

  const Vector2D(this.x, this.y);

  /// Addition operator.
  Vector2D operator +(Vector2D other) {
    return Vector2D(x + other.x, y + other.y);
  }

  /// Subtraction operator.
  Vector2D operator -(Vector2D other) {
    return Vector2D(x - other.x, y - other.y);
  }

  /// Scalar multiplication.
  Vector2D operator *(double scalar) {
    return Vector2D(x * scalar, y * scalar);
  }

  /// Negation operator.
  Vector2D operator -() {
    return Vector2D(-x, -y);
  }

  /// Indexing operator.
  double operator [](int index) {
    if (index == 0) return x;
    if (index == 1) return y;
    throw RangeError.index(index, this, 'index', null, 2);
  }

  /// Equality.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vector2D && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  double get length => (x * x + y * y);

  @override
  String toString() => 'Vector2D($x, $y)';
}

// =============================================================================
// Special Parameter Patterns
// =============================================================================

/// Class with varargs-like pattern (uses List).
class VarArgsLikeClass {
  final List<String> items;

  VarArgsLikeClass(this.items);

  /// Method accepting variable number of items.
  String join([String separator = ', ']) {
    return items.join(separator);
  }

  /// Method with spread-like parameter.
  void addAll(List<String> moreItems) {
    items.addAll(moreItems);
  }
}

/// Class with many parameters (stress test).
class ManyParamsClass {
  final String p1;
  final String p2;
  final String p3;
  final String p4;
  final String p5;
  final int n1;
  final int n2;
  final int n3;
  final bool b1;
  final bool b2;

  ManyParamsClass({
    required this.p1,
    required this.p2,
    this.p3 = '',
    this.p4 = '',
    this.p5 = '',
    this.n1 = 0,
    this.n2 = 0,
    this.n3 = 0,
    this.b1 = false,
    this.b2 = false,
  });

  @override
  String toString() => 'ManyParamsClass($p1, $p2, ...)';
}

// =============================================================================
// Nullable and Required Patterns
// =============================================================================

/// Class testing nullable parameter patterns.
class NullableParamsClass {
  final String? nullableString;
  final int? nullableInt;
  final List<String>? nullableList;

  NullableParamsClass({
    this.nullableString,
    this.nullableInt,
    this.nullableList,
  });

  /// Method with nullable return.
  String? getFirstOrNull() {
    return nullableList?.firstOrNull;
  }

  /// Method accepting nullable parameter.
  String format(String? prefix) {
    return '${prefix ?? 'default'}: ${nullableString ?? 'none'}';
  }
}

// =============================================================================
// Empty and Minimal Classes
// =============================================================================

/// A completely empty class.
class EmptyClass {}

/// A class with only a default constructor (no explicit members).
class MinimalClass {
  MinimalClass();
}

/// A class with only static members (no instance members).
class StaticOnlyClass {
  static const String name = 'StaticOnly';
  static int counter = 0;

  static void increment() {
    counter++;
  }

  static int getCount() => counter;
}

// =============================================================================
// Mixin Classes
// =============================================================================

/// A mixin for logging capability.
mixin LoggingMixin {
  final List<String> _logs = [];

  void log(String message) {
    _logs.add('[${DateTime.now()}] $message');
  }

  List<String> get logs => List.unmodifiable(_logs);

  void clearLogs() {
    _logs.clear();
  }
}

/// A class using a mixin.
class LoggingClass with LoggingMixin {
  final String name;

  LoggingClass(this.name);

  void doWork() {
    log('$name: Starting work');
    // ... work ...
    log('$name: Finished work');
  }
}

// =============================================================================
// Late Initialization
// =============================================================================

/// Class with late-initialized fields.
class LateInitClass {
  late String name;
  late final int id;

  LateInitClass();

  void initialize(String name, int id) {
    this.name = name;
    this.id = id;
  }

  bool get isInitialized {
    try {
      // Access to check if initialized
      name;
      id;
      return true;
    } catch (_) {
      return false;
    }
  }
}

// =============================================================================
// Covariant Parameters
// =============================================================================

/// Base class for covariant test.
abstract class Animal {
  String get species;
  void feed(Object food);
}

/// Derived class with covariant parameter.
class Cat extends Animal {
  @override
  String get species => 'Cat';

  @override
  void feed(covariant String food) {
    // Cats only eat certain foods
  }
}
