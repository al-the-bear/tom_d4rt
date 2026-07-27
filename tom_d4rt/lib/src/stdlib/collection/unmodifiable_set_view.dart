import 'dart:collection';

import 'package:tom_d4rt/d4rt.dart';

/// Narrows [target] to the native view, or reports which member was reached
/// with the wrong receiver.
///
/// Every adapter below needs this guard, so it lives here rather than being
/// re-inlined for each of the thirty-odd members.
UnmodifiableSetView _view(Object? target, String member) {
  if (target is UnmodifiableSetView) return target;
  throw RuntimeD4rtException(
      "Target is not an UnmodifiableSetView for '$member'");
}

/// Narrows a script-supplied argument to a callable, naming the member that
/// received it so the script author knows which call site to fix.
Callable _callback(Object? argument, String member) {
  if (argument is Callable) return argument;
  throw RuntimeD4rtException(
      "Argument to UnmodifiableSetView.$member must be a function.");
}

/// Narrows a script-supplied argument to an iterable.
Iterable<dynamic> _iterable(Object? argument, String member) {
  if (argument is Iterable) return argument;
  throw RuntimeD4rtException(
      "Argument to UnmodifiableSetView.$member must be an Iterable.");
}

/// Turns a script predicate into a Dart one, treating a non-`bool` result as
/// `false` — the same leniency the other collection bridges apply.
bool Function(dynamic) _predicate(
    InterpreterVisitor visitor, Object? argument, String member) {
  final test = _callback(argument, member);
  return (element) {
    final result = test.call(visitor, [element]);
    return result is bool && result;
  };
}

/// Bridge for `dart:collection`'s [UnmodifiableSetView].
///
/// See [UnmodifiableMapViewCollection] for the rationale shared by both view
/// bridges — in particular, why the mutating members delegate to the native
/// view rather than raising a [RuntimeD4rtException] of their own.
class UnmodifiableSetViewCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: UnmodifiableSetView,
        name: 'UnmodifiableSetView',
        isAssignable: (v) => v is UnmodifiableSetView,
        typeParameterCount: 1,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  "Constructor UnmodifiableSetView() expects one positional argument (the source set).");
            }
            final source = positionalArgs[0];
            if (source is Set) {
              return UnmodifiableSetView<dynamic>(source);
            }
            throw RuntimeD4rtException(
                "Argument to UnmodifiableSetView() must be a Set.");
          },
        },
        methods: {
          'contains': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'contains').contains(positionalArgs[0]);
          },
          'containsAll': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'containsAll')
                .containsAll(_iterable(positionalArgs[0], 'containsAll'));
          },
          'lookup': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'lookup').lookup(positionalArgs[0]);
          },
          'difference': (visitor, target, positionalArgs, namedArgs, _) {
            final other = positionalArgs[0];
            if (other is! Set) {
              throw RuntimeD4rtException(
                  "Argument to UnmodifiableSetView.difference must be a Set.");
            }
            return _view(target, 'difference').difference(other);
          },
          'intersection': (visitor, target, positionalArgs, namedArgs, _) {
            final other = positionalArgs[0];
            if (other is! Set) {
              throw RuntimeD4rtException(
                  "Argument to UnmodifiableSetView.intersection must be a Set.");
            }
            return _view(target, 'intersection').intersection(other);
          },
          'union': (visitor, target, positionalArgs, namedArgs, _) {
            final other = positionalArgs[0];
            if (other is! Set) {
              throw RuntimeD4rtException(
                  "Argument to UnmodifiableSetView.union must be a Set.");
            }
            return _view(target, 'union').union(other);
          },
          'forEach': (visitor, target, positionalArgs, namedArgs, _) {
            final action = _callback(positionalArgs[0], 'forEach');
            for (final element in _view(target, 'forEach')) {
              action.call(visitor, [element]);
            }
            return null;
          },
          'map': (visitor, target, positionalArgs, namedArgs, _) {
            final f = _callback(positionalArgs[0], 'map');
            return _view(target, 'map')
                .map((element) => f.call(visitor, [element]));
          },
          'where': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'where')
                .where(_predicate(visitor, positionalArgs[0], 'where'));
          },
          'whereType': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'whereType').whereType<dynamic>();
          },
          'expand': (visitor, target, positionalArgs, namedArgs, _) {
            final f = _callback(positionalArgs[0], 'expand');
            return _view(target, 'expand').expand((element) {
              final result = f.call(visitor, [element]);
              return result is Iterable ? result : const [];
            });
          },
          'any': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'any')
                .any(_predicate(visitor, positionalArgs[0], 'any'));
          },
          'every': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'every')
                .every(_predicate(visitor, positionalArgs[0], 'every'));
          },
          'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'takeWhile')
                .takeWhile(_predicate(visitor, positionalArgs[0], 'takeWhile'));
          },
          'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'skipWhile')
                .skipWhile(_predicate(visitor, positionalArgs[0], 'skipWhile'));
          },
          'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
            final orElse = namedArgs['orElse'] as Callable?;
            return _view(target, 'firstWhere').firstWhere(
              _predicate(visitor, positionalArgs[0], 'firstWhere'),
              orElse: orElse == null ? null : () => orElse.call(visitor, []),
            );
          },
          'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
            final orElse = namedArgs['orElse'] as Callable?;
            return _view(target, 'lastWhere').lastWhere(
              _predicate(visitor, positionalArgs[0], 'lastWhere'),
              orElse: orElse == null ? null : () => orElse.call(visitor, []),
            );
          },
          'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
            final orElse = namedArgs['orElse'] as Callable?;
            return _view(target, 'singleWhere').singleWhere(
              _predicate(visitor, positionalArgs[0], 'singleWhere'),
              orElse: orElse == null ? null : () => orElse.call(visitor, []),
            );
          },
          'fold': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 2) {
              throw RuntimeD4rtException(
                  "Invalid arguments for UnmodifiableSetView.fold");
            }
            final combine = _callback(positionalArgs[1], 'fold');
            return _view(target, 'fold').fold(
                positionalArgs[0],
                (previousValue, element) =>
                    combine.call(visitor, [previousValue, element]));
          },
          'reduce': (visitor, target, positionalArgs, namedArgs, _) {
            final combine = _callback(positionalArgs[0], 'reduce');
            return _view(target, 'reduce').reduce(
                (value, element) => combine.call(visitor, [value, element]));
          },
          'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'followedBy')
                .followedBy(_iterable(positionalArgs[0], 'followedBy'));
          },
          'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'elementAt')
                .elementAt(positionalArgs[0] as int);
          },
          'take': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'take').take(positionalArgs[0] as int);
          },
          'skip': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'skip').skip(positionalArgs[0] as int);
          },
          'join': (visitor, target, positionalArgs, namedArgs, _) {
            final separator =
                positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
            return _view(target, 'join').join(separator);
          },
          'toList': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'toList')
                .toList(growable: namedArgs['growable'] as bool? ?? true);
          },
          'toSet': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'toSet').toSet();
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'cast').cast<dynamic>();
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'toString').toString();
          },
          // --- Mutating members -------------------------------------------
          // Delegated on purpose so the native view raises the SDK
          // `UnsupportedError` that scripts already catch via
          // `on UnsupportedError`.
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'add').add(positionalArgs[0]);
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            _view(target, 'addAll')
                .addAll(_iterable(positionalArgs[0], 'addAll'));
            return null;
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            return _view(target, 'remove').remove(positionalArgs[0]);
          },
          'removeAll': (visitor, target, positionalArgs, namedArgs, _) {
            _view(target, 'removeAll')
                .removeAll(_iterable(positionalArgs[0], 'removeAll'));
            return null;
          },
          'retainAll': (visitor, target, positionalArgs, namedArgs, _) {
            _view(target, 'retainAll')
                .retainAll(_iterable(positionalArgs[0], 'retainAll'));
            return null;
          },
          'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
            _view(target, 'removeWhere').removeWhere(
                _predicate(visitor, positionalArgs[0], 'removeWhere'));
            return null;
          },
          'retainWhere': (visitor, target, positionalArgs, namedArgs, _) {
            _view(target, 'retainWhere').retainWhere(
                _predicate(visitor, positionalArgs[0], 'retainWhere'));
            return null;
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            _view(target, 'clear').clear();
            return null;
          },
        },
        getters: {
          'length': (visitor, target) => _view(target, 'length').length,
          'isEmpty': (visitor, target) => _view(target, 'isEmpty').isEmpty,
          'isNotEmpty': (visitor, target) =>
              _view(target, 'isNotEmpty').isNotEmpty,
          'first': (visitor, target) => _view(target, 'first').first,
          'last': (visitor, target) => _view(target, 'last').last,
          'single': (visitor, target) => _view(target, 'single').single,
          'iterator': (visitor, target) => _view(target, 'iterator').iterator,
          'hashCode': (visitor, target) => _view(target, 'hashCode').hashCode,
          'runtimeType': (visitor, target) =>
              _view(target, 'runtimeType').runtimeType,
        },
      );
}
