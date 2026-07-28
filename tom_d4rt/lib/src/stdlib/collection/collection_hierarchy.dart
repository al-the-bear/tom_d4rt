import 'package:tom_d4rt/d4rt.dart';

/// Supertype edges for the whole `dart:collection` hierarchy.
///
/// Bridges are registered flat and dispatch is per-bridge, so without these
/// edges a bridged collection knows nothing about the interface it implements.
/// Two things break as a result:
///
///   * **`is` against a supertype answers false.** `HashSet() is Iterable`,
///     `UnmodifiableListView([1]) is List` and `HashMap() is Map` were all
///     false, because nothing connected the concrete bridge to its interface.
///   * **Inherited members are unreachable.** A queue could not reach the
///     ~30-member `Iterable` surface it inherits — `.where`, `.join`, `.map`
///     and even `.contains` failed with "has no instance method named".
///     Declaring the edges recovers the whole surface for every collection at
///     once instead of copying the adapters onto each bridge.
///
/// Expressed as registry edges and deliberately NOT by widening any
/// `isAssignable`: that predicate is what `Environment.toBridgedInstance`
/// consults to decide which bridge *owns* a native object, and every
/// hand-written stdlib bridge carries `hierarchyDepth == 0`, so a supertype
/// claiming assignability for its subtypes could quietly steal dispatch.
/// Feeding the registry instead lets the `_filterToMostSpecific` pass *use* the
/// hierarchy to drop supertype matches — so this makes dispatch more exact, not
/// less. `ConvertHierarchyConvert` follows the same pattern for `dart:convert`.
///
/// The registry keys on NAME, so `register()` must run after the bridges that
/// these names refer to are defined.
class CollectionHierarchyCollection {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // Maps. `Map` is not an `Iterable` in Dart, so the chain stops there.
      'HashMap': ['Map'],
      'LinkedHashMap': ['Map'],
      'SplayTreeMap': ['Map'],
      'UnmodifiableMapView': ['Map'],
      // Sets. Both edges are listed explicitly rather than relying on
      // `Set -> Iterable` being followed transitively, because the registry
      // walk in `BridgedClass.isSubtypeOf` only goes one hop past the direct
      // supertypes.
      'HashSet': ['Set', 'Iterable'],
      'LinkedHashSet': ['Set', 'Iterable'],
      'SplayTreeSet': ['Set', 'Iterable'],
      'UnmodifiableSetView': ['Set', 'Iterable'],
      'Set': ['Iterable'],
      // Lists.
      'UnmodifiableListView': ['List', 'Iterable'],
      'List': ['Iterable'],
      // Queues.
      'DoubleLinkedQueue': ['Queue', 'Iterable'],
      'ListQueue': ['Queue', 'Iterable'],
      'Queue': ['Iterable'],
      // `LinkedList<E extends LinkedListEntry<E>>` implements `Iterable<E>`.
      'LinkedList': ['Iterable'],
    });
  }
}
