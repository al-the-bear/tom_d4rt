import 'dart:collection';

import 'package:tom_d4rt_ast/runtime.dart';

/// Narrows [target] to the native view, or reports which member was reached
/// with the wrong receiver.
///
/// Every adapter below needs this guard, so it lives here rather than being
/// re-inlined thirty times.
UnmodifiableMapView _view(Object? target, String member) {
  if (target is UnmodifiableMapView) return target;
  throw RuntimeD4rtException(
    "Target is not an UnmodifiableMapView for '$member'",
  );
}

/// Narrows a script-supplied argument to a callable, naming the member that
/// received it so the script author knows which call site to fix.
Callable _callback(Object? argument, String member) {
  if (argument is Callable) return argument;
  throw RuntimeD4rtException(
    "Argument to UnmodifiableMapView.$member must be a function.",
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
    'UnmodifiableMapView.map callback must return a MapEntry, got ${result.runtimeType}',
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
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Constructor UnmodifiableMapView() expects one positional argument (the source map).",
          );
        }
        final source = positionalArgs[0];
        if (source is Map) {
          return UnmodifiableMapView<dynamic, dynamic>(source);
        }
        throw RuntimeD4rtException(
          "Argument to UnmodifiableMapView() must be a Map.",
        );
      },
    },
    methods: {
      '[]': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView[]",
          );
        }
        return _view(target, '[]')[positionalArgs[0]];
      },
      'containsKey': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.containsKey",
          );
        }
        return _view(target, 'containsKey').containsKey(positionalArgs[0]);
      },
      'containsValue': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.containsValue",
          );
        }
        return _view(target, 'containsValue').containsValue(positionalArgs[0]);
      },
      'forEach': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.forEach",
          );
        }
        final action = _callback(positionalArgs[0], 'forEach');
        _view(target, 'forEach').forEach((key, value) {
          action.call(visitor, [key, value]);
        });
        return null;
      },
      'map': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.map",
          );
        }
        final convert = _callback(positionalArgs[0], 'map');
        return _view(
          target,
          'map',
        ).map((key, value) => _asMapEntry(convert.call(visitor, [key, value])));
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return _view(target, 'cast').cast<dynamic, dynamic>();
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
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView[]=",
          );
        }
        _view(target, '[]=')[positionalArgs[0]] = positionalArgs[1];
        return positionalArgs[1];
      },
      'addAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Map) {
          throw RuntimeD4rtException(
            "Argument to UnmodifiableMapView.addAll must be a Map.",
          );
        }
        _view(target, 'addAll').addAll(positionalArgs[0] as Map);
        return null;
      },
      'addEntries': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Iterable) {
          throw RuntimeD4rtException(
            "Argument to UnmodifiableMapView.addEntries must be an Iterable.",
          );
        }
        _view(
          target,
          'addEntries',
        ).addEntries((positionalArgs[0] as Iterable).cast());
        return null;
      },
      'clear': (visitor, target, positionalArgs, namedArgs, _) {
        _view(target, 'clear').clear();
        return null;
      },
      'putIfAbsent': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.putIfAbsent",
          );
        }
        final ifAbsent = _callback(positionalArgs[1], 'putIfAbsent');
        return _view(
          target,
          'putIfAbsent',
        ).putIfAbsent(positionalArgs[0], () => ifAbsent.call(visitor, []));
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.remove",
          );
        }
        return _view(target, 'remove').remove(positionalArgs[0]);
      },
      'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.removeWhere",
          );
        }
        final test = _callback(positionalArgs[0], 'removeWhere');
        _view(target, 'removeWhere').removeWhere((key, value) {
          final result = test.call(visitor, [key, value]);
          return result is bool && result;
        });
        return null;
      },
      'update': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.update",
          );
        }
        final update = _callback(positionalArgs[1], 'update');
        final ifAbsent = namedArgs['ifAbsent'] as Callable?;
        return _view(target, 'update').update(
          positionalArgs[0],
          (value) => update.call(visitor, [value]),
          ifAbsent: ifAbsent == null ? null : () => ifAbsent.call(visitor, []),
        );
      },
      'updateAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableMapView.updateAll",
          );
        }
        final update = _callback(positionalArgs[0], 'updateAll');
        _view(
          target,
          'updateAll',
        ).updateAll((key, value) => update.call(visitor, [key, value]));
        return null;
      },
    },
    getters: {
      'length': (visitor, target) => _view(target, 'length').length,
      'isEmpty': (visitor, target) => _view(target, 'isEmpty').isEmpty,
      'isNotEmpty': (visitor, target) => _view(target, 'isNotEmpty').isNotEmpty,
      'keys': (visitor, target) => _view(target, 'keys').keys,
      'values': (visitor, target) => _view(target, 'values').values,
      'entries': (visitor, target) => _view(target, 'entries').entries,
      'hashCode': (visitor, target) => _view(target, 'hashCode').hashCode,
      'runtimeType': (visitor, target) =>
          _view(target, 'runtimeType').runtimeType,
    },
  );
}
