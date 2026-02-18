import 'dart:collection';
import 'package:tom_d4rt_exec/d4rt.dart';

class QueueCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: Queue,
        name: 'Queue',
        typeParameterCount: 1,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  "Constructor Queue() does not take arguments.");
            }
            return Queue<dynamic>();
          },
          'from': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  "Constructor Queue.from(elements) expects one positional argument.");
            }
            final elements = positionalArgs[0];
            if (elements is Iterable) {
              return Queue<dynamic>.from(elements);
            } else if (elements == null) {
              throw RuntimeD4rtException(
                  "The argument type 'Null' can't be assigned to the parameter type 'Iterable<dynamic>'.");
            }
            throw RuntimeD4rtException("Argument to Queue.from must be an Iterable.");
          },
        },
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.length == 1 &&
                namedArgs.isEmpty) {
              target.add(positionalArgs[0]);
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.add");
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.length == 1 &&
                namedArgs.isEmpty) {
              final elements = positionalArgs[0];
              if (elements is Iterable) {
                target.addAll(elements);
                return null;
              }
              throw RuntimeD4rtException("Queue.addAll requires an Iterable argument.");
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.addAll");
          },
          'addFirst': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.length == 1 &&
                namedArgs.isEmpty) {
              target.addFirst(positionalArgs[0]);
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.addFirst");
          },
          'addLast': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.length == 1 &&
                namedArgs.isEmpty) {
              target.addLast(positionalArgs[0]);
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.addLast");
          },
          'removeLast': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("Cannot removeLast from an empty queue.");
              }
              return target.removeLast();
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.removeLast");
          },
          'toList': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue) {
              final growable = namedArgs['growable'] as bool? ?? true;
              return target.toList(growable: growable);
            }
            throw RuntimeD4rtException("Invalid target for Queue.toList");
          },
          'removeFirst': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("Cannot removeFirst from an empty queue.");
              }
              return target.removeFirst();
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.removeFirst");
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              target.clear();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.clear");
          },
          'contains': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Queue &&
                positionalArgs.length == 1 &&
                namedArgs.isEmpty) {
              return target.contains(positionalArgs[0]);
            }
            throw RuntimeD4rtException("Invalid arguments for Queue.contains");
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is Queue) {
              return target.length;
            }
            throw RuntimeD4rtException("Target is not a Queue for getter 'length'");
          },
          'isEmpty': (visitor, target) {
            if (target is Queue) {
              return target.isEmpty;
            }
            throw RuntimeD4rtException("Target is not a Queue for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is Queue) {
              return target.isNotEmpty;
            }
            throw RuntimeD4rtException("Target is not a Queue for getter 'isNotEmpty'");
          },
          'first': (visitor, target) {
            if (target is Queue) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("Cannot get first from an empty queue.");
              }
              return target.first;
            }
            throw RuntimeD4rtException("Target is not a Queue for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is Queue) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("Cannot get last from an empty queue.");
              }
              return target.last;
            }
            throw RuntimeD4rtException("Target is not a Queue for getter 'last'");
          },
          'hashCode': (visitor, target) {
            if (target is Queue) {
              return target.hashCode;
            }
            throw RuntimeD4rtException("Target is not a Queue for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is Queue) {
              return target.runtimeType;
            }
            throw RuntimeD4rtException(
                "Target is not a Queue for getter 'runtimeType'");
          },
        },
      );
}
