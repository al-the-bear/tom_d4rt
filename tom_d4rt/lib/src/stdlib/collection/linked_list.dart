import 'dart:collection';
import 'package:tom_d4rt/d4rt.dart';

/// `LinkedList` bridges only the members that are LinkedList's OWN.
///
/// The whole `Iterable` surface — 25 members, from `map` and `where` down to
/// `iterator` and `toList` — is reachable through the `LinkedList -> Iterable`
/// edge registered by `CollectionHierarchyCollection`, not through adapters
/// here. Do not add an adapter for an inherited member: it shadows the
/// fallback with a second implementation that then has to be kept correct.
///
/// `LinkedListEntry` IS THE ENTRY POINT, and the bridge follows the SDK's
/// shape for it: an implicit zero-argument constructor and the six members
/// `list`, `next`, `previous`, `insertAfter`, `insertBefore`, `unlink`. A
/// script declares `class E extends LinkedListEntry<E>` — the SDK declares it
/// `abstract base mixin class` over a self-referential type parameter, so
/// there is no other way in — and carries its payload on that class, where
/// Dart carries it.
///
/// A `LinkedListEntry(value)` CONSTRUCTOR AND A `value` GETTER are therefore
/// both absent, and were both present until SCE84. Neither is in the SDK, so a
/// script using them ran here and did not compile as Dart — the same judgement
/// `removeFirst` gets below, applied to a constructor and a getter.
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
            "Constructor LinkedList() does not take arguments.",
          );
        }
        return LinkedList<BridgedLinkedListEntry>();
      },
    },
    methods: {
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        final entry = positionalArgs.length == 1 && namedArgs.isEmpty
            ? _nativeEntry(positionalArgs[0])
            : null;
        if (target is LinkedList<BridgedLinkedListEntry> && entry != null) {
          target.add(entry);
          return null;
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedList.add. Expected a LinkedListEntry.",
        );
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
            final entry = _nativeEntry(element);
            if (entry == null) {
              throw RuntimeD4rtException(
                "Invalid arguments for LinkedList.addAll. Expected an "
                "Iterable of LinkedListEntry, found "
                "'${element.runtimeType}'.",
              );
            }
            entries.add(entry);
          }
          target.addAll(entries);
          return null;
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedList.addAll. Expected an Iterable of LinkedListEntry.",
        );
      },
      'addFirst': (visitor, target, positionalArgs, namedArgs, _) {
        final entry = positionalArgs.length == 1 && namedArgs.isEmpty
            ? _nativeEntry(positionalArgs[0])
            : null;
        if (target is LinkedList<BridgedLinkedListEntry> && entry != null) {
          target.addFirst(entry);
          return null;
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedList.addFirst. Expected a LinkedListEntry.",
        );
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        final entry = positionalArgs.length == 1 && namedArgs.isEmpty
            ? _nativeEntry(positionalArgs[0])
            : null;
        if (target is LinkedList<BridgedLinkedListEntry> && entry != null) {
          return target.remove(entry);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedList.remove. Expected a LinkedListEntry.",
        );
      },
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        // The ONE inherited member this bridge declares on purpose, against
        // the rule at the top of this file. `Iterable.contains` takes an
        // ELEMENT, and the element a script holds is its own entry object
        // while the list holds the native entry behind it — so the inherited
        // adapter compares two carriers of one object and answers false.
        // Every other `Iterable` member takes a predicate or nothing, and the
        // proxy marker on [BridgedLinkedListEntry] covers those: the entry
        // they hand out reads as the script's own object.
        D4.checkArity(positionalArgs, 'LinkedList.contains', exactly: 1);
        final entry = namedArgs.isEmpty
            ? _nativeEntry(positionalArgs[0])
            : null;
        if (target is LinkedList<BridgedLinkedListEntry> && entry != null) {
          return identical(entry.list, target);
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedList.contains. Expected a "
          "LinkedListEntry.",
        );
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
          "Target is not a LinkedList for getter 'length'",
        );
      },
      'isEmpty': (visitor, target) {
        if (target is LinkedList<BridgedLinkedListEntry>) {
          return target.isEmpty;
        }
        throw RuntimeD4rtException(
          "Target is not a LinkedList for getter 'isEmpty'",
        );
      },
      'isNotEmpty': (visitor, target) {
        if (target is LinkedList<BridgedLinkedListEntry>) {
          return target.isNotEmpty;
        }
        throw RuntimeD4rtException(
          "Target is not a LinkedList for getter 'isNotEmpty'",
        );
      },
    },
  );
}

/// The concrete stand-in this package ships for the SDK's abstract
/// `LinkedListEntry`, and the bridge's native type.
///
/// Its surface is deliberately EXACTLY the SDK's — everything it has, it
/// inherits from `LinkedListEntry` — because the member audit reflects over
/// this class to decide what a script should be able to reach. A field added
/// here reads as a member of `LinkedListEntry` that nothing bridges, which is
/// why the owner link and the proxy marker live on [_OwnedLinkedListEntry]
/// below rather than here.
final class BridgedLinkedListEntry
    extends LinkedListEntry<BridgedLinkedListEntry> {}

/// The entry the bridge mints, which can stand for a script's own subclass.
///
/// A script writes `class E extends LinkedListEntry<E>`; the interpreter calls
/// the bridged constructor for the implicit `super()` and assigns the result
/// as the instance's `bridgedSuperObject`. The adapter is called without
/// `this`, so the tie is made later — when the entry ENTERS a list, the only
/// moment both halves are in one place.
///
/// [D4InterpretedProxy] is what makes `list.first.myField` reach the script's
/// class: the native list can only hold native entries, so `Iterable`'s
/// adapters hand out THIS object, and the interpreter's existing proxy
/// unwrapping turns it back into the instance on property access, member
/// invocation and `as`.
final class _OwnedLinkedListEntry extends BridgedLinkedListEntry
    implements D4InterpretedProxy {
  /// The script's own entry object, or null for an entry standing for nothing.
  Object? owner;

  /// Answers with itself when there is no owner. Every unwrap site tests the
  /// result with `is InterpretedInstance` before using it, so a non-instance
  /// answer means "nothing to unwrap to" and the site falls through to the
  /// behaviour it had before.
  @override
  Object get d4rtInstance => owner ?? this;

  /// The owner's own `toString` when there is one.
  ///
  /// SCE120. This used to read `LinkedListEntry(<owner>)`, and it is the one
  /// place the proxy leaked: `list.first.myField` reaches the script's class
  /// through [D4InterpretedProxy], but `toString` does not, because the
  /// unwrap is a FALLBACK after the bridge's own members fail and this one
  /// succeeded. A script that declares `String toString() => 'E:' + …` saw
  /// `LinkedListEntry(E:1)` — its own rendering wrapped in the name of a class
  /// it never mentioned.
  ///
  /// `owner` is an `InterpretedInstance`, whose `toString()` dispatches to the
  /// script's override and degrades to the diagnostic form when there is none
  /// (SCD72, shared since SCE116), so this is the script's answer or the
  /// interpreter's — never the wrapper's.
  ///
  /// The unowned case keeps the old shape: there is no script object to
  /// speak for, and the name is the useful thing to print.
  @override
  String toString() => owner?.toString() ?? 'LinkedListEntry(unowned)';
}

/// The native entry behind [arg], whichever way the script produced it, with
/// its [BridgedLinkedListEntry.owner] linked.
///
/// A script writes `class E extends LinkedListEntry<E>`, so what arrives is an
/// [InterpretedInstance] whose `bridgedSuperObject` is the native entry the
/// implicit `super()` created. The native list can only hold native entries,
/// so this is where the two are tied together.
BridgedLinkedListEntry? _nativeEntry(Object? arg) {
  final value = arg is BridgedInstance ? arg.nativeObject : arg;
  if (value is BridgedLinkedListEntry) return value;
  if (value is InterpretedInstance) {
    final native = value.bridgedSuperObject;
    if (native is _OwnedLinkedListEntry) {
      native.owner = value;
      return native;
    }
    if (native is BridgedLinkedListEntry) return native;
  }
  return null;
}

/// What a script should see for [entry]: its own object when it declared one,
/// and the native entry otherwise.
Object? _exposed(BridgedLinkedListEntry? entry) =>
    entry is _OwnedLinkedListEntry ? entry.owner ?? entry : entry;

class LinkedListEntryCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: BridgedLinkedListEntry,
    name: 'LinkedListEntry',
    isAssignable: (v) => v is BridgedLinkedListEntry,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        // The SDK's `LinkedListEntry` has an implicit ZERO-argument
        // constructor, and a script reaches it through the implicit `super()`
        // of its own `class E extends LinkedListEntry<E>` — the only way the
        // type is usable, since `LinkedList` has no other entry point.
        if (namedArgs.isEmpty && positionalArgs.isEmpty) {
          return _OwnedLinkedListEntry();
        }
        throw RuntimeD4rtException(
          "Constructor LinkedListEntry() takes no arguments. Declare an entry "
          "type the way Dart requires — `class E extends LinkedListEntry<E>` "
          "— and carry your value on it.",
        );
      },
    },
    methods: {
      'insertAfter': (visitor, target, positionalArgs, namedArgs, _) {
        final entry = positionalArgs.length == 1
            ? _nativeEntry(positionalArgs[0])
            : null;
        if (target is! BridgedLinkedListEntry || entry == null) {
          throw RuntimeD4rtException(
            'LinkedListEntry.insertAfter(entry) expects one LinkedListEntry.',
          );
        }
        target.insertAfter(entry);
        return null;
      },
      'insertBefore': (visitor, target, positionalArgs, namedArgs, _) {
        final entry = positionalArgs.length == 1
            ? _nativeEntry(positionalArgs[0])
            : null;
        if (target is! BridgedLinkedListEntry || entry == null) {
          throw RuntimeD4rtException(
            'LinkedListEntry.insertBefore(entry) expects one LinkedListEntry.',
          );
        }
        target.insertBefore(entry);
        return null;
      },
      'unlink': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is BridgedLinkedListEntry &&
            positionalArgs.isEmpty &&
            namedArgs.isEmpty) {
          // SCD31 examined this guard and it STAYS, which is the one
          // survivor of that sweep. It looks like the defect class — a
          // hand-written throw conditioned on the receiver's state — but Dart
          // has no contract here to contradict: measured, `LinkedListEntry
          // .unlink()` on an unlinked entry throws
          // `_TypeError: Null check operator used on a null value`, an internal
          // crash rather than a documented failure, and not a type any script
          // would name in a catch.
          //
          // So deleting it would trade a clear message for an SDK crash and
          // gain no fidelity. The rule the sweep applies is "do not invent a
          // contract the SDK has"; where the SDK has none, a legible error is
          // the better answer.
          if (target.list == null) {
            throw RuntimeD4rtException(
              "Cannot unlink an entry that is not in a list or already unlinked.",
            );
          }
          target.unlink();
          return null;
        }
        throw RuntimeD4rtException(
          "Invalid arguments for LinkedListEntry.unlink",
        );
      },
    },
    getters: {
      'list': (visitor, target) {
        if (target is BridgedLinkedListEntry) {
          return target.list;
        }
        throw RuntimeD4rtException(
          "Target is not a LinkedListEntry for getter 'list'",
        );
      },
      'previous': (visitor, target) {
        if (target is BridgedLinkedListEntry) {
          return _exposed(target.previous);
        }
        throw RuntimeD4rtException(
          "Target is not a LinkedListEntry for getter 'previous'",
        );
      },
      'next': (visitor, target) {
        if (target is BridgedLinkedListEntry) {
          return _exposed(target.next);
        }
        throw RuntimeD4rtException(
          "Target is not a LinkedListEntry for getter 'next'",
        );
      },
    },
  );
}
