import 'dart:collection';

/// Immutable, hash-indexed string-keyed map for member/declaration tables
/// that are fully populated during declaration wiring and never mutated
/// afterwards (perf T6, plan_2 §6 / round-1 plan 5c).
///
/// Lifecycle is two-phase and a [FrozenNameMap] is a drop-in
/// `Map<String, V>`, so read sites need no changes:
///
///  * **Building** — behaves like a normal mutable map (delegates to an
///    internal [LinkedHashMap]). The wiring code fills it via `[]=`.
///  * **Frozen** — after [freeze] the entries are compacted into three
///    parallel arrays sorted by `key.hashCode`. A lookup binary-searches the
///    hash array (branch-friendly int compares) and only falls back to `==`
///    across the rare hashCode-collision run. Mutation throws.
///
/// Why this shape: the steady-state member tables are read far more than
/// they are written (exactly once, at declaration time). A sorted parallel
/// layout removes the `LinkedHashMap` bucket/hash-bookkeeping overhead and
/// turns the string `==` that dominates `_OneByteString.==` into integer
/// compares everywhere except true hashCode collisions.
///
/// Hashes are stored as a plain `List<int>` rather than an `Int32List` so
/// the full (possibly 64-bit, possibly negative) `String.hashCode` is kept
/// verbatim — truncating to 32 bits would require masking the search target
/// identically and buys nothing for the small tables involved here.
class FrozenNameMap<V> extends MapBase<String, V> {
  FrozenNameMap();

  /// Mutable backing while building; set to `null` once [freeze] runs.
  Map<String, V>? _builder = <String, V>{};

  /// Sorted (ascending) `key.hashCode`s once frozen.
  List<int>? _hashes;

  /// Keys in the same order as [_hashes] (collision disambiguation + [keys]).
  List<String>? _names;

  /// Values in the same order as [_hashes].
  List<V>? _values;

  /// Whether the map has been compacted and is now read-only.
  bool get isFrozen => _builder == null;

  /// Compact the builder into the sorted parallel arrays. Idempotent: a
  /// second call is a no-op. After freezing, mutating operations throw.
  void freeze() {
    final builder = _builder;
    if (builder == null) return;
    final entries = builder.entries.toList(growable: false)
      ..sort((a, b) => a.key.hashCode.compareTo(b.key.hashCode));
    final n = entries.length;
    final hashes = List<int>.generate(n, (i) => entries[i].key.hashCode,
        growable: false);
    final names =
        List<String>.generate(n, (i) => entries[i].key, growable: false);
    final values = List<V>.generate(n, (i) => entries[i].value, growable: false);
    _hashes = hashes;
    _names = names;
    _values = values;
    _builder = null;
  }

  /// Index of [key] in the frozen arrays, or `-1` if absent. Only valid
  /// after [freeze].
  int _indexOf(String key) {
    final hashes = _hashes!;
    final n = hashes.length;
    if (n == 0) return -1;
    final target = key.hashCode;
    var lo = 0;
    var hi = n - 1;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      final h = hashes[mid];
      if (h < target) {
        lo = mid + 1;
      } else if (h > target) {
        hi = mid - 1;
      } else {
        // Matching hash; scan the (usually length-1) collision run.
        final names = _names!;
        var i = mid;
        while (i > 0 && hashes[i - 1] == target) {
          i--;
        }
        for (; i < n && hashes[i] == target; i++) {
          if (names[i] == key) return i;
        }
        return -1;
      }
    }
    return -1;
  }

  @override
  V? operator [](Object? key) {
    if (key is! String) return null;
    final builder = _builder;
    if (builder != null) return builder[key];
    final idx = _indexOf(key);
    return idx < 0 ? null : _values![idx];
  }

  @override
  bool containsKey(Object? key) {
    if (key is! String) return false;
    final builder = _builder;
    return builder != null ? builder.containsKey(key) : _indexOf(key) >= 0;
  }

  @override
  void operator []=(String key, V value) {
    final builder = _builder;
    if (builder == null) {
      throw UnsupportedError('FrozenNameMap is frozen and cannot be mutated.');
    }
    builder[key] = value;
  }

  @override
  V? remove(Object? key) {
    final builder = _builder;
    if (builder == null) {
      throw UnsupportedError('FrozenNameMap is frozen and cannot be mutated.');
    }
    return builder.remove(key);
  }

  @override
  void clear() {
    final builder = _builder;
    if (builder == null) {
      throw UnsupportedError('FrozenNameMap is frozen and cannot be mutated.');
    }
    builder.clear();
  }

  @override
  Iterable<String> get keys {
    final builder = _builder;
    return builder != null ? builder.keys : _names!;
  }

  @override
  int get length {
    final builder = _builder;
    return builder != null ? builder.length : _hashes!.length;
  }

  @override
  bool get isEmpty => length == 0;

  @override
  bool get isNotEmpty => length != 0;
}
