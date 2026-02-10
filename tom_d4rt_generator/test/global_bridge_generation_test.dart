/// Tests for bridge generator global function and variable handling.
///
/// These tests verify that the generator correctly:
/// - Detects global functions from source files
/// - Detects global variables (const, final, mutable)
/// - Generates globalFunctionNames and globalVariableNames lists
/// - Handles various parameter patterns
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('bridge_global_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Global Function Detection', () {
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      // Need to include a class source for the generator to produce output
      // The global functions/variables are included alongside classes
      final classSourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile = p.join(testFixturesDir, 'global_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'global_bridges_test.dart');

      result = await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty, 
          reason: 'Generator should produce output files');

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    group('Simple Functions', () {
      test('detects void function with no parameters [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'resetState'"));
      });

      test('detects function returning value [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'getRequestCount'"));
      });

      test('detects function with single parameter [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'greet'"));
      });

      test('detects function with multiple parameters [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'add'"));
      });

      test('detects function returning boolean [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'isValidName'"));
      });
    });

    group('Functions with Optional Parameters', () {
      test('detects function with optional positional parameter [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'formatMessage'"));
      });

      test('detects function with optional parameters and defaults [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'buildUrl'"));
      });

      test('detects function with named parameters [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'formatRecord'"));
      });

      test('detects function with mixed parameters [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'createEntry'"));
      });
    });

    group('Functions with Complex Types', () {
      test('detects function returning list [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'range'"));
      });

      test('detects function taking list parameter [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'sumList'"));
      });

      test('detects function returning map [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'createConfig'"));
      });

      test('detects function with nullable return [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'findMatch'"));
      });
    });

    group('Async Functions', () {
      test('detects async function [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'fetchData'"));
      });

      test('detects async function with parameters [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'computeAsync'"));
      });
    });

    group('Private Functions', () {
      test('skips private functions [2026-02-10 06:37]', () {
        expect(generatedCode, isNot(contains("'_internalHelper'")));
        expect(generatedCode, isNot(contains("'_calculateInternal'")));
      });
    });

    group('Error Handling Functions', () {
      test('detects function that may throw [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'divideStrict'"));
      });

      test('detects function with try-catch [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'divideSafe'"));
      });
    });
  });

  group('Global Variable Detection', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
      );

      // Include class source to ensure output is generated
      final classSourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile = p.join(testFixturesDir, 'global_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'global_vars_test.dart');

      await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile],
        outputPath: outputFile,
        moduleName: 'globals',
      );

      generatedCode = await File(outputFile).readAsString();
    });

    group('Constants', () {
      test('detects string constant [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'appName'"));
      });

      test('detects int constant [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'maxRetries'"));
      });

      test('detects double constant [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'defaultTimeout'"));
      });

      test('detects bool constant [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'debugMode'"));
      });
    });

    group('Final Variables', () {
      test('detects final string [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'version'"));
      });

      test('detects final list [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'supportedFormats'"));
      });

      test('detects final map [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'errorCodes'"));
      });
    });

    group('Mutable Variables', () {
      test('detects mutable int [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'requestCount'"));
      });

      test('detects mutable string [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'lastError'"));
      });

      test('detects nullable mutable variable [2026-02-10 06:37]', () {
        expect(generatedCode, contains("'lastRunTime'"));
      });
    });
  });

  group('Global Bridge Structure', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
      );

      // Include class source to ensure output is generated
      final classSourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile = p.join(testFixturesDir, 'global_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'global_struct_test.dart');

      await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      generatedCode = await File(outputFile).readAsString();
    });

    test('G-GB-1: generates globalFunctionNames list [2026-02-10 08:00]', () {
      expect(
        generatedCode,
        contains('static List<String> get globalFunctionNames'),
      );
    });

    test('G-GB-2: generates globalVariableNames list [2026-02-10 08:00]', () {
      expect(
        generatedCode,
        contains('static List<String> get globalVariableNames'),
      );
    });

    test('G-GB-3: generates getGlobalInitializationScript [2026-02-10 08:00]', () {
      expect(
        generatedCode,
        contains('static String getGlobalInitializationScript()'),
      );
    });
  });

  group('Function Signature Verification', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
      );

      // Include class source to ensure output is generated
      final classSourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile = p.join(testFixturesDir, 'global_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'func_sig_test.dart');

      await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile],
        outputPath: outputFile,
        moduleName: 'funcs',
      );

      generatedCode = await File(outputFile).readAsString();
    });

    test('function names are in globalFunctionNames list [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'greet'"));
      expect(generatedCode, contains("'add'"));
      expect(generatedCode, contains("'resetState'"));
    });

    test('async functions are included [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'fetchData'"));
      expect(generatedCode, contains("'computeAsync'"));
    });

    test('functions with named params are included [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'formatRecord'"));
      expect(generatedCode, contains("'createEntry'"));
    });

    test('private functions are excluded [2026-02-10 06:37]', () {
      expect(generatedCode, isNot(contains("'_internalHelper'")));
      expect(generatedCode, isNot(contains("'_calculateInternal'")));
    });
  });

  group('Variable Signature Verification', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
      );

      // Include class source to ensure output is generated
      final classSourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile = p.join(testFixturesDir, 'global_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'var_sig_test.dart');

      await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile],
        outputPath: outputFile,
        moduleName: 'vars',
      );

      generatedCode = await File(outputFile).readAsString();
    });

    test('constant names are in globalVariableNames list [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'appName'"));
      expect(generatedCode, contains("'maxRetries'"));
      expect(generatedCode, contains("'debugMode'"));
    });

    test('final variables are included [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'version'"));
      expect(generatedCode, contains("'supportedFormats'"));
    });

    test('mutable variables are included [2026-02-10 06:37]', () {
      expect(generatedCode, contains("'requestCount'"));
      expect(generatedCode, contains("'lastError'"));
    });

    test('G-GB-4: init script contains variable getters [2026-02-10 08:00]', () {
      // The getGlobalInitializationScript should contain getter definitions
      expect(generatedCode, contains('getGlobalInitializationScript'));
    });
  });

  group('Global Getter vs Variable Registration', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
      );

      final classSourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile =
          p.join(testFixturesDir, 'global_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'getter_vs_var_test.dart');

      await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile],
        outputPath: outputFile,
        moduleName: 'getters',
      );

      generatedCode = await File(outputFile).readAsString();
    });

    group('Regular Variables use registerGlobalVariable', () {
      test('G-GB-5: const vars use registerGlobalVariable [2026-02-10 08:00]', () {
        // Variable values are now prefixed with $pkg. since source imports use a prefix
        expect(
          generatedCode,
          contains(r"interpreter.registerGlobalVariable('appName', $pkg.appName)"),
        );
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('maxRetries', $pkg.maxRetries)"),
        );
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('debugMode', $pkg.debugMode)"),
        );
      });

      test('G-GB-6: final vars use registerGlobalVariable [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(r"interpreter.registerGlobalVariable('version', $pkg.version)"),
        );
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalVariable('supportedFormats', $pkg.supportedFormats)",
          ),
        );
      });

      test('G-GB-7: mutable vars use registerGlobalVariable [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalVariable('requestCount', $pkg.requestCount)",
          ),
        );
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('lastError', $pkg.lastError)"),
        );
      });
    });

    group('Top-level Getters use registerGlobalGetter', () {
      test('G-GB-8: getter singleton uses registerGlobalGetter [2026-02-10 08:00]', () {
        // Getter values are now prefixed with $pkg. since source imports use a prefix
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('globalService', () => $pkg.globalService)",
          ),
        );
      });

      test('G-GB-9: getter computed uses registerGlobalGetter [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('currentTime', () => $pkg.currentTime)",
          ),
        );
      });

      test('G-GB-10: nullable getter uses registerGlobalGetter [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('lastLogMessage', () => $pkg.lastLogMessage)",
          ),
        );
      });

      test('G-GB-11: mutable state getter registerGlobalGetter [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('doubleRequestCount', () => $pkg.doubleRequestCount)",
          ),
        );
      });
    });

    group('Getter vs Variable Separation', () {
      test('G-GB-12: registerGlobalVariables contains both [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains('static void registerGlobalVariables(D4rt interpreter)'),
        );
      });

      test('getters are NOT registered with registerGlobalVariable [2026-02-10 06:37]', () {
        // These should NOT be registered as regular variables
        expect(
          generatedCode,
          isNot(contains(
              "interpreter.registerGlobalVariable('globalService'")),
        );
        expect(
          generatedCode,
          isNot(contains(
              "interpreter.registerGlobalVariable('currentTime'")),
        );
        expect(
          generatedCode,
          isNot(contains(
              "interpreter.registerGlobalVariable('doubleRequestCount'")),
        );
      });

      test('regular variables are NOT registered with registerGlobalGetter [2026-02-10 06:37]',
          () {
        // These should NOT be registered as getters
        expect(
          generatedCode,
          isNot(contains("interpreter.registerGlobalGetter('appName'")),
        );
        expect(
          generatedCode,
          isNot(contains("interpreter.registerGlobalGetter('version'")),
        );
        expect(
          generatedCode,
          isNot(contains("interpreter.registerGlobalGetter('requestCount'")),
        );
      });
    });
  });
}