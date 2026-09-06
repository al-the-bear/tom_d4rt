import 'dart:collection';

import 'package:tom_d4rt_ast/runtime.dart';

import 'set_algebra_methods.dart';

/// Bridge for `dart:collection`'s [LinkedHashSet] — a [Set] whose iteration
/// order is the order in which elements were first inserted.
///
/// The surface mirrors [HashSetCollection] exactly; the only additions are the
/// `of` constructor and the ordering guarantee, which is a property of the
/// native type rather than of the bridge.
class LinkedHashSetCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: LinkedHashSet,
    name: 'LinkedHashSet',
    isAssignable: (v) => v is LinkedHashSet,
    typeParameterCount: 1,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            "Constructor LinkedHashSet() does not take positional arguments.",
          );
        }
        // ignore: prefer_collection_literals
        return LinkedHashSet<dynamic>();
      },
      'from': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Constructor LinkedHashSet.from(Iterable elements) expects one positional argument.",
          );
        }
        final elements = positionalArgs[0];
        if (elements is Iterable) {
          return LinkedHashSet<dynamic>.from(elements);
        }
        throw RuntimeD4rtException(
          "Argument to LinkedHashSet.from must be an Iterable.",
        );
      },
      'of': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            "Constructor LinkedHashSet.of(Iterable elements) expects one positional argument.",
          );
        }
        final elements = positionalArgs[0];
        if (elements is Iterable) {
          return LinkedHashSet<dynamic>.of(elements);
        }
        throw RuntimeD4rtException(
          "Argument to LinkedHashSet.of must be an Iterable.",
        );
      },
      'identity': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            'Constructor LinkedHashSet.identity() takes no arguments.',
          );
        }
        return LinkedHashSet<dynamic>.identity();
      },
    },
    methods: {
      // Not reachable through the Set bridge: the interpreter's
      // supertype fallback for instance methods is not uniform.
      ...setAlgebraMethods('LinkedHashSet', (t) => t as Set),
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          return target.add(positionalArgs[0]);
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.add");
      },
      'addAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final elements = positionalArgs[0];
          if (elements is Iterable) {
            target.addAll(elements);
            return null;
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.addAll must be an Iterable.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.addAll",
        );
      },
      'clear': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet &&
            positionalArgs.isEmpty &&
            namedArgs.isEmpty) {
          target.clear();
          return null;
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.clear");
      },
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          return target.contains(positionalArgs[0]);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.contains",
        );
      },
      'containsAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final elements = positionalArgs[0];
          if (elements is Iterable) {
            return target.containsAll(elements);
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.containsAll must be an Iterable.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.containsAll",
        );
      },
      'forEach': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final action = positionalArgs[0];
          if (action is InterpretedFunction) {
            for (var element in target) {
              action.call(visitor, [element]);
            }
            return null;
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.forEach must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.forEach",
        );
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          return target.remove(positionalArgs[0]);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.remove",
        );
      },
      'removeAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final elements = positionalArgs[0];
          if (elements is Iterable) {
            target.removeAll(elements);
            return null;
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.removeAll must be an Iterable.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.removeAll",
        );
      },
      'retainAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final elements = positionalArgs[0];
          if (elements is Iterable) {
            target.retainAll(elements);
            return null;
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.retainAll must be an Iterable.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.retainAll",
        );
      },
      'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            target.removeWhere((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
            return null;
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.removeWhere must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.removeWhere",
        );
      },
      'retainWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            target.retainWhere((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
            return null;
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.retainWhere must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.retainWhere",
        );
      },
      'any': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            return target.any((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.any must be a function.",
          );
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.any");
      },
      'every': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            return target.every((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.every must be a function.",
          );
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.every");
      },
      'where': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            return target.where((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.where must be a function.",
          );
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.where");
      },
      'map': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final f = positionalArgs[0];
          if (f is InterpretedFunction) {
            return target.map((element) => f.call(visitor, [element]));
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.map must be a function.",
          );
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.map");
      },
      'expand': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final f = positionalArgs[0];
          if (f is InterpretedFunction) {
            return target.expand((element) {
              final result = f.call(visitor, [element]);
              return result is Iterable ? result : [];
            });
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.expand must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.expand",
        );
      },
      'fold': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 2) {
          final initialValue = positionalArgs[0];
          final combine = positionalArgs[1];
          if (combine is InterpretedFunction) {
            return target.fold(
              initialValue,
              (previousValue, element) =>
                  combine.call(visitor, [previousValue, element]),
            );
          }
          throw RuntimeD4rtException(
            "Second argument to LinkedHashSet.fold must be a function.",
          );
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.fold");
      },
      'reduce': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final combine = positionalArgs[0];
          if (combine is InterpretedFunction) {
            return target.reduce(
              (value, element) => combine.call(visitor, [value, element]),
            );
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.reduce must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.reduce",
        );
      },
      'lookup': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          return target.lookup(positionalArgs[0]);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.lookup",
        );
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet) {
          return target.cast<dynamic>();
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.cast");
      },
      'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final other = positionalArgs[0];
          if (other is Iterable) {
            return target.followedBy(other);
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.followedBy must be an Iterable.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.followedBy",
        );
      },
      'take': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final count = positionalArgs[0] as int;
          return target.take(count);
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.take");
      },
      'skip': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final count = positionalArgs[0] as int;
          return target.skip(count);
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.skip");
      },
      'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            return target.takeWhile((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.takeWhile must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.takeWhile",
        );
      },
      'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          if (test is InterpretedFunction) {
            return target.skipWhile((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            });
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.skipWhile must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.skipWhile",
        );
      },
      'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          final orElse = namedArgs['orElse'] as InterpretedFunction?;
          if (test is InterpretedFunction) {
            return target.firstWhere((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            }, orElse: orElse == null ? null : () => orElse.call(visitor, []));
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.firstWhere must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.firstWhere",
        );
      },
      'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          final orElse = namedArgs['orElse'] as InterpretedFunction?;
          if (test is InterpretedFunction) {
            return target.lastWhere((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            }, orElse: orElse == null ? null : () => orElse.call(visitor, []));
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.lastWhere must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.lastWhere",
        );
      },
      'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final test = positionalArgs[0];
          final orElse = namedArgs['orElse'] as InterpretedFunction?;
          if (test is InterpretedFunction) {
            return target.singleWhere((element) {
              final result = test.call(visitor, [element]);
              return result is bool && result;
            }, orElse: orElse == null ? null : () => orElse.call(visitor, []));
          }
          throw RuntimeD4rtException(
            "Argument to LinkedHashSet.singleWhere must be a function.",
          );
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.singleWhere",
        );
      },
      'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.length == 1) {
          final index = positionalArgs[0] as int;
          return target.elementAt(index);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.elementAt",
        );
      },
      'join': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet) {
          final separator = positionalArgs.isNotEmpty
              ? positionalArgs[0] as String
              : "";
          return target.join(separator);
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.join");
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet &&
            positionalArgs.isEmpty &&
            namedArgs.isEmpty) {
          return target.toString();
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.toString",
        );
      },
      'whereType': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet &&
            positionalArgs.isEmpty &&
            namedArgs.isEmpty) {
          return target.whereType<dynamic>();
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.whereType",
        );
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet && positionalArgs.isEmpty) {
          bool growable = namedArgs['growable'] as bool? ?? true;
          return target.toList(growable: growable);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedHashSet.toList",
        );
      },
      'toSet': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is LinkedHashSet &&
            positionalArgs.isEmpty &&
            namedArgs.isEmpty) {
          return target.toSet();
        }
        throw RuntimeD4rtException("Invalid arguments for LinkedHashSet.toSet");
      },
    },
    getters: {
      'length': (visitor, target) {
        if (target is LinkedHashSet) return target.length;
        throw RuntimeD4rtException(
          "Target is not a LinkedHashSet for getter 'length'",
        );
      },
      'isEmpty': (visitor, target) {
        if (target is LinkedHashSet) return target.isEmpty;
        throw RuntimeD4rtException(
          "Target is not a LinkedHashSet for getter 'isEmpty'",
        );
      },
      'isNotEmpty': (visitor, target) {
        if (target is LinkedHashSet) return target.isNotEmpty;
        throw RuntimeD4rtException(
          "Target is not a LinkedHashSet for getter 'isNotEmpty'",
        );
      },
      'iterator': (visitor, target) {
        if (target is LinkedHashSet) return target.iterator;
        throw RuntimeD4rtException(
          "Target is not a LinkedHashSet for getter 'iterator'",
        );
      },
      'hashCode': (visitor, target) {
        if (target is LinkedHashSet) return target.hashCode;
        throw RuntimeD4rtException(
          "Target is not a LinkedHashSet for getter 'hashCode'",
        );
      },
      'runtimeType': (visitor, target) {
        if (target is LinkedHashSet) return target.runtimeType;
        throw RuntimeD4rtException(
          "Target is not a LinkedHashSet for getter 'runtimeType'",
        );
      },
    },
  );
}
