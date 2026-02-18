import 'package:test/test.dart';
import 'package:tom_analyzer/src/reflection/generator/generator.dart';

void main() {
  group('GlobMatcher', () {
    test('matches exact string', () {
      final matcher = GlobMatcher('flutter');
      expect(matcher.matches('flutter'), isTrue);
      expect(matcher.matches('flutter_bloc'), isFalse);
      expect(matcher.matches('my_flutter'), isFalse);
    });

    test('matches with * wildcard', () {
      final matcher = GlobMatcher('flutter_*');
      expect(matcher.matches('flutter_bloc'), isTrue);
      expect(matcher.matches('flutter_riverpod'), isTrue);
      expect(matcher.matches('flutter'), isFalse);
      expect(matcher.matches('my_flutter_bloc'), isFalse);
    });

    test('matches with ** wildcard', () {
      final matcher = GlobMatcher('**/test/**');
      expect(matcher.matches('lib/test/helper.dart'), isTrue);
      expect(matcher.matches('src/test/data/model.dart'), isTrue);
      expect(matcher.matches('test.dart'), isFalse);
    });

    test('matches with ? wildcard', () {
      final matcher = GlobMatcher('User?');
      expect(matcher.matches('User1'), isTrue);
      expect(matcher.matches('UserA'), isTrue);
      expect(matcher.matches('User'), isFalse);
      expect(matcher.matches('User12'), isFalse);
    });

    test('matches dart SDK packages', () {
      final matcher = GlobMatcher('dart:*');
      expect(matcher.matches('dart:core'), isTrue);
      expect(matcher.matches('dart:async'), isTrue);
      expect(matcher.matches('package:dart'), isFalse);
    });

    test('escapes regex special characters', () {
      final matcher = GlobMatcher('my.package');
      expect(matcher.matches('my.package'), isTrue);
      expect(matcher.matches('myXpackage'), isFalse);
    });

    test('handles prefix wildcards', () {
      final matcher = GlobMatcher('*Service');
      expect(matcher.matches('UserService'), isTrue);
      expect(matcher.matches('MyService'), isTrue);
      expect(matcher.matches('Service'), isTrue);
      expect(matcher.matches('ServiceManager'), isFalse);
    });
  });

  group('AnnotationPattern', () {
    test('parses short name', () {
      final pattern = AnnotationPattern.parse('Entity');
      expect(pattern.name, 'Entity');
      expect(pattern.isQualified, isFalse);
      expect(pattern.fieldMatchers, isNull);
    });

    test('parses qualified name with package URI', () {
      final pattern = AnnotationPattern.parse(
          'package:my_app/annotations.dart#Entity');
      expect(pattern.name, 'package:my_app/annotations.dart#Entity');
      expect(pattern.isQualified, isTrue);
    });

    test('parses short name with hash', () {
      final pattern = AnnotationPattern.parse('models.dart#Entity');
      expect(pattern.name, 'models.dart#Entity');
      expect(pattern.isQualified, isTrue);
    });

    test('parses annotation with field matchers', () {
      final pattern = AnnotationPattern.parse('Entity(tableName: *)');
      expect(pattern.name, 'Entity');
      expect(pattern.isQualified, isFalse);
      expect(pattern.fieldMatchers, isNotNull);
      expect(pattern.fieldMatchers!.containsKey('tableName'), isTrue);
    });

    test('parses @ prefix annotation', () {
      final pattern = AnnotationPattern.parse('@Entity');
      expect(pattern.name, '@Entity');
      expect(pattern.isQualified, isFalse);
    });
  });

  group('FilterMatcher', () {
    group('matchesPackage', () {
      test('matches exact package', () {
        final filter = ReflectionFilter(
          isInclude: true,
          packages: ['flutter'],
        );
        final matcher = FilterMatcher(filter);

        expect(matcher.matchesPackage('flutter'), isTrue);
        expect(matcher.matchesPackage('flutter_bloc'), isFalse);
      });

      test('matches wildcard packages', () {
        final filter = ReflectionFilter(
          isInclude: true,
          packages: ['flutter_*', 'dart:*'],
        );
        final matcher = FilterMatcher(filter);

        expect(matcher.matchesPackage('flutter_bloc'), isTrue);
        expect(matcher.matchesPackage('flutter_riverpod'), isTrue);
        expect(matcher.matchesPackage('dart:core'), isTrue);
        expect(matcher.matchesPackage('my_package'), isFalse);
      });

      test('returns false when no packages specified', () {
        final filter = ReflectionFilter(isInclude: true);
        final matcher = FilterMatcher(filter);

        expect(matcher.matchesPackage('flutter'), isFalse);
      });
    });

    group('matchesPath', () {
      test('matches glob patterns', () {
        final filter = ReflectionFilter(
          isInclude: false,
          paths: ['**/test/**', '**/*_test.dart'],
        );
        final matcher = FilterMatcher(filter);

        expect(matcher.matchesPath('lib/test/helper.dart'), isTrue);
        expect(matcher.matchesPath('src/user_test.dart'), isTrue);
        expect(matcher.matchesPath('lib/main.dart'), isFalse);
      });
    });

    group('matchesTypeName', () {
      test('matches type patterns', () {
        final filter = ReflectionFilter(
          isInclude: true,
          types: ['*Service', '*Repository'],
        );
        final matcher = FilterMatcher(filter);

        expect(matcher.matchesTypeName('UserService'), isTrue);
        expect(matcher.matchesTypeName('ProductRepository'), isTrue);
        expect(matcher.matchesTypeName('UserController'), isFalse);
      });
    });

    group('matchesElement', () {
      test('matches exact element identifiers', () {
        final filter = ReflectionFilter(
          isInclude: true,
          elements: [
            'package:my_app/models.dart#User',
            'package:my_app/services.dart#UserService',
          ],
        );
        final matcher = FilterMatcher(filter);

        expect(
            matcher.matchesElement('package:my_app/models.dart#User'), isTrue);
        expect(matcher.matchesElement('package:my_app/services.dart#UserService'),
            isTrue);
        expect(
            matcher.matchesElement('package:my_app/models.dart#Product'), isFalse);
      });
    });

    group('hasSelectors', () {
      test('returns false when no selectors', () {
        final filter = ReflectionFilter(isInclude: true);
        final matcher = FilterMatcher(filter);

        expect(matcher.hasSelectors, isFalse);
      });

      test('returns true when has packages', () {
        final filter = ReflectionFilter(
          isInclude: true,
          packages: ['flutter'],
        );
        final matcher = FilterMatcher(filter);

        expect(matcher.hasSelectors, isTrue);
      });

      test('returns true when has annotations', () {
        final filter = ReflectionFilter(
          isInclude: true,
          annotations: ['@Entity'],
        );
        final matcher = FilterMatcher(filter);

        expect(matcher.hasSelectors, isTrue);
      });
    });

    group('isInclude', () {
      test('reflects filter type', () {
        final includeFilter = ReflectionFilter(isInclude: true);
        expect(FilterMatcher(includeFilter).isInclude, isTrue);

        final excludeFilter = ReflectionFilter(isInclude: false);
        expect(FilterMatcher(excludeFilter).isInclude, isFalse);
      });
    });
  });

  group('DefaultsMatcher', () {
    test('detects excluded packages', () {
      final defaults = ReflectionDefaults(
        excludePackages: ['flutter', 'dart:*'],
      );
      final matcher = DefaultsMatcher(defaults);

      expect(matcher.isPackageExcluded('flutter'), isTrue);
      expect(matcher.isPackageExcluded('dart:core'), isTrue);
      expect(matcher.isPackageExcluded('my_package'), isFalse);
    });

    test('detects included packages', () {
      final defaults = ReflectionDefaults(
        includePackages: ['my_package_*'],
      );
      final matcher = DefaultsMatcher(defaults);

      expect(matcher.isPackageIncluded('my_package_core'), isTrue);
      expect(matcher.isPackageIncluded('my_package_ui'), isTrue);
      expect(matcher.isPackageIncluded('other_package'), isFalse);
    });
  });

  group('InclusionResolver', () {
    test('creates from config', () {
      final resolver = InclusionResolver(
        defaultsConfig: ReflectionDefaults(
          excludePackages: ['flutter', 'dart:*'],
        ),
        filterConfigs: [
          ReflectionFilter(isInclude: false, packages: ['test_*']),
        ],
      );

      expect(resolver.defaults, isNotNull);
      expect(resolver.filters.length, 1);
    });

    test('defaults matcher is accessible', () {
      final resolver = InclusionResolver(
        defaultsConfig: ReflectionDefaults(
          excludePackages: ['flutter'],
          includePackages: ['my_app'],
        ),
        filterConfigs: [],
      );

      expect(resolver.defaults.isPackageExcluded('flutter'), isTrue);
      expect(resolver.defaults.isPackageIncluded('my_app'), isTrue);
    });

    test('filters are ordered', () {
      final resolver = InclusionResolver(
        defaultsConfig: ReflectionDefaults(),
        filterConfigs: [
          ReflectionFilter(isInclude: false, packages: ['first']),
          ReflectionFilter(isInclude: true, packages: ['second']),
        ],
      );

      expect(resolver.filters.length, 2);
      expect(resolver.filters[0].isInclude, isFalse);
      expect(resolver.filters[1].isInclude, isTrue);
    });
  });
}
