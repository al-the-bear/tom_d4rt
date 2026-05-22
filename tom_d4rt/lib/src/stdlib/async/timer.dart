import 'dart:async';
import 'package:tom_d4rt/d4rt.dart';

/// Cooperative yield used after every interpreted Timer-bridged
/// callback. See `_ai/quests/d4rt/interpreter_yielding.md` §§5-6.
///
/// `Duration.zero` schedules the await as a tail-of-queue task; on
/// Linux GTK that's apparently NOT enough to let the embedder pump
/// native input between firings (phase 1 in commit `7011045a`
/// shipped exactly that and didn't help). Three changes versus
/// phase 1:
///   1. Non-zero delay (`Duration(milliseconds: 1)`) — gives the
///      embedder a real timeslice, not just a queue-tail slot.
///   2. Multiple awaits chained back-to-back — each one is a
///      separate yield point.
///   3. `Future.delayed(Duration.zero)` between the millisecond
///      delays so we don't add a literal millisecond every tick.
Future<void> _yieldEventLoop() async {
  // First yield: 1 ms real delay — gives the embedder a slice it
  // can actually use to pump native input.
  await Future<void>.delayed(const Duration(milliseconds: 1));
  // Second yield: drain whatever microtasks the framework
  // scheduled while the embedder was pumping.
  await Future<void>.delayed(Duration.zero);
  // Third yield: belt-and-braces — give the platform-message
  // dispatcher one more slot before the next tick logic queues.
  await Future<void>.delayed(Duration.zero);
}

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
            return Timer(duration, () async {
              callback.call(visitor, []);
              await _yieldEventLoop();
            });
          },
        },
        staticMethods: {
          'periodic': (visitor, positionalArgs, namedArgs, _) {
            final duration = positionalArgs[0] as Duration;
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer.periodic(duration, (timer) async {
              callback.call(visitor, [timer]);
              await _yieldEventLoop();
            });
          },
          'run': (visitor, positionalArgs, namedArgs, _) {
            final callback = positionalArgs[1] as InterpretedFunction;
            return Timer.run(() async {
              callback.call(visitor, []);
              await _yieldEventLoop();
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
