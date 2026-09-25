import 'package:tom_d4rt/d4rt.dart';

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
        // SCE185: `Sink.close` is declared `void`, but every implementation a
        // script meets returns a `Future` (an IOSink, a socket, a controller),
        // and the subtype adapters hand it back. Discarding it here made
        // `await sink.close()` wait for nothing whenever dispatch reached this
        // adapter. Forward whatever the native call produced.
        return (target as dynamic).close();
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Sink).toString(),
    },
    getters: {
      'hashCode': (visitor, target) => (target as Sink).hashCode,
      'runtimeType': (visitor, target) => (target as Sink).runtimeType,
    },
  );
}
