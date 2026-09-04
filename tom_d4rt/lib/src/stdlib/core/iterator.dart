import 'package:tom_d4rt/d4rt.dart';

class IteratorCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Iterator,
    name: 'Iterator',
    typeParameterCount: 1,
    // The SDK's iterator implementations are all private, so the only way
    // to claim them for this bridge is to name them. Until these were
    // listed, `.iterator` was a dead end for everything but a `List`:
    // `LinkedHashSet`, `SplayTreeSet`, `UnmodifiableSetView`, every map
    // key/value/entry view and even a plain `<int>{}` literal answered
    // "Undefined property or method 'moveNext'". The names below were
    // enumerated by walking `.iterator` on every bridged collection and
    // map view rather than collected one bug report at a time.
    //
    // An allowlist can only ever be as complete as its last update; the
    // structural alternative is a native `is Iterator` fallback in
    // `Environment.toBridgedInstance`, which is not done here because that
    // predicate decides which bridge OWNS an object and a blanket claim
    // could steal dispatch from a more specific bridge. Tracked separately.
    nativeNames: [
      '_ListQueueIterator',
      '_HashSetIterator',
      '_LazySyncGeneratorIterator', // D4rt sync* generator iterator
      'ListIterator',
      'MappedIterator', // HashMap.entries
      'RuneIterator',
      '_CompactIterator', // LinkedHashSet/Map, UnmodifiableSetView, literals
      '_CompactEntriesIterator',
      '_DoubleLinkedQueueIterator',
      '_HashMapKeyIterator',
      '_HashMapValueIterator',
      '_SplayTreeKeyIterator',
      '_SplayTreeValueIterator',
      '_SplayTreeMapEntryIterator',
      '_LinkedListIterator', // LinkedList.iterator
      '_AllMatchesIterator', // RegExp.allMatches(...).iterator
      // Every typed list — Uint8List, Int32List, Float64List and the rest
      // share one iterator implementation. Missing until SCC24, so
      // `.iterator` was a dead end on exactly the buffers Flutter scripts
      // handle most (binary message codecs, byte buffers).
      '_TypedListIterator',
    ],
    methods: {
      'moveNext': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Iterator).moveNext();
      },
    },
    getters: {
      'current': (visitor, target) => (target as Iterator).current,
      'hashCode': (visitor, target) => (target as Iterator).hashCode,
      'runtimeType': (visitor, target) => (target as Iterator).runtimeType,
    },
  );
}
