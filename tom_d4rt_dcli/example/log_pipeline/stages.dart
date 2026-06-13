/// Log-pipeline stages.
///
/// Three composable stages — parse → filter → aggregate — each a small
/// single-responsibility class. Demonstrates a staged data-flow design split
/// across files, with the DCli filesystem bridges used to read inputs.
library;

import 'package:dcli/dcli.dart';

import 'models.dart';
import 'report.dart';

/// Reads every `*.log` file under [logDir] and parses each line into a
/// [LogEntry], skipping malformed lines. Uses the DCli `find` + `read`
/// bridges.
class ParseStage {
  List<LogEntry> run(String logDir) {
    final entries = <LogEntry>[];
    for (final file in find('*.log', workingDirectory: logDir).toList()) {
      for (final line in read(file).toList()) {
        final entry = LogEntry.tryParse(line);
        if (entry != null) entries.add(entry);
      }
    }
    return entries;
  }
}

/// Keeps only entries whose level is in [keep]. An empty set keeps all.
class FilterStage {
  FilterStage(Iterable<String> keep)
      : keep = keep.map((l) => l.toUpperCase()).toSet();

  final Set<String> keep;

  List<LogEntry> run(List<LogEntry> entries) {
    if (keep.isEmpty) return entries;
    return entries.where((e) => keep.contains(e.level)).toList();
  }
}

/// Folds the filtered entries into a [Report]: counts per level and the
/// earliest/latest timestamps seen.
class AggregateStage {
  Report run(List<LogEntry> entries) {
    final counts = <String, int>{};
    DateTime? first;
    DateTime? last;
    for (final e in entries) {
      counts[e.level] = (counts[e.level] ?? 0) + 1;
      if (first == null || e.timestamp.isBefore(first)) first = e.timestamp;
      if (last == null || e.timestamp.isAfter(last)) last = e.timestamp;
    }
    return Report(
      total: entries.length,
      countsByLevel: counts,
      firstSeen: first,
      lastSeen: last,
    );
  }
}
