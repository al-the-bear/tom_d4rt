/// The one definition of what counts as a bad emission.
///
/// Both `d4rtgen --verify-output` and the GEN-121 test gate answer the same
/// question — does the code the generator just wrote survive `dart analyze`? —
/// so they answer it with the same code. Two copies of a severity policy drift,
/// and the entire value of the gate is that the tool and the test agree on what
/// "broken output" means.
///
/// Why this is needed at all: consumers exclude their generated bridge
/// directory in `analysis_options.yaml` (`lib/src/d4rt_bridges/**` is the usual
/// spelling), so `dart analyze` reports the project clean while the generated
/// file imports a URI that resolves nowhere. GEN-119 and GEN-120 both shipped
/// that way and were found by hand afterwards.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// Diagnostic severities that do not count as a bad emission.
///
/// `INFO` covers lints, which depend on the ambient SDK's default rule set and
/// on the consumer's `analysis_options.yaml`. Gating on them would fail a
/// generation because the SDK moved or because the consumer enabled a lint,
/// neither of which is a generator defect.
const nonFatalSeverities = {'INFO'};

/// Analyzer warning codes that are known, reviewed, and accepted.
///
/// Spelled as `dart analyze --format=machine` spells them — `UPPER_SNAKE_CASE`,
/// e.g. `UNUSED_IMPORT`, not the `unused_import` of the human-readable format.
/// Matched case-insensitively so an entry written the other way still works.
///
/// Deliberately empty. An entry here is a standing statement that a generated
/// file may carry that warning forever, so each addition wants a comment saying
/// who reviewed it and why it cannot be fixed at the generator.
const allowedWarningCodes = <String>{};

/// One diagnostic line of `dart analyze --format=machine`.
///
/// The machine format is `SEVERITY|TYPE|CODE|FILE|LINE|COL|LENGTH|MESSAGE`.
class Diagnostic {
  /// Creates a diagnostic.
  Diagnostic({
    required this.severity,
    required this.code,
    required this.file,
    required this.line,
    required this.message,
  });

  /// `ERROR`, `WARNING` or `INFO`.
  final String severity;

  /// The analyzer's code for the rule or error, e.g. `uri_does_not_exist`.
  final String code;

  /// Absolute path of the file the diagnostic is reported against.
  final String file;

  /// 1-based line number, as the analyzer printed it.
  final String line;

  /// The human-readable message.
  final String message;

  /// Parses one machine-format line, or returns null when [raw] is not one.
  static Diagnostic? tryParse(String raw) {
    final parts = raw.split('|');
    if (parts.length < 8) return null;
    return Diagnostic(
      severity: parts[0],
      code: parts[2],
      file: parts[3],
      line: parts[4],
      // The message may itself contain `|`; rejoin whatever follows.
      message: parts.sublist(7).join('|'),
    );
  }

  @override
  String toString() => '$severity $code ($file:$line): $message';
}

/// Thrown when `dart analyze` could not run at all.
///
/// Distinct from "the analyzer ran and found problems": a tool that cannot
/// verify must say so rather than report success by default.
class AnalyzeInvocationException implements Exception {
  /// Creates the exception.
  AnalyzeInvocationException(this.stdout, this.stderr);

  /// What the process wrote to stdout.
  final String stdout;

  /// What the process wrote to stderr.
  final String stderr;

  @override
  String toString() =>
      'dart analyze could not run (exit 1).\nstdout: $stdout\nstderr: $stderr';
}

/// Runs `dart analyze --format=machine` over [paths] and parses the result.
///
/// Uses [Platform.resolvedExecutable] — the Dart binary running this process —
/// rather than whatever `dart` is first on PATH, so the analysis uses the same
/// SDK as the caller.
Future<List<Diagnostic>> analyzePaths(List<String> paths) async {
  if (paths.isEmpty) return const [];

  final result = await Process.run(Platform.resolvedExecutable, [
    'analyze',
    '--format=machine',
    ...paths,
  ]);

  // Exit codes: 0 none, 1 usage/crash, 2 warnings only, 3 errors present.
  if (result.exitCode == 1) {
    throw AnalyzeInvocationException('${result.stdout}', '${result.stderr}');
  }

  return const LineSplitter()
      .convert(result.stdout as String)
      .where((l) => l.trim().isNotEmpty)
      .map(Diagnostic.tryParse)
      .whereType<Diagnostic>()
      .toList();
}

/// The diagnostics from [all] that count as a bad emission.
List<Diagnostic> fatalDiagnostics(Iterable<Diagnostic> all) {
  final allowed = allowedWarningCodes.map((c) => c.toUpperCase()).toSet();
  return all
      .where((d) => !nonFatalSeverities.contains(d.severity.toUpperCase()))
      .where(
        (d) => !(d.severity.toUpperCase() == 'WARNING' &&
            allowed.contains(d.code.toUpperCase())),
      )
      .toList();
}

/// What [verifyGeneratedOutput] found.
class OutputVerification {
  /// Creates a verification report.
  const OutputVerification({
    required this.analysed,
    required this.fatal,
    required this.ignored,
  });

  /// The files that were analysed, as given.
  final List<String> analysed;

  /// Diagnostics that fail the verification.
  final List<Diagnostic> fatal;

  /// Diagnostics that were found but do not fail it — informational only.
  final List<Diagnostic> ignored;

  /// Whether the emission is acceptable.
  bool get ok => fatal.isEmpty;

  /// A report suitable for printing to a terminal.
  String describe({required String label}) {
    if (ok) {
      return '  VERIFY: ${analysed.length} generated file(s) analysed clean'
          '${ignored.isEmpty ? '' : ' (${ignored.length} non-fatal)'}';
    }
    final buffer = StringBuffer()
      ..writeln(
        '  VERIFY FAILED: $label emitted ${fatal.length} '
        'analyzer problem(s) the generator is responsible for:',
      );
    for (final d in fatal) {
      buffer.writeln('    $d');
    }
    buffer.write(
      '  These are diagnostics inside generated files only; diagnostics '
      'elsewhere in the package were not considered.',
    );
    return buffer.toString();
  }
}

/// The path [path] canonicalised for comparison.
///
/// `dart analyze` reports diagnostics against the REAL path, with every symlink
/// resolved, while a caller naturally passes the path it used to write the
/// file. On macOS those differ for anything under the system temp directory
/// (`/tmp` is a symlink to `/private/tmp`), and they differ anywhere a
/// repository sits under a symlinked home.
///
/// Getting this wrong is not a cosmetic bug: the scoping filter would match
/// nothing, every diagnostic would be discarded as "not in a generated file",
/// and the verification would report success having checked nothing. A gate
/// that passes vacuously is worse than no gate, because it is believed.
String _canonical(String path) {
  try {
    return File(path).resolveSymbolicLinksSync();
  } on FileSystemException {
    // The file may not exist (a diagnostic against a phantom URI). Falling back
    // to the lexical form is right: two paths that are both unresolvable can
    // still be compared.
    return p.normalize(p.absolute(path));
  }
}

/// Analyses [generatedFiles] and reports only the problems inside them.
///
/// Scoping to the generated files is what makes this safe to run on a real
/// consumer: a package with a pre-existing, unrelated warning of its own must
/// not fail a regeneration. The analyzer still resolves each file in its
/// package context, so imports, part-of relationships and transitive
/// dependencies behave exactly as they do in an ordinary analysis.
///
/// Files that do not exist are skipped — a module that generated nothing is not
/// a failure.
Future<OutputVerification> verifyGeneratedOutput({
  required List<String> generatedFiles,
}) async {
  final existing = generatedFiles
      .map((f) => p.normalize(p.absolute(f)))
      .where((f) => File(f).existsSync())
      .toSet()
      .toList()
    ..sort();

  final all = await analyzePaths(existing);

  // The analyzer reports against every file it had to resolve, not only the
  // ones named on the command line, so restrict to the generated set.
  final generated = existing.map(_canonical).toSet();
  final mine = all.where((d) => generated.contains(_canonical(d.file)));

  final fatal = fatalDiagnostics(mine);
  final fatalSet = fatal.toSet();
  return OutputVerification(
    analysed: existing,
    fatal: fatal,
    ignored: mine.where((d) => !fatalSet.contains(d)).toList(),
  );
}
