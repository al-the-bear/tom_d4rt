import 'dart:typed_data';
import 'package:tom_d4rt_exec/d4rt.dart';

class ByteBufferTypedData {
  static BridgedClass get definition => BridgedClass(
        name: 'ByteBuffer',
        nativeType: ByteBuffer,
        typeParameterCount: 0,
        constructors: {},
        methods: {
          'asUint8List': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ByteBuffer) {
              int offsetInBytes = 0;
              int? length;
              if (positionalArgs.isNotEmpty) {
                if (positionalArgs[0] is int) {
                  offsetInBytes = positionalArgs[0] as int;
                } else {
                  throw RuntimeD4rtException(
                      "asUint8List: offsetInBytes must be an int.");
                }
              }
              if (positionalArgs.length > 1) {
                if (positionalArgs[1] is int?) {
                  length = positionalArgs[1] as int?;
                } else if (positionalArgs[1] != null) {
                  throw RuntimeD4rtException(
                      "asUint8List: length must be an int or null.");
                }
              }
              return target.asUint8List(offsetInBytes, length);
            }
            throw RuntimeD4rtException("Target is not a ByteBuffer for asUint8List");
          },
          'asByteData': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is ByteBuffer) {
              int offsetInBytes = 0;
              int? length;
              if (positionalArgs.isNotEmpty) {
                if (positionalArgs[0] is int) {
                  offsetInBytes = positionalArgs[0] as int;
                } else {
                  throw RuntimeD4rtException(
                      "asByteData: offsetInBytes must be an int.");
                }
              }
              if (positionalArgs.length > 1) {
                if (positionalArgs[1] is int?) {
                  length = positionalArgs[1] as int?;
                } else if (positionalArgs[1] != null) {
                  throw RuntimeD4rtException(
                      "asByteData: length must be an int or null.");
                }
              }
              return target.asByteData(offsetInBytes, length);
            }
            throw RuntimeD4rtException("Target is not a ByteBuffer for asByteData");
          },
        },
        getters: {
          'lengthInBytes': (visitor, target) {
            if (target is ByteBuffer) {
              return target.lengthInBytes;
            }
            throw RuntimeD4rtException(
                "Target is not a ByteBuffer for getter 'lengthInBytes'");
          },
          'hashCode': (visitor, target) {
            if (target is ByteBuffer) {
              return target.hashCode;
            }
            throw RuntimeD4rtException(
                "Target is not a ByteBuffer for getter 'hashCode'");
          },
          'runtimeType': (visitor, target) {
            if (target is ByteBuffer) {
              return target.runtimeType;
            }
            throw RuntimeD4rtException(
                "Target is not a ByteBuffer for getter 'runtimeType'");
          },
        },
      );
}
