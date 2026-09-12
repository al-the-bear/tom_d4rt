import 'dart:typed_data';
import 'package:tom_d4rt/d4rt.dart';

import 'inherited_list_methods.dart';

class Uint8ListTypedData {
  static BridgedClass get definition => BridgedClass(
    name: 'Uint8List',
    nativeType: Uint8List,
    isAssignable: (v) => v is Uint8List,
    nativeNames: ['_Uint8ArrayView'],
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length == 1 && positionalArgs[0] is int) {
          return Uint8List(positionalArgs[0] as int);
        }
        throw RuntimeD4rtException(
          "Uint8List constructor expects one int argument (length).",
        );
      },
      'fromList': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length == 1 && positionalArgs[0] is List) {
          final sourceList = positionalArgs[0] as List;
          final intList = sourceList.toNativeList().map((e) {
            if (e is int) return e;
            throw RuntimeD4rtException(
              "Uint8List.fromList expects a List<int>.",
            );
          }).toList();
          return Uint8List.fromList(intList);
        }
        throw RuntimeD4rtException(
          "Uint8List.fromList expects one List<int> argument.",
        );
      },
      'view': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isNotEmpty && positionalArgs[0] is ByteBuffer) {
          final buffer = positionalArgs[0] as ByteBuffer;
          final offsetInBytes = positionalArgs.length > 1
              ? positionalArgs[1] as int? ?? 0
              : 0;
          final length = positionalArgs.length > 2
              ? positionalArgs[2] as int?
              : null;
          return Uint8List.view(buffer, offsetInBytes, length);
        }
        throw RuntimeD4rtException(
          "Uint8List.view expects ByteBuffer and optional int arguments.",
        );
      },
      'sublistView': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isNotEmpty && positionalArgs[0] is TypedData) {
          final data = positionalArgs[0] as TypedData;
          final start = positionalArgs.length > 1
              ? positionalArgs[1] as int? ?? 0
              : 0;
          final end = positionalArgs.length > 2
              ? positionalArgs[2] as int?
              : null;
          return Uint8List.sublistView(data, start, end);
        }
        throw RuntimeD4rtException(
          "Uint8List.sublistView expects TypedData and optional int arguments.",
        );
      },
    },
    methods: {
      // Index operators
      '[]': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is Uint8List &&
            positionalArgs.length == 1 &&
            positionalArgs[0] is int) {
          return target[positionalArgs[0] as int];
        }
        throw RuntimeD4rtException("Uint8List[index] expects an int index.");
      },
      '[]=': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is Uint8List &&
            positionalArgs.length == 2 &&
            positionalArgs[0] is int &&
            positionalArgs[1] is int) {
          final index = positionalArgs[0] as int;
          final value = positionalArgs[1] as int;
          target[index] = value;
          return value;
        }
        throw RuntimeD4rtException(
          "Uint8List[index] = value expects int index and int value.",
        );
      },
      'asUint8ListView': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.asUint8ListView', atMost: 2);
        final offsetInBytes = positionalArgs.isNotEmpty
            ? positionalArgs[0] as int?
            : null;
        final length = positionalArgs.length > 1
            ? positionalArgs[1] as int?
            : null;
        return (target as Uint8List).buffer.asUint8List(
          offsetInBytes ?? 0,
          length,
        );
      },
      // SCD27: `buffer` was registered here as well as in `getters`, so
      // `l.buffer()` resolved. In the SDK it is a getter inherited from
      // `TypedData` and that call does not compile as Dart — the widening
      // shape,
      'fillRange': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.fillRange', atMost: 3);
        final start = positionalArgs[0] as int;
        final end = positionalArgs[1] as int;
        final fillValue = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return (target as Uint8List).fillRange(start, end, fillValue);
      },
      'getRange': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.getRange', atMost: 2);
        final start = positionalArgs[0] as int;
        final end = positionalArgs[1] as int;
        return (target as Uint8List).getRange(start, end);
      },
      'setAll': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.setAll', atMost: 2);
        final index = positionalArgs[0] as int;
        final iterable = coerceElements<int>(
          positionalArgs[1],
          'Uint8List.setAll',
        );
        return (target as Uint8List).setAll(index, iterable);
      },
      'setRange': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.setRange', atMost: 4);
        final start = positionalArgs[0] as int;
        final end = positionalArgs[1] as int;
        final iterable = coerceElements<int>(
          positionalArgs[2],
          'Uint8List.setRange',
        );
        final skipCount = positionalArgs.length > 3
            ? positionalArgs[3] as int
            : 0;
        return (target as Uint8List).setRange(start, end, iterable, skipCount);
      },
      'sublist': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.sublist', atMost: 2);
        final start = positionalArgs[0] as int;
        final end = positionalArgs.length > 1
            ? positionalArgs[1] as int?
            : null;
        return (target as Uint8List).sublist(start, end);
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Uint8List).toString();
      },
      '==': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uint8List.==', atMost: 1);
        return (target as Uint8List) == positionalArgs[0];
      },

      // Inherited Iterable<int> / List<int> read-only methods.
      // See inherited_list_methods.dart — these are declared per variant
      // because the element type has to be reified at the native boundary,
      // which the generic `List` bridge cannot do. The supertype walk does
      // reach `List`, so pruning this spread looks safe and is not.
      //
      // SCD28: Uint8List used to hand-roll all of this, which is how it ended
      // up the one variant whose behaviour differed — twice, in opposite
      // directions (SCB3 gave it `sort`/`shuffle`/`asUnmodifiableView` the
      // others lacked; SCC9 gave it a `_TypeError` where the others raised a
      // catchable `UnsupportedError`). It is the variant most likely to be
      // probed and the one least representative of the family, so every
      // spot-check of "typed lists" was a spot-check of the special case.
      ...inheritedListMethods<int>(
        (t) => t as Uint8List,
        unmodifiableView: (t) => (t as Uint8List).asUnmodifiableView(),
      ),
    },
    // Uint8List hand-rolls its instance maps rather than sharing
    // inheritedListMethods, but the static is the same for every variant.
    staticGetters: typedListStaticGetters(Uint8List.bytesPerElement),
    getters: {
      'length': (visitor, target) => (target as Uint8List).length,
      'elementSizeInBytes': (visitor, target) =>
          (target as Uint8List).elementSizeInBytes,
      'buffer': (visitor, target) => (target as Uint8List).buffer,
      'lengthInBytes': (visitor, target) => (target as Uint8List).lengthInBytes,
      'offsetInBytes': (visitor, target) => (target as Uint8List).offsetInBytes,
      'first': (visitor, target) => (target as Uint8List).first,
      'last': (visitor, target) => (target as Uint8List).last,
      'isEmpty': (visitor, target) => (target as Uint8List).isEmpty,
      'isNotEmpty': (visitor, target) => (target as Uint8List).isNotEmpty,
      'iterator': (visitor, target) => (target as Uint8List).iterator,
      'reversed': (visitor, target) => (target as Uint8List).reversed,
      'single': (visitor, target) => (target as Uint8List).single,
      'hashCode': (visitor, target) => (target as Uint8List).hashCode,
      'runtimeType': (visitor, target) => (target as Uint8List).runtimeType,
    },
    setters: inheritedListSetters<int>((t) => t as Uint8List),
  );
}
