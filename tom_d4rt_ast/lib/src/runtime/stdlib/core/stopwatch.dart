import 'package:tom_d4rt_ast/runtime.dart';

/// SC1: `dart:core` [Stopwatch].
///
/// Pure timing primitive — it reads a monotonic clock and performs no I/O, so
/// it needs no permission gate (unlike the `dart:io` bridges). Every member is
/// a thin forward to the native object; the interpreter holds the real
/// [Stopwatch], so start/stop/reset semantics are the SDK's own.
class StopwatchCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Stopwatch,
    name: 'Stopwatch',
    isAssignable: (v) => v is Stopwatch,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return Stopwatch();
      },
    },
    methods: {
      'start': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Stopwatch).start();
        return null;
      },
      'stop': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Stopwatch).stop();
        return null;
      },
      'reset': (visitor, target, positionalArgs, namedArgs, _) {
        (target as Stopwatch).reset();
        return null;
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Stopwatch).toString();
      },
    },
    getters: {
      'elapsed': (visitor, target) => (target as Stopwatch).elapsed,
      'elapsedTicks': (visitor, target) => (target as Stopwatch).elapsedTicks,
      'elapsedMilliseconds': (visitor, target) =>
          (target as Stopwatch).elapsedMilliseconds,
      'elapsedMicroseconds': (visitor, target) =>
          (target as Stopwatch).elapsedMicroseconds,
      'frequency': (visitor, target) => (target as Stopwatch).frequency,
      'isRunning': (visitor, target) => (target as Stopwatch).isRunning,
      'hashCode': (visitor, target) => (target as Stopwatch).hashCode,
      'runtimeType': (visitor, target) => (target as Stopwatch).runtimeType,
    },
  );
}
