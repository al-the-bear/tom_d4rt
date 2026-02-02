// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

void main() {
  group('CliState', () {
    late CliState state;
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('cli_state_test_');
      state = CliState(
        dataDirectory: tempDir.path,
        initialDirectory: tempDir.path,
      );
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('initial state', () {
      expect(state.dataDirectory, tempDir.path);
      expect(state.cwd, tempDir.path);
      expect(state.isMultilineMode, false);
      expect(state.multilineMode, MultilineMode.none);
      expect(state.currentSessionId, isNull);
    });

    test('cd changes directory', () {
      // Create a subdirectory
      final subDir = Directory('${tempDir.path}/subdir');
      subDir.createSync();

      final result = state.cd('subdir');
      expect(result, subDir.path);
      expect(state.cwd, subDir.path);
    });

    test('cd with absolute path', () {
      // Create a subdirectory
      final subDir = Directory('${tempDir.path}/absolute_test');
      subDir.createSync();

      final result = state.cd(subDir.path);
      expect(result, subDir.path);
      expect(state.cwd, subDir.path);
    });

    test('home returns to data directory', () {
      // Create and navigate to a subdirectory
      final subDir = Directory('${tempDir.path}/deep/nested');
      subDir.createSync(recursive: true);
      state.cd(subDir.path);

      final result = state.home();
      expect(result, tempDir.path);
      expect(state.cwd, tempDir.path);
    });

    test('defines management', () {
      expect(state.defines, isEmpty);

      state.setDefine('test', 'echo hello');
      expect(state.defines, {'test': 'echo hello'});
      expect(state.getDefine('test'), 'echo hello');

      state.removeDefine('test');
      expect(state.defines, isEmpty);
      expect(state.getDefine('test'), isNull);
    });

    test('path resolution - relative paths', () {
      final resolved = state.resolvePath('file.txt');
      expect(resolved, '${tempDir.path}/file.txt');
    });

    test('path resolution - absolute paths', () {
      final absolutePath = '/absolute/path/file.txt';
      final resolved = state.resolvePath(absolutePath);
      expect(resolved, absolutePath);
    });

    test('path resolution - tilde expansion', () {
      final home = Platform.environment['HOME'] ?? '/tmp';
      final resolved = state.resolvePath('~/test.txt');
      expect(resolved, '$home/test.txt');
    });
  });

  group('ExecutionContext', () {
    test('multiline mode management', () {
      final context = ExecutionContext(
        workingDirectory: '/test',
        sourceFile: null,
        recordToSession: true,
        silent: false,
      );

      expect(context.isMultilineMode, false);
      expect(context.multilineMode, MultilineMode.none);

      context.startMultilineMode(MultilineMode.script);
      expect(context.isMultilineMode, true);
      expect(context.multilineMode, MultilineMode.script);

      context.addMultilineLine('line 1');
      context.addMultilineLine('line 2');
      expect(context.multilineBuffer, ['line 1', 'line 2']);
      expect(context.getMultilineCode(), 'line 1\nline 2');

      context.clearMultilineBuffer();
      expect(context.multilineBuffer, isEmpty);
      expect(context.multilineMode, MultilineMode.none);
    });
  });

  group('ContextStack', () {
    test('initial state', () {
      final stack = ContextStack('/test');
      expect(stack.cwd, '/test');
      expect(stack.silent, false);
      expect(stack.recordToSession, true);
    });

    test('push and pop contexts', () {
      final stack = ContextStack('/root');

      stack.push(ExecutionContext(
        workingDirectory: '/nested',
        sourceFile: 'test.d4rt',
        recordToSession: false,
        silent: true,
      ));

      expect(stack.cwd, '/nested');
      expect(stack.silent, true);
      expect(stack.recordToSession, false);

      stack.pop();
      expect(stack.cwd, '/root');
      expect(stack.silent, false);
    });

    test('cannot pop root context', () {
      final stack = ContextStack('/root');
      expect(stack.pop, throwsStateError);
    });
  });

  group('D4rtCliController', () {
    late D4rt d4rt;
    late CliState state;
    late D4rtCliController controller;
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('cli_controller_test_');
      d4rt = D4rt();
      d4rt.grant(FilesystemPermission.any);

      state = CliState(
        dataDirectory: tempDir.path,
        initialDirectory: tempDir.path,
      );

      controller = D4rtCliController(
        d4rt: d4rt,
        state: state,
        toolName: 'Test',
      );
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('basic properties', () {
      expect(controller.toolName, 'Test');
      expect(controller.dataDirectory, tempDir.path);
      expect(controller.d4rt, d4rt);
    });

    test('directory navigation', () {
      expect(controller.cwd(), tempDir.path);

      // Create subdirectory
      final subDir = Directory('${tempDir.path}/sub');
      subDir.createSync();

      controller.cd('sub');
      expect(controller.cwd(), subDir.path);

      controller.home();
      expect(controller.cwd(), tempDir.path);
    });

    test('ls lists directory contents', () {
      // Create some files and directories
      File('${tempDir.path}/file1.txt').createSync();
      File('${tempDir.path}/file2.dart').createSync();
      Directory('${tempDir.path}/subdir').createSync();

      final listing = controller.ls();
      // Listing should contain our created files
      expect(listing, contains('file1.txt'));
      expect(listing, contains('file2.dart'));
      // Directory should have trailing slash
      expect(listing, contains('subdir/'));
    });

    test('defines work correctly', () {
      controller.define('hello', 'print("Hello, World!")');
      expect(controller.defines(), {'hello': 'print("Hello, World!")'});

      expect(controller.undefine('hello'), true);
      expect(controller.defines(), isEmpty);
      expect(controller.undefine('nonexistent'), false);
    });

    test('eval executes expressions', () async {
      // Need to execute something first to set up the context
      await controller.execute('void main() {}');
      final result = await controller.eval('1 + 2');
      expect(result, 3);
    });

    test('multiline mode', () {
      expect(controller.isMultilineMode, false);

      controller.startScript();
      expect(controller.isMultilineMode, true);
      expect(controller.multilineMode, MultilineMode.script);

      controller.clearMultilineBuffer();
      expect(controller.isMultilineMode, false);
    });

    test('help returns help text', () {
      final help = controller.help();
      expect(help, isNotEmpty);
    });

    test('info without name returns tool info', () {
      final info = controller.info();
      expect(info, isNotNull);
      expect(info!.name, 'Test');
      expect(info.kind, SymbolKind.package);
    });

    test('processPrompt handles comments', () async {
      final result = await controller.processPrompt('# this is a comment');
      expect(result, isNull);
    });

    test('processPrompt handles empty lines', () async {
      final result = await controller.processPrompt('   ');
      expect(result, isNull);
    });

    test('execute runs code in fresh environment', () async {
      // Execute runs a complete program, not just an expression
      final result = await controller.execute('void main() { print(42); }');
      // Success means no errors during execution
      expect(result.error, isNull);
    });
  });

  group('ExecuteResult', () {
    test('success result', () {
      final result = ExecuteResult.success(42);
      expect(result.success, true);
      expect(result.result, 42);
      expect(result.error, isNull);
    });

    test('failure result', () {
      final result = ExecuteResult.failure('Something went wrong');
      expect(result.success, false);
      expect(result.result, isNull);
      expect(result.error, 'Something went wrong');
    });
  });

  group('CliExceptions', () {
    test('CliException', () {
      final ex = CliException('test error');
      expect(ex.message, 'test error');
      expect(ex.toString(), contains('test error'));
    });

    test('CliFileNotFoundException', () {
      final ex = CliFileNotFoundException('/path/to/file.txt');
      expect(ex.path, '/path/to/file.txt');
      expect(ex.toString(), contains('/path/to/file.txt'));
    });

    test('DirectoryNotFoundException', () {
      final ex = DirectoryNotFoundException('/path/to/dir');
      expect(ex.path, '/path/to/dir');
    });

    test('ReplayException', () {
      final inner = CliException('inner error');
      final ex = ReplayException('test.d4rt', 10, inner);
      expect(ex.file, 'test.d4rt');
      expect(ex.line, 10);
      expect(ex.cause, inner);
      expect(ex.toString(), contains('test.d4rt:10'));
    });
  });
}
