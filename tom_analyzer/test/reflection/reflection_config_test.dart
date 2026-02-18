import 'package:test/test.dart';
import 'package:tom_analyzer/src/reflection/generator/generator.dart';

void main() {
  group('ReflectionConfig', () {
    group('fromMap', () {
      test('parses minimal configuration', () {
        final config = ReflectionConfig.fromMap({
          'entry_points': ['lib/main.dart'],
        });

        expect(config.entryPoints, ['lib/main.dart']);
        expect(config.output, isNull);
        expect(config.filters, isEmpty);
        expect(config.includePrivate, isFalse);
      });

      test('parses complete configuration', () {
        final config = ReflectionConfig.fromMap({
          'entry_points': ['lib/app.dart', 'lib/cli.dart'],
          'output': 'lib/reflection',
          'include_private': true,
          'defaults': {
            'exclude_packages': ['flutter', 'dart:*'],
            'include_packages': ['my_package'],
            'include_annotations': ['package:json_annotation/json_annotation.dart#JsonSerializable'],
          },
          'filters': [
            {'exclude': {'packages': ['test_*']}},
            {'include': {'annotations': ['@Entity']}},
          ],
          'dependency_config': {
            'superclasses': {'depth': 3, 'external_depth': 1},
            'interfaces': {'enabled': true},
          },
          'coverage_config': {
            'instance_members': {
              'pattern': 'get*',
              'annotations': ['@reflectable'],
            },
          },
        });

        expect(config.entryPoints, ['lib/app.dart', 'lib/cli.dart']);
        expect(config.output, 'lib/reflection');
        expect(config.includePrivate, isTrue);
        expect(config.defaults.excludePackages, ['flutter', 'dart:*']);
        expect(config.defaults.includePackages, ['my_package']);
        expect(config.filters.length, 2);
        expect(config.dependencyConfig.superclasses.depth, 3);
        expect(config.dependencyConfig.superclasses.externalDepth, 1);
        expect(config.dependencyConfig.interfaces.enabled, isTrue);
        expect(config.coverageConfig.instanceMembers.pattern, 'get*');
      });

      test('handles empty configuration', () {
        final config = ReflectionConfig.fromMap({});

        expect(config.entryPoints, isEmpty);
        expect(config.output, isNull);
        expect(config.filters, isEmpty);
      });
    });

    group('getOutputPathFor', () {
      test('derives output from entry point', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/main.dart'],
          output: 'lib/reflection',
        );

        // Currently getOutputPathFor derives from entry point, not output
        expect(config.getOutputPathFor('lib/main.dart'), 'lib/main.r.dart');
      });

      test('derives output from entry point when no output specified', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/my_app.dart'],
        );

        expect(config.getOutputPathFor('lib/my_app.dart'), 'lib/my_app.r.dart');
      });

      test('handles entry point with .dart extension', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/main.dart'],
        );

        // Should replace .dart with .r.dart
        final path = config.getOutputPathFor('lib/main.dart');
        expect(path, 'lib/main.r.dart');
        expect(path, endsWith('.r.dart'));
        expect(path, isNot(endsWith('.dart.r.dart')));
      });

      test('handles entry point without .dart extension', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/main'],
        );

        expect(config.getOutputPathFor('lib/main'), 'lib/main.r.dart');
      });
    });

    group('hasMultipleEntryPoints', () {
      test('returns false for single entry point', () {
        final config = ReflectionConfig(entryPoints: ['lib/main.dart']);
        expect(config.hasMultipleEntryPoints, isFalse);
      });

      test('returns true for multiple entry points', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/cli.dart', 'lib/server.dart'],
        );
        expect(config.hasMultipleEntryPoints, isTrue);
      });

      test('returns false for empty entry points', () {
        final config = ReflectionConfig(entryPoints: []);
        expect(config.hasMultipleEntryPoints, isFalse);
      });
    });

    group('shouldCombineOutput', () {
      test('returns true when output is specified with multiple entries', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/a.dart', 'lib/b.dart'],
          output: 'lib/combined',
        );
        expect(config.shouldCombineOutput, isTrue);
      });

      test('returns false when no output specified', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/a.dart', 'lib/b.dart'],
        );
        expect(config.shouldCombineOutput, isFalse);
      });

      test('returns false for single entry point', () {
        final config = ReflectionConfig(
          entryPoints: ['lib/main.dart'],
          output: 'lib/reflection',
        );
        expect(config.shouldCombineOutput, isFalse);
      });
    });
  });

  group('ReflectionDefaults', () {
    test('parses from map', () {
      final defaults = ReflectionDefaults.fromMap({
        'exclude_packages': ['flutter', 'dart:*'],
        'include_packages': ['my_package'],
        'include_annotations': ['@Entity'],
      });

      expect(defaults.excludePackages, ['flutter', 'dart:*']);
      expect(defaults.includePackages, ['my_package']);
      expect(defaults.includeAnnotations, ['@Entity']);
    });

    test('handles empty map', () {
      final defaults = ReflectionDefaults.fromMap({});

      expect(defaults.excludePackages, isEmpty);
      expect(defaults.includePackages, isEmpty);
      expect(defaults.includeAnnotations, isEmpty);
    });
  });

  group('ReflectionFilter', () {
    test('parses include filter', () {
      final filter = ReflectionFilter.fromMap({
        'include': {
          'packages': ['my_package'],
          'annotations': ['@Entity'],
          'types': ['User*'],
        },
      });

      expect(filter.isInclude, isTrue);
      expect(filter.packages, ['my_package']);
      expect(filter.annotations, ['@Entity']);
      expect(filter.types, ['User*']);
    });

    test('parses exclude filter', () {
      final filter = ReflectionFilter.fromMap({
        'exclude': {
          'packages': ['test_*'],
          'paths': ['**/test/**'],
        },
      });

      expect(filter.isInclude, isFalse);
      expect(filter.packages, ['test_*']);
      expect(filter.paths, ['**/test/**']);
    });

    test('parses element identifiers', () {
      final filter = ReflectionFilter.fromMap({
        'include': {
          'elements': [
            'package:my_app/models.dart#User',
            'package:my_app/services.dart#UserService',
          ],
        },
      });

      expect(filter.elements, [
        'package:my_app/models.dart#User',
        'package:my_app/services.dart#UserService',
      ]);
    });

    test('handles hasSelectors', () {
      final emptyFilter = ReflectionFilter(isInclude: true);
      expect(emptyFilter.hasSelectors, isFalse);

      final withPackages = ReflectionFilter(
        isInclude: true,
        packages: ['my_package'],
      );
      expect(withPackages.hasSelectors, isTrue);
    });
  });

  group('DependencyConfig', () {
    test('parses superclass config', () {
      final config = DependencyConfig.fromMap({
        'superclasses': {
          'depth': 5,
          'external_depth': 2,
          'exclude_types': ['Object', 'StatelessWidget'],
        },
      });

      expect(config.superclasses.depth, 5);
      expect(config.superclasses.externalDepth, 2);
      expect(config.superclasses.excludeTypes, ['Object', 'StatelessWidget']);
    });

    test('parses interface config', () {
      final config = DependencyConfig.fromMap({
        'interfaces': {
          'enabled': true,
          'external': false,
        },
      });

      expect(config.interfaces.enabled, isTrue);
      expect(config.interfaces.external, isFalse);
    });

    test('parses mixin config', () {
      final config = DependencyConfig.fromMap({
        'mixins': {
          'enabled': true,
          'external': true,
        },
      });

      expect(config.mixins.enabled, isTrue);
      expect(config.mixins.external, isTrue);
    });

    test('defaults are correct', () {
      final config = DependencyConfig();

      expect(config.superclasses.depth, -1); // unlimited
      expect(config.superclasses.externalDepth, 2); // default is 2
      expect(config.interfaces.enabled, isTrue);
      expect(config.mixins.enabled, isTrue);
    });
  });

  group('CoverageConfig', () {
    test('parses instance members config', () {
      final config = CoverageConfig.fromMap({
        'instance_members': {
          'enabled': true,
          'pattern': 'get*',
          'annotations': ['@reflectable'],
        },
      });

      expect(config.instanceMembers.enabled, isTrue);
      expect(config.instanceMembers.pattern, 'get*');
      expect(config.instanceMembers.annotations, ['@reflectable']);
    });

    test('parses constructors config', () {
      final config = CoverageConfig.fromMap({
        'constructors': {
          'enabled': true,
          'pattern': 'from*',
        },
      });

      expect(config.constructors.enabled, isTrue);
      expect(config.constructors.pattern, 'from*');
    });

    test('parses top level config', () {
      final config = CoverageConfig.fromMap({
        'top_level': {
          'enabled': false,
        },
      });

      expect(config.topLevel.enabled, isFalse);
    });

    test('parses static members config', () {
      final config = CoverageConfig.fromMap({
        'static_members': {
          'enabled': false,
        },
      });

      expect(config.staticMembers.enabled, isFalse);
    });

    test('defaults are correct', () {
      final config = CoverageConfig();

      expect(config.instanceMembers.enabled, isTrue);
      expect(config.constructors.enabled, isTrue);
      expect(config.topLevel.enabled, isTrue);
    });
  });
}
