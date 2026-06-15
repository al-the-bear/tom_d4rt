/// A generic single-slot container whose index operator needs a user bridge.
///
/// A generic `operator[]` is the third class of generator limitation: the
/// element type `T` is not known at generation time, so the generated adapter
/// cannot coerce arguments correctly. [BoxUserBridge] handles the operators;
/// the generator bridges [isEmpty] and [size] on its own.
library;

/// A fixed-size, index-addressable container of [T].
class Box<T> {
  final List<T?> _slots;

  /// Create a box with [size] empty slots.
  Box(int size) : _slots = List<T?>.filled(size, null);

  /// Read slot [index]; `null` if nothing has been stored there.
  T? operator [](int index) => _slots[index];

  /// Store [value] in slot [index].
  void operator []=(int index, T? value) => _slots[index] = value;

  /// Number of slots.
  int get size => _slots.length;

  /// Whether every slot is still empty.
  bool get isEmpty => _slots.every((slot) => slot == null);

  @override
  String toString() => 'Box($_slots)';
}
