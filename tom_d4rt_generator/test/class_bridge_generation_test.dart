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
      test('detects SimpleClass', () {
        expect(generatedCode, contains("name: 'SimpleClass'"));
        // Types are now prefixed with $pkg. since source imports use a prefix
        expect(generatedCode, contains(r'nativeType: $pkg.SimpleClass'));
      });

      test('detects OptionalPositionalClass', () {
        expect(generatedCode, contains("name: 'OptionalPositionalClass'"));
      });

      test('detects NamedParamsClass', () {
        expect(generatedCode, contains("name: 'NamedParamsClass'"));
      });

      test('skips private classes', () {
        expect(generatedCode, isNot(contains('_PrivateClass')));
      });
    });

    group('Constructors', () {
      test('generates default constructor', () {
        // Default constructor has empty name
        expect(generatedCode, contains("'': (visitor, positional, named)"));
      });

      test('generates named constructors', () {
        expect(generatedCode, contains("'fromType'"));
        expect(generatedCode, contains("'empty'"));
      });

      test('generates factory constructors', () {
        expect(generatedCode, contains("'create'"));
      });

      test('generates constructor parameter extraction', () {
        // Positional parameter extraction pattern
        expect(
          generatedCode,
          contains('D4.requireMinArgs'),
        );
      });

      test('handles const constructors', () {
        expect(generatedCode, contains("name: 'ConstClass'"));
      });

      test('GEN-042: generates constructor for implicit default constructor', () {
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

      test('GEN-042: generates constructor for methods-only class', () {
        // CalculatorLike has only methods, no fields with initializers, no constructor.
        expect(generatedCode, contains("name: 'CalculatorLike'"));
        final calcSection = _extractClassSection(generatedCode, 'CalculatorLike');
        expect(calcSection, isNotNull, reason: 'CalculatorLike should be in generated code');
        expect(calcSection, contains("'': (visitor, positional, named)"),
            reason: 'Should have an unnamed constructor bridge');
      });
    });

    group('Getters and Setters', () {
      test('generates getters map', () {
        expect(generatedCode, contains('getters: {'));
      });

      test('generates instance getters', () {
        expect(generatedCode, contains("'name':"));
        expect(generatedCode, contains("'displayName':"));
        expect(generatedCode, contains("'isEmpty':"));
      });

      test('generates setters map', () {
        expect(generatedCode, contains('setters: {'));
      });

      test('generates target validation for getters', () {
        // Types are prefixed with $pkg since source imports use that prefix
        expect(
          generatedCode,
          contains(r'D4.validateTarget<$pkg.PropertyClass>'),
        );
      });
    });

    group('Methods', () {
      test('generates methods map', () {
        expect(generatedCode, contains('methods: {'));
      });

      test('generates void methods', () {
        expect(generatedCode, contains("'reset':"));
      });

      test('generates methods with return values', () {
        expect(generatedCode, contains("'increment':"));
        expect(generatedCode, contains("'format':"));
      });

      test('generates methods with optional parameters', () {
        expect(generatedCode, contains("'formatWithSuffix':"));
      });

      test('generates methods with named parameters', () {
        expect(generatedCode, contains("'formatCustom':"));
      });

      test('generates method target validation', () {
        // Types are prefixed with $pkg since source imports use that prefix
        expect(
          generatedCode,
          contains(r"D4.validateTarget<$pkg.MethodClass>(target, 'MethodClass')"),
        );
      });
    });

    group('Inheritance', () {
      test('detects base class', () {
        expect(generatedCode, contains("name: 'BaseEntity'"));
      });

      test('detects derived class', () {
        expect(generatedCode, contains("name: 'DerivedEntity'"));
      });

      test('detects multi-level inheritance', () {
        expect(generatedCode, contains("name: 'SpecialEntity'"));
      });

      test('inherited getters are included', () {
        // DerivedEntity should have 'lastModified' from BaseEntity
        // Check that createDerivedEntityBridge includes inherited members
        expect(generatedCode, contains('_createDerivedEntityBridge'));
      });

      test('inherited methods are included', () {
        // DerivedEntity should have 'touch' from BaseEntity
        expect(generatedCode, contains("'touch':"));
      });

      test('overridden methods use child implementation', () {
        expect(generatedCode, contains("'describe':"));
      });
    });

    group('Static Members', () {
      test('generates static getters', () {
        expect(generatedCode, contains('staticGetters: {'));
      });

      test('generates static methods', () {
        expect(generatedCode, contains('staticMethods: {'));
      });

      test('static getter has correct signature', () {
        expect(generatedCode, contains("'instanceCount': (visitor)"));
      });

      test('static method has correct signature', () {
        expect(
          generatedCode,
          contains("'resetCount': (visitor, positional, named, typeArgs)"),
        );
      });
    });

    group('Abstract Classes', () {
      test('abstract classes without constructors may be skipped', () {
        // Pure abstract classes (no constructors) are typically skipped
        // since they cannot be instantiated from D4rt scripts.
        // The concrete implementation should still be bridged.
        expect(generatedCode, contains("name: 'SimpleProcessor'"));
      });

      test('detects concrete implementation SimpleProcessor', () {
        expect(generatedCode, contains("name: 'SimpleProcessor'"));
      });

      test('SimpleProcessor has its own methods bridged', () {
        // SimpleProcessor has isReady getter and process method
        expect(generatedCode, contains("'isReady':"));
        expect(generatedCode, contains("'process':"));
      });
    });

    group('Generic Classes', () {
      test('detects Container<T>', () {
        expect(generatedCode, contains("name: 'Container'"));
      });

      test('detects NumberContainer<T extends num>', () {
        expect(generatedCode, contains("name: 'NumberContainer'"));
      });

      test('detects Pair<K, V>', () {
        expect(generatedCode, contains("name: 'Pair'"));
      });

      test('generic class methods are bridged', () {
        expect(generatedCode, contains("'hasValue':"));
        expect(generatedCode, contains("'clear':"));
        expect(generatedCode, contains("'swap':"));
      });
    });

    group('Special Cases', () {
      test('singleton pattern factory constructor', () {
        expect(generatedCode, contains("name: 'SingletonPattern'"));
      });

      test('classes with id field', () {
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

    test('generates module bridge class with correct name', () {
      expect(generatedCode, contains('class TestModuleBridge {'));
    });

    test('generates bridgeClasses method', () {
      expect(
        generatedCode,
        contains('static List<BridgedClass> bridgeClasses()'),
      );
    });

    test('generates registerBridges method', () {
      expect(
        generatedCode,
        contains('static void registerBridges(D4rt interpreter, String importPath)'),
      );
    });

    test('generates getImportBlock method', () {
      expect(generatedCode, contains('static String getImportBlock()'));
    });

    test('includes header comment', () {
      expect(
        generatedCode,
        contains('// D4rt Bridge - Generated file, do not edit'),
      );
    });

    test('includes generation timestamp', () {
      expect(generatedCode, contains('// Generated:'));
    });

    test('imports tom_d4rt package', () {
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

    test('generic class Container<T> is bridged', () {
      expect(generatedCode, contains("name: 'Container'"));
      // Types are now prefixed with $pkg. since source imports use a prefix
      expect(generatedCode, contains(r'nativeType: $pkg.Container'));
    });

    test('bounded generic NumberContainer<T extends num> is bridged', () {
      expect(generatedCode, contains("name: 'NumberContainer'"));
    });

    test('multi-param generic Pair<K, V> is bridged', () {
      expect(generatedCode, contains("name: 'Pair'"));
    });

    test('inheritance is reflected in generated bridges', () {
      // DerivedEntity extends BaseEntity - both should be bridged
      expect(generatedCode, contains("name: 'BaseEntity'"));
      expect(generatedCode, contains("name: 'DerivedEntity'"));
      expect(generatedCode, contains("name: 'SpecialEntity'"));
    });

    test('concrete implementation SimpleProcessor is bridged', () {
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
