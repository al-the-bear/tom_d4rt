import 'package:tom_d4rt_ast/runtime.dart';

class SinkCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Sink,
        name: 'Sink',
        typeParameterCount: 1,
        constructors: {},
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException('Sink.add requires exactly one argument.');
            }
            (target as Sink).add(positionalArgs[0]);
            return null;
          },
          'close': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException('Sink.close expects no arguments.');
            }
            (target as Sink).close();
            return null;
          },
          'hashCode': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Sink).hashCode,
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Sink).toString(),
        },
        getters: {
          'hashCode': (visitor, target) => (target as Sink).hashCode,
          'runtimeType': (visitor, target) => (target as Sink).runtimeType,
        },
      );
}
