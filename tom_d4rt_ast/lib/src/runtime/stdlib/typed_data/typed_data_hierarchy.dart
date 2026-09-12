import 'package:tom_d4rt_ast/runtime.dart';

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
/// One edge per SDK `implements`, and `Iterable` is NOT among them: it is
/// reached by following `List -> Iterable`. That edge used to be declared by
/// `dart:collection`'s registrar, which is why every view here restated the
/// whole closure — a script importing only `dart:typed_data` had no other path
/// to `Iterable`. SCD67 moved it to `CoreHierarchyCore`, where the `dart:core`
/// types it describes actually live, and the closure is unchanged in both
/// conditions. (The original reason for restating it — that the registry walk
/// went only one hop past the direct supertypes — stopped being true at SCC19,
/// which made `isSubtypeOf` read the full closure.)
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
      // The eleven list views. `abstract class Uint8List implements List<int>,
      // TypedData` — two edges, and `Iterable` is reached by following
      // `List -> Iterable` in `CoreHierarchyCore` rather than being restated.
      'Uint8List': ['TypedData', 'List'],
      'Uint8ClampedList': ['TypedData', 'List'],
      'Uint16List': ['TypedData', 'List'],
      'Uint32List': ['TypedData', 'List'],
      'Uint64List': ['TypedData', 'List'],
      'Int8List': ['TypedData', 'List'],
      'Int16List': ['TypedData', 'List'],
      'Int32List': ['TypedData', 'List'],
      'Int64List': ['TypedData', 'List'],
      'Float32List': ['TypedData', 'List'],
      'Float64List': ['TypedData', 'List'],
      // `ByteData` implements `TypedData` without implementing `List`.
      'ByteData': ['TypedData'],
    });
  }
}
