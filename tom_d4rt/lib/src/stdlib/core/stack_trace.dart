import 'package:tom_d4rt/d4rt.dart';

class StackTraceCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: StackTrace,
        name: 'StackTrace',
        typeParameterCount: 0,
        nativeNames: [
          '_StringStackTrace',
        ],
        staticMethods: {
          'current': (visitor, positionalArgs, namedArgs, _) {
            return StackTrace.current;
          },
          'empty': (visitor, positionalArgs, namedArgs, _) {
            return StackTrace.empty;
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as StackTrace).toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as StackTrace).hashCode,
          'runtimeType': (visitor, target) =>
              (target as StackTrace).runtimeType,
        },
      );
}
