/// DCli Error Handling Example
///
/// Demonstrates exception handling for DCli operations.
///
/// Run with: dart run tomexample/error_handling.dart
library;

import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

void main() {
  print('=== DCli Error Handling Examples ===\n');

  final tempDir = createTempDir();

  try {
    // 1. File not found
    print('--- 1. File Not Found ---');
    try {
      read('/nonexistent/file.txt').toList();
    } on ReadException catch (e) {
      print('Caught ReadException: ${e.message}');
    }

    // 2. Delete non-existent file
    print('\n--- 2. Delete Non-Existent File ---');
    try {
      delete('/nonexistent/file.txt');
    } on DeleteException catch (e) {
      print('Caught DeleteException: ${e.message}');
    }

    // 3. Create directory without recursive
    print('\n--- 3. Create Nested Directory Without Recursive ---');
    try {
      createDir(p.join(tempDir, 'a', 'b', 'c'), recursive: false);
    } on CreateDirException catch (e) {
      print('Caught CreateDirException: ${e.message}');
    }

    // 4. Copy to invalid destination
    print('\n--- 4. Copy to Invalid Destination ---');
    final sourceFile = p.join(tempDir, 'source.txt');
    touch(sourceFile, create: true);
    try {
      copy(sourceFile, '/nonexistent/dir/dest.txt');
    } on CopyException catch (e) {
      print('Caught CopyException: ${e.message}');
    }

    // 5. Move non-existent file
    print('\n--- 5. Move Non-Existent File ---');
    try {
      move('/nonexistent/source.txt', p.join(tempDir, 'dest.txt'));
    } on CopyException catch (e) {
      // move() uses copy() internally, so throws CopyException
      print('Caught CopyException (from move): ${e.message}');
    }

    // 6. Command execution failure
    print('\n--- 6. Command Execution Failure ---');
    try {
      'nonexistent_command_xyz'.run;
    } on RunException catch (e) {
      print('Caught RunException: exit code ${e.exitCode}');
    }

    // 7. Command with non-zero exit
    print('\n--- 7. Non-Zero Exit Code ---');
    try {
      'ls /nonexistent/directory/xyz'.run;
    } on RunException catch (e) {
      print('Caught RunException: exit code ${e.exitCode}');
    }

    // 8. Using nothrow option
    print('\n--- 8. Using nothrow Option ---');
    'false'.start(progress: Progress.devNull(), nothrow: true);
    print('Command completed with nothrow (no exception thrown)');

    // 9. Delete non-empty directory without recursive
    print('\n--- 9. Delete Non-Empty Directory ---');
    final nonEmpty = p.join(tempDir, 'nonempty');
    createDir(nonEmpty);
    touch(p.join(nonEmpty, 'file.txt'), create: true);
    try {
      deleteDir(nonEmpty, recursive: false);
    } on DeleteDirException catch (e) {
      print('Caught DeleteDirException: ${e.message}');
    }
    // Cleanup
    deleteDir(nonEmpty, recursive: true);

    // 10. Move directory that doesn't exist
    print('\n--- 10. Move Non-Existent Directory ---');
    try {
      moveDir('/nonexistent/dir', p.join(tempDir, 'dest'));
    } on MoveDirException catch (e) {
      print('Caught MoveDirException: ${e.message}');
    }

    // 11. Generic exception handling
    print('\n--- 11. Generic Exception Handling ---');
    try {
      read('/root/protected_file.txt').toList();
    } on DCliException catch (e) {
      print('Caught DCliException: ${e.message}');
    } catch (e) {
      print('Caught generic exception: $e');
    }

    // 12. Safe file operations pattern
    print('\n--- 12. Safe File Operations Pattern ---');
    String? safeRead(String path) {
      if (!exists(path)) {
        print('File does not exist: $path');
        return null;
      }
      if (!isReadable(path)) {
        print('File is not readable: $path');
        return null;
      }
      try {
        return read(path).toList().join('\n');
      } on DCliException catch (e) {
        print('Error reading file: ${e.message}');
        return null;
      }
    }

    final testFile = p.join(tempDir, 'test.txt');
    testFile.write('Safe content');
    final content = safeRead(testFile);
    print('Safe read result: $content');

    safeRead('/nonexistent/file.txt');

    // 13. Safe command execution pattern
    print('\n--- 13. Safe Command Execution Pattern ---');
    List<String>? safeRun(String command) {
      try {
        return command.toList();
      } on RunException catch (e) {
        print('Command failed: ${e.cmdLine}');
        print('Exit code: ${e.exitCode}');
        return null;
      }
    }

    final result1 = safeRun('echo "hello"');
    print('Safe run result: $result1');

    final result2 = safeRun('nonexistent_xyz');
    print('Failed run result: $result2');

    // 14. Retry pattern
    print('\n--- 14. Retry Pattern ---');
    T? withRetry<T>(T Function() operation, int maxRetries) {
      for (var i = 0; i < maxRetries; i++) {
        try {
          return operation();
        } catch (e) {
          print('Attempt ${i + 1} failed: $e');
          if (i == maxRetries - 1) rethrow;
        }
      }
      return null;
    }

    try {
      withRetry(() => throw Exception('Always fails'), 3);
    } catch (e) {
      print('All retries exhausted');
    }

    // 15. Cleanup on error pattern
    print('\n--- 15. Cleanup on Error ---');
    void processFile(String inputPath, String outputPath) {
      final tempPath = createTempFile();
      try {
        // Simulate processing
        if (!exists(inputPath)) {
          throw FileNotFoundException(inputPath);
        }
        copy(inputPath, tempPath);
        // ... more processing ...
        move(tempPath, outputPath);
      } catch (e) {
        // Cleanup temp file on error
        if (exists(tempPath)) {
          delete(tempPath);
        }
        rethrow;
      }
    }

    try {
      processFile('/nonexistent/input.txt', p.join(tempDir, 'output.txt'));
    } on FileNotFoundException {
      print('Handled FileNotFoundException with cleanup');
    }
  } finally {
    // Final cleanup
    print('\n--- Cleanup ---');
    deleteDir(tempDir, recursive: true);
    print('Removed temp directory');
  }

  print('\n=== Error Handling Example Complete ===');
}
