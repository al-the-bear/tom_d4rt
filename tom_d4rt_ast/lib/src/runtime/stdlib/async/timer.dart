import 'dart:async';
import 'package:tom_d4rt_ast/runtime.dart';

/// Cooperative yield used after every interpreted Timer-bridged
/// callback. Mirror of `tom_d4rt`'s helper — see
/// `_ai/quests/d4rt/interpreter_yielding.md` §6.1 for the rationale.
///
/// Phase 1 (`await Future.delayed(Duration.zero)`) shipped in
/// `7011045a` and didn't help. This phase tries:
///   1. A non-zero (1 ms) delay so the embedder gets a real
///      timeslice rather than a queue-tail slot.
///   2. Multiple chained yields so the platform-message dispatcher
///      has several slots to drain into.
Future<void> _yieldEventLoop() async {
  await Future<void>.delayed(const Duration(milliseconds: 1));
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

/// SCD73 — a timer body is the one interpreted callback whose future *nobody
/// can await*, so this is where the interpreter's wrapper has to come off.
///
/// The zone d4rt forks sheds the wrapper for every escape that leaves through a
/// callback the platform invokes, which is most of them. A timer is the
/// exception, and for a reason that is d4rt's own doing rather than the SDK's:
/// the adapters below are `async` so they can yield the event loop afterwards,
/// so a synchronous throw out of `callback.call` does not escape the registered
/// callback at all — it completes the adapter's own future, which nothing holds.
/// `Zone.errorCallback` was measured and is not consulted for an `async`
/// function body's completion, so there is no zone seam to use here.
///
/// Unwrapping at this one boundary is unambiguous in a way a general per-adapter
/// guard is not: nothing downstream of a timer body can be an interpreted
/// `catch`, so the value is leaving the interpreter for good.
Never _rethrowUnwrapped(Object error, StackTrace stackTrace) =>
    Error.throwWithStackTrace(unwrapScriptError(error), stackTrace);

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
        final callback = positionalArgs[1] as Callable;
        return Timer(duration, () async {
          try {
            callback.call(visitor, []);
          } catch (error, stackTrace) {
            _rethrowUnwrapped(error, stackTrace);
          }
          await _yieldEventLoop();
        });
      },
    },
    staticMethods: {
      'periodic': (visitor, positionalArgs, namedArgs, _) {
        final duration = positionalArgs[0] as Duration;
        final callback = positionalArgs[1] as Callable;
        return Timer.periodic(duration, (timer) async {
          try {
            callback.call(visitor, [timer]);
          } catch (error, stackTrace) {
            _rethrowUnwrapped(error, stackTrace);
          }
          await _yieldEventLoop();
        });
      },
      'run': (visitor, positionalArgs, namedArgs, _) {
        // Timer.run(void Function() callback) — single positional
        // arg. Previous code indexed positionalArgs[1], which
        // RangeError'd ("Only valid value is 0: 1") on every call.
        if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            'Timer.run expects exactly one callback argument.',
          );
        }
        final callback = positionalArgs[0] as Callable;
        return Timer.run(() async {
          try {
            callback.call(visitor, []);
          } catch (error, stackTrace) {
            _rethrowUnwrapped(error, stackTrace);
          }
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
