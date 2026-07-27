import 'dart:typed_data';

import 'package:tom_d4rt_ast/runtime.dart';

/// `BytesBuilder` (dart:typed_data) — incremental byte accumulation.
///
/// **Why `nativeNames` carries two entries.** `BytesBuilder` is abstract; its
/// only public constructor is the factory
/// `BytesBuilder({bool copy = true})`, which returns one of two *private*
/// implementations — `_CopyingBytesBuilder` when `copy` is true (the default)
/// and `_BytesBuilder` when it is false. Neither is a `BytesBuilder` as far as
/// `runtimeType` is concerned, so without both names on `nativeNames` every
/// member call on a constructed builder would reach no bridge at all. This is
/// the `_TypeError` / `_DoubleLinkedQueueElement` pattern again, but it is the
/// first bridge where the *argument* selects which private class comes back:
/// omitting `_BytesBuilder` would leave `BytesBuilder(copy: false)` working at
/// construction and broken on the first `addByte`.
///
/// Declaring `isAssignable` is safe here for the same reason it was safe on
/// `DoubleLinkedQueue`: the two implementations are private, so no more
/// specific bridge exists that this predicate could steal dispatch from.
class BytesBuilderTypedData {
  static BridgedClass get definition => BridgedClass(
        name: 'BytesBuilder',
        nativeType: BytesBuilder,
        isAssignable: (v) => v is BytesBuilder,
        nativeNames: const ['_CopyingBytesBuilder', '_BytesBuilder'],
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  'BytesBuilder takes no positional arguments; '
                  'use BytesBuilder(copy: false) to opt out of copying.');
            }
            final copy = namedArgs['copy'] ?? true;
            if (copy is! bool) {
              throw RuntimeD4rtException(
                  'BytesBuilder(copy:) expects a bool.');
            }
            return BytesBuilder(copy: copy);
          },
        },
        methods: {
          'addByte': (visitor, target, positionalArgs, namedArgs, _) {
            final byte = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            if (byte is! int) {
              throw RuntimeD4rtException(
                  'BytesBuilder.addByte expects one int argument.');
            }
            (target as BytesBuilder).addByte(byte);
            return null;
          },
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            final bytes = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            if (bytes is! List) {
              throw RuntimeD4rtException(
                  'BytesBuilder.add expects one List<int> argument.');
            }
            (target as BytesBuilder).add(_asIntList(bytes, 'add'));
            return null;
          },
          'takeBytes': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as BytesBuilder).takeBytes();
          },
          'toBytes': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as BytesBuilder).toBytes();
          },
          'clear': (visitor, target, positionalArgs, namedArgs, _) {
            (target as BytesBuilder).clear();
            return null;
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as BytesBuilder).toString();
          },
        },
        getters: {
          'length': (visitor, target) => (target as BytesBuilder).length,
          'isEmpty': (visitor, target) => (target as BytesBuilder).isEmpty,
          'isNotEmpty': (visitor, target) => (target as BytesBuilder).isNotEmpty,
          'hashCode': (visitor, target) => (target as BytesBuilder).hashCode,
          'runtimeType': (visitor, target) =>
              (target as BytesBuilder).runtimeType,
        },
      );
}

/// Narrows an interpreted list to `List<int>`.
///
/// The interpreter hands over a `List<dynamic>` even when every element is an
/// int, and `BytesBuilder.add` takes `List<int>` — so a bare cast throws a
/// host `TypeError` that surfaces to the script as an internal failure rather
/// than an argument error. Converting element-wise lets the bad element be
/// named.
List<int> _asIntList(List source, String where) {
  final native = source.toNativeList();
  final result = <int>[];
  for (final element in native) {
    if (element is! int) {
      throw RuntimeD4rtException(
          'BytesBuilder.$where expects a List<int>; found ${element.runtimeType}.');
    }
    result.add(element);
  }
  return result;
}
