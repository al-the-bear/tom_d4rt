// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Stdin smart preprocessing integration tests.
///
/// These tests exercise the `--stdin` flag end-to-end by spawning `dcli`
/// as a subprocess and piping source code into it.  A companion shell script
/// (`test/stdin/test_stdin.sh`) runs the full matrix; this Dart test both
/// executes that script AND runs individual focused assertions directly
/// via `Process.start`.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Project root for `tom_dcli_exec`.
final _projectRoot = _findProjectRoot();

String _findProjectRoot() {
  // When run via `dart test`, Platform.script is a data: URI, so we
  // walk up from the current working directory instead.
  var dir = Directory.current;
  while (!File(p.join(dir.path, 'pubspec.yaml')).existsSync()) {
    final parent = dir.parent;
    if (parent.path == dir.path) {
      // Last resort: try a well-known relative path from the workspace root
      final fallback = Directory(p.join(
        Directory.current.path,
        'xternal', 'tom_module_d4rt', 'tom_dcli_exec',
      ));
      if (File(p.join(fallback.path, 'pubspec.yaml')).existsSync()) {
        return fallback.path;
      }
      throw StateError('Could not find tom_dcli_exec project root');
    }
    dir = parent;
  }
  return dir.path;
}

/// Run `dcli --stdin` with the given [input] and return a result record.
Future<({String stdout, String stderr, int exitCode})> runDcliStdin(
  String input,
) async {
  final process = await Process.start(
    'dart',
    ['run', 'bin/dcli.dart', '--stdin'],
    workingDirectory: _projectRoot,
  );
  process.stdin.writeln(input);
  await process.stdin.close();

  final stdout = await process.stdout.transform(utf8.decoder).join();
  final stderr = await process.stderr.transform(utf8.decoder).join();
  final exitCode = await process.exitCode;

  return (stdout: stdout, stderr: stderr, exitCode: exitCode);
}

void main() {
  // Give each spawned process plenty of time for JIT compile + bridges init.
  const processTimeout = Timeout(Duration(seconds: 120));

  group('stdin shell script', () {
    test(
      'test_stdin.sh passes all checks',
      () async {
        final scriptPath = p.join(_projectRoot, 'test', 'stdin', 'test_stdin.sh');
        final result = await Process.run(
          'bash',
          [scriptPath, _projectRoot],
          workingDirectory: _projectRoot,
        );

        // Print full output so CI logs are useful on failure.
        if (result.stdout.toString().isNotEmpty) {
          // ignore: avoid_print
          print(result.stdout);
        }
        if (result.stderr.toString().isNotEmpty) {
          // ignore: avoid_print
          print('STDERR:\n${result.stderr}');
        }
        expect(result.exitCode, 0, reason: 'test_stdin.sh reported failures');
      },
      timeout: const Timeout(Duration(minutes: 10)),
    );
  });

  group('stdin preprocessing — bare statements', () {
    test('should print output and exit 0', () async {
      final r = await runDcliStdin('print("hello stdin");');
      expect(r.exitCode, 0);
      expect(r.stdout, contains('hello stdin'));
    }, timeout: processTimeout);

    test('should use int return as exit code', () async {
      final r = await runDcliStdin('return 42;');
      expect(r.exitCode, 42);
    }, timeout: processTimeout);

    test('should auto-import dart:math (stdlib bridge)', () async {
      final r = await runDcliStdin('print(max(3, 7));');
      expect(r.exitCode, 0);
      expect(r.stdout.trim(), contains('7'));
    }, timeout: processTimeout);

    test('should auto-import dart:io', () async {
      final r = await runDcliStdin('print(Platform.operatingSystem);');
      expect(r.exitCode, 0);
      expect(r.stdout.trim(), isNotEmpty);
    }, timeout: processTimeout);
  });

  group('stdin preprocessing — main without imports', () {
    test('should execute void main and exit 0', () async {
      final r = await runDcliStdin('''void main() {
  print("from main");
}''');
      expect(r.exitCode, 0);
      expect(r.stdout, contains('from main'));
    }, timeout: processTimeout);

    test('should auto-prefix imports for bridge usage', () async {
      final r = await runDcliStdin('''Object main(List<String> args) {
  print(max(5, 9));
  return 0;
}''');
      expect(r.exitCode, 0);
      expect(r.stdout.trim(), contains('9'));
    }, timeout: processTimeout);

    test('should use int return from main as exit code', () async {
      final r = await runDcliStdin('''int main() {
  return 7;
}''');
      expect(r.exitCode, 7);
    }, timeout: processTimeout);
  });

  group('stdin preprocessing — complete script', () {
    test('should execute complete script as-is', () async {
      final r = await runDcliStdin("""import 'dart:math';
void main() {
  print(max(100, 200));
}""");
      expect(r.exitCode, 0);
      expect(r.stdout.trim(), contains('200'));
    }, timeout: processTimeout);
  });

  group('stdin error handling', () {
    test('should exit 1 on empty stdin', () async {
      final process = await Process.start(
        'dart',
        ['run', 'bin/dcli.dart', '--stdin'],
        workingDirectory: _projectRoot,
      );
      // Close stdin immediately with no input
      await process.stdin.close();
      final exitCode = await process.exitCode;
      final stderr = await process.stderr.transform(utf8.decoder).join();
      expect(exitCode, 1);
      expect(stderr, contains('No input'));
    }, timeout: processTimeout);

    test('should exit 2 on runtime error', () async {
      final r = await runDcliStdin('print(undefinedVariable123);');
      expect(r.exitCode, 2);
    }, timeout: processTimeout);
  });
}
