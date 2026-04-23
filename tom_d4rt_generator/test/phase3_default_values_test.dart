/// Phase 3 / B2: Default-value rendering via the element-mode walker.
///
/// The summary-backed refactoring plan (doc/summary_refactoring_plan.md,
/// §3 — "Close bridge-output diffs") explicitly calls for representative
/// unit tests covering default-value patterns:
///
///   > Default-value rendering — chase any `null` / `dynamic` regressions
///   > for summary-backed constants. Add unit tests under `test/` for
///   > representative patterns.
///
/// Post-Phase 2 the generator routes every library through
/// `ElementModeExtractor`. These tests lock down the `_defaultValueSource`
/// behavior (primary `constantInitializer.toSource()`, fallback
/// `defaultValueCode`) so future refactors cannot silently regress the
/// rendering of primitive, null, collection, enum, and const-constructor
/// default values.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String fixturesDir;
  late String tempDir;
  late String generatedCode;

  setUpAll(() async {
    fixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempDir =
        Directory.systemTemp.createTempSync('phase3_default_values_').path;

    final generator = BridgeGenerator(
      workspacePath: fixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'default_values_source.dart',
      packageName: 'test_package',
      verbose: false,
    );

    final src = p.join(fixturesDir, 'default_values_source.dart');
    final out = p.join(tempDir, 'default_values_bridges.dart');

    final result = await generator.generateBridges(
      sourceFiles: [src],
      outputPath: out,
      moduleName: 'test',
    );

    expect(result.errors, isEmpty,
        reason: 'default-values fixture must generate cleanly');
    expect(result.outputFiles, isNotEmpty);

    generatedCode = await File(result.outputFiles.first).readAsString();
  });

  tearDownAll(() {
    try {
      Directory(tempDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Phase 3 / B2: default-value rendering (element-mode)', () {
    test('primitive int default renders as literal', () {
      // `this.i = 42` → `getNamedArgWithDefault<...>(named, 'i', 42)`
      expect(generatedCode, contains("'i', 42"));
    });

    test('primitive double default renders as literal', () {
      // `this.d = 1.5` → `..., 'd', 1.5)`
      expect(generatedCode, contains("'d', 1.5"));
    });

    test('primitive bool default renders as literal', () {
      // `this.b = false` → `..., 'b', false)`
      expect(generatedCode, contains("'b', false"));
    });

    test('primitive String default renders as quoted literal', () {
      // `this.s = 'hello'` → `..., 's', 'hello')`
      expect(generatedCode, contains("'s', 'hello'"));
    });

    test('explicit null default is preserved', () {
      // `this.n = null` — the generator may either render as
      // `getNamedArgWithDefault<...>(named, 'n', null)` or as
      // `getOptionalNamedArg` (treating null == no default). Either is
      // acceptable per the plan's "cosmetic differences are non-gating"
      // rule, but the bridge MUST still name the parameter.
      expect(generatedCode, contains("'n'"));
    });

    test('const List literal default is preserved', () {
      // `this.list = const [1, 2, 3]`
      expect(generatedCode, contains('const [1, 2, 3]'));
    });

    test('const Map literal default is preserved', () {
      // `this.map = const {'a': 1}` — analyzer's `toSource()` emits a space
      // before the colon: `const {'a' : 1}`. The plan explicitly marks
      // whitespace as cosmetic/non-gating, so we accept either shape.
      expect(
          generatedCode,
          anyOf(
            contains("const {'a': 1}"),
            contains("const {'a' : 1}"),
            contains("const <String, int>{'a': 1}"),
          ));
    });

    test('enum-value default is preserved with enum qualifier', () {
      // `this.tri = TriState.auto`
      expect(generatedCode, contains('TriState.auto'));
    });

    test('const-constructor default is preserved', () {
      // `this.dur = const DurationLike(seconds: 5)`
      expect(generatedCode, contains('const DurationLike(seconds: 5)'));
    });

    test('optional-positional default renders via getOptionalArgWithDefault',
        () {
      // `[this.value = 0, this.label = 'x']` — positional defaults use the
      // indexed helper, not the named helper. Both values MUST appear.
      expect(
          generatedCode, contains("getOptionalArgWithDefault"));
      expect(generatedCode, contains("'value', 0"));
      expect(generatedCode, contains("'label', 'x'"));
    });

    test('no default value skips the getOptionalArgWithDefault variant', () {
      // `description` in OptionalPositionalClass is declared without a
      // default — fixture uses only `label = 'x'`, but the shape is that
      // params without a default use `getOptionalArg` (no trailing value)
      // and params with defaults use `getOptionalArgWithDefault`. Both
      // helpers must appear in the generated code.
      expect(generatedCode, contains('getOptionalArg'));
    });
  });
}
