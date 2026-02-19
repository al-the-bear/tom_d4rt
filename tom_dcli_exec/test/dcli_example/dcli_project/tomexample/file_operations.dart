/// DCli File Operations Example
///
/// Demonstrates copy, move, delete, touch, cat, read, head, tail, replace functions.
///
/// Run with: dart run tomexample/file_operations.dart
library;

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

void main() {
  print('=== DCli File Operations Examples ===\n');

  // Create a temporary directory for demonstrations
  final tempDir = createTempDir();
  print('Working in: $tempDir\n');

  try {
    // 1. Creating files with touch
    print('--- 1. Creating Files with touch ---');
    final file1 = p.join(tempDir, 'file1.txt');
    touch(file1, create: true);
    print('Created: $file1');
    print('Exists: ${exists(file1)}');

    // 2. Writing content
    print('\n--- 2. Writing Content ---');
    file1.write('Line 1\nLine 2\nLine 3\nLine 4\nLine 5');
    print('Wrote 5 lines to file1.txt');

    // 3. Reading content with cat
    print('\n--- 3. Reading with cat ---');
    print('Contents:');
    cat(file1);

    // 4. Reading as list
    print('\n--- 4. Reading as list ---');
    final lines = read(file1).toList();
    print('Read ${lines.length} lines');
    for (var i = 0; i < lines.length; i++) {
      print('  [$i]: ${lines[i]}');
    }

    // 5. Head - first N lines
    print('\n--- 5. head - First 2 lines ---');
    head(file1, 2).forEach(print);

    // 6. Tail - last N lines
    print('\n--- 6. tail - Last 2 lines ---');
    tail(file1, 2).forEach(print);

    // 7. Copying files
    print('\n--- 7. Copying Files ---');
    final file2 = p.join(tempDir, 'file2.txt');
    copy(file1, file2);
    print('Copied $file1 to $file2');
    print('file2 exists: ${exists(file2)}');

    // 8. Moving files
    print('\n--- 8. Moving Files ---');
    final file3 = p.join(tempDir, 'file3.txt');
    move(file2, file3);
    print('Moved file2.txt to file3.txt');
    print('file2 exists: ${exists(file2)}');
    print('file3 exists: ${exists(file3)}');

    // 9. Appending content
    print('\n--- 9. Appending Content ---');
    file3.append('Line 6 (appended)');
    print('Appended line to file3.txt');
    print('Last line: ${read(file3).toList().last}');

    // 10. Replace content
    print('\n--- 10. Replacing Content ---');
    replace(file3, RegExp(r'Line \d'), 'Modified');
    print('Replaced "Line X" with "Modified"');
    cat(file3);

    // 11. Creating multiple files
    print('\n--- 11. Creating Multiple Files ---');
    for (var i = 1; i <= 3; i++) {
      final path = p.join(tempDir, 'data$i.txt');
      touch(path, create: true);
      path.write('Data file $i');
    }
    print('Created 3 data files');

    // 12. Deleting files
    print('\n--- 12. Deleting Files ---');
    delete(file1);
    print('Deleted file1.txt');
    print('file1 exists: ${exists(file1)}');

    // 13. Copy tree
    print('\n--- 13. Copy Tree ---');
    final sourceDir = p.join(tempDir, 'source');
    final destDir = p.join(tempDir, 'dest');
    createDir(sourceDir);
    createDir(destDir); // Destination must exist
    touch(p.join(sourceDir, 'a.txt'), create: true);
    touch(p.join(sourceDir, 'b.txt'), create: true);
    copyTree(sourceDir, destDir);
    print('Copied directory tree');
    print('Files in dest:');
    find('*', workingDirectory: destDir)
        .forEach((f) => print('  ${p.basename(f)}'));

    // 14. File info
    print('\n--- 14. File Information ---');
    final infoFile = p.join(tempDir, 'data1.txt');
    print('File: $infoFile');
    print('  isFile: ${isFile(infoFile)}');
    print('  isDirectory: ${isDirectory(infoFile)}');
    print('  isReadable: ${isReadable(infoFile)}');
    print('  isWritable: ${isWritable(infoFile)}');

    final stat = File(infoFile).statSync();
    print('  Size: ${stat.size} bytes');
    print('  Modified: ${stat.modified}');

    // 15. Reading with filter
    print('\n--- 15. Reading with Filter ---');
    final filterFile = p.join(tempDir, 'filter.txt');
    filterFile.write('apple\nbanana\napricot\ncherry\navocado');
    print('Lines starting with "a":');
    read(filterFile)
        .toList()
        .where((line) => line.startsWith('a'))
        .forEach((line) => print('  $line'));
  } finally {
    // Cleanup
    print('\n--- Cleanup ---');
    deleteDir(tempDir, recursive: true);
    print('Removed temp directory');
  }

  print('\n=== File Operations Example Complete ===');
}
