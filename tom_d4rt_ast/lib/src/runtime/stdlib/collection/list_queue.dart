import 'dart:collection';
import 'package:tom_d4rt_ast/runtime.dart';

class ListQueueCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: ListQueue,
        name: 'ListQueue',
        typeParameterCount: 1,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length > 1) {
              throw RuntimeD4rtException(
                  "Constructor ListQueue() takes at most one positional argument for initialCapacity.");
            }
            int? initialCapacity;
            if (positionalArgs.isNotEmpty) {
              if (positionalArgs[0] is int) {
                initialCapacity = positionalArgs[0] as int;
              } else if (positionalArgs[0] != null) {
                throw RuntimeD4rtException(
                    "initialCapacity for ListQueue() must be an int.");
              }
            }
            return ListQueue<dynamic>(initialCapacity);
          },
          'from': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  "Constructor ListQueue.from(Iterable elements) expects one positional argument.");
            }
            final elements = positionalArgs[0];
            if (elements is Iterable) {
              return ListQueue<dynamic>.from(elements);
            }
            throw RuntimeD4rtException(
                "Argument to ListQueue.from must be an Iterable.");
          },
        },
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.length == 1) {
              target.add(positionalArgs[0]);
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.add");
          },
          'addFirst': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.length == 1) {
              target.addFirst(positionalArgs[0]);
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.addFirst");
          },
          'addLast': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.length == 1) {
              target.addLast(positionalArgs[0]);
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.addLast");
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.length == 1) {
              final elements = positionalArgs[0];
              if (elements is Iterable) {
                target.addAll(elements);
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to ListQueue.addAll must be an Iterable.");
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.addAll");
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              target.clear();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.clear");
          },
          'removeFirst': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              if (target.isEmpty) {
                throw RuntimeD4rtException(
                    "Cannot removeFirst from an empty ListQueue.");
              }
              return target.removeFirst();
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.removeFirst");
          },
          'removeLast': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              if (target.isEmpty) {
                throw RuntimeD4rtException(
                    "Cannot removeLast from an empty ListQueue.");
              }
              return target.removeLast();
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.removeLast");
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.length == 1) {
              return target.remove(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.remove");
          },
          'forEach': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.length == 1) {
              final action = positionalArgs[0];
              if (action is InterpretedFunction) {
                for (var element in target) {
                  action.call(visitor, [element]);
                }
                return null;
              }
              throw RuntimeD4rtException(
                  "Argument to ListQueue.forEach must be a function.");
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.forEach");
          },
          'toList': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ListQueue && positionalArgs.isEmpty) {
              bool growable = namedArgs['growable'] as bool? ?? true;
              return target.toList(growable: growable);
            }
            throw RuntimeD4rtException("Invalid arguments for ListQueue.toList");
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is ListQueue) return target.length;
            throw RuntimeD4rtException("Target is not a ListQueue for getter 'length'");
          },
          'isEmpty': (visitor, target) {
            if (target is ListQueue) return target.isEmpty;
            throw RuntimeD4rtException(
                "Target is not a ListQueue for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is ListQueue) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not a ListQueue for getter 'isNotEmpty'");
          },
          'first': (visitor, target) {
            if (target is ListQueue) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("ListQueue is empty (for getter 'first').");
              }
              return target.first;
            }
            throw RuntimeD4rtException("Target is not a ListQueue for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is ListQueue) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("ListQueue is empty (for getter 'last').");
              }
              return target.last;
            }
            throw RuntimeD4rtException("Target is not a ListQueue for getter 'last'");
          },
          'single': (visitor, target) {
            if (target is ListQueue) {
              if (target.length != 1) {
                if (target.isEmpty) {
                  throw RuntimeD4rtException(
                      "ListQueue is empty (for getter 'single').");
                } else {
                  throw RuntimeD4rtException(
                      "ListQueue has more than one element (for getter 'single').");
                }
              }
              return target.single;
            }
            throw RuntimeD4rtException("Target is not a ListQueue for getter 'single'");
          },
          'iterator': (visitor, target) {
            if (target is ListQueue) return target.iterator;
            throw RuntimeD4rtException(
                "Target is not a ListQueue for getter 'iterator'");
          },
          'hashCode': (visitor, target) {
            if (target is ListQueue) return target.hashCode;
            throw RuntimeD4rtException(
                "Target is not a ListQueue for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is ListQueue) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not a ListQueue for getter 'runtimeType'");
          },
        },
      );
}
