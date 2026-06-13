#!/usr/bin/env dcli
/// log_pipeline — extended multi-file DCli sample.
///
/// A file-processing pipeline: it synthesises a few sample `.log` files in a
/// temp directory, then runs a parse → filter → aggregate pipeline over them
/// and emits both a console summary and a written report file. The CLI analog
/// of the Flutter "extended sample" apps, focused on the DCli filesystem
/// bridges and a staged, multi-file data-flow design.
///
/// Files:
///   * `main.dart`   — fixture generation + pipeline wiring (this file)
///   * `models.dart` — the `LogEntry` value type + line parser
///   * `stages.dart` — `ParseStage`, `FilterStage`, `AggregateStage`
///   * `report.dart` — the `Report` value type + renderers
///
/// Run it:
///   dcli example/log_pipeline/main.dart                # all levels
///   dcli example/log_pipeline/main.dart ERROR WARN     # only these levels
///   dart run example/log_pipeline/main.dart INFO
library;

import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

import 'stages.dart';

void main(List<String> args) {
  // Remaining args are the levels to keep; empty means "keep all".
  final levels = args.map((a) => a.toUpperCase()).toList();

  print(blue('tom_d4rt_dcli log-pipeline', bold: true));
  print(grey(
    levels.isEmpty ? 'levels: all' : 'levels: ${levels.join(', ')}',
    level: 0.6,
  ));

  final workDir = createTempDir();
  try {
    _writeSampleLogs(workDir);

    // Stage the data flow: parse → filter → aggregate.
    final parsed = ParseStage().run(workDir);
    print(grey('parsed ${parsed.length} entries', level: 0.6));

    final filtered = FilterStage(levels).run(parsed);
    final report = AggregateStage().run(filtered);

    print('');
    report.printColoured();

    // Persist the report next to the logs and echo it back via `cat`.
    final reportPath = p.join(workDir, 'report.txt');
    reportPath.write(report.toPlainText());
    print('');
    print(grey('report written to $reportPath:', level: 0.6));
    cat(reportPath);
  } finally {
    if (exists(workDir)) deleteDir(workDir, recursive: true);
  }
}

/// Writes a couple of small `.log` files (plus one line of deliberately
/// malformed input) so the pipeline has realistic, multi-file input.
void _writeSampleLogs(String dir) {
  final app = p.join(dir, 'app.log');
  app.write([
    '2026-06-13T10:00:00 INFO service started',
    '2026-06-13T10:00:01 INFO handling request /home',
    '2026-06-13T10:00:02 WARN slow query (820ms)',
    '2026-06-13T10:00:03 ERROR upstream timeout',
    'this line is malformed and should be skipped',
    '2026-06-13T10:00:05 INFO request complete',
  ].join('\n'));

  final worker = p.join(dir, 'worker.log');
  worker.write([
    '2026-06-13T10:00:00 DEBUG queue drained',
    '2026-06-13T10:00:04 WARN retry 1/3',
    '2026-06-13T10:00:06 ERROR job 42 failed',
    '2026-06-13T10:00:07 INFO job 43 done',
  ].join('\n'));
}
