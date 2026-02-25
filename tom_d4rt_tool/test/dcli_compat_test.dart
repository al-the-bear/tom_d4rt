/// DCli compatibility tests run via d4rt.
///
/// Runs the DCli `.dcli` replay files from `tom_d4rt_dcli/test/replay/`
/// using the d4rt binary to verify backward compatibility.
/// D4rt must be able to run all DCli replay files without errors.
///
/// ## Limitations
///
/// D4rt replay mode does not support `import` statements. Most DCli test
/// files contain imports which cause parse errors. These tests are skipped
/// with `skip: 'D4rt replay does not support imports'`.
///
/// Only `test_dcli_basics.dcli` has no imports and can be run via D4rt.
///
/// Run with: `dart test test/dcli_compat_test.dart`
@TestOn('vm')
@Timeout(Duration(minutes: 5))
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'replay_test_helper.dart';

/// Path to the DCli replay test directory.
final String _dcliTestDir = p.normalize(p.join(
  Directory.current.path,
  '../../xternal/tom_module_d4rt/tom_d4rt_dcli/test/replay',
));

void main() {
  late ReplayTestHelper helper;

  setUpAll(() async {
    helper = ReplayTestHelper(projectPath: Directory.current.path);

    // If binary already exists (built by d4rt_replay_test or manual d4rtgen),
    // mark as prepared directly. Otherwise, generate + compile.
    if (File(helper.binaryPath).existsSync()) {
      helper.markPrepared();
    } else {
      final ok = await helper.prepare();
      expect(ok, isTrue,
          reason: 'Preparation failed: '
              '${helper.preparationError ?? "unknown"}');
    }
  });

  // No cleanup — shared binary with d4rt_replay_test

  group('DCli compatibility', () {
    test('basics', () async {
      final result = await helper.runReplay(
        p.join(_dcliTestDir, 'test_dcli_basics.dcli'),
      );
      expect(result.success, isTrue, reason: result.failureReason);
    });

    test(
      'classes',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_classes.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'collections',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_collections.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'core',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_core.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'datetime',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_datetime.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'filesystem',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_filesystem.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'functions',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_functions.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'io',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_io.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'json',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_json.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'math',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_math.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'multiline',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_multiline.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'platform',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_platform.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );

    test(
      'strings',
      skip: 'D4rt replay does not support imports',
      () async {
        final result = await helper.runReplay(
          p.join(_dcliTestDir, 'test_dcli_strings.dcli'),
        );
        expect(result.success, isTrue, reason: result.failureReason);
      },
    );
  });
}
