/// Log-pipeline data model.
///
/// A single immutable [LogEntry] value plus its line parser. Kept in its own
/// file to demonstrate cross-file value types in a multi-file D4rt CLI
/// script.
library;

/// One parsed log line: `2026-06-13T10:00:00 LEVEL message...`.
class LogEntry {
  const LogEntry({
    required this.timestamp,
    required this.level,
    required this.message,
  });

  final DateTime timestamp;
  final String level;
  final String message;

  /// Parses a single raw line. Returns `null` for blank lines or lines that
  /// do not match the expected `<iso-timestamp> <LEVEL> <message>` shape, so
  /// the caller can simply skip malformed input.
  static LogEntry? tryParse(String line) {
    final trimmed = line.trim();
    if (trimmed.isEmpty) return null;

    final firstSpace = trimmed.indexOf(' ');
    if (firstSpace < 0) return null;
    final secondSpace = trimmed.indexOf(' ', firstSpace + 1);
    if (secondSpace < 0) return null;

    final ts = DateTime.tryParse(trimmed.substring(0, firstSpace));
    if (ts == null) return null;

    final level = trimmed.substring(firstSpace + 1, secondSpace).toUpperCase();
    final message = trimmed.substring(secondSpace + 1);
    return LogEntry(timestamp: ts, level: level, message: message);
  }

  @override
  String toString() =>
      '${timestamp.toIso8601String()} $level $message';
}
