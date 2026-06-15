import 'log_entry.dart';

/// Parses raw log lines into [LogEntry] objects.
///
/// Accepts the common `[LEVEL] message` and `LEVEL: message` shapes. Lines that
/// do not start with a recognised level marker are treated as continuations or
/// noise and skipped (the parser returns `null`).
class LogParser {
  LogParser();

  /// Matches a leading `[LEVEL]` or `LEVEL:` marker, capturing the level word
  /// and the remaining message.
  static final RegExp _marker =
      RegExp(r'^\s*(?:\[(\w+)\]|(\w+):)\s*(.*)$');

  /// Parse a single [line]. [lineNumber] is recorded on the entry for reporting.
  ///
  /// Returns `null` when the line carries no recognised level marker.
  LogEntry? parse(String line, int lineNumber) {
    final match = _marker.firstMatch(line);
    if (match == null) return null;

    final word = match.group(1) ?? match.group(2)!;
    final level = LogLevel.fromName(word);
    if (level == null) return null;

    return LogEntry(lineNumber, level, match.group(3)!.trim());
  }

  /// Parse a whole file's worth of [lines], skipping unrecognised ones.
  ///
  /// 1-based line numbers are assigned in order.
  List<LogEntry> parseAll(List<String> lines) {
    final entries = <LogEntry>[];
    for (var i = 0; i < lines.length; i++) {
      final entry = parse(lines[i], i + 1);
      if (entry != null) entries.add(entry);
    }
    return entries;
  }
}
