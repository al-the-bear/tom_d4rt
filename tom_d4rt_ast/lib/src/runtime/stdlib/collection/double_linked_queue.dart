import 'dart:collection';
import 'package:tom_d4rt_ast/runtime.dart';

/// Runs a script-supplied callback, accepting any [Callable] so that both an
/// interpreted closure and a bridged tear-off reach the same path.
Object? _runCallback(
  InterpreterVisitor visitor,
  Object? fn,
  List<Object?> args,
  String where,
) {
  if (fn is Callable) return fn.call(visitor, args);
  throw RuntimeD4rtException("Argument to $where must be a function.");
}

/// `DoubleLinkedQueue<E> extends Iterable<E> implements Queue<E>` — the deque
/// whose reason to exist is the *entry* API: `firstEntry`/`lastEntry`/
/// `forEachEntry` hand out [DoubleLinkedQueueEntry] cursors that can splice in
/// place. Bridging the queue without the entry type would have produced a
/// slower `ListQueue` with no distinguishing surface, so both are registered
/// here and `CollectionHierarchyCollection` wires the inherited surface.
class DoubleLinkedQueueCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: DoubleLinkedQueue,
    name: 'DoubleLinkedQueue',
    // Concrete and a leaf, so a predicate here cannot shadow a more
    // specific bridge. It still *ties* with `Queue`'s predicate in
    // `Environment.toBridgedInstance`; the `DoubleLinkedQueue -> Queue`
    // edge registered by `CollectionHierarchyCollection` is what breaks that
    // tie in favour of this bridge rather than registration order.
    isAssignable: (v) => v is DoubleLinkedQueue,
    typeParameterCount: 1,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            "Constructor DoubleLinkedQueue() does not take arguments.",
          );
        }
        return DoubleLinkedQueue<dynamic>();
      },
      'from': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            "Constructor DoubleLinkedQueue.from(elements) expects one positional argument.",
          );
        }
        final elements = positionalArgs[0];
        if (elements is Iterable) {
          return DoubleLinkedQueue<dynamic>.from(elements);
        }
        throw RuntimeD4rtException(
          "Argument to DoubleLinkedQueue.from must be an Iterable.",
        );
      },
      'of': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            "Constructor DoubleLinkedQueue.of(elements) expects one positional argument.",
          );
        }
        final elements = positionalArgs[0];
        if (elements is Iterable) {
          return DoubleLinkedQueue<dynamic>.of(elements);
        }
        throw RuntimeD4rtException(
          "Argument to DoubleLinkedQueue.of must be an Iterable.",
        );
      },
    },
    methods: {
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        (target as DoubleLinkedQueue).add(positionalArgs[0]);
        return null;
      },
      'addFirst': (visitor, target, positionalArgs, namedArgs, _) {
        (target as DoubleLinkedQueue).addFirst(positionalArgs[0]);
        return null;
      },
      'addLast': (visitor, target, positionalArgs, namedArgs, _) {
        (target as DoubleLinkedQueue).addLast(positionalArgs[0]);
        return null;
      },
      'addAll': (visitor, target, positionalArgs, namedArgs, _) {
        final elements = positionalArgs.firstOrNull;
        if (elements is Iterable) {
          (target as DoubleLinkedQueue).addAll(elements);
          return null;
        }
        throw RuntimeD4rtException(
          "Argument to DoubleLinkedQueue.addAll must be an Iterable.",
        );
      },
      'removeFirst': (visitor, target, positionalArgs, namedArgs, _) {
        final queue = target as DoubleLinkedQueue;
        if (queue.isEmpty) {
          throw RuntimeD4rtException(
            "Cannot removeFirst from an empty DoubleLinkedQueue.",
          );
        }
        return queue.removeFirst();
      },
      'removeLast': (visitor, target, positionalArgs, namedArgs, _) {
        final queue = target as DoubleLinkedQueue;
        if (queue.isEmpty) {
          throw RuntimeD4rtException(
            "Cannot removeLast from an empty DoubleLinkedQueue.",
          );
        }
        return queue.removeLast();
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueue).remove(positionalArgs[0]);
      },
      'removeWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs.firstOrNull;
        (target as DoubleLinkedQueue).removeWhere(
          (e) =>
              _runCallback(visitor, test, [e], 'DoubleLinkedQueue.removeWhere')
                  as bool,
        );
        return null;
      },
      'retainWhere': (visitor, target, positionalArgs, namedArgs, _) {
        final test = positionalArgs.firstOrNull;
        (target as DoubleLinkedQueue).retainWhere(
          (e) =>
              _runCallback(visitor, test, [e], 'DoubleLinkedQueue.retainWhere')
                  as bool,
        );
        return null;
      },
      'clear': (visitor, target, positionalArgs, namedArgs, _) {
        (target as DoubleLinkedQueue).clear();
        return null;
      },
      // The distinguishing surface. `firstEntry`/`lastEntry` return null on
      // an empty queue rather than throwing — that is the SDK's contract,
      // and it is why they are methods rather than getters.
      'firstEntry': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueue).firstEntry();
      },
      'lastEntry': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueue).lastEntry();
      },
      'forEachEntry': (visitor, target, positionalArgs, namedArgs, _) {
        final action = positionalArgs.firstOrNull;
        (target as DoubleLinkedQueue).forEachEntry(
          (entry) => _runCallback(visitor, action, [
            entry,
          ], 'DoubleLinkedQueue.forEachEntry'),
        );
        return null;
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) {
        final growable = namedArgs['growable'] as bool? ?? true;
        return (target as DoubleLinkedQueue).toList(growable: growable);
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueue).toString();
      },
    },
    getters: {
      'length': (visitor, target) => (target as DoubleLinkedQueue).length,
      'isEmpty': (visitor, target) => (target as DoubleLinkedQueue).isEmpty,
      'isNotEmpty': (visitor, target) =>
          (target as DoubleLinkedQueue).isNotEmpty,
      'first': (visitor, target) {
        final queue = target as DoubleLinkedQueue;
        if (queue.isEmpty) {
          throw RuntimeD4rtException(
            "DoubleLinkedQueue is empty (for getter 'first').",
          );
        }
        return queue.first;
      },
      'last': (visitor, target) {
        final queue = target as DoubleLinkedQueue;
        if (queue.isEmpty) {
          throw RuntimeD4rtException(
            "DoubleLinkedQueue is empty (for getter 'last').",
          );
        }
        return queue.last;
      },
      'single': (visitor, target) {
        final queue = target as DoubleLinkedQueue;
        if (queue.length != 1) {
          throw RuntimeD4rtException(
            queue.isEmpty
                ? "DoubleLinkedQueue is empty (for getter 'single')."
                : "DoubleLinkedQueue has more than one element (for getter 'single').",
          );
        }
        return queue.single;
      },
      'iterator': (visitor, target) => (target as DoubleLinkedQueue).iterator,
      'hashCode': (visitor, target) => (target as DoubleLinkedQueue).hashCode,
      'runtimeType': (visitor, target) =>
          (target as DoubleLinkedQueue).runtimeType,
    },
  );
}

/// The cursor handed out by `firstEntry`/`lastEntry`/`forEachEntry`.
///
/// A standalone `DoubleLinkedQueueEntry(e)` is legal and supports the whole
/// surface, so the constructor is bridged too rather than making the type
/// obtainable only from a queue.
class DoubleLinkedQueueEntryCollection {
  static BridgedClass get definition => BridgedClass(
    nativeType: DoubleLinkedQueueEntry,
    name: 'DoubleLinkedQueueEntry',
    isAssignable: (v) => v is DoubleLinkedQueueEntry,
    typeParameterCount: 1,
    // `firstEntry()` does NOT return a `DoubleLinkedQueueEntry` — it
    // returns the private `_DoubleLinkedQueueElement` subclass the queue
    // links internally. Without this routing the entry API would hand back
    // objects that reach no bridge at all, so every accessor on the result
    // would fail. Same pattern as `_TypeError` on the `TypeError` bridge.
    nativeNames: const ['_DoubleLinkedQueueElement'],
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            "Constructor DoubleLinkedQueueEntry(element) expects one positional argument.",
          );
        }
        return DoubleLinkedQueueEntry<dynamic>(positionalArgs[0]);
      },
    },
    methods: {
      'append': (visitor, target, positionalArgs, namedArgs, _) {
        (target as DoubleLinkedQueueEntry).append(positionalArgs[0]);
        return null;
      },
      'prepend': (visitor, target, positionalArgs, namedArgs, _) {
        (target as DoubleLinkedQueueEntry).prepend(positionalArgs[0]);
        return null;
      },
      'remove': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueueEntry).remove();
      },
      'previousEntry': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueueEntry).previousEntry();
      },
      'nextEntry': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as DoubleLinkedQueueEntry).nextEntry();
      },
    },
    getters: {
      'element': (visitor, target) =>
          (target as DoubleLinkedQueueEntry).element,
      'hashCode': (visitor, target) =>
          (target as DoubleLinkedQueueEntry).hashCode,
      'runtimeType': (visitor, target) =>
          (target as DoubleLinkedQueueEntry).runtimeType,
    },
    setters: {
      'element': (visitor, target, value) {
        (target as DoubleLinkedQueueEntry).element = value;
      },
    },
  );
}

// The queue supertype edges live with the rest of the `dart:collection`
// hierarchy in `CollectionHierarchyCollection` (collection_hierarchy.dart) —
// one declaration of the library's supertype graph rather than one per file.
