/// D4rt replay integration tests.
///
/// Wraps the `.d4rt` replay files in `test/replay/` as Dart tests.
/// Each test runs a replay file against the compiled d4rt binary and
/// asserts that all verifications pass (exit code 0).
///
/// ## Test flow
///
/// 1. `setUpAll` — generates bridges via d4rtgen, compiles `bin/d4rt_test`
/// 2. Each test — runs `d4rt_test -run-replay <file> -test`
/// 3. `tearDownAll` — removes the temporary binary
///
/// Run with: `dart test test/d4rt_replay_test.dart`
@TestOn('vm')
@Timeout(Duration(minutes: 5))
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'replay_test_helper.dart';

void main() {
  late ReplayTestHelper helper;

  setUpAll(() async {
    helper = ReplayTestHelper(projectPath: Directory.current.path);

    // If binary already exists (from a previous run or manual build),
    // skip the expensive generation + compilation step.
    if (File(p.join(helper.projectPath, 'bin', 'd4rt_test')).existsSync()) {
      helper.markPrepared();
    } else {
      final ok = await helper.prepare();
      expect(ok, isTrue,
          reason: 'Bridge generation or compilation failed: '
              '${helper.preparationError ?? "unknown"}');
    }
  });

  tearDownAll(() {
    helper.cleanup();
  });

  // ── D4rt Language Features ─────────────────────────────────────────

  group('D4rt language', () {
    test('basics — types, expressions, arithmetic, strings, lists', () async {
      final result =
          await helper.runReplay('test/replay/test_d4rt_basics.d4rt');
      expect(result.success, isTrue, reason: result.failureReason);
    });

    test(
      'regexp — regular expressions and pattern matching',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_regexp.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'context — context patterns and exception handling',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_context.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'observable — custom classes and interface patterns',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_observable.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  // ── Bridge Framework ───────────────────────────────────────────────

  group('bridges', () {
    test(
      'bridge types and functionality',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_bridges.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'tom types — TomCore type classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_types.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'tom http — TomMimeType, TomHttpMethod',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_http.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  // ── DCli Bridges ───────────────────────────────────────────────────

  group('dcli', () {
    test(
      'dcli classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_dcli_classes.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'dcli core classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_dcli_core.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'terminal and ANSI classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_terminal.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  // ── Tom Framework Bridges ─────────────────────────────────────────

  group('tom_basics', () {
    test(
      'TomBasics — tomLog, TomLogLevel, TomPlatform',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_basics.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'tom_basics_network classes',
      () async {
        final result = await helper.runReplay(
          'test/replay/test_d4rt_tom_basics_network.d4rt',
          timeout: const Duration(seconds: 60),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_core', () {
    test(
      'tom_core_kernel classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_core_kernel.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'tom_core_server classes',
      () async {
        final result = await helper
            .runReplay('test/replay/test_d4rt_tom_core_server.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_build', () {
    test(
      'tom_build classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_build.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_crypto', () {
    test(
      'tom_crypto classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_crypto.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_reflection', () {
    test(
      'tom_reflection classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_reflection.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_dist_ledger', () {
    test(
      'tom_dist_ledger classes',
      () async {
        final result = await helper
            .runReplay('test/replay/test_d4rt_tom_dist_ledger.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_process_monitor', () {
    test(
      'tom_process_monitor classes',
      () async {
        final result = await helper
            .runReplay('test/replay/test_d4rt_tom_process_monitor.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });

  group('tom_vscode', () {
    test(
      'tom_vscode_scripting_api classes',
      () async {
        final result =
            await helper.runReplay('test/replay/test_d4rt_tom_vscode.d4rt');
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });
}
