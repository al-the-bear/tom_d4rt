/// Tests for UserBridge override system.
///
/// Verifies that:
/// - UserBridgeScanner detects classes extending D4UserBridge with @D4rtUserBridge annotation
/// - Static override methods are correctly identified
/// - Classes extending D4UserBridge are excluded from generation
/// - Generated bridges use static override methods
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Library path used in the test fixture's @D4rtUserBridge annotation.
const testLibraryPath = 'package:test_package/user_bridge_test_source.dart';

/// Library path used in the GlobalsUserBridge fixture's @D4rtGlobalsUserBridge annotation.
const globalsLibraryPath = 'package:test_package/global_test_source.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('user_bridge_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('UserBridgeScanner', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'user_bridge_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'user_bridge_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'user_bridges_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('detects class extending D4UserBridge [2026-02-10 06:37]', () {
      // MyCollectionUserBridge should be detected as extending D4UserBridge
      expect(
        generator.userBridgeScanner.shouldExcludeClass('MyCollectionUserBridge'),
        isTrue,
        reason: 'MyCollectionUserBridge extends D4UserBridge and should be excluded',
      );
    });

    test('identifies target class from annotation [2026-02-10 06:37]', () {
      // Should map MyCollectionUserBridge to target class MyCollection via @D4rtUserBridge
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);
      expect(userBridge!.targetClassName, equals('MyCollection'));
      expect(userBridge.libraryPath, equals(testLibraryPath));
      expect(userBridge.userBridgeClassName, equals('MyCollectionUserBridge'));
    });

    test('detects static nativeNames getter [2026-02-10 06:37]', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);
      expect(userBridge!.hasNativeNames, isTrue);
    });

    test('detects static constructor override [2026-02-10 06:37]', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);

      // Default constructor override
      final ctorOverride = userBridge!.getConstructorOverride('');
      expect(ctorOverride, equals('overrideConstructor'));
    });

    test('detects static operator override [2026-02-10 06:37]', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);

      // operator[] override
      final operatorOverride = userBridge!.getOperatorOverride('[]');
      expect(operatorOverride, equals('overrideOperatorIndex'));
    });

    test('detects static getter override [2026-02-10 06:37]', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);

      // length getter override
      final getterOverride = userBridge!.getGetterOverride('length');
      expect(getterOverride, equals('overrideGetterLength'));
    });

    test('detects static method override [2026-02-10 06:37]', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);

      // add method override
      final methodOverride = userBridge!.getMethodOverride('add');
      expect(methodOverride, equals('overrideMethodAdd'));
    });

    test('detects static getter override for static member [2026-02-10 06:37]', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);

      // defaultCapacity static getter override
      final staticGetterOverride =
          userBridge!.getStaticGetterOverride('defaultCapacity');
      expect(staticGetterOverride, equals('overrideStaticGetterDefaultCapacity'));
    });

    test('class without UserBridge is not excluded [2026-02-10 06:37]', () {
      // SimpleClass has no UserBridge and should not be excluded
      expect(
        generator.userBridgeScanner.shouldExcludeClass('SimpleClass'),
        isFalse,
      );

      // Also no UserBridge info
      expect(
        generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'SimpleClass'),
        isNull,
      );
    });

    test('excludes UserBridge class from generated code [2026-02-10 06:37]', () {
      // MyCollectionUserBridge should NOT appear in generated bridges
      expect(
        generatedCode,
        isNot(contains("name: 'MyCollectionUserBridge'")),
        reason: 'UserBridge classes should be excluded from generation',
      );
    });

    test('generates bridge for target class with overrides [2026-02-10 06:37]', () {
      // MyCollection should have a generated bridge
      expect(
        generatedCode,
        contains("name: 'MyCollection'"),
        reason: 'Target class should have a generated bridge',
      );
    });

    test('uses nativeNames from UserBridge [2026-02-10 06:37]', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.nativeNames'),
        reason: 'Generated bridge should reference UserBridge.nativeNames',
      );
    });

    test('uses constructor override from UserBridge [2026-02-10 06:37]', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideConstructor'),
        reason: 'Generated bridge should reference constructor override',
      );
    });

    test('uses operator override from UserBridge [2026-02-10 06:37]', () {
      // Verify the override is detected
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor(testLibraryPath, 'MyCollection');
      expect(userBridge, isNotNull);
      expect(
        userBridge!.getOperatorOverride('[]'),
        equals('overrideOperatorIndex'),
        reason: 'Operator override should be detected',
      );
      // Verify the generated code uses the override
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideOperatorIndex'),
        reason: 'Generated bridge should reference operator override',
      );
    });

    test('uses getter override from UserBridge [2026-02-10 06:37]', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideGetterLength'),
        reason: 'Generated bridge should reference getter override',
      );
    });

    test('uses method override from UserBridge [2026-02-10 06:37]', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideMethodAdd'),
        reason: 'Generated bridge should reference method override',
      );
    });

    test('uses static getter override from UserBridge [2026-02-10 06:37]', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideStaticGetterDefaultCapacity'),
        reason: 'Generated bridge should reference static getter override',
      );
    });

    test('generates non-overridden members normally [2026-02-10 06:37]', () {
      // isEmpty getter has no override - should be generated normally
      expect(
        generatedCode,
        contains("'isEmpty':"),
        reason: 'Non-overridden members should be generated normally',
      );

      // clear method has no override - should be generated normally
      expect(
        generatedCode,
        contains("'clear':"),
        reason: 'Non-overridden methods should be generated normally',
      );
    });

    test('generates SimpleClass normally (no UserBridge) [2026-02-10 06:37]', () {
      // SimpleClass has no UserBridge - all members generated normally
      expect(
        generatedCode,
        contains("name: 'SimpleClass'"),
      );

      // greet method should be generated
      expect(
        generatedCode,
        contains("'greet':"),
      );
    });
  });

  group('GlobalsUserBridge', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'global_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      // Include both global source and globals user bridge
      final classSourceFile =
          p.join(testFixturesDir, 'class_test_source.dart');
      final globalSourceFile =
          p.join(testFixturesDir, 'global_test_source.dart');
      final globalsUserBridgeFile =
          p.join(testFixturesDir, 'globals_user_bridge.dart');
      final outputFile =
          p.join(tempOutputDir, 'globals_user_bridge_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [classSourceFile, globalSourceFile, globalsUserBridgeFile],
        outputPath: outputFile,
        moduleName: 'globals_override',
      );

      expect(result.errors, isEmpty);
      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    group('Scanner Detection', () {
      test('detects GlobalsUserBridge class [2026-02-10 06:37]', () {
        final globalsInfo =
            generator.userBridgeScanner.getGlobalsUserBridgeFor(globalsLibraryPath);
        expect(globalsInfo, isNotNull);
        expect(
            globalsInfo!.userBridgeClassName, equals('GlobalsUserBridge'));
      });

      test('excludes GlobalsUserBridge from bridge generation [2026-02-10 06:37]', () {
        expect(
          generator.userBridgeScanner
              .shouldExcludeClass('GlobalsUserBridge'),
          isTrue,
        );
      });

      test('detects global variable overrides [2026-02-10 06:37]', () {
        final globalsInfo =
            generator.userBridgeScanner.getGlobalsUserBridgeFor(globalsLibraryPath);
        expect(globalsInfo, isNotNull);
        expect(
          globalsInfo!.globalVariableOverrides,
          containsPair('appName', 'overrideGlobalVariableAppName'),
        );
        expect(
          globalsInfo.globalVariableOverrides,
          containsPair('maxRetries', 'overrideGlobalVariableMaxRetries'),
        );
      });

      test('detects global getter overrides [2026-02-10 06:37]', () {
        final globalsInfo =
            generator.userBridgeScanner.getGlobalsUserBridgeFor(globalsLibraryPath);
        expect(globalsInfo, isNotNull);
        expect(
          globalsInfo!.globalGetterOverrides,
          containsPair('currentTime', 'overrideGlobalGetterCurrentTime'),
        );
        expect(
          globalsInfo.globalGetterOverrides,
          containsPair('globalService', 'overrideGlobalGetterGlobalService'),
        );
      });

      test('detects global function overrides [2026-02-10 06:37]', () {
        final globalsInfo =
            generator.userBridgeScanner.getGlobalsUserBridgeFor(globalsLibraryPath);
        expect(globalsInfo, isNotNull);
        expect(
          globalsInfo!.globalFunctionOverrides,
          containsPair('greet', 'overrideGlobalFunctionGreet'),
        );
        expect(
          globalsInfo.globalFunctionOverrides,
          containsPair('add', 'overrideGlobalFunctionAdd'),
        );
      });
    });

    group('Code Generation with Overrides', () {
      test('G-UB-1: override for global variable appName [2026-02-10 08:00]', () {
        // The generated code includes importPath and sourceUri parameters
        expect(
          generatedCode,
          contains(
            "GlobalsUserBridge.overrideGlobalVariableAppName()",
          ),
        );
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalVariable('appName', GlobalsUserBridge.overrideGlobalVariableAppName(), importPath",
          ),
        );
      });

      test('G-UB-2: override for global variable maxRetries [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            "GlobalsUserBridge.overrideGlobalVariableMaxRetries()",
          ),
        );
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalVariable('maxRetries', GlobalsUserBridge.overrideGlobalVariableMaxRetries(), importPath",
          ),
        );
      });

      test('G-UB-3: override for global getter currentTime [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            "GlobalsUserBridge.overrideGlobalGetterCurrentTime()",
          ),
        );
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalGetter('currentTime', GlobalsUserBridge.overrideGlobalGetterCurrentTime(), importPath",
          ),
        );
      });

      test('G-UB-4: override for global getter globalService [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains(
            "GlobalsUserBridge.overrideGlobalGetterGlobalService()",
          ),
        );
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalGetter('globalService', GlobalsUserBridge.overrideGlobalGetterGlobalService(), importPath",
          ),
        );
      });

      test('G-UB-5: override for global function greet [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains("'greet': GlobalsUserBridge.overrideGlobalFunctionGreet,"),
        );
      });

      test('G-UB-6: override for global function add [2026-02-10 08:00]', () {
        expect(
          generatedCode,
          contains("'add': GlobalsUserBridge.overrideGlobalFunctionAdd,"),
        );
      });

      test('non-overridden globals are generated normally [2026-02-10 06:37]', () {
        // Variable values are now prefixed with $pkg. since source imports use a prefix
        // The generated code now includes importPath and sourceUri parameters
        // debugMode is not overridden
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('debugMode', $pkg.debugMode, importPath"),
        );
        // version is not overridden
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('version', $pkg.version, importPath"),
        );
        // resetState function is not overridden
        expect(
          generatedCode,
          contains("'resetState': (visitor, positional, named, typeArgs)"),
        );
      });
    });
  });
}
