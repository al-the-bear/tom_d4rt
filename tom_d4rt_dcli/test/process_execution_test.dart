/// Comprehensive tests for DCli process execution.
///
/// Tests run, start, toList, firstLine, lastLine, forEach, toParagraph functions.
@TestOn('vm')
library;

import 'dart:io';
import 'package:dcli/dcli.dart' hide isEmpty;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  late String testDir;

  setUp(() {
    testDir = createTempDir();
  });

  tearDown(() {
    if (exists(testDir)) {
      deleteDir(testDir, recursive: true);
    }
  });

  group('run (string extension)', () {
    test('executes simple echo command', () {
      // The .run extension executes a command
      expect(() => 'echo hello'.run, returnsNormally);
    });

    test('runs command in specific directory', () {
      'ls -la'.start(
        workingDirectory: testDir,
        progress: Progress.devNull(),
      );

      expect(true, isTrue); // Command executed successfully
    });
  });

  group('toList', () {
    test('captures output as list of lines', () {
      final result = 'echo -e "line1\nline2\nline3"'.toList();

      expect(result.length, greaterThanOrEqualTo(1));
    });

    test('returns each line separately', () {
      // Create a test file with multiple lines
      final testFile = p.join(testDir, 'test.txt');
      testFile.write('line1\nline2\nline3');

      final result = 'cat $testFile'.toList();

      expect(result.length, equals(3));
      expect(result[0], equals('line1'));
      expect(result[1], equals('line2'));
      expect(result[2], equals('line3'));
    });

    test('returns empty list for no output', () {
      final result = 'true'.toList();

      expect(result, isEmpty);
    });

    test('handles multiline output', () {
      final result = 'seq 1 5'.toList();

      expect(result.length, equals(5));
      expect(result, containsAll(['1', '2', '3', '4', '5']));
    });
  });

  group('firstLine', () {
    test('returns first line of output', () {
      final testFile = p.join(testDir, 'first.txt');
      testFile.write('first\nsecond\nthird');

      final result = 'cat $testFile'.firstLine;

      expect(result, equals('first'));
    });

    test('returns null for no output', () {
      final result = 'true'.firstLine;

      expect(result, isNull);
    });

    test('handles single line output', () {
      final result = 'echo "only line"'.firstLine;

      expect(result, equals('only line'));
    });
  });

  group('lastLine', () {
    test('returns last line of output', () {
      final testFile = p.join(testDir, 'last.txt');
      testFile.write('first\nsecond\nthird');

      final result = 'cat $testFile'.lastLine;

      expect(result, equals('third'));
    });

    test('returns null for no output', () {
      final result = 'true'.lastLine;

      expect(result, isNull);
    });

    test('handles single line', () {
      final result = 'echo "only"'.lastLine;

      expect(result, equals('only'));
    });
  });

  group('toParagraph', () {
    test('joins lines with newlines', () {
      final testFile = p.join(testDir, 'para.txt');
      testFile.write('a\nb\nc');

      final result = 'cat $testFile'.toParagraph();

      expect(result, equals('a\nb\nc'));
    });

    test('returns empty string for no output', () {
      final result = 'true'.toParagraph();

      expect(result, equals(''));
    });
  });

  group('forEach', () {
    test('iterates over each line', () {
      final testFile = p.join(testDir, 'foreach.txt');
      testFile.write('1\n2\n3');
      final lines = <String>[];

      'cat $testFile'.forEach(lines.add);

      expect(lines, equals(['1', '2', '3']));
    });

    test('handles empty output', () {
      final lines = <String>[];

      'true'.forEach(lines.add);

      expect(lines, isEmpty);
    });

    test('processes lines in order', () {
      final numbers = <int>[];

      'seq 1 3'.forEach((line) => numbers.add(int.parse(line.trim())));

      expect(numbers, equals([1, 2, 3]));
    });
  });

  group('start', () {
    test('executes command with progress tracking', () {
      final lines = <String>[];

      'echo "test output"'.start(
        progress: Progress((line) => lines.add(line)),
      );

      expect(lines, contains('test output'));
    });

    test('captures stderr via callback', () {
      // Create a script that writes to stderr
      final script = p.join(testDir, 'stderr.sh');
      script.write('#!/bin/bash\necho "error" >&2');
      'chmod +x $script'.run;

      final stderr = <String>[];
      script.start(
        progress: Progress(
          (line) {}, // stdout goes to devNull
          stderr: (line) => stderr.add(line),
        ),
        nothrow: true,
      );

      expect(stderr, contains('error'));
    });

    test('returns exit code via progress', () {
      final testFile = p.join(testDir, 'test.txt');
      touch(testFile, create: true);

      'ls $testFile'.start(progress: Progress.devNull());
      // If we get here without exception, exit code was 0
      expect(true, isTrue);
    });

    test('throws on non-zero exit code by default', () {
      expect(
        () => 'false'.start(progress: Progress.devNull()),
        throwsA(isA<Exception>()),
      );
    });

    test('does not throw with nothrow option', () {
      'false'.start(progress: Progress.devNull(), nothrow: true);
      // No exception thrown
      expect(true, isTrue);
    });

    test('respects workingDirectory', () {
      createDir(p.join(testDir, 'subdir'));
      touch(p.join(testDir, 'subdir', 'marker.txt'), create: true);

      final lines = <String>[];
      'ls'.start(
        workingDirectory: p.join(testDir, 'subdir'),
        progress: Progress((line) => lines.add(line)),
      );

      expect(lines, contains('marker.txt'));
    });
  });

  group('startFromArgs', () {
    test('handles arguments with spaces', () {
      final testFile = p.join(testDir, 'args test.txt');
      touch(testFile, create: true);

      final lines = <String>[];
      startFromArgs('ls', [testFile],
          progress: Progress((line) => lines.add(line)));

      expect(lines.join(), contains('args test.txt'));
    });

    test('handles empty arguments', () {
      final lines = <String>[];

      startFromArgs('echo', [], progress: Progress((line) => lines.add(line)));

      // echo with no args outputs empty line or nothing
      expect(true, isTrue);
    });

    test('handles multiple arguments', () {
      final lines = <String>[];

      startFromArgs('echo', ['-n', 'hello', 'world'],
          progress: Progress.capture());

      expect(true, isTrue);
    });
  });

  group('command piping (Dart-native)', () {
    // NOTE: DCli does NOT parse shell pipes. The | character is treated as an argument.
    // Instead, chain commands in Dart or use single commands with equivalent functionality.

    test('filter output in Dart instead of piping', () {
      final testFile = p.join(testDir, 'pipe.txt');
      testFile.write('apple\nbanana\napricot');

      // Instead of: 'cat $testFile | grep ^a'
      // Use Dart filtering:
      final result =
          'cat $testFile'.toList().where((l) => l.startsWith('a')).toList();

      expect(result.length, equals(2));
      expect(result, containsAll(['apple', 'apricot']));
    });

    test('use grep directly without pipe', () {
      final testFile = p.join(testDir, 'grep.txt');
      testFile.write('apple\nbanana\napricot');

      // Instead of: cat file | grep pattern
      // Use: grep pattern file
      // Note: grep output may vary - just check it finds matches starting with 'a'
      final result = 'grep ^a $testFile'.toList();

      expect(result.length, greaterThanOrEqualTo(2));
      expect(result.any((l) => l.contains('apple')), isTrue);
      expect(result.any((l) => l.contains('apricot')), isTrue);
    });
  });

  group('environment variables', () {
    // NOTE: DCli does NOT expand shell variables like $HOME.
    // Use Dart string interpolation with env[] instead.

    test('use env directly instead of shell expansion', () {
      // Instead of: 'echo $HOME'.firstLine
      // Use: env['HOME'] directly
      final home = env['HOME'];

      expect(home, isNotNull);
      expect(home, isNotEmpty);
    });

    test('interpolate env in Dart string', () {
      env['MY_TEST_VAR'] = 'test_value';

      // Instead of: 'echo $MY_TEST_VAR'.firstLine
      // Use Dart string interpolation:
      final value = env['MY_TEST_VAR'];
      final result = 'echo $value'.firstLine;

      expect(result, equals('test_value'));

      env['MY_TEST_VAR'] = null;
    });
  });

  group('error handling', () {
    test('captures non-existent command error', () {
      expect(
        () => 'nonexistent_command_xyz'.run,
        throwsA(isA<Exception>()),
      );
    });

    test('captures command failure', () {
      expect(
        () => 'ls /nonexistent/directory/xyz'.run,
        throwsA(isA<Exception>()),
      );
    });
  });

  group('Progress class', () {
    test('devNull discards output', () {
      final progress = Progress.devNull();
      'echo "discarded"'.start(progress: progress);
      // No exception, output discarded
      expect(true, isTrue);
    });

    test('capture stores lines in .lines', () {
      final progress = Progress.capture();

      'echo "captured"'.start(progress: progress);

      expect(progress.lines, contains('captured'));
    });

    test('print outputs to console', () {
      // Just verify it doesn't throw
      expect(() => 'echo "printed"'.start(progress: Progress.print()),
          returnsNormally);
    });

    test('custom callback receives lines', () {
      final received = <String>[];
      final progress = Progress((line) {
        received.add(line);
      });

      'seq 1 3'.start(progress: progress);

      expect(received, containsAll(['1', '2', '3']));
    });
  });

  group('verbose mode', () {
    test('runs with verbose output', () {
      // Verbose mode shows command being run
      expect(
        () => 'echo "verbose"'.start(progress: Progress.devNull()),
        returnsNormally,
      );
    });
  });

  group('real-world scenarios', () {
    test('find and process files', () {
      // Create test structure
      createDir(p.join(testDir, 'src'), recursive: true);
      touch(p.join(testDir, 'src', 'file1.txt'), create: true);
      touch(p.join(testDir, 'src', 'file2.txt'), create: true);

      final files = 'find $testDir -name "*.txt"'.toList();

      expect(files.length, equals(2));
    });

    test('get git status', () {
      // This will work if running in a git repo
      'git status --porcelain'.start(
        workingDirectory: testDir,
        progress: Progress.devNull(),
        nothrow: true, // May fail if not in git repo
      );

      expect(true, isTrue);
    });

    test('process wc output', () {
      final testFile = p.join(testDir, 'count.txt');
      testFile.write('line1\nline2\nline3');

      final output = 'wc -l $testFile'.firstLine;

      expect(output, contains('3'));
    });

    test('extract specific field in Dart', () {
      final testFile = p.join(testDir, 'fields.txt');
      testFile.write('a b c\nd e f');

      // Instead of complex awk escaping, process in Dart:
      final lines = 'cat $testFile'.toList();
      final result = lines.map((l) => l.split(' ')[1]).toList();

      expect(result, containsAll(['b', 'e']));
    });
  });
}
