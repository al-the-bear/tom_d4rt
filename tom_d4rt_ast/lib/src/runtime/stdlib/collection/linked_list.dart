import 'dart:collection';
import 'package:tom_d4rt_ast/runtime.dart';

/// `LinkedList` bridges only the members that are LinkedList's OWN.
///
/// The whole `Iterable` surface — 25 members, from `map` and `where` down to
/// `iterator` and `toList` — is reachable through the `LinkedList -> Iterable`
/// edge registered by `CollectionHierarchyCollection`, not through adapters
/// here. Do not add an adapter for an inherited member: it shadows the
/// fallback with a second implementation that then has to be kept correct.
///
/// `removeFirst` is DELIBERATELY ABSENT. Dart's `LinkedList` has no such
/// member — `Queue` does, which is where the expectation comes from — and the
/// portable way to drop the head is `list.first.unlink()`. Bridging it made
/// scripts that used it run here and fail to compile as Dart, which is the one
/// class of bridge defect no test can catch by itself; F-SCC8-5 in
/// `test/stdlib/collection/linked_list_test.dart` pins the absence.
class LinkedListCollection {
  static BridgedClass get definition => BridgedClass(
        nativeType: LinkedList,
        name: 'LinkedList',
        isAssignable: (v) => v is LinkedList,
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
                "Invalid arguments for LinkedList.add. Expected a LinkedListEntry.");
          },
          'addAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is Iterable &&
                namedArgs.isEmpty) {
              // Validate and materialise BEFORE linking anything. Two reasons,
              // both about the argument being lazy: `LinkedList.addAll` links
              // each entry as it walks, so an iterable derived from this same
              // list would mutate what it is iterating; and a bad element part
              // way in would otherwise leave a half-applied addAll, a state no
              // program the Dart compiler accepts can reach.
              final entries = <BridgedLinkedListEntry>[];
              for (final element in positionalArgs[0] as Iterable) {
                // Elements INSIDE an interpreted collection arrive wrapped;
                // single positional arguments do not, which is why `add` and
                // `addFirst` need no unwrapping and this does.
                final entry =
                    element is BridgedInstance ? element.nativeObject : element;
                if (entry is! BridgedLinkedListEntry) {
                  throw RuntimeD4rtException(
                      "Invalid arguments for LinkedList.addAll. Expected an "
                      "Iterable of LinkedListEntry, found "
                      "'${entry.runtimeType}'.");
                }
                entries.add(entry);
              }
              target.addAll(entries);
              return null;
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedList.addAll. Expected an Iterable of LinkedListEntry.");
          },
          'addFirst': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is BridgedLinkedListEntry &&
                namedArgs.isEmpty) {
              target.addFirst(positionalArgs[0] as BridgedLinkedListEntry);
              return null;
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedList.addFirst. Expected a LinkedListEntry.");
          },
          'remove': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is LinkedList<BridgedLinkedListEntry> &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is BridgedLinkedListEntry &&
                namedArgs.isEmpty) {
              return target.remove(positionalArgs[0] as BridgedLinkedListEntry);
            }
            throw RuntimeD4rtException(
                "Invalid arguments for LinkedList.remove. Expected a LinkedListEntry.");
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
        isAssignable: (v) => v is BridgedLinkedListEntry,
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
