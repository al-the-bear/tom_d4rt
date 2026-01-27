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
      test('parses basic module config', () {
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

      test('parses excludeClasses', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeClasses': ['ExcludedClass', 'AnotherExcluded'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeClasses, equals(['ExcludedClass', 'AnotherExcluded']));
      });

      test('parses excludeEnums', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeEnums': ['EnumA', 'EnumB'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeEnums, equals(['EnumA', 'EnumB']));
      });

      test('parses excludeFunctions', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeFunctions': ['helperFunction', 'internalFunc'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeFunctions, equals(['helperFunction', 'internalFunc']));
      });

      test('parses excludeVariables', () {
        final json = {
          'name': 'test',
          'barrelFiles': ['lib/test.dart'],
          'outputPath': 'lib/bridges.dart',
          'excludeVariables': ['_privateVar', 'debugMode'],
        };
        
        final config = ModuleConfig.fromJson(json);
        
        expect(config.excludeVariables, equals(['_privateVar', 'debugMode']));
      });

      test('parses all exclude fields together', () {
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

      test('defaults to empty lists when fields not provided', () {
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
      test('serializes basic config', () {
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

      test('serializes excludeClasses when non-empty', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeClasses: ['ClassA', 'ClassB'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeClasses'], equals(['ClassA', 'ClassB']));
      });

      test('serializes excludeEnums when non-empty', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeEnums: ['EnumA'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeEnums'], equals(['EnumA']));
      });

      test('serializes excludeFunctions when non-empty', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeFunctions: ['func1', 'func2'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeFunctions'], equals(['func1', 'func2']));
      });

      test('serializes excludeVariables when non-empty', () {
        final config = ModuleConfig(
          name: 'test',
          barrelFiles: ['lib/test.dart'],
          outputPath: 'lib/bridges.dart',
          excludeVariables: ['kConstant'],
        );
        
        final json = config.toJson();
        
        expect(json['excludeVariables'], equals(['kConstant']));
      });

      test('omits empty lists in serialization', () {
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

      test('round-trip preserves all fields', () {
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
        expect(restored.followReExports, equals(original.followReExports));
      });
    });
  });

  group('BridgeConfig', () {
    test('parses config with modules containing exclude fields', () {
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

