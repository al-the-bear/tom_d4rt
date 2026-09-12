import 'package:tom_d4rt/d4rt.dart';

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
            'Function.apply requires a Callable as the first argument.',
          );
        }
        final functionToApply = positionalArgs[0] as Callable;
        final argumentsToPass = positionalArgs.length > 1
            ? positionalArgs[1] as List<Object?>
            : <Object?>[];
        // SCD70: coerce, not cast. `Function.apply(f, args, named)` is
        // `dart:core`, not io, and it failed the same way every byte API did:
        // a map literal written in a script is a `Map<Object?, Object?>`, so
        // the cast threw for the only spelling a script can produce.
        final namedArgumentsToPass = positionalArgs.length > 2
            ? D4.coerceMap<String, Object?>(
                positionalArgs[2],
                'namedArguments',
                visitor,
              )
            : namedArgs;

        return functionToApply.call(
          visitor,
          argumentsToPass,
          namedArgumentsToPass,
        );
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
