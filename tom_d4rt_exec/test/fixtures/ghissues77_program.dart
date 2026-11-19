// ghissues77's test program (GitHub #21, Slang's closure): dart:collection
// bases and Iterable as superclasses and mixins of script classes, and the
// interpreter fixes the closure needed after them.
//
// Valid Dart: the tests import it to get native Dart's answers, and run its
// text through the interpreter (tom_d4rt: test/ghissues77_collection_bases_test.dart;
// tom_d4rt_ast: a bundle of the same file, fixtures/ghissues77_program.bundle.json,
// written by tom_ast_generator/tool/write_ghissues77_fixtures.dart).
// tom_d4rt_ast keeps a copy (test/runtime/fixtures/ghissues77_program.dart);
// the two must stay identical.
// ignore_for_file: unnecessary_type_check, prefer_collection_literals, prefer_function_declarations_over_variables

import 'dart:collection';
import 'dart:convert';

String t(Object? Function() f) {
  try {
    return '${f()}';
  } catch (e) {
    return 'E:${e.runtimeType}:$e';
  }
}

// --- Iterable, IterableBase, IterableMixin ---------------------------------

class R extends Iterable<int> {
  @override
  Iterator<int> get iterator => [1, 2, 3].iterator;
}

/// A script iterator.
class Counter implements Iterator<int> {
  Counter(this.n);
  final int n;
  int _i = 0;

  @override
  int get current => _i;

  @override
  bool moveNext() => ++_i <= n;
}

/// Overrides a member the SDK implements (`length`).
class C extends IterableBase<int> {
  @override
  Iterator<int> get iterator => Counter(3);

  @override
  int get length => 42;
}

class M with IterableMixin<String> {
  @override
  Iterator<String> get iterator => ['a', 'b'].iterator;
}

List<String> iterables() => [
  t(() => R().length),
  t(() => R().toList()),
  t(() => R().map((e) => e * 2).toList()),
  t(() => R().where((e) => e.isOdd).join(',')),
  t(() => R().contains(2)),
  t(() => R().first),
  t(() => R().skip(1).toList()),
  t(() => C().toList()),
  t(() => C().length),
  t(() => C().last),
  t(() => M().join('-')),
  t(() => M().length),
  t(() => R() is Iterable<int>),
  t(() => List<int>.of(R())),
  t(() => R().toString()),
  t(() => '${C()}'),
];

// --- ListBase, ListMixin -----------------------------------------------------

class L extends ListBase<int> {
  final _items = <int?>[];

  @override
  int get length => _items.length;

  @override
  set length(int newLength) => _items.length = newLength;

  @override
  int operator [](int index) => _items[index]!;

  @override
  void operator []=(int index, int value) => _items[index] = value;
}

class LM with ListMixin<String> {
  final _items = <String?>[];

  @override
  int get length => _items.length;

  @override
  set length(int newLength) => _items.length = newLength;

  @override
  String operator [](int index) => _items[index]!;

  @override
  void operator []=(int index, String value) => _items[index] = value;
}

List<String> lists() {
  L make() => L()
    ..add(3)
    ..addAll([1, 2]);
  return [
    t(() => make().toList()),
    t(() => (make()..sort()).toList()),
    t(() => make().reversed.toList()),
    t(() => make().indexOf(2)),
    t(() => (make()..[0] = 9).toList()),
    t(() => (make()..removeLast()).toList()),
    t(() => make() is List),
    t(() => make() is List<int>),
    t(() => jsonEncode(make())),
    t(() => make().toString()),
    t(() => (LM()..add('x')..add('y')).join()),
    t(() => LM() is List<String>),
  ];
}

// --- SetBase, SetMixin -------------------------------------------------------

class S extends SetBase<int> {
  final _items = <int>{};

  @override
  bool add(int value) => _items.add(value);

  @override
  bool contains(Object? element) => _items.contains(element);

  @override
  int? lookup(Object? element) => _items.lookup(element);

  @override
  bool remove(Object? value) => _items.remove(value);

  @override
  Iterator<int> get iterator => _items.iterator;

  @override
  int get length => _items.length;

  @override
  Set<int> toSet() => _items.toSet();
}

class SM with SetMixin<String> {
  final _items = <String>{};

  @override
  bool add(String value) => _items.add(value);

  @override
  bool contains(Object? element) => _items.contains(element);

  @override
  String? lookup(Object? element) => _items.lookup(element);

  @override
  bool remove(Object? value) => _items.remove(value);

  @override
  Iterator<String> get iterator => _items.iterator;

  @override
  int get length => _items.length;

  @override
  Set<String> toSet() => _items.toSet();
}

List<String> sets() {
  S make() => S()
    ..add(4)
    ..add(4)
    ..add(5);
  return [
    t(() => make().toList()),
    t(() => make().length),
    t(() => (make().union({6}).toList()..sort())),
    t(() => make().intersection({5, 7}).toList()),
    t(() => make() is Set<int>),
    t(() => make().toString()),
    t(() => (SM()..addAll(['b', 'a', 'b'])).join(',')),
    t(() => SM() is Set<String>),
  ];
}

// --- MapBase, MapMixin, UnmodifiableMapBase ----------------------------------

class Mp extends MapBase<String, int> {
  final _map = <String, int>{};

  @override
  int? operator [](Object? key) => _map[key];

  @override
  void operator []=(String key, int value) => _map[key] = value;

  @override
  Iterable<String> get keys => _map.keys;

  @override
  int? remove(Object? key) => _map.remove(key);

  @override
  void clear() => _map.clear();
}

class MM with MapMixin<String, int> {
  final _map = <String, int>{};

  @override
  int? operator [](Object? key) => _map[key];

  @override
  void operator []=(String key, int value) => _map[key] = value;

  @override
  Iterable<String> get keys => _map.keys;

  @override
  int? remove(Object? key) => _map.remove(key);

  @override
  void clear() => _map.clear();
}

class U extends UnmodifiableMapBase<String, int> {
  @override
  int? operator [](Object? key) => key == 'a' ? 1 : null;

  @override
  Iterable<String> get keys => ['a'];
}

List<String> maps() {
  Mp make() => Mp()
    ..['x'] = 1
    ..addAll(<String, int>{'y': 2});
  return [
    t(() => make().entries.map((e) => '${e.key}=${e.value}').join(',')),
    t(() => make().length),
    t(() => make().containsKey('y')),
    t(() => make().values.toList()),
    t(() => make() is Map<String, int>),
    t(() => jsonEncode(make())),
    t(() => make().toString()),
    t(() => (MM()..['k'] = 3).toString()),
    t(() => U().length),
    t(() => U()['a']),
    t(() => U().containsKey('a')),
    t(() {
      U()['b'] = 2;
      return 'no error';
    }),
  ];
}

// --- What Slang's closure needed besides the bases ---------------------------

/// package collection's `EmptyUnmodifiableSet`, which extends `IterableBase`
/// with `UnmodifiableSetMixin` and implements `UnmodifiableSetView`: the
/// interface declares members concretely, and the class has them from
/// `IterableBase` and `Object`.
abstract class Described {
  bool any(bool Function(int element) test) => false;

  @override
  String toString() => 'Described';
}

class Z extends IterableBase<int> implements Described {
  @override
  Iterator<int> get iterator => [7].iterator;
}

/// Slang's `static setLocale(...) => instance.setLocale(...)`: a static
/// member is not reachable through an instance, so `instance.hello` is the
/// extension's.
abstract class Base {}

extension BaseExt on Base {
  String hello(String who) => 'ext hello $who';
  String get kind => 'ext kind';
}

class Settings extends Base {
  Settings._();
  static final instance = Settings._();
  static String hello(String who) => instance.hello(who);
  static String get kind => instance.kind;
}

/// Slang's `final Set<E> translationsLoading = {};`.
class Holder {
  final Set<int> loading = {};
  final Map<int, String> loaded = {};
}

/// Slang's `int score(E supported)`: a local function typed by an extension's
/// type parameter.
extension Pick<E extends Object> on List<E> {
  E best() {
    int score(E candidate) => '$candidate'.length;
    return reduce((a, b) => score(b) > score(a) ? b : a);
  }
}

/// Slang's `LocaleSettingsExt.loadLocale`: an async extension method.
extension Loader on Holder {
  Future<String> load(int key) async {
    if (loading.contains(key)) return 'loading';
    loading.add(key);
    loaded[key] = await Future.value('v$key');
    loading.remove(key);
    return 'loaded ${loaded.length}';
  }

  Stream<int> counts() async* {
    yield loaded.length;
    await Future<void>.delayed(Duration.zero);
    yield loaded.length + 1;
  }

  Iterable<int> keysTwice() sync* {
    yield* loaded.keys;
    yield* loaded.keys;
  }
}

/// package collection's
/// `extension ComparatorExtension<T> on Comparator<T>`.
extension Inverse<T> on Comparator<T> {
  Comparator<T> get inverse =>
      (T a, T b) => this(b, a);
}

List<String> closure() => [
  t(() => Z().any((e) => e == 7)),
  t(() => Z().toString()),
  t(() => Settings.hello('x')),
  t(() => Settings.kind),
  t(() => Holder().loading is Set<int>),
  t(() => (Holder()..loading.add(1)).loading.length),
  t(() => ['a', 'ccc', 'bb'].best()),
];

Future<List<String>> asyncClosure() async {
  final h = Holder();
  return [
    await h.load(1),
    await h.load(2),
    '${h.loaded}',
    '${await h.counts().toList()}',
    '${h.keysTwice().toList()}',
  ];
}

List<String> comparators() {
  final Comparator<int> byValue = (a, b) => a - b;
  return [t(() => ([3, 1, 2]..sort(byValue.inverse)).toString())];
}
