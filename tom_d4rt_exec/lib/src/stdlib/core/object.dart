import 'package:tom_d4rt_exec/d4rt.dart';

class ObjectCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Object,
        name: 'Object',
        typeParameterCount: 0,
        methods: {
          '==': (visitor, target, positionalArgs, namedArgs, _) {
            return target == positionalArgs[0];
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return target.toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => target.hashCode,
          'runtimeType': (visitor, target) => target.runtimeType,
        },
      );
}
