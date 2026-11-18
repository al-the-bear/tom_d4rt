// ghissues74 — the resolving check reads each package under its own language
// version (GitHub al-the-bear/tom_d4rt#18, found while measuring ghissues69).
//
// With `explicitSources` and no project the check places every package in a
// virtual workspace. Each package used to get the SDK's language version
// there, so a package written for an older one was refused: intl 0.20.3
// (language 3.9) has `num parse(final String inputText)`, which Dart 3.13
// reports as `extraneous_modifier`. `AstBundler.packageLanguageVersions`
// (`AstResolver.checkModules(languageVersions:)`, `astgen --resolve
// --package-config`) gives each package its own. In a project, an explicit
// source of a package the project places outside its root (the pub cache) is
// moved into the virtual workspace under the project's language version;
// before, the analyzer had no context for it (`Unable to find the context`).

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_ast_generator/src/v2/astgen_executor.dart'
    show readPackageLanguageVersions;
import 'package:tom_ast_generator/tom_ast_generator.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle;

const _resolve = AstBundlerConfig(resolve: true);

const _entry = 'package:gh74/main.dart';

/// A library in the style of intl's `compact_number_format.dart`: a `final`
/// parameter, valid up to language 3.12.
const _oldStyle = '''
num parseIt(final String inputText) => num.parse(inputText);
''';

const _useOldStyle = '''
import 'package:old_style/old_style.dart';

Object main() => parseIt('3');
''';

/// The packages of this package's own `package_config.json`: name ->
/// (lib folder, language version).
Map<String, ({String lib, String? languageVersion})> _ownPackages() {
  final file = File(p.join('.dart_tool', 'package_config.json'));
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  final configDir = Uri.directory(p.absolute('.dart_tool'));
  return {
    for (final entry in (json['packages'] as List).cast<Map<String, dynamic>>())
      entry['name'] as String: (
        lib: p.normalize(
          configDir
              .resolve(
                '${(entry['rootUri'] as String).replaceFirst(RegExp(r'/?$'), '/')}'
                '${entry['packageUri'] ?? 'lib/'}',
              )
              .toFilePath(),
        ),
        languageVersion: entry['languageVersion'] as String?,
      ),
  };
}

/// Every `.dart` file of [packages]' lib folders, as `package:` sources.
Map<String, String> _sourcesOf(
  Map<String, ({String lib, String? languageVersion})> packages,
) => {
  for (final MapEntry(key: name, value: package) in packages.entries)
    for (final file in Directory(package.lib).listSync(recursive: true))
      if (file is File && file.path.endsWith('.dart'))
        'package:$name/${p.split(p.relative(file.path, from: package.lib)).join('/')}':
            file.readAsStringSync(),
};

Matcher _refusedWith(String code) => throwsA(
  isA<AstResolveException>().having(
    (e) => e.report.errors.map((d) => d.code),
    'error codes',
    contains(code),
  ),
);

void main() {
  final resolver = AstResolver();

  Future<AstBundle> bundle(
    String source,
    Map<String, String> sources, {
    Map<String, String> languageVersions = const {},
  }) => AstBundler(
    explicitSources: {_entry: source, ...sources},
    fileAccessValidator: (_) => false,
    config: _resolve,
    resolver: resolver,
    packageLanguageVersions: languageVersions,
  ).createFromSource(source, sourcePath: _entry);

  group('ghissues74: explicitSources with their language versions', () {
    test('GH74-1: a final parameter under the SDK\'s language version is '
        'refused, as before [2026-11-18]', () async {
      await expectLater(
        bundle(_useOldStyle, {'package:old_style/old_style.dart': _oldStyle}),
        _refusedWith('extraneous_modifier'),
      );
    });

    test('GH74-2: with the package\'s language version given it passes; '
        'another package keeps the SDK\'s [2026-11-18]', () async {
      final b = await bundle(
        _useOldStyle,
        {'package:old_style/old_style.dart': _oldStyle},
        languageVersions: {'old_style': '3.9'},
      );
      expect(b.modules.keys, contains('package:old_style/old_style.dart'));
      // The entry's package has no entry: SDK language version, and the
      // modifier is still refused there.
      await expectLater(
        bundle(
          '$_useOldStyle\nnum local(final String s) => 0;\n',
          {'package:old_style/old_style.dart': _oldStyle},
          languageVersions: {'old_style': '3.9'},
        ),
        _refusedWith('extraneous_modifier'),
      );
    });

    test('GH74-3: the intl 0.20.3 closure (intl, clock, meta, path) from '
        'explicitSources passes with the packages\' language versions, and is '
        'refused without them [2026-11-18]', () async {
      final own = _ownPackages();
      final closure = {
        for (final name in ['intl', 'clock', 'meta', 'path']) name: own[name]!,
      };
      expect(
        p.basename(p.dirname(closure['intl']!.lib)),
        'intl-0.20.3',
        reason: 'this package resolves intl 0.20.3',
      );
      final sources = _sourcesOf(closure);
      const program = '''
import 'package:intl/intl.dart';

Object main() => NumberFormat.compact(locale: 'en').parse('1.2K');
''';
      await expectLater(
        bundle(program, sources),
        _refusedWith('extraneous_modifier'),
      );
      final b = await bundle(
        program,
        sources,
        languageVersions: {
          for (final MapEntry(key: name, value: package) in closure.entries)
            name: package.languageVersion!,
        },
      );
      expect(
        b.modules.keys,
        contains('package:intl/src/intl/compact_number_format.dart'),
      );
    }, timeout: const Timeout(Duration(minutes: 5)));
  });

  group('ghissues74: a project with a package outside its root', () {
    late Directory workspace;
    late String projectRoot;

    setUp(() {
      workspace = Directory.systemTemp.createTempSync('gh74_');
      projectRoot = p.join(workspace.path, 'proj');
      final outside = p.join(workspace.path, 'cache', 'old_style-1.0.0');
      File(p.join(outside, 'lib', 'old_style.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync(
          "import 'helper.dart';\n\n$_oldStyle\nnum twice(String s) => "
          'double(parseIt(s));\n',
        );
      File(p.join(outside, 'lib', 'helper.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync('num double(num n) => n * 2;\n');
      File(p.join(outside, 'pubspec.yaml'))
        ..createSync(recursive: true)
        ..writeAsStringSync('name: old_style\nversion: 1.0.0\n');
      File(p.join(projectRoot, 'pubspec.yaml'))
        ..createSync(recursive: true)
        ..writeAsStringSync('name: gh74\nenvironment:\n  sdk: ^3.10.0\n');
      File(p.join(projectRoot, '.dart_tool', 'package_config.json'))
        ..createSync(recursive: true)
        ..writeAsStringSync(
          jsonEncode({
            'configVersion': 2,
            'packages': [
              {
                'name': 'gh74',
                'rootUri': '../',
                'packageUri': 'lib/',
                'languageVersion': '3.10',
              },
              {
                'name': 'old_style',
                'rootUri': Uri.directory(outside).toString(),
                'packageUri': 'lib/',
                'languageVersion': '3.9',
              },
            ],
          }),
        );
    });

    tearDown(() => workspace.deleteSync(recursive: true));

    test('GH74-4: an explicit source of a package outside the root that '
        'differs from its file resolves, under the project\'s language '
        'version, its other files with it [2026-11-18]', () async {
      final report = await resolver.checkModules(
        modules: {
          'package:gh74/main.dart':
              "import 'package:old_style/old_style.dart';\n\n"
              "Object main() => twice('3');\n",
          // Not the file on disk: the overlay path, not the project fast path.
          'package:old_style/old_style.dart':
              "import 'helper.dart';\n\n// edited\n$_oldStyle\n"
              "num twice(String s) => double(parseIt(s));\n",
        },
        projectRoot: projectRoot,
      );
      expect(report.errors, isEmpty);
      expect(report.modulesChecked, 2);
    });

    test('GH74-5: the moved package\'s facts stamp keeps its version '
        '[2026-11-18]', () async {
      final report = await resolver.checkModules(
        modules: {
          'package:gh74/main.dart':
              "import 'package:old_style/old_style.dart';\n\n"
              'Object main() => [Holder()];\n',
          'package:old_style/old_style.dart':
              "import 'helper.dart';\n\n// edited\n$_oldStyle\n"
              "num twice(String s) => double(parseIt(s));\n"
              'class Holder {}\n',
        },
        projectRoot: projectRoot,
        collectFacts: true,
      );
      expect(report.errors, isEmpty);
      // `[Holder()]` records `Holder`, from the moved package: its version
      // is still read from its pubspec where it was.
      expect(report.facts!.stamp.packages, {'old_style': '1.0.0'});
    });
  });

  group('ghissues74: astgen --package-config', () {
    late Directory dir;

    setUp(() => dir = Directory.systemTemp.createTempSync('gh74_config_'));
    tearDown(() => dir.deleteSync(recursive: true));

    test('GH74-6: languageVersion is read per package, rootUri ignored; a '
        'package without one is left out [2026-11-18]', () {
      final file = File(p.join(dir.path, 'package_config.json'))
        ..writeAsStringSync(
          jsonEncode({
            'configVersion': 2,
            'packages': [
              {
                'name': 'intl',
                'rootUri': 'file:///nowhere/intl-0.20.3',
                'languageVersion': '3.9',
              },
              {'name': 'bare', 'rootUri': '../bare'},
            ],
          }),
        );
      expect(readPackageLanguageVersions(file.path), {'intl': '3.9'});
      expect(readPackageLanguageVersions(null), isEmpty);
      expect(
        () => readPackageLanguageVersions(p.join(dir.path, 'missing.json')),
        throwsArgumentError,
      );
    });

    test('GH74-7: checkFiles gives a stub\'s virtual package the language '
        'version given: an extension type stub under 3.2 (before extension '
        'types) breaks its user; without an entry it is the SDK\'s '
        '[2026-11-18]', () async {
      final root = p.join(dir.path, 'proj');
      File(p.join(root, 'pubspec.yaml'))
        ..createSync(recursive: true)
        ..writeAsStringSync('name: gh74files\n');
      File(p.join(root, '.dart_tool', 'package_config.json'))
        ..createSync(recursive: true)
        ..writeAsStringSync(
          jsonEncode({
            'configVersion': 2,
            'packages': [
              {
                'name': 'gh74files',
                'rootUri': '../',
                'packageUri': 'lib/',
                'languageVersion': '3.10',
              },
            ],
          }),
        );
      final main = File(p.join(root, 'bin', 'main.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync(
          "import 'package:ids/ids.dart';\n\nObject main() => Id(3).v;\n",
        );
      Future<ResolveReport> check(Map<String, String> versions) {
        final fresh = AstResolver();
        return fresh
            .checkFiles(
              [main.path],
              projectRoot: root,
              stubs: {'package:ids/ids.dart': 'extension type Id(int v) {}\n'},
              languageVersions: versions,
            )
            .whenComplete(fresh.dispose);
      }

      expect((await check(const {})).errors, isEmpty);
      expect((await check({'ids': '3.2'})).passed, isFalse);
    });
  });
}
