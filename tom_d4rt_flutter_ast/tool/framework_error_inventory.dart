// Per-script framework-error inventory for a corpus run folder.
//
//     dart run tool/framework_error_inventory.dart testlog/<run>
//     dart run tool/framework_error_inventory.dart testlog/<run> --order run
//     dart run tool/framework_error_inventory.dart testlog/<run> --summary
//
// `--summary` prints the machine-readable trailer every corpus runner appends
// to its `metrics.txt` (SCE247), described at [renderSummary].
//
// From the source twin, by path (the tool needs nothing but dart:io, so it
// runs from either package and on every fleet host, Windows included):
//
//     dart run ../tom_d4rt_flutter_ast/tool/framework_error_inventory.dart testlog/<run>
//
// WHY IT EXISTS. The cluster-entry template in doc/interpreter_issues.md asks
// for one discriminator before a shared cause is claimed: count the error
// occurrences per script; a leak ACCUMULATES along the run, independent
// defects do not. SCC48 was decided by exactly that — twelve counts, 11, 78,
// 23, 8, 2, 2, 3, 11, 9, 6, 1, 6, non-monotonic in run order, which killed the
// accumulation hypothesis before any code was read. Taking it meant
// hand-grepping a run folder, and a check that takes ten careful minutes is a
// check that gets skipped.
//
// WHAT IT READS, and why not metrics.txt. metrics.txt carries only the
// per-file `exit=` / `+N ~M -K` line. The per-script counts live in each
// `*.log.txt`: the harness prints a `[METRIC] script=... testFile=...
// frameworkErrors=N` line per script, and, when N > 0, a block
//
//       ⚠️  FRAMEWORK ERROR in <script> (N error(s)):
//              <first line of each error, truncated at 200 characters>
//
// The METRIC count is authoritative. The block supplies the texts, and its
// "(N error(s))" is cross-checked against it; a disagreement is reported.
// Only an error's first line is its signature: a message containing newlines
// continues on UNINDENTED lines, so where one error ends cannot be told.
//
// A folder with no *.log.txt is an error, not an empty inventory — reading the
// wrong file and printing nothing is the failure this tool exists to prevent.
library;

import 'dart:io';

/// One script's measurement from a `[METRIC]` line, plus its block's texts.
class ScriptErrors {
  ScriptErrors({
    required this.script,
    required this.testFile,
    required this.count,
    required this.position,
  });

  final String script;
  final String testFile;

  /// `frameworkErrors=` on the script's `[METRIC]` line.
  final int count;

  /// Order of the script within the whole run, 0-based, across log files
  /// read in name order — the order the runners execute them.
  final int position;

  /// The first line of each error from the script's FRAMEWORK ERROR block.
  final List<String> texts = [];

  /// The count the block itself declared, when a block was seen.
  int? blockCount;
}

/// Everything read from one run folder.
class Inventory {
  Inventory(this.logFiles, this.scripts);

  final List<String> logFiles;

  /// Every script with a `[METRIC]` line, in run order.
  final List<ScriptErrors> scripts;

  Iterable<ScriptErrors> get raising => scripts.where((s) => s.count > 0);

  int get total => raising.fold(0, (sum, s) => sum + s.count);

  /// Scripts whose block declared a different count from their METRIC line.
  Iterable<ScriptErrors> get disagreeing =>
      raising.where((s) => s.blockCount != null && s.blockCount != s.count);
}

final _metric = RegExp(
  r'\[METRIC\] script=(\S+) testFile=(\S+).*?\bframeworkErrors=(\d+)',
);
final _block = RegExp(r'FRAMEWORK ERROR in (\S+) \((\d+) error\(s\)\):');
final _errorLine = RegExp(r'^ {7}(\S.*)$');

/// Parse the text of the `*.log.txt` files in [logs] (name -> content), which
/// must be given in run order.
Inventory parseLogs(Map<String, String> logs) {
  final scripts = <ScriptErrors>[];
  for (final content in logs.values) {
    ScriptErrors? open;
    for (final raw in content.split('\n')) {
      final line = raw.endsWith('\r') ? raw.substring(0, raw.length - 1) : raw;
      final metric = _metric.firstMatch(line);
      if (metric != null) {
        scripts.add(
          ScriptErrors(
            script: metric.group(1)!,
            testFile: metric.group(2)!,
            count: int.parse(metric.group(3)!),
            position: scripts.length,
          ),
        );
        open = null;
        continue;
      }
      final block = _block.firstMatch(line);
      if (block != null) {
        // The block follows its script's METRIC line; attach it to the last
        // script with that name.
        open = scripts.lastWhere(
          (s) => s.script == block.group(1),
          orElse: () => ScriptErrors(
            script: block.group(1)!,
            testFile: '?',
            count: 0,
            position: -1,
          ),
        )..blockCount = int.parse(block.group(2)!);
        continue;
      }
      if (open != null) {
        final text = _errorLine.firstMatch(line);
        if (text != null) {
          open.texts.add(text.group(1)!);
        } else if (line.trim().isNotEmpty) {
          open = null;
        }
      }
    }
  }
  return Inventory(logs.keys.toList(), scripts);
}

/// An error text with every number replaced by `#`, so messages that differ
/// only in a measurement group together. Decimals count as one number:
/// "overflowed by 12.5 pixels" and "overflowed by 3 pixels" are one signature.
String signatureOf(String text) =>
    text.replaceAll(RegExp(r'\d+(?:\.\d+)?'), '#');

/// The printed report.
String render(Inventory inv, {required String folder, bool runOrder = false}) {
  final out = StringBuffer()
    ..writeln('framework-error inventory: $folder')
    ..writeln(
      '  ${inv.logFiles.length} log file(s), ${inv.scripts.length} script(s) '
      'measured, ${inv.raising.length} raised any',
    );
  final raising = inv.raising.toList();
  if (raising.isEmpty) {
    out.writeln('  no framework errors in this run');
    return out.toString();
  }
  if (!runOrder) {
    raising.sort((a, b) {
      final byCount = b.count.compareTo(a.count);
      return byCount != 0 ? byCount : a.position.compareTo(b.position);
    });
  }
  final width = inv.scripts.length.toString().length;
  out
    ..writeln()
    ..writeln(
      runOrder
          ? '  by script, in run order (#position  count  script  testFile):'
          : '  by script, most first (count  script  testFile):',
    );
  for (final s in raising) {
    final pos = runOrder ? '#${s.position.toString().padLeft(width)}  ' : '';
    out.writeln(
      '  $pos${s.count.toString().padLeft(5)}  ${s.script}  ${s.testFile}',
    );
  }

  final bySignature = <String, List<ScriptErrors>>{};
  for (final s in raising) {
    for (final text in s.texts.toSet()) {
      (bySignature[signatureOf(text)] ??= []).add(s);
    }
  }
  final occurrences = <String, int>{};
  for (final s in raising) {
    for (final text in s.texts) {
      final sig = signatureOf(text);
      occurrences[sig] = (occurrences[sig] ?? 0) + 1;
    }
  }
  final signatures = bySignature.keys.toList()
    ..sort((a, b) {
      final byScripts = bySignature[b]!.length.compareTo(
        bySignature[a]!.length,
      );
      return byScripts != 0 ? byScripts : a.compareTo(b);
    });
  out
    ..writeln()
    ..writeln(
      '  by signature, numbers as # (scripts  occurrences  signature):',
    );
  for (final sig in signatures) {
    out.writeln(
      '  ${bySignature[sig]!.length.toString().padLeft(5)}  '
      '${occurrences[sig].toString().padLeft(5)}  $sig',
    );
  }

  out
    ..writeln()
    ..writeln(
      '  total: ${inv.total} error(s) in ${raising.length} script(s), '
      '${signatures.length} distinct signature(s)',
    );
  final disagreeing = inv.disagreeing.toList();
  if (disagreeing.isNotEmpty) {
    out.writeln(
      '  WARNING: ${disagreeing.length} script(s) whose FRAMEWORK ERROR block '
      'declares a different count from its [METRIC] line:',
    );
    for (final s in disagreeing) {
      out.writeln('    ${s.script}: metric=${s.count} block=${s.blockCount}');
    }
  }
  return out.toString();
}

/// The rejection family: a value refused at an argument or parameter
/// binding, `type 'X' is not a subtype of type 'Y' of 'p'`. A script callback
/// the interpreter could not hand to a typed Flutter parameter (GEN-125) is
/// reported this way, and it does not fail the script — the widget still
/// builds, so the script reports success and the file's pass count cannot
/// move. The trailing `of 'p'` is what separates a binding refusal from any
/// other failed cast.
final RegExp rejectionPattern = RegExp(
  r"is not a subtype of type '[^']+' of '[^']+'",
);

/// Prefix of every line [renderSummary] writes. The attribution header at the
/// top of `metrics.txt` is `# `-prefixed and read with `takeWhile`, so a
/// trailer with its own prefix cannot be mistaken for it.
const String summaryPrefix = '## ';

/// The `metrics.txt` trailer (SCE247): the run's own framework-error total and
/// the rejection family broken down by signature, most first.
///
///     ## framework-errors: total=117 scripts=47 measured=910
///     ## rejections: total=117 signatures=6
///     ## rejection: 64  type 'dynamic Function(dynamic)' is not a subtype of type 'ValueChanged' of 'onChanged'
///
/// The base gate's pass / skip / fail cannot see a refused callback, because
/// the script still succeeds; these lines are the number that does move. A
/// run with none still writes the first two lines, so an absent trailer means
/// a runner that predates it rather than a clean run.
String renderSummary(Inventory inv) {
  final raising = inv.raising.toList();
  final occurrences = <String, int>{};
  for (final s in raising) {
    for (final text in s.texts) {
      if (!rejectionPattern.hasMatch(text)) continue;
      final sig = signatureOf(text);
      occurrences[sig] = (occurrences[sig] ?? 0) + 1;
    }
  }
  final signatures = occurrences.keys.toList()
    ..sort((a, b) {
      final byCount = occurrences[b]!.compareTo(occurrences[a]!);
      return byCount != 0 ? byCount : a.compareTo(b);
    });
  final rejections = occurrences.values.fold(0, (sum, n) => sum + n);
  final out = StringBuffer()
    ..writeln(
      '${summaryPrefix}framework-errors: total=${inv.total} '
      'scripts=${raising.length} measured=${inv.scripts.length}',
    )
    ..writeln(
      '${summaryPrefix}rejections: total=$rejections '
      'signatures=${signatures.length}',
    );
  for (final sig in signatures) {
    out.writeln('${summaryPrefix}rejection: ${occurrences[sig]}  $sig');
  }
  return out.toString();
}

/// What a `metrics.txt` trailer says, or null when it has none.
typedef RunSummary = ({
  int frameworkErrors,
  int scripts,
  int measured,
  int rejections,
  Map<String, int> bySignature,
});

/// Reads the trailer [renderSummary] wrote from [metricsLines].
RunSummary? parseRunSummary(List<String> metricsLines) {
  final fe = RegExp(
    r'^## framework-errors: total=(\d+) scripts=(\d+) measured=(\d+)$',
  );
  final rj = RegExp(r'^## rejections: total=(\d+) signatures=\d+$');
  final one = RegExp(r'^## rejection: (\d+)  (.*)$');
  RegExpMatch? feMatch;
  RegExpMatch? rjMatch;
  final bySignature = <String, int>{};
  for (final line in metricsLines) {
    feMatch ??= fe.firstMatch(line);
    rjMatch ??= rj.firstMatch(line);
    final m = one.firstMatch(line);
    if (m != null) bySignature[m.group(2)!] = int.parse(m.group(1)!);
  }
  if (feMatch == null || rjMatch == null) return null;
  return (
    frameworkErrors: int.parse(feMatch.group(1)!),
    scripts: int.parse(feMatch.group(2)!),
    measured: int.parse(feMatch.group(3)!),
    rejections: int.parse(rjMatch.group(1)!),
    bySignature: bySignature,
  );
}

void main(List<String> args) {
  final summary = args.contains('--summary');
  final runOrder =
      args.contains('--order') &&
      args.indexOf('--order') + 1 < args.length &&
      args[args.indexOf('--order') + 1] == 'run';
  final positional = [
    for (var i = 0; i < args.length; i++)
      if (args[i] == '--order' || args[i] == '--summary')
        null
      else if (i > 0 && args[i - 1] == '--order')
        null
      else
        args[i],
  ].whereType<String>().toList();
  if (positional.length != 1 ||
      args.contains('-h') ||
      args.contains('--help')) {
    stderr.writeln(
      'usage: dart run tool/framework_error_inventory.dart <run folder> '
      '[--order run | --summary]',
    );
    exitCode = 64;
    return;
  }
  final folder = Directory(positional.single);
  if (!folder.existsSync()) {
    stderr.writeln('no such folder: ${folder.path}');
    exitCode = 66;
    return;
  }
  final logs =
      folder
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.log.txt'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  if (logs.isEmpty) {
    stderr.writeln(
      'no *.log.txt in ${folder.path}. The per-script counts live in the log '
      'files, not in metrics.txt; point this at a run folder under testlog/.',
    );
    exitCode = 66;
    return;
  }
  final inventory = parseLogs({
    for (final f in logs) f.uri.pathSegments.last: f.readAsStringSync(),
  });
  if (inventory.scripts.isEmpty) {
    stderr.writeln(
      'read ${logs.length} log file(s) and found no [METRIC] line. Either the '
      'run failed before any script executed, or the harness changed its '
      'output format — nothing was measured.',
    );
    exitCode = 65;
    return;
  }
  stdout.write(
    summary
        ? renderSummary(inventory)
        : render(inventory, folder: folder.path, runOrder: runOrder),
  );
}
