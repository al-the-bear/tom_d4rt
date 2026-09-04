import 'package:tom_d4rt_ast/runtime.dart';

class DurationCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Duration,
    name: 'Duration',
    isAssignable: (v) => v is Duration,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return Duration(
          days: namedArgs['days'] as int? ?? 0,
          hours: namedArgs['hours'] as int? ?? 0,
          minutes: namedArgs['minutes'] as int? ?? 0,
          seconds: namedArgs['seconds'] as int? ?? 0,
          milliseconds: namedArgs['milliseconds'] as int? ?? 0,
          microseconds: namedArgs['microseconds'] as int? ?? 0,
        );
      },
    },
    // All sixteen unit constants, not a subset. Six were registered and ten
    // were not, which made the class look covered to any check that landed
    // on a working one — `Duration.secondsPerMinute` resolved while
    // `Duration.microsecondsPerDay` did not.
    staticGetters: {
      'microsecondsPerMillisecond': (visitor) {
        return Duration.microsecondsPerMillisecond;
      },
      'microsecondsPerSecond': (visitor) {
        return Duration.microsecondsPerSecond;
      },
      'microsecondsPerMinute': (visitor) {
        return Duration.microsecondsPerMinute;
      },
      'microsecondsPerHour': (visitor) {
        return Duration.microsecondsPerHour;
      },
      'microsecondsPerDay': (visitor) {
        return Duration.microsecondsPerDay;
      },
      'millisecondsPerSecond': (visitor) {
        return Duration.millisecondsPerSecond;
      },
      'millisecondsPerMinute': (visitor) {
        return Duration.millisecondsPerMinute;
      },
      'millisecondsPerHour': (visitor) {
        return Duration.millisecondsPerHour;
      },
      'millisecondsPerDay': (visitor) {
        return Duration.millisecondsPerDay;
      },
      'secondsPerMinute': (visitor) {
        return Duration.secondsPerMinute;
      },
      'secondsPerHour': (visitor) {
        return Duration.secondsPerHour;
      },
      'secondsPerDay': (visitor) {
        return Duration.secondsPerDay;
      },
      'minutesPerHour': (visitor) {
        return Duration.minutesPerHour;
      },
      'minutesPerDay': (visitor) {
        return Duration.minutesPerDay;
      },
      'hoursPerDay': (visitor) {
        return Duration.hoursPerDay;
      },
      'zero': (visitor) {
        return Duration.zero;
      },
    },
    methods: {
      '+': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration) + (positionalArgs[0] as Duration);
      },
      '-': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration) - (positionalArgs[0] as Duration);
      },
      '*': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration) * (positionalArgs[0] as num);
      },
      '~/': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration) ~/ (positionalArgs[0] as int);
      },
      'unary-': (visitor, target, positionalArgs, namedArgs, _) {
        return -(target as Duration);
      },
      'abs': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration).abs();
      },
      'compareTo': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration).compareTo(positionalArgs[0] as Duration);
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Duration).toString();
      },
    },
    getters: {
      'inDays': (visitor, target) => (target as Duration).inDays,
      'inHours': (visitor, target) => (target as Duration).inHours,
      'inMinutes': (visitor, target) => (target as Duration).inMinutes,
      'inSeconds': (visitor, target) => (target as Duration).inSeconds,
      'inMilliseconds': (visitor, target) =>
          (target as Duration).inMilliseconds,
      'inMicroseconds': (visitor, target) =>
          (target as Duration).inMicroseconds,
      'isNegative': (visitor, target) => (target as Duration).isNegative,
      'hashCode': (visitor, target) => (target as Duration).hashCode,
      'runtimeType': (visitor, target) => (target as Duration).runtimeType,
    },
  );
}
