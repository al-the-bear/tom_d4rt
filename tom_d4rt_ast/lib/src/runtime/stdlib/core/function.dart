import 'package:tom_d4rt_ast/runtime.dart';

class FunctionCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Function,
        name: 'Function',
        typeParameterCount: 0,
        constructors: {},
        staticMethods: {
          'apply': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty || positionalArgs[0] is! Callable) {
              throw RuntimeD4rtException(
                  'Function.apply requires a Callable as the first argument.');
            }
            final functionToApply = positionalArgs[0] as Callable;
            final argumentsToPass = positionalArgs.length > 1
                ? positionalArgs[1] as List<Object?>
                : <Object?>[];
            final namedArgumentsToPass = positionalArgs.length > 2
                ? positionalArgs[2] as Map<String, Object?>
                : namedArgs;

            return functionToApply.call(
                visitor, argumentsToPass, namedArgumentsToPass);
          },
        },
        methods: {
          'call': (visitor, target, positionalArgs, namedArgs, _) {
            if (target is Callable) {
              return target.call(visitor, positionalArgs, namedArgs);
            }
            throw RuntimeD4rtException('Cannot call non-Callable Function');
          },
          'hashCode': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Function).hashCode,
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Function).toString(),
        },
        getters: {
          'hashCode': (visitor, target) => (target as Function).hashCode,
          'runtimeType': (visitor, target) => (target as Function).runtimeType,
        },
      );
}
