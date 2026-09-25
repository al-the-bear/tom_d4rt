// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every corpus runner in BOTH twins writes the attribution header, and both copies of the helper agree.
//
// Its subject reaches OUTSIDE this package, so it runs only when
// tom_d4rt_flutter_ast's suite runs and a session working elsewhere in the repo
// reaches none of it. SCD129 made that arrangement visible rather than
// incidental: `grep -rn 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// WHAT THIS IS FOR. A `testlog/` folder is the primary evidence artifact of the
// quest's cluster-fix protocol, and both twins gitignore `pubspec.lock` — so
// without a header in `metrics.txt` the folder is a pass/skip/fail triple with
// no provenance, and two fleet hosts can produce incomparable results that look
// identical in shape.
//
// F-SCD164-2 IS THE LOAD-BEARING CASE, and it is a census rather than a list.
// The obvious form of this guard names the four scripts the fix was written
// against; there are TWELVE writers of `metrics.txt` — three runners
// (`run_base_tests`, `run_issue_analysis_tests`, `run_harness_tests`) times two
// extensions times two twins — and a `.ps1` left behind is precisely how this
// corpus previously ended up writing to `doc/` on Windows and `testlog/`
// everywhere else. So the set is globbed from disk: anything that writes
// `metrics.txt` must attribute it, whatever it is called and whenever it
// arrives.
//
// Fixtures are written under this package's `.dart_tool/` and deleted
// afterwards.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'run_attribution.dart';
import 'sibling_trees.dart';

const _twins = <String>['.', '../tom_d4rt_flutter'];

/// A write of `metrics.txt` into the run's own output directory.
///
/// Matching the bare words `metrics.txt` is too broad, and this guard found
/// that out about itself within the hour: a COMMENT in `run_guard_tests.sh`
/// explaining why SCD164's check lives in the AST twin mentions `metrics.txt`,
/// which made a script that writes no such file look like one that does. The
/// write expression — the file under the run's `$OUT`/`$out` — is the thing
/// actually being policed.
final RegExp _metricsWrite = RegExp(r'\$\{?(OUT|out)\}?/metrics\.txt');

/// Every `run_*.{sh,ps1}` in a twin's `test/` that writes `metrics.txt`.
List<File> metricsWriters(String twin) {
  final dir = Directory('$twin/test');
  if (!dir.existsSync()) return const [];
  final writers = <File>[];
  for (final e in dir.listSync()) {
    if (e is! File) continue;
    final name = e.uri.pathSegments.last;
    if (!name.startsWith('run_')) continue;
    if (!name.endsWith('.sh') && !name.endsWith('.ps1')) continue;
    if (_metricsWrite.hasMatch(e.readAsStringSync())) writers.add(e);
  }
  writers.sort((a, b) => a.path.compareTo(b.path));
  return writers;
}

String _lockEntry(String name, String version, {String source = 'hosted'}) =>
    '  $name:\n'
    '    dependency: transitive\n'
    '    description:\n'
    '      name: $name\n'
    '    source: $source\n'
    '    version: "$version"\n';

void _package(
  Directory dir, {
  required String name,
  String version = '1.0.0',
  List<String> lockEntries = const [],
  bool withLock = true,
}) {
  dir.createSync(recursive: true);
  File(
    '${dir.path}/pubspec.yaml',
  ).writeAsStringSync('name: $name\nversion: $version\n');
  if (withLock) {
    File('${dir.path}/pubspec.lock').writeAsStringSync(
      'packages:\n${lockEntries.join()}sdks:\n  dart: ">=3.0.0"\n',
    );
  }
}

/// The Dart executable to shell out to, resolved from THIS package rather than
/// from the ambient PATH.
///
/// SCE135: `Process.run('dart', ...)` works on the POSIX hosts and fails on
/// Windows with `ProcessException: cannot find the specified file` — found the
/// first time these guards were ever run on legiondary01. `Process.run` looks
/// for `dart.exe`/`dart.bat` on the WINDOWS PATH, and the Flutter SDK reaches a
/// Git Bash session through a shell profile that the Windows process
/// environment does not carry. So the guard was not failing; it could not
/// start, which is the shape this repo's pre-commit hook was already written
/// against (see `.githooks/pre-commit`, "a git hook runs with a minimal PATH").
///
/// The answer is the hook's: read `flutterRoot` out of the package's OWN
/// resolved `package_config.json`. It is machine-local and repo-derived, so it
/// is correct per host with nothing hardcoded, and it is written by the same
/// `pub get` that makes this package testable at all. Falls back to the bare
/// name, which is what every POSIX host has always used.
String _dartExecutable() {
  final config = File('.dart_tool/package_config.json');
  if (config.existsSync()) {
    final match = RegExp(
      r'"flutterRoot"\s*:\s*"([^"]*)"',
    ).firstMatch(config.readAsStringSync());
    final uri = match?.group(1);
    if (uri != null && uri.isNotEmpty) {
      // `Uri.toFilePath()` rather than string surgery on the `file://` prefix,
      // and that is the whole of the Windows fix. The first attempt captured
      // everything after `file://` and got `/C:/flutter-sdk/flutter` there —
      // a leading slash before the drive letter, which no `File` on Windows
      // resolves — so the lookup silently fell through to the bare name and
      // the guard failed exactly as before. On POSIX the same capture happens
      // to be right, which is why it looked correct on the machine it was
      // written on.
      String root;
      try {
        root = Uri.parse(uri).toFilePath();
      } on Object {
        return 'dart';
      }
      for (final candidate in [
        '$root/bin/cache/dart-sdk/bin/dart.exe',
        '$root/bin/cache/dart-sdk/bin/dart',
      ]) {
        if (File(candidate).existsSync()) return candidate;
      }
    }
  }
  return 'dart';
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject:
        'every corpus runner in BOTH twins writes the attribution header, and both copies of the helper agree',
  );

  group('SCD164: corpus runs record the interpreter they resolved', () {
    late Directory root;
    late String parentDir;
    late String appDir;

    setUp(() {
      root = Directory(
        '${Directory.current.path}/.dart_tool/test_fixtures/'
        'attribution_${pid}_${DateTime.now().microsecondsSinceEpoch}',
      )..createSync(recursive: true);
      parentDir = '${root.path}/zom_twin';
      appDir = '${root.path}/zom_twin/test/zom_twin_app';
    });

    tearDown(() => root.deleteSync(recursive: true));

    test('F-SCD164-1: both twins were scanned and each has runners that '
        'write metrics.txt [2026-09-15] (PASS)', () {
      // Anti-vacuity: F-SCD164-2 iterates this census, so an empty one
      // satisfies it while checking nothing. Six per twin today; the floor
      // asks only that the scan found the shape it is meant to police.
      for (final twin in _twins) {
        expect(
          metricsWriters(twin).length,
          greaterThanOrEqualTo(4),
          reason:
              'only ${metricsWriters(twin).length} metrics.txt writers found '
              'under $twin/test — the census is not seeing the runners, so '
              'F-SCD164-2 would pass vacuously',
        );
      }
    });

    test('F-SCD164-2: every runner that writes metrics.txt also writes the '
        'attribution header [2026-09-15] (PASS)', () {
      final unattributed = <String>[];
      for (final twin in _twins) {
        for (final script in metricsWriters(twin)) {
          if (!script.readAsStringSync().contains('run_attribution.dart')) {
            unattributed.add(script.path);
          }
        }
      }
      expect(
        unattributed,
        isEmpty,
        reason:
            'these runners write metrics.txt without attributing it, so the '
            'testlog folders they produce cannot be matched to the interpreter '
            'that made them. Add the run_attribution.dart call after the '
            'companion app is resolved, in EVERY copy — .sh and .ps1, both '
            'twins.',
      );
    });

    test('F-SCD164-3: the header records every tom_ package both locks '
        'resolve, and no others [2026-09-15] (PASS)', () {
      _package(
        Directory(parentDir),
        name: 'zom_twin',
        version: '0.3.0',
        lockEntries: [
          _lockEntry('tom_d4rt_ast', '0.65.0'),
          _lockEntry('tom_d4rt_generator', '1.26.0'),
          _lockEntry('collection', '1.19.0'),
        ],
      );
      _package(
        Directory(appDir),
        name: 'zom_twin_app',
        lockEntries: [
          _lockEntry('tom_d4rt_ast', '0.65.0'),
          _lockEntry('zom_twin', '0.3.0', source: 'path'),
        ],
      );

      final lines = runAttributionLines(
        parentDir: parentDir,
        appDir: appDir,
        runId: '20260915-1200-base',
        startedAt: DateTime.utc(2026, 9, 15, 12),
      );

      expect(lines.first, '# run: 20260915-1200-base');
      expect(lines, contains('# started: 2026-09-15T12:00:00'));
      expect(lines, contains('# package: zom_twin 0.3.0'));
      expect(lines, contains('# app: $appDir'));
      expect(lines, contains('# resolved: tom_d4rt_ast 0.65.0 (hosted)'));
      expect(lines, contains('# resolved: tom_d4rt_generator 1.26.0 (hosted)'));
      expect(lines, contains('# app-resolved: tom_d4rt_ast 0.65.0 (hosted)'));
      // The app resolves this package by path; recording the source is what
      // distinguishes "the app is wired to the working tree" from "the app
      // pulled a published copy".
      expect(lines, contains('# app-resolved: zom_twin 0.3.0 (path)'));
      // Third-party packages are not the subject and would bury the ones that
      // are: this header is read beside a 40-file metrics table.
      expect(
        lines.where((l) => l.contains('collection')),
        isEmpty,
        reason: 'only tom_ packages belong in the header',
      );
      // Every line is prefixed, so a parser can separate header from results
      // without counting lines.
      for (final line in lines) {
        expect(line, startsWith(attributionPrefix));
      }
    });

    test('F-SCD164-4: a lock that is missing or holds no tom_ package is '
        'NAMED, not silently omitted [2026-09-15] (PASS)', () {
      // The failure this prevents: a header with no `app-resolved:` line reads
      // as "the app resolved nothing interesting" when it means "nobody
      // looked". An empty diagnostic that cannot tell those apart is how this
      // repository has been misled before.
      _package(
        Directory(parentDir),
        name: 'zom_twin',
        version: '0.3.0',
        lockEntries: [_lockEntry('collection', '1.19.0')],
      );
      _package(Directory(appDir), name: 'zom_twin_app', withLock: false);

      final lines = runAttributionLines(
        parentDir: parentDir,
        appDir: appDir,
        runId: 'r',
        startedAt: DateTime.utc(2026, 9, 15),
      );
      expect(
        lines.singleWhere((l) => l.startsWith('# resolved:')),
        contains('NONE — no tom_ package in'),
      );
      expect(
        lines.singleWhere((l) => l.startsWith('# app-resolved:')),
        contains('NONE — $appDir has no pubspec.lock'),
      );
    });

    // ------------------------------------------------------------------
    // SCE63: the header also says how far behind the working tree the
    // resolution is.
    //
    // exec guards the same exposure by FAILING (F-SCC80-3): a run certifying
    // an interpreter nobody is editing is a wasted run. That does not port.
    // Here the gap is deliberate — the twins resolve from pub.dev so their
    // corpora certify what a consumer gets — so a gate would refuse every
    // legitimate run. What was missing is the RECORD, because both twins
    // gitignore pubspec.lock and the gap is therefore per-machine and absent
    // from every diff.
    // ------------------------------------------------------------------

    /// A sibling package tree beside [parentDir], as the twins are laid out.
    Directory sibling(String name, String version, {String? libContent}) {
      final dir = Directory('${root.path}/$name');
      _package(dir, name: name, version: version, withLock: false);
      if (libContent != null) {
        File('${dir.path}/lib/x.dart')
          ..createSync(recursive: true)
          ..writeAsStringSync(libContent);
      }
      return dir;
    }

    /// A package config for [parentDir] naming [name] at [root].
    void config(String name, Directory packageRoot) {
      File('$parentDir/.dart_tool/package_config.json')
        ..createSync(recursive: true)
        ..writeAsStringSync(
          '{"configVersion":2,"packages":[{"name":"$name",'
          '"rootUri":"${packageRoot.uri}","packageUri":"lib/"}]}',
        );
    }

    test('F-SCE63-1: a resolution behind its sibling tree is announced '
        '[2026-09-21]', () {
      _package(
        Directory(parentDir),
        name: 'zom_twin',
        lockEntries: [_lockEntry('tom_zom_interp', '0.65.0')],
      );
      _package(Directory(appDir), name: 'zom_twin_app', withLock: false);
      sibling('tom_zom_interp', '0.123.0');

      final line = runAttributionLines(
        parentDir: parentDir,
        appDir: appDir,
        runId: 'r',
        startedAt: DateTime(2026, 9, 21),
      ).singleWhere((l) => l.startsWith('# tree:'));

      expect(line, contains('tom_zom_interp resolved 0.65.0, tree 0.123.0'));
      expect(
        line,
        contains('TREE AHEAD'),
        reason:
            'the whole point is that a reader of testlog/ learns this '
            'without opening a gitignored lock on the machine that ran it',
      );
    });

    test('F-SCE63-2: the same version with different bytes is not "in step" '
        '[2026-09-21]', () {
      // The case a version comparison cannot see, and the reason the contents
      // are diffed when the numbers already agree: a sibling edited without a
      // bump reads as in step to every version-based check in the repo.
      _package(
        Directory(parentDir),
        name: 'zom_twin',
        lockEntries: [_lockEntry('tom_zom_interp', '1.0.0')],
      );
      _package(Directory(appDir), name: 'zom_twin_app', withLock: false);
      final published = sibling('tom_zom_pub', '1.0.0', libContent: 'a');
      config('tom_zom_interp', published);
      sibling('tom_zom_interp', '1.0.0', libContent: 'DIFFERENT');

      final line = runAttributionLines(
        parentDir: parentDir,
        appDir: appDir,
        runId: 'r',
        startedAt: DateTime(2026, 9, 21),
      ).singleWhere((l) => l.startsWith('# tree:'));

      expect(line, contains('SAME VERSION'));
      expect(line, contains('1 FILE(S) DIFFER'));
    });

    test('F-SCE63-3: no sibling is reported as NONE, not omitted '
        '[2026-09-21]', () {
      // Same rule the resolved lines already follow: "asked and found none"
      // must be distinguishable from "never asked", which shows as no line
      // with this prefix at all.
      _package(
        Directory(parentDir),
        name: 'zom_twin',
        lockEntries: [_lockEntry('tom_zom_absent', '1.0.0')],
      );
      _package(Directory(appDir), name: 'zom_twin_app', withLock: false);

      expect(
        runAttributionLines(
          parentDir: parentDir,
          appDir: appDir,
          runId: 'r',
          startedAt: DateTime(2026, 9, 21),
        ).singleWhere((l) => l.startsWith('# tree:')),
        contains('NONE — no hosted tom_ package'),
      );
    });

    test('F-SCE63-4: drift is announced on stderr, and silence means in step '
        '[2026-09-21]', () async {
      // END TO END, because the mechanism IS the stream split: every runner
      // redirects this program's stdout into metrics.txt and nothing else, so
      // the announcement only reaches a console if it is on stderr. A unit
      // test of the formatting would pass with the writes going to stdout,
      // which is the one arrangement that breaks all twelve runners at once
      // (it would bury the banner in the metrics file and corrupt the header
      // the Verification runs table is read from).
      _package(
        Directory(parentDir),
        name: 'zom_twin',
        lockEntries: [_lockEntry('tom_zom_interp', '0.65.0')],
      );
      _package(Directory(appDir), name: 'zom_twin_app', withLock: false);
      final tree = sibling('tom_zom_interp', '0.123.0');

      Future<ProcessResult> attribute() => Process.run(_dartExecutable(), [
        'run',
        'test/run_attribution.dart',
        parentDir,
        appDir,
        'r',
      ]);

      final drifted = await attribute();
      expect(
        drifted.stderr,
        allOf(
          contains('does NOT measure the working tree'),
          contains('tom_zom_interp resolved 0.65.0, tree 0.123.0'),
        ),
        reason: 'the console must say it without anyone opening metrics.txt',
      );
      expect(
        drifted.stdout,
        isNot(contains('does NOT measure')),
        reason:
            'stdout is metrics.txt — the header must stay parseable, and '
            'F-SCD164-3 reads it',
      );

      // Versions brought into step AND the bytes comparable: nothing is
      // announced. A banner printed on every run is one nobody reads by the
      // third time.
      //
      // The published copy has to exist and be named by the package config,
      // and that is not fixture ceremony — without it the verdict is
      // "NOT COMPARED", which is UNKNOWN rather than in step and is announced
      // on purpose. The first draft of this test omitted it and read the
      // resulting banner as a bug in the code.
      File(
        '${tree.path}/pubspec.yaml',
      ).writeAsStringSync('name: tom_zom_interp\nversion: 0.65.0\n');
      File('${tree.path}/lib/x.dart')
        ..createSync(recursive: true)
        ..writeAsStringSync('same');
      final published = sibling('zom_published', '0.65.0', libContent: 'same');
      config('tom_zom_interp', published);
      final quiet = await attribute();
      expect(quiet.stderr, isEmpty);
      expect(
        quiet.stdout,
        contains('tom_zom_interp resolved 0.65.0, tree 0.65.0'),
        reason:
            'still RECORDED in the header — only the announcement is '
            'conditional',
      );
    });

    test('F-SCD164-5: the tom_d4rt_flutter copy of run_attribution.dart is '
        'identical to this one [2026-09-15] (PASS)', () {
      final twin = File('../tom_d4rt_flutter/test/run_attribution.dart');
      if (!twin.existsSync()) {
        markTestSkipped(
          'tom_d4rt_flutter is not checked out beside this package',
        );
        return;
      }
      expect(
        twin.readAsStringSync(),
        File('test/run_attribution.dart').readAsStringSync(),
        reason:
            'Both twins must write the same header, or two testlog folders '
            'cannot be compared. Edit it here and copy it to '
            'tom_d4rt_flutter/test/.',
      );
    });
  });
}
