import 'package:tom_d4rt_ast/runtime.dart';

class ErrorCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Error,
        name: 'Error',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            return Error();
          },
        },
        staticMethods: {
          'safeToString': (visitor, positionalArgs, namedArgs, _) {
            return Error.safeToString(positionalArgs[0]);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Error).toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Error).hashCode,
          'runtimeType': (visitor, target) => (target as Error).runtimeType,
          'stackTrace': (visitor, target) => (target as Error).stackTrace,
        },
      );
}

class StateErrorCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: StateError,
        name: 'StateError',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final message = positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
            return StateError(message);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as StateError).toString();
          },
        },
        getters: {
          'message': (visitor, target) => (target as StateError).message,
          'hashCode': (visitor, target) => (target as StateError).hashCode,
          'runtimeType': (visitor, target) => (target as StateError).runtimeType,
          'stackTrace': (visitor, target) => (target as StateError).stackTrace,
        },
      );
}

class ArgumentErrorCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: ArgumentError,
        name: 'ArgumentError',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final message = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            return ArgumentError(message);
          },
          'value': (visitor, positionalArgs, namedArgs) {
            final value = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            final name = positionalArgs.length > 1 ? positionalArgs[1] as String? : null;
            final message = positionalArgs.length > 2 ? positionalArgs[2] : null;
            return ArgumentError.value(value, name, message);
          },
          'notNull': (visitor, positionalArgs, namedArgs) {
            final name = positionalArgs.isNotEmpty ? positionalArgs[0] as String? : null;
            return ArgumentError.notNull(name);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as ArgumentError).toString();
          },
        },
        getters: {
          'message': (visitor, target) => (target as ArgumentError).message,
          'name': (visitor, target) => (target as ArgumentError).name,
          'invalidValue': (visitor, target) => (target as ArgumentError).invalidValue,
          'hashCode': (visitor, target) => (target as ArgumentError).hashCode,
          'runtimeType': (visitor, target) => (target as ArgumentError).runtimeType,
          'stackTrace': (visitor, target) => (target as ArgumentError).stackTrace,
        },
      );
}

class RangeErrorCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: RangeError,
        name: 'RangeError',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final message = positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
            return RangeError(message);
          },
          'value': (visitor, positionalArgs, namedArgs) {
            final value = positionalArgs[0] as num;
            final name = positionalArgs.length > 1 ? positionalArgs[1] as String? : null;
            final message = positionalArgs.length > 2 ? positionalArgs[2] as String? : null;
            return RangeError.value(value, name, message);
          },
          'range': (visitor, positionalArgs, namedArgs) {
            final invalidValue = positionalArgs[0] as num;
            final minValue = positionalArgs[1] as num?;
            final maxValue = positionalArgs[2] as num?;
            final name = positionalArgs.length > 3 ? positionalArgs[3] as String? : null;
            final message = positionalArgs.length > 4 ? positionalArgs[4] as String? : null;
            return RangeError.range(invalidValue, minValue as int?, maxValue as int?, name, message);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as RangeError).toString();
          },
        },
        getters: {
          'start': (visitor, target) => (target as RangeError).start,
          'end': (visitor, target) => (target as RangeError).end,
          'message': (visitor, target) => (target as RangeError).message,
          'name': (visitor, target) => (target as RangeError).name,
          'invalidValue': (visitor, target) => (target as RangeError).invalidValue,
          'hashCode': (visitor, target) => (target as RangeError).hashCode,
          'runtimeType': (visitor, target) => (target as RangeError).runtimeType,
          'stackTrace': (visitor, target) => (target as RangeError).stackTrace,
        },
      );
}

class UnsupportedErrorCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: UnsupportedError,
        name: 'UnsupportedError',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final message = positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
            return UnsupportedError(message);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UnsupportedError).toString();
          },
        },
        getters: {
          'message': (visitor, target) => (target as UnsupportedError).message,
          'hashCode': (visitor, target) => (target as UnsupportedError).hashCode,
          'runtimeType': (visitor, target) => (target as UnsupportedError).runtimeType,
          'stackTrace': (visitor, target) => (target as UnsupportedError).stackTrace,
        },
      );
}

class UnimplementedErrorCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: UnimplementedError,
        name: 'UnimplementedError',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final message = positionalArgs.isNotEmpty ? positionalArgs[0] as String? : null;
            return UnimplementedError(message);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UnimplementedError).toString();
          },
        },
        getters: {
          'message': (visitor, target) => (target as UnimplementedError).message,
          'hashCode': (visitor, target) => (target as UnimplementedError).hashCode,
          'runtimeType': (visitor, target) => (target as UnimplementedError).runtimeType,
          'stackTrace': (visitor, target) => (target as UnimplementedError).stackTrace,
        },
      );
}
