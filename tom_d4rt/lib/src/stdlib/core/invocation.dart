import 'package:tom_d4rt/d4rt.dart';

/// Bug-78 FIX: Bridge for the Invocation class to support noSuchMethod
class InvocationCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Invocation,
        name: 'Invocation',
        typeParameterCount: 0,
        constructors: {
          // Invocation has factory constructors, no public default constructor
          'method': (visitor, positionalArgs, namedArgs) {
            final memberName = positionalArgs[0] as Symbol;
            final positional = positionalArgs.length > 1 
                ? (positionalArgs[1] as List?)?.cast<Object?>() ?? <Object?>[]
                : <Object?>[];
            final named = positionalArgs.length > 2 
                ? (positionalArgs[2] as Map?)?.cast<Symbol, Object?>() ?? <Symbol, Object?>{}
                : <Symbol, Object?>{};
            return Invocation.method(memberName, positional, named);
          },
          'getter': (visitor, positionalArgs, namedArgs) {
            final memberName = positionalArgs[0] as Symbol;
            return Invocation.getter(memberName);
          },
          'setter': (visitor, positionalArgs, namedArgs) {
            final memberName = positionalArgs[0] as Symbol;
            final argument = positionalArgs[1];
            return Invocation.setter(memberName, argument);
          },
          'genericMethod': (visitor, positionalArgs, namedArgs) {
            final memberName = positionalArgs[0] as Symbol;
            final typeArgs = (positionalArgs[1] as List?)?.cast<Type>() ?? <Type>[];
            final positional = positionalArgs.length > 2 
                ? (positionalArgs[2] as List?)?.cast<Object?>() ?? <Object?>[]
                : <Object?>[];
            final named = positionalArgs.length > 3 
                ? (positionalArgs[3] as Map?)?.cast<Symbol, Object?>() ?? <Symbol, Object?>{}
                : <Symbol, Object?>{};
            return Invocation.genericMethod(memberName, typeArgs, positional, named);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Invocation).toString();
          },
        },
        getters: {
          'memberName': (visitor, target) => (target as Invocation).memberName,
          'positionalArguments': (visitor, target) => (target as Invocation).positionalArguments,
          'namedArguments': (visitor, target) => (target as Invocation).namedArguments,
          'typeArguments': (visitor, target) => (target as Invocation).typeArguments,
          'isMethod': (visitor, target) => (target as Invocation).isMethod,
          'isGetter': (visitor, target) => (target as Invocation).isGetter,
          'isSetter': (visitor, target) => (target as Invocation).isSetter,
          'isAccessor': (visitor, target) => (target as Invocation).isAccessor,
          'hashCode': (visitor, target) => (target as Invocation).hashCode,
          'runtimeType': (visitor, target) => (target as Invocation).runtimeType,
        },
      );
}
