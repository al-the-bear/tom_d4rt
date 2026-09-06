import 'dart:collection';
import 'dart:math';

import 'package:tom_d4rt/d4rt.dart';

/// Narrows [target] to the native view, or reports which member was reached
/// with the wrong receiver.
///
/// Every mutating adapter below needs this guard, so it lives here rather than
/// being re-inlined twenty times.
UnmodifiableListView _view(Object? target, String member) {
  if (target is UnmodifiableListView) return target;
  throw RuntimeD4rtException(
    "Target is not an UnmodifiableListView for '$member'",
  );
}

/// Narrows a script-supplied argument to an `int`, naming the member and
/// parameter so the script author knows which argument to fix.
int _int(Object? argument, String member, String parameter) {
  if (argument is int) return argument;
  throw RuntimeD4rtException(
    "Argument '$parameter' of UnmodifiableListView.$member must be an int.",
  );
}

/// Narrows a script-supplied argument to an [Iterable].
Iterable _iterable(Object? argument, String member, String parameter) {
  if (argument is Iterable) return argument;
  throw RuntimeD4rtException(
    "Argument '$parameter' of UnmodifiableListView.$member must be an Iterable.",
  );
}

/// Narrows a script-supplied argument to a callable.
///
/// Accepts any [Callable], not just [InterpretedFunction], so a bridged or
/// native function is as acceptable here as an interpreted closure.
Callable _callback(Object? argument, String member) {
  if (argument is Callable) return argument;
  throw RuntimeD4rtException(
    "Argument to UnmodifiableListView.$member must be a function.",
  );
}

class UnmodifiableListViewCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: UnmodifiableListView,
    name: 'UnmodifiableListView',
    isAssignable: (v) => v is UnmodifiableListView,
    typeParameterCount: 1,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Constructor UnmodifiableListView() expects one positional argument (the source list).",
          );
        }
        final sourceList = positionalArgs[0];
        if (sourceList is List) {
          return UnmodifiableListView<dynamic>(sourceList);
        }
        throw RuntimeD4rtException(
          "Argument to UnmodifiableListView() must be a List.",
        );
      },
    },
    methods: {
      '[]': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is UnmodifiableListView && positionalArgs.length == 1) {
          return target[positionalArgs[0] as int];
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView[] getter",
        );
      },
      // --- Mutating members -------------------------------------------
      // These delegate so the native view raises the SDK
      // `UnsupportedError` rather than a D4rt-specific exception. That is
      // what makes a mutation attempt catchable from script with
      // `on UnsupportedError`, matching the dart:collection contract and
      // the sibling map/set view bridges. Arguments are still checked
      // first, so a malformed call reports the argument problem instead of
      // the (equally true, but less useful) unsupported-operation error.
      //
      // The native view rejects every one of these before touching the
      // backing list, so the callbacks narrowed below are never actually
      // invoked; they are validated because an unmodifiable view is still
      // entitled to complain about a nonsensical call.
      '[]=': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView[]=",
          );
        }
        final index = _int(positionalArgs[0], '[]=', 'index');
        _view(target, '[]=')[index] = positionalArgs[1];
        return positionalArgs[1];
      },
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.add",
          );
        }
        _view(target, 'add').add(positionalArgs[0]);
        return null;
      },
      'addAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.addAll",
          );
        }
        _view(
          target,
          'addAll',
        ).addAll(_iterable(positionalArgs[0], 'addAll', 'iterable'));
        return null;
      },
      'clear': (visitor, target, positionalArgs, namedArgs, _) {
        _view(target, 'clear').clear();
        return null;
      },
      'insert': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.insert",
          );
        }
        final index = _int(positionalArgs[0], 'insert', 'index');
        _view(target, 'insert').insert(index, positionalArgs[1]);
        return null;
      },
      'insertAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.insertAll",
          );
        }
        final index = _int(positionalArgs[0], 'insertAll', 'index');
        _view(target, 'insertAll').insertAll(
          index,
          _iterable(positionalArgs[1], 'insertAll', 'iterable'),
        );
        return null;
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.remove",
          );
        }
        return _view(target, 'remove').remove(positionalArgs[0]);
      },
      'removeAt': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.removeAt",
          );
        }
        final index = _int(positionalArgs[0], 'removeAt', 'index');
        return _view(target, 'removeAt').removeAt(index);
      },
      'removeLast': (visitor, target, positionalArgs, namedArgs, _) {
        return _view(target, 'removeLast').removeLast();
      },
      'removeRange': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.removeRange",
          );
        }
        _view(target, 'removeRange').removeRange(
          _int(positionalArgs[0], 'removeRange', 'start'),
          _int(positionalArgs[1], 'removeRange', 'end'),
        );
        return null;
      },
      'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.removeWhere",
          );
        }
        final test = _callback(positionalArgs[0], 'removeWhere');
        _view(target, 'removeWhere').removeWhere((e) {
          final result = test.call(visitor, [e]);
          return result is bool && result;
        });
        return null;
      },
      'replaceRange': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 3) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.replaceRange",
          );
        }
        _view(target, 'replaceRange').replaceRange(
          _int(positionalArgs[0], 'replaceRange', 'start'),
          _int(positionalArgs[1], 'replaceRange', 'end'),
          _iterable(positionalArgs[2], 'replaceRange', 'replacements'),
        );
        return null;
      },
      'retainWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.retainWhere",
          );
        }
        final test = _callback(positionalArgs[0], 'retainWhere');
        _view(target, 'retainWhere').retainWhere((e) {
          final result = test.call(visitor, [e]);
          return result is bool && result;
        });
        return null;
      },
      'fillRange': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 2 || positionalArgs.length > 3) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.fillRange",
          );
        }
        _view(target, 'fillRange').fillRange(
          _int(positionalArgs[0], 'fillRange', 'start'),
          _int(positionalArgs[1], 'fillRange', 'end'),
          positionalArgs.length > 2 ? positionalArgs[2] : null,
        );
        return null;
      },
      'setAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.setAll",
          );
        }
        _view(target, 'setAll').setAll(
          _int(positionalArgs[0], 'setAll', 'index'),
          _iterable(positionalArgs[1], 'setAll', 'iterable'),
        );
        return null;
      },
      'setRange': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 3 || positionalArgs.length > 4) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.setRange",
          );
        }
        _view(target, 'setRange').setRange(
          _int(positionalArgs[0], 'setRange', 'start'),
          _int(positionalArgs[1], 'setRange', 'end'),
          _iterable(positionalArgs[2], 'setRange', 'iterable'),
          positionalArgs.length > 3
              ? _int(positionalArgs[3], 'setRange', 'skipCount')
              : 0,
        );
        return null;
      },
      'shuffle': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length > 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.shuffle",
          );
        }
        Random? random;
        if (positionalArgs.length == 1 && positionalArgs[0] != null) {
          final candidate = positionalArgs[0];
          if (candidate is! Random) {
            throw RuntimeD4rtException(
              "Argument to UnmodifiableListView.shuffle must be a Random.",
            );
          }
          random = candidate;
        }
        _view(target, 'shuffle').shuffle(random);
        return null;
      },
      'sort': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length > 1) {
          throw RuntimeD4rtException(
            "Invalid arguments for UnmodifiableListView.sort",
          );
        }
        int Function(dynamic, dynamic)? compare;
        if (positionalArgs.length == 1 && positionalArgs[0] != null) {
          final comparator = _callback(positionalArgs[0], 'sort');
          compare = (a, b) {
            final result = comparator.call(visitor, [a, b]);
            if (result is int) return result;
            throw RuntimeD4rtException(
              "Comparator for 'sort' must return an int.",
            );
          };
        }
        _view(target, 'sort').sort(compare);
        return null;
      },
      'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          return t.elementAt(positionalArgs[0] as int);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.elementAt",
        );
      },
      'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 && positionalArgs[0] is Iterable) {
          return t.followedBy(positionalArgs[0] as Iterable);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.followedBy",
        );
      },
      'forEach': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final action = positionalArgs[0] as InterpretedFunction;
          for (var element in t) {
            action.call(visitor, [element]);
          }
          return null;
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.forEach",
        );
      },
      'map': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final toElement = positionalArgs[0] as InterpretedFunction;
          return t.map((e) => toElement.call(visitor, [e]));
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.map",
        );
      },
      'where': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          return t.where((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'where' must return a bool.",
            );
          });
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.where",
        );
      },
      'any': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          return t.any((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'any' must return a bool.",
            );
          });
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.any",
        );
      },
      'every': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          return t.every((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'every' must return a bool.",
            );
          });
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.every",
        );
      },
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1) {
          return t.contains(positionalArgs[0]);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.contains",
        );
      },
      'indexOf': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.isNotEmpty) {
          final element = positionalArgs[0];
          final startIndex = positionalArgs.length > 1
              ? (positionalArgs[1] as int? ?? 0)
              : 0;
          return t.indexOf(element, startIndex);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.indexOf",
        );
      },
      'lastIndexOf': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.isNotEmpty) {
          final element = positionalArgs[0];
          final startIndex = positionalArgs.length > 1
              ? (positionalArgs[1] as int?)
              : null;
          return t.lastIndexOf(element, startIndex);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.lastIndexOf",
        );
      },
      'join': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        String separator = "";
        if (positionalArgs.isNotEmpty) {
          separator = positionalArgs[0] as String? ?? "";
        }
        return t.join(separator);
      },
      'getRange': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 2 &&
            positionalArgs[0] is int &&
            positionalArgs[1] is int) {
          return t.getRange(positionalArgs[0] as int, positionalArgs[1] as int);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.getRange",
        );
      },
      'sublist': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.isNotEmpty && positionalArgs[0] is int) {
          final start = positionalArgs[0] as int;
          final end = positionalArgs.length > 1
              ? positionalArgs[1] as int?
              : null;
          return t.sublist(start, end);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.sublist",
        );
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        bool growable = namedArgs['growable'] as bool? ?? true;
        if (positionalArgs.isEmpty) {
          return t.toList(growable: growable);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.toList",
        );
      },
      'toSet': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.isEmpty) {
          return t.toSet();
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.toSet",
        );
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        var castedSource = t.cast<dynamic>();
        return UnmodifiableListView(castedSource.toList());
      },
      'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          final orElse = namedArgs['orElse'] as InterpretedFunction?;
          return t.singleWhere((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'singleWhere' must return a bool.",
            );
          }, orElse: orElse == null ? null : () => orElse.call(visitor, []));
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.singleWhere",
        );
      },
      'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          final orElse = namedArgs['orElse'] as InterpretedFunction?;
          return t.firstWhere((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'firstWhere' must return a bool.",
            );
          }, orElse: orElse == null ? null : () => orElse.call(visitor, []));
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.firstWhere",
        );
      },
      'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          final orElse = namedArgs['orElse'] as InterpretedFunction?;
          return t.lastWhere((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'lastWhere' must return a bool.",
            );
          }, orElse: orElse == null ? null : () => orElse.call(visitor, []));
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.lastWhere",
        );
      },
      'skip': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          return t.skip(positionalArgs[0] as int);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.skip",
        );
      },
      'take': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          return t.take(positionalArgs[0] as int);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.take",
        );
      },
      'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          return t.skipWhile((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'skipWhile' must return a bool.",
            );
          });
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.skipWhile",
        );
      },
      'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final test = positionalArgs[0] as InterpretedFunction;
          return t.takeWhile((e) {
            final result = test.call(visitor, [e]);
            if (result is bool) return result;
            throw RuntimeD4rtException(
              "Test function for 'takeWhile' must return a bool.",
            );
          });
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.takeWhile",
        );
      },
      'expand': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final toElements = positionalArgs[0] as InterpretedFunction;
          return t.expand((e) {
            final result = toElements.call(visitor, [e]);
            if (result is Iterable) return result;
            throw RuntimeD4rtException(
              "Function for 'expand' must return an Iterable.",
            );
          });
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.expand",
        );
      },
      'fold': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 2 &&
            positionalArgs[1] is InterpretedFunction) {
          final initialValue = positionalArgs[0];
          final combine = positionalArgs[1] as InterpretedFunction;
          return t.fold(
            initialValue,
            (prev, e) => combine.call(visitor, [prev, e]),
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.fold",
        );
      },
      'reduce': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.length == 1 &&
            positionalArgs[0] is InterpretedFunction) {
          final combine = positionalArgs[0] as InterpretedFunction;
          return t.reduce((prev, e) => combine.call(visitor, [prev, e]));
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.reduce",
        );
      },
      'asMap': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.isEmpty && namedArgs.isEmpty) {
          return t.asMap();
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.asMap",
        );
      },
      'reversed': (visitor, target, positionalArgs, namedArgs, _) {
        final t = target as UnmodifiableListView;
        if (positionalArgs.isEmpty && namedArgs.isEmpty) {
          return t.reversed;
        }
        throw RuntimeD4rtException(
          "Invalid arguments for UnmodifiableListView.reversed",
        );
      },
    },
    getters: {
      'length': (visitor, target) {
        if (target is UnmodifiableListView) return target.length;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'length'",
        );
      },
      'isEmpty': (visitor, target) {
        if (target is UnmodifiableListView) return target.isEmpty;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'isEmpty'",
        );
      },
      'isNotEmpty': (visitor, target) {
        if (target is UnmodifiableListView) return target.isNotEmpty;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'isNotEmpty'",
        );
      },
      'iterator': (visitor, target) {
        if (target is UnmodifiableListView) return target.iterator;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'iterator'",
        );
      },
      'reversed': (visitor, target) {
        if (target is UnmodifiableListView) return target.reversed;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'reversed'",
        );
      },
      'hashCode': (visitor, target) {
        if (target is UnmodifiableListView) return target.hashCode;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'hashCode'",
        );
      },
      'runtimeType': (visitor, target) {
        if (target is UnmodifiableListView) return target.runtimeType;
        throw RuntimeD4rtException(
          "Target is not an UnmodifiableListView for getter 'runtimeType'",
        );
      },
    },
    // The mutating setters delegate for the same reason as the mutating
    // methods above: the SDK's `UnsupportedError` has to reach the script.
    setters: {
      'length': (visitor, target, value) {
        _view(target, 'length=').length = _int(value, 'length=', 'value');
      },
      'first': (visitor, target, value) {
        _view(target, 'first=').first = value;
      },
      'last': (visitor, target, value) {
        _view(target, 'last=').last = value;
      },
    },
  );
}
