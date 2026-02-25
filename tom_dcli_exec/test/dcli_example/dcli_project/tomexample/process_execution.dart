/// DCli Process Execution Example
///
/// Demonstrates run, start, toList, firstLine, lastLine, forEach functions.
///
/// Run with: dart run tomexample/process_execution.dart
library;

import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

void main() {
  print('=== DCli Process Execution Examples ===\n');

  final tempDir = createTempDir();
  print('Working in: $tempDir\n');

  try {
    // 1. Simple command execution with .run
    print('--- 1. Simple Command Execution ---');
    'echo "Hello from DCli!"'.run;

    // 2. Capture output as list
    print('\n--- 2. Capture Output as List ---');
    final dateOutput = 'date'.toList();
    print('Date command output: ${dateOutput.first}');

    // 3. First and last line
    print('\n--- 3. First and Last Line ---');
    final testFile = p.join(tempDir, 'lines.txt');
    testFile.write('First line\nMiddle line\nLast line');

    print('First line: ${'cat $testFile'.firstLine}');
    print('Last line: ${'cat $testFile'.lastLine}');

    // 4. Iterate with forEach
    print('\n--- 4. Iterate with forEach ---');
    print('All lines:');
    'cat $testFile'.forEach((line) => print('  > $line'));

    // 5. toParagraph - join all output
    print('\n--- 5. Join Output with toParagraph ---');
    final paragraph = 'cat $testFile'.toParagraph();
    print('Combined output:\n$paragraph');

    // 6. Progress tracking
    print('\n--- 6. Progress Tracking ---');
    final lines = <String>[];
    'seq 1 5'.start(progress: Progress((line) {
      lines.add(line);
    }));
    print('Captured ${lines.length} lines: ${lines.join(", ")}');

    // 7. Capture stdout and stderr
    print('\n--- 7. Separate stdout/stderr ---');
    final script = p.join(tempDir, 'mixed.sh');
    script.write('''
#!/bin/bash
echo "This goes to stdout"
echo "This goes to stderr" >&2
echo "More stdout"
''');
    'chmod 755 $script'.run;

    final stdout = <String>[];
    final stderr = <String>[];
    script.start(
      progress: Progress(
        (line) => stdout.add(line),
        stderr: (line) => stderr.add(line),
      ),
    );
    print('stdout: $stdout');
    print('stderr: $stderr');

    // 8. Working directory
    print('\n--- 8. Working Directory ---');
    final subdir = p.join(tempDir, 'subdir');
    createDir(subdir);
    touch(p.join(subdir, 'marker.txt'), create: true);

    final files = <String>[];
    'ls'.start(
      workingDirectory: subdir,
      progress: Progress((line) => files.add(line)),
    );
    print('Files in subdir: ${files.join(", ")}');

    // 9. Command piping (using shell)
    print('\n--- 9. Command Piping ---');
    final dataFile = p.join(tempDir, 'data.txt');
    dataFile.write('apple\nbanana\napricot\ncherry\navocado');

    print('Fruits starting with "a":');
    // Use grep directly to filter
    'grep "^a" $dataFile'.forEach((line) => print('  $line'));

    // 10. Exit code handling
    print('\n--- 10. Exit Code Handling ---');
    try {
      'false'.run; // This command always returns exit code 1
    } catch (e) {
      print('Command failed as expected (false returns 1)');
    }

    // With nothrow
    'false'.start(progress: Progress.devNull(), nothrow: true);
    print('Used nothrow to ignore failure');

    // 11. Environment variables in commands
    print('\n--- 11. Environment Variables ---');
    print('HOME: ${'echo \$HOME'.firstLine}');
    print('USER: ${'echo \$USER'.firstLine}');

    // 12. startFromArgs for safe argument handling
    print('\n--- 12. Safe Argument Handling ---');
    final fileWithSpace = p.join(tempDir, 'file with space.txt');
    touch(fileWithSpace, create: true);

    final found = <String>[];
    startFromArgs('ls', ['-la', fileWithSpace],
        progress: Progress((line) => found.add(line)));
    print('Found file with space in name: ${found.isNotEmpty}');

    // 13. Process multiple files
    print('\n--- 13. Process Multiple Files ---');
    for (var i = 1; i <= 3; i++) {
      final file = p.join(tempDir, 'file$i.txt');
      touch(file, create: true);
    }

    print('Listing all txt files:');
    'find $tempDir -name "*.txt" -type f'.forEach((line) {
      print('  ${p.basename(line)}');
    });

    // 14. Background-style execution
    print('\n--- 14. Using devNull for Silent Execution ---');
    'sleep 0.1'.start(progress: Progress.devNull());
    print('Silent command completed');

    // 15. Count lines with wc
    print('\n--- 15. Count Lines ---');
    final countFile = p.join(tempDir, 'count.txt');
    countFile.write('1\n2\n3\n4\n5\n6\n7\n8\n9\n10');
    final lineCount = 'wc -l $countFile'.firstLine?.trim().split(' ').first;
    print('File has $lineCount lines');

    // 16. Extract fields (using Dart for complex parsing)
    print('\n--- 16. Extract Fields ---');
    final csvFile = p.join(tempDir, 'data.csv');
    csvFile.write('name,age,city\nAlice,30,NYC\nBob,25,LA\nCarol,35,Chicago');

    print('Names from CSV (using Dart):');
    read(csvFile).toList().skip(1).forEach((line) {
      final name = line.split(',').first;
      print('  $name');
    });

    // 17. Check command existence
    print('\n--- 17. Check Command Existence ---');
    final commands = ['ls', 'git', 'nonexistent_xyz'];
    for (final cmd in commands) {
      final available = isOnPATH(cmd);
      print('  $cmd: ${available ? "✓" : "✗"}');
    }

    // 18. Get filesystem info
    print('\n--- 18. Filesystem Info ---');
    final dfOutput = 'df -h $tempDir'.toList();
    if (dfOutput.isNotEmpty) {
      print('Disk usage header: ${dfOutput.first}');
      if (dfOutput.length > 1) {
        print('Temp dir disk: ${dfOutput[1]}');
      }
    }
  } finally {
    // Cleanup
    print('\n--- Cleanup ---');
    deleteDir(tempDir, recursive: true);
    print('Removed temp directory');
  }

  print('\n=== Process Execution Example Complete ===');
}
