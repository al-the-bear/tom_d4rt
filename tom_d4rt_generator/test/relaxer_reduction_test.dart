/// Tests for the P&R#4 relaxer/RC-2 generation reduction knob.
///
/// `BridgeConfig.generateAllRelaxers` (default `true`) controls whether the
/// combinatorial relaxer-factory / RC-2 generic-constructor switches enumerate
/// *every* concrete bridged class as a candidate generic type-argument, or only
/// a reduced allowlist (discovered extraction sites ∪ `relaxerClasses` ∪
/// `additionalRelaxerTypes`).
///
/// The fixture is a generic `Box<T>` (unbounded single type param with a
/// non-factory constructor) plus three concrete classes `Apple`, `Banana`,
/// `Cherry`. Only `Box<Apple>` is referenced by an extraction site, so under
/// the default the switches still enumerate all three concrete types (the
/// combinatorial explosion); under the reduced mode only the allowlisted types
/// appear.
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('Relaxer reduction knob (P&R#4)', () {
    const barrel = 'package:fake_pkg/fake_pkg.dart';

    ClassInfo concrete(String name) =>
        ClassInfo(name: name, sourceFile: barrel);

    Map<String, ClassInfo> buildLookup() => {
          'Box': ClassInfo(
            name: 'Box',
            sourceFile: barrel,
            typeParameters: const {'T': null},
            constructors: const [
              ConstructorInfo(
                parameters: [ParameterInfo(name: 'value', type: 'T')],
              ),
            ],
          ),
          'Apple': concrete('Apple'),
          'Banana': concrete('Banana'),
          'Cherry': concrete('Cherry'),
        };

    BridgeConfig configFor(
      String outputPath, {
      bool generateAllRelaxers = true,
      List<RelaxerClassConfig> relaxerClasses = const [],
      List<String> additionalRelaxerTypes = const [],
    }) =>
        BridgeConfig(
          name: 'fake_pkg',
          modules: const [
            ModuleConfig(
              name: 'fake',
              barrelFiles: ['lib/fake_pkg.dart'],
              outputPath: 'lib/src/fake.b.dart',
              barrelImport: barrel,
            ),
          ],
          relaxerOutputPath: outputPath,
          generateAllRelaxers: generateAllRelaxers,
          relaxerClasses: relaxerClasses,
          additionalRelaxerTypes: additionalRelaxerTypes,
        );

    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('relaxer_reduction_test');
    });

    tearDown(() {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    });

    Future<String> runAndRead(BridgeConfig config) async {
      final result = await generateRelaxers(
        config: config,
        projectPath: tempDir.path,
        globalClassLookup: buildLookup(),
        genericExtractionSites: const [
          GenericExtractionSite(
            baseTypeName: 'Box',
            typeArg: 'Apple',
            moduleName: 'fake',
          ),
        ],
      );
      expect(result.outputFile, isNotNull,
          reason: 'generation should have produced an output file');
      return File(result.outputFile!).readAsStringSync();
    }

    test('G-RDX-1: default (generateAllRelaxers true) enumerates every concrete type. [2026-06-07 00:00] (PASS)',
        () async {
      final output = await runAndRead(
        configFor('${tempDir.path}/relaxers_full.b.dart'),
      );

      // All three concrete types are emitted as switch cases even though only
      // Box<Apple> is referenced by a real extraction site — this is the
      // combinatorial surface the knob is designed to cap.
      expect(output, contains("'Apple'"));
      expect(output, contains("'Banana'"));
      expect(output, contains("'Cherry'"));
    });

    test('G-RDX-2: reduced mode keeps discovered + additionalRelaxerTypes only. [2026-06-07 00:00] (PASS)',
        () async {
      // Allowlist = {Apple (from extraction site)} ∪ {Banana (additional)}.
      final output = await runAndRead(
        configFor(
          '${tempDir.path}/relaxers_reduced_add.b.dart',
          generateAllRelaxers: false,
          additionalRelaxerTypes: const ['Banana'],
        ),
      );

      expect(output, contains("'Apple'"));
      expect(output, contains("'Banana'"));
      expect(output, isNot(contains('Cherry')));
    });

    test('G-RDX-3: reduced mode keeps discovered + relaxerClasses only. [2026-06-07 00:00] (PASS)',
        () async {
      // Allowlist = {Apple (from extraction site)} ∪ {Cherry (relaxerClasses)}.
      final output = await runAndRead(
        configFor(
          '${tempDir.path}/relaxers_reduced_classes.b.dart',
          generateAllRelaxers: false,
          relaxerClasses: const [RelaxerClassConfig(className: 'Cherry')],
        ),
      );

      expect(output, contains("'Apple'"));
      expect(output, contains("'Cherry'"));
      expect(output, isNot(contains('Banana')));
    });

    test('G-RDX-4: package-qualified additionalRelaxerTypes resolve to bare name. [2026-06-07 00:00] (PASS)',
        () async {
      // 'package:fake_pkg/fake_pkg.dart:Banana' → bare 'Banana' for matching.
      final output = await runAndRead(
        configFor(
          '${tempDir.path}/relaxers_reduced_qualified.b.dart',
          generateAllRelaxers: false,
          additionalRelaxerTypes: const [
            'package:fake_pkg/fake_pkg.dart:Banana',
          ],
        ),
      );

      expect(output, contains("'Apple'"));
      expect(output, contains("'Banana'"));
      expect(output, isNot(contains('Cherry')));
    });
  });
}
