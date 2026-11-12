// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every idle_timeout.sh removes the temp folder its command wrote.
//
// Its subject reaches OUTSIDE this package (the source twin's and the demo
// app's copies of the watchdog), so it runs only when tom_d4rt_flutter_ast's
// suite runs. SCD129 made that arrangement visible rather than incidental:
// `grep -rn 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// ghissues44 — the companion app's `flutter run` (Flutter 3.47.9), which the
// corpus harness starts and kills for every test file, leaves its
// `flutter_tools.*` temp folder (app.dill and app.dill.incremental.dill, about
// 300 MB each) in $TMPDIR; a `flutter test` that exits normally leaves none
// (measured 2026-11-12). The corpus runners run each test file through
// idle_timeout.sh, so every file of every run left one behind: on mbp 791 such
// folders, 447 GB, filled the disk in two days (measured 2026-11-11).
// idle_timeout.sh now gives the command a temp folder of its own (TMPDIR)
// and removes it on exit, whether the command finished or the watchdog
// killed it. Pure process work - no companion app.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import 'sibling_trees.dart';

/// Every copy of the watchdog in the repository, relative to this package.
const _copies = <String>[
  'test/idle_timeout.sh',
  '../tom_d4rt_flutter/test/idle_timeout.sh',
  '../tom_d4rt_flutter_test/test/idle_timeout.sh',
];

/// Runs [script] over `bash -c [command]` with an outer TMPDIR this test owns
/// and answers the exit code and the outer folder's entries afterwards.
Future<(int, List<String>, String)> _run(
  String script,
  String command, {
  required int idle,
}) async {
  final outer = Directory.systemTemp.createTempSync('ghi44_outer_');
  addTearDown(() {
    if (outer.existsSync()) outer.deleteSync(recursive: true);
  });
  final log = p.join(outer.path, 'run.log');
  final result = await Process.run(
    'bash',
    [script, '$idle', log, '--', 'bash', '-c', command],
    environment: {'TMPDIR': outer.path, 'IDLE_POLL': '1'},
  );
  final left = [
    for (final e in outer.listSync())
      if (p.basename(e.path) != 'run.log') p.basename(e.path),
  ];
  return (
    result.exitCode,
    left,
    File(log).existsSync() ? File(log).readAsStringSync() : '',
  );
}

void main() {
  // SCE191: the copies are named relative to this package, so a copy of this
  // file anywhere else would test other files in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: 'every idle_timeout.sh removes the temp folder of its command',
  );

  for (final copy in _copies) {
    group('ghissues44: $copy removes its command\'s temp folder', () {
      test('GHI44-1: a command that exits normally [2026-11-12]', () async {
        final (rc, left, log) = await _run(
          copy,
          r'mkdir "$TMPDIR/flutter_tools.fixture" && '
          r'head -c 1024 /dev/zero > "$TMPDIR/flutter_tools.fixture/app.dill" '
          r'&& echo "tmp=$TMPDIR"',
          idle: 30,
        );
        expect(rc, 0, reason: log);
        expect(
          log,
          contains('tmp='),
          reason: 'the command ran and printed its TMPDIR',
        );
        expect(
          left,
          isEmpty,
          reason:
              'the watchdog leaves nothing in TMPDIR once the command is '
              'done:\n$log',
        );
      });

      test('GHI44-2: a command the watchdog kills [2026-11-12]', () async {
        final (rc, left, log) = await _run(
          copy,
          r'mkdir "$TMPDIR/flutter_tools.fixture" && echo started && sleep 60',
          idle: 2,
        );
        expect(rc, 124, reason: 'idle-killed:\n$log');
        expect(log, contains('started'));
        expect(left, isEmpty, reason: 'killed, and still cleaned up:\n$log');
      }, timeout: const Timeout(Duration(seconds: 60)));

      test('GHI44-3: a watchdog that is itself terminated takes the command '
          'down and cleans up [2026-11-12]', () async {
        final outer = Directory.systemTemp.createTempSync('ghi44_outer_');
        addTearDown(() {
          if (outer.existsSync()) outer.deleteSync(recursive: true);
        });
        final log = File(p.join(outer.path, 'run.log'));
        final marker = p.join(outer.path, 'command.pid');
        final watchdog = await Process.start(
          'bash',
          [
            copy,
            '60',
            log.path,
            '--',
            'bash',
            '-c',
            'echo \$\$ > "$marker"; mkdir "\$TMPDIR/flutter_tools.fixture" '
                '&& echo started && sleep 60',
          ],
          environment: {'TMPDIR': outer.path, 'IDLE_POLL': '1'},
        );
        final deadline = DateTime.now().add(const Duration(seconds: 20));
        while (!(log.existsSync() &&
            log.readAsStringSync().contains('started'))) {
          if (DateTime.now().isAfter(deadline)) {
            fail('the command never started');
          }
          await Future<void>.delayed(const Duration(milliseconds: 200));
        }
        watchdog.kill(ProcessSignal.sigterm);
        expect(await watchdog.exitCode, 143);

        final commandPid = File(marker).readAsStringSync().trim();
        final alive = Process.runSync('kill', ['-0', commandPid]).exitCode == 0;
        expect(alive, isFalse, reason: 'the command outlived its watchdog');
        final left = [
          for (final e in outer.listSync())
            if (!{'run.log', 'command.pid'}.contains(p.basename(e.path)))
              p.basename(e.path),
        ];
        expect(left, isEmpty);
      }, timeout: const Timeout(Duration(seconds: 60)));
    });
  }
}
