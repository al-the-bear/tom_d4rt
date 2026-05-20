import 'package:tom_d4rt_ast/runtime.dart';

class NullCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Null,
        name: 'Null',
        // ignore: type_check_with_null
        isAssignable: (v) => v == null,
        typeParameterCount: 0,
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Null).toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Null).hashCode,
        },
      );
}
