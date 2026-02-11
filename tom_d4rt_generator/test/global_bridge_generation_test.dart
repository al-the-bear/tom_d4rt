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
      test('G-GB-29: Detects void function with no parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'resetState'"));
      });

      test('G-GB-30: Detects function returning value. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'getRequestCount'"));
      });

      test('G-GB-31: Detects function with single parameter. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'greet'"));
      });

      test('G-GB-32: Detects function with multiple parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'add'"));
      });

      test('G-GB-33: Detects function returning boolean. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'isValidName'"));
      });
    });

    group('Functions with Optional Parameters', () {
      test('G-GB-34: Detects function with optional positional parameter. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'formatMessage'"));
      });

      test('G-GB-35: Detects function with optional parameters and defaults. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'buildUrl'"));
      });

      test('G-GB-36: Detects function with named parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'formatRecord'"));
      });

      test('G-GB-37: Detects function with mixed parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'createEntry'"));
      });
    });

    group('Functions with Complex Types', () {
      test('G-GB-1b: Detects function returning list. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'range'"));
      });

      test('G-GB-2b: Detects function taking list parameter. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'sumList'"));
      });

      test('G-GB-3b: Detects function returning map. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'createConfig'"));
      });

      test('G-GB-4b: Detects function with nullable return. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'findMatch'"));
      });
    });

    group('Async Functions', () {
      test('G-GB-5b: Detects async function. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'fetchData'"));
      });

      test('G-GB-6b: Detects async function with parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'computeAsync'"));
      });
    });

    group('Private Functions', () {
      test('G-GB-7b: Skips private functions. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, isNot(contains("'_internalHelper'")));
        expect(generatedCode, isNot(contains("'_calculateInternal'")));
      });
    });

    group('Error Handling Functions', () {
      test('G-GB-8a: Detects function that may throw. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'divideStrict'"));
      });

      test('G-GB-9b: Detects function with try-catch. [2026-02-10 06:37] (PASS)', () {
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
      test('G-GB-10a: Detects string constant. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'appName'"));
      });

      test('G-GB-11a: Detects int constant. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'maxRetries'"));
      });

      test('G-GB-12a: Detects double constant. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'defaultTimeout'"));
      });

      test('G-GB-13: Detects bool constant. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'debugMode'"));
      });
    });

    group('Final Variables', () {
      test('G-GB-14: Detects final string. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'version'"));
      });

      test('G-GB-15: Detects final list. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'supportedFormats'"));
      });

      test('G-GB-16: Detects final map. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'errorCodes'"));
      });
    });

    group('Mutable Variables', () {
      test('G-GB-17: Detects mutable int. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'requestCount'"));
      });

      test('G-GB-18: Detects mutable string. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'lastError'"));
      });

      test('G-GB-19: Detects nullable mutable variable. [2026-02-10 06:37] (PASS)', () {
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

    test('G-GB-1a: Generates globalFunctions map. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains('static Map<String, NativeFunctionImpl> globalFunctions()'),
      );
    });

    test('G-GB-2a: Generates registerGlobalVariables method. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains('static void registerGlobalVariables(D4rt interpreter, String importPath)'),
      );
    });

    test('G-GB-3a: Generates registerBridges entry point. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains('static void registerBridges(D4rt interpreter, String importPath)'),
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

    test('G-GB-20: Function names are in globalFunctionNames list. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'greet'"));
      expect(generatedCode, contains("'add'"));
      expect(generatedCode, contains("'resetState'"));
    });

    test('G-GB-21: Async functions are included. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'fetchData'"));
      expect(generatedCode, contains("'computeAsync'"));
    });

    test('G-GB-22: Functions with named params are included. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'formatRecord'"));
      expect(generatedCode, contains("'createEntry'"));
    });

    test('G-GB-23: Private functions are excluded. [2026-02-10 06:37] (PASS)', () {
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

    test('G-GB-24: Constant names are in globalVariableNames list. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'appName'"));
      expect(generatedCode, contains("'maxRetries'"));
      expect(generatedCode, contains("'debugMode'"));
    });

    test('G-GB-25: Final variables are included. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'version'"));
      expect(generatedCode, contains("'supportedFormats'"));
    });

    test('G-GB-26: Mutable variables are included. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("'requestCount'"));
      expect(generatedCode, contains("'lastError'"));
    });

    test('G-GB-4a: registerGlobalVariables registers variables. [2026-02-10 06:37] (PASS)', () {
      // The registerGlobalVariables method should contain variable registrations
      expect(generatedCode, contains('registerGlobalVariables'));
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
      test('G-GB-5a: Const vars use registerGlobalVariable. [2026-02-10 06:37] (PASS)', () {
        // Variable values are now prefixed with $pkg. since source imports use a prefix
        // registerGlobalVariable now includes importPath and sourceUri parameters
        expect(
          generatedCode,
          contains(r"interpreter.registerGlobalVariable('appName', $pkg.appName, importPath"),
        );
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('maxRetries', $pkg.maxRetries, importPath"),
        );
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('debugMode', $pkg.debugMode, importPath"),
        );
      });

      test('G-GB-6a: Final vars use registerGlobalVariable. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains(r"interpreter.registerGlobalVariable('version', $pkg.version, importPath"),
        );
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalVariable('supportedFormats', $pkg.supportedFormats, importPath",
          ),
        );
      });

      test('G-GB-7a: Mutable vars use registerGlobalVariable. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalVariable('requestCount', $pkg.requestCount, importPath",
          ),
        );
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('lastError', $pkg.lastError, importPath"),
        );
      });
    });

    group('Top-level Getters use registerGlobalGetter', () {
      test('G-GB-8b: Getter singleton uses registerGlobalGetter. [2026-02-10 06:37] (PASS)', () {
        // Getter values are now prefixed with $pkg. since source imports use a prefix
        // registerGlobalGetter now includes importPath and sourceUri parameters
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('globalService', () => $pkg.globalService, importPath",
          ),
        );
      });

      test('G-GB-9a: Getter computed uses registerGlobalGetter. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('currentTime', () => $pkg.currentTime, importPath",
          ),
        );
      });

      test('G-GB-10b: Nullable getter uses registerGlobalGetter. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('lastLogMessage', () => $pkg.lastLogMessage, importPath",
          ),
        );
      });

      test('G-GB-11b: Mutable state getter registerGlobalGetter. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains(
            r"interpreter.registerGlobalGetter('doubleRequestCount', () => $pkg.doubleRequestCount, importPath",
          ),
        );
      });
    });

    group('Getter vs Variable Separation', () {
      test('G-GB-12b: RegisterGlobalVariables contains both. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains('static void registerGlobalVariables(D4rt interpreter, String importPath)'),
        );
      });

      test('G-GB-27: Getters are NOT registered with registerGlobalVariable. [2026-02-10 06:37] (PASS)', () {
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

      test('G-GB-28: Regular variables are NOT registered with registerGlobalGetter. [2026-02-10 06:37] (PASS)',
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
