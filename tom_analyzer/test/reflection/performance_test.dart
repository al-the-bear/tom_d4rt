import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_generator.dart';

/// Performance tests for reflection code generation.
///
/// These tests verify that the generator performs well on larger codebases
/// and provides metrics for analysis and generation times.
void main() {
  group('ReflectionGenerator - Performance Tests', () {
    // Location of the large sample project - use absolute path
    // The test runs from tom_analyzer directory, so we navigate from workspace root
    final workspaceRoot = p.normalize(p.join(
      Directory.current.path,
      '..',
      '..',
      '..',
    ));
    final uamServerPath = p.join(workspaceRoot, 'uam', 'tom_uam_server');
    final aaServerStartPath =
        p.join(uamServerPath, 'bin', 'aa_server_start.dart');

    // Check if the UAM server project exists
    final uamServerExists = File(aaServerStartPath).existsSync();

    group('analysis performance', () {
      test('analyzes small fixture in reasonable time', () async {
        final fixturesPath = p.join(
          Directory.current.path,
          'test',
          'reflection',
          'fixtures',
          'sample_models.dart',
        );

        final stopwatch = Stopwatch()..start();

        final generator = ReflectionGenerator.fromMap({
          'entry_points': [fixturesPath],
        });
        final result = await generator.analyze();

        stopwatch.stop();

        // Small fixture should analyze in under 5 seconds
        expect(stopwatch.elapsedMilliseconds, lessThan(5000),
            reason: 'Small fixture analysis took ${stopwatch.elapsed}');

        // Should have discovered types
        expect(result.typeCount, greaterThan(0));

        // Print metrics for debugging
        print('Small fixture analysis time: ${stopwatch.elapsed}');
        print('Types discovered: ${result.typeCount}');
        print('Global members: ${result.globalMemberCount}');
      });

      test('analysis time scales reasonably with type count', () async {
        final fixturesPath = p.join(
          Directory.current.path,
          'test',
          'reflection',
          'fixtures',
          'sample_models.dart',
        );

        // Run multiple analyses to get average
        final times = <int>[];
        for (var i = 0; i < 3; i++) {
          final stopwatch = Stopwatch()..start();

          final generator = ReflectionGenerator.fromMap({
            'entry_points': [fixturesPath],
          });
          await generator.analyze();

          stopwatch.stop();
          times.add(stopwatch.elapsedMilliseconds);
        }

        final avgTime = times.reduce((a, b) => a + b) / times.length;
        print('Average analysis time (3 runs): ${avgTime.toStringAsFixed(1)}ms');

        // First run may be slower due to warm-up, subsequent runs should be faster
        expect(times.last, lessThanOrEqualTo(times.first + 1000),
            reason: 'Analysis time should be consistent');
      });
    },
        skip: !File(p.join(Directory.current.path, 'test', 'reflection',
                'fixtures', 'sample_models.dart'))
            .existsSync());

    group('code generation performance', () {
      test('generates code in reasonable time for small fixture', () async {
        final fixturesPath = p.join(
          Directory.current.path,
          'test',
          'reflection',
          'fixtures',
          'sample_models.dart',
        );

        final generator = ReflectionGenerator.fromMap({
          'entry_points': [fixturesPath],
        });

        // Measure analysis + generation separately
        final analysisWatch = Stopwatch()..start();
        await generator.analyze();
        analysisWatch.stop();

        final generationWatch = Stopwatch()..start();
        final code = await generator.generate();
        generationWatch.stop();

        // Analysis should be under 5 seconds
        expect(analysisWatch.elapsedMilliseconds, lessThan(5000));

        // Generation should be fast (under 2 seconds)
        expect(generationWatch.elapsedMilliseconds, lessThan(2000));

        // Generated code should be non-empty
        expect(code.length, greaterThan(1000));

        print('Analysis time: ${analysisWatch.elapsed}');
        print('Generation time: ${generationWatch.elapsed}');
        print('Generated code size: ${code.length} characters');
      });

      test('generated code size is proportional to type count', () async {
        final fixturesPath = p.join(
          Directory.current.path,
          'test',
          'reflection',
          'fixtures',
          'sample_models.dart',
        );

        final generator = ReflectionGenerator.fromMap({
          'entry_points': [fixturesPath],
        });

        final result = await generator.analyze();
        final code = await generator.generate();

        // Calculate characters per type
        final charsPerType = code.length / (result.typeCount + 1);
        print('Characters per type: ${charsPerType.toStringAsFixed(0)}');

        // Should be reasonable (not too large per type)
        expect(charsPerType, lessThan(50000),
            reason: 'Generated code per type should be reasonable');
      });
    });

    group(
      'large codebase performance (UAM Server)',
      () {
        test('analyzes aa_server_start.dart entry point', () async {
          final stopwatch = Stopwatch()..start();

          final generator = ReflectionGenerator.fromMap({
            'entry_points': [aaServerStartPath],
          });
          final result = await generator.analyze();

          stopwatch.stop();

          print('UAM Server analysis time: ${stopwatch.elapsed}');
          print('Classes discovered: ${result.classes.length}');
          print('Enums discovered: ${result.enums.length}');
          print('Mixins discovered: ${result.mixins.length}');
          print('Extensions discovered: ${result.extensions.length}');
          print('Global functions: ${result.globalFunctions.length}');
          print('Total types: ${result.typeCount}');

          // Should discover a reasonable number of types
          expect(result.typeCount, greaterThan(0),
              reason: 'Should discover types from UAM server');

          // Analysis should complete in reasonable time (under 60 seconds)
          expect(stopwatch.elapsedMilliseconds, lessThan(60000),
              reason: 'Large codebase analysis took ${stopwatch.elapsed}');
        });

        test('generates code for aa_server_start.dart', () async {
          final generator = ReflectionGenerator.fromMap({
            'entry_points': [aaServerStartPath],
          });

          final analysisWatch = Stopwatch()..start();
          await generator.analyze();
          analysisWatch.stop();

          final generationWatch = Stopwatch()..start();
          final code = await generator.generate();
          generationWatch.stop();

          print('UAM Server analysis time: ${analysisWatch.elapsed}');
          print('UAM Server generation time: ${generationWatch.elapsed}');
          print('Generated code size: ${(code.length / 1024).toStringAsFixed(1)} KB');

          // Generation should complete in reasonable time
          expect(generationWatch.elapsedMilliseconds, lessThan(30000),
              reason: 'Code generation took ${generationWatch.elapsed}');

          // Generated code should be substantial for a real project
          expect(code.length, greaterThan(10000));
        });

        test('memory usage is reasonable', () async {
          // Force GC before measurement
          // (Note: Dart doesn't expose direct memory APIs in tests,
          // but we can ensure no out-of-memory errors occur)

          final generator = ReflectionGenerator.fromMap({
            'entry_points': [aaServerStartPath],
          });

          // Should complete without memory issues
          final result = await generator.analyze();
          final code = await generator.generate();

          expect(result, isNotNull);
          expect(code, isNotEmpty);
        });
      },
      skip: !uamServerExists
          ? 'UAM Server project not found at $aaServerStartPath'
          : null,
    );

    group('generator efficiency', () {
      test('reusing generator is efficient', () async {
        final fixturesPath = p.join(
          Directory.current.path,
          'test',
          'reflection',
          'fixtures',
          'sample_models.dart',
        );

        final generator = ReflectionGenerator.fromMap({
          'entry_points': [fixturesPath],
        });

        // First run
        final watch1 = Stopwatch()..start();
        await generator.generate();
        watch1.stop();

        // Second run (reusing generator)
        final watch2 = Stopwatch()..start();
        await generator.generate();
        watch2.stop();

        print('First generation: ${watch1.elapsed}');
        print('Second generation: ${watch2.elapsed}');

        // Both runs should complete reasonably
        expect(watch1.elapsedMilliseconds, lessThan(10000));
        expect(watch2.elapsedMilliseconds, lessThan(10000));
      });
    });
  });
}
