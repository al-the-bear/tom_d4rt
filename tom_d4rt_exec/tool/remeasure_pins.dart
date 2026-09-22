/// Re-measures every entry in `_pinnedInterpreterFloors` against the interpreter
/// this package actually resolves, and prints a verdict per entry.
///
/// ## Why this exists
///
/// SCC43 made the flip condition of a publish-blocked baseline entry
/// machine-checkable: F-SCC43-1 reads exec's `tom_d4rt_ast` floor out of
/// `pubspec.yaml` and goes red with a checklist the moment a pin's publish has
/// landed. That answers WHEN an entry becomes reviewable.
///
/// SCC44 found the other half, and it is the expensive one. Of the seven entries
/// that register then held, SIX had already been passing for a full release —
/// not because anyone missed a publish, but because the pin had never been a
/// measurement. Each was written from prose ("the working-tree Queue bridge
/// gained remove/removeWhere/retainWhere") describing a working-tree behaviour
/// that had in fact shipped in the very version the entry claimed to be blocked
/// by. F-SCC43-1 cannot catch that: its trigger is the floor moving, and the
/// floor had not moved.
///
/// So nothing answers WHETHER A PIN IS STILL TRUE except a run, and the run was
/// a five-step manual recipe per entry. At seven entries that is enough friction
/// not to do, which is precisely what happened. This is that recipe as one
/// command.
///
/// ## What it does
///
/// For every pinned entry: take the `tom_d4rt` twin at the same relative path,
/// rewrite its interpreter imports using the SAME table `_normalise` reads
/// (`test/port_recipe.dart` — one table, two directions, so the tool and the
/// guard cannot disagree about what a port is), run it against the resolved
/// interpreter, and report.
///
/// ## It does not touch the tree
///
/// The candidate is written under `<workspace>/ztmp`, never into `test/`. A tool
/// that edits the tree it is measuring leaves that tree dirty when it crashes,
/// and this one runs `dart test` — the single most likely thing in the repo to
/// be interrupted. Running a file from outside the package works because
/// `package:` URIs resolve through the package config of the directory the
/// command runs in; the reference file's RELATIVE imports (`interpreter_test.dart`)
/// would not, so they are rewritten to absolute `file:` URIs anchored at the
/// exec path the port would have occupied.
///
/// ## Its answer is advice, not a contract
///
/// It takes minutes and needs whatever `dart test` needs. Deliberately NOT wired
/// into `conformance_drift_test.dart`: a guard that takes minutes gets switched
/// off. F-SCC43-1 names this command in its failure message instead.
///
/// ## Reading the verdicts
///
///   still-failing     the pin is justified. Paste the reported case ids and
///                     values into the entry comment — that is what makes the
///                     next reader's pin a measurement rather than a
///                     restatement.
///   does-not-compile  also justified, and more strongly: the port cannot even
///                     be built against the resolved interpreter.
///   PASSES NOW        the pin is stale. Port the file for real and delete both
///                     the baseline entry and its register line.
///   no-twin           the reference file is gone. The register is stale in a
///                     different way; F-SCC43-1 part one covers the case where
///                     the BASELINE entry is gone, not this one.
///
/// ## The other register (SCD126)
///
/// `_uncoveredBaseline` has the same absorption property and the same
/// experiment: an entry claims a reference file has no exec counterpart, and
/// while it stands nothing notices if one becomes possible. `--uncovered` runs
/// the identical copy-rewrite-run over that map instead. The verdict vocabulary
/// carries over unchanged, only what it means changes: `PASSES NOW` on a pin
/// means the pin was never true, and on an uncovered entry means the port is
/// available and the entry should go.
///
/// Usage, from `tom_d4rt_exec/`:
///
///     dart run tool/remeasure_pins.dart              # _pinnedInterpreterFloors
///     dart run tool/remeasure_pins.dart --uncovered  # _uncoveredBaseline
///     dart run tool/remeasure_pins.dart --candidates scd62_nullable_is_test.dart ...
///
/// The third form runs the identical experiment over files in NEITHER register
/// — what F-SCC6-2 reports when a reference test has no counterpart. `PASSES
/// NOW` there means the port is available and should be taken; the other three
/// verdicts each imply a different entry, and which one is not a judgement the
/// reader should have to make from the file alone.
library;

import 'dart:convert';
import 'dart:io';

import '../test/port_recipe.dart';

/// Where the register lives. Parsed rather than imported: it is a private const
/// in a test file, and moving it out would split the guard's knowledge across
/// two files for the tool's convenience.
const String _guardPath = 'test/conformance_drift_test.dart';

Future<int> main(List<String> args) async {
  if (!File('pubspec.yaml').existsSync() || !File(_guardPath).existsSync()) {
    stderr.writeln(
      'Run this from the tom_d4rt_exec package root: it reads $_guardPath '
      'and resolves ../tom_d4rt beside it.',
    );
    return 2;
  }

  final uncovered = args.contains('--uncovered');
  // SCD200: the same experiment over files that are in NEITHER register — the
  // reference tests F-SCC6-2 reports as having no counterpart. Deciding what to
  // do with one of those means knowing whether its port would run, and the
  // recipe for finding that out is this tool's whole subject. Without this mode
  // the question was answered by hand, per file, which is how twenty-four of
  // them accumulated unanswered.
  final candidates = args.contains('--candidates');
  final register = candidates
      ? 'candidate'
      : uncovered
      ? '_uncoveredBaseline'
      : '_pinnedInterpreterFloors';
  final pins = candidates
      ? {
          for (final path in args.where((a) => !a.startsWith('--')))
            path: '(candidate)',
        }
      : uncovered
      ? _parseRegister(
          File(_guardPath).readAsStringSync(),
          // SCE100 changed the value from a bare case count to a
          // `_CaseCounts` record, so both the opener and the entry shape moved
          // under this tool. The anti-vacuity check below is what turned that
          // into a refusal rather than an empty, cheerful report — but a tool
          // that reads a register has to be edited WITH it, which is the same
          // rule the register applies to its own prose.
          'const Map<String, _CaseCounts> _uncoveredBaseline = {',
          // `ran` is the runtime count, which is what this tool re-measures;
          // the formatter wraps long entries, so the two fields may be on the
          // key's line or on their own.
          "^\\s*'([^']+)':\\s*\\(?\\s*ran:\\s*(\\d+)",
        )
      : _parsePins(File(_guardPath).readAsStringSync());
  if (candidates && pins.isEmpty) {
    stderr.writeln(
      'No candidate paths given. Usage:\n'
      '    dart run tool/remeasure_pins.dart --candidates '
      '<path relative to tom_d4rt/test> ...',
    );
    return 2;
  }
  if (pins.isEmpty) {
    // A scan that finds nothing "succeeds" at everything. SCD122 caught exactly
    // that failure in this file's sibling scanner, twice, so an empty parse is
    // an error here rather than an empty report.
    stderr.writeln(
      'Parsed ZERO entries out of \$register. Either the register '
      'is genuinely empty — in which case there is nothing to re-measure and '
      'this tool should not have been run — or its syntax moved out from under '
      'the parser. Check $_guardPath before believing an empty report.',
    );
    return 2;
  }

  final floor = _execAstFloor();
  final resolved = _resolvedAstVersion();
  stdout.writeln(
    'exec declares tom_d4rt_ast floor $floor; resolves ${resolved ?? "unknown"}.'
    '\nRe-measuring ${pins.length} $register '
    '${pins.length == 1 ? "entry" : "entries"} against the RESOLVED copy.\n',
  );

  final scratch = _scratchDir();
  final results = <_Result>[];
  for (final entry in pins.entries) {
    stdout.writeln('--- ${entry.key}');
    results.add(await _remeasure(entry.key, entry.value, scratch));
  }

  stdout.writeln('\n${'=' * 78}\n');
  final width = results.fold<int>(
    5,
    (w, r) => r.path.length > w ? r.path.length : w,
  );
  stdout.writeln(
    '${"ENTRY".padRight(width)}  ${(uncovered ? "CASES" : "PINNED").padRight(8)}  ${"FLOOR".padRight(8)}  VERDICT',
  );
  for (final r in results) {
    stdout.writeln(
      '${r.path.padRight(width)}  ${r.pinnedAt.padRight(8)}  '
      '${floor.padRight(8)}  ${r.verdict}',
    );
  }

  final stale = results.where((r) => r.verdict == _Verdict.passesNow).toList();
  if (stale.isNotEmpty) {
    stdout.writeln(
      uncovered
          ? '\n${stale.length} entry/entries are PORTABLE — they pass against '
                'the interpreter this package already resolves, so nothing is '
                'blocking the port. Take it (diff the CASE COUNTS too, not just '
                'pass/fail — a baseline entry can hide a silently-partial copy) '
                'and delete the entry:\n'
                '${stale.map((r) => '  ${r.path}').join('\n')}'
          : '\n${stale.length} pin(s) are STALE — they pass against the '
                'interpreter this package already resolves, so they were never '
                'blocked by the version they name. Port each one for real and '
                'delete both its baseline entry and its line in '
                '_pinnedInterpreterFloors:\n'
                '${stale.map((r) => '  ${r.path}').join('\n')}',
    );
  }

  for (final r in results.where((r) => r.detail.isNotEmpty)) {
    stdout.writeln('\n${r.path} — ${r.verdict}:');
    for (final line in r.detail) {
      stdout.writeln('  $line');
    }
  }

  stdout.writeln(
    '\nA verdict is evidence for one day. Record it in the entry comment with '
    'the date, the resolved version and the case ids — a pin restated is a pin '
    'that will go stale again.',
  );
  return stale.isEmpty ? 0 : 1;
}

enum _Verdict {
  stillFailing('still-failing'),
  doesNotCompile('does-not-compile'),
  passesNow('PASSES NOW — stale pin'),
  noTwin('no-twin');

  const _Verdict(this.label);
  final String label;

  @override
  String toString() => label;
}

class _Result {
  _Result(this.path, this.pinnedAt, this.verdict, this.detail);
  final String path;
  final String pinnedAt;
  final _Verdict verdict;
  final List<String> detail;
}

/// `_pinnedInterpreterFloors`, read out of [source].
///
/// Deliberately anchored on the register's opening line rather than matching
/// `'x': 'y',` anywhere in the file: several other maps in that file have the
/// same shape, and a parser that swept the whole file would report entries that
/// are not pins at all.
Map<String, String> _parsePins(String source) => _parseRegister(
  source,
  'const Map<String, String> _pinnedInterpreterFloors',
  "^\\s*'([^']+)':\\s*'([^']+)',",
);

/// One register out of [source], as `path -> second capture group`.
///
/// Anchored on the map's opening line rather than sweeping the file, because
/// several maps there share an entry shape and a parser that matched anywhere
/// would report entries from the wrong one.
Map<String, String> _parseRegister(
  String source,
  String opener,
  String entryPattern,
) {
  final start = source.indexOf(opener);
  if (start < 0) return const {};
  final end = source.indexOf('\n};', start);
  if (end < 0) return const {};
  final body = source.substring(start, end);
  final entry = RegExp(entryPattern, multiLine: true);
  return {for (final m in entry.allMatches(body)) m.group(1)!: m.group(2)!};
}

String _execAstFloor() {
  final match = RegExp(
    r'''tom_d4rt_ast:\s*["']?(?:>=|\^)\s*(\d+\.\d+\.\d+)''',
  ).firstMatch(File('pubspec.yaml').readAsStringSync());
  return match?.group(1) ?? 'unreadable';
}

String? _resolvedAstVersion() {
  final lock = File('pubspec.lock');
  if (!lock.existsSync()) return null;
  final match = RegExp(
    r'^  tom_d4rt_ast:\n(?:.*\n)*?    version: "([^"]+)"',
    multiLine: true,
  ).firstMatch(lock.readAsStringSync());
  return match?.group(1);
}

/// A clean scratch directory under the WORKSPACE `ztmp`.
///
/// Not `Directory.systemTemp`: the workspace rule is that temporary files live
/// in `<workspace-root>/ztmp`, where whoever has to clean up after an
/// interrupted run can see them, rather than hidden under `/tmp`.
///
/// FINDING THE RIGHT ONE TOOK TWO WRONG ANSWERS, both measured, and both worth
/// recording because the failure is silent either way — the tool works, it just
/// writes somewhere nobody expected:
///
///   * "the nearest ancestor with a ztmp" put the candidate in
///     `tom_d4rt_exec/ztmp/`, INSIDE the package being measured, which is the
///     one property this tool was built to have. `ztmp/` is gitignored at the
///     repo root, so being ignored had hidden it;
///   * "the highest ancestor with a ztmp" walked past the workspace entirely
///     into the fleet root's `ztmp`, four levels above anything this package
///     belongs to. There are four `ztmp` directories on the way up.
///
/// So the anchor is not `ztmp` at all — it is the workspace root, identified by
/// carrying BOTH a `ztmp/` and a `CLAUDE.md`, and the nearest such ancestor
/// wins.
Directory _scratchDir() {
  var dir = Directory.current.absolute;
  for (var i = 0; i < 10; i++) {
    final ztmp = Directory('${dir.path}/ztmp');
    if (ztmp.existsSync() && File('${dir.path}/CLAUDE.md').existsSync()) {
      final scratch = Directory('${ztmp.path}/remeasure_pins');
      if (scratch.existsSync()) scratch.deleteSync(recursive: true);
      scratch.createSync(recursive: true);
      return scratch;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  throw StateError(
    'No workspace root (a directory with both ztmp/ and CLAUDE.md) above '
    '${Directory.current.path}. This tool writes its candidate there rather '
    'than into test/, so it will not run without one.',
  );
}

/// Run one pin: build the port in [scratch], run it, read the verdict.
Future<_Result> _remeasure(
  String path,
  String pinnedAt,
  Directory scratch,
) async {
  final reference = File('../tom_d4rt/test/$path');
  if (!reference.existsSync()) {
    stdout.writeln('    no twin at ${reference.path}');
    return _Result(path, pinnedAt, _Verdict.noTwin, const []);
  }

  // The directory the port WOULD occupy, so relative imports can be anchored.
  final execDir = Directory(
    'test/${path.contains('/') ? path.substring(0, path.lastIndexOf('/')) : ''}',
  ).absolute.path;
  final source = _anchorRelativeImports(
    rewriteReferenceImports(reference.readAsStringSync()),
    execDir,
  );

  final candidate = File('${scratch.path}/${path.replaceAll('/', '__')}');
  candidate.writeAsStringSync(source);

  final run = await Process.run('dart', [
    'test',
    '-r',
    'json',
    candidate.path,
  ], workingDirectory: Directory.current.path);

  final report = _readJsonReport(run.stdout as String);
  if (report.compileError != null) {
    stdout.writeln('    does not compile against the resolved interpreter');
    return _Result(path, pinnedAt, _Verdict.doesNotCompile, [
      report.compileError!,
    ]);
  }
  if (report.failures.isEmpty && run.exitCode == 0) {
    stdout.writeln('    PASSES NOW (${report.passed} cases) — stale pin');
    return _Result(path, pinnedAt, _Verdict.passesNow, const []);
  }
  stdout.writeln(
    '    still failing: ${report.failures.length} of '
    '${report.failures.length + report.passed}',
  );
  return _Result(path, pinnedAt, _Verdict.stillFailing, report.failures);
}

/// [source] with relative imports turned into absolute `file:` URIs anchored at
/// [anchorDir], the directory the port would have lived in.
///
/// Only relative ones: a `package:` or `dart:` import already resolves through
/// the package config of the directory `dart test` runs in.
String _anchorRelativeImports(String source, String anchorDir) =>
    source.replaceAllMapped(
      RegExp(
        '''^(\\s*(?:import|export)\\s+)(['"])([^'"]+)\\2''',
        multiLine: true,
      ),
      (m) {
        final uri = m.group(3)!;
        if (uri.startsWith('package:') ||
            uri.startsWith('dart:') ||
            uri.startsWith('file:')) {
          return m.group(0)!;
        }
        final resolved = Uri.file('$anchorDir/').resolve(uri);
        return '${m.group(1)}${m.group(2)}$resolved${m.group(2)}';
      },
    );

class _Report {
  _Report(this.passed, this.failures, this.compileError);
  final int passed;
  final List<String> failures;
  final String? compileError;
}

/// The JSON reporter's stream, reduced to what a verdict needs.
_Report _readJsonReport(String stdoutText) {
  final names = <int, String>{};
  final failures = <String>[];
  final errors = <int, String>{};
  var passed = 0;
  String? compileError;
  for (final line in const LineSplitter().convert(stdoutText)) {
    if (!line.startsWith('{')) continue;
    final Object? decoded;
    try {
      decoded = jsonDecode(line);
    } catch (_) {
      continue;
    }
    if (decoded is! Map<String, dynamic>) continue;
    switch (decoded['type']) {
      case 'testStart':
        final test = decoded['test'] as Map<String, dynamic>;
        names[test['id'] as int] = test['name'] as String;
      case 'error':
        final message = '${decoded['error']}';
        final id = decoded['testID'] as int?;
        if (id != null) errors[id] = message;
        // A file that does not compile fails its synthetic "loading" test.
        if ((names[id] ?? '').startsWith('loading ') ||
            message.contains('Error: ') && names[id] == null) {
          compileError ??= message.split('\n').take(6).join('\n  ');
        }
      case 'testDone':
        final id = decoded['testID'] as int;
        final name = names[id] ?? '?';
        if (name.startsWith('loading ')) continue;
        if (decoded['skipped'] == true) continue;
        if (decoded['result'] == 'success') {
          passed++;
        } else {
          final why = (errors[id] ?? '').split('\n').take(3).join(' / ');
          failures.add('$name${why.isEmpty ? '' : '  --  $why'}');
        }
    }
  }
  return _Report(passed, failures, compileError);
}
