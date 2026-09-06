import 'package:tom_d4rt/d4rt.dart';

class StackTraceCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: StackTrace,
    name: 'StackTrace',
    typeParameterCount: 0,
    nativeNames: ['_StringStackTrace'],
    constructors: {
      'fromString': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'StackTrace.fromString requires one String argument.',
          );
        }
        return StackTrace.fromString(positionalArgs[0] as String);
      },
    },
    staticGetters: {
      'current': (visitor) => StackTrace.current,
      'empty': (visitor) => StackTrace.empty,
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as StackTrace).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as StackTrace).hashCode,
      'runtimeType': (visitor, target) => (target as StackTrace).runtimeType,
    },
  );
}
