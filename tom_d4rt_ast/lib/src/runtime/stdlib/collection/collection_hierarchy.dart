import 'package:tom_d4rt_ast/runtime.dart';

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
/// Each edge is declared ONCE, mirroring the SDK's own `implements` /`extends`
/// clause; the transitive closure is computed by the registry walk. Declare a
/// new collection by naming its immediate supertype only.
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
      // Sets. One edge per SDK relationship; `HashSet is Iterable` is answered
      // by following `HashSet -> Set -> Iterable`, not by restating it.
      'HashSet': ['Set'],
      'LinkedHashSet': ['Set'],
      'SplayTreeSet': ['Set'],
      'UnmodifiableSetView': ['Set'],
      'Set': ['Iterable'],
      // Lists.
      'UnmodifiableListView': ['List'],
      'List': ['Iterable'],
      // Queues.
      'DoubleLinkedQueue': ['Queue'],
      'ListQueue': ['Queue'],
      'Queue': ['Iterable'],
      // `LinkedList<E extends LinkedListEntry<E>>` implements `Iterable<E>`.
      'LinkedList': ['Iterable'],
    });
  }
}
