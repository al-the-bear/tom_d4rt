// The domain model for the log-analysis library.
//
// These are ordinary native Dart types. The bridge generator turns them into
// `BridgedClass` registrations so D4rt scripts can construct and inspect them
// exactly as if they were written in the script itself.

/// Severity of a parsed log line.
enum LogLevel {
  debug,
  info,
  warning,
  error;

  /// Parse a textual level (case-insensitive) into a [LogLevel].
  ///
  /// Returns `null` when the text does not name a known level — the parser
  /// uses this to skip lines that are not real log records.
  static LogLevel? fromName(String name) {
    final lower = name.toLowerCase();
    for (final level in LogLevel.values) {
      if (level.name == lower) return level;
    }
    return null;
  }

  /// A fixed-width label, handy for aligned report output.
  String get label => name.toUpperCase().padRight(7);
}

/// A single parsed log record.
class LogEntry {
  LogEntry(this.lineNumber, this.level, this.message);

  /// 1-based line number in the source file.
  final int lineNumber;

  /// Parsed severity.
  final LogLevel level;

  /// The free-text message after the level marker.
  final String message;

  /// True for [LogLevel.error] records — convenience for scripts.
  bool get isError => level == LogLevel.error;

  @override
  String toString() => '#$lineNumber ${level.label} $message';
}
