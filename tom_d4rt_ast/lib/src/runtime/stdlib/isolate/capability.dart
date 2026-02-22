import 'dart:isolate';
import 'package:tom_d4rt_ast/runtime.dart';

class CapabilityIsolate {
  static BridgedClass get definition => BridgedClass(
        nativeType: Capability,
        name: 'Capability',
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            return Capability();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Capability).hashCode,
          'runtimeType': (visitor, target) =>
              (target as Capability).runtimeType,
        },
      );
}
