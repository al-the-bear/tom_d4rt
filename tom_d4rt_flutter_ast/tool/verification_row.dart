/// Prints the resolved-version table rows of a `Verification runs` entry
/// from the `testlog/` folders of the runs it records.
///
///     dart run tool/verification_row.dart <testlog folder> [<testlog folder>]
///
/// SCE199. Each entry of `doc/interpreter_issues.md` § `Verification runs`
/// carries a table of the `tom_d4rt` / `tom_d4rt_ast` / `tom_d4rt_generator`
/// versions each twin and its companion app resolved. Since SCD164 every
/// `metrics.txt` opens with a header holding exactly those facts, measured;
/// the table was still transcribed by a person reading lockfiles. A mistyped
/// minor makes an entry describe a pair nobody measured, and nothing can
/// detect it afterwards — `testlog/` and the locks are gitignored, which is
/// why the document is the durable record. This removes the transcription.
///
/// A folder with no usable header is REPORTED, never turned into an empty
/// row: no `metrics.txt`, no header (a run from before SCD164), or a header
/// saying `attribution: FAILED`. Any of those exits 1. A package resolved by
/// PATH is printed with its source and flagged: that is a pre-publish pass,
/// whose results `Verification runs` must not record.
///
/// After the table it prints one `**Framework errors:**` line per run, read
/// from the trailer every corpus runner appends to `metrics.txt` (SCE247): the
/// framework-error total and the refused-callback count by signature. Those
/// are the numbers a callback-binding fix moves while pass / skip / fail stays
/// put, so an entry records them beside the table. A run whose runner
/// predates the trailer is named instead of printed as zero.
///
/// Deliberately NOT a guard over the document: comparing it against a
/// `testlog/` folder would pass or fail on whether this machine still holds
/// the run.
library;

import 'dart:io';

import '../test/run_attribution.dart';
import 'framework_error_inventory.dart';

/// The columns of the table, in the document's order.
const List<String> verificationColumns = [
  'tom_d4rt',
  'tom_d4rt_ast',
  'tom_d4rt_generator',
];

/// The rows for [runs] — `(folder, metrics.txt lines or null)` — and the
/// problems that kept any folder from yielding rows.
({List<String> rows, List<String> problems, List<String> warnings})
verificationRows(List<(String, List<String>?)> runs) {
  final labelled = <(String, String)>[];
  final problems = <String>[];
  final warnings = <String>[];
  String cell(String row, String column, (String, String)? entry) {
    if (entry == null) return '—';
    final (version, source) = entry;
    if (source == 'hosted') return '**$version**';
    warnings.add(
      '$row resolves $column by $source ($version): a run that does not '
      'resolve the interpreter from pub.dev is a pre-publish pass, and '
      '`Verification runs` must not record it.',
    );
    return '**$version ($source)**';
  }

  String row(String label, Map<String, (String, String)> resolved) =>
      '| `$label` | '
      '${verificationColumns.map((c) => cell(label, c, resolved[c])).join(' | ')} |';

  for (final (folder, lines) in runs) {
    if (lines == null) {
      problems.add('$folder: no metrics.txt — not a runner output folder');
      continue;
    }
    final attribution = parseRunAttribution(lines);
    if (attribution == null) {
      problems.add(
        '$folder: metrics.txt has no attribution header — the run predates '
        'SCD164, so its versions were never recorded and cannot be derived',
      );
      continue;
    }
    if (attribution.failure != null) {
      problems.add(
        '$folder: attribution FAILED — ${attribution.failure}. Read the locks '
        'by hand, and say in the entry that you did',
      );
      continue;
    }
    final package = attribution.package;
    if (package == null) {
      problems.add('$folder: the header names no package');
      continue;
    }
    labelled.add((package, row(package, attribution.resolved)));
    if (attribution.app != null) {
      final label = '$package/${attribution.app}';
      labelled.add((label, row(label, attribution.appResolved)));
    }
  }
  // Sorted by LABEL, which is the document's order: a twin before its own app
  // path (a prefix sorts first), and `tom_d4rt_flutter/…` before
  // `tom_d4rt_flutter_ast` (`/` < `_`). Sorting the rendered rows would not do:
  // the closing backtick after a bare twin name sorts after `/`.
  labelled.sort((a, b) => a.$1.compareTo(b.$1));
  final rows = [for (final (_, r) in labelled) r];
  return (rows: rows, problems: problems, warnings: warnings);
}

/// The `**Framework errors:**` line for each of [runs], labelled by the
/// package its header names (or the folder when it names none).
List<String> frameworkErrorLines(List<(String, List<String>?)> runs) => [
  for (final (folder, lines) in runs)
    if (lines != null) _frameworkErrorLine(folder, lines),
];

String _frameworkErrorLine(String folder, List<String> lines) {
  final label = parseRunAttribution(lines)?.package ?? folder;
  final summary = parseRunSummary(lines);
  if (summary == null) {
    return '- `$label`: NO TRAILER — the runner predates SCE247; count with '
        '`dart run tool/framework_error_inventory.dart $folder --summary`';
  }
  final signatures = summary.bySignature.entries
      .map((e) => '${e.value} × `${e.key}`')
      .join('; ');
  return '- `$label`: ${summary.frameworkErrors} framework error(s) in '
      '${summary.scripts} of ${summary.measured} script(s); '
      '${summary.rejections} refused callback(s)'
      '${signatures.isEmpty ? '' : ' — $signatures'}';
}

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln(
      'usage: dart run tool/verification_row.dart <testlog folder> [...]',
    );
    exitCode = 64;
    return;
  }
  final runs = <(String, List<String>?)>[
    for (final folder in args)
      (
        folder,
        File('$folder/metrics.txt').existsSync()
            ? File('$folder/metrics.txt').readAsLinesSync()
            : null,
      ),
  ];
  final result = verificationRows(runs);
  if (result.rows.isNotEmpty) {
    stdout.writeln(
      '| Package | ${verificationColumns.map((c) => '`$c`').join(' | ')} |',
    );
    stdout.writeln(
      '| ------- | ${verificationColumns.map((c) => '-' * (c.length + 2)).join(' | ')} |',
    );
    result.rows.forEach(stdout.writeln);
    stdout
      ..writeln()
      ..writeln('**Framework errors** (SCE247 trailer):')
      ..writeln();
    frameworkErrorLines(runs).forEach(stdout.writeln);
  }
  for (final w in result.warnings) {
    stderr.writeln('WARNING: $w');
  }
  for (final p in result.problems) {
    stderr.writeln('NO ROWS: $p');
  }
  if (result.problems.isNotEmpty) exitCode = 1;
}
