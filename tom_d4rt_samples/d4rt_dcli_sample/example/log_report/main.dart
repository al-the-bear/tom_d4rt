// log_report — the focus example.
//
// A D4rt script that mixes two bridge sources in one program:
//   * dcli (file I/O)            — `'sample.log'.toList()`, `'report.txt'.write()`
//   * this project's native lib  — LogParser, LogStats, LogEntry, LogLevel
//
// dcli's functions run as compiled native code, so the script reads and writes
// real files even though it executes inside the sandboxed interpreter. The
// runner switches the working directory to this folder before running, so the
// relative paths below resolve to the files next to this script.

import 'package:dcli/dcli.dart';
import 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart';

void main(List<String> args) {
  const logPath = 'sample.log';
  const reportPath = 'report.txt';

  if (!exists(logPath)) {
    print('No $logPath found in the current directory.');
    return;
  }

  // dcli: read the file as a list of lines. `read(path)` returns a Progress;
  // `.toList()` drains it. (Note: `'cmd'.toList()` would instead RUN the string
  // as a process — the dcli String extensions overload on intent.)
  final lines = read(logPath).toList();
  print('Read ${lines.length} line(s) from $logPath\n');

  // Native library: parse and aggregate.
  final parser = LogParser();
  final stats = LogStats();
  final entries = parser.parseAll(lines);
  stats.addAll(entries);

  // Show the parsed records.
  for (final entry in entries) {
    print('  $entry');
  }

  final report = stats.summary();
  print('\n$report');

  // dcli: write the report next to the log file.
  reportPath.write(report);
  print('Report written to $reportPath '
      '(${stats.countOf(LogLevel.error)} error(s) of ${stats.total} records)');
}
