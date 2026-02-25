/// DCli Directory Operations Example
///
/// Demonstrates createDir, deleteDir, find, exists, isDirectory functions.
///
/// Run with: dart run tomexample/directory_operations.dart
library;

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

void main() {
  print('=== DCli Directory Operations Examples ===\n');

  final tempDir = createTempDir();
  print('Working in: $tempDir\n');

  try {
    // 1. Creating directories
    print('--- 1. Creating Directories ---');
    final dir1 = p.join(tempDir, 'mydir');
    createDir(dir1);
    print('Created: $dir1');
    print('Is directory: ${isDirectory(dir1)}');
    print('Is empty: ${isEmpty(dir1)}');

    // 2. Creating nested directories
    print('\n--- 2. Nested Directories ---');
    final nested = p.join(tempDir, 'a', 'b', 'c', 'd');
    createDir(nested, recursive: true);
    print('Created nested: $nested');
    print('Exists: ${exists(nested)}');

    // 3. Populating with files
    print('\n--- 3. Populating Directories ---');
    final projectDir = p.join(tempDir, 'project');
    createDir(p.join(projectDir, 'lib', 'src'), recursive: true);
    createDir(p.join(projectDir, 'test'));
    createDir(p.join(projectDir, 'bin'));

    // Create files
    touch(p.join(projectDir, 'pubspec.yaml'), create: true);
    touch(p.join(projectDir, 'lib', 'main.dart'), create: true);
    touch(p.join(projectDir, 'lib', 'src', 'widget.dart'), create: true);
    touch(p.join(projectDir, 'lib', 'src', 'helper.dart'), create: true);
    touch(p.join(projectDir, 'test', 'main_test.dart'), create: true);
    touch(p.join(projectDir, 'bin', 'cli.dart'), create: true);

    print('Created project structure with files');

    // 4. Find files by pattern
    print('\n--- 4. Finding Files ---');
    print('All .dart files:');
    find('*.dart', workingDirectory: projectDir, recursive: true)
        .forEach((f) => print('  ${p.relative(f, from: projectDir)}'));

    // 5. Find with types
    print('\n--- 5. Finding Directories ---');
    print('All directories:');
    find('*',
            workingDirectory: projectDir,
            recursive: true,
            types: [FileSystemEntityType.directory])
        .forEach((f) => print('  ${p.relative(f, from: projectDir)}/'));

    // 6. Find with case insensitive
    print('\n--- 6. Case-insensitive Find ---');
    touch(p.join(projectDir, 'README.md'), create: true);
    touch(p.join(projectDir, 'readme.txt'), create: true);
    print('Files matching readme (case-insensitive):');
    find('readme*', workingDirectory: projectDir, caseSensitive: false)
        .forEach((f) => print('  ${p.basename(f)}'));

    // 7. Listing directory contents
    print('\n--- 7. Listing Contents ---');
    print('Contents of project/:');
    Directory(projectDir).listSync().forEach((entity) {
      final name = p.basename(entity.path);
      final type = entity is Directory ? 'DIR ' : 'FILE';
      print('  [$type] $name');
    });

    // 8. Check directory properties
    print('\n--- 8. Directory Properties ---');
    print('project/lib:');
    final libDir = p.join(projectDir, 'lib');
    print('  exists: ${exists(libDir)}');
    print('  isDirectory: ${isDirectory(libDir)}');
    print('  isFile: ${isFile(libDir)}');
    print('  isEmpty: ${isEmpty(libDir)}');
    print('  isReadable: ${isReadable(libDir)}');
    print('  isWritable: ${isWritable(libDir)}');
    print('  isExecutable: ${isExecutable(libDir)}');

    // 9. Working with hidden directories
    print('\n--- 9. Hidden Directories ---');
    final hiddenDir = p.join(projectDir, '.config');
    createDir(hiddenDir);
    touch(p.join(hiddenDir, 'settings.json'), create: true);
    print('Created hidden directory: .config/');

    print('Hidden files (with includeHidden):');
    find('*',
            workingDirectory: projectDir, includeHidden: true, recursive: false)
        .toList()
        .where((f) => p.basename(f).startsWith('.'))
        .forEach((f) => print('  ${p.basename(f)}'));

    // 10. Count files
    print('\n--- 10. Counting Files ---');
    final dartFileCount =
        find('*.dart', workingDirectory: projectDir, recursive: true)
            .toList()
            .length;
    print('Total .dart files: $dartFileCount');

    // 11. Move directory
    print('\n--- 11. Moving Directories ---');
    final srcDir = p.join(tempDir, 'source');
    final dstDir = p.join(tempDir, 'destination');
    createDir(srcDir);
    touch(p.join(srcDir, 'file.txt'), create: true);

    moveDir(srcDir, dstDir);
    print('Moved source/ to destination/');
    print('source exists: ${exists(srcDir)}');
    print('destination exists: ${exists(dstDir)}');

    // 12. Copy directory tree
    print('\n--- 12. Copying Directory Trees ---');
    final backupDir = p.join(tempDir, 'backup');
    createDir(backupDir); // Destination must exist
    copyTree(projectDir, backupDir);
    print('Copied project/ to backup/');

    final backupDartFiles =
        find('*.dart', workingDirectory: backupDir, recursive: true)
            .toList()
            .length;
    print('Dart files in backup: $backupDartFiles');

    // 13. Delete non-empty directory
    print('\n--- 13. Deleting Directories ---');
    deleteDir(backupDir, recursive: true);
    print('Deleted backup/ recursively');
    print('backup exists: ${exists(backupDir)}');

    // 14. Temp directory operations
    print('\n--- 14. Temp Directory Operations ---');
    final customTemp = createTempDir();
    print('Created temp dir: $customTemp');

    // Use withTempDir for automatic cleanup
    withTempDirAsync((dir) async {
      print('Working in auto-cleanup dir: $dir');
      touch(p.join(dir, 'temp.txt'), create: true);
      // Directory cleaned up after this block
    });

    deleteDir(customTemp);

    // 15. Path operations with directories
    print('\n--- 15. Path Operations ---');
    final somePath = p.join(projectDir, 'lib', 'src', 'widget.dart');
    print('Full path: $somePath');
    print('Directory: ${p.dirname(somePath)}');
    print('Filename: ${p.basename(somePath)}');
    print('Extension: ${p.extension(somePath)}');
  } finally {
    // Cleanup
    print('\n--- Cleanup ---');
    deleteDir(tempDir, recursive: true);
    print('Removed temp directory');
  }

  print('\n=== Directory Operations Example Complete ===');
}
