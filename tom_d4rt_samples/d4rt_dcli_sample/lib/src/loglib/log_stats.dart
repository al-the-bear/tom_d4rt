import 'log_entry.dart';

/// Aggregates parsed [LogEntry] records into per-level counts and an error list.
///
/// A script feeds entries in with [add] (or [addAll]) and then reads the
/// derived getters to build a report.
class LogStats {
  LogStats();

  final Map<LogLevel, int> _counts = <LogLevel, int>{
    for (final level in LogLevel.values) level: 0,
  };
  final List<LogEntry> _errors = <LogEntry>[];

  /// Record a single [entry].
  void add(LogEntry entry) {
    _counts[entry.level] = (_counts[entry.level] ?? 0) + 1;
    if (entry.isError) _errors.add(entry);
  }

  /// Record every entry in [entries].
  void addAll(List<LogEntry> entries) {
    for (final entry in entries) {
      add(entry);
    }
  }

  /// How many records were seen at [level].
  int countOf(LogLevel level) => _counts[level] ?? 0;

  /// Total number of recorded records across all levels.
  int get total => _counts.values.fold(0, (sum, n) => sum + n);

  /// The recorded error records, in arrival order.
  List<LogEntry> get errors => List.unmodifiable(_errors);

  /// A multi-line, human-readable summary suitable for writing to a report file.
  String summary() {
    final buffer = StringBuffer();
    buffer.writeln('Log summary — $total record(s)');
    buffer.writeln('-' * 32);
    for (final level in LogLevel.values) {
      buffer.writeln('  ${level.label} ${countOf(level)}');
    }
    if (_errors.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Errors:');
      for (final entry in _errors) {
        buffer.writeln('  line ${entry.lineNumber}: ${entry.message}');
      }
    }
    return buffer.toString();
  }
}
