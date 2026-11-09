// GitHub al-the-bear/tom_d4rt#5 — a bridge imports another package's `src`
// libraries through that package's public libraries.
//
// tom_d4rt_flutter 1.2.0 stopped compiling on Flutter 3.47.1: its generated
// bridges imported `package:flutter/src/widgets/visibility.dart`, which Flutter
// had removed. The generator imported every type from the library that
// DECLARES it, so every file Flutter moved broke every published bridge set.
// A public library that binds every name of a `src` library to the same
// declaration can stand in for it under the same prefix; measured 2026-11-09
// on tom_d4rt_flutter_ast: 1 110 of the 1 113 `src` imports move, every other
// line of the 18 bridge files is unchanged, and the one `src` library left
// (`widgets/_html_element_view_io.dart`) is exported by no public library.
//
// GH5-1..5 pin the choice; GH5-6 generates bridges for a package whose public
// library exports one `src` library whole, hides a name of another and leaves
// a third unexported.

@Tags(['generation'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/public_import_targets.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group(
    'GH5: choosing the public library a src library is imported through',
    () {
      const src = 'package:p/src/a.dart';

      test('GH5-1: a public library binding every name to the same declaration '
          'stands in [2026-11-09]', () {
        expect(
          choosePublicImportTargets(
            publicNamespaces: {
              'package:p/p.dart': {
                'A': src,
                'B': src,
                'Other': 'package:q/q.dart',
              },
            },
            srcNamespaces: {
              src: {'A': src, 'B': src},
            },
          ),
          {src: 'package:p/p.dart'},
        );
      });

      test('GH5-2: the narrowest covering library is taken, ties by URI '
          '[2026-11-09]', () {
        final targets = choosePublicImportTargets(
          publicNamespaces: {
            'package:p/material.dart': {'A': src, 'M': 'package:p/src/m.dart'},
            'package:p/widgets.dart': {'A': src},
            'package:p/also.dart': {'A': src},
          },
          srcNamespaces: {
            src: {'A': src},
          },
        );
        expect(targets, {src: 'package:p/also.dart'});
      });

      test('GH5-3: a hidden name keeps the src import [2026-11-09]', () {
        expect(
          choosePublicImportTargets(
            publicNamespaces: {
              'package:p/p.dart': {'A': src},
            },
            srcNamespaces: {
              src: {'A': src, 'Hidden': src},
            },
          ),
          isEmpty,
        );
      });

      test('GH5-4: a name bound to another declaration keeps the src import '
          '[2026-11-09]', () {
        expect(
          choosePublicImportTargets(
            publicNamespaces: {
              'package:p/p.dart': {'A': src, 'B': 'package:p/src/other.dart'},
            },
            srcNamespaces: {
              src: {'A': src, 'B': src},
            },
          ),
          isEmpty,
        );
      });

      test('GH5-5: a src library with an empty namespace keeps its import '
          '[2026-11-09]', () {
        expect(
          choosePublicImportTargets(
            publicNamespaces: {
              'package:p/p.dart': {'A': src},
            },
            srcNamespaces: {src: {}},
          ),
          isEmpty,
        );
      });
    },
  );

  group('GH5: generated bridges', () {
    late Directory root;
    late String generated;

    setUpAll(() async {
      root = Directory.systemTemp.createTempSync('gh5_public_imports_');
      final lib = _writePackage(root, 'zom_gh5_lib', {
        'zom_gh5_lib.dart':
            "export 'src/whole.dart';\n"
            "export 'src/partial.dart' hide Hidden;\n",
        'src/whole.dart':
            "import 'unexported.dart';\n"
            '\n'
            'class Whole {\n'
            '  Whole(this.count);\n'
            '  final int count;\n'
            '  Unexported make() => Unexported();\n'
            '}\n',
        'src/partial.dart':
            'class Partial {\n'
            '  String name() => "partial";\n'
            '}\n'
            '\n'
            'class Hidden {}\n',
        'src/unexported.dart': 'class Unexported {}\n',
      });
      final consumer = _writePackage(
        root,
        'zom_gh5_consumer',
        {'zom_gh5_consumer.dart': ''},
        dependencies: [lib],
      );
      // The library package resolves itself too: its files are analysed in
      // their own context.
      _writePackageConfig(lib, [lib]);

      final generator = BridgeGenerator(
        workspacePath: consumer.path,
        packageName: 'zom_gh5_consumer',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      );
      final out = p.join(root.path, 'out', 'gh5_bridges.b.dart');
      final result = await generator.generateBridges(
        sourceFiles: [
          p.join(lib.path, 'lib', 'src', 'whole.dart'),
          p.join(lib.path, 'lib', 'src', 'partial.dart'),
        ],
        outputPath: out,
        moduleName: 'gh5',
      );
      expect(result.errors, isEmpty);
      generated = File(out).readAsStringSync();
    });

    tearDownAll(() {
      try {
        root.deleteSync(recursive: true);
      } catch (_) {}
    });

    Map<String, String> importsByUri() => {
      for (final m in RegExp(
        r"^import '([^']+)' as (\S+);",
        multiLine: true,
      ).allMatches(generated))
        m.group(1)!: m.group(2)!,
    };

    test('GH5-6: an exported src library is imported through the public '
        'library, the others keep their src imports, and the references '
        'keep their prefixes [2026-11-09]', () {
      final imports = importsByUri();
      expect(imports, contains('package:zom_gh5_lib/zom_gh5_lib.dart'));
      expect(imports, isNot(contains('package:zom_gh5_lib/src/whole.dart')));
      // `Hidden` is hidden by the public library, so `partial.dart` stays.
      expect(imports, contains('package:zom_gh5_lib/src/partial.dart'));
      // Exported by no public library: only reachable through src.
      expect(imports, contains('package:zom_gh5_lib/src/unexported.dart'));
      final publicPrefix = imports['package:zom_gh5_lib/zom_gh5_lib.dart']!;
      expect(generated, contains('$publicPrefix.Whole'));
      final partialPrefix = imports['package:zom_gh5_lib/src/partial.dart']!;
      expect(generated, contains('$partialPrefix.Partial'));
    });
  });
}

/// Writes package [name] under [root] with [files] in its `lib/`, and a
/// package config naming itself and [dependencies].
Directory _writePackage(
  Directory root,
  String name,
  Map<String, String> files, {
  List<Directory> dependencies = const [],
}) {
  final dir = Directory(p.join(root.path, name))..createSync(recursive: true);
  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: $name\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );
  for (final entry in files.entries) {
    File(p.join(dir.path, 'lib', entry.key))
      ..createSync(recursive: true)
      ..writeAsStringSync(entry.value);
  }
  _writePackageConfig(dir, [dir, ...dependencies]);
  return dir;
}

void _writePackageConfig(Directory dir, List<Directory> packages) {
  Directory(p.join(dir.path, '.dart_tool')).createSync(recursive: true);
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    jsonEncode({
      'configVersion': 2,
      'packages': [
        for (final pkg in packages)
          {
            'name': p.basename(pkg.path),
            'rootUri': Uri.directory(pkg.path).toString(),
            'packageUri': 'lib/',
            'languageVersion': '3.0',
          },
      ],
    }),
  );
}
