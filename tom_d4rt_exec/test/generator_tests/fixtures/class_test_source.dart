/// Test fixtures for bridge generator class bridging tests.
///
/// This file contains various class definitions to test:
/// - Simple classes with constructors
/// - Classes with named constructors
/// - Classes with factory constructors
/// - Classes with getters and setters
/// - Classes with methods
/// - Inheritance and superclasses
/// - Static members
/// - Abstract classes
/// - Generic classes
library;

// ignore_for_file: unused_element

// =============================================================================
// Simple Classes
// =============================================================================

/// A simple class with a default constructor.
class SimpleClass {
  final String name;
  final int value;

  SimpleClass(this.name, this.value);
}

/// A class with optional positional parameters.
class OptionalPositionalClass {
  final String name;
  final int value;
  final String? description;

  OptionalPositionalClass(this.name, [this.value = 0, this.description]);
}

/// A class with named parameters.
class NamedParamsClass {
  final String name;
  final int value;
  final bool enabled;

  NamedParamsClass({
    required this.name,
    this.value = 42,
    this.enabled = false,
  });
}

// =============================================================================
// Named and Factory Constructors
// =============================================================================

/// A class with multiple constructors.
class MultiConstructorClass {
  final String id;
  final String type;
  final int count;

  /// Default constructor.
  MultiConstructorClass(this.id, this.type, this.count);

  /// Named constructor from type.
  MultiConstructorClass.fromType(this.type)
      : id = 'auto_${DateTime.now().millisecondsSinceEpoch}',
        count = 0;

  /// Named constructor with defaults.
  MultiConstructorClass.empty()
      : id = '',
        type = 'unknown',
        count = 0;

  /// Factory constructor.
  factory MultiConstructorClass.create(String type) {
    return MultiConstructorClass('factory_id', type, 1);
  }
}

/// A class with const constructor.
class ConstClass {
  final String value;

  const ConstClass(this.value);

  const ConstClass.empty() : value = '';
}

// =============================================================================
// Getters and Setters
// =============================================================================

/// A class with various getters and setters.
class PropertyClass {
  String _name;
  int _count;
  final String id;

  PropertyClass(this.id, this._name, this._count);

  /// Simple getter.
  String get name => _name;

  /// Simple setter.
  set name(String value) => _name = value;

  /// Computed getter.
  int get count => _count;

  /// Setter with validation logic.
  set count(int value) {
    if (value >= 0) {
      _count = value;
    }
  }

  /// Read-only computed property.
  String get displayName => '$name (#$id)';

  /// Derived property.
  bool get isEmpty => _name.isEmpty && _count == 0;
}

// =============================================================================
// Methods
// =============================================================================

/// A class with various method types.
class MethodClass {
  final String prefix;
  int _counter = 0;

  MethodClass(this.prefix);

  /// Simple void method.
  void reset() {
    _counter = 0;
  }

  /// Method with return value.
  int increment() {
    return ++_counter;
  }

  /// Method with positional parameter.
  String format(String input) {
    return '$prefix: $input';
  }

  /// Method with optional positional parameters.
  String formatWithSuffix(String input, [String suffix = '']) {
    return '$prefix: $input$suffix';
  }

  /// Method with named parameters.
  String formatCustom({
    required String input,
    String separator = ': ',
    bool uppercase = false,
  }) {
    final result = '$prefix$separator$input';
    return uppercase ? result.toUpperCase() : result;
  }

  /// Method returning nullable type.
  String? getIfNotEmpty(String input) {
    return input.isEmpty ? null : input;
  }

  /// Method with complex return type.
  List<String> getItems(int count) {
    return List.generate(count, (i) => '$prefix-$i');
  }

  /// Getter for current count.
  int get counter => _counter;
}

// =============================================================================
// Inheritance
// =============================================================================

/// Base class for inheritance tests.
class BaseEntity {
  final String id;
  DateTime? _lastModified;

  BaseEntity(this.id);

  /// Getter from base.
  DateTime? get lastModified => _lastModified;

  /// Method from base.
  void touch() {
    _lastModified = DateTime.now();
  }

  /// Method to override.
  String describe() => 'Entity: $id';
}

/// Derived class extending base.
class DerivedEntity extends BaseEntity {
  final String name;
  final String type;

  DerivedEntity(String id, this.name, this.type) : super(id);

  /// Additional getter.
  String get fullName => '$type:$name';

  /// Override parent method.
  @override
  String describe() => 'DerivedEntity: $name ($type) [id=$id]';

  /// Own method.
  bool matches(String pattern) {
    return name.contains(pattern) || type.contains(pattern);
  }
}

/// Multi-level inheritance.
class SpecialEntity extends DerivedEntity {
  final int priority;

  SpecialEntity(String id, String name, String type, this.priority)
      : super(id, name, type);

  @override
  String describe() => '${super.describe()} priority=$priority';

  /// Own getter.
  bool get isHighPriority => priority > 5;
}

// =============================================================================
// Static Members
// =============================================================================

/// A class with static members.
class StaticMembersClass {
  static const String defaultName = 'default';
  static int _instanceCount = 0;

  final String name;

  StaticMembersClass(this.name) {
    _instanceCount++;
  }

  /// Static getter.
  static int get instanceCount => _instanceCount;

  /// Static method.
  static void resetCount() {
    _instanceCount = 0;
  }

  /// Static method with parameters.
  static String createId(String prefix, int number) {
    return '${prefix}_$number';
  }

  /// Instance method.
  String greet() => 'Hello, $name!';
}

// =============================================================================
// Abstract Classes
// =============================================================================

/// An abstract class (should be bridged but constructor may be skipped).
abstract class Processor {
  /// Abstract method.
  void process(String input);

  /// Concrete getter.
  bool get isReady;

  /// Concrete method.
  String status() => isReady ? 'ready' : 'not ready';
}

/// Concrete implementation of abstract class.
class SimpleProcessor extends Processor {
  bool _ready = false;

  @override
  void process(String input) {
    // Process the input
    _ready = true;
  }

  @override
  bool get isReady => _ready;
}

// =============================================================================
// Generic Classes
// =============================================================================

/// A simple generic class.
class Container<T> {
  T? _value;

  Container([this._value]);

  T? get value => _value;
  set value(T? val) => _value = val;

  bool get hasValue => _value != null;

  void clear() {
    _value = null;
  }
}

/// A generic class with bounded type parameter.
class NumberContainer<T extends num> {
  final T value;

  NumberContainer(this.value);

  T add(T other) {
    // Cast needed for generic arithmetic
    return (value + other) as T;
  }

  bool isGreaterThan(T other) => value > other;
}

/// A generic class with multiple type parameters.
class Pair<K, V> {
  final K key;
  final V value;

  const Pair(this.key, this.value);

  Pair<V, K> swap() => Pair(value, key);

  @override
  String toString() => '($key, $value)';
}

// =============================================================================
// Private Classes (should be skipped)
// =============================================================================

/// Private class should be skipped when skipPrivate is true.
class _PrivateClass {
  final String secret;

  _PrivateClass(this.secret);

  String reveal() => secret;
}

/// Public class with private constructor.
class SingletonPattern {
  static final SingletonPattern _instance = SingletonPattern._internal();

  /// Private constructor.
  SingletonPattern._internal();

  /// Factory that returns singleton.
  factory SingletonPattern() {
    return _instance;
  }

  String get message => 'I am the singleton';
}

/// GEN-042: Class with no explicit constructor.
/// Dart provides an implicit default no-arg constructor.
class ImplicitCtorClass {
  String label = 'default';
  int count = 0;

  void increment() => count++;
}

/// GEN-042: Another class with only methods, no constructor.
class CalculatorLike {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
}
