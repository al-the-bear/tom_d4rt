import 'dart:typed_data';
import 'package:tom_d4rt_ast/runtime.dart';

/// The root of the `dart:typed_data` hierarchy.
///
/// SCB20: before this bridge existed, `d is TypedData` did not answer false —
/// it threw `Undefined variable: TypedData`. A type test that throws is worse
/// than one that answers wrongly, because `is` is total in Dart and scripts
/// reasonably assume it cannot fail. Registering the root is what makes the
/// question expressible at all; [TypedDataHierarchyTypedData] then supplies the
/// edges that make it answer correctly.
///
/// **Deliberately has no `isAssignable`.** That predicate is what
/// `Environment.toBridgedInstance` consults to decide which bridge *owns* a
/// native object, and every hand-written stdlib bridge carries
/// `hierarchyDepth == 0`. A root claiming `(v) => v is TypedData` would compete
/// with the eleven concrete views and `ByteData` for ownership of every typed
/// buffer in the system. The subtype answers do not need it: the registry walk
/// in `BridgedClass.isSubtypeOf` resolves `is TypedData` from the declared
/// edges alone. `Iterable` is bridged the same way and for the same reason;
/// `Queue` carries a predicate because it is also directly constructible.
///
/// The four getters below are the whole of the `TypedData` interface. They are
/// redundant today — all twelve implementors declare them on their own bridges
/// — but they are what makes this a faithful mirror of the interface rather
/// than a bare name, and they are the safety net if an implementor ever drops
/// one. Supertype member lookup walks the same registry, so the edge recovers
/// the member without touching the subtype's bridge; that is exactly how
/// `LinkedList -> Iterable` recovered 25 members in SCB7.
class TypedDataTypedData {
  static BridgedClass get definition => BridgedClass(
    nativeType: TypedData,
    name: 'TypedData',
    getters: {
      'buffer': (visitor, target) => (target as TypedData).buffer,
      'lengthInBytes': (visitor, target) => (target as TypedData).lengthInBytes,
      'offsetInBytes': (visitor, target) => (target as TypedData).offsetInBytes,
      'elementSizeInBytes': (visitor, target) =>
          (target as TypedData).elementSizeInBytes,
    },
  );
}
