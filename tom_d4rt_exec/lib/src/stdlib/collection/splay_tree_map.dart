import 'dart:collection';
import 'package:tom_d4rt_exec/d4rt.dart';

class SplayTreeMapCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: SplayTreeMap,
        name: 'SplayTreeMap',
        typeParameterCount: 2,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length > 1) {
              throw RuntimeD4rtException(
                  "Constructor SplayTreeMap() takes at most one positional argument for compare function.");
            }

            InterpretedFunction? compareFn;
            if (positionalArgs.isNotEmpty && positionalArgs[0] != null) {
              if (positionalArgs[0] is InterpretedFunction) {
                compareFn = positionalArgs[0] as InterpretedFunction;
              } else {
                throw RuntimeD4rtException(
                    "The 'compare' argument must be a function.");
              }
            }

            int Function(dynamic, dynamic)? actualCompare;
            if (compareFn != null) {
              actualCompare = (k1, k2) {
                final result = compareFn!.call(visitor, [k1, k2]);
                if (result is int) {
                  return result;
                }
                throw RuntimeD4rtException("Compare function must return an int.");
              };
            }
            return SplayTreeMap<dynamic, dynamic>(actualCompare);
          },
          'from': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty || positionalArgs.length > 2) {
              throw RuntimeD4rtException(
                  "Constructor SplayTreeMap.from() expects one or two positional arguments (otherMap, [compare]).");
            }
            final otherMap = positionalArgs[0];
            if (otherMap is! Map) {
              throw RuntimeD4rtException(
                  "First argument to SplayTreeMap.from must be a Map.");
            }

            InterpretedFunction? compareFn;
            if (positionalArgs.length > 1 && positionalArgs[1] != null) {
              if (positionalArgs[1] is InterpretedFunction) {
                compareFn = positionalArgs[1] as InterpretedFunction;
              } else {
                throw RuntimeD4rtException(
                    "The 'compare' argument must be a function.");
              }
            }
            int Function(dynamic, dynamic)? actualCompare;
            if (compareFn != null) {
              actualCompare = (k1, k2) {
                final result = compareFn!.call(visitor, [k1, k2]);
                if (result is int) return result;
                throw RuntimeD4rtException("Compare function must return an int.");
              };
            }
            return SplayTreeMap<dynamic, dynamic>.from(otherMap, actualCompare);
          },
          'of': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty || positionalArgs.length > 2) {
              throw RuntimeD4rtException(
                  "Constructor SplayTreeMap.of() expects one or two positional arguments (otherMap, [compare]).");
            }
            final otherMap = positionalArgs[0];
            if (otherMap is! Map) {
              throw RuntimeD4rtException(
                  "First argument to SplayTreeMap.of must be a Map.");
            }
            InterpretedFunction? compareFn;
            if (positionalArgs.length > 1 && positionalArgs[1] != null) {
              if (positionalArgs[1] is InterpretedFunction) {
                compareFn = positionalArgs[1] as InterpretedFunction;
              } else {
                throw RuntimeD4rtException(
                    "The 'compare' argument must be a function.");
              }
            }
            int Function(dynamic, dynamic)? actualCompare;
            if (compareFn != null) {
              actualCompare = (k1, k2) {
                final result = compareFn!.call(visitor, [k1, k2]);
                if (result is int) return result;
                throw RuntimeD4rtException("Compare function must return an int.");
              };
            }
            return SplayTreeMap<dynamic, dynamic>.of(
                otherMap.cast<dynamic, dynamic>(), actualCompare);
          },
        },
        methods: {
          '[]': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 1) {
              return target[positionalArgs[0]];
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap[] getter");
          },
          '[]=': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 2) {
              target[positionalArgs[0]] = positionalArgs[1];
              return positionalArgs[1];
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap[]= setter");
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 1) {
              final otherMap = positionalArgs[0];
              if (otherMap is Map) {
                target.addAll(otherMap.cast<dynamic, dynamic>());
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeMap.addAll must be a Map.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap.addAll");
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              target.clear();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap.clear");
          },
          'containsKey': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 1) {
              return target.containsKey(positionalArgs[0]);
            }
            throw RuntimeD4rtException(
                "Invalid arguments for SplayTreeMap.containsKey");
          },
          'containsValue': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 1) {
              return target.containsValue(positionalArgs[0]);
            }
            throw RuntimeD4rtException(
                "Invalid arguments for SplayTreeMap.containsValue");
          },
          'forEach': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 1) {
              final action = positionalArgs[0];
              if (action is InterpretedFunction) {
                for (var entry in target.entries) {
                  action.call(visitor, [entry.key, entry.value]);
                }
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to SplayTreeMap.forEach must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap.forEach");
          },
          'putIfAbsent': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 2) {
              final key = positionalArgs[0];
              final ifAbsent = positionalArgs[1];
              if (ifAbsent is InterpretedFunction) {
                return target.putIfAbsent(
                    key, () => ifAbsent.call(visitor, []));
              }
              throw RuntimeD4rtException(
                  "Second argument to SplayTreeMap.putIfAbsent (ifAbsent) must be a function.");
            }
            throw RuntimeD4rtException(
                "Invalid arguments for SplayTreeMap.putIfAbsent");
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.length == 1) {
              return target.remove(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap.remove");
          },
          'firstKey': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.isEmpty) {
              if (target.isEmpty) throw RuntimeD4rtException("Map is empty");
              return target.firstKey();
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap.firstKey");
          },
          'lastKey': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is SplayTreeMap && positionalArgs.isEmpty) {
              if (target.isEmpty) throw RuntimeD4rtException("Map is empty");
              return target.lastKey();
            }
            throw RuntimeD4rtException("Invalid arguments for SplayTreeMap.lastKey");
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is SplayTreeMap) return target.length;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'length'");
          },
          'isEmpty': (visitor, target) {
            if (target is SplayTreeMap) return target.isEmpty;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is SplayTreeMap) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'isNotEmpty'");
          },
          'keys': (visitor, target) {
            if (target is SplayTreeMap) return target.keys;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'keys'");
          },
          'values': (visitor, target) {
            if (target is SplayTreeMap) return target.values;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'values'");
          },
          'entries': (visitor, target) {
            if (target is SplayTreeMap) return target.entries;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'entries'");
          },
          'hashCode': (visitor, target) {
            if (target is SplayTreeMap) return target.hashCode;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is SplayTreeMap) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not a SplayTreeMap for getter 'runtimeType'");
          },
        },
      );
}
