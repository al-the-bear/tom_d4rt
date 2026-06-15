// Pure clock model.
//
// The clock advances through a fixed `baseTime` plus a runtime
// duration. The runtime is driven externally — by the
// `AnimationController` in the home widget — so this model is
// stateless w.r.t. wall-clock time and trivially testable.
//
// Hand angles are returned in **radians, clockwise from 12 o'clock**
// (which is `-pi/2` in standard math convention). The painter does
// the rotation; the model only owns the math.
import 'dart:math' as math;

/// Snapshot of the clock at a point in time.
class ClockTime {
  final DateTime instant;
  final int timezoneOffsetMinutes;

  const ClockTime({
    required this.instant,
    required this.timezoneOffsetMinutes,
  });

  /// The instant adjusted for the dial's timezone offset.
  DateTime get withOffset =>
      instant.add(Duration(minutes: timezoneOffsetMinutes));

  /// Seconds component (0..59) — uses fractional sub-second so the
  /// painter can sweep smoothly between integer seconds.
  double get secondsFractional {
    final DateTime t = withOffset;
    final int sec = t.second;
    final int ms = t.millisecond;
    return sec + ms / 1000.0;
  }

  int get hour12 {
    final int h = withOffset.hour % 12;
    return h == 0 ? 12 : h;
  }

  int get minute => withOffset.minute;

  /// Hour hand angle in radians, measured clockwise from 12.
  double get hourAngle {
    final DateTime t = withOffset;
    final double h = (t.hour % 12).toDouble();
    final double m = t.minute.toDouble();
    // 30° per hour + 0.5° per minute = (h + m/60) * (2π/12).
    return (h + m / 60.0) * (math.pi * 2.0 / 12.0);
  }

  /// Minute hand angle in radians, measured clockwise from 12.
  double get minuteAngle {
    final DateTime t = withOffset;
    final double m = t.minute.toDouble();
    final double s = t.second.toDouble();
    return (m + s / 60.0) * (math.pi * 2.0 / 60.0);
  }

  /// Second hand angle in radians, measured clockwise from 12.
  /// Uses fractional seconds for a smooth sweep.
  double get secondAngle => secondsFractional * (math.pi * 2.0 / 60.0);
}

/// Quantise an arbitrary minute count into the dial's step size.
/// The dial advances in 15-minute increments so that "snap" feel is
/// obvious to the user.
int quantizeOffsetMinutes(int raw) {
  const int step = 15;
  final int snapped = ((raw / step).round()) * step;
  // Clamp to [-12h, +14h] — covers every real-world timezone.
  if (snapped < -12 * 60) return -12 * 60;
  if (snapped > 14 * 60) return 14 * 60;
  return snapped;
}

/// Pretty UTC-style label: `UTC`, `UTC+5:30`, `UTC-3:00`.
String formatOffset(int minutes) {
  if (minutes == 0) return 'UTC';
  final String sign = minutes >= 0 ? '+' : '-';
  final int abs = minutes < 0 ? -minutes : minutes;
  final int h = abs ~/ 60;
  final int m = abs % 60;
  final String mm = m < 10 ? '0$m' : '$m';
  return 'UTC$sign$h:$mm';
}
