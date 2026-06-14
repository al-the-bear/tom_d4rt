import 'package:tom_d4rt_ast/runtime.dart';

class NullCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Null,
        name: 'Null',
        // ignore: type_check_with_null
        isAssignable: (v) => v == null,
        typeParameterCount: 0,
        methods: {
          // The `Null` bridge's target is always the null value, so calling
          // through `null` directly is equivalent and avoids the cast-to-Null
          // pattern that the analyzer flags as dead code.
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return null.toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => null.hashCode,
        },
      );
}
