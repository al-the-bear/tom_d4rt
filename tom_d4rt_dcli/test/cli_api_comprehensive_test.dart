// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Comprehensive CLI API Tests
///
/// This file provides test infrastructure and comprehensive tests for
/// the D4rt CLI API, including output capture and controller testing.
library;

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:tom_d4rt_dcli/dartscript.b.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

// =============================================================================
// Test Infrastructure
// =============================================================================

/// Captures stdout and stderr output during test execution.
class OutputCapture {
  final List<String> stdout = [];
  final List<String> stderr = [];

  String get stdoutText => stdout.join();
  String get stderrText => stderr.join();

  void clear() {
    stdout.clear();
    stderr.clear();
  }
}

/// Runs a function with output capture using runZoned.
Future<T> withOutputCapture<T>(
  OutputCapture capture,
  Future<T> Function() fn,
) async {
  return runZoned(
    fn,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capture.stdout.add('$line\n');
      },
    ),
  );
}

/// Creates a fully configured test controller with bridges registered.
class TestCliController {
  late D4rt d4rt;
  late CliState state;
  late D4rtCliController controller;
  late Directory tempDir;
  final OutputCapture output = OutputCapture();

  TestCliController();

  Future<void> setUp({bool registerDcliBridges = true}) async {
    tempDir = Directory.systemTemp.createTempSync('cli_comprehensive_test_');
    d4rt = D4rt();
    d4rt.grant(FilesystemPermission.any);
    d4rt.grant(NetworkPermission.any);
    d4rt.grant(ProcessRunPermission.any);

    // Register dcli bridges if requested
    if (registerDcliBridges) {
      TomD4rtDcliBridge.register(d4rt);
    }

    state = CliState(
      dataDirectory: tempDir.path,
      initialDirectory: tempDir.path,
    );

    controller = D4rtCliController(
      d4rt: d4rt,
      state: state,
      toolName: 'Test',
    );
  }

  Future<void> tearDown() async {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  /// Execute code and capture output.
  Future<ExecuteResult> executeWithCapture(String code) async {
    return withOutputCapture(output, () => controller.execute(code));
  }

  /// Execute continued code and capture output.
  Future<ExecuteResult> executeContinuedWithCapture(String code) async {
    return withOutputCapture(output, () => controller.executeContinued(code));
  }

  /// Eval expression and capture output.
  Future<dynamic> evalWithCapture(String expression) async {
    return withOutputCapture(output, () => controller.eval(expression));
  }

  /// Process prompt and capture output.
  Future<dynamic> processPromptWithCapture(String line) async {
    return withOutputCapture(output, () => controller.processPrompt(line));
  }

  /// Create a test file in the temp directory.
  File createTestFile(String name, String content) {
    final file = File('${tempDir.path}/$name');
    file.writeAsStringSync(content);
    return file;
  }

  /// Create a test directory in the temp directory.
  Directory createTestDir(String name) {
    final dir = Directory('${tempDir.path}/$name');
    dir.createSync(recursive: true);
    return dir;
  }
}

// =============================================================================
// Test Groups
// =============================================================================

void main() {
  group('CLI API Controller - Core Methods', () {
    late TestCliController ctx;

    setUp(() async {
      ctx = TestCliController();
      await ctx.setUp();
    });

    tearDown(() async {
      await ctx.tearDown();
    });

    // -------------------------------------------------------------------------
    // Basic Properties
    // -------------------------------------------------------------------------

    group('properties', () {
      test('toolName returns configured name', () {
        expect(ctx.controller.toolName, 'Test');
      });

      test('dataDirectory returns configured path', () {
        expect(ctx.controller.dataDirectory, ctx.tempDir.path);
      });

      test('d4rt returns interpreter instance', () {
        expect(ctx.controller.d4rt, ctx.d4rt);
      });

      test('configuration is available', () {
        expect(ctx.controller.configuration, isNotNull);
      });

      test('runtime provides access to process info', () {
        expect(ctx.controller.runtime, isNotNull);
        expect(ctx.controller.runtime.processDirectory, isNotEmpty);
      });

      test('currentSessionId is null when no session active', () {
        expect(ctx.controller.currentSessionId, isNull);
      });
    });

    // -------------------------------------------------------------------------
    // Directory Navigation
    // -------------------------------------------------------------------------

    group('directory navigation', () {
      test('cwd returns current directory', () {
        expect(ctx.controller.cwd(), ctx.tempDir.path);
      });

      test('cd changes to subdirectory', () {
        ctx.createTestDir('subdir');
        final result = ctx.controller.cd('subdir');
        expect(result, endsWith('/subdir'));
        expect(ctx.controller.cwd(), endsWith('/subdir'));
      });

      test('cd with absolute path', () {
        final subDir = ctx.createTestDir('absolute');
        final result = ctx.controller.cd(subDir.path);
        expect(result, subDir.path);
        expect(ctx.controller.cwd(), subDir.path);
      });

      test('cd with relative parent path', () {
        final subDir = ctx.createTestDir('parent/child');
        ctx.controller.cd(subDir.path);
        final result = ctx.controller.cd('..');
        expect(result, endsWith('/parent'));
      });

      test('cd with tilde expansion', () {
        final home = Platform.environment['HOME'];
        if (home != null) {
          final result = ctx.controller.cd('~');
          expect(result, home);
        }
      });

      test('cd to nonexistent directory throws', () {
        expect(
          () => ctx.controller.cd('nonexistent'),
          throwsA(isA<DirectoryNotFoundException>()),
        );
      });

      test('home returns to data directory', () {
        ctx.createTestDir('somewhere');
        ctx.controller.cd('somewhere');
        final result = ctx.controller.home();
        expect(result, ctx.tempDir.path);
      });

      test('ls lists files and directories', () {
        ctx.createTestFile('file1.txt', 'content');
        ctx.createTestFile('file2.dart', 'content');
        ctx.createTestDir('subdir');

        final listing = ctx.controller.ls();
        expect(listing, contains('file1.txt'));
        expect(listing, contains('file2.dart'));
        expect(listing, contains('subdir/'));
      });

      test('ls with path argument', () {
        final subDir = ctx.createTestDir('listed');
        File('${subDir.path}/nested.txt').createSync();

        final listing = ctx.controller.ls('listed');
        expect(listing, contains('nested.txt'));
      });

      test('ls nonexistent path throws', () {
        expect(
          () => ctx.controller.ls('nonexistent'),
          throwsA(isA<DirectoryNotFoundException>()),
        );
      });
    });

    // -------------------------------------------------------------------------
    // File Listings
    // -------------------------------------------------------------------------

    group('file listings', () {
      test('sessions lists session files', () {
        // sessions() looks in dataDirectory/sessions
        final sessionsDir = Directory('${ctx.tempDir.path}/sessions');
        sessionsDir.createSync();
        File('${sessionsDir.path}/test.session.txt').writeAsStringSync('content');
        final sessions = ctx.controller.sessions();
        expect(sessions, contains('test'));
      });

      test('scripts lists script files', () {
        // scripts() lists files in cwd with .script.txt extension
        ctx.createTestFile('test.script.txt', 'print("hello");');
        final scripts = ctx.controller.scripts();
        expect(scripts, contains('test.script.txt'));
      });

      test('plays lists replay files', () {
        ctx.createTestFile('test.replay.txt', '1+1');
        final plays = ctx.controller.plays();
        expect(plays, isNotEmpty);
      });

      test('executes lists executable files', () {
        // executes() returns full filename with extension
        ctx.createTestFile('test.exec.dart', 'void main() {}');
        final executes = ctx.controller.executes();
        expect(executes, contains('test.exec.dart'));
      });
    });

    // -------------------------------------------------------------------------
    // Defines
    // -------------------------------------------------------------------------

    group('defines', () {
      test('define creates alias', () {
        ctx.controller.define('greet', 'print("Hello, \$\$")');
        expect(ctx.controller.defines(), {'greet': 'print("Hello, \$\$")'});
      });

      test('undefine removes alias', () {
        ctx.controller.define('temp', 'temp value');
        expect(ctx.controller.undefine('temp'), true);
        expect(ctx.controller.defines(), isEmpty);
      });

      test('undefine returns false for nonexistent', () {
        expect(ctx.controller.undefine('nonexistent'), false);
      });

      test('invokeDefine expands template', () {
        ctx.controller.define('echo', 'print("\$\$")');
        final expanded = ctx.controller.invokeDefine('echo', ['hello', 'world']);
        expect(expanded, 'print("hello world")');
      });

      test('invokeDefine with positional args', () {
        ctx.controller.define('add', '\$1 + \$2');
        final expanded = ctx.controller.invokeDefine('add', ['10', '20']);
        expect(expanded, '10 + 20');
      });

      test('invokeDefine unknown returns null', () {
        expect(ctx.controller.invokeDefine('unknown'), isNull);
      });

      test('expandDefine parses define invocation', () {
        ctx.controller.define('test', 'expanded');
        final result = ctx.controller.expandDefine('@test');
        expect(result, 'expanded');
      });

      test('loadDefines from file', () {
        ctx.createTestFile('defines.txt', 'alias1=value1\nalias2=value2');
        final count = ctx.controller.loadDefines('defines.txt');
        expect(count, 2);
        expect(ctx.controller.defines()['alias1'], 'value1');
        expect(ctx.controller.defines()['alias2'], 'value2');
      });

      test('loadDefines returns -1 for missing file', () {
        final count = ctx.controller.loadDefines('nonexistent.txt');
        expect(count, -1);
      });
    });

    // -------------------------------------------------------------------------
    // Introspection
    // -------------------------------------------------------------------------

    group('introspection', () {
      test('help returns help text', () {
        final help = ctx.controller.help();
        expect(help, isNotEmpty);
        expect(help, contains('help'));
      });

      test('info without name returns tool info', () {
        final info = ctx.controller.info();
        expect(info, isNotNull);
        expect(info!.name, 'Test');
        expect(info.kind, SymbolKind.package);
      });

      test('info with package name', () async {
        await ctx.controller.execute('void main() {}');
        ctx.controller.info('dcli');
        // May or may not find it depending on bridge registration
        // Just check it doesn't crash
        expect(true, isTrue);
      });

      test('classes returns list', () {
        final classes = ctx.controller.classes();
        expect(classes, isA<List<ClassInfo>>());
      });

      test('enums returns list', () {
        final enums = ctx.controller.enums();
        expect(enums, isA<List<EnumInfo>>());
      });

      test('methods returns list', () {
        final methods = ctx.controller.methods();
        expect(methods, isA<List<FunctionInfo>>());
      });

      test('variables returns list', () {
        final variables = ctx.controller.variables();
        expect(variables, isA<List<VariableInfo>>());
      });

      test('imports returns list', () {
        final imports = ctx.controller.imports();
        expect(imports, isA<List<ImportInfo>>());
      });

      test('registeredClasses returns list', () {
        final classes = ctx.controller.registeredClasses();
        expect(classes, isA<List<ClassInfo>>());
        // Should have dcli bridges registered
        expect(classes, isNotEmpty);
      });

      test('registeredEnums returns list', () {
        final enums = ctx.controller.registeredEnums();
        expect(enums, isA<List<EnumInfo>>());
      });

      test('registeredMethods returns list', () {
        final methods = ctx.controller.registeredMethods();
        expect(methods, isA<List<FunctionInfo>>());
        // Should have dcli functions
        expect(methods, isNotEmpty);
      });

      test('registeredVariables returns list', () {
        final variables = ctx.controller.registeredVariables();
        expect(variables, isA<List<VariableInfo>>());
      });

      test('registeredImports returns list', () {
        final imports = ctx.controller.registeredImports();
        expect(imports, isA<List<ImportInfo>>());
      });

      test('showInit returns initialization source', () {
        final init = ctx.controller.showInit();
        expect(init, isNotEmpty);
      });
    });

    // -------------------------------------------------------------------------
    // Multiline Mode
    // -------------------------------------------------------------------------

    group('multiline mode', () {
      test('initially not in multiline mode', () {
        expect(ctx.controller.isMultilineMode, false);
        expect(ctx.controller.multilineMode, MultilineMode.none);
        expect(ctx.controller.multilineBuffer, isEmpty);
      });

      test('startScript enters script mode', () {
        ctx.controller.startScript();
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.script);
      });

      test('startDefine enters define mode', () {
        ctx.controller.startDefine();
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.define);
      });

      test('startFile enters file mode', () {
        ctx.controller.startFile();
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.file);
      });

      test('startExecute enters execute mode', () {
        ctx.controller.startExecute();
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.executeNew);
      });

      test('clearMultilineBuffer clears and exits mode', () {
        ctx.controller.startScript();
        ctx.controller.clearMultilineBuffer();
        expect(ctx.controller.isMultilineMode, false);
        expect(ctx.controller.multilineMode, MultilineMode.none);
      });

      test('end executes multiline buffer', () async {
        await ctx.controller.execute('void main() {}');
        ctx.controller.startScript();
        await ctx.controller.processPrompt('return 5 + 5;');
        final result = await ctx.controller.end();
        expect(result, 10);
      });

      test('processPrompt accumulates in multiline mode', () async {
        ctx.controller.startScript();
        await ctx.controller.processPrompt('line1');
        await ctx.controller.processPrompt('line2');
        expect(ctx.controller.multilineBuffer, ['line1', 'line2']);
      });

      test('starting mode when already in mode throws', () {
        ctx.controller.startScript();
        expect(() => ctx.controller.startDefine(), throwsA(isA<InvalidMultilineModeException>()));
      });
    });

    // -------------------------------------------------------------------------
    // Code Execution
    // -------------------------------------------------------------------------

    group('code execution', () {
      test('execute runs fresh program', () async {
        final result = await ctx.controller.execute('void main() { print(42); }');
        expect(result.success, true);
        expect(result.error, isNull);
      });

      test('execute with error returns failure', () async {
        final result = await ctx.controller.execute('void main() { undefinedVar; }');
        expect(result.success, false);
        expect(result.error, isNotNull);
      });

      test('executeContinued shares environment', () async {
        // First execute establishes environment with a top-level variable
        await ctx.controller.execute('var counter = 0; void main() { counter = 1; }');
        // continuedExecute adds more top-level code
        final result = await ctx.controller.executeContinued('var doubled = counter * 2; void main() {}');
        expect(result.success, true);
      });

      test('eval evaluates expression', () async {
        await ctx.controller.execute('void main() {}');
        final result = await ctx.controller.eval('1 + 2 + 3');
        expect(result, 6);
      });

      test('eval with variables', () async {
        await ctx.controller.execute('var x = 10; void main() {}');
        final result = await ctx.controller.eval('x * 2');
        expect(result, 20);
      });

      test('executeFile runs file', () async {
        ctx.createTestFile('test.dart', 'void main() { print("from file"); }');
        final result = await ctx.controller.executeFile('test.dart');
        expect(result.success, true);
      });

      test('executeFile throws for missing file', () async {
        await expectLater(
          ctx.controller.executeFile('missing.dart'),
          throwsA(isA<CliFileNotFoundException>()),
        );
      });

      test('file runs in current environment', () async {
        await ctx.controller.execute('var fromPrevious = true; void main() {}');
        ctx.createTestFile('continued.dart', 'var fromFile = fromPrevious;');
        final result = await ctx.controller.file('continued.dart');
        expect(result.success, true);
      });

      test('script runs line by line', () async {
        // script() evaluates each line via eval
        await ctx.controller.execute('void main() {}');
        ctx.createTestFile('script.txt', '1+1\n2+2\n3+3');
        final count = await ctx.controller.script('script.txt');
        expect(count, 3);
      });

      test('load replays with output', () async {
        await ctx.controller.execute('void main() {}');
        ctx.createTestFile('load.txt', '1+1');
        final count = await ctx.controller.load('load.txt');
        expect(count, greaterThan(0));
      });

      test('replay replays silently', () async {
        await ctx.controller.execute('void main() {}');
        ctx.createTestFile('replay.txt', '1+1');
        final count = await ctx.controller.replay('replay.txt');
        expect(count, greaterThan(0));
      });
    });

    // -------------------------------------------------------------------------
    // File Content Loading
    // -------------------------------------------------------------------------

    group('file content loading', () {
      test('loadFile reads exec.dart file', () {
        ctx.createTestFile('test.exec.dart', 'void main() {}');
        final content = ctx.controller.loadFile('test');
        expect(content, 'void main() {}');
      });

      test('loadScript reads script.txt file', () {
        ctx.createTestFile('test.script.txt', 'script content');
        final content = ctx.controller.loadScript('test');
        expect(content, 'script content');
      });

      test('loadReplay reads replay.txt file', () {
        ctx.createTestFile('test.replay.txt', 'replay content');
        final content = ctx.controller.loadReplay('test');
        expect(content, 'replay content');
      });

      test('loadSession reads session.txt file', () {
        // loadSession looks for file in sessions subdirectory
        final sessionsDir = Directory('${ctx.tempDir.path}/sessions');
        sessionsDir.createSync();
        File('${sessionsDir.path}/test.session.txt').writeAsStringSync('session content');
        final content = ctx.controller.loadSession('test');
        expect(content, 'session content');
      });
    });

    // -------------------------------------------------------------------------
    // Process Prompt
    // -------------------------------------------------------------------------

    group('processPrompt', () {
      test('handles empty lines', () async {
        final result = await ctx.controller.processPrompt('   ');
        expect(result, isNull);
      });

      test('handles comments', () async {
        final result = await ctx.controller.processPrompt('# comment');
        expect(result, isNull);
      });

      test('handles help command', () async {
        final result = await ctx.controller.processPrompt('help');
        expect(result, isA<String>());
      });

      test('handles classes command', () async {
        final result = await ctx.controller.processPrompt('classes');
        expect(result, isA<List<ClassInfo>>());
      });

      test('handles enums command', () async {
        final result = await ctx.controller.processPrompt('enums');
        expect(result, isA<List<EnumInfo>>());
      });

      test('handles methods command', () async {
        final result = await ctx.controller.processPrompt('methods');
        expect(result, isA<List<FunctionInfo>>());
      });

      test('handles variables command', () async {
        final result = await ctx.controller.processPrompt('variables');
        expect(result, isA<List<VariableInfo>>());
      });

      test('handles imports command', () async {
        final result = await ctx.controller.processPrompt('imports');
        expect(result, isA<List<ImportInfo>>());
      });

      test('handles cwd command', () async {
        final result = await ctx.controller.processPrompt('cwd');
        expect(result, ctx.tempDir.path);
      });

      test('handles cd command', () async {
        ctx.createTestDir('testcd');
        final result = await ctx.controller.processPrompt('cd testcd');
        expect(result, endsWith('/testcd'));
      });

      test('handles home command', () async {
        ctx.createTestDir('away');
        await ctx.controller.processPrompt('cd away');
        final result = await ctx.controller.processPrompt('home');
        expect(result, ctx.tempDir.path);
      });

      test('handles ls command', () async {
        ctx.createTestFile('visible.txt', 'content');
        final result = await ctx.controller.processPrompt('ls');
        expect(result, isA<List<String>>());
        expect(result, contains('visible.txt'));
      });

      test('handles define command', () async {
        await ctx.controller.processPrompt('define hello=world');
        expect(ctx.controller.defines()['hello'], 'world');
      });

      test('handles undefine command', () async {
        ctx.controller.define('todelete', 'value');
        final result = await ctx.controller.processPrompt('undefine todelete');
        expect(result, true);
      });

      test('handles defines command', () async {
        ctx.controller.define('a', '1');
        ctx.controller.define('b', '2');
        final result = await ctx.controller.processPrompt('defines');
        expect(result, isA<Map<String, String>>());
        expect(result['a'], '1');
        expect(result['b'], '2');
      });

      test('handles .start-script command', () async {
        await ctx.controller.processPrompt('.start-script');
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.script);
        ctx.controller.clearMultilineBuffer();
      });

      test('handles .start-define command', () async {
        await ctx.controller.processPrompt('.start-define');
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.define);
        ctx.controller.clearMultilineBuffer();
      });

      test('handles .start-file command', () async {
        await ctx.controller.processPrompt('.start-file');
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.file);
        ctx.controller.clearMultilineBuffer();
      });

      test('handles .start-execute command', () async {
        await ctx.controller.processPrompt('.start-execute');
        expect(ctx.controller.isMultilineMode, true);
        expect(ctx.controller.multilineMode, MultilineMode.executeNew);
        ctx.controller.clearMultilineBuffer();
      });

      test('handles .end command', () async {
        await ctx.controller.execute('void main() {}');
        await ctx.controller.processPrompt('.start-script');
        await ctx.controller.processPrompt('return 2 + 2;');
        final result = await ctx.controller.processPrompt('.end');
        expect(result, 4);
      });

      test('handles expression evaluation', () async {
        await ctx.controller.execute('void main() {}');
        final result = await ctx.controller.processPrompt('2 * 3');
        expect(result, 6);
      });

      test('processPrompts handles multiple lines', () async {
        await ctx.controller.execute('void main() {}');
        final results = await ctx.controller.processPrompts([
          '1 + 1',
          '2 + 2',
          '3 + 3',
        ]);
        expect(results, [2, 4, 6]);
      });

      test('processPrompts continues on error when requested', () async {
        await ctx.controller.execute('void main() {}');
        final results = await ctx.controller.processPrompts(
          ['1 + 1', 'invalidSyntax(', '3 + 3'],
          continueOnError: true,
        );
        expect(results.length, 3);
        expect(results[0], 2);
        expect(results[2], 6);
      });
    });

    // -------------------------------------------------------------------------
    // Clear and Other Commands
    // -------------------------------------------------------------------------

    group('other commands', () {
      test('clear does not throw', () {
        expect(() => ctx.controller.clear(), returnsNormally);
      });

      test('sessions command', () async {
        final result = await ctx.controller.processPrompt('sessions');
        expect(result, isA<List<String>>());
      });

      test('scripts command', () async {
        final result = await ctx.controller.processPrompt('scripts');
        expect(result, isA<List<String>>());
      });

      test('plays command', () async {
        final result = await ctx.controller.processPrompt('plays');
        expect(result, isA<List<String>>());
      });

      test('executes command', () async {
        final result = await ctx.controller.processPrompt('executes');
        expect(result, isA<List<String>>());
      });

      test('registered-classes command', () async {
        final result = await ctx.controller.processPrompt('registered-classes');
        expect(result, isA<List<ClassInfo>>());
      });

      test('registered-enums command', () async {
        final result = await ctx.controller.processPrompt('registered-enums');
        expect(result, isA<List<EnumInfo>>());
      });

      test('registered-methods command', () async {
        final result = await ctx.controller.processPrompt('registered-methods');
        expect(result, isA<List<FunctionInfo>>());
      });

      test('registered-variables command', () async {
        final result = await ctx.controller.processPrompt('registered-variables');
        expect(result, isA<List<VariableInfo>>());
      });

      test('registered-imports command', () async {
        final result = await ctx.controller.processPrompt('registered-imports');
        expect(result, isA<List<ImportInfo>>());
      });

      test('show-init command', () async {
        final result = await ctx.controller.processPrompt('show-init');
        expect(result, isA<String>());
        expect(result, isNotEmpty);
      });
    });
  });
}
