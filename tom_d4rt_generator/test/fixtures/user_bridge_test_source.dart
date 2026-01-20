/// Test fixture for UserBridge override system.
library;

import 'package:tom_d4rt/d4rt.dart';

// =============================================================================
// Target class to be bridged
// =============================================================================

/// A class that will have some members overridden via UserBridge.
class MyCollection<T> {
  final List<T> _items = [];

  MyCollection();
  MyCollection.fromList(List<T> items) {
    _items.addAll(items);
  }

  T operator [](int index) => _items[index];
  void operator []=(int index, T value) => _items[index] = value;

  int get length => _items.length;
  bool get isEmpty => _items.isEmpty;

  void add(T item) => _items.add(item);
  void clear() => _items.clear();

  static MyCollection<T> empty<T>() => MyCollection<T>();
  static int get defaultCapacity => 16;
}

// =============================================================================
// UserBridge with static overrides
// =============================================================================

/// User-defined bridge overrides for MyCollection.
///
/// This class extends D4UserBridge to:
/// 1. Be automatically excluded from bridge generation
/// 2. Provide static override methods for specific members
class MyCollectionUserBridge extends D4UserBridge {
  /// Provide nativeNames for internal implementations.
  static List<String> get nativeNames => ['_InternalCollection'];

  /// Override the default constructor.
  static Object? overrideConstructor(
    Object? visitor,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    return MyCollection();
  }

  /// Override operator[].
  static Object? overrideOperatorIndex(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final collection = D4.validateTarget<MyCollection>(target, 'MyCollection');
    final index = D4.getRequiredArg<int>(positional, 0, 'index', '[]');
    return collection[index];
  }

  /// Override the length getter.
  static Object? overrideGetterLength(Object? visitor, Object? target) {
    final collection = D4.validateTarget<MyCollection>(target, 'MyCollection');
    return collection.length;
  }

  /// Override the add method.
  static Object? overrideMethodAdd(
    Object? visitor,
    Object? target,
    List<Object?> positional,
    Map<String, Object?> named,
  ) {
    final collection = D4.validateTarget<MyCollection>(target, 'MyCollection');
    collection.add(positional[0]);
    return null;
  }

  /// Override static getter.
  static Object? overrideStaticGetterDefaultCapacity(Object? visitor) {
    return MyCollection.defaultCapacity;
  }
}

// =============================================================================
// Another class without UserBridge (for comparison)
// =============================================================================

/// A class without any UserBridge - should be generated normally.
class SimpleClass {
  final String name;
  SimpleClass(this.name);

  String greet() => 'Hello, $name!';
}
