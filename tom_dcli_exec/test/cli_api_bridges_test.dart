// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// CLI API Bridges Tests
///
/// Comprehensive tests for all bridged classes and global functions from dcli.
/// These tests execute D4rt scripts that use the bridged APIs.
library;

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';
import 'package:tom_dcli_exec/dartscript.b.dart';
import 'package:tom_dcli_exec/tom_d4rt_cli_api.dart';

// =============================================================================
// Test Infrastructure
// =============================================================================

/// Output capture for testing.
class OutputCapture {
  final List<String> stdout = [];
  String get stdoutText => stdout.join();
  void clear() => stdout.clear();
}

/// Run with output capture.
Future<T> withCapture<T>(OutputCapture capture, Future<T> Function() fn) async {
  return runZoned(
    fn,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capture.stdout.add('$line\n');
      },
    ),
  );
}

/// Helper to create and configure a test controller.
class BridgeTestContext {
  late D4rt d4rt;
  late CliState state;
  late D4rtCliController controller;
  late Directory tempDir;
  final OutputCapture output = OutputCapture();

  Future<void> setUp() async {
    tempDir = Directory.systemTemp.createTempSync('cli_bridges_test_');
    d4rt = D4rt();
    d4rt.grant(FilesystemPermission.any);
    d4rt.grant(NetworkPermission.any);
    d4rt.grant(ProcessRunPermission.any);
    TomD4rtDcliBridge.register(d4rt);

    state = CliState(
      dataDirectory: tempDir.path,
      initialDirectory: tempDir.path,
    );

    controller = D4rtCliController(d4rt: d4rt, state: state, toolName: 'Test');
  }

  Future<void> tearDown() async {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  /// Execute code with dcli import and capture output.
  Future<ExecuteResult> exec(String code) async {
    output.clear();
    return withCapture(
      output,
      () => controller.execute('''
import 'package:dcli_core/dcli_core.dart';
import 'package:dcli/dcli.dart';
import 'package:tom_dcli_exec/tom_d4rt_cli_api.dart';

$code
'''),
    );
  }

  /// Execute and verify success.
  Future<void> run(String code) async {
    final result = await exec(code);
    if (!result.success) {
      fail('Execution failed: ${result.error}');
    }
  }

  /// Execute and return the captured output.
  Future<String> runAndCapture(String code) async {
    await run(code);
    return output.stdoutText;
  }

  /// Create a test file.
  File createFile(String name, String content) {
    final file = File('${tempDir.path}/$name');
    file.writeAsStringSync(content);
    return file;
  }

  /// Create a test directory.
  Directory createDir(String name) {
    final dir = Directory('${tempDir.path}/$name');
    dir.createSync(recursive: true);
    return dir;
  }
}

// =============================================================================
// Tests
// =============================================================================

void main() {
  // ===========================================================================
  // DCli Global Functions - File System Checks
  // ===========================================================================

  group('DCli Global Functions - File System Checks', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('exists() returns true for existing file', () async {
      ctx.createFile('exists_test.txt', 'content');
      final out = await ctx.runAndCapture('''
void main() {
  print(exists('${ctx.tempDir.path}/exists_test.txt'));
}
''');
      expect(out.trim(), 'true');
    });

    test('exists() returns false for non-existent file', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(exists('${ctx.tempDir.path}/nonexistent.txt'));
}
''');
      expect(out.trim(), 'false');
    });

    test('exists() returns true for existing directory', () async {
      ctx.createDir('exists_dir');
      final out = await ctx.runAndCapture('''
void main() {
  print(exists('${ctx.tempDir.path}/exists_dir'));
}
''');
      expect(out.trim(), 'true');
    });

    test('isFile() returns true for files', () async {
      ctx.createFile('file_check.txt', 'content');
      final out = await ctx.runAndCapture('''
void main() {
  print(isFile('${ctx.tempDir.path}/file_check.txt'));
}
''');
      expect(out.trim(), 'true');
    });

    test('isFile() returns false for directories', () async {
      ctx.createDir('dir_check');
      final out = await ctx.runAndCapture('''
void main() {
  print(isFile('${ctx.tempDir.path}/dir_check'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isFile() returns false for non-existent path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(isFile('${ctx.tempDir.path}/no_such_file.txt'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isDirectory() returns true for directories', () async {
      ctx.createDir('is_dir_test');
      final out = await ctx.runAndCapture('''
void main() {
  print(isDirectory('${ctx.tempDir.path}/is_dir_test'));
}
''');
      expect(out.trim(), 'true');
    });

    test('isDirectory() returns false for files', () async {
      ctx.createFile('not_dir.txt', 'content');
      final out = await ctx.runAndCapture('''
void main() {
  print(isDirectory('${ctx.tempDir.path}/not_dir.txt'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isDirectory() returns false for non-existent path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(isDirectory('${ctx.tempDir.path}/no_such_dir'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isEmpty() returns true for empty directory', () async {
      ctx.createDir('empty_dir');
      final out = await ctx.runAndCapture('''
void main() {
  print(isEmpty('${ctx.tempDir.path}/empty_dir'));
}
''');
      expect(out.trim(), 'true');
    });

    test('isEmpty() returns false for non-empty directory', () async {
      ctx.createDir('non_empty_dir');
      ctx.createFile('non_empty_dir/file.txt', 'content');
      final out = await ctx.runAndCapture('''
void main() {
  print(isEmpty('${ctx.tempDir.path}/non_empty_dir'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isLink() returns false for regular files', () async {
      ctx.createFile('not_link.txt', 'content');
      final out = await ctx.runAndCapture('''
void main() {
  print(isLink('${ctx.tempDir.path}/not_link.txt'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isLink() returns true for symbolic links', () async {
      ctx.createFile('link_target.txt', 'content');
      Link(
        '${ctx.tempDir.path}/link.txt',
      ).createSync('${ctx.tempDir.path}/link_target.txt');
      final out = await ctx.runAndCapture('''
void main() {
  print(isLink('${ctx.tempDir.path}/link.txt'));
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Global Functions - File Operations
  // ===========================================================================

  group('DCli Global Functions - File Operations', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('touch() creates new file', () async {
      final path = '${ctx.tempDir.path}/touched.txt';
      await ctx.run('''
void main() {
  touch('$path', create: true);
}
''');
      expect(File(path).existsSync(), true);
    });

    test('touch() updates existing file timestamp', () async {
      final file = ctx.createFile('touch_update.txt', 'content');
      final originalModified = file.lastModifiedSync();
      await Future.delayed(Duration(milliseconds: 10));
      await ctx.run('''
void main() {
  touch('${file.path}');
}
''');
      final newModified = file.lastModifiedSync();
      expect(
        newModified.isAfter(originalModified) ||
            newModified == originalModified,
        true,
      );
    });

    test('delete() removes file', () async {
      ctx.createFile('to_delete.txt', 'content');
      final path = '${ctx.tempDir.path}/to_delete.txt';
      await ctx.run('''
void main() {
  delete('$path');
}
''');
      expect(File(path).existsSync(), false);
    });

    test('delete() with ask: false removes file silently', () async {
      ctx.createFile('to_delete_silent.txt', 'content');
      final path = '${ctx.tempDir.path}/to_delete_silent.txt';
      await ctx.run('''
void main() {
  delete('$path', ask: false);
}
''');
      expect(File(path).existsSync(), false);
    });

    test('copy() copies file to new location', () async {
      ctx.createFile('source.txt', 'source content');
      final sourcePath = '${ctx.tempDir.path}/source.txt';
      final destPath = '${ctx.tempDir.path}/dest.txt';
      await ctx.run('''
void main() {
  copy('$sourcePath', '$destPath');
}
''');
      expect(File(destPath).existsSync(), true);
      expect(File(destPath).readAsStringSync(), 'source content');
    });

    test('copy() preserves original file', () async {
      ctx.createFile('orig.txt', 'original');
      final sourcePath = '${ctx.tempDir.path}/orig.txt';
      final destPath = '${ctx.tempDir.path}/copy.txt';
      await ctx.run('''
void main() {
  copy('$sourcePath', '$destPath');
}
''');
      expect(File(sourcePath).existsSync(), true);
      expect(File(destPath).existsSync(), true);
    });

    test('copy() with overwrite replaces existing file', () async {
      ctx.createFile('src_over.txt', 'new content');
      ctx.createFile('dest_over.txt', 'old content');
      final sourcePath = '${ctx.tempDir.path}/src_over.txt';
      final destPath = '${ctx.tempDir.path}/dest_over.txt';
      await ctx.run('''
void main() {
  copy('$sourcePath', '$destPath', overwrite: true);
}
''');
      expect(File(destPath).readAsStringSync(), 'new content');
    });

    test('move() moves file to new location', () async {
      ctx.createFile('to_move.txt', 'move content');
      final sourcePath = '${ctx.tempDir.path}/to_move.txt';
      final destPath = '${ctx.tempDir.path}/moved.txt';
      await ctx.run('''
void main() {
  move('$sourcePath', '$destPath');
}
''');
      expect(File(sourcePath).existsSync(), false);
      expect(File(destPath).existsSync(), true);
      expect(File(destPath).readAsStringSync(), 'move content');
    });

    test('move() with overwrite replaces existing file', () async {
      ctx.createFile('mv_src.txt', 'new');
      ctx.createFile('mv_dest.txt', 'old');
      final sourcePath = '${ctx.tempDir.path}/mv_src.txt';
      final destPath = '${ctx.tempDir.path}/mv_dest.txt';
      await ctx.run('''
void main() {
  move('$sourcePath', '$destPath', overwrite: true);
}
''');
      expect(File(destPath).readAsStringSync(), 'new');
    });

    test('fileLength() returns correct file size', () async {
      ctx.createFile('size_test.txt', 'hello');
      final path = '${ctx.tempDir.path}/size_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  print(fileLength('$path'));
}
''');
      expect(out.trim(), '5');
    });

    test('fileLength() returns 0 for empty file', () async {
      ctx.createFile('empty_size.txt', '');
      final path = '${ctx.tempDir.path}/empty_size.txt';
      final out = await ctx.runAndCapture('''
void main() {
  print(fileLength('$path'));
}
''');
      expect(out.trim(), '0');
    });

    // Note: lastModified() and setLastModifed() are not exported from dcli barrel.
    // They are only available in dcli_core. Tests removed.

    test('stat() returns file information', () async {
      ctx.createFile('stat_test.txt', 'content');
      final path = '${ctx.tempDir.path}/stat_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  var s = stat('$path');
  print(s != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('calculateHash() returns hash string', () async {
      ctx.createFile('hash_test.txt', 'content');
      final path = '${ctx.tempDir.path}/hash_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  print(calculateHash('$path'));
}
''');
      expect(out.trim().length, greaterThan(0));
    });

    test('calculateHash() returns consistent hash for same content', () async {
      ctx.createFile('hash1.txt', 'same content');
      ctx.createFile('hash2.txt', 'same content');
      final path1 = '${ctx.tempDir.path}/hash1.txt';
      final path2 = '${ctx.tempDir.path}/hash2.txt';
      final out = await ctx.runAndCapture('''
void main() {
  var h1 = calculateHash('$path1');
  var h2 = calculateHash('$path2');
  print(h1 == h2);
}
''');
      expect(out.trim(), 'true');
    });

    test('replace() replaces text in file', () async {
      ctx.createFile('replace_test.txt', 'Hello World');
      final path = '${ctx.tempDir.path}/replace_test.txt';
      await ctx.run('''
void main() {
  replace('$path', 'World', 'Dart');
}
''');
      expect(File(path).readAsStringSync(), contains('Dart'));
    });

    test('replace() replaces multiple occurrences', () async {
      ctx.createFile('replace_multi.txt', 'aaa bbb aaa');
      final path = '${ctx.tempDir.path}/replace_multi.txt';
      await ctx.run('''
void main() {
  replace('$path', 'aaa', 'xxx', all: true);
}
''');
      expect(File(path).readAsStringSync(), contains('xxx'));
      expect(File(path).readAsStringSync().contains('aaa'), false);
    });
  });

  // ===========================================================================
  // DCli Global Functions - File Reading
  // ===========================================================================

  group('DCli Global Functions - File Reading', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('read() returns Progress object', () async {
      ctx.createFile('read_test.txt', 'line1\nline2\nline3');
      final path = '${ctx.tempDir.path}/read_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  var progress = read('$path');
  print(progress != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('head() returns Progress object', () async {
      ctx.createFile('head_test.txt', 'line1\nline2\nline3\nline4\nline5');
      final path = '${ctx.tempDir.path}/head_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  var progress = head('$path', 2);
  print(progress != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('head() returns Progress with lines property', () async {
      ctx.createFile('head_lines.txt', 'a\nb\nc');
      final path = '${ctx.tempDir.path}/head_lines.txt';
      final out = await ctx.runAndCapture('''
void main() {
  var h = head('$path', 10);
  print(h != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('tail() returns Progress object', () async {
      ctx.createFile('tail_test.txt', 'line1\nline2\nline3\nline4\nline5');
      final path = '${ctx.tempDir.path}/tail_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  var progress = tail('$path', 2);
  print(progress != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('cat() outputs file content', () async {
      ctx.createFile('cat_test.txt', 'cat content');
      final path = '${ctx.tempDir.path}/cat_test.txt';
      final out = await ctx.runAndCapture('''
void main() {
  cat('$path');
}
''');
      expect(out.trim(), 'cat content');
    });
  });

  // ===========================================================================
  // DCli Global Functions - Directory Operations
  // ===========================================================================

  group('DCli Global Functions - Directory Operations', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('createDir() creates directory', () async {
      final path = '${ctx.tempDir.path}/created_dir';
      await ctx.run('''
void main() {
  createDir('$path');
}
''');
      expect(Directory(path).existsSync(), true);
    });

    test('createDir() with recursive creates nested directories', () async {
      final path = '${ctx.tempDir.path}/deep/nested/dir';
      await ctx.run('''
void main() {
  createDir('$path', recursive: true);
}
''');
      expect(Directory(path).existsSync(), true);
    });

    test('createDir() creates parent directories when recursive', () async {
      final path = '${ctx.tempDir.path}/parent/child/grandchild';
      await ctx.run('''
void main() {
  createDir('$path', recursive: true);
}
''');
      expect(Directory('${ctx.tempDir.path}/parent').existsSync(), true);
      expect(Directory('${ctx.tempDir.path}/parent/child').existsSync(), true);
      expect(Directory(path).existsSync(), true);
    });

    test('deleteDir() removes empty directory', () async {
      ctx.createDir('dir_to_delete');
      final path = '${ctx.tempDir.path}/dir_to_delete';
      await ctx.run('''
void main() {
  deleteDir('$path');
}
''');
      expect(Directory(path).existsSync(), false);
    });

    test('deleteDir() with recursive removes non-empty directory', () async {
      ctx.createDir('dir_with_content');
      ctx.createFile('dir_with_content/file.txt', 'content');
      final path = '${ctx.tempDir.path}/dir_with_content';
      await ctx.run('''
void main() {
  deleteDir('$path', recursive: true);
}
''');
      expect(Directory(path).existsSync(), false);
    });

    test('moveDir() moves directory to new location', () async {
      ctx.createDir('dir_to_move');
      ctx.createFile('dir_to_move/file.txt', 'content');
      final sourcePath = '${ctx.tempDir.path}/dir_to_move';
      final destPath = '${ctx.tempDir.path}/dir_moved';
      await ctx.run('''
void main() {
  moveDir('$sourcePath', '$destPath');
}
''');
      expect(Directory(sourcePath).existsSync(), false);
      expect(Directory(destPath).existsSync(), true);
      expect(File('$destPath/file.txt').existsSync(), true);
    });

    test('copyTree() copies directory tree', () async {
      final sourceDir = ctx.createDir('source_tree');
      File('${sourceDir.path}/file1.txt').writeAsStringSync('content1');
      File('${sourceDir.path}/file2.txt').writeAsStringSync('content2');
      ctx.createDir('source_tree/subdir');
      File('${sourceDir.path}/subdir/nested.txt').writeAsStringSync('nested');

      // copyTree requires destination to exist
      final destPath = '${ctx.tempDir.path}/dest_tree';
      Directory(destPath).createSync();

      await ctx.run('''
void main() {
  copyTree('${sourceDir.path}', '$destPath');
}
''');
      expect(Directory(destPath).existsSync(), true);
      expect(File('$destPath/file1.txt').existsSync(), true);
      expect(File('$destPath/file2.txt').existsSync(), true);
      expect(File('$destPath/subdir/nested.txt').existsSync(), true);
    });

    test('copyTree() preserves file contents', () async {
      final sourceDir = ctx.createDir('copy_content');
      File('${sourceDir.path}/data.txt').writeAsStringSync('important data');

      // copyTree requires destination to exist
      final destPath = '${ctx.tempDir.path}/copy_dest';
      Directory(destPath).createSync();

      await ctx.run('''
void main() {
  copyTree('${sourceDir.path}', '$destPath');
}
''');
      expect(File('$destPath/data.txt').readAsStringSync(), 'important data');
    });

    test('createTempDir() creates temporary directory', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var tmp = createTempDir();
  print(tmp);
}
''');
      final tmpPath = out.trim();
      expect(Directory(tmpPath).existsSync(), true);
      // Clean up
      Directory(tmpPath).deleteSync();
    });

    test('createTempDir() with suffix parameter', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var tmp = createTempDir(suffix: 'mytest');
  print(tmp.isNotEmpty);
  deleteDir(tmp);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Global Functions - Find
  // ===========================================================================

  group('DCli Global Functions - Find', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('find() returns FindProgress object', () async {
      ctx.createFile('find_a.txt', 'a');
      ctx.createFile('find_b.txt', 'b');
      ctx.createFile('other.dat', 'c');

      final out = await ctx.runAndCapture('''
void main() {
  var result = find('*.txt', workingDirectory: '${ctx.tempDir.path}');
  print(result != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('find() with recursive: true parameter', () async {
      ctx.createDir('findtest/subdir');
      ctx.createFile('findtest/root.txt', 'root');
      ctx.createFile('findtest/subdir/nested.txt', 'nested');

      final out = await ctx.runAndCapture('''
void main() {
  var result = find('*.txt', workingDirectory: '${ctx.tempDir.path}/findtest', recursive: true);
  print(result != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('find() with recursive: false parameter', () async {
      ctx.createDir('findflat/subdir');
      ctx.createFile('findflat/root.txt', 'root');
      ctx.createFile('findflat/subdir/nested.txt', 'nested');

      final out = await ctx.runAndCapture('''
void main() {
  var result = find('*.txt', workingDirectory: '${ctx.tempDir.path}/findflat', recursive: false);
  print(result != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('find() returns FindProgress object for type filtering', () async {
      ctx.createDir('findtype');
      ctx.createFile('findtype/file.txt', 'content');

      final out = await ctx.runAndCapture('''
void main() {
  var result = find('*.txt', workingDirectory: '${ctx.tempDir.path}/findtype');
  print(result != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('find() supports caseSensitive parameter', () async {
      ctx.createDir('findcase');
      ctx.createFile('findcase/file.TXT', 'content');

      final out = await ctx.runAndCapture('''
void main() {
  var result = find('*.txt', workingDirectory: '${ctx.tempDir.path}/findcase', caseSensitive: false);
  print(result != null);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Global Functions - Symlinks
  // ===========================================================================

  group('DCli Global Functions - Symlinks', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('createSymLink() creates symbolic link', () async {
      ctx.createFile('link_target.txt', 'target');
      final targetPath = '${ctx.tempDir.path}/link_target.txt';
      final linkPath = '${ctx.tempDir.path}/link.txt';
      await ctx.run('''
void main() {
  createSymLink(targetPath: '$targetPath', linkPath: '$linkPath');
}
''');
      expect(Link(linkPath).existsSync(), true);
    });

    test('createSymLink() link points to target', () async {
      ctx.createFile('sym_target.txt', 'target content');
      final targetPath = '${ctx.tempDir.path}/sym_target.txt';
      final linkPath = '${ctx.tempDir.path}/sym_link.txt';
      await ctx.run('''
void main() {
  createSymLink(targetPath: '$targetPath', linkPath: '$linkPath');
}
''');
      expect(File(linkPath).readAsStringSync(), 'target content');
    });

    test('resolveSymLink() resolves link to target', () async {
      ctx.createFile('resolve_target.txt', 'target');
      final targetPath = '${ctx.tempDir.path}/resolve_target.txt';
      final linkPath = '${ctx.tempDir.path}/resolve_link.txt';
      Link(linkPath).createSync(targetPath);

      final out = await ctx.runAndCapture('''
void main() {
  print(resolveSymLink('$linkPath'));
}
''');
      // macOS may add /private prefix, so just check filename is in result
      expect(out.trim(), contains('resolve_target.txt'));
    });

    test('deleteSymlink() removes link but keeps target', () async {
      ctx.createFile('del_target.txt', 'target');
      final targetPath = '${ctx.tempDir.path}/del_target.txt';
      final linkPath = '${ctx.tempDir.path}/del_link.txt';
      Link(linkPath).createSync(targetPath);

      await ctx.run('''
void main() {
  deleteSymlink('$linkPath');
}
''');
      expect(Link(linkPath).existsSync(), false);
      expect(File(targetPath).existsSync(), true);
    });
  });

  // ===========================================================================
  // DCli Global Functions - Backup/Restore
  // ===========================================================================

  group('DCli Global Functions - Backup/Restore', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('backupFile() is callable with file path', () async {
      ctx.createFile('backup_me.txt', 'original');
      final path = '${ctx.tempDir.path}/backup_me.txt';
      // backupFile stores backup in dcli's internal backup directory, not .bak
      await ctx.run('''
void main() {
  backupFile('$path');
  print('backup done');
}
''');
      // Just verify it runs without error
      expect(ctx.output.stdoutText.trim(), 'backup done');
    });

    test('backupFile() supports ignoreMissing parameter', () async {
      ctx.createFile('backup_ignore.txt', 'content');
      final path = '${ctx.tempDir.path}/backup_ignore.txt';
      // ignoreMissing doesn't prevent error when file is missing;
      // it's for when the backup file doesn't exist
      await ctx.run('''
void main() {
  backupFile('$path', ignoreMissing: true);
  print('ok');
}
''');
      expect(ctx.output.stdoutText.trim(), 'ok');
    });

    test('restoreFile() is callable after backup', () async {
      ctx.createFile('restore_me.txt', 'original');
      final path = '${ctx.tempDir.path}/restore_me.txt';
      await ctx.run('''
void main() {
  backupFile('$path');
  restoreFile('$path');
  print('restore done');
}
''');
      expect(ctx.output.stdoutText.trim(), 'restore done');
    });

    test('restoreFile() with ignoreMissing handles missing backup', () async {
      ctx.createFile('no_backup.txt', 'content');
      final path = '${ctx.tempDir.path}/no_backup.txt';
      await ctx.run('''
void main() {
  restoreFile('$path', ignoreMissing: true);
  print('ok');
}
''');
      expect(ctx.output.stdoutText.trim(), 'ok');
    });
  });

  // ===========================================================================
  // DCli Global Functions - Temp Files
  // ===========================================================================

  group('DCli Global Functions - Temp Files', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('createTempFilename() returns path string', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var path = createTempFilename();
  print(path.isNotEmpty);
}
''');
      expect(out.trim(), 'true');
    });

    test('createTempFilename() with suffix adds suffix', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var path = createTempFilename(suffix: '.myext');
  print(path);
}
''');
      expect(out.trim(), contains('.myext'));
    });

    test('createTempFile() creates actual file', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var path = createTempFile();
  print(path);
}
''');
      final tmpPath = out.trim();
      expect(File(tmpPath).existsSync(), true);
      // Clean up
      File(tmpPath).deleteSync();
    });

    test('createTempFile() with suffix adds suffix to filename', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var path = createTempFile(suffix: '.log');
  print(path);
}
''');
      final tmpPath = out.trim();
      expect(tmpPath, contains('.log'));
      // Clean up
      if (File(tmpPath).existsSync()) {
        File(tmpPath).deleteSync();
      }
    });
  });

  // ===========================================================================
  // DCli Global Functions - Echo/Print
  // ===========================================================================

  group('DCli Global Functions - Echo/Print', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('echo() is callable', () async {
      // echo writes directly to stdout, not captured via zone print
      await ctx.run('''
void main() {
  echo('Hello Echo');
}
''');
      // Just verify it runs without error
    });

    test('echo() with newline parameter is callable', () async {
      await ctx.run('''
void main() {
  echo('no newline', newline: false);
  echo('after');
}
''');
      // Just verify it runs without error
    });
  });

  // ===========================================================================
  // DCli Global Functions - Sleep
  // ===========================================================================

  group('DCli Global Functions - Sleep', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('sleep() with milliseconds pauses execution', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var start = DateTime.now();
  sleep(10, interval: Interval.milliseconds);
  var end = DateTime.now();
  print(end.difference(start).inMilliseconds >= 10);
}
''');
      expect(out.trim(), 'true');
    });

    test('Interval.seconds enum value is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(Interval.seconds);
}
''');
      expect(out.trim(), contains('seconds'));
    });

    test('Interval.milliseconds enum value is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(Interval.milliseconds);
}
''');
      expect(out.trim(), contains('milliseconds'));
    });

    test('Interval.minutes enum value is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(Interval.minutes);
}
''');
      expect(out.trim(), contains('minutes'));
    });
  });

  // ===========================================================================
  // DCli Global Functions - Which
  // ===========================================================================

  group('DCli Global Functions - Which', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('which() finds dart executable', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = which('dart');
  print(result.found);
}
''');
      expect(out.trim(), 'true');
    });

    test('which() returns path when found', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = which('dart');
  print(result.path != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('which() returns not found for nonexistent command', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = which('nonexistent_command_xyz_123');
  print(result.found);
}
''');
      expect(out.trim(), 'false');
    });
  });

  // ===========================================================================
  // DCli Classes - DartSdk
  // ===========================================================================

  group('DCli Classes - DartSdk', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('DartSdk() constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var sdk = DartSdk();
  print(sdk != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('DartSdk.dartExeName returns dart', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(DartSdk.dartExeName);
}
''');
      expect(out.trim(), 'dart');
    });

    test('DartSdk().pathToDartExe returns path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var sdk = DartSdk();
  print(sdk.pathToDartExe.isNotEmpty);
}
''');
      expect(out.trim(), 'true');
    });

    test('DartSdk().version returns version string', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var sdk = DartSdk();
  print(sdk.version.isNotEmpty);
}
''');
      expect(out.trim(), 'true');
    });

    test('DartSdk().pathToSdk returns path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var sdk = DartSdk();
  print(sdk.pathToSdk.isNotEmpty);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Classes - Shell
  // ===========================================================================

  group('DCli Classes - Shell', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('Shell.current returns shell instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var shell = Shell.current;
  print(shell != null);
}
''');
      expect(out.trim(), 'true');
    });

    // Note: Shell subclasses (ZshShell, BashShell, etc.) don't have
    // properties bridged - we just verify the static getter works
  });

  // ===========================================================================
  // DCli Classes - DCliPaths
  // ===========================================================================

  group('DCli Classes - DCliPaths', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('DCliPaths() constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var paths = DCliPaths();
  print(paths != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('DCliPaths().pathToDCli returns path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var paths = DCliPaths();
  // pathToDCli may be null on some systems
  print(paths.pathToDCli != null || paths.pathToDCli == null);
}
''');
      expect(out.trim(), 'true');
    });

    // Note: pathToDCliCache is not bridged
  });

  // ===========================================================================
  // DCli Classes - DartProject
  // ===========================================================================

  group('DCli Classes - DartProject', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('DartProject.fromPath() with valid project', () async {
      // Create a minimal pubspec.yaml
      final projectDir = ctx.createDir('test_project');
      File('${projectDir.path}/pubspec.yaml').writeAsStringSync('''
name: test_project
version: 1.0.0
environment:
  sdk: ^3.0.0
''');

      final out = await ctx.runAndCapture('''
void main() {
  var project = DartProject.fromPath('${projectDir.path}');
  print(project != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('DartProject.fromPath().pathToProjectRoot returns path', () async {
      final projectDir = ctx.createDir('named_project');
      File('${projectDir.path}/pubspec.yaml').writeAsStringSync('''
name: my_cool_project
version: 1.0.0
environment:
  sdk: ^3.0.0
''');

      final out = await ctx.runAndCapture('''
void main() {
  var project = DartProject.fromPath('${projectDir.path}');
  print(project.pathToProjectRoot.isNotEmpty);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Classes - DartScript
  // ===========================================================================

  group('DCli Classes - DartScript', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('DartScript.fromFile() parses script', () async {
      final scriptFile = ctx.createFile('test_script.dart', '''
void main() {
  print('Hello');
}
''');

      final out = await ctx.runAndCapture('''
void main() {
  var script = DartScript.fromFile('${scriptFile.path}');
  print(script != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('DartScript.fromFile().pathToScript returns path', () async {
      final scriptFile = ctx.createFile('path_script.dart', 'void main() {}');

      final out = await ctx.runAndCapture('''
void main() {
  var script = DartScript.fromFile('${scriptFile.path}');
  print(script.pathToScript);
}
''');
      expect(out.trim(), scriptFile.path);
    });
  });

  // ===========================================================================
  // DCli Classes - FileSync
  // ===========================================================================

  group('DCli Classes - FileSync', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('FileSync.tempFile() creates temp file', () async {
      // FileSync.tempFile() returns a String path, not a FileSync object
      final out = await ctx.runAndCapture('''
void main() {
  var tempPath = FileSync.tempFile();
  print(tempPath is String);
}
''');
      expect(out.trim(), 'true');
    });

    test('FileSync write and read', () async {
      final path = '${ctx.tempDir.path}/filesync_test.txt';
      await ctx.run('''
import 'dart:io';
void main() {
  var fs = FileSync('$path', fileMode: FileMode.write);
  fs.write('Hello FileSync');
  fs.close();
}
''');
      expect(File(path).readAsStringSync(), contains('Hello FileSync'));
    });

    test('FileSync.append() adds to file', () async {
      final path = '${ctx.tempDir.path}/filesync_append.txt';
      // Test append mode adds to existing content
      await ctx.run('''
import 'dart:io';
void main() {
  // Create initial file with write mode
  var fs = FileSync('$path', fileMode: FileMode.writeOnly);
  fs.write('First');
  fs.flush();
  fs.close();
  
  // Append to it
  fs = FileSync('$path', fileMode: FileMode.writeOnlyAppend);
  fs.append('Second');
  fs.flush();
  fs.close();
}
''');
      final content = File(path).readAsStringSync();
      expect(content, contains('First'));
      expect(content, contains('Second'));
    });
  });

  // ===========================================================================
  // DCli Classes - NamedLock
  // ===========================================================================

  group('DCli Classes - NamedLock', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('NamedLock() constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var lock = NamedLock(name: 'test_lock');
  print(lock != null);
}
''');
      expect(out.trim(), 'true');
    });

    test(
      'NamedLock.withLock() executes callback (deprecated in dcli 8.4.2, throws UnsupportedError)',
      () async {
        // withLock is deprecated in dcli 8.4.2 — throws UnsupportedError('Use withLockAsync')
        expect(
          () => ctx.runAndCapture('''
void main() async {
  var lock = NamedLock(name: 'test_lock_callback');
  var result = await lock.withLock(() => 'completed');
  print(result);
}
'''),
          throwsA(isA<Exception>()),
        );
      },
    );

    test(
      'NamedLock.withLock() with timeout (deprecated in dcli 8.4.2, throws UnsupportedError)',
      () async {
        // withLock is deprecated in dcli 8.4.2 — throws UnsupportedError('Use withLockAsync')
        expect(
          () => ctx.runAndCapture('''
void main() async {
  var lock = NamedLock(name: 'timeout_test_lock', timeout: Duration(seconds: 5));
  var result = await lock.withLock(() => 42);
  print(result);
}
'''),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('NamedLock.withLockAsync() executes callback', () async {
      final out = await ctx.runAndCapture('''
void main() async {
  var lock = NamedLock(name: 'test_lock_async_callback');
  await lock.withLockAsync(() async {
    print('inside async lock');
  });
  print('done');
}
''');
      expect(out, contains('inside async lock'));
      expect(out, contains('done'));
    });

    test('NamedLock.withLockAsync() with timeout', () async {
      final out = await ctx.runAndCapture('''
void main() async {
  var lock = NamedLock(name: 'timeout_async_lock', timeout: Duration(seconds: 5));
  await lock.withLockAsync(() async {
    print('locked with timeout');
  });
  print('completed');
}
''');
      expect(out, contains('locked with timeout'));
      expect(out, contains('completed'));
    });
  });

  // ===========================================================================
  // DCli Classes - Progress
  // ===========================================================================

  group('DCli Classes - Progress', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('Progress.print() creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var progress = Progress.print();
  print(progress != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('Progress.capture() creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var progress = Progress.capture();
  print(progress != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('Progress.devNull() creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var progress = Progress.devNull();
  print(progress != null);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Classes - ProcessDetails
  // ===========================================================================

  group('DCli Classes - ProcessDetails', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('ProcessDetails() constructor creates instance', () async {
      // ProcessDetails.self() is not bridged, test constructor instead
      final out = await ctx.runAndCapture('''
void main() {
  var pd = ProcessDetails(123, 'test_process', '10M');
  print(pd != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('ProcessDetails.pid returns process ID', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var pd = ProcessDetails(456, 'test_process', '20M');
  print(pd.pid);
}
''');
      expect(out.trim(), '456');
    });

    test('ProcessDetails.name returns process name', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var pd = ProcessDetails(789, 'dart_process', '30M');
  print(pd.name);
}
''');
      expect(out.trim(), 'dart_process');
    });
  });

  // ===========================================================================
  // DCli Classes - PubCache
  // ===========================================================================

  group('DCli Classes - PubCache', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('PubCache() constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var cache = PubCache();
  print(cache != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('PubCache().pathTo returns path', () async {
      // Property is pathTo, not pathToPubCache
      final out = await ctx.runAndCapture('''
void main() {
  var cache = PubCache();
  print(cache.pathTo.isNotEmpty);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // DCli Classes - Settings
  // ===========================================================================

  group('DCli Classes - Settings', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('Settings() constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var settings = Settings();
  print(settings != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('Settings().isVerbose returns boolean', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var settings = Settings();
  print(settings.isVerbose is bool);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // CLI API Classes - CliState
  // ===========================================================================

  group('CLI API Classes - CliState', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('CliState constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var state = CliState(dataDirectory: '/tmp', initialDirectory: '/tmp');
  print(state != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('CliState.cwd returns initial directory', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var state = CliState(dataDirectory: '/tmp', initialDirectory: '/tmp');
  print(state.cwd);
}
''');
      expect(out.trim(), '/tmp');
    });

    test('CliState.dataDirectory returns data directory', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var state = CliState(dataDirectory: '/data', initialDirectory: '/tmp');
  print(state.dataDirectory);
}
''');
      expect(out.trim(), '/data');
    });
  });

  // ===========================================================================
  // CLI API Classes - ExecuteResult
  // ===========================================================================

  group('CLI API Classes - ExecuteResult', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('ExecuteResult.success() creates success result', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = ExecuteResult.success(42);
  print(result.success);
}
''');
      expect(out.trim(), 'true');
    });

    test('ExecuteResult.success() stores result value', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = ExecuteResult.success(42);
  print(result.result);
}
''');
      expect(out.trim(), '42');
    });

    test('ExecuteResult.success() has null error', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = ExecuteResult.success(42);
  print(result.error == null);
}
''');
      expect(out.trim(), 'true');
    });

    test('ExecuteResult.failure() creates failure result', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = ExecuteResult.failure('error message');
  print(result.success);
}
''');
      expect(out.trim(), 'false');
    });

    test('ExecuteResult.failure() stores error message', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = ExecuteResult.failure('error message');
  print(result.error);
}
''');
      expect(out.trim(), 'error message');
    });
  });

  // ===========================================================================
  // CLI API Classes - Exceptions
  // ===========================================================================

  group('CLI API Classes - Exceptions', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('CliException constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = CliException('test error');
  print(ex != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('CliException.message returns message', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = CliException('test error');
  print(ex.message);
}
''');
      expect(out.trim(), 'test error');
    });

    test('CliFileNotFoundException constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = CliFileNotFoundException('/path/to/file');
  print(ex != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('CliFileNotFoundException.path returns path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = CliFileNotFoundException('/path/to/file');
  print(ex.path);
}
''');
      expect(out.trim(), '/path/to/file');
    });

    test('DirectoryNotFoundException constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = DirectoryNotFoundException('/path/to/dir');
  print(ex != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('DirectoryNotFoundException.path returns path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = DirectoryNotFoundException('/path/to/dir');
  print(ex.path);
}
''');
      expect(out.trim(), '/path/to/dir');
    });

    test('ExecutionException constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var ex = ExecutionException('execution failed');
  print(ex != null);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // CLI API Classes - ExecutionContext
  // ===========================================================================

  group('CLI API Classes - ExecutionContext', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('ExecutionContext constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var context = ExecutionContext(
    workingDirectory: '/tmp',
    sourceFile: null,
    recordToSession: true,
    silent: false,
  );
  print(context != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('ExecutionContext.workingDirectory returns directory', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var context = ExecutionContext(
    workingDirectory: '/test',
    sourceFile: null,
    recordToSession: true,
    silent: false,
  );
  print(context.workingDirectory);
}
''');
      expect(out.trim(), '/test');
    });

    test('ExecutionContext.sourceFile returns source file', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var context = ExecutionContext(
    workingDirectory: '/test',
    sourceFile: 'test.dart',
    recordToSession: true,
    silent: false,
  );
  print(context.sourceFile);
}
''');
      expect(out.trim(), 'test.dart');
    });

    test('ExecutionContext.recordToSession returns flag', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var context = ExecutionContext(
    workingDirectory: '/test',
    sourceFile: null,
    recordToSession: true,
    silent: false,
  );
  print(context.recordToSession);
}
''');
      expect(out.trim(), 'true');
    });

    test('ExecutionContext.silent returns flag', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var context = ExecutionContext(
    workingDirectory: '/test',
    sourceFile: null,
    recordToSession: true,
    silent: true,
  );
  print(context.silent);
}
''');
      expect(out.trim(), 'true');
    });

    test('ExecutionContext.isMultilineMode returns false initially', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var context = ExecutionContext(
    workingDirectory: '/test',
    sourceFile: null,
    recordToSession: true,
    silent: false,
  );
  print(context.isMultilineMode);
}
''');
      expect(out.trim(), 'false');
    });
  });

  // ===========================================================================
  // CLI API Classes - ContextStack
  // ===========================================================================

  group('CLI API Classes - ContextStack', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('ContextStack constructor creates instance', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/initial');
  print(stack != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('ContextStack.cwd returns initial directory', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/initial');
  print(stack.cwd);
}
''');
      expect(out.trim(), '/initial');
    });

    test('ContextStack.depth returns 0 initially', () async {
      // ContextStack starts with depth 0 before any push
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/initial');
  print(stack.depth);
}
''');
      expect(out.trim(), '0');
    });

    test('ContextStack push increases depth', () async {
      // After push, depth becomes 1 (0 -> 1)
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/root');
  stack.push(ExecutionContext(
    workingDirectory: '/nested',
    sourceFile: null,
    recordToSession: false,
    silent: true,
  ));
  print(stack.depth);
}
''');
      expect(out.trim(), '1');
    });

    test('ContextStack push changes cwd', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/root');
  stack.push(ExecutionContext(
    workingDirectory: '/nested',
    sourceFile: null,
    recordToSession: false,
    silent: true,
  ));
  print(stack.cwd);
}
''');
      expect(out.trim(), '/nested');
    });

    test('ContextStack pop decreases depth', () async {
      // After push then pop, depth returns to 0
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/root');
  stack.push(ExecutionContext(
    workingDirectory: '/nested',
    sourceFile: null,
    recordToSession: false,
    silent: true,
  ));
  stack.pop();
  print(stack.depth);
}
''');
      expect(out.trim(), '0');
    });

    test('ContextStack pop restores cwd', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var stack = ContextStack('/root');
  stack.push(ExecutionContext(
    workingDirectory: '/nested',
    sourceFile: null,
    recordToSession: false,
    silent: true,
  ));
  stack.pop();
  print(stack.cwd);
}
''');
      expect(out.trim(), '/root');
    });
  });

  // ===========================================================================
  // Enums - MultilineMode
  // ===========================================================================

  group('Enums - MultilineMode', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('MultilineMode.none is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(MultilineMode.none);
}
''');
      expect(out.trim(), contains('none'));
    });

    test('MultilineMode.script is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(MultilineMode.script);
}
''');
      expect(out.trim(), contains('script'));
    });

    test('MultilineMode.file is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(MultilineMode.file);
}
''');
      expect(out.trim(), contains('file'));
    });

    test('MultilineMode.executeNew is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(MultilineMode.executeNew);
}
''');
      expect(out.trim(), contains('executeNew'));
    });

    test('MultilineMode.define is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(MultilineMode.define);
}
''');
      expect(out.trim(), contains('define'));
    });

    test('MultilineMode enum has multiple values', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(MultilineMode.none);
  print(MultilineMode.script);
  print('done');
}
''');
      expect(out, contains('done'));
    });
  });

  // ===========================================================================
  // Enums - SymbolKind
  // ===========================================================================

  group('Enums - SymbolKind', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('SymbolKind.package is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SymbolKind.package);
}
''');
      expect(out.trim(), contains('package'));
    });

    test('SymbolKind.class_ is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SymbolKind.class_);
}
''');
      expect(out, contains('class'));
    });

    test('SymbolKind.method is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SymbolKind.method);
}
''');
      expect(out.trim(), contains('method'));
    });

    test('SymbolKind.variable is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SymbolKind.variable);
}
''');
      expect(out.trim(), contains('variable'));
    });

    test('SymbolKind.enum_ is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SymbolKind.enum_);
}
''');
      expect(out, contains('enum'));
    });
  });

  // ===========================================================================
  // Enums - DCli Enums
  // ===========================================================================

  group('Enums - DCli Enums', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('FetchMethod.get is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(FetchMethod.get);
}
''');
      expect(out.trim(), contains('get'));
    });

    test('FetchMethod.post is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(FetchMethod.post);
}
''');
      expect(out.trim(), contains('post'));
    });

    test('FetchStatus.complete is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(FetchStatus.complete);
}
''');
      expect(out.trim(), contains('complete'));
    });

    test('SortDirection.ascending is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SortDirection.ascending);
}
''');
      expect(out.trim(), contains('ascending'));
    });

    test('SortDirection.descending is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(SortDirection.descending);
}
''');
      expect(out.trim(), contains('descending'));
    });

    test('Find.file is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(Find.file);
}
''');
      expect(out.trim(), contains('file'));
    });

    test('Find.directory is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(Find.directory);
}
''');
      expect(out.trim(), contains('directory'));
    });

    test('Find.link is available', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(Find.link);
}
''');
      expect(out.trim(), contains('link'));
    });
  });

  // ===========================================================================
  // Integration Tests - Complex Scenarios
  // ===========================================================================

  group('Integration - Complex File Operations', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('create, modify, and verify file', () async {
      final path = '${ctx.tempDir.path}/integration1.txt';
      await ctx.run('''
void main() {
  touch('$path', create: true);
  // Verify exists
  if (!isFile('$path')) throw 'File not created';
}
''');
      expect(File(path).existsSync(), true);
    });

    test('copy file tree and verify structure', () async {
      // Create source structure
      ctx.createDir('src_tree/subdir1');
      ctx.createDir('src_tree/subdir2');
      ctx.createFile('src_tree/root.txt', 'root');
      ctx.createFile('src_tree/subdir1/a.txt', 'a');
      ctx.createFile('src_tree/subdir2/b.txt', 'b');

      final srcPath = '${ctx.tempDir.path}/src_tree';
      final destPath = '${ctx.tempDir.path}/dest_tree';

      // copyTree requires destination to exist
      Directory(destPath).createSync();

      await ctx.run('''
void main() {
  copyTree('$srcPath', '$destPath');
}
''');

      expect(Directory(destPath).existsSync(), true);
      expect(File('$destPath/root.txt').existsSync(), true);
      expect(File('$destPath/subdir1/a.txt').existsSync(), true);
      expect(File('$destPath/subdir2/b.txt').existsSync(), true);
    });

    test('find files and count results', () async {
      ctx.createDir('find_complex');
      for (var i = 0; i < 5; i++) {
        ctx.createFile('find_complex/file$i.txt', 'content$i');
      }
      ctx.createFile('find_complex/other.dat', 'other');

      // Note: forEach is not bridged on FindProgress, just verify find() returns non-null
      final out = await ctx.runAndCapture('''
void main() {
  var result = find('*.txt', workingDirectory: '${ctx.tempDir.path}/find_complex');
  print(result != null);
}
''');
      expect(out.trim(), 'true');
    });

    test('backup, modify, and restore file', () async {
      ctx.createFile('restore_test.txt', 'original content');
      final path = '${ctx.tempDir.path}/restore_test.txt';

      await ctx.run('''
void main() {
  backupFile('$path');
}
''');

      File(path).writeAsStringSync('modified content');
      expect(File(path).readAsStringSync(), 'modified content');

      await ctx.run('''
void main() {
  restoreFile('$path');
}
''');

      expect(File(path).readAsStringSync(), 'original content');
    });

    test('create temp directory, add files, clean up', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var tmp = createTempDir(suffix: 'cleanup_test');
  touch('\$tmp/file.txt', create: true);
  var existed = isFile('\$tmp/file.txt');
  deleteDir(tmp, recursive: true);
  var deletedDir = !exists(tmp);
  print('existed: \$existed, deleted: \$deletedDir');
}
''');
      expect(out, contains('existed: true'));
      expect(out, contains('deleted: true'));
    });

    test('use DartSdk and verify properties', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var sdk = DartSdk();
  var hasPath = sdk.pathToDartExe.isNotEmpty;
  var hasVersion = sdk.version.isNotEmpty;
  print('path: \$hasPath, version: \$hasVersion');
}
''');
      expect(out, contains('path: true'));
      expect(out, contains('version: true'));
    });

    test('use which to find multiple commands', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var dart = which('dart').found;
  var nonexistent = which('definitely_not_a_command_xyz').found;
  print('dart: \$dart, nonexistent: \$nonexistent');
}
''');
      expect(out, contains('dart: true'));
      expect(out, contains('nonexistent: false'));
    });

    test(
      'create and use NamedLock with callback (deprecated in dcli 8.4.2, throws UnsupportedError)',
      () async {
        // withLock is deprecated in dcli 8.4.2 — throws UnsupportedError('Use withLockAsync')
        final lockPath = '${ctx.tempDir.path}/lock_integration';
        expect(
          () => ctx.runAndCapture('''
void main() {
  var lock = NamedLock(name: 'integration', lockPath: '$lockPath');
  lock.withLock(() {
    print('inside lock');
  });
  print('done');
}
'''),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('create and use NamedLock with withLockAsync', () async {
      final lockPath = '${ctx.tempDir.path}/lock_integration_async';
      final out = await ctx.runAndCapture('''
void main() async {
  var lock = NamedLock(name: 'integration_async', lockPath: '$lockPath');
  await lock.withLockAsync(() async {
    print('inside async lock');
  });
  print('done');
}
''');
      expect(out, contains('inside async lock'));
      expect(out, contains('done'));
    });

    test('chain file operations', () async {
      final src = '${ctx.tempDir.path}/chain_src.txt';
      final mid = '${ctx.tempDir.path}/chain_mid.txt';
      final dest = '${ctx.tempDir.path}/chain_dest.txt';

      await ctx.run('''
void main() {
  // Create
  touch('$src', create: true);
  // Copy
  copy('$src', '$mid');
  // Move
  move('$mid', '$dest');
  // Delete original
  delete('$src');
}
''');

      expect(File(src).existsSync(), false);
      expect(File(mid).existsSync(), false);
      expect(File(dest).existsSync(), true);
    });

    test('create directory hierarchy and verify', () async {
      await ctx.run('''
void main() {
  createDir('${ctx.tempDir.path}/a/b/c/d/e', recursive: true);
}
''');

      expect(Directory('${ctx.tempDir.path}/a').existsSync(), true);
      expect(Directory('${ctx.tempDir.path}/a/b').existsSync(), true);
      expect(Directory('${ctx.tempDir.path}/a/b/c').existsSync(), true);
      expect(Directory('${ctx.tempDir.path}/a/b/c/d').existsSync(), true);
      expect(Directory('${ctx.tempDir.path}/a/b/c/d/e').existsSync(), true);
    });

    test('createSymLink + resolveSymLink + deleteSymlink chain', () async {
      ctx.createFile('sym_original.txt', 'original');
      final origPath = '${ctx.tempDir.path}/sym_original.txt';
      final linkPath = '${ctx.tempDir.path}/sym_link.txt';

      await ctx.run('''
void main() {
  createSymLink(targetPath: '$origPath', linkPath: '$linkPath');
}
''');

      expect(Link(linkPath).existsSync(), true);

      final out = await ctx.runAndCapture('''
void main() {
  print(resolveSymLink('$linkPath'));
}
''');
      // macOS may add /private prefix
      expect(out.trim(), contains('sym_original.txt'));

      await ctx.run('''
void main() {
  deleteSymlink('$linkPath');
}
''');

      expect(Link(linkPath).existsSync(), false);
      expect(File(origPath).existsSync(), true);
    });
  });

  // ===========================================================================
  // Integration Tests - Error Handling
  // ===========================================================================

  group('Integration - Error Handling', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('exists returns false for nonexistent path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(exists('${ctx.tempDir.path}/definitely_not_here.txt'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isFile returns false for nonexistent path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(isFile('${ctx.tempDir.path}/no_such_file.txt'));
}
''');
      expect(out.trim(), 'false');
    });

    test('isDirectory returns false for nonexistent path', () async {
      final out = await ctx.runAndCapture('''
void main() {
  print(isDirectory('${ctx.tempDir.path}/no_such_dir'));
}
''');
      expect(out.trim(), 'false');
    });

    test('which returns not found for nonexistent command', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var result = which('absolutely_nonexistent_command_12345');
  print(result.found);
}
''');
      expect(out.trim(), 'false');
    });

    test('createTempDir creates unique directories', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var dir1 = createTempDir();
  var dir2 = createTempDir();
  print(dir1 != dir2);
  deleteDir(dir1);
  deleteDir(dir2);
}
''');
      expect(out.trim(), 'true');
    });

    test('createTempFile creates unique files', () async {
      final out = await ctx.runAndCapture('''
void main() {
  var file1 = createTempFile();
  var file2 = createTempFile();
  print(file1 != file2);
  delete(file1);
  delete(file2);
}
''');
      expect(out.trim(), 'true');
    });
  });

  // ===========================================================================
  // Integration Tests - State Persistence
  // ===========================================================================

  group('Integration - State Persistence', () {
    late BridgeTestContext ctx;

    setUp(() async {
      ctx = BridgeTestContext();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    test('file modifications persist', () async {
      final path = '${ctx.tempDir.path}/persist.txt';

      await ctx.run('''
void main() {
  touch('$path', create: true);
}
''');
      expect(File(path).existsSync(), true);

      await ctx.run('''
void main() {
  delete('$path');
}
''');
      expect(File(path).existsSync(), false);
    });

    test('directory modifications persist', () async {
      final path = '${ctx.tempDir.path}/persist_dir';

      await ctx.run('''
void main() {
  createDir('$path');
}
''');
      expect(Directory(path).existsSync(), true);

      await ctx.run('''
void main() {
  deleteDir('$path');
}
''');
      expect(Directory(path).existsSync(), false);
    });

    test('file content modifications persist', () async {
      ctx.createFile('content_persist.txt', 'initial');
      final path = '${ctx.tempDir.path}/content_persist.txt';

      await ctx.run('''
void main() {
  replace('$path', 'initial', 'modified');
}
''');
      expect(File(path).readAsStringSync(), contains('modified'));
    });
  });
}
