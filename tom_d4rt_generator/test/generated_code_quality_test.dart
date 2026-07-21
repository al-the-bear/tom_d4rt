/// DGU4 — generated-code-quality regression guards.
///
/// Upstream 0.2.1 shipped four generated-code-quality fixes. Cross-checking each
/// against `tom_d4rt_generator` output showed our analyzer-driven emitter never
/// produced any of the four anti-patterns (unlike the heuristic upstream
/// generator these fixes targeted). These tests lock that in so a future
/// emitter change cannot silently reintroduce one:
///
///   1. generic collection extraction is well-formed (`D4.coerceList<T>(...)`
///      with no stray spaces / invalid angle-bracket tags);
///   2. abstract classes expose no generative constructor adapter (only
///      factories) and carry `isAbstract: true`;
///   3. no redundant `?? null` is emitted for optional params;
///   4. a param named `key` extracts as its *declared* type (`Marker?`), never a
///      force-inferred one.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;
  late String generated;

  setUpAll(() async {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp.createTempSync('gen_quality_').path;

    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'generated_code_quality_source.dart',
      packageName: 'test_package',
      verbose: false,
    );

    final sourceFile = p.join(
      testFixturesDir,
      'generated_code_quality_source.dart',
    );
    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: p.join(tempOutputDir, 'gen_quality.dart'),
      moduleName: 'gen_quality',
    );
    expect(result.errors, isEmpty, reason: 'Should generate without errors');
    expect(result.outputFiles, isNotEmpty);
    generated = await File(result.outputFiles.first).readAsString();
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('DGU4 generated-code-quality guards', () {
    test(
      'G-DGU4-1: generic collection extraction is well-formed. '
      '[2026-07-21] (PASS)',
      () {
        // Panel.mount(List<Item>) must emit a clean coerceList<...Item> call.
        expect(
          generated,
          contains('coerceList<'),
          reason: 'the List<Item> param must extract via coerceList',
        );
        expect(
          generated,
          matches(RegExp(r'coerceList<\$?[A-Za-z0-9_.]+\.Item>')),
          reason: 'the emitted generic type argument must be a tidy '
              'prefixed Item with no stray spaces or invalid tags',
        );
        // No malformed angle-bracket artefacts anywhere in the coercion sites.
        expect(generated, isNot(contains('coerceList< ')));
        expect(generated, isNot(contains('coerceList<>')));
      },
    );

    test(
      'G-DGU4-2: abstract class strips its generative constructor and keeps '
      'the factory + isAbstract flag. [2026-07-21] (PASS)',
      () {
        expect(generated, contains("name: 'Delegate'"));
        expect(
          generated,
          contains('isAbstract: true'),
          reason: 'abstract Delegate must be flagged for the runtime',
        );
        // The factory `Delegate.create` survives; the generative `Delegate()`
        // adapter (keyed '') is stripped so no abstract construction slips in.
        final bridgeMatch = RegExp(
          r'BridgedClass _createDelegateBridge\(\) \{[\s\S]*?'
          r'constructors: \{([\s\S]*?)\},',
        ).firstMatch(generated);
        expect(bridgeMatch, isNotNull, reason: 'Delegate bridge must exist');
        final ctorSection = bridgeMatch!.group(1)!;
        expect(
          ctorSection,
          contains("'create':"),
          reason: 'the factory constructor must be bridged',
        );
        expect(
          ctorSection,
          isNot(contains("'': (visitor")),
          reason: 'the abstract generative constructor must be stripped',
        );
      },
    );

    test(
      'G-DGU4-3: no redundant `?? null` is emitted for optional params. '
      '[2026-07-21] (PASS)',
      () {
        expect(
          generated,
          isNot(contains('?? null')),
          reason: 'optional params must not extract with a trailing ?? null',
        );
      },
    );

    test(
      "G-DGU4-4: a param named `key` extracts as its declared type, not a "
      'force-inferred one. [2026-07-21] (PASS)',
      () {
        // Panel.key is declared `Marker?` — it must extract as Marker?, proving
        // no name-based ("key" => some widget Key) inference is applied.
        expect(
          generated,
          matches(RegExp(r"getOptionalNamedArg<\$?[A-Za-z0-9_.]+\.Marker\?>"
              r"\(named, 'key'\)")),
          reason: 'the key param must keep its declared Marker? type',
        );
        expect(
          generated,
          isNot(contains("<Key?>(named, 'key')")),
          reason: 'no aggressive Key inference for a param named key',
        );
      },
    );
  });
}
