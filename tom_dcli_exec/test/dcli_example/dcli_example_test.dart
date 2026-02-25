// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// DCli example integration tests.
///
/// Runs the copied DCli example scripts via the compiled `dclie` binary
/// and verifies they execute without errors.
///
/// Scripts that require interactive input (stdin) or external packages
/// (like `package:args`) are excluded.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Project root for `tom_dcli_exec`.
final _projectRoot = _findProjectRoot();

/// Path to the compiled dclie binary (set during setUpAll).
late final String _dclieBinaryPath;

String _findProjectRoot() {
  var dir = Directory.current;
  while (!File(p.join(dir.path, 'pubspec.yaml')).existsSync()) {
    final parent = dir.parent;
    if (parent.path == dir.path) {
      final fallback = Directory(
        p.join(
          Directory.current.path,
          'xternal',
          'tom_module_d4rt',
          'tom_dcli_exec',
        ),
      );
      if (File(p.join(fallback.path, 'pubspec.yaml')).existsSync()) {
        return fallback.path;
      }
      throw StateError('Could not find tom_dcli_exec project root');
    }
    dir = parent;
  }
  return dir.path;
}

/// Compile the dclie binary if it doesn't exist or is outdated.
Future<String> _ensureDclieBinary() async {
  final binaryPath = p.join(_projectRoot, 'bin', 'dclie');
  final sourcePath = p.join(_projectRoot, 'bin', 'dclie.dart');
  final binary = File(binaryPath);
  final source = File(sourcePath);

  if (!binary.existsSync() ||
      source.lastModifiedSync().isAfter(binary.lastModifiedSync())) {
    final result = await Process.run(
      'dart',
      ['compile', 'exe', sourcePath, '-o', binaryPath],
      workingDirectory: _projectRoot,
    );
    if (result.exitCode != 0) {
      throw StateError('Failed to compile dclie binary:\n${result.stderr}');
    }
  }
  return binaryPath;
}

/// Run a script via the dclie binary and return results.
Future<({String stdout, String stderr, int exitCode})> _runScript(
  String scriptPath, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  final process = await Process.start(
    _dclieBinaryPath,
    [scriptPath],
    workingDirectory: _projectRoot,
  );

  final stdout = await process.stdout
      .transform(utf8.decoder)
      .join()
      .timeout(timeout, onTimeout: () {
    process.kill();
    return '<TIMEOUT>';
  });
  final stderr = await process.stderr
      .transform(utf8.decoder)
      .join()
      .timeout(timeout, onTimeout: () => '<TIMEOUT>');
  final exitCode = await process.exitCode.timeout(
    timeout,
    onTimeout: () {
      process.kill(ProcessSignal.sigkill);
      return -1;
    },
  );

  return (stdout: stdout, stderr: stderr, exitCode: exitCode);
}

void main() {
  setUpAll(() async {
    _dclieBinaryPath = await _ensureDclieBinary();
    print('Using dclie binary: $_dclieBinaryPath');
  });

  group('DCli Scripting Guide Examples', () {
    final scriptDir = p.join(
      _projectRoot,
      'test',
      'dcli_example',
      'dcli_scripting_guide',
    );

    test('01_hello', () async {
      final r = await _runScript(p.join(scriptDir, '01_hello.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Hello from DCli!'));
    });

    test('02_string_as_process', () async {
      final r = await _runScript(p.join(scriptDir, '02_string_as_process.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });

    test('03_colors', () async {
      final r = await _runScript(p.join(scriptDir, '03_colors.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Success!'));
    });

    test('04_file_write', () async {
      final r = await _runScript(p.join(scriptDir, '04_file_write.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('File operations completed!'));
    });

    test('05_progress_capture', () async {
      final r = await _runScript(p.join(scriptDir, '05_progress_capture.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });

    test('06_env_access', () async {
      final r = await _runScript(p.join(scriptDir, '06_env_access.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('HOME:'));
      expect(r.stdout, contains('PATH entries:'));
    });

    test('07_basic_file_ops', () async {
      final r = await _runScript(p.join(scriptDir, '07_basic_file_ops.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Demo completed and cleaned up!'));
    });

    test('10_temp_files', () async {
      final r = await _runScript(p.join(scriptDir, '10_temp_files.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Temp file examples completed!'));
    });

    test('11_find_details', () async {
      final r = await _runScript(p.join(scriptDir, '11_find_details.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Find examples completed!'));
    });

    test('13_cross_platform', () async {
      final r = await _runScript(p.join(scriptDir, '13_cross_platform.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Cross-platform examples completed!'));
    });
  });

  group('DCli Project - tomexample', () {
    final scriptDir = p.join(
      _projectRoot,
      'test',
      'dcli_example',
      'dcli_project',
      'tomexample',
    );

    test('color_output', () async {
      final r = await _runScript(p.join(scriptDir, 'color_output.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });

    test('file_operations', () async {
      final r = await _runScript(p.join(scriptDir, 'file_operations.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });

    test('directory_operations', () async {
      final r = await _runScript(p.join(scriptDir, 'directory_operations.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });
  });

  group('DCli Project - standalone', () {
    final scriptDir = p.join(
      _projectRoot,
      'test',
      'dcli_example',
      'dcli_project',
    );

    test('kill_tomcat', () async {
      final r = await _runScript(p.join(scriptDir, 'kill_tomcat.dart'));
      // This script may exit 0 even if no tomcat found (just prints)
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });
  });

  group('DCli Scripting Guide - Advanced', () {
    final scriptDir = p.join(
      _projectRoot,
      'test',
      'dcli_example',
      'dcli_scripting_guide',
    );

    test('08_command_execution', () async {
      final r = await _runScript(
        p.join(scriptDir, '08_command_execution.dart'),
      );
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Command execution examples completed!'));
    });

    test('12_error_handling', () async {
      final r = await _runScript(
        p.join(scriptDir, '12_error_handling.dart'),
      );
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('All error handling examples completed!'));
    });

    test('14_shell_execution', () async {
      final r = await _runScript(
        p.join(scriptDir, '14_shell_execution.dart'),
      );
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Shell execution examples completed!'));
    });
  });

  group('DCli Project - tomexample (advanced)', () {
    final tomexampleDir = p.join(
      _projectRoot,
      'test',
      'dcli_example',
      'dcli_project',
      'tomexample',
    );

    test('environment', () async {
      final r = await _runScript(
        p.join(tomexampleDir, 'environment.dart'),
      );
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Environment Operations Example Complete'));
    });

    test('process_execution', () async {
      final r = await _runScript(
        p.join(tomexampleDir, 'process_execution.dart'),
        timeout: const Duration(seconds: 60),
      );
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Process Execution Example Complete'));
    });

    test('error_handling', () async {
      final r = await _runScript(
        p.join(tomexampleDir, 'error_handling.dart'),
      );
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
      expect(r.stdout, contains('Error Handling Example Complete'));
    });
  });

  group('DCli Project - standalone (advanced)', () {
    final scriptDir = p.join(
      _projectRoot,
      'test',
      'dcli_example',
      'dcli_project',
    );

    test('redirect', () async {
      final r = await _runScript(p.join(scriptDir, 'redirect.dart'));
      expect(r.exitCode, 0, reason: 'stderr: ${r.stderr}');
    });
  });
}
