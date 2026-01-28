/// Tests for UserBridge override system.
///
/// Verifies that:
/// - UserBridgeScanner detects classes extending D4UserBridge
/// - Static override methods are correctly identified
/// - Classes extending D4UserBridge are excluded from generation
/// - Generated bridges use static override methods
library;

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

    test('detects class extending D4UserBridge', () {
      // MyCollectionUserBridge should be detected as extending D4UserBridge
      expect(
        generator.userBridgeScanner.shouldExcludeClass('MyCollectionUserBridge'),
        isTrue,
        reason: 'MyCollectionUserBridge extends D4UserBridge and should be excluded',
      );
    });

    test('identifies target class from naming convention', () {
      // Should map MyCollectionUserBridge to target class MyCollection
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);
      expect(userBridge!.targetClassName, equals('MyCollection'));
      expect(userBridge.userBridgeClassName, equals('MyCollectionUserBridge'));
    });

    test('detects static nativeNames getter', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);
      expect(userBridge!.hasNativeNames, isTrue);
    });

    test('detects static constructor override', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);

      // Default constructor override
      final ctorOverride = userBridge!.getConstructorOverride('');
      expect(ctorOverride, equals('overrideConstructor'));
    });

    test('detects static operator override', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);

      // operator[] override
      final operatorOverride = userBridge!.getOperatorOverride('[]');
      expect(operatorOverride, equals('overrideOperatorIndex'));
    });

    test('detects static getter override', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);

      // length getter override
      final getterOverride = userBridge!.getGetterOverride('length');
      expect(getterOverride, equals('overrideGetterLength'));
    });

    test('detects static method override', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);

      // add method override
      final methodOverride = userBridge!.getMethodOverride('add');
      expect(methodOverride, equals('overrideMethodAdd'));
    });

    test('detects static getter override for static member', () {
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
      expect(userBridge, isNotNull);

      // defaultCapacity static getter override
      final staticGetterOverride =
          userBridge!.getStaticGetterOverride('defaultCapacity');
      expect(staticGetterOverride, equals('overrideStaticGetterDefaultCapacity'));
    });

    test('class without UserBridge is not excluded', () {
      // SimpleClass has no UserBridge and should not be excluded
      expect(
        generator.userBridgeScanner.shouldExcludeClass('SimpleClass'),
        isFalse,
      );

      // Also no UserBridge info
      expect(
        generator.userBridgeScanner.getUserBridgeFor('SimpleClass'),
        isNull,
      );
    });

    test('excludes UserBridge class from generated code', () {
      // MyCollectionUserBridge should NOT appear in generated bridges
      expect(
        generatedCode,
        isNot(contains("name: 'MyCollectionUserBridge'")),
        reason: 'UserBridge classes should be excluded from generation',
      );
    });

    test('generates bridge for target class with overrides', () {
      // MyCollection should have a generated bridge
      expect(
        generatedCode,
        contains("name: 'MyCollection'"),
        reason: 'Target class should have a generated bridge',
      );
    });

    test('uses nativeNames from UserBridge', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.nativeNames'),
        reason: 'Generated bridge should reference UserBridge.nativeNames',
      );
    });

    test('uses constructor override from UserBridge', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideConstructor'),
        reason: 'Generated bridge should reference constructor override',
      );
    });

    test('uses operator override from UserBridge', () {
      // Verify the override is detected
      final userBridge =
          generator.userBridgeScanner.getUserBridgeFor('MyCollection');
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

    test('uses getter override from UserBridge', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideGetterLength'),
        reason: 'Generated bridge should reference getter override',
      );
    });

    test('uses method override from UserBridge', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideMethodAdd'),
        reason: 'Generated bridge should reference method override',
      );
    });

    test('uses static getter override from UserBridge', () {
      expect(
        generatedCode,
        contains('MyCollectionUserBridge.overrideStaticGetterDefaultCapacity'),
        reason: 'Generated bridge should reference static getter override',
      );
    });

    test('generates non-overridden members normally', () {
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

    test('generates SimpleClass normally (no UserBridge)', () {
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
      test('detects GlobalsUserBridge class', () {
        final globalsInfo = generator.userBridgeScanner.globalsUserBridge;
        expect(globalsInfo, isNotNull);
        expect(
            globalsInfo!.userBridgeClassName, equals('GlobalsUserBridge'));
      });

      test('excludes GlobalsUserBridge from bridge generation', () {
        expect(
          generator.userBridgeScanner
              .shouldExcludeClass('GlobalsUserBridge'),
          isTrue,
        );
      });

      test('detects global variable overrides', () {
        final globalsInfo = generator.userBridgeScanner.globalsUserBridge;
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

      test('detects global getter overrides', () {
        final globalsInfo = generator.userBridgeScanner.globalsUserBridge;
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

      test('detects global function overrides', () {
        final globalsInfo = generator.userBridgeScanner.globalsUserBridge;
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
      test('uses override for global variable appName', () {
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalVariable('appName', GlobalsUserBridge.overrideGlobalVariableAppName())",
          ),
        );
      });

      test('uses override for global variable maxRetries', () {
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalVariable('maxRetries', GlobalsUserBridge.overrideGlobalVariableMaxRetries())",
          ),
        );
      });

      test('uses override for global getter currentTime', () {
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalGetter('currentTime', GlobalsUserBridge.overrideGlobalGetterCurrentTime())",
          ),
        );
      });

      test('uses override for global getter globalService', () {
        expect(
          generatedCode,
          contains(
            "interpreter.registerGlobalGetter('globalService', GlobalsUserBridge.overrideGlobalGetterGlobalService())",
          ),
        );
      });

      test('uses override for global function greet', () {
        expect(
          generatedCode,
          contains("'greet': GlobalsUserBridge.overrideGlobalFunctionGreet,"),
        );
      });

      test('uses override for global function add', () {
        expect(
          generatedCode,
          contains("'add': GlobalsUserBridge.overrideGlobalFunctionAdd,"),
        );
      });

      test('non-overridden globals are generated normally', () {
        // Variable values are now prefixed with $pkg. since source imports use a prefix
        // debugMode is not overridden
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('debugMode', $pkg.debugMode)"),
        );
        // version is not overridden
        expect(
          generatedCode,
          contains(
              r"interpreter.registerGlobalVariable('version', $pkg.version)"),
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
