// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — both twins' launch/retry path must kill a process TREE.
//
// Its subject reaches OUTSIDE this package (the sibling twin's
// send_test_runner.dart), so it runs only when tom_d4rt_flutter_ast's suite
// runs. SCD129 made that arrangement visible rather than incidental:
// `grep -rn 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE14 — a launch that timed out left its build running, and the retry then
// collided with it.
//
// `_killTestApp` SIGKILLed the `flutter run` wrapper and nothing else. Measured
// 2026-09-18 on macOS: `flutter run` spawns `xcodebuild` as a DIRECT CHILD,
// which owns a subtree of six more processes, and SIGKILL on the wrapper left
// every one of them alive — with XCBBuildService still holding
// `build/macos/Build/Intermediates.noindex/XCBuildData/build.db`. The retry
// started a second build in the same directory and died with
// `unable to attach DB: … database is locked`.
//
// The port reap that ran afterwards could not help, and it is worth being
// precise about why: it finds processes by their LISTEN socket, and a build
// binds none. The two cleanups cover DISJOINT escapees — the tree walk reaches
// descendants the wrapper still owns, the port reap reaches a desktop app that
// has reparented away from it. Removing either one reopens a different hole.
//
// And because `catch (_)` discarded the first attempt, the only reason that
// reached the reader described the retry. "database is locked" is a
// consequence of the first failure, never a cause of anything, so the actual
// event — a cold build overrunning a 120 s deadline — was invisible.
//
// WHAT THIS PINS, AND WHAT IT DOES NOT. Source-shape assertions. The behaviour
// needs a cold platform build (~2–3 minutes) to observe, and this file is
// invoked from `run_guard_tests.sh`, which exists so that cheap checks are not
// held hostage to expensive ones. The behaviour was verified by deleting the
// companion app's `build/` and running a base file; what is pinned here are the
// four shapes whose loss brings the bug back.
//
// EACH ASSERTION HAS BEEN SEEN TO FAIL by reinstating the old code.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// The two runners this guard holds to the same contract.
const _twins = <String>['tom_d4rt_flutter_ast', 'tom_d4rt_flutter'];

File _runnerFor(String twin) {
  final here = Directory.current.path;
  final root = p.basename(here) == twin ? here : p.join(p.dirname(here), twin);
  return File(p.join(root, 'test', 'send_test_runner.dart'));
}

/// Body of the class method whose signature contains [signature].
///
/// Ends at the class-member-level closing brace (`  }`) rather than by counting
/// braces, so a brace in a string or comment cannot confuse it.
String _methodBody(String source, String signature, String where) {
  final lines = source.split('\n');
  final start = lines.indexWhere((l) => l.contains(signature));
  expect(
    start,
    isNot(-1),
    reason:
        '`$signature` is gone from $where. If it was renamed, retarget this '
        'guard rather than deleting it.',
  );
  final end = lines.indexWhere((l) => l == '  }', start + 1);
  expect(end, isNot(-1), reason: 'could not find the end of `$signature`');
  return lines.sublist(start, end + 1).join('\n');
}

void main() {
  group('SCE14: a timed-out launch leaves nothing behind for the retry', () {
    test('F-SCE14-1: the app is killed as a process tree [2026-09-18]', () {
      for (final twin in _twins) {
        final runner = _runnerFor(twin);
        expect(
          runner.existsSync(),
          isTrue,
          reason: '${runner.path} is missing',
        );
        final source = runner.readAsStringSync();
        final kill = _methodBody(
          source,
          'static Future<void> _killTestApp()',
          twin,
        );

        expect(
          kill,
          contains('_killProcessTree('),
          reason:
              '$twin: _killTestApp no longer kills the tree. On macOS that '
              'leaves xcodebuild and its six descendants running, holding the '
              "app's build.db, and the retry dies on 'database is locked'.",
        );
        expect(
          kill.contains('_testAppProcess!.kill('),
          isFalse,
          reason:
              '$twin: _killTestApp signals the wrapper pid directly again. A '
              'build the wrapper spawned is a separate process and survives.',
        );
        // The port reap is not made redundant by the tree walk: a reparented
        // desktop app is outside the tree. Losing it reopens a different hole.
        expect(
          kill,
          contains('_killExistingProcess()'),
          reason:
              '$twin: the port reap is gone. The tree walk cannot find a '
              'desktop app that reparented away from the wrapper.',
        );

        // The walk itself must not degrade silently when it cannot enumerate.
        final walk = _methodBody(
          source,
          'static Future<List<int>> _processTreePids(',
          twin,
        );
        expect(
          walk,
          contains('print('),
          reason:
              '$twin: a failure to enumerate children is silent again. '
              'Falling back to killing the root alone IS the old bug, and its '
              'whole cost was that it looked like something else.',
        );
      }
    });

    test('F-SCE14-2: the retry waits for the build lock [2026-09-18]', () {
      for (final twin in _twins) {
        final setUp = _methodBody(
          _runnerFor(twin).readAsStringSync(),
          'static Future<void> setUp({',
          twin,
        );
        expect(
          setUp,
          contains('_waitForBuildLockFree('),
          reason:
              '$twin: the retry restarts without waiting for the previous '
              "attempt's build database to be released. Killing the tree does "
              'not guarantee the kernel has closed its handles yet, and a '
              'build started into that window fails exactly as a concurrent '
              'one does.',
        );
      }
    });

    test('F-SCE14-3: a double failure names both attempts [2026-09-18]', () {
      for (final twin in _twins) {
        final setUp = _methodBody(
          _runnerFor(twin).readAsStringSync(),
          'static Future<void> setUp({',
          twin,
        );
        expect(
          setUp,
          contains('catch (firstAttempt)'),
          reason:
              '$twin: the first launch failure is discarded again. The retry '
              "reason describes the retry; the first attempt's is the event.",
        );
        expect(
          setUp,
          allOf(contains(r'$firstAttempt'), contains(r'$secondAttempt')),
          reason:
              '$twin: the thrown message does not carry both attempts, so one '
              'of the two reasons still cannot reach a reader.',
        );
      }
    });

    test('F-SCE14-4: the first launch gets build-sized patience [2026-09-18]', () {
      for (final twin in _twins) {
        final source = _runnerFor(twin).readAsStringSync();
        expect(
          source,
          contains('_hasLaunchedOnce'),
          reason:
              '$twin: the first launch no longer gets a longer deadline. Only '
              'the first launch of a process can be waiting on a cold platform '
              'build, and a cold macOS build does not fit in 120 s — which is '
              'what produced the overrun the retry then collided with.',
        );
        final start = _methodBody(
          source,
          'static Future<void> _startTestApp(',
          twin,
        );
        expect(
          start,
          contains('!_hasLaunchedOnce'),
          reason: '$twin: the flag exists but no longer widens the deadline',
        );
      }
    });
  });
}
