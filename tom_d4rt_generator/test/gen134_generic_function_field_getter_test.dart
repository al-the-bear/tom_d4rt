// GEN-134 (d4rt addtestscl1): a getter of a generic class whose type nests a
// class type parameter is read through `dynamic`.
//
// The adapter's target is the class instantiated to bounds
// (`Picker<dynamic>`); reading `onChanged` (`Changed<T?>?`, a function taking
// T) through that static type makes Dart check the field against
// `void Function(dynamic)`, which an instance built with `T = int` fails.
// RadioMenuButton<int>.onChanged in the Flutter twins was the case found.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'support/generated_code.dart';

void main() {
  group('GEN-134: nestsClassTypeParameter', () {
    test('GEN134-1: nested mentions count, the bare parameter does not '
        '[2026-11-18]', () {
      bool nests(String type) =>
          BridgeGenerator.nestsClassTypeParameter(type, const ['T']);
      expect(nests('ValueChanged<T?>?'), isTrue);
      expect(nests('List<T>'), isTrue);
      expect(nests('T Function()'), isTrue);
      expect(nests('Map<String, T>?'), isTrue);
      expect(nests('T'), isFalse);
      expect(nests('T?'), isFalse);
      expect(nests('Type'), isFalse);
      expect(nests('List<Tile>'), isFalse);
      expect(nests('int'), isFalse);
      expect(
        BridgeGenerator.nestsClassTypeParameter('List<T>', const []),
        isFalse,
      );
    });
  });

  group('GEN-134: generated getters', () {
    late String generatedCode;
    late String tempOutputDir;

    setUpAll(() async {
      final fixtures = p.join(Directory.current.path, 'test', 'fixtures');
      tempOutputDir = Directory.systemTemp.createTempSync('gen134_').path;
      final result =
          await BridgeGenerator(
            workspacePath: fixtures,
            skipPrivate: true,
            helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
            sourceImport: 'gen134_generic_field_source.dart',
            packageName: 'test_package',
            verbose: false,
          ).generateBridges(
            sourceFiles: [p.join(fixtures, 'gen134_generic_field_source.dart')],
            outputPath: p.join(tempOutputDir, 'gen134.dart'),
            moduleName: 'gen134',
          );
      expect(result.errors, isEmpty);
      generatedCode = await readGeneratedCode(result.outputFiles.first);
    });

    tearDownAll(() {
      try {
        Directory(tempOutputDir).deleteSync(recursive: true);
      } catch (_) {}
    });

    // The getter adapter's text: from its key to the next key.
    String getter(String name) {
      final start = generatedCode.indexOf("'$name': (visitor, target) =>");
      expect(start, isNot(-1), reason: name);
      final end = generatedCode.indexOf(
        "': (visitor, target) =>",
        start + name.length + 3,
      );
      return generatedCode.substring(
        start,
        end < 0 ? generatedCode.length : end,
      );
    }

    test('GEN134-2: function-typed and generic fields mentioning T read '
        'through dynamic [2026-11-18]', () {
      for (final name in ['onChanged', 'values', 'make']) {
        expect(getter(name), contains('as dynamic).$name'), reason: name);
      }
    });

    test('GEN134-3: a bare T field and a non-generic field read statically '
        '[2026-11-18]', () {
      for (final name in ['value', 'count']) {
        expect(getter(name), isNot(contains('as dynamic)')), reason: name);
      }
    });
  });
}
