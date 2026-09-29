// SCF32 — the generator emitted 24 classes on Windows where macOS emits 2015.
//
// Measured on legiondary01 (2026-09-29, tree generator 1.49.0, the AST twin's
// buildkit.yaml, `dart_ui` alone):
//
//   Warning: element-mode walker returned no library for
//     C:\flutter-sdk\flutter\bin\cache\pkg\sky_engine\lib\ui\ui.dart
//
// The element-mode walker resolves a library by its `package:` URI, and the
// URI came from a lookup of `'/lib/'` in the NATIVE path. A Windows path holds
// `\lib\`, so the lookup missed, the walker fell back to resolving the file by
// path — which finds nothing for a library outside the project, i.e. every
// SDK and pub-cache library — and each module came out empty. Only files
// inside the project resolved, which is where the 24 came from.
//
// The same raw lookup was written out six times across the generator. It now
// lives once, in [SourcePackage], which normalises separators first; G-SCF32-4
// keeps a seventh copy from appearing.
//
// Windows paths are produced here by rewriting a real temporary package's
// separators, so the pubspec lookup behind each answer is a real one and the
// test goes red on macOS exactly as the generator did on Windows.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';
import 'package:tom_d4rt_generator/src/relaxer_generator.dart'
    show isSourceInScopeForTesting;
import 'package:tom_d4rt_generator/src/source_package.dart';

/// [path] spelled the way Windows spells it.
String _windows(String path) => path.replaceAll('/', r'\');

void main() {
  late Directory root;
  late String source;

  setUpAll(() {
    root = Directory.systemTemp.createTempSync('scf32_');
    File(
      p.join(root.path, 'pubspec.yaml'),
    ).writeAsStringSync('name: zom_scf32\n');
    final file = File(p.join(root.path, 'lib', 'src', 'widgets.dart'))
      ..createSync(recursive: true)
      ..writeAsStringSync('class ZomWidget {}\n');
    source = file.path;
  });

  tearDownAll(() => root.deleteSync(recursive: true));

  group('SCF32: a followed external re-export keys its file the way every '
      'lookup does', () {
    test('G-SCF32-5: every key parseExportFiles returns is a normalised '
        'native path [2026-09-29] (PASS)', () async {
      // The second Windows defect behind the same measurement. A re-export
      // from ANOTHER package (`export 'package:vector_math/vector_math_64.dart'
      // show Matrix4`) was keyed by string interpolation,
      // `'$packageRoot/lib/$path'` — `C:\...\vector_math-2.2.0/lib/...` on
      // Windows. Class lookups use the analyzer's native path, missed that
      // key, and the `show` filter failed OPEN: every vector_math class and
      // function landed in the painting module there, and vector_math_64's
      // own module came out empty.
      //
      // On macOS a `/` joins as `/`, so the observable form here is a package
      // root pub may legally write with a trailing slash: the interpolated key
      // reads `…/zom_ext//lib/…`, which the lookup's path never does.
      final ws = Directory.systemTemp.createTempSync('scf32_ws_');
      addTearDown(() => ws.deleteSync(recursive: true));
      final ext = Directory(p.join(ws.path, 'zom_ext'))..createSync();
      File(p.join(ext.path, 'lib', 'zom_ext.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync("export 'src/a.dart';\n");
      File(p.join(ext.path, 'lib', 'src', 'a.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync('class A {}\nclass B {}\n');
      final app = Directory(p.join(ws.path, 'app'))..createSync();
      File(p.join(app.path, 'pubspec.yaml')).writeAsStringSync('name: app\n');
      File(p.join(app.path, '.dart_tool', 'package_config.json'))
        ..createSync(recursive: true)
        ..writeAsStringSync('''
{"configVersion": 2, "packages": [
  {"name": "zom_ext", "rootUri": "${ext.uri}", "packageUri": "lib/"}
]}''');
      final barrel = File(p.join(app.path, 'lib', 'app.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync("export 'package:zom_ext/zom_ext.dart' show A;\n");

      final exports = await BridgeGenerator(
        workspacePath: app.path,
        packageName: 'app',
      ).parseExportFiles([barrel.path]);

      final followed = p.normalize(p.join(ext.path, 'lib', 'src', 'a.dart'));
      expect(exports.keys, contains(followed));
      expect(
        exports.keys.where((k) => k != p.normalize(k)),
        isEmpty,
        reason: 'a key no lookup can hit makes its show/hide filter fail open',
      );
      expect(exports[followed]!.showClause, ['A']);
    });
  });

  group('SCF32: a Windows source path finds its package', () {
    test('G-SCF32-1: SourcePackage reads the pubspec behind a backslash path '
        '[2026-09-29] (PASS)', () {
      final package = SourcePackage.of(_windows(source))!;
      expect(package.name, 'zom_scf32');
      expect(package.libRelativePath, 'src/widgets.dart');
      expect(package.packageUri, 'package:zom_scf32/src/widgets.dart');
      expect(package.root.contains(r'\'), isFalse);
    });

    test('G-SCF32-2: the generator\'s library-resolution URI is the package '
        'URI for a backslash path [2026-09-29] (PASS)', () {
      // This is the lookup the element-mode walker makes before falling back
      // to resolving by path — the one that returned null on Windows.
      final generator = BridgeGenerator(workspacePath: root.path);
      expect(
        generator.libraryUriForFilePathForTesting(_windows(source)),
        'package:zom_scf32/src/widgets.dart',
      );
      expect(
        generator.libraryUriForFilePathForTesting(source),
        'package:zom_scf32/src/widgets.dart',
        reason: 'the POSIX spelling must keep working',
      );
    });

    test('G-SCF32-3: a path outside any lib/ has no package, and a lib/ with '
        'no readable pubspec has no name [2026-09-29] (PASS)', () {
      expect(SourcePackage.of(_windows(p.join(root.path, 'x.dart'))), isNull);
      final orphan = SourcePackage.of(r'C:\nowhere\pkg\lib\a.dart')!;
      expect(orphan.name, isNull);
      expect(orphan.packageUri, isNull);
      expect(orphan.root, 'C:/nowhere/pkg');
    });

    test('G-SCF32-4: no source file looks for `/lib/` in a raw path any more '
        '[2026-09-29] (PASS)', () {
      // Six copies of the lookup existed and none normalised first. The
      // helper is the one place allowed to search for `/lib/`, because it
      // searches a normalised path; `_getPackageUri` goes through it too.
      final offenders = <String>[];
      for (final file in Directory('lib').listSync(recursive: true)) {
        if (file is! File || !file.path.endsWith('.dart')) continue;
        if (p.basename(file.path) == 'source_package.dart') continue;
        final lines = file.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          if (lines[i].contains("indexOf('/lib/')")) {
            offenders.add('${file.path}:${i + 1}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'these search a native path for `/lib/`, which a Windows path '
            'never contains — use SourcePackage.of',
      );
    });
  });

  group('SCF32: the relaxer sees Flutter types on a Windows path', () {
    test('G-SCF32-6: the scope check maps a backslash Flutter or sky_engine '
        'path as it maps the slash form [2026-09-29] (PASS)', () {
      // Measured on legiondary01: with every module otherwise fresh, the
      // relaxer was an empty stub ("GEN-095: No relaxers or RC-2 generic
      // constructors reachable via barrels") where macOS emits 182 000 lines,
      // because `ImageProvider` and every other Flutter class was out of
      // scope.
      const prefixes = {'package:flutter/'};
      for (final path in [
        r'C:\flutter-sdk\flutter\packages\flutter\lib\src\painting\image_provider.dart',
        '/srv/flutter/flutter/packages/flutter/lib/src/painting/image_provider.dart',
        r'C:\flutter-sdk\flutter\bin\cache\pkg\sky_engine\lib\ui\ui.dart',
      ]) {
        expect(isSourceInScopeForTesting(path, prefixes), isTrue, reason: path);
      }
      // Control: a package outside every module stays out of scope.
      expect(
        isSourceInScopeForTesting(
          r'C:\cache\hosted\pub.dev\other-1.0.0\lib\other.dart',
          prefixes,
        ),
        isFalse,
      );
    });
  });
}
