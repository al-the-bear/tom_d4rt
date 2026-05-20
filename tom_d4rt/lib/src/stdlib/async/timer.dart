import 'dart:async';
import 'package:tom_d4rt/d4rt.dart';

class TimerAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: Timer,
        name: 'Timer',
        nativeNames: ['TimerImpl'],
        // GEN-114 — without an `isAssignable` callback the
        // `Environment.toBridgedInstance` isAssignable-iteration skips
        // this bridge entirely, so subclasses of Timer (notably
        // `FakeTimer` from `package:fake_async` used by `flutter_test`
        // and `WidgetTester.runAsync`) fail every method lookup with
        // "Undefined property or method 'cancel' on FakeTimer".
        isAssignable: (v) => v is Timer,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 2 || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException('Timer constructor takes 2 arguments.');
            }
            final duration = positionalArgs[0] as Duration;
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer(duration, () {
              callback.call(visitor, []);
            });
          },
        },
        staticMethods: {
          'periodic': (visitor, positionalArgs, namedArgs, _) {
            final duration = positionalArgs[0] as Duration;
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer.periodic(duration, (timer) {
              callback.call(visitor, [timer]);
            });
          },
          'run': (visitor, positionalArgs, namedArgs, _) {
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer.run(() {
              callback.call(visitor, []);
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
