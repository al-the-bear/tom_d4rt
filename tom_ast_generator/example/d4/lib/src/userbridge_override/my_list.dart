/// MyList class from userbridge_override_design.md example.
///
/// This class demonstrates the need for UserBridge overrides because
/// generic operator[] requires special handling that can't be auto-generated.
library;

/// A generic list wrapper that requires manual operator bridging.
class MyList<T> {
  final List<T> _items = [];

  /// Create a new MyList.
  MyList();

  /// Get item at index.
  T operator [](int index) => _items[index];

  /// Set item at index.
  void operator []=(int index, T value) => _items[index] = value;

  /// Get the length of the list.
  int get length => _items.length;

  /// Check if the list is empty.
  bool get isEmpty => _items.isEmpty;

  /// Add an item to the list.
  void add(T item) => _items.add(item);

  /// Remove an item from the list.
  bool remove(T item) => _items.remove(item);

  /// Clear all items.
  void clear() => _items.clear();

  /// Create an empty list.
  static MyList<T> empty<T>() => MyList<T>();

  /// Create a list from existing items.
  static MyList<T> from<T>(List<T> items) {
    final list = MyList<T>();
    list._items.addAll(items);
    return list;
  }
}
