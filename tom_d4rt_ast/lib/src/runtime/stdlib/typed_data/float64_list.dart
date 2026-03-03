import 'dart:typed_data';
import 'package:tom_d4rt_ast/runtime.dart';

class Float64ListTypedData {
  static BridgedClass get definition => BridgedClass(
        name: 'Float64List',
        nativeType: Float64List,
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && positionalArgs[0] is int) {
              return Float64List(positionalArgs[0] as int);
            }
            throw RuntimeD4rtException(
                "Float64List constructor expects one int argument (length).");
          },
          'fromList': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && positionalArgs[0] is List) {
              final sourceList = positionalArgs[0] as List;
              final doubleList = sourceList.toNativeList().map((e) {
                if (e is num) return e.toDouble();
                throw RuntimeD4rtException("Float64List.fromList expects a List<num>.");
              }).toList();
              return Float64List.fromList(doubleList);
            }
            throw RuntimeD4rtException(
                "Float64List.fromList expects one List<num> argument.");
          },
          'view': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty && positionalArgs[0] is ByteBuffer) {
              final buffer = positionalArgs[0] as ByteBuffer;
              final offsetInBytes = positionalArgs.length > 1
                  ? positionalArgs[1] as int? ?? 0
                  : 0;
              final length =
                  positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
              return Float64List.view(buffer, offsetInBytes, length);
            }
            throw RuntimeD4rtException(
                "Float64List.view expects ByteBuffer and optional offset/length arguments.");
          },
          'sublistView': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty && positionalArgs[0] is TypedData) {
              final data = positionalArgs[0] as TypedData;
              final start = positionalArgs.length > 1
                  ? positionalArgs[1] as int? ?? 0
                  : 0;
              final end =
                  positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
              return Float64List.sublistView(data, start, end);
            }
            throw RuntimeD4rtException(
                "Float64List.sublistView expects TypedData and optional start/end arguments.");
          },
        },
        methods: {
          // Index operators
          '[]': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Float64List &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is int) {
              return target[positionalArgs[0] as int];
            }
            throw RuntimeD4rtException("Float64List[index] expects an int index.");
          },
          '[]=': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Float64List &&
                positionalArgs.length == 2 &&
                positionalArgs[0] is int &&
                positionalArgs[1] is num) {
              final index = positionalArgs[0] as int;
              final value = (positionalArgs[1] as num).toDouble();
              target[index] = value;
              return value;
            }
            throw RuntimeD4rtException(
                "Float64List[index] = value expects int index and num value.");
          },

          // List methods
          'sublist': (visitor, target, positionalArgs, namedArgs, _) {
            final start =
                positionalArgs.isNotEmpty ? positionalArgs[0] as int : 0;
            final end =
                positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
            return (target as Float64List).sublist(start, end);
          },
          'getRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            return (target as Float64List).getRange(start, end);
          },
          'setRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            final iterable = positionalArgs[2] as Iterable<double>;
            final skipCount =
                positionalArgs.length > 3 ? positionalArgs[3] as int : 0;
            (target as Float64List).setRange(start, end, iterable, skipCount);
            return null;
          },
          'setAll': (visitor, target, positionalArgs, namedArgs, _) {
            final at = positionalArgs[0] as int;
            final iterable = positionalArgs[1] as Iterable<double>;
            (target as Float64List).setAll(at, iterable);
            return null;
          },
          'fillRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            final fill = positionalArgs.length > 2
                ? (positionalArgs[2] as num?)?.toDouble()
                : null;
            (target as Float64List).fillRange(start, end, fill);
            return null;
          },

          // Typed methods
          'buffer': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Float64List).buffer;
          },
          'asUint8ListView': (visitor, target, positionalArgs, namedArgs, _) {
            final offsetInBytes =
                positionalArgs.isNotEmpty ? positionalArgs[0] as int? : null;
            final length =
                positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
            return (target as Float64List)
                .buffer
                .asUint8List(offsetInBytes ?? 0, length);
          },

          // Standard methods
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Float64List).toString();
          },
          '==': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Float64List) == positionalArgs[0];
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is Float64List) return target.length;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'length'");
          },
          'lengthInBytes': (visitor, target) {
            if (target is Float64List) return target.lengthInBytes;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'lengthInBytes'");
          },
          'elementSizeInBytes': (visitor, target) {
            if (target is Float64List) return target.elementSizeInBytes;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'elementSizeInBytes'");
          },
          'offsetInBytes': (visitor, target) {
            if (target is Float64List) return target.offsetInBytes;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'offsetInBytes'");
          },
          'buffer': (visitor, target) {
            if (target is Float64List) return target.buffer;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'buffer'");
          },
          'first': (visitor, target) {
            if (target is Float64List) return target.first;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is Float64List) return target.last;
            throw RuntimeD4rtException("Target is not a Float64List for getter 'last'");
          },
          'isEmpty': (visitor, target) {
            if (target is Float64List) return target.isEmpty;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is Float64List) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'isNotEmpty'");
          },
          'hashCode': (visitor, target) {
            if (target is Float64List) return target.hashCode;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is Float64List) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not a Float64List for getter 'runtimeType'");
          },
        },
      );
}
