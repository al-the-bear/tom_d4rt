import 'package:tom_d4rt/d4rt.dart';

/// Supertype edges for the whole `dart:typed_data` hierarchy.
///
/// SCB20. Bridges are registered flat and dispatch is per-bridge, so without
/// these edges a typed-data view knows nothing about the interfaces it
/// implements. What actually broke, and what did not:
///
///   * **`is TypedData` threw.** The root was unbridged, so the test raised
///     `Undefined variable: TypedData` instead of answering. Fixed by
///     [TypedDataTypedData] plus the edges here.
///   * **`is Iterable` answered false** on all eleven views.
///   * **`is List` answered TRUE the whole time**, with no edge present. This
///     is the part worth understanding before touching this file, because the
///     original SCB20 report claimed the opposite and a "fix" aimed at that
///     claim would be aimed at nothing. `BridgedClass.isSubtypeOf` falls back
///     to asking the *target's* `isAssignable` about the native value
///     (GEN-075 / GEN-081), and the `List` bridge carries
///     `isAssignable: (v) => v is List` (GEN-C3c). A native `Uint8List` is a
///     native `List`, so the fallback answered true. `Iterable`'s bridge has no
///     predicate, which is the entire reason the two behaved differently.
///
/// `-> List` is therefore declared here for correctness, not for behaviour: it
/// makes the hierarchy readable on its own terms instead of depending on the
/// `List` bridge keeping a predicate it is under no obligation to keep.
///
/// Expressed as registry edges and deliberately NOT by widening any
/// `isAssignable`, for the reason spelled out on `CollectionHierarchyCollection`
/// — the predicate decides bridge *ownership*, so a supertype claiming
/// assignability could quietly steal dispatch from the concrete views.
///
/// Every edge is listed explicitly rather than relying on `-> List -> Iterable`
/// being followed transitively: the registry walk in
/// `BridgedClass.isSubtypeOf` only goes one hop past the direct supertypes, and
/// leaving `Iterable` implicit would work today only by accident of the chain
/// being exactly two links long.
///
/// `ByteData` is the member of this hierarchy that is NOT a list — it
/// implements `TypedData` and nothing else — which is what makes it the case
/// that proves these are real edges rather than the `List` fallback in
/// disguise. `ByteBuffer` and `BytesBuilder` are deliberately absent: neither
/// implements `TypedData`, however much they look like they should.
///
/// The registry keys on NAME, so `register()` must run after the bridges that
/// these names refer to are defined.
class TypedDataHierarchyTypedData {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // The eleven list views: `TypedData` and the List/Iterable chain.
      'Uint8List': ['TypedData', 'List', 'Iterable'],
      'Uint8ClampedList': ['TypedData', 'List', 'Iterable'],
      'Uint16List': ['TypedData', 'List', 'Iterable'],
      'Uint32List': ['TypedData', 'List', 'Iterable'],
      'Uint64List': ['TypedData', 'List', 'Iterable'],
      'Int8List': ['TypedData', 'List', 'Iterable'],
      'Int16List': ['TypedData', 'List', 'Iterable'],
      'Int32List': ['TypedData', 'List', 'Iterable'],
      'Int64List': ['TypedData', 'List', 'Iterable'],
      'Float32List': ['TypedData', 'List', 'Iterable'],
      'Float64List': ['TypedData', 'List', 'Iterable'],
      // `ByteData` implements `TypedData` without implementing `List`.
      'ByteData': ['TypedData'],
    });
  }
}
