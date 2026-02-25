import 'dart:collection';
import 'package:tom_d4rt/d4rt.dart';

class LinkedListCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: LinkedList,
        name: 'LinkedList',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  "Constructor LinkedList() does not take arguments.");
            }
            return LinkedList<BridgedLinkedListEntry>();
          },
        },
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is BridgedLinkedListEntry &&
                namedArgs.isEmpty) {
              target.add(positionalArgs[0] as BridgedLinkedListEntry);
              return null;
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedList.add. Expected a BridgedLinkedListEntry.");
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is BridgedLinkedListEntry &&
                namedArgs.isEmpty) {
              return target.remove(positionalArgs[0] as BridgedLinkedListEntry);
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedList.remove. Expected a BridgedLinkedListEntry.");
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              target.clear();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedList.clear");
          },
          'removeFirst': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              if (target.isEmpty) {
                throw RuntimeD4rtException(
                    "Cannot removeFirst from an empty LinkedList.");
              }
              final firstEntry = target.first;
              firstEntry.unlink();
              return firstEntry;
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedList.removeFirst");
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is LinkedList<BridgedLinkedListEntry>) {
              return target.length;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedList for getter 'length'");
          },
          'isEmpty': (visitor, target) {
            if (target is LinkedList<BridgedLinkedListEntry>) {
              return target.isEmpty;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedList for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is LinkedList<BridgedLinkedListEntry>) {
              return target.isNotEmpty;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedList for getter 'isNotEmpty'");
          },
          'first': (visitor, target) {
            if (target is LinkedList<BridgedLinkedListEntry>) {
              if (target.isEmpty) {
                throw RuntimeD4rtException(
                    "Cannot get first from an empty LinkedList.");
              }
              return target.first;
            }
            throw RuntimeD4rtException("Target is not a LinkedList for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is LinkedList<BridgedLinkedListEntry>) {
              if (target.isEmpty) {
                throw RuntimeD4rtException("Cannot get last from an empty LinkedList.");
              }
              return target.last;
            }
            throw RuntimeD4rtException("Target is not a LinkedList for getter 'last'");
          },
        },
      );
}

final class BridgedLinkedListEntry
    extends LinkedListEntry<BridgedLinkedListEntry> {
  final Object? value;

  BridgedLinkedListEntry(this.value);

  @override
  String toString() => 'BridgedLinkedListEntry($value)';
}

class LinkedListEntryCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: BridgedLinkedListEntry,
        name: 'LinkedListEntry',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && namedArgs.isEmpty) {
              return BridgedLinkedListEntry(positionalArgs[0]);
            }
            throw RuntimeD4rtException(
                "Constructor LinkedListEntry(value) expects one positional argument.");
          },
        },
        methods: {
          'unlink': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is BridgedLinkedListEntry &&
                positionalArgs.isEmpty &&
                namedArgs.isEmpty) {
              if (target.list == null) {
                throw RuntimeD4rtException(
                    "Cannot unlink an entry that is not in a list or already unlinked.");
              }
              target.unlink();
              return null;
            }
            throw RuntimeD4rtException("Invalid arguments for LinkedListEntry.unlink");
          },
        },
        getters: {
          'value': (visitor, target) {
            if (target is BridgedLinkedListEntry) {
              return target.value;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedListEntry for getter 'value'");
          },
          'list': (visitor, target) {
            if (target is BridgedLinkedListEntry) {
              return target.list;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedListEntry for getter 'list'");
          },
          'previous': (visitor, target) {
            if (target is BridgedLinkedListEntry) {
              return target.previous;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedListEntry for getter 'previous'");
          },
          'next': (visitor, target) {
            if (target is BridgedLinkedListEntry) {
              return target.next;
            }
            throw RuntimeD4rtException(
                "Target is not a LinkedListEntry for getter 'next'");
          },
        },
      );
}
