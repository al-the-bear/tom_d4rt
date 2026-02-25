import 'dart:collection';
import 'package:tom_d4rt/d4rt.dart';

class LinkedHashMapCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: LinkedHashMap,
        name: 'LinkedHashMap',
        typeParameterCount: 2,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  "Constructor LinkedHashMap() does not take positional arguments.");
            }
            // ignore: prefer_collection_literals
            return LinkedHashMap<dynamic, dynamic>();
          },
          'from': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  "Constructor LinkedHashMap.from(Map other) expects one positional argument.");
            }
            final otherMap = positionalArgs[0];
            if (otherMap is Map) {
              return LinkedHashMap<dynamic, dynamic>.from(otherMap);
            }
            throw RuntimeD4rtException("Argument to LinkedHashMap.from must be a Map.");
          },
          'of': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  "Constructor LinkedHashMap.of(Map other) expects one positional argument.");
            }
            final otherMap = positionalArgs[0];
            if (otherMap is Map) {
              return LinkedHashMap<dynamic, dynamic>.of(otherMap);
            }
            throw RuntimeD4rtException("Argument to LinkedHashMap.of must be a Map.");
          },
          'identity': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  "Constructor LinkedHashMap.identity() does not take positional arguments.");
            }
            return LinkedHashMap<dynamic, dynamic>.identity();
          },
        },
        methods: {
          '[]': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              return target[positionalArgs[0]];
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap[] getter");
          },
          '[]=': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 2) {
              target[positionalArgs[0]] = positionalArgs[1];
              return positionalArgs[1];
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap[]= setter");
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              final otherMap = positionalArgs[0];
              if (otherMap is Map) {
                target.addAll(otherMap.cast<dynamic, dynamic>());
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to LinkedHashMap.addAll must be a Map.");
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.addAll");
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              target.clear();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.clear");
          },
          'containsKey': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              return target.containsKey(positionalArgs[0]);
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedHashMap.containsKey");
          },
          'containsValue': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              return target.containsValue(positionalArgs[0]);
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedHashMap.containsValue");
          },
          'forEach': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              final action = positionalArgs[0];
              if (action is InterpretedFunction) {
                target.forEach((key, value) {
                  action.call(visitor, [key, value]);
                });
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to LinkedHashMap.forEach must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.forEach");
          },
          'putIfAbsent': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 2) {
              final key = positionalArgs[0];
              final ifAbsent = positionalArgs[1];
              if (ifAbsent is InterpretedFunction) {
                return target.putIfAbsent(
                    key, () => ifAbsent.call(visitor, []));
              }
              throw RuntimeD4rtException(
                  "Second argument to LinkedHashMap.putIfAbsent (ifAbsent) must be a function.");
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedHashMap.putIfAbsent");
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              return target.remove(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.remove");
          },
          'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              final test = positionalArgs[0];
              if (test is InterpretedFunction) {
                target.removeWhere((key, value) {
                  final result = test.call(visitor, [key, value]);
                  return result is bool && result;
                });
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to LinkedHashMap.removeWhere must be a function.");
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedHashMap.removeWhere");
          },
          'update': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 2) {
              final key = positionalArgs[0];
              final update = positionalArgs[1];
              final ifAbsent = namedArgs['ifAbsent'] as InterpretedFunction?;
              if (update is InterpretedFunction) {
                return target.update(
                    key, (value) => update.call(visitor, [value]),
                    ifAbsent: ifAbsent == null
                        ? null
                        : () => ifAbsent.call(visitor, []));
              }
              throw RuntimeD4rtException(
                  "Second argument to LinkedHashMap.update must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.update");
          },
          'updateAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              final update = positionalArgs[0];
              if (update is InterpretedFunction) {
                target.updateAll(
                    (key, value) => update.call(visitor, [key, value]));
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to LinkedHashMap.updateAll must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.updateAll");
          },
          'addEntries': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              final newEntries = positionalArgs[0];
              if (newEntries is Iterable) {
                target.addEntries(newEntries.cast());
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to LinkedHashMap.addEntries must be an Iterable.");
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedHashMap.addEntries");
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap) {
              return target.cast<dynamic, dynamic>();
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.cast");
          },
          'map': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedHashMap && positionalArgs.length == 1) {
              final transform = positionalArgs[0];
              if (transform is InterpretedFunction) {
                return target.map((key, value) =>
                    MapEntry(key, transform.call(visitor, [key, value])));
              }
              throw RuntimeD4rtException(
                  "Argument to LinkedHashMap.map must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedHashMap.map");
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is LinkedHashMap) return target.length;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'length'");
          },
          'isEmpty': (visitor, target) {
            if (target is LinkedHashMap) return target.isEmpty;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is LinkedHashMap) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'isNotEmpty'");
          },
          'keys': (visitor, target) {
            if (target is LinkedHashMap) return target.keys;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'keys'");
          },
          'values': (visitor, target) {
            if (target is LinkedHashMap) return target.values;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'values'");
          },
          'entries': (visitor, target) {
            if (target is LinkedHashMap) return target.entries;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'entries'");
          },
          'hashCode': (visitor, target) {
            if (target is LinkedHashMap) return target.hashCode;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is LinkedHashMap) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not a LinkedHashMap for getter 'runtimeType'");
          },
        },
      );
}
