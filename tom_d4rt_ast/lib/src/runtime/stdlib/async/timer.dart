import 'dart:async';
import 'package:tom_d4rt_ast/runtime.dart';

class TimerAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: Timer,
        name: 'Timer',
        nativeNames: ['TimerImpl'],
        // GEN-114 — recognise Timer subclasses (e.g. flutter_test's
        // FakeTimer used by `WidgetTester.runAsync`). Mirror of
        // `tom_d4rt`.
        isAssignable: (v) => v is Timer,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 2 || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException('Timer constructor takes 2 arguments.');
            }
            final duration = positionalArgs[0] as Duration;
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer(duration, () async {
              callback.call(visitor, []);
              // Yield so the embedder can pump platform input
              // between interpreted ticks — see
              // _ai/quests/d4rt/interpreter_yielding.md.
              await Future<void>.delayed(Duration.zero);
            });
          },
        },
        staticMethods: {
          'periodic': (visitor, positionalArgs, namedArgs, _) {
            final duration = positionalArgs[0] as Duration;
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer.periodic(duration, (timer) async {
              callback.call(visitor, [timer]);
              // Same yield rationale as the one-shot Timer
              // above. Without this, the synchronous interpreted
              // callback holds the framework thread for every
              // tick and Flutter's platform-message queue (key
              // events, gesture events) backs up until the ticker
              // is cancelled.
              await Future<void>.delayed(Duration.zero);
            });
          },
          'run': (visitor, positionalArgs, namedArgs, _) {
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer.run(() async {
              callback.call(visitor, []);
              await Future<void>.delayed(Duration.zero);
            });
          },
        },
        methods: {
          'cancel': (visitor, target, positionalArgs, namedArgs, _) {
            (target as Timer).cancel();
            return null;
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Timer).toString();
          },
        },
        getters: {
          'isActive': (visitor, target) => (target as Timer).isActive,
          'tick': (visitor, target) => (target as Timer).tick,
          'hashCode': (visitor, target) => (target as Timer).hashCode,
          'runtimeType': (visitor, target) => (target as Timer).runtimeType,
        },
      );
}

class TimerStdlib {
  static void register(Environment environment) {
    environment.defineBridge(TimerAsync.definition);
  }
}
