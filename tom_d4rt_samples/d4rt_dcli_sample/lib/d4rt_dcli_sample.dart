/// Native log-analysis library for the D4rt dcli sample.
///
/// The bridge generator reads this barrel (via `buildkit.yaml`) and emits
/// `BridgedClass` registrations so D4rt scripts can use `LogParser`,
/// `LogStats`, `LogEntry` and `LogLevel` as native objects.
library;

export 'src/loglib/log_entry.dart';
export 'src/loglib/log_parser.dart';
export 'src/loglib/log_stats.dart';
