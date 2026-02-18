import 'package:test/test.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_generator.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_config.dart';

void main() {
  group('ReflectionGenerator', () {
    group('constructor', () {
      test('creates generator with config', () {
        final config = ReflectionConfig.fromMap({'entry_points': []});
        final generator = ReflectionGenerator(config);

        expect(generator.config, same(config));
      });
    });

    group('fromMap factory', () {
      test('creates generator from minimal map', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
        });

        expect(generator.config, isA<ReflectionConfig>());
        expect(generator.config.entryPoints, isEmpty);
      });

      test('creates generator with entry points', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': ['lib/main.dart'],
        });

        expect(generator.config.entryPoints, hasLength(1));
        expect(generator.config.entryPoints.first, 'lib/main.dart');
      });

      test('creates generator with output path', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': ['lib/main.dart'],
          'output': 'lib/reflection.r.dart',
        });

        expect(generator.config.output, 'lib/reflection.r.dart');
      });

      test('creates generator with filters', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'filters': [
            {'include': 'MyClass'},
          ],
        });

        expect(generator.config.filters, hasLength(1));
      });
    });

    group('config access', () {
      test('config returns the configuration', () {
        final config = ReflectionConfig.fromMap({
          'entry_points': ['lib/src/models.dart'],
          'output': 'lib/generated/reflection.r.dart',
        });
        final generator = ReflectionGenerator(config);

        expect(generator.config.entryPoints, ['lib/src/models.dart']);
        expect(generator.config.output, 'lib/generated/reflection.r.dart');
      });

      test('config has expected default values', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
        });

        expect(generator.config.defaults.excludePackages, isEmpty);
        expect(generator.config.defaults.includePackages, isEmpty);
        expect(generator.config.filters, isEmpty);
      });
    });

    group('configuration integration', () {
      test('generator respects defaults.excludePackages config', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'defaults': {
            'exclude_packages': ['flutter', 'dart:core'],
          },
        });

        expect(generator.config.defaults.excludePackages, contains('flutter'));
        expect(
            generator.config.defaults.excludePackages, contains('dart:core'));
      });

      test('generator respects defaults.includePackages config', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'defaults': {
            'include_packages': ['my_package', 'shared_lib'],
          },
        });

        expect(
            generator.config.defaults.includePackages, contains('my_package'));
        expect(
            generator.config.defaults.includePackages, contains('shared_lib'));
      });

      test('generator respects dependency_config', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'dependency_config': {
            'superclasses': {'enabled': true, 'depth': 3},
          },
        });

        expect(generator.config.dependencyConfig, isNotNull);
        expect(generator.config.dependencyConfig.superclasses.enabled, isTrue);
        expect(generator.config.dependencyConfig.superclasses.depth, 3);
      });
    });

    group('multiple entry points', () {
      test('generator accepts multiple entry points', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [
            'lib/main.dart',
            'lib/src/models/user.dart',
            'lib/src/services/api.dart',
          ],
        });

        expect(generator.config.entryPoints, hasLength(3));
      });

      test('generator accepts glob patterns in entry points', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [
            'lib/src/models/*.dart',
            'lib/src/services/**/*.dart',
          ],
        });

        expect(generator.config.entryPoints, hasLength(2));
        expect(generator.config.entryPoints, contains('lib/src/models/*.dart'));
      });
    });

    group('filter combinations', () {
      test('generator with include filters', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'filters': [
            {'include': 'User*'},
            {'include': '*Service'},
          ],
        });

        expect(generator.config.filters, hasLength(2));
      });

      test('generator with exclude filters', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'filters': [
            {'exclude': '*Test'},
            {'exclude': 'Mock*'},
          ],
        });

        expect(generator.config.filters, hasLength(2));
      });

      test('generator with mixed filters', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [],
          'filters': [
            {'include': '*Model'},
            {'exclude': 'Internal*'},
            {'include': '*Repository'},
          ],
        });

        expect(generator.config.filters, hasLength(3));
      });
    });

    group('complex configuration', () {
      test('generator with full configuration', () {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': ['lib/main.dart'],
          'output': 'lib/generated/reflection.r.dart',
          'defaults': {
            'exclude_packages': ['flutter_test'],
            'include_packages': ['my_core_package'],
          },
          'filters': [
            {'include': '*Model'},
            {'exclude': '*_'},
          ],
          'dependency_config': {
            'superclasses': {'enabled': true, 'depth': 2},
          },
        });

        expect(generator.config.entryPoints, ['lib/main.dart']);
        expect(generator.config.output, 'lib/generated/reflection.r.dart');
        expect(generator.config.defaults.excludePackages, ['flutter_test']);
        expect(generator.config.defaults.includePackages, ['my_core_package']);
        expect(generator.config.filters, hasLength(2));
        expect(generator.config.dependencyConfig.superclasses.enabled, isTrue);
        expect(generator.config.dependencyConfig.superclasses.depth, 2);
      });
    });
  });
}
