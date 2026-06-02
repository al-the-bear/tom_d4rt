// Time formatting helpers.

/// Format a duration in milliseconds as "MM:SS.cc" (centiseconds).
///
/// Examples:
///   0           → "00:00.00"
///   1234        → "00:01.23"
///   65_400      → "01:05.40"
///   3_600_000   → "60:00.00"
String formatElapsed(int ms) {
  final totalCenti = ms ~/ 10;
  final centi = totalCenti % 100;
  final totalSeconds = totalCenti ~/ 100;
  final seconds = totalSeconds % 60;
  final minutes = totalSeconds ~/ 60;
  return '${_pad2(minutes)}:${_pad2(seconds)}.${_pad2(centi)}';
}

/// Format a "split" — the delta between two consecutive laps — with a
/// leading sign so the history reads naturally
/// (`+00:00.45` for a faster lap, etc.).
String formatSplit(int deltaMs) {
  final sign = deltaMs >= 0 ? '+' : '-';
  return '$sign${formatElapsed(deltaMs.abs())}';
}

String _pad2(int n) {
  final s = n.toString();
  return s.length < 2 ? '0$s' : s;
}
