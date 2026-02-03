/// Tests for the script_execution module.
///
/// Tests file-based script execution with import resolution.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('ScriptExecutionResult', () {
    test('success creates successful result', () {
      final result = ScriptExecutionResult.success(42, 3);

      expect(result.success, isTrue);
      expect(result.result, equals(42));
      expect(result.error, isNull);
      expect(result.stackTrace, isNull);
      expect(result.sourcesLoaded, equals(3));
    });

    test('failure creates failed result', () {
      final result = ScriptExecutionResult.failure(
        'Something went wrong',
        sourcesLoaded: 1,
      );

      expect(result.success, isFalse);
      expect(result.result, isNull);
      expect(result.error, equals('Something went wrong'));
      expect(result.sourcesLoaded, equals(1));
    });

    test('failure with stack trace', () {
      final stackTrace = StackTrace.current;
      final result = ScriptExecutionResult.failure(
        'Error occurred',
        stackTrace: stackTrace,
      );

      expect(result.success, isFalse);
      expect(result.stackTrace, equals(stackTrace));
    });
  });

  group('executeFile', () {
    late D4rt d4rt;
    late Directory tempDir;

    setUp(() {
      d4rt = D4rt();
      tempDir = Directory.systemTemp.createTempSync('d4rt_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('executes simple script file', () {
      final scriptFile = File('${tempDir.path}/simple.dart');
      scriptFile.writeAsStringSync('''
void main() {
  print('Hello from script');
}

int getValue() => 42;
''');

      final result = executeFile(d4rt, scriptFile.path);

      expect(result.success, isTrue);
      expect(result.sourcesLoaded, greaterThanOrEqualTo(1));
    });

    test('returns failure for non-existent file', () {
      final result = executeFile(d4rt, '${tempDir.path}/non_existent.dart');

      expect(result.success, isFalse);
      expect(result.error, contains('File not found'));
    });

    test('executes script with main returning value', () {
      final scriptFile = File('${tempDir.path}/return_value.dart');
      scriptFile.writeAsStringSync('''
main() {
  return 42;
}
''');

      final result = executeFile(d4rt, scriptFile.path);

      expect(result.success, isTrue);
      expect(result.result, equals(42));
    });

    test('executes script with relative import', () {
      // Create a helper file
      final helperFile = File('${tempDir.path}/helper.dart');
      helperFile.writeAsStringSync('''
int add(int a, int b) => a + b;
''');

      // Create main script that imports the helper
      final mainFile = File('${tempDir.path}/main.dart');
      mainFile.writeAsStringSync('''
import 'helper.dart';

main() {
  return add(10, 20);
}
''');

      final result = executeFile(d4rt, mainFile.path);

      expect(result.success, isTrue);
      expect(result.result, equals(30));
      expect(result.sourcesLoaded, equals(2)); // main + helper
    });

    test('handles nested imports', () {
      // Create base utility
      final utilsFile = File('${tempDir.path}/utils.dart');
      utilsFile.writeAsStringSync('''
int multiply(int a, int b) => a * b;
''');

      // Create math library that imports utils
      final mathFile = File('${tempDir.path}/math_lib.dart');
      mathFile.writeAsStringSync('''
import 'utils.dart';

int square(int x) => multiply(x, x);
''');

      // Create main script that imports math
      final mainFile = File('${tempDir.path}/main.dart');
      mainFile.writeAsStringSync('''
import 'math_lib.dart';

main() {
  return square(5);
}
''');

      final result = executeFile(d4rt, mainFile.path);

      expect(result.success, isTrue);
      expect(result.result, equals(25));
      expect(result.sourcesLoaded, equals(3)); // main + math_lib + utils
    });

    test('provides logging callback', () {
      final logs = <String>[];

      final scriptFile = File('${tempDir.path}/logged.dart');
      scriptFile.writeAsStringSync('''
main() => 'logged';
''');

      executeFile(
        d4rt,
        scriptFile.path,
        log: (message) => logs.add(message),
      );

      // Should have at least logged the main file
      expect(logs, isNotEmpty);
    });
  });

  group('executeSource', () {
    late D4rt d4rt;
    late Directory tempDir;

    setUp(() {
      d4rt = D4rt();
      tempDir = Directory.systemTemp.createTempSync('d4rt_source_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('executes simple source code', () {
      const source = '''
main() {
  return 100;
}
''';

      final result = executeSource(d4rt, source, tempDir.path);

      expect(result.success, isTrue);
      expect(result.result, equals(100));
    });

    test('resolves imports from basePath', () {
      // Create a helper file in tempDir
      final helperFile = File('${tempDir.path}/helper.dart');
      helperFile.writeAsStringSync('''
String greet(String name) => 'Hello, \$name!';
''');

      // Execute source that imports the helper
      const source = '''
import 'helper.dart';

main() {
  return greet('World');
}
''';

      final result = executeSource(d4rt, source, tempDir.path);

      expect(result.success, isTrue);
      expect(result.result, equals('Hello, World!'));
    });

    test('uses custom script name', () {
      const source = 'main() => "test";';

      final result = executeSource(
        d4rt,
        source,
        tempDir.path,
        scriptName: 'custom_script.dart',
      );

      expect(result.success, isTrue);
    });
  });

  group('executeFileContinued', () {
    late D4rt d4rt;
    late Directory tempDir;

    setUp(() {
      d4rt = D4rt();
      // Initialize with a basic script first
      d4rt.execute(source: '''
void main() {}
var existingValue = 'from-init';
''');
      tempDir = Directory.systemTemp.createTempSync('d4rt_continued_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('continues execution in existing environment', () {
      final scriptFile = File('${tempDir.path}/continued.dart');
      scriptFile.writeAsStringSync('''
var newValue = existingValue;
''');

      final result = executeFileContinued(d4rt, scriptFile.path);

      expect(result.success, isTrue);
      // After eval, we can access the new variable which references existing
      final evalResult = d4rt.eval('newValue');
      expect(evalResult, equals('from-init'));
    });

    test('adds declarations to global environment', () {
      final scriptFile = File('${tempDir.path}/declarations.dart');
      scriptFile.writeAsStringSync('''
int computeValue() => 42;
''');

      final result = executeFileContinued(d4rt, scriptFile.path);
      expect(result.success, isTrue);

      // The function should now be available via eval
      final evalResult = d4rt.eval('computeValue()');
      expect(evalResult, equals(42));
    });

    test('returns failure for non-existent file', () {
      final result = executeFileContinued(
        d4rt,
        '${tempDir.path}/non_existent.dart',
      );

      expect(result.success, isFalse);
      expect(result.error, contains('File not found'));
    });
  });

  group('resolveImportsRecursively', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('d4rt_imports_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('resolves relative imports', () {
      // Create files
      final libFile = File('${tempDir.path}/lib.dart');
      libFile.writeAsStringSync('int libValue = 10;');

      final mainSource = "import 'lib.dart';\nmain() => libValue;";
      final mainUri = 'file://${tempDir.path}/main.dart';

      final sources = <String, String>{};
      resolveImportsRecursively(mainSource, mainUri, sources, null);

      expect(sources.containsKey(mainUri), isTrue);
      expect(sources.containsKey('file://${tempDir.path}/lib.dart'), isTrue);
      expect(sources.length, equals(2));
    });

    test('handles circular imports gracefully', () {
      // Create files that import each other
      final aFile = File('${tempDir.path}/a.dart');
      aFile.writeAsStringSync("import 'b.dart';\nint aValue = 1;");

      final bFile = File('${tempDir.path}/b.dart');
      bFile.writeAsStringSync("import 'a.dart';\nint bValue = 2;");

      final mainSource = "import 'a.dart';\nimport 'b.dart';";
      final mainUri = 'file://${tempDir.path}/main.dart';

      final sources = <String, String>{};

      // Should not throw or loop infinitely
      resolveImportsRecursively(mainSource, mainUri, sources, null);

      expect(sources.length, equals(3)); // main, a, b
    });

    test('skips dart: and package: imports', () {
      const source = '''
import 'dart:core';
import 'dart:async';
import 'package:some_package/some_file.dart';
main() {}
''';

      final mainUri = 'file://${tempDir.path}/main.dart';
      final sources = <String, String>{};

      resolveImportsRecursively(source, mainUri, sources, null);

      // Only the main file should be in sources
      expect(sources.length, equals(1));
      expect(sources.containsKey(mainUri), isTrue);
    });

    test('handles imports with double quotes', () {
      final libFile = File('${tempDir.path}/double_quoted.dart');
      libFile.writeAsStringSync('int value = 5;');

      const source = 'import "double_quoted.dart";';
      final mainUri = 'file://${tempDir.path}/main.dart';

      final sources = <String, String>{};
      resolveImportsRecursively(source, mainUri, sources, null);

      expect(sources.length, equals(2));
    });
  });
}
