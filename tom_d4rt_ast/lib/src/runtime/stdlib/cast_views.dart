import 'dart:collection';

import 'package:tom_d4rt_ast/runtime.dart';

/// The `cast<T>()` of the stdlib bridges (ghissues30).
///
/// Dart's `cast<T>()` returns a view that checks each element against `T` as
/// it is read (and each element written into it), throwing a `TypeError` for
/// one that is not a `T`. The bridges used to answer the native
/// `cast<dynamic>()`, which drops the call's type argument, so a script never
/// saw that error. These helpers answer a checked view when
/// [InterpreterVisitor.castElementCheck] has a check for the type argument,
/// and the old lenient view otherwise.
///
/// The views are lazy like Dart's: `[1, 'a'].cast<int>().first` is 1, and the
/// error comes when `'a'` is read.

/// The `cast<T>()` of a list: a checked [List] view of [source].
List<Object?> castList(
  InterpreterVisitor visitor,
  List source,
  List<RuntimeType>? typeArguments,
) {
  final check = visitor.castElementCheck(typeArguments);
  if (check == null) return source.cast<dynamic>();
  return CheckedCastList(source, check);
}

/// The `cast<T>()` of an iterable: a lazy checked view of [source].
Iterable<Object?> castIterable(
  InterpreterVisitor visitor,
  Iterable source,
  List<RuntimeType>? typeArguments,
) {
  final check = visitor.castElementCheck(typeArguments);
  if (check == null) return source.cast<dynamic>();
  return source.map<Object?>(check);
}

/// The `cast<T>()` of a set: a checked [Set] view of [source].
Set<Object?> castSet(
  InterpreterVisitor visitor,
  Set source,
  List<RuntimeType>? typeArguments,
) {
  final check = visitor.castElementCheck(typeArguments);
  if (check == null) return source.cast<dynamic>();
  return CheckedCastSet(source, check);
}

/// The `cast<K, V>()` of a map: a checked [Map] view of [source].
Map<Object?, Object?> castMap(
  InterpreterVisitor visitor,
  Map source,
  List<RuntimeType>? typeArguments,
) {
  final checkKey = visitor.castElementCheck(typeArguments, 0);
  final checkValue = visitor.castElementCheck(typeArguments, 1);
  if (checkKey == null && checkValue == null) {
    return source.cast<dynamic, dynamic>();
  }
  return CheckedCastMap(
    source,
    checkKey ?? _unchecked,
    checkValue ?? _unchecked,
  );
}

Object? _unchecked(Object? element) => element;

/// A [List] view of a source list whose elements are checked on the way out
/// and on the way in; the length and every write belong to the source.
class CheckedCastList extends ListBase<Object?> {
  CheckedCastList(this._source, this._check);

  final List _source;
  final Object? Function(Object?) _check;

  @override
  int get length => _source.length;

  @override
  set length(int newLength) => _source.length = newLength;

  @override
  Object? operator [](int index) => _check(_source[index]);

  @override
  void operator []=(int index, Object? value) => _source[index] = _check(value);

  @override
  void add(Object? element) => _source.add(_check(element));

  @override
  void addAll(Iterable<Object?> iterable) =>
      _source.addAll(iterable.map(_check));

  @override
  void insert(int index, Object? element) =>
      _source.insert(index, _check(element));

  @override
  bool remove(Object? element) => _source.remove(element);

  @override
  Object? removeAt(int index) => _check(_source.removeAt(index));

  @override
  Object? removeLast() => _check(_source.removeLast());

  @override
  void clear() => _source.clear();
}

/// A [Set] view of a source set whose elements are checked when read and
/// added; membership and removal belong to the source.
class CheckedCastSet extends SetBase<Object?> {
  CheckedCastSet(this._source, this._check);

  final Set _source;
  final Object? Function(Object?) _check;

  @override
  bool add(Object? value) => _source.add(_check(value));

  @override
  bool contains(Object? element) => _source.contains(element);

  @override
  Iterator<Object?> get iterator => _source.map<Object?>(_check).iterator;

  @override
  int get length => _source.length;

  @override
  Object? lookup(Object? element) =>
      _source.contains(element) ? _check(_source.lookup(element)) : null;

  @override
  bool remove(Object? value) => _source.remove(value);

  @override
  Set<Object?> toSet() => _source.map<Object?>(_check).toSet();
}

/// A [Map] view of a source map whose keys and values are checked when read
/// and written; lookups by key belong to the source.
class CheckedCastMap extends MapBase<Object?, Object?> {
  CheckedCastMap(this._source, this._checkKey, this._checkValue);

  final Map _source;
  final Object? Function(Object?) _checkKey;
  final Object? Function(Object?) _checkValue;

  @override
  Object? operator [](Object? key) => _checkValue(_source[key]);

  @override
  void operator []=(Object? key, Object? value) =>
      _source[_checkKey(key)] = _checkValue(value);

  @override
  void clear() => _source.clear();

  @override
  Iterable<Object?> get keys => _source.keys.map<Object?>(_checkKey);

  @override
  Object? remove(Object? key) => _checkValue(_source.remove(key));

  @override
  bool containsKey(Object? key) => _source.containsKey(key);

  @override
  int get length => _source.length;
}
