/// DGU3 — configurable `typeMappings` escape hatch + `additionalImports`.
///
/// Upstream `GeneratorConfig` exposes `typeMappings: Map<String,String>` as an
/// explicit escape hatch that substitutes an awkward source type with another
/// type at emission time. Our generator historically handled awkward types only
/// in generator code, forcing a code patch for every downstream package. These
/// tests pin the config seam that upholds the "fix the generator, not the
/// generated code" rule:
///
///   • `typeMappings: {'Awkward': 'dynamic'}` rewrites every *type-resolution*
///     reference to `Awkward` (parameters, fields, return types, and each type
///     argument inside generics) to `dynamic`, while leaving `Awkward`'s own
///     bridge registration intact.
///   • `additionalImports` adds custom `import` directives to the generated file
///     so a substitute type can live in a package the generator would not
///     otherwise import.
///   • Both default to empty and round-trip through json/copyWith, so committed
///     output stays byte-identical until a config opts in.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;
  late String sourceFile;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp.createTempSync('type_mappings_').path;
    sourceFile = p.join(testFixturesDir, 'type_mappings_source.dart');
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  Future<String> generate({
    Map<String, String> typeMappings = const {},
    List<String> additionalImports = const [],
    required String tag,
  }) async {
    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'type_mappings_source.dart',
      packageName: 'test_package',
      verbose: false,
      typeMappings: typeMappings,
      additionalImports: additionalImports,
    );

    final outputFile = p.join(tempOutputDir, 'tm_$tag.dart');
    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'tm_$tag',
    );
    expect(result.errors, isEmpty, reason: 'Should generate without errors');
    expect(result.outputFiles, isNotEmpty);
    return File(result.outputFiles.first).readAsString();
  }

  group('DGU3 typeMappings generator escape hatch', () {
    late String generatedOff;
    late String generatedOn;

    setUpAll(() async {
      generatedOff = await generate(tag: 'off');
      generatedOn = await generate(
        tag: 'on',
        typeMappings: const {'Awkward': 'dynamic'},
        additionalImports: const ['package:test_package/shims.dart'],
      );
    });

    test(
      'G-DGU3-1: without mapping, Awkward-typed params resolve to the concrete '
      'Awkward type. [2026-07-21] (PASS)',
      () {
        // Each Gadget member extracts its Awkward argument with the concrete
        // prefixed type — this is the awkward emission the escape hatch targets.
        expect(generatedOff, contains("Awkward>(positional, 0, 'input'"));
        expect(generatedOff, contains("Awkward>(positional, 0, 'first'"));
        expect(generatedOff, contains("Awkward>(positional, 0, 'seed'"));
        // No substitution occurred (baseline).
        expect(
          generatedOff,
          isNot(contains("getRequiredArg<dynamic>(positional, 0, 'input'")),
          reason: 'without a mapping the param keeps its concrete type',
        );
      },
    );

    test(
      'G-DGU3-2: mapping Awkward->dynamic substitutes every type-resolution '
      'reference at extraction sites. [2026-07-21] (PASS)',
      () {
        for (final param in ['input', 'first', 'seed']) {
          expect(
            generatedOn,
            contains("getRequiredArg<dynamic>(positional, 0, '$param'"),
            reason: 'mapped param "$param" must extract as dynamic',
          );
          expect(
            generatedOn,
            isNot(contains("Awkward>(positional, 0, '$param'")),
            reason: 'mapped param "$param" must not keep the concrete Awkward '
                'type',
          );
        }
      },
    );

    test(
      "G-DGU3-3: the mapped type's own bridge registration is left intact. "
      '[2026-07-21] (PASS)',
      () {
        // typeMappings must only rewrite type *references*, never erase the
        // class bridge itself — Awkward is still registered and constructible.
        expect(generatedOn, contains("name: 'Awkward'"));
        expect(generatedOn, contains('_createAwkwardBridge'));
        expect(
          generatedOn,
          contains('nativeType: \$test_package_1.Awkward'),
          reason: 'the bridge nativeType stays the real class, not dynamic',
        );
      },
    );

    test(
      'G-DGU3-4: additionalImports are emitted into the generated file. '
      '[2026-07-21] (PASS)',
      () {
        expect(
          generatedOn,
          contains("import 'package:test_package/shims.dart';"),
          reason: 'configured additional import must appear in the output',
        );
        expect(
          generatedOff,
          isNot(contains("import 'package:test_package/shims.dart';")),
          reason: 'no additional import is emitted without configuration',
        );
      },
    );
  });

  group('DGU3 BridgeConfig plumbing', () {
    test(
      'G-DGU3-5: typeMappings and additionalImports default empty and '
      'round-trip through json/copyWith. [2026-07-21] (PASS)',
      () {
        const base = BridgeConfig(name: 'pkg', modules: []);
        expect(base.typeMappings, isEmpty);
        expect(base.additionalImports, isEmpty);

        // Empty ⇒ keys omitted from json (back-compatible).
        expect(base.toJson().containsKey('typeMappings'), isFalse);
        expect(base.toJson().containsKey('additionalImports'), isFalse);

        final configured = base.copyWith(
          typeMappings: const {'Awkward': 'dynamic', 'Sealed?': 'Object?'},
          additionalImports: const ['package:my_pkg/shims.dart'],
        );
        expect(configured.typeMappings['Awkward'], 'dynamic');
        expect(configured.typeMappings['Sealed?'], 'Object?');
        expect(configured.additionalImports, ['package:my_pkg/shims.dart']);
        expect(configured.toJson()['typeMappings'], isNotNull);
        expect(configured.toJson()['additionalImports'], isNotNull);

        final restored = BridgeConfig.fromJson(configured.toJson());
        expect(restored.typeMappings, configured.typeMappings);
        expect(restored.additionalImports, configured.additionalImports);

        // Absent in json ⇒ empty.
        final fromBare = BridgeConfig.fromJson({'name': 'pkg', 'modules': []});
        expect(fromBare.typeMappings, isEmpty);
        expect(fromBare.additionalImports, isEmpty);
      },
    );
  });
}
