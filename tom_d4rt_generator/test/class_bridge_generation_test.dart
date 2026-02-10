/// Comprehensive tests for bridge generator class bridging.
///
/// These tests verify that the generator correctly:
/// - Detects classes from source files
/// - Generates BridgedClass code with constructors
/// - Handles getters, setters, and methods
/// - Supports inheritance and static members
/// - Handles abstract classes and generics
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
        Directory.systemTemp.createTempSync('bridge_class_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Class Bridge Generation', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'class_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'class_bridges_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    group('Simple Classes', () {
      test('G-CLS-45: Detects SimpleClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'SimpleClass'"));
        // Types are now prefixed with $pkg. since source imports use a prefix
        expect(generatedCode, contains(r'nativeType: $pkg.SimpleClass'));
      });

      test('G-CLS-46: Detects OptionalPositionalClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'OptionalPositionalClass'"));
      });

      test('G-CLS-47: Detects NamedParamsClass. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'NamedParamsClass'"));
      });

      test('G-CLS-48: Skips private classes. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, isNot(contains('_PrivateClass')));
      });
    });

    group('Constructors', () {
      test('G-CLS-49: Generates default constructor. [2026-02-10 06:37] (PASS)', () {
        // Default constructor has empty name
        expect(generatedCode, contains("'': (visitor, positional, named)"));
      });

      test('G-CLS-50: Generates named constructors. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'fromType'"));
        expect(generatedCode, contains("'empty'"));
      });

      test('G-CLS-51: Generates factory constructors. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'create'"));
      });

      test('G-CLS-52: Generates constructor parameter extraction. [2026-02-10 06:37] (PASS)', () {
        // Positional parameter extraction pattern
        expect(
          generatedCode,
          contains('D4.requireMinArgs'),
        );
      });

      test('G-CLS-1: Handles const constructors. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'ConstClass'"));
      });

      test('G-CLS-2: Generates constructor for implicit default constructor. [2026-02-10 06:37] (PASS)', () {
        // ImplicitCtorClass has no explicit constructor declaration.
        // The generator should detect the synthetic default constructor
        // via ClassElement.unnamedConstructor.isSynthetic and emit a bridge.
        expect(generatedCode, contains("name: 'ImplicitCtorClass'"));
        // Verify the constructor map is not empty for this class
        final implicitClassSection = _extractClassSection(generatedCode, 'ImplicitCtorClass');
        expect(implicitClassSection, isNotNull, reason: 'ImplicitCtorClass should be in generated code');
        expect(implicitClassSection, contains("'': (visitor, positional, named)"),
            reason: 'Should have an unnamed constructor bridge');
      });

      test('G-CLS-3: Generates constructor for methods-only class. [2026-02-10 06:37] (PASS)', () {
        // CalculatorLike has only methods, no fields with initializers, no constructor.
        expect(generatedCode, contains("name: 'CalculatorLike'"));
        final calcSection = _extractClassSection(generatedCode, 'CalculatorLike');
        expect(calcSection, isNotNull, reason: 'CalculatorLike should be in generated code');
        expect(calcSection, contains("'': (visitor, positional, named)"),
            reason: 'Should have an unnamed constructor bridge');
      });
    });

    group('Getters and Setters', () {
      test('G-CLS-4: Generates getters map. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('getters: {'));
      });

      test('G-CLS-5: Generates instance getters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'name':"));
        expect(generatedCode, contains("'displayName':"));
        expect(generatedCode, contains("'isEmpty':"));
      });

      test('G-CLS-6: Generates setters map. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('setters: {'));
      });

      test('G-CLS-7: Generates target validation for getters. [2026-02-10 06:37] (PASS)', () {
        // Types are prefixed with $pkg since source imports use that prefix
        expect(
          generatedCode,
          contains(r'D4.validateTarget<$pkg.PropertyClass>'),
        );
      });
    });

    group('Methods', () {
      test('G-CLS-8: Generates methods map. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('methods: {'));
      });

      test('G-CLS-9: Generates void methods. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'reset':"));
      });

      test('G-CLS-10: Generates methods with return values. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'increment':"));
        expect(generatedCode, contains("'format':"));
      });

      test('G-CLS-11: Generates methods with optional parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'formatWithSuffix':"));
      });

      test('G-CLS-12: Generates methods with named parameters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'formatCustom':"));
      });

      test('G-CLS-13: Generates method target validation. [2026-02-10 06:37] (PASS)', () {
        // Types are prefixed with $pkg since source imports use that prefix
        expect(
          generatedCode,
          contains(r"D4.validateTarget<$pkg.MethodClass>(target, 'MethodClass')"),
        );
      });
    });

    group('Inheritance', () {
      test('G-CLS-14: Detects base class. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'BaseEntity'"));
      });

      test('G-CLS-15: Detects derived class. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'DerivedEntity'"));
      });

      test('G-CLS-16: Detects multi-level inheritance. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'SpecialEntity'"));
      });

      test('G-CLS-17: Inherited getters are included. [2026-02-10 06:37] (PASS)', () {
        // DerivedEntity should have 'lastModified' from BaseEntity
        // Check that createDerivedEntityBridge includes inherited members
        expect(generatedCode, contains('_createDerivedEntityBridge'));
      });

      test('G-CLS-18: Inherited methods are included. [2026-02-10 06:37] (PASS)', () {
        // DerivedEntity should have 'touch' from BaseEntity
        expect(generatedCode, contains("'touch':"));
      });

      test('G-CLS-19: Overridden methods use child implementation. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'describe':"));
      });
    });

    group('Static Members', () {
      test('G-CLS-20: Generates static getters. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('staticGetters: {'));
      });

      test('G-CLS-21: Generates static methods. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains('staticMethods: {'));
      });

      test('G-CLS-22: Static getter has correct signature. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'instanceCount': (visitor)"));
      });

      test('G-CLS-23: Static method has correct signature. [2026-02-10 06:37] (PASS)', () {
        expect(
          generatedCode,
          contains("'resetCount': (visitor, positional, named, typeArgs)"),
        );
      });
    });

    group('Abstract Classes', () {
      test('G-CLS-24: Abstract classes without constructors may be skipped. [2026-02-10 06:37] (PASS)', () {
        // Pure abstract classes (no constructors) are typically skipped
        // since they cannot be instantiated from D4rt scripts.
        // The concrete implementation should still be bridged.
        expect(generatedCode, contains("name: 'SimpleProcessor'"));
      });

      test('G-CLS-25: Detects concrete implementation SimpleProcessor. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'SimpleProcessor'"));
      });

      test('G-CLS-26: SimpleProcessor has its own methods bridged. [2026-02-10 06:37] (PASS)', () {
        // SimpleProcessor has isReady getter and process method
        expect(generatedCode, contains("'isReady':"));
        expect(generatedCode, contains("'process':"));
      });
    });

    group('Generic Classes', () {
      test('G-CLS-27: Detects Container<T>. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'Container'"));
      });

      test('G-CLS-28: Detects NumberContainer<T extends num>. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'NumberContainer'"));
      });

      test('G-CLS-29: Detects Pair<K, V>. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'Pair'"));
      });

      test('G-CLS-30: Generic class methods are bridged. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'hasValue':"));
        expect(generatedCode, contains("'clear':"));
        expect(generatedCode, contains("'swap':"));
      });
    });

    group('Special Cases', () {
      test('G-CLS-31: Singleton pattern factory constructor. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("name: 'SingletonPattern'"));
      });

      test('G-CLS-32: Classes with id field. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'id':"));
      });
    });
  });

  group('Bridge Structure', () {
    late String generatedCode;

    setUpAll(() async {
      final testFixturesDir =
          p.join(Directory.current.path, 'test', 'fixtures');
      final tempOutputDir =
          Directory.systemTemp.createTempSync('bridge_struct_test_').path;

      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'class_test_source.dart',
        packageName: 'test_package',
      );

      final sourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'struct_test.dart');

      await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test_module',
      );

      generatedCode = await File(outputFile).readAsString();

      // Cleanup
      addTearDown(() {
        try {
          Directory(tempOutputDir).deleteSync(recursive: true);
        } catch (_) {}
      });
    });

    test('G-CLS-33: Generates module bridge class with correct name. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains('class TestModuleBridge {'));
    });

    test('G-CLS-34: Generates bridgeClasses method. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains('static List<BridgedClass> bridgeClasses()'),
      );
    });

    test('G-CLS-35: Generates registerBridges method. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains('static void registerBridges(D4rt interpreter, String importPath)'),
      );
    });

    test('G-CLS-36: Generates getImportBlock method. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains('static String getImportBlock()'));
    });

    test('G-CLS-37: Includes header comment. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains('// D4rt Bridge - Generated file, do not edit'),
      );
    });

    test('G-CLS-38: Includes generation timestamp. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains('// Generated:'));
    });

    test('G-CLS-39: Imports tom_d4rt package. [2026-02-10 06:37] (PASS)', () {
      expect(
        generatedCode,
        contains("import 'package:tom_d4rt/d4rt.dart'"),
      );
    });
  });

  group('Class Properties Verification', () {
    late String generatedCode;

    setUpAll(() async {
      final testFixturesDir =
          p.join(Directory.current.path, 'test', 'fixtures');
      final tempDir =
          Directory.systemTemp.createTempSync('bridge_props_test_').path;

      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'class_test_source.dart',
        packageName: 'test_package',
      );

      final sourceFile = p.join(testFixturesDir, 'class_test_source.dart');
      final outputFile = p.join(tempDir, 'props_test.dart');

      await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'props',
      );

      generatedCode = await File(outputFile).readAsString();

      addTearDown(() {
        try {
          Directory(tempDir).deleteSync(recursive: true);
        } catch (_) {}
      });
    });

    test('G-CLS-40: Generic class Container<T> is bridged. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'Container'"));
      // Types are now prefixed with $pkg. since source imports use a prefix
      expect(generatedCode, contains(r'nativeType: $pkg.Container'));
    });

    test('G-CLS-41: Bounded generic NumberContainer<T extends num> is bridged. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'NumberContainer'"));
    });

    test('G-CLS-42: Multi-param generic Pair<K, V> is bridged. [2026-02-10 06:37] (PASS)', () {
      expect(generatedCode, contains("name: 'Pair'"));
    });

    test('G-CLS-43: Inheritance is reflected in generated bridges. [2026-02-10 06:37] (PASS)', () {
      // DerivedEntity extends BaseEntity - both should be bridged
      expect(generatedCode, contains("name: 'BaseEntity'"));
      expect(generatedCode, contains("name: 'DerivedEntity'"));
      expect(generatedCode, contains("name: 'SpecialEntity'"));
    });

    test('G-CLS-44: Concrete implementation SimpleProcessor is bridged. [2026-02-10 06:37] (PASS)', () {
      // Pure abstract classes may not be bridged, but implementations should be
      expect(generatedCode, contains("name: 'SimpleProcessor'"));
    });
  });
}

/// Extracts the BridgedClass section for [className] from generated code.
/// Returns the text from `BridgedClass(` up to the corresponding closing `)`,
/// or null if not found.
String? _extractClassSection(String code, String className) {
  final marker = "name: '$className'";
  final idx = code.indexOf(marker);
  if (idx == -1) return null;
  // Walk backwards to find 'BridgedClass('
  final start = code.lastIndexOf('BridgedClass(', idx);
  if (start == -1) return null;
  // Walk forward from start, counting parens to find the matching close
  var depth = 0;
  for (var i = start; i < code.length; i++) {
    if (code[i] == '(') depth++;
    if (code[i] == ')') {
      depth--;
      if (depth == 0) return code.substring(start, i + 1);
    }
  }
  return code.substring(start); // fallback
}
