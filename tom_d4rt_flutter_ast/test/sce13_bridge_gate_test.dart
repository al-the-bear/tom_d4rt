// The corpus harness must not regenerate bridges silently, and must not write
// to the package when the generator's output has not changed.
//
// SCE13. `SendTestRunner.setUp` decided bridge staleness from MTIMES and ran
// the regeneration through `Process.run`, which buffers. A `flutter pub
// upgrade` moves tom_d4rt_generator into a different pub-cache directory with
// fresh mtimes, so every lock change read as stale. Measured 2026-09-18 in
// this package: the regeneration took 116 s, produced 240 lines nobody saw,
// and rewrote all 18 bridges with no difference beyond the `// Generated:`
// line. Two consequences, neither of which named its cause — the corpus
// runner's idle watchdog killed `flutter_base_01` and reported
// `exit=124 (IDLE-KILLED)`, which the quest protocol says to re-run rather
// than read; and a dirty `lib/src/bridges` forced a cold rebuild of the
// companion app.
//
// WHAT THIS PINS, AND WHAT IT DOES NOT. These are source-shape assertions,
// deliberately. The property that matters — "a fresh package is left
// untouched" — is observable only by running the generator, which takes about
// 45 s, and this file is invoked from `run_guard_tests.sh`, whose whole reason
// for existing is that a cheap check should not be held hostage to an
// expensive one. So the behaviour was verified by running the gate and the
// base corpus (recorded on the SCE13 todo), and what is pinned here are the
// three SHAPES whose loss brings the bug back: a buffered call, an
// mtime-only decision, and a stamp that reaches a commit.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL, and one of them only because that was
// checked: F-SCE13-1 was first written as a regex for a tool name near a
// `Process.run(`, which can never match — `_runBridgeTool` takes the script as
// a parameter, so no tool name appears at the call site. Reinstating the bug
// left the guard green. It now reads the launcher method instead.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

/// Body of the class method whose signature contains [signature], from that
/// line to the closing brace of the method.
///
/// The end is found by INDENTATION (`  }`, the class-member level) rather than
/// by counting braces, so a brace inside a string or a comment cannot confuse
/// it.
String _methodBody(String source, String signature) {
  final lines = source.split('\n');
  final start = lines.indexWhere((l) => l.contains(signature));
  expect(
    start,
    isNot(-1),
    reason:
        '`$signature` is gone from send_test_runner.dart. If it was renamed, '
        'retarget this guard; if the bridge step was removed outright, delete '
        'this file and say so in the commit.',
  );
  final end = lines.indexWhere((l) => l == '  }', start + 1);
  expect(end, isNot(-1), reason: 'could not find the end of `$signature`');
  return lines.sublist(start, end + 1).join('\n');
}

void main() {
  final packageRoot = Directory.current.path;
  final runner = File(p.join(packageRoot, 'test', 'send_test_runner.dart'));
  final gate = File(p.join(packageRoot, 'tool', 'bridge_freshness_gate.dart'));

  group('SCE13: the bridge step is visible, content-decided, uncommitted', () {
    test('F-SCE13-1: bridge tools are streamed, never buffered [2026-09-18]', () {
      final source = runner.readAsStringSync();

      // `_runBridgeTool` is the single place a bridge tool is launched, and it
      // takes the script path as a PARAMETER — so the check reads that method
      // rather than looking for a tool name beside a `Process.run(`.
      final launcher = _methodBody(
        source,
        'static Future<int> _runBridgeTool(',
      );

      expect(
        launcher,
        contains('Process.start'),
        reason: 'the bridge launcher no longer starts a streaming subprocess',
      );
      expect(
        launcher.contains('Process.run'),
        isFalse,
        reason:
            'the bridge launcher uses Process.run, which buffers output until '
            'the child exits. The generator prints ~240 lines over ~2 minutes '
            'and none would reach the terminal, so the corpus idle watchdog '
            'kills the file and reports a wedged transport.',
      );
      expect(
        launcher,
        contains('forEach'),
        reason:
            'the output streams are no longer drained line by line, so the '
            'watchdog has nothing to see even though a pipe exists',
      );

      // The caller must go through it rather than spawning its own, or
      // `_runBridgeTool` stops being the one place streaming is guaranteed.
      final ensure = _methodBody(
        source,
        'static Future<void> _ensureBridgesRegenerated()',
      );
      expect(
        RegExp(r'Process\.(run|start)\(').hasMatch(ensure),
        isFalse,
        reason:
            '_ensureBridgesRegenerated spawns a process directly instead of '
            'going through _runBridgeTool',
      );
    });

    test(
      'F-SCE13-2: staleness is settled by content, not mtimes [2026-09-18]',
      () {
        expect(
          gate.existsSync(),
          isTrue,
          reason: 'tool/bridge_freshness_gate.dart is missing',
        );
        expect(
          gate.readAsStringSync(),
          contains('checkBridgeFreshness'),
          reason:
              'the gate no longer asks the generator whether the committed bytes '
              'differ. Mtimes cannot answer that: a pub upgrade moves the '
              'generator to a new cache directory, and every lock change then '
              'reads as stale.',
        );

        final body = _methodBody(
          runner.readAsStringSync(),
          'static Future<void> _ensureBridgesRegenerated()',
        );

        // The mtime check may still run — it is a cheap negative filter — but
        // its "stale" answer must reach the content gate, not a rewrite.
        expect(
          body,
          contains('bridge_freshness_gate.dart'),
          reason: 'the stale path no longer consults the content gate',
        );

        // An unconditional regeneration is allowed only as the
        // D4RT_FORCE_BRIDGE_REGEN escape hatch, which must come first.
        final forcedAt = body.indexOf('_forceBridgeRegenEnv');
        final unconditionalAt = body.indexOf('tool/regenerate_bridges.dart');
        if (unconditionalAt != -1) {
          expect(
            forcedAt,
            allOf(isNot(-1), lessThan(unconditionalAt)),
            reason:
                'an unconditional regeneration appears outside the '
                'D4RT_FORCE_BRIDGE_REGEN escape hatch — that is the mtime-only '
                'rewrite SCE13 removed',
          );
        }
      },
    );

    test('F-SCE13-3: the freshness stamp never reaches a commit [2026-09-18]', () {
      final source = runner.readAsStringSync();
      expect(
        source,
        contains('d4rt_bridge_freshness.stamp'),
        reason:
            'the stamp is gone; without it every corpus file re-runs the '
            'content check, at ~45 s each',
      );

      // The stamp attests to a pub-cache path and a set of mtimes: per-machine
      // facts. Committing it would make one machine's verdict travel to
      // another, where it is not merely stale but meaningless. Directory and
      // file name are asserted together, so moving one cannot pass.
      expect(
        source,
        contains("'.dart_tool', 'd4rt_bridge_freshness.stamp'"),
        reason: 'the stamp must be built under .dart_tool/',
      );

      final ignored = Process.runSync('git', [
        'check-ignore',
        '-q',
        p.join(packageRoot, '.dart_tool', 'd4rt_bridge_freshness.stamp'),
      ], workingDirectory: packageRoot);
      expect(
        ignored.exitCode,
        0,
        reason:
            '.dart_tool/d4rt_bridge_freshness.stamp is not gitignored, so a '
            'machine-local freshness verdict can be committed and then read as '
            'authoritative on a machine it says nothing about',
      );
    });
  });
}
