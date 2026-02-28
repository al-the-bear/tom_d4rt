/// Test fixtures for type parameter erasure in bridge generator.
///
/// This file contains classes and functions with type parameters to test
/// that the generator correctly uses type bounds for type erasure.
library;

// Test fixtures intentionally use patterns that trigger lint warnings
// ignore_for_file: unused_element
// ignore_for_file: avoid_shadowing_type_parameters

// =============================================================================
// Base Types for Bounds
// =============================================================================

/// Base class for testing type bounds.
abstract class BaseEntity {
  String get id;
}

/// Concrete entity for testing.
class Entity implements BaseEntity {
  @override
  final String id;
  final String name;

  Entity(this.id, this.name);
}

/// Observable base for testing constrained generics.
abstract class Observable {
  void notify();
}

/// Observable list for testing.
class ObservableList<E extends Observable> {
  final List<E> _items = [];

  void add(E item) => _items.add(item);

  /// Static method with constrained type parameters.
  /// The source type S must extend Observable, and the target type E must too.
  static ObservableList<E> castFrom<S extends Observable, E extends Observable>(
    ObservableList<S> source,
  ) {
    final result = ObservableList<E>();
    for (final item in source._items) {
      result.add(item as E);
    }
    return result;
  }

  /// Instance method with type parameter that has a bound.
  E firstWhere<E extends Observable>(bool Function(Observable) test) {
    for (final item in _items) {
      if (test(item)) return item as E;
    }
    throw StateError('No element');
  }
}

// =============================================================================
// Classes with Generic Methods
// =============================================================================

/// A class with various generic methods to test type erasure.
class GenericMethodClass {
  /// Method with unbounded type parameter - should use dynamic.
  T identity<T>(T value) => value;

  /// Method with bounded type parameter - should use the bound.
  E findFirst<E extends BaseEntity>(List<E> items) {
    return items.first;
  }

  /// Method with multiple bounded type parameters.
  Map<K, V> createMap<K extends Comparable, V extends BaseEntity>(
    List<K> keys,
    List<V> values,
  ) {
    final map = <K, V>{};
    for (var i = 0; i < keys.length && i < values.length; i++) {
      map[keys[i]] = values[i];
    }
    return map;
  }

  /// Static method with bounded type parameter.
  static List<E> filterEntities<E extends BaseEntity>(
    List<E> items,
    bool Function(E) predicate,
  ) {
    return items.where(predicate).toList();
  }

  /// Static method with complex nested generic bounds.
  static S transform<S extends BaseEntity, R extends Comparable>(
    S source,
    R Function(S) transformer,
  ) {
    transformer(source);
    return source;
  }
}

// =============================================================================
// Generic Class with Type Parameters
// =============================================================================

/// A generic class that also has methods with their own type parameters.
class Container<T extends BaseEntity> {
  final List<T> _items = [];

  void add(T item) => _items.add(item);

  /// Instance method with its own type parameter that differs from class param.
  /// The method type param R shadows nothing here.
  R mapFirst<R extends Comparable>(R Function(T) mapper) {
    if (_items.isEmpty) throw StateError('Empty container');
    return mapper(_items.first);
  }

  /// Static method - cannot use class type param T, only its own.
  static Container<E> createEmpty<E extends BaseEntity>() {
    return Container<E>();
  }
}

// =============================================================================
// Top-Level Functions with Type Parameters
// =============================================================================

/// Global function with unbounded type parameter.
T globalIdentity<T>(T value) => value;

/// Global function with bounded type parameter.
E findEntity<E extends BaseEntity>(List<E> entities, String id) {
  return entities.firstWhere((e) => e.id == id);
}

/// Global function with multiple bounded type parameters.
Map<K, V> buildEntityMap<K extends Comparable, V extends BaseEntity>(
  List<K> keys,
  V Function(K) factory,
) {
  final map = <K, V>{};
  for (final key in keys) {
    map[key] = factory(key);
  }
  return map;
}

// =============================================================================
// Recursive Type Bounds (T extends Comparable<T>)
// =============================================================================

/// Sort items with recursive type bound.
/// This tests the special case where T refers to itself in the bound.
List<T> sortItems<T extends Comparable<T>>(List<T> items) {
  final sorted = List<T>.from(items);
  sorted.sort();
  return sorted;
}

/// Find minimum value with recursive type bound.
T minValue<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) <= 0 ? a : b;
}

/// Find maximum value with recursive type bound.
T maxValue<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) >= 0 ? a : b;
}

/// Class with method using recursive type bound.
class SortableContainer<E extends Comparable<E>> {
  final List<E> _items = [];

  void add(E item) => _items.add(item);

  List<E> sorted() {
    final result = List<E>.from(_items);
    result.sort();
    return result;
  }

  E minimum() {
    if (_items.isEmpty) throw StateError('Empty container');
    return _items.reduce((a, b) => a.compareTo(b) <= 0 ? a : b);
  }
}
