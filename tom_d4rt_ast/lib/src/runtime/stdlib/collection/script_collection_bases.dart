// ghissues77 (GitHub #21): the dart:collection base classes, and Iterable
// itself, as superclasses and mixins of script classes.
//
// `class R extends Iterable<int> { Iterator<int> get iterator => ...; }` and
// package collection's `class EmptyUnmodifiableSet<E> extends IterableBase<E>
// with UnmodifiableSetMixin<E>` implement the members the SDK leaves abstract
// and inherit every other one from the SDK. An abstract bridged class has no
// constructor, so a script subclass gets no native super-object; a member it
// inherits runs on a RECEIVER PROXY instead (`D4.markProxyIsReceiver`,
// ghissues25): a native subclass of the SDK base whose abstract members call
// the script's, created once per instance and kept as its native object. The
// SDK's own implementations of everything else then run on it, as in Dart,
// and the proxy is also what native code sees when the instance crosses into
// it (`List.of(x)`, `jsonEncode(x)`, `x is List`).
//
// `UnmodifiableSetMixin` and `UnmodifiableMapMixin` are package collection's
// (interpreted from its source, their mutators throw there), and
// `UnmodifiableListBase` is `dart:_internal`'s, which a script cannot import;
// of the unmodifiable bases only `UnmodifiableMapBase` is `dart:collection`'s.
//
// The bridges: each base gets the member adapters of the interface it
// implements (Iterable, List, Set, Map), so a bridged mixin - whose lookup
// reads its own adapters only - answers them too, and a supertype edge to
// that interface for `is` and proxy resolution.
import 'dart:collection';

import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/list.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/map.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/set.dart';

/// The kind of collection a script class is, by the bridged bases on its
/// class chain.
enum _Kind { iterable, list, set, map }

/// The bases, by bridge name: the collection kind they make, and whether they
/// make it unmodifiable. `IterableBase` and `IterableMixin` are typedefs of
/// `Iterable`, `ListMixin` of `ListBase`, `SetMixin` of `SetBase` and
/// `MapMixin` of `MapBase` in Dart 3, so each is an alias of that bridge
/// ([ScriptCollectionBasesCollection.aliases]) and never a bridge of its
/// own: a second bridge over the same native type would displace the first
/// from the by-type registry.
const Map<String, (_Kind, bool)> _bases = {
  'Iterable': (_Kind.iterable, false),
  'ListBase': (_Kind.list, false),
  'SetBase': (_Kind.set, false),
  'MapBase': (_Kind.map, false),
  'UnmodifiableMapBase': (_Kind.map, true),
};

/// The bridges of the bases (Iterable is `dart:core`'s, already defined).
class ScriptCollectionBasesCollection {
  static BridgedClass get listBase {
    final members = ListCore.definition;
    return BridgedClass(
      nativeType: ListBase,
      name: 'ListBase',
      typeParameterCount: members.typeParameterCount,
      canBeUsedAsMixin: true,
      isAbstract: true,
      staticMethods: {
        'listToString': (visitor, positional, named, typeArgs) =>
            ListBase.listToString(D4.unwrapAs<List<Object?>>(positional[0])),
      },
      methods: members.methods,
      getters: members.getters,
      setters: members.setters,
      methodSignatures: members.methodSignatures,
      getterSignatures: members.getterSignatures,
      setterSignatures: members.setterSignatures,
    );
  }

  static BridgedClass get setBase {
    final members = SetCore.definition;
    return BridgedClass(
      nativeType: SetBase,
      name: 'SetBase',
      typeParameterCount: members.typeParameterCount,
      canBeUsedAsMixin: true,
      isAbstract: true,
      staticMethods: {
        'setToString': (visitor, positional, named, typeArgs) =>
            SetBase.setToString(D4.unwrapAs<Set<Object?>>(positional[0])),
      },
      methods: members.methods,
      getters: members.getters,
      setters: members.setters,
      methodSignatures: members.methodSignatures,
      getterSignatures: members.getterSignatures,
      setterSignatures: members.setterSignatures,
    );
  }

  static BridgedClass get mapBase {
    final members = MapCore.definition;
    return BridgedClass(
      nativeType: MapBase,
      name: 'MapBase',
      typeParameterCount: members.typeParameterCount,
      canBeUsedAsMixin: true,
      isAbstract: true,
      staticMethods: {
        'mapToString': (visitor, positional, named, typeArgs) =>
            MapBase.mapToString(
              D4.unwrapAs<Map<Object?, Object?>>(positional[0]),
            ),
      },
      methods: members.methods,
      getters: members.getters,
      setters: members.setters,
      methodSignatures: members.methodSignatures,
      getterSignatures: members.getterSignatures,
      setterSignatures: members.setterSignatures,
    );
  }

  static BridgedClass get unmodifiableMapBase {
    final members = MapCore.definition;
    return BridgedClass(
      nativeType: UnmodifiableMapBase,
      name: 'UnmodifiableMapBase',
      typeParameterCount: members.typeParameterCount,
      canBeUsedAsMixin: false,
      isAbstract: true,
      methods: members.methods,
      getters: members.getters,
      setters: members.setters,
      methodSignatures: members.methodSignatures,
      getterSignatures: members.getterSignatures,
      setterSignatures: members.setterSignatures,
    );
  }

  /// The four bridges, in registration order.
  static List<BridgedClass> get definitions => [
    listBase,
    setBase,
    mapBase,
    unmodifiableMapBase,
  ];

  /// The typedef names, alias -> bridge.
  static const Map<String, String> aliases = {
    'IterableBase': 'Iterable',
    'IterableMixin': 'Iterable',
    'ListMixin': 'ListBase',
    'SetMixin': 'SetBase',
    'MapMixin': 'MapBase',
  };

  /// Defines the bridges and aliases in [environment], then the supertype
  /// edges and the receiver proxies.
  static void register(Environment environment) {
    for (final base in definitions) {
      environment.defineBridge(base);
    }
    for (final MapEntry(key: alias, value: target) in aliases.entries) {
      environment.defineBridgeAlias(alias, target);
    }
    BridgedClass.registerSupertypes(const {
      'ListBase': ['List'],
      'SetBase': ['Set'],
      'MapBase': ['Map'],
      'UnmodifiableMapBase': ['MapBase'],
    });
    for (final name in _bases.keys) {
      D4.registerInterfaceProxy(name, scriptCollectionProxy);
      D4.markProxyIsReceiver(name);
    }
  }
}

/// The receiver proxy of a script collection [instance]: an Iterable, List,
/// Set or Map by the bases on its class chain (the most specific wins: a
/// `SetBase` with `IterableMixin` is a set).
Object scriptCollectionProxy(
  InterpreterVisitor visitor,
  InterpretedInstance instance,
) {
  var kind = _Kind.iterable;
  var unmodifiable = false;
  final seen = <InterpretedClass>{};
  void walk(InterpretedClass? c) {
    if (c == null || !seen.add(c)) return;
    for (final bridged in [?c.bridgedSuperclass, ...c.bridgedMixins]) {
      final base = _bases[bridged.name];
      if (base == null) continue;
      if (base.$1.index > kind.index) kind = base.$1;
      unmodifiable = unmodifiable || base.$2;
    }
    walk(c.superclass);
    c.mixins.forEach(walk);
  }

  walk(instance.klass);
  final script = _Script(visitor, instance, unmodifiable);
  return switch (kind) {
    _Kind.iterable => _ScriptIterable(script),
    _Kind.list => _ScriptList(script),
    _Kind.set => _ScriptSet(script),
    _Kind.map when unmodifiable => _ScriptUnmodifiableMap(script),
    _Kind.map => _ScriptMap(script),
  };
}

/// The script instance a proxy forwards to.
final class _Script {
  _Script(this.visitor, this.instance, this.unmodifiable);

  final InterpreterVisitor visitor;
  final InterpretedInstance instance;

  /// An `Unmodifiable*` base is on the class chain: a mutator the script
  /// does not declare throws, as the SDK's mixin does.
  final bool unmodifiable;

  /// Whether the script declares [name] (a field, getter or method).
  bool has(String name) => instance.hasInstanceMember(name);

  Object? get(String name) => _native(instance.get(name, visitor: visitor));

  void set(String name, Object? value) => instance.set(name, value, visitor);

  Object? call(String name, List<Object?> arguments) {
    final callee = instance.get(name, visitor: visitor);
    if (callee is! Callable) {
      throw RuntimeD4rtException(
        "'${instance.klass.name}.$name' is not a method.",
      );
    }
    return _invoke(() => callee.call(visitor, arguments, const {}));
  }

  bool hasOperator(String symbol) =>
      instance.klass.findOperator(symbol) != null;

  Object? operator(String symbol, List<Object?> arguments) {
    final member = instance.klass.findOperator(symbol);
    if (member == null) throw missing(symbol);
    return _invoke(
      () => member.bind(instance).call(visitor, arguments, const {}),
    );
  }

  Object? _invoke(Object? Function() run) {
    try {
      return _native(run());
    } on ReturnException catch (e) {
      return _native(e.value);
    }
  }

  /// A member the SDK leaves abstract that the script does not implement.
  Error missing(String member) => unmodifiable
      ? UnsupportedError('Cannot modify an unmodifiable collection')
      : UnimplementedError(
          "'${instance.klass.name}' does not implement '$member', which its "
          'collection base leaves abstract.',
        );

  /// A value the script answers, as native code takes it.
  Object? _native(Object? value) => switch (value) {
    InterpretedInstance() => value,
    BridgedInstance() => value.nativeObject,
    BridgedEnumValue() => value.nativeValue,
    _ => value,
  };

  /// [value], answered by the script, as the native [T] - a script
  /// collection through its own proxy.
  T unwrap<T>(Object? value) => D4.unwrapAs<T>(value, visitor: visitor);

  /// The script's `iterator`, as a native [Iterator].
  Iterator<Object?> iterator() {
    final value = get('iterator');
    if (value is Iterator<Object?>) return value;
    if (value is InterpretedInstance) return _ScriptIterator(visitor, value);
    throw StateError(
      "'${instance.klass.name}.iterator' answered ${value.runtimeType}, not an "
      'Iterator.',
    );
  }
}

/// A script iterator, for native code.
final class _ScriptIterator implements Iterator<Object?> {
  _ScriptIterator(this._visitor, this._instance);

  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  bool moveNext() {
    final moveNext = _instance.get('moveNext', visitor: _visitor);
    try {
      return (moveNext as Callable).call(_visitor, const [], const {}) == true;
    } on ReturnException catch (e) {
      return e.value == true;
    }
  }

  @override
  Object? get current {
    final value = _instance.get('current', visitor: _visitor);
    return value is BridgedInstance ? value.nativeObject : value;
  }
}

/// A script collection's receiver proxy: the native Iterable, List, Set or
/// Map a script `IterableBase` / `ListBase` / ... subclass is in native
/// code. An argument crossing into native code is passed as it, and a value
/// coming back is the script instance again.
abstract interface class D4ScriptCollectionProxy implements D4InterpretedProxy {
  /// The script instance the proxy stands for.
  InterpretedInstance get scriptInstance;
}

/// The members every proxy shares: the instance it stands for.
mixin _Proxy implements D4ScriptCollectionProxy {
  _Script get _script;

  @override
  Object get d4rtInstance => _script.instance;

  @override
  InterpretedInstance get scriptInstance => _script.instance;
}

final class _ScriptIterable extends Iterable<Object?> with _Proxy {
  _ScriptIterable(this._script);

  @override
  final _Script _script;

  @override
  Iterator<Object?> get iterator => _script.iterator();

  @override
  int get length =>
      _script.has('length') ? _script.get('length') as int : super.length;

  @override
  bool contains(Object? element) => _script.has('contains')
      ? _script.call('contains', [element]) == true
      : super.contains(element);
}

final class _ScriptList extends ListBase<Object?> with _Proxy {
  _ScriptList(this._script);

  @override
  final _Script _script;

  @override
  int get length => _script.get('length') as int;

  @override
  set length(int newLength) {
    if (!_script.has('length') || _script.unmodifiable) {
      throw _script.missing('length=');
    }
    _script.set('length', newLength);
  }

  @override
  Object? operator [](int index) => _script.operator('[]', [index]);

  @override
  void operator []=(int index, Object? value) {
    if (!_script.hasOperator('[]=')) throw _script.missing('[]=');
    _script.operator('[]=', [index, value]);
  }
}

final class _ScriptSet extends SetBase<Object?> with _Proxy {
  _ScriptSet(this._script);

  @override
  final _Script _script;

  @override
  Iterator<Object?> get iterator => _script.iterator();

  @override
  int get length => _script.get('length') as int;

  @override
  bool contains(Object? element) => _script.call('contains', [element]) == true;

  @override
  Object? lookup(Object? element) => _script.call('lookup', [element]);

  @override
  bool add(Object? value) => _script.has('add')
      ? _script.call('add', [value]) == true
      : throw _script.missing('add');

  @override
  bool remove(Object? value) => _script.has('remove')
      ? _script.call('remove', [value]) == true
      : throw _script.missing('remove');

  @override
  void clear() =>
      _script.has('clear') ? _script.call('clear', const []) : super.clear();

  @override
  Set<Object?> toSet() => _script.has('toSet')
      ? _script.unwrap<Set<Object?>>(_script.call('toSet', const []))
      : {...this};
}

final class _ScriptMap extends MapBase<Object?, Object?> with _Proxy {
  _ScriptMap(this._script);

  @override
  final _Script _script;

  @override
  Object? operator [](Object? key) => _script.operator('[]', [key]);

  @override
  void operator []=(Object? key, Object? value) {
    if (!_script.hasOperator('[]=')) throw _script.missing('[]=');
    _script.operator('[]=', [key, value]);
  }

  @override
  Iterable<Object?> get keys =>
      _script.unwrap<Iterable<Object?>>(_script.get('keys'));

  @override
  Object? remove(Object? key) => _script.has('remove')
      ? _script.call('remove', [key])
      : throw _script.missing('remove');

  @override
  void clear() => _script.has('clear')
      ? _script.call('clear', const [])
      : throw _script.missing('clear');
}

/// `UnmodifiableMapBase`: the SDK's mutators throw, the script gives `[]`
/// and `keys`.
final class _ScriptUnmodifiableMap extends UnmodifiableMapBase<Object?, Object?>
    with _Proxy {
  _ScriptUnmodifiableMap(this._script);

  @override
  final _Script _script;

  @override
  Object? operator [](Object? key) => _script.operator('[]', [key]);

  @override
  Iterable<Object?> get keys =>
      _script.unwrap<Iterable<Object?>>(_script.get('keys'));
}
