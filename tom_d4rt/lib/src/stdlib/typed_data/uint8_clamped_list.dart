import 'dart:typed_data';
import 'package:tom_d4rt/d4rt.dart';

class Uint8ClampedListTypedData {
  static BridgedClass get definition => BridgedClass(
        name: 'Uint8ClampedList',
        nativeType: Uint8ClampedList,
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && positionalArgs[0] is int) {
              return Uint8ClampedList(positionalArgs[0] as int);
            }
            throw RuntimeD4rtException(
                "Uint8ClampedList constructor expects one int argument (length).");
          },
          'fromList': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length == 1 && positionalArgs[0] is List) {
              final sourceList = positionalArgs[0] as List;
              final intList = sourceList.toNativeList().map((e) {
                if (e is int) return e;
                throw RuntimeD4rtException("Uint8ClampedList.fromList expects a List<int>.");
              }).toList();
              return Uint8ClampedList.fromList(intList);
            }
            throw RuntimeD4rtException(
                "Uint8ClampedList.fromList expects one List<int> argument.");
          },
          'view': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty && positionalArgs[0] is ByteBuffer) {
              final buffer = positionalArgs[0] as ByteBuffer;
              final offsetInBytes = positionalArgs.length > 1
                  ? positionalArgs[1] as int? ?? 0
                  : 0;
              final length =
                  positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
              return Uint8ClampedList.view(buffer, offsetInBytes, length);
            }
            throw RuntimeD4rtException(
                "Uint8ClampedList.view expects ByteBuffer and optional offset/length arguments.");
          },
          'sublistView': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty && positionalArgs[0] is TypedData) {
              final data = positionalArgs[0] as TypedData;
              final start = positionalArgs.length > 1
                  ? positionalArgs[1] as int? ?? 0
                  : 0;
              final end =
                  positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
              return Uint8ClampedList.sublistView(data, start, end);
            }
            throw RuntimeD4rtException(
                "Uint8ClampedList.sublistView expects TypedData and optional start/end arguments.");
          },
        },
        methods: {
          // Index operators
          '[]': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Uint8ClampedList &&
                positionalArgs.length == 1 &&
                positionalArgs[0] is int) {
              return target[positionalArgs[0] as int];
            }
            throw RuntimeD4rtException("Uint8ClampedList[index] expects an int index.");
          },
          '[]=': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Uint8ClampedList &&
                positionalArgs.length == 2 &&
                positionalArgs[0] is int &&
                positionalArgs[1] is int) {
              final index = positionalArgs[0] as int;
              final value = positionalArgs[1] as int;
              target[index] = value;
              return value;
            }
            throw RuntimeD4rtException(
                "Uint8ClampedList[index] = value expects int index and int value.");
          },

          // List methods
          'sublist': (visitor, target, positionalArgs, namedArgs, _) {
            final start =
                positionalArgs.isNotEmpty ? positionalArgs[0] as int : 0;
            final end =
                positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
            return (target as Uint8ClampedList).sublist(start, end);
          },
          'getRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            return (target as Uint8ClampedList).getRange(start, end);
          },
          'setRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            final iterable = positionalArgs[2] as Iterable<int>;
            final skipCount =
                positionalArgs.length > 3 ? positionalArgs[3] as int : 0;
            (target as Uint8ClampedList).setRange(start, end, iterable, skipCount);
            return null;
          },
          'setAll': (visitor, target, positionalArgs, namedArgs, _) {
            final at = positionalArgs[0] as int;
            final iterable = positionalArgs[1] as Iterable<int>;
            (target as Uint8ClampedList).setAll(at, iterable);
            return null;
          },
          'fillRange': (visitor, target, positionalArgs, namedArgs, _) {
            final start = positionalArgs[0] as int;
            final end = positionalArgs[1] as int;
            final fill =
                positionalArgs.length > 2 ? positionalArgs[2] as int? : null;
            (target as Uint8ClampedList).fillRange(start, end, fill);
            return null;
          },

          // Typed methods
          'buffer': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Uint8ClampedList).buffer;
          },
          'asUint8ListView': (visitor, target, positionalArgs, namedArgs, _) {
            final offsetInBytes =
                positionalArgs.isNotEmpty ? positionalArgs[0] as int? : null;
            final length =
                positionalArgs.length > 1 ? positionalArgs[1] as int? : null;
            return (target as Uint8ClampedList)
                .buffer
                .asUint8List(offsetInBytes ?? 0, length);
          },

          // Standard methods
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Uint8ClampedList).toString();
          },
          '==': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Uint8ClampedList) == positionalArgs[0];
          },
        },
        getters: {
          'length': (visitor, target) {
            if (target is Uint8ClampedList) return target.length;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'length'");
          },
          'lengthInBytes': (visitor, target) {
            if (target is Uint8ClampedList) return target.lengthInBytes;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'lengthInBytes'");
          },
          'elementSizeInBytes': (visitor, target) {
            if (target is Uint8ClampedList) return target.elementSizeInBytes;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'elementSizeInBytes'");
          },
          'offsetInBytes': (visitor, target) {
            if (target is Uint8ClampedList) return target.offsetInBytes;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'offsetInBytes'");
          },
          'buffer': (visitor, target) {
            if (target is Uint8ClampedList) return target.buffer;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'buffer'");
          },
          'first': (visitor, target) {
            if (target is Uint8ClampedList) return target.first;
            throw RuntimeD4rtException("Target is not an Uint8ClampedList for getter 'first'");
          },
          'last': (visitor, target) {
            if (target is Uint8ClampedList) return target.last;
            throw RuntimeD4rtException("Target is not an Uint8ClampedList for getter 'last'");
          },
          'isEmpty': (visitor, target) {
            if (target is Uint8ClampedList) return target.isEmpty;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'isEmpty'");
          },
          'isNotEmpty': (visitor, target) {
            if (target is Uint8ClampedList) return target.isNotEmpty;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'isNotEmpty'");
          },
          'hashCode': (visitor, target) {
            if (target is Uint8ClampedList) return target.hashCode;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is Uint8ClampedList) return target.runtimeType;
            throw RuntimeD4rtException(
                "Target is not an Uint8ClampedList for getter 'runtimeType'");
          },
        },
      );
}
