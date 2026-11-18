import 'dart:collection';

import 'package:tom_d4rt/d4rt.dart';
import '../cast_views.dart';

/// Narrows [target] to the native view, or reports which member was reached
/// with the wrong receiver.
///
/// Every adapter below needs this guard, so it lives here rather than being
/// re-inlined thirty times.
MapView _view(Object? target, String member) {
  if (target is MapView) return target;
  throw RuntimeD4rtException("Target is not a MapView for '$member'");
}

/// Narrows a script-supplied argument to a callable, naming the member that
/// received it so the script author knows which call site to fix.
Callable _callback(Object? argument, String member) {
  if (argument is Callable) return argument;
  throw RuntimeD4rtException(
    "Argument to the map view's $member must be a function.",
  );
}

/// Unwraps whatever a script `map` callback returned into a native [MapEntry].
///
/// Interpreted code may hand back either a native entry or a bridged one
/// depending on how the entry was constructed, so both shapes are accepted —
/// this mirrors the core `Map` bridge.
MapEntry<dynamic, dynamic> _asMapEntry(Object? result) {
  if (result is MapEntry) return result;
  if (result is BridgedInstance && result.nativeObject is MapEntry) {
    return result.nativeObject as MapEntry;
  }
  throw RuntimeD4rtException(
    'The map view\'s map callback must return a MapEntry, got ${result.runtimeType}',
  );
}

/// Bridge for `dart:collection`'s [UnmodifiableMapView].
///
/// `Map.unmodifiable(...)` already produced this runtime type before the bridge
/// existed, and the core `Map` bridge claimed it by name — so reads worked but
/// the *type* could not be named. Registering it here makes
/// `UnmodifiableMapView(...)`, `on UnmodifiableMapView` and
/// `x is UnmodifiableMapView` resolve.
///
/// The mutating members deliberately **delegate to the native view** instead of
/// throwing a [RuntimeD4rtException] themselves. The native call raises the SDK
/// `UnsupportedError`, which is what scripts already catch today via
/// `on UnsupportedError`; intercepting it here would silently break them.
class UnmodifiableMapViewCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: UnmodifiableMapView,
    name: 'UnmodifiableMapView',
    isAssignable: (v) => v is UnmodifiableMapView,
    typeParameterCount: 2,
    constructors: _mapViewConstructors(
      'UnmodifiableMapView',
      (source) => UnmodifiableMapView<dynamic, dynamic>(source),
    ),
    methods: _mapViewMethods('UnmodifiableMapView'),
    getters: _mapViewGetters,
  );
}

/// Bridge for `dart:collection`'s [MapView] (ghissues71).
///
/// A view of a map that forwards every member to it - path's
/// `class PathMap<V> extends MapView<String?, V>` is why it is bridged: an
/// interpreted class extending it gets the native view as its bridged super
/// object, `super(map)` building it, and every member it does not declare
/// reaches the wrapped map through the adapters below. The adapters are
/// [UnmodifiableMapViewCollection]'s; a [MapView] lets the mutating ones
/// through.
class MapViewCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: MapView,
    name: 'MapView',
    isAssignable: (v) => v is MapView,
    typeParameterCount: 2,
    constructors: _mapViewConstructors(
      'MapView',
      (source) => MapView<dynamic, dynamic>(source),
    ),
    methods: _mapViewMethods('MapView'),
    getters: _mapViewGetters,
  );
}

/// The constructor [MapView] and [UnmodifiableMapView] share: a view of the
/// map passed in, built by [create].
Map<String, BridgedConstructorCallable> _mapViewConstructors(
  String name,
  Map<dynamic, dynamic> Function(Map<dynamic, dynamic> source) create,
) => {
  '': (visitor, positionalArgs, namedArgs) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException(
        "Constructor $name() expects one positional argument (the source map).",
      );
    }
    final source = positionalArgs[0];
    if (source is Map) {
      return create(source);
    }
    throw RuntimeD4rtException("Argument to $name() must be a Map.");
  },
};

/// The methods [MapView] and [UnmodifiableMapView] share: every member
/// forwards to the native view, which reads and writes its map, or raises
/// the SDK's `UnsupportedError` for a mutation of an unmodifiable one.
Map<String, BridgedMethodAdapter> _mapViewMethods(String name) => {
  '[]': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name[]");
    }
    return _view(target, '[]')[positionalArgs[0]];
  },
  'containsKey': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.containsKey");
    }
    return _view(target, 'containsKey').containsKey(positionalArgs[0]);
  },
  'containsValue': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.containsValue");
    }
    return _view(target, 'containsValue').containsValue(positionalArgs[0]);
  },
  'forEach': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.forEach");
    }
    final action = _callback(positionalArgs[0], 'forEach');
    _view(target, 'forEach').forEach((key, value) {
      D4.enterInterpreted(visitor, action, [key, value]);
    });
    return null;
  },
  'map': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.map");
    }
    final convert = _callback(positionalArgs[0], 'map');
    return _view(target, 'map').map(
      (key, value) =>
          _asMapEntry(D4.enterInterpreted(visitor, convert, [key, value])),
    );
  },
  'cast': (visitor, target, positionalArgs, namedArgs, typeArgs) {
    return castMap(visitor, _view(target, 'cast'), typeArgs);
  },
  'toString': (visitor, target, positionalArgs, namedArgs, _) {
    return _view(target, 'toString').toString();
  },
  // --- Mutating members -------------------------------------------
  // These delegate so the native view raises the SDK `UnsupportedError`
  // rather than a D4rt-specific exception. Arguments are still checked
  // first, so a malformed call reports the argument problem instead of
  // the (equally true, but less useful) unsupported-operation error.
  '[]=': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 2) {
      throw RuntimeD4rtException("Invalid arguments for $name[]=");
    }
    _view(target, '[]=')[positionalArgs[0]] = positionalArgs[1];
    // As the `Map` adapter: the operator returns nothing (SCC51).
    return null;
  },
  'addAll': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1 || positionalArgs[0] is! Map) {
      throw RuntimeD4rtException("Argument to $name.addAll must be a Map.");
    }
    _view(target, 'addAll').addAll(positionalArgs[0] as Map);
    return null;
  },
  'clear': (visitor, target, positionalArgs, namedArgs, _) {
    _view(target, 'clear').clear();
    return null;
  },
  'putIfAbsent': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 2) {
      throw RuntimeD4rtException("Invalid arguments for $name.putIfAbsent");
    }
    final ifAbsent = _callback(positionalArgs[1], 'putIfAbsent');
    return _view(target, 'putIfAbsent').putIfAbsent(
      positionalArgs[0],
      () => D4.enterInterpreted(visitor, ifAbsent, []),
    );
  },
  'remove': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.remove");
    }
    return _view(target, 'remove').remove(positionalArgs[0]);
  },
  'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.removeWhere");
    }
    final test = _callback(positionalArgs[0], 'removeWhere');
    _view(target, 'removeWhere').removeWhere((key, value) {
      final result = D4.enterInterpreted(visitor, test, [key, value]);
      return result is bool && result;
    });
    return null;
  },
  'update': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 2) {
      throw RuntimeD4rtException("Invalid arguments for $name.update");
    }
    final update = _callback(positionalArgs[1], 'update');
    final ifAbsent = namedArgs['ifAbsent'] as Callable?;
    return _view(target, 'update').update(
      positionalArgs[0],
      (value) => D4.enterInterpreted(visitor, update, [value]),
      ifAbsent: ifAbsent == null
          ? null
          : () => D4.enterInterpreted(visitor, ifAbsent, []),
    );
  },
  'updateAll': (visitor, target, positionalArgs, namedArgs, _) {
    if (positionalArgs.length != 1) {
      throw RuntimeD4rtException("Invalid arguments for $name.updateAll");
    }
    final update = _callback(positionalArgs[0], 'updateAll');
    _view(target, 'updateAll').updateAll(
      (key, value) => D4.enterInterpreted(visitor, update, [key, value]),
    );
    return null;
  },
};

/// The getters [MapView] and [UnmodifiableMapView] share.
final Map<String, BridgedInstanceGetterAdapter> _mapViewGetters = {
  'length': (visitor, target) => _view(target, 'length').length,
  'isEmpty': (visitor, target) => _view(target, 'isEmpty').isEmpty,
  'isNotEmpty': (visitor, target) => _view(target, 'isNotEmpty').isNotEmpty,
  'keys': (visitor, target) => _view(target, 'keys').keys,
  'values': (visitor, target) => _view(target, 'values').values,
  'entries': (visitor, target) => _view(target, 'entries').entries,
  'hashCode': (visitor, target) => _view(target, 'hashCode').hashCode,
  'runtimeType': (visitor, target) => _view(target, 'runtimeType').runtimeType,
};
