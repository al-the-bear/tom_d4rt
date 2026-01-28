/// Generic class examples for bridge generation testing.
/// 
/// This file demonstrates generic type bridging capabilities:
/// - Generic classes with type parameters
/// - Generic methods with their own type parameters
/// - Bounded type parameters (extends)
/// - Multiple type parameters
library;

/// Base interface for identifiable objects.
abstract class Identifiable {
  String get id;
}

/// Simple entity with id and name.
class Entity implements Identifiable {
  @override
  final String id;
  final String name;

  Entity(this.id, this.name);

  @override
  String toString() => 'Entity($id, $name)';
}

/// A generic box container.
class Box<T> {
  T? _value;

  Box([this._value]);

  T? get value => _value;
  set value(T? v) => _value = v;

  bool get isEmpty => _value == null;

  void clear() => _value = null;

  /// Generic method with unbounded type parameter.
  R transform<R>(R Function(T) transformer) {
    if (_value == null) {
      throw StateError('Box is empty');
    }
    return transformer(_value as T);
  }

  /// Static factory with type parameter.
  static Box<E> filled<E>(E value) => Box<E>(value);

  /// Static method with unbounded type.
  static U identity<U>(U value) => value;
}

/// A container with bounded type parameter.
class Repository<T extends Identifiable> {
  final Map<String, T> _items = {};

  /// Default constructor.
  Repository();

  void add(T item) => _items[item.id] = item;

  T? getById(String id) => _items[id];

  List<T> getAll() => _items.values.toList();

  int get count => _items.length;

  /// Find with predicate - uses T which has bounds.
  T? findWhere(bool Function(T) predicate) {
    for (final item in _items.values) {
      if (predicate(item)) return item;
    }
    return null;
  }

  /// Map all items - method with its own type parameter.
  List<R> mapAll<R>(R Function(T) mapper) {
    return _items.values.map(mapper).toList();
  }

  /// Static factory that creates repository from list.
  static Repository<E> fromList<E extends Identifiable>(List<E> items) {
    final repo = Repository<E>();
    for (final item in items) {
      repo.add(item);
    }
    return repo;
  }
}

/// A pair class with two type parameters.
class Pair<K, V> {
  final K first;
  final V second;

  Pair(this.first, this.second);

  /// Swap the pair values.
  Pair<V, K> swap() => Pair<V, K>(second, first);

  /// Map both values.
  Pair<K2, V2> mapBoth<K2, V2>(K2 Function(K) mapFirst, V2 Function(V) mapSecond) {
    return Pair<K2, V2>(mapFirst(first), mapSecond(second));
  }

  /// Create a new pair with different first value.
  Pair<K3, V> withFirst<K3>(K3 newFirst) => Pair<K3, V>(newFirst, second);

  /// Create a new pair with different second value.
  Pair<K, V3> withSecond<V3>(V3 newSecond) => Pair<K, V3>(first, newSecond);

  @override
  String toString() => 'Pair($first, $second)';
}

/// A class demonstrating generic methods without class type params.
class Transformer {
  /// Default constructor.
  Transformer();

  /// Identity function - unbounded.
  T identity<T>(T value) => value;

  /// Cast from one type to another.
  R cast<T, R>(T value) => value as R;

  /// Create a list from value.
  List<T> singleton<T>(T value) => [value];

  /// Merge two values into a pair.
  Pair<A, B> pair<A, B>(A first, B second) => Pair<A, B>(first, second);

  /// With bounded type parameter.
  String idOf<T extends Identifiable>(T item) => item.id;

  /// Static generic method.
  static List<E> repeat<E>(E value, int count) {
    return List.generate(count, (_) => value);
  }
}
