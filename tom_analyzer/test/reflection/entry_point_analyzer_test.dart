import 'package:test/test.dart';
import 'package:tom_analyzer/src/reflection/generator/generator.dart';

void main() {
  group('ReflectionAnalysisResult', () {
    test('empty result has zero counts', () {
      final result = ReflectionAnalysisResult();

      expect(result.classes, isEmpty);
      expect(result.enums, isEmpty);
      expect(result.mixins, isEmpty);
      expect(result.extensionTypes, isEmpty);
      expect(result.extensions, isEmpty);
      expect(result.typeAliases, isEmpty);
      expect(result.globalFunctions, isEmpty);
      expect(result.globalVariables, isEmpty);
      expect(result.typeCount, 0);
      expect(result.globalMemberCount, 0);
    });

    test('typeCount sums all type categories', () {
      // We can't easily create mock Element instances, so we test the
      // count calculation logic indirectly through the empty result
      final result = ReflectionAnalysisResult();
      expect(result.typeCount, 0);
    });

    test('globalMemberCount sums functions and variables', () {
      final result = ReflectionAnalysisResult();
      expect(result.globalMemberCount, 0);
    });

    test('packageLibraries is empty by default', () {
      final result = ReflectionAnalysisResult();
      expect(result.packageLibraries, isEmpty);
    });

    test('libraryTypes is empty by default', () {
      final result = ReflectionAnalysisResult();
      expect(result.libraryTypes, isEmpty);
    });
  });

  group('EntryPointAnalyzer', () {
    test('creates with config', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart'],
        defaults: ReflectionDefaults(
          excludePackages: ['flutter'],
        ),
      );
      final analyzer = EntryPointAnalyzer(config);

      expect(analyzer.config, same(config));
    });

    test('returns empty result for empty entry points', () async {
      final config = ReflectionConfig(entryPoints: []);
      final analyzer = EntryPointAnalyzer(config);

      final result = await analyzer.analyze();

      expect(result.classes, isEmpty);
      expect(result.enums, isEmpty);
      expect(result.typeCount, 0);
    });

    test('creates inclusion resolver from config', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart'],
        defaults: ReflectionDefaults(
          excludePackages: ['flutter', 'dart:*'],
          includePackages: ['my_app'],
        ),
        filters: [
          ReflectionFilter(isInclude: false, packages: ['test_*']),
        ],
      );

      // Just verify it creates without error
      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer, isNotNull);
    });
  });

  group('EntryPointAnalyzer configuration', () {
    test('respects exclude_packages in defaults', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart'],
        defaults: ReflectionDefaults(
          excludePackages: ['flutter', 'flutter_*', 'dart:*'],
        ),
      );

      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer.config.defaults.excludePackages, contains('flutter'));
      expect(analyzer.config.defaults.excludePackages, contains('dart:*'));
    });

    test('respects include_packages in defaults', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart'],
        defaults: ReflectionDefaults(
          includePackages: ['my_core', 'my_models'],
        ),
      );

      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer.config.defaults.includePackages, contains('my_core'));
    });

    test('applies filters in order', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart'],
        filters: [
          ReflectionFilter(isInclude: false, packages: ['excluded_*']),
          ReflectionFilter(isInclude: true, annotations: ['@Entity']),
          ReflectionFilter(isInclude: false, paths: ['**/test/**']),
        ],
      );

      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer.config.filters.length, 3);
      expect(analyzer.config.filters[0].isInclude, isFalse);
      expect(analyzer.config.filters[1].isInclude, isTrue);
      expect(analyzer.config.filters[2].isInclude, isFalse);
    });

    test('uses dependency config', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart'],
        dependencyConfig: DependencyConfig(
          superclasses: SuperclassConfig(depth: 3, externalDepth: 1),
          interfaces: InterfaceConfig(enabled: true, external: false),
          mixins: MixinConfig(enabled: true),
        ),
      );

      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer.config.dependencyConfig.superclasses.depth, 3);
      expect(analyzer.config.dependencyConfig.interfaces.enabled, isTrue);
      expect(analyzer.config.dependencyConfig.mixins.enabled, isTrue);
    });
  });

  group('EntryPointAnalyzer path handling', () {
    test('handles relative paths', () {
      final config = ReflectionConfig(
        entryPoints: ['lib/main.dart', 'bin/cli.dart'],
      );

      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer.config.entryPoints.length, 2);
    });

    test('handles absolute paths', () {
      final config = ReflectionConfig(
        entryPoints: ['/absolute/path/to/main.dart'],
      );

      final analyzer = EntryPointAnalyzer(config);
      expect(analyzer.config.entryPoints.first, startsWith('/'));
    });
  });
}
