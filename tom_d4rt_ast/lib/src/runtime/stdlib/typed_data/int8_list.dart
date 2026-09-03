import 'dart:typed_data';
import 'package:tom_d4rt_ast/runtime.dart';

import 'inherited_list_methods.dart';

class Int8ListTypedData {
  static BridgedClass get definition => BridgedClass(
        name: 'Int8List',
        nativeType: Int8List,
        isAssignable: (v) => v is Int8List,
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && positionalArgs[0] is int) {
              return Int8List(positionalArgs[0] as int);
            }
            throw RuntimeD4rtException(
                "Int8List constructor expects one int argument (length).");
          },
          'fromList': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && positionalArgs[0] is List) {
              final sourceList = positionalArgs[0] as List;
              final intList = sourceList.toNativeList().map((e) {
                if (e is int) return e;
                throw RuntimeD4rtException("Int8List.fromList expects a List<int>.");
              }).toList();
              return Int8List.fromList(intList);
            }
            throw RuntimeD4rtException(
                "Int8List.fromList expects one List<int> argument.");
          },
          'view': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty && positionalArgs[0] is ByteBuffer) {
              final buffer = positionalArgs[0] as ByteBuffer;
              final offsetInBytes = positionalArgs.length > 1
                  ? positionalArgs[1] as int? ?? 0
                  : 0;
              final length =
                  positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
              return Int8List.view(buffer, offsetInBytes, length);
            }
            throw RuntimeD4rtException(
                "Int8List.view expects ByteBuffer and optional offset/length arguments.");
          },
          'sublistView': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty && positionalArgs[0] is TypedData) {
              final data = positionalArgs[0] as TypedData;
              final start = positionalArgs.length > 1
                  ? positionalArgs[1] as int? ?? 0
                  : 0;
              final end =
                  positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
              return Int8List.sublistView(data, start, end);
            }
            throw RuntimeD4rtException(
                "Int8List.sublistView expects TypedData and optional start/end arguments.");
          },
        },
        methods: {
          // Index operators
          '[]': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Int8List &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is int) {
              return target[positionalArgs[0] as int];
            }
            throw RuntimeD4rtException("Int8List[index] expects an int index.");
          },
          '[]=': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Int8List &&
                positionalArgs.length == 2 &&
                positionalArgs[0] is int &&
                positionalArgs[1] is int) {
              final index = positionalArgs[0] as int;
              final value = positionalArgs[1] as int;
              target[index] = value;
              return value;
            }
            throw RuntimeD4rtException(
                "Int8List[index] = value expects int index and int value.");
          },

          // List methods
          'sublist': (visitor, target, positionalArgs, namedArgs, _) {
            final start =
                positionalArgs.isNotEmpty ? positionalArgs[0] as int : 0;
            final end =
                positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
            return (target as Int8List).sublist(start, end);
          },
          'getRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            return (target as Int8List).getRange(start, end);
          },
          'setRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            final iterable = coerceElements<int>(
                positionalArgs[2], 'Int8List.setRange');
            final skipCount =
                positionalArgs.length > 3 ? positionalArgs[3] as int : 0;
            (target as Int8List).setRange(start, end, iterable, skipCount);
            return null;
          },
          'setAll': (visitor, target, positionalArgs, namedArgs, _) {
            final at = positionalArgs[0] as int;
            final iterable = coerceElements<int>(
                positionalArgs[1], 'Int8List.setAll');
            (target as Int8List).setAll(at, iterable);
            return null;
          },
          'fillRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            final fill =
                positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
            (target as Int8List).fillRange(start, end, fill);
            return null;
          },

          // Typed methods
          'buffer': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Int8List).buffer;
          },
          'asUint8ListView': (visitor, target, positionalArgs, namedArgs, _) {
            final offsetInBytes =
                positionalArgs.isNotEmpty ? positionalArgs[0] as int? : null;
            final length =
                positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
            return (target as Int8List)
                .buffer
                .asUint8List(offsetInBytes ?? 0, length);
          },

          // Standard methods
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Int8List).toString();
          },
          '==': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Int8List) == positionalArgs[0];
          },

          // Inherited Iterable<int> / List<int> read-only methods.
          // See inherited_list_methods.dart — the interpreter resolves
          // bridged methods without walking the supertype chain, so each
          // typed-data variant must declare these directly.
          ...inheritedListMethods<int>((t) => t as Int8List,
              unmodifiableView: (t) => (t as Int8List).asUnmodifiableView()),
        },
        staticGetters: typedListStaticGetters(Int8List.bytesPerElement),
        getters: {
          'length': (visitor, target) {
            if (target is Int8List) return target.length;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'length'");
          },
          'lengthInBytes': (visitor, target) {
            if (target is Int8List) return target.lengthInBytes;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'lengthInBytes'");
          },
          'elementSizeInBytes': (visitor, target) {
            if (target is Int8List) return target.elementSizeInBytes;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'elementSizeInBytes'");
          },
          'offsetInBytes': (visitor, target) {
            if (target is Int8List) return target.offsetInBytes;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'offsetInBytes'");
          },
          'buffer': (visitor, target) {
            if (target is Int8List) return target.buffer;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'buffer'");
          },
          'first': (visitor, target) {
            if (target is Int8List) return target.first;
            throw RuntimeD4rtException("Target is not an Int8List for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is Int8List) return target.last;
            throw RuntimeD4rtException("Target is not an Int8List for getter 'last'");
          },
          'isEmpty': (visitor, target) {
            if (target is Int8List) return target.isEmpty;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is Int8List) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'isNotEmpty'");
          },
          'hashCode': (visitor, target) {
            if (target is Int8List) return target.hashCode;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is Int8List) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not an Int8List for getter 'runtimeType'");
          },

          // Inherited getters (single, iterator, reversed).
          ...inheritedListGetters<int>((t) => t as Int8List),
        },
      );
}
