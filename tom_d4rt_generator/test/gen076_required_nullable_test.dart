// GEN-076: Test required nullable parameter and non-wrappable default bridging
//
// These tests verify:
// 1. Required nullable parameters (e.g., required bool? value) generate
//    getRequiredNamedArg<bool?> — NOT getRequiredNamedArg<bool>
// 2. Static const defaults (e.g., thickness = defaultThickness) are handled
//    by resolving the literal value when possible

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String generatedCode;
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() async {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp
        .createTempSync('gen076_required_nullable_test_')
        .path;

    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'required_nullable_source.dart',
      packageName: 'test_package',
      verbose: false,
    );

    final sourceFile =
        p.join(testFixturesDir, 'required_nullable_source.dart');
    final outputFile =
        p.join(tempOutputDir, 'required_nullable_bridges_test.dart');

    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'test_required_nullable',
    );

    expect(result.errors, isEmpty, reason: 'Should generate without errors');
    expect(result.outputFiles, isNotEmpty);

    generatedCode = await File(result.outputFiles.first).readAsString();
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-076: Required nullable parameters', () {
    test(
      'G-ISS-30: required bool? value emits getRequiredNamedArg<bool?> [2025-06-27] (PASS)',
      () {
        // The generator must use bool? (nullable) not bool (non-nullable)
        // for required nullable parameters like CupertinoCheckbox.value
        expect(
          generatedCode,
          contains("getRequiredNamedArg<bool?>"),
          reason:
              'Required bool? parameter must use nullable type in extraction',
        );
      },
    );

    test(
      'G-ISS-31: required String? label emits getRequiredNamedArg<String?> [2025-06-27] (PASS)',
      () {
        expect(
          generatedCode,
          contains("getRequiredNamedArg<String?>"),
          reason:
              'Required String? parameter must use nullable type in extraction',
        );
      },
    );

    test(
      'G-ISS-32: required int? priority emits getRequiredNamedArg<int?> [2025-06-27] (PASS)',
      () {
        expect(
          generatedCode,
          contains("getRequiredNamedArg<int?>"),
          reason:
              'Required int? parameter must use nullable type in extraction',
        );
      },
    );

    test(
      'G-ISS-33: tristate with default false uses getNamedArgWithDefault [2025-06-27] (PASS)',
      () {
        expect(
          generatedCode,
          contains("getNamedArgWithDefault<bool>("),
          reason:
              'Non-required bool parameter with default should use getNamedArgWithDefault',
        );
      },
    );
  });

  group('GEN-076: Non-wrappable defaults', () {
    test(
      'G-ISS-34: static const default generates containsKey conditional [2025-06-27] (PASS)',
      () {
        // Parameters with static const defaults that reference same-class
        // members should generate conditional containsKey branches that omit
        // the param from the native call when not provided, letting the
        // native default apply.
        expect(
          generatedCode,
          contains("!named.containsKey('thickness')"),
          reason:
              'Static const defaults should use containsKey conditional pattern',
        );
      },
    );

    test(
      'G-ISS-35: thickness param uses conditional branch pattern [2025-06-27] (PASS)',
      () {
        // When thickness is provided, it should be extracted and passed;
        // when not provided, it should be omitted from the constructor call
        expect(
          generatedCode,
          contains("named.containsKey('thickness')"),
          reason:
              'Generated code should check containsKey for static const default params',
        );
        expect(
          generatedCode,
          contains("named.containsKey('thicknessWhileDragging')"),
          reason:
              'Generated code should check containsKey for static const default params',
        );
      },
    );

    test(
      'G-ISS-36: private constant default uses containsKey pattern [2025-06-27] (PASS)',
      () {
        // Private constants like _kDefaultPadding also generate containsKey
        // conditional branches
        expect(
          generatedCode,
          contains("!named.containsKey('padding')"),
          reason:
              'Private constant default should also use containsKey pattern',
        );
      },
    );
  });
}
