// B5/R6: VM↔web signature-skew coercion table (MCI#10 / cleanup_todos #38).
//
// Some Flutter `dart:ui` members declare a named parameter nullable on the VM
// but non-nullable on web. The generator reads VM analyzer summaries, so the
// standard extraction emits `getNamedArgWithDefault<T?>(…)`, whose nullable
// result cannot be forwarded to the web's non-nullable parameter. For known
// skew params the generator appends a `?? default` coercion so the local
// infers the non-null `T`.
//
// These tests verify both states of the `enableVmWebSkewCoercion` gate:
//   - ON  → the `?? default` coercion is emitted for the skewed param.
//   - OFF → output is unchanged (committed `*.b.dart` stays byte-identical).

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

Future<String> _generate({required bool enableSkew}) async {
  final testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
  final tempOutputDir = Directory.systemTemp
      .createTempSync('vm_web_skew_test_')
      .path;

  final generator = BridgeGenerator(
    workspacePath: testFixturesDir,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    sourceImport: 'vm_web_skew_source.dart',
    packageName: 'test_package',
    verbose: false,
    enableVmWebSkewCoercion: enableSkew,
  );

  final sourceFile = p.join(testFixturesDir, 'vm_web_skew_source.dart');
  final outputFile = p.join(tempOutputDir, 'vm_web_skew_bridges_test.dart');

  final result = await generator.generateBridges(
    sourceFiles: [sourceFile],
    outputPath: outputFile,
    moduleName: 'test_vm_web_skew',
  );

  expect(result.errors, isEmpty, reason: 'Should generate without errors');
  expect(result.outputFiles, isNotEmpty);

  final code = await File(result.outputFiles.first).readAsString();
  try {
    Directory(tempOutputDir).deleteSync(recursive: true);
  } catch (_) {}
  return code;
}

/// Matches the skewed `offset` extraction with the `?? default` coercion,
/// allowing for an optional import prefix on `Offset`.
final _coercionPattern = RegExp(
  r"getNamedArgWithDefault<[\w$]*\.?Offset\?>\(named, 'offset', "
  r"[^;]*\) \?\? [^;]*;",
);

/// Matches the skewed `offset` extraction WITHOUT the coercion (gate off).
final _plainPattern = RegExp(
  r"getNamedArgWithDefault<[\w$]*\.?Offset\?>\(named, 'offset', "
  r"[^;?]*\);",
);

void main() {
  group('B5/R6: VM↔web signature-skew coercion', () {
    test(
      'G-ISS-38a: skew gate ON emits ?? default coercion for SceneBuilder.pushOpacity.offset [2026-06-07] (PASS)',
      () async {
        final code = await _generate(enableSkew: true);
        expect(
          code,
          matches(_coercionPattern),
          reason:
              'With the skew gate on, the nullable offset extraction must be '
              'coerced to non-null via `?? default`.',
        );
      },
    );

    test(
      'G-ISS-38b: skew gate OFF leaves offset extraction uncoerced [2026-06-07] (PASS)',
      () async {
        final code = await _generate(enableSkew: false);
        expect(
          code,
          isNot(matches(_coercionPattern)),
          reason:
              'With the skew gate off (default), no coercion is emitted so '
              'committed bridge output stays byte-identical.',
        );
        expect(
          code,
          matches(_plainPattern),
          reason:
              'The default path still emits the plain nullable extraction.',
        );
      },
    );
  });
}
