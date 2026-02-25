import 'dart:typed_data';
import 'package:tom_d4rt_ast/runtime.dart';

class EndianTypedData {
  static BridgedClass get definition => BridgedClass(
        name: 'Endian',
        nativeType: Endian,
        typeParameterCount: 0,
        constructors: {},
        staticGetters: {
          'big': (InterpreterVisitor visitor) => Endian.big,
          'little': (InterpreterVisitor visitor) => Endian.little,
          'host': (InterpreterVisitor visitor) => Endian.host,
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Endian).toString();
          },
          '==': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Endian) == positionalArgs[0];
          },
        },
        getters: {
          'hashCode': (visitor, target) {
            return (target as Endian).hashCode;
          },
          'runtimeType': (visitor, target) {
            return (target as Endian).runtimeType;
          },
        },
      );
}
