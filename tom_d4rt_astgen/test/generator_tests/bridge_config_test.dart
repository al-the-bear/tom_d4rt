/// Tests for BridgeConfig and ModuleConfig parsing and serialization.
///
/// These tests verify that the configuration classes correctly:
/// - Parse JSON configuration including new exclude fields
/// - Serialize to JSON
/// - Handle default values
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('ModuleConfig', () {
    group('fromJson', () {
      test('G-CFG-2: Parses basic module config. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'test_module',
          'barrelFiles': ['lib/src/test.dart'],
          'outputPath': 'lib/src/bridges/test_bridges.dart',
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.name, equals('test_module'));
        expect(config.barrelFiles, equals(['lib/src/test.dart']));
        expect(config.outputPath, equals('lib/src/bridges/test_bridges.dart'));
      });

      test('G-CFG-11: Parses excludeClasses. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeClasses': ['ExcludedClass', 'AnotherExcluded'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeClasses, equals(['ExcludedClass', 'AnotherExcluded']));
      });

      test('G-CFG-12: Parses excludeEnums. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeEnums': ['EnumA', 'EnumB'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeEnums, equals(['EnumA', 'EnumB']));
      });

      test('G-CFG-13: Parses excludeFunctions. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeFunctions': ['helperFunction', 'internalFunc'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeFunctions, equals(['helperFunction', 'internalFunc']));
      });

      test('G-CFG-14: Parses excludeVariables. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeVariables': ['_privateVar', 'debugMode'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeVariables, equals(['_privateVar', 'debugMode']));
      });

      test('G-CFG-15: Parses all exclude fields together. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'comprehensive',
          'barrelFiles': ['lib/all.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeClasses': ['Class1'],
          'excludeEnums': ['Enum1'],
          'excludeFunctions': ['func1'],
          'excludeVariables': ['var1'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeClasses, equals(['Class1']));
        expect(config.excludeEnums, equals(['Enum1']));
        expect(config.excludeFunctions, equals(['func1']));
        expect(config.excludeVariables, equals(['var1']));
      });

      test('G-CFG-16: Defaults to empty lists when fields not provided. [2026-02-10 06:37] (PASS)', () {
        final json = {
          'name': 'minimal',
          'barrelFiles': ['lib/minimal.dart'],
          'outputPath': 'lib/bridges.dart',
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeClasses, isEmpty);
        expect(config.excludeEnums, isEmpty);
        expect(config.excludeFunctions, isEmpty);
        expect(config.excludeVariables, isEmpty);
        expect(config.excludePatterns, isEmpty);
      });
    });

    group('toJson', () {
      test('G-CFG-1: Serializes basic config. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'test_module',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
        );
        
        final json = config.toJson();
        
        expect(json['name'], equals('test_module'));
        expect(json['barrelFiles'], equals(['lib/test.dart']));
        expect(json['outputPath'], equals('lib/bridges.dart'));
      });

      test('G-CFG-3: Serializes excludeClasses when non-empty. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeClasses: ['ClassA', 'ClassB'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeClasses'], equals(['ClassA', 'ClassB']));
      });

      test('G-CFG-4: Serializes excludeEnums when non-empty. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeEnums: ['EnumA'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeEnums'], equals(['EnumA']));
      });

      test('G-CFG-5: Serializes excludeFunctions when non-empty. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeFunctions: ['func1', 'func2'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeFunctions'], equals(['func1', 'func2']));
      });

      test('G-CFG-6: Serializes excludeVariables when non-empty. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeVariables: ['kConstant'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeVariables'], equals(['kConstant']));
      });

      test('G-CFG-7: Omits empty lists in serialization. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'minimal',
          barrelFiles: ['lib/minimal.dart'],
          outputPath: 'lib/bridges.dart',
        );
        
        final json = config.toJson();
        
        expect(json.containsKey('excludeClasses'), isFalse);
        expect(json.containsKey('excludeEnums'), isFalse);
        expect(json.containsKey('excludeFunctions'), isFalse);
        expect(json.containsKey('excludeVariables'), isFalse);
        expect(json.containsKey('excludePatterns'), isFalse);
      });

      test('G-CFG-8: Round-trip preserves all fields. [2026-02-10 06:37] (PASS)', () {
        final original = ModuleConfig(
          name: 'full_config',
          barrelFiles: ['lib/src/a.dart', 'lib/src/b.dart'],
          outputPath: 'lib/bridges/full_bridges.dart',
          barrelImport: 'package:my_package/my_package.dart',
          excludePatterns: ['*_test.dart'],
          excludeClasses: ['ProblematicClass'],
          excludeEnums: ['InternalEnum'],
          excludeFunctions: ['debugHelper'],
          excludeVariables: ['_internalState'],
          excludeSourcePatterns: ['package:dcli/src/shell/**', 'package:*/src/internal/*'],
          followReExports: ['tom_basics'],
        );
        
        final json = original.toJson();
        final restored = ModuleConfig.fromJson(json);
        
        expect(restored.name, equals(original.name));
        expect(restored.barrelFiles, equals(original.barrelFiles));
        expect(restored.outputPath, equals(original.outputPath));
        expect(restored.barrelImport, equals(original.barrelImport));
        expect(restored.excludePatterns, equals(original.excludePatterns));
        expect(restored.excludeClasses, equals(original.excludeClasses));
        expect(restored.excludeEnums, equals(original.excludeEnums));
        expect(restored.excludeFunctions, equals(original.excludeFunctions));
        expect(restored.excludeVariables, equals(original.excludeVariables));
        expect(restored.excludeSourcePatterns, equals(original.excludeSourcePatterns));
        expect(restored.followReExports, equals(original.followReExports));
      });

      test('G-CFG-9: ExcludeSourcePatterns serialization and deserialization. [2026-02-10 06:37] (PASS)', () {
        final config = ModuleConfig(
          name: 'source_pattern_test',
          barrelFiles: ['lib/lib.dart'],
          outputPath: 'lib/bridges.dart',
          excludeSourcePatterns: [
            'package:dcli/src/shell/**',
            'package:*/src/internal/*',
            'package:some_pkg/**',
          ],
        );
        
        final json = config.toJson();
        expect(json['excludeSourcePatterns'], equals([
          'package:dcli/src/shell/**',
          'package:*/src/internal/*',
          'package:some_pkg/**',
        ]));
        
        final restored = ModuleConfig.fromJson(json);
        expect(restored.excludeSourcePatterns, equals(config.excludeSourcePatterns));
      });
    });
  });

  group('BridgeConfig', () {
    test('G-CFG-10: Parses config with modules containing exclude fields. [2026-02-10 06:37] (PASS)', () {
      final json = {
        'name': 'test_project',
        'modules': [
          {
            'name': 'module_a',
            'barrelFiles': ['lib/a.dart'],
            'outputPath': 'lib/bridges/a.dart',
            'excludeEnums': ['EnumA'],
            'excludeFunctions': ['helperA'],
          },
          {
            'name': 'module_b',
            'barrelFiles': ['lib/b.dart'],
            'outputPath': 'lib/bridges/b.dart',
            'excludeVariables': ['kConstB'],
          },
        ],
      };
      
      final config = BridgeConfig.fromJson(json);
      
      expect(config.modules.length, equals(2));
      expect(config.modules[0].excludeEnums, equals(['EnumA']));
      expect(config.modules[0].excludeFunctions, equals(['helperA']));
      expect(config.modules[1].excludeVariables, equals(['kConstB']));
    });
  });
}

