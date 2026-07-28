import 'dart:collection';

import 'package:tom_d4rt_ast/runtime.dart';

import 'set_algebra_methods.dart';

/// Adapts an optional script-supplied `compare` argument into a native
/// [Comparator], or returns `null` so the native constructor falls back to
/// [Comparable.compare].
///
/// All three `SplayTreeSet` constructors accept the same optional argument, so
/// the conversion lives here rather than being repeated per constructor.
int Function(dynamic, dynamic)? _asComparator(
    InterpreterVisitor visitor, Object? argument, String constructorName) {
  if (argument == null) return null;
  if (argument is! InterpretedFunction) {
    throw RuntimeD4rtException(
        "The 'compare' argument to $constructorName must be a function.");
  }
  return (a, b) {
    final result = argument.call(visitor, [a, b]);
    if (result is int) return result;
    throw RuntimeD4rtException("Compare function must return an int.");
  };
}

/// Bridge for `dart:collection`'s [SplayTreeSet] — a [Set] whose iteration
/// order is sorted, either by [Comparable.compare] or by a `compare` function
/// supplied to the constructor.
///
/// The member surface mirrors [HashSetCollection]; only the constructors
/// differ, because each of them accepts the optional comparator.
class SplayTreeSetCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: SplayTreeSet,
        name: 'SplayTreeSet',
        isAssignable: (v) => v is SplayTreeSet,
        typeParameterCount: 1,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length > 1) {
              throw RuntimeD4rtException(
                  "Constructor SplayTreeSet() takes at most one positional argument for the compare function.");
            }
            return SplayTreeSet<dynamic>(_asComparator(visitor,
                positionalArgs.isEmpty ? null : positionalArgs[0], 'SplayTreeSet()'));
          },
          'from': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty || positionalArgs.length > 2) {
              throw RuntimeD4rtException(
                  "Constructor SplayTreeSet.from() expects one or two positional arguments (elements, [compare]).");
            }
            final elements = positionalArgs[0];
            if (elements is! Iterable) {
              throw RuntimeD4rtException(
                  "First argument to SplayTreeSet.from must be an Iterable.");
            }
            return SplayTreeSet<dynamic>.from(
                elements,
                _asComparator(visitor,
                    positionalArgs.length > 1 ? positionalArgs[1] : null,
                    'SplayTreeSet.from()'));
          },
          'of': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty || positionalArgs.length > 2) {
              throw RuntimeD4rtException(
                  "Constructor SplayTreeSet.of() expects one or two positional arguments (elements, [compare]).");
            }
            final elements = positionalArgs[0];
            if (elements is! Iterable) {
              throw RuntimeD4rtException(
                  "First argument to SplayTreeSet.of must be an Iterable.");
            }
            return SplayTreeSet<dynamic>.of(
                elements,
                _asComparator(visitor,
                    positionalArgs.length > 1 ? positionalArgs[1] : null,
                    'SplayTreeSet.of()'));
          },
        },
        methods: {
          // Not reachable through the Set bridge: the interpreter's
          // supertype fallback for instance methods is not uniform.
          ...setAlgebraMethods('SplayTreeSet', (t) => t as Set),
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              return target.add(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.add");
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final elements = positionalArgs[0];
              if (elements is Iterable) {
                target.addAll(elements);
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.addAll must be an Iterable.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.addAll");
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              target.clear();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.clear");
          },
          'contains': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              return target.contains(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.contains");
          },
          'containsAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final elements = positionalArgs[0];
              if (elements is Iterable) {
                return target.containsAll(elements);
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.containsAll must be an Iterable.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.containsAll");
          },
          'forEach': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final action = positionalArgs[0];
              if (action is InterpretedFunction) {
                for (var element in target) {
                  action.call(visitor, [element]);
                }
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.forEach must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.forEach");
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              return target.remove(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.remove");
          },
          'removeAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final elements = positionalArgs[0];
              if (elements is Iterable) {
                target.removeAll(elements);
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.removeAll must be an Iterable.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.removeAll");
          },
          'retainAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final elements = positionalArgs[0];
              if (elements is Iterable) {
                target.retainAll(elements);
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.retainAll must be an Iterable.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.retainAll");
          },
          'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                target.removeWhere((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.removeWhere must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.removeWhere");
          },
          'retainWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                target.retainWhere((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.retainWhere must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.retainWhere");
          },
          'any': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                return target.any((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
              }
              throw RuntimeD4rtException("Argument to SplayTreeSet.any must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.any");
          },
          'every': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                return target.every((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.every must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.every");
          },
          'where': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                return target.where((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.where must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.where");
          },
          'map': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final f = positionalArgs[0];
              if (f is InterpretedFunction) {
                return target.map((element) => f.call(visitor, [element]));
              }
              throw RuntimeD4rtException("Argument to SplayTreeSet.map must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.map");
          },
          'expand': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final f = positionalArgs[0];
              if (f is InterpretedFunction) {
                return target.expand((element) {
                  final result = f.call(visitor, [element]);
                  return result is Iterable ? result : [];
                });
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.expand must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.expand");
          },
          'fold': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 2) {
              final initialValue = positionalArgs[0];
              final combine = positionalArgs[1];
              if (combine is InterpretedFunction) {
                return target.fold(
                    initialValue,
                    (previousValue, element) =>
                        combine.call(visitor, [previousValue, element]));
              }
              throw RuntimeD4rtException(
                  "Second argument to SplayTreeSet.fold must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.fold");
          },
          'reduce': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final combine = positionalArgs[0];
              if (combine is InterpretedFunction) {
                return target.reduce((value, element) =>
                    combine.call(visitor, [value, element]));
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.reduce must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.reduce");
          },
          'lookup': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              return target.lookup(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.lookup");
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet) {
              return target.cast<dynamic>();
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.cast");
          },
          'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final other = positionalArgs[0];
              if (other is Iterable) {
                return target.followedBy(other);
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.followedBy must be an Iterable.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.followedBy");
          },
          'take': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final count = positionalArgs[0] as int;
              return target.take(count);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.take");
          },
          'skip': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final count = positionalArgs[0] as int;
              return target.skip(count);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.skip");
          },
          'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                return target.takeWhile((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.takeWhile must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.takeWhile");
          },
          'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                return target.skipWhile((element) {
                  final result = test.call(visitor, [element]);
                  return result is bool && result;
                });
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.skipWhile must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.skipWhile");
          },
          'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              final orElse = namedArgs['orElse'] as InterpretedFunction?;
              if (test is InterpretedFunction) {
                return target.firstWhere(
                  (element) {
                    final result = test.call(visitor, [element]);
                    return result is bool && result;
                  },
                  orElse:
                      orElse == null ? null : () => orElse.call(visitor, []),
                );
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.firstWhere must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.firstWhere");
          },
          'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              final orElse = namedArgs['orElse'] as InterpretedFunction?;
              if (test is InterpretedFunction) {
                return target.lastWhere(
                  (element) {
                    final result = test.call(visitor, [element]);
                    return result is bool && result;
                  },
                  orElse:
                      orElse == null ? null : () => orElse.call(visitor, []),
                );
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.lastWhere must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.lastWhere");
          },
          'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              final orElse = namedArgs['orElse'] as InterpretedFunction?;
              if (test is InterpretedFunction) {
                return target.singleWhere(
                  (element) {
                    final result = test.call(visitor, [element]);
                    return result is bool && result;
                  },
                  orElse:
                      orElse == null ? null : () => orElse.call(visitor, []),
                );
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeSet.singleWhere must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.singleWhere");
          },
          'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.length == 1) {
              final index = positionalArgs[0] as int;
              return target.elementAt(index);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.elementAt");
          },
          'join': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet) {
              final separator =
                  positionalArgs.isNotEmpty ? positionalArgs[0] as String : "";
              return target.join(separator);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.join");
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              return target.toString();
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.toString");
          },
          'whereType': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              return target.whereType<dynamic>();
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.whereType");
          },
          'toList': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet && positionalArgs.isEmpty) {
              bool growable = namedArgs['growable'] as bool? ?? true;
              return target.toList(growable: growable);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.toList");
          },
          'toSet': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeSet &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              return target.toSet();
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeSet.toSet");
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is SplayTreeSet) return target.length;
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'length'");
          },
          'isEmpty': (visitor, target) {
            if (target is SplayTreeSet) return target.isEmpty;
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is SplayTreeSet) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeSet for getter 'isNotEmpty'");
          },
          'first': (visitor, target) {
            if (target is SplayTreeSet) {
              try {
                return target.first;
              } catch (e) {
                throw RuntimeD4rtException("SplayTreeSet is empty (for getter 'first').");
              }
            }
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is SplayTreeSet) {
              try {
                return target.last;
              } catch (e) {
                throw RuntimeD4rtException("SplayTreeSet is empty (for getter 'last').");
              }
            }
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'last'");
          },
          'single': (visitor, target) {
            if (target is SplayTreeSet) {
              try {
                return target.single;
              } catch (e) {
                if (target.isEmpty) {
                  throw RuntimeD4rtException("SplayTreeSet is empty (for getter 'single').");
                } else {
                  throw RuntimeD4rtException(
                      "SplayTreeSet has more than one element (for getter 'single').");
                }
              }
            }
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'single'");
          },
          'iterator': (visitor, target) {
            if (target is SplayTreeSet) return target.iterator;
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'iterator'");
          },
          'hashCode': (visitor, target) {
            if (target is SplayTreeSet) return target.hashCode;
            throw RuntimeD4rtException("Target is not a SplayTreeSet for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is SplayTreeSet) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeSet for getter 'runtimeType'");
          },
        },
      );
}
