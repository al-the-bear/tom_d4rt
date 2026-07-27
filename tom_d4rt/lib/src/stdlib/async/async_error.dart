import 'dart:async';
import 'package:tom_d4rt/d4rt.dart';

/// `AsyncError` — the error/stackTrace pair that stream and zone plumbing
/// passes around.
///
/// Scripts meet it from two directions: they construct one to forward an error
/// with its original trace intact, and they receive one from zone error
/// handlers. Both need `error` and `stackTrace` to be readable, which is the
/// bulk of the class.
///
/// The SDK declares `class AsyncError implements Error`, so the `Error` edge is
/// registered in the supertype registry (see [AsyncErrorStdlib.register]) and
/// `on Error catch` keeps catching it. `isAssignable` is safe here — unlike the
/// interface types in `stream.dart`, `AsyncError` is concrete and final in
/// practice, so it cannot shadow a more specific bridge.
class AsyncErrorAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: AsyncError,
        name: 'AsyncError',
        isAssignable: (v) => v is AsyncError,
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty || positionalArgs[0] == null) {
              throw RuntimeD4rtException(
                  'AsyncError constructor requires a non-null error argument.');
            }
            // The SDK's second parameter is required-but-nullable. Scripts
            // routinely write `AsyncError(e)` expecting the SDK's
            // `defaultStackTrace` fallback, so accept the one-argument form
            // rather than making them pass an explicit null.
            final stackTrace = positionalArgs.length > 1
                ? positionalArgs[1] as StackTrace?
                : null;
            return AsyncError(positionalArgs[0] as Object, stackTrace);
          },
        },
        staticMethods: {
          'defaultStackTrace': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty || positionalArgs[0] == null) {
              throw RuntimeD4rtException(
                  'AsyncError.defaultStackTrace requires a non-null error.');
            }
            return AsyncError.defaultStackTrace(positionalArgs[0] as Object);
          },
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as AsyncError).toString(),
        },
        getters: {
          'error': (visitor, target) => (target as AsyncError).error,
          'stackTrace': (visitor, target) => (target as AsyncError).stackTrace,
          'hashCode': (visitor, target) => (target as AsyncError).hashCode,
          'runtimeType': (visitor, target) => (target as AsyncError).runtimeType,
        },
      );
}

class AsyncErrorStdlib {
  static void register(Environment environment) {
    environment.defineBridge(AsyncErrorAsync.definition);

    // `class AsyncError implements Error` — bridges are registered flat, so
    // this registry entry is the only thing that can make `e is Error` and
    // `on Error catch (e)` see an AsyncError.
    BridgedClass.registerSupertypes(const {
      'AsyncError': ['Error'],
    });
  }
}
