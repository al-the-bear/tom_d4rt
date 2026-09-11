// Whether a project still resolves: the read-only config check, discovery,
// and the resolve-and-verify step the example tests and D4rtTester run first.
//
// Fixtures live under this package's `.dart_tool/`, gitignored, and are deleted
// afterwards. Every fixture package has no hosted dependencies, so `dart pub
// get` resolves it without the network.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';

Directory _fixtureRoot(String tag) => Directory(
  p.join(
    Directory.current.path,
    '.dart_tool',
    'test_fixtures',
    '${tag}_${pid}_${DateTime.now().microsecondsSinceEpoch}',
  ),
)..createSync(recursive: true);

/// A package named [name] in [dir], with an optional hand-written package
/// config listing [packages] as `name -> rootUri`.
void _package(
  Directory dir, {
  String name = 'zom_resolve',
  String dependencies = '',
  Map<String, String>? packages,
}) {
  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: $name\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n"
    '$dependencies',
  );
  if (packages == null) return;
  Directory(p.join(dir.path, '.dart_tool')).createSync();
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    jsonEncode({
      'configVersion': 2,
      'packages': [
        for (final entry in packages.entries)
          {'name': entry.key, 'rootUri': entry.value, 'packageUri': 'lib/'},
      ],
    }),
  );
}

void main() {
  late Directory root;

  setUp(() => root = _fixtureRoot('resolution'));
  tearDown(() => root.deleteSync(recursive: true));

  group('resolutionProblems', () {
    test('G-RESOLVE-01: a project never resolved here is reported '
        '[2026-09-11] (PASS)', () {
      _package(root);
      expect(
        resolutionProblems(root.path).single,
        contains('no .dart_tool/package_config.json'),
      );
    });

    test('G-RESOLVE-02: a config whose every package is present has no '
        'problems [2026-09-11] (PASS)', () {
      _package(root, packages: {'zom_resolve': '../'});
      expect(resolutionProblems(root.path), isEmpty);
    });

    test('G-RESOLVE-03: a package directory that no longer exists is '
        'reported by name — the shape a recreated pub cache leaves '
        '[2026-09-11] (PASS)', () {
      final gone = p.join(root.path, 'gone', 'lints-5.1.1');
      _package(
        root,
        packages: {
          'zom_resolve': '../',
          'lints': Uri.directory(gone).toString(),
        },
      );
      final problems = resolutionProblems(root.path);
      expect(problems.single, startsWith('lints: '));
      expect(problems.single, contains('no longer exists'));
    });

    test('G-RESOLVE-04: a directory without a pubspec.yaml is reported with '
        'the remedy pub get cannot apply [2026-09-11] (PASS)', () {
      final hollow = Directory(p.join(root.path, 'hollow'))..createSync();
      File(p.join(hollow.path, 'README.md')).writeAsStringSync('left over');
      _package(
        root,
        packages: {
          'zom_resolve': '../',
          'hollow': Uri.directory(hollow.path).toString(),
        },
      );
      expect(
        resolutionProblems(root.path).single,
        allOf(contains('hollow'), contains('delete that directory')),
      );
    });

    test('G-RESOLVE-05: an unreadable config is reported, not thrown '
        '[2026-09-11] (PASS)', () {
      _package(root, packages: {});
      File(
        p.join(root.path, '.dart_tool', 'package_config.json'),
      ).writeAsStringSync('{not json');
      expect(resolutionProblems(root.path).single, contains('not valid JSON'));
    });
  });

  test('G-RESOLVE-06: findDartProjects finds pubspec projects at any depth, '
      'skipping .dart_tool and build trees [2026-09-11] (PASS)', () {
    for (final dir in ['a', 'outer/b', 'a/.dart_tool/c', 'a/build/d']) {
      final d = Directory(p.join(root.path, dir))..createSync(recursive: true);
      _package(d);
    }
    expect(findDartProjects(root.path), ['a', 'outer/b']);
  });

  group('resolveIfUnresolved', () {
    test('G-RESOLVE-07: a project whose config names a vanished package is '
        'resolved again and comes back clean [2026-09-11] (PASS)', () async {
      _package(
        root,
        packages: {
          'zom_resolve': '../',
          'ghost': Uri.directory(p.join(root.path, 'ghost')).toString(),
        },
      );
      expect(resolutionProblems(root.path), isNotEmpty);
      expect(await resolveIfUnresolved(root.path), isNull);
      expect(resolutionProblems(root.path), isEmpty);
    });

    test('G-RESOLVE-08: a project that cannot resolve returns pub\'s own '
        'message, not a downstream symptom [2026-09-11] (PASS)', () async {
      _package(
        root,
        dependencies:
            'dependencies:\n'
            '  zom_missing:\n'
            '    path: ../does_not_exist\n',
        packages: {'zom_resolve': '../'},
      );
      final failure = await resolveIfUnresolved(root.path);
      expect(failure, isNotNull);
      expect(failure, contains('`dart pub get` failed'));
      expect(failure, contains('zom_missing'));
    });

    test('G-RESOLVE-09: a current resolution is left untouched '
        '[2026-09-11] (PASS)', () async {
      _package(root);
      expect(await resolveIfUnresolved(root.path), isNull);
      final config = File(
        p.join(root.path, '.dart_tool', 'package_config.json'),
      );
      final stamp = config.lastModifiedSync();
      final lock = File(p.join(root.path, 'pubspec.lock')).lastModifiedSync();
      // Past the filesystem's timestamp resolution, so a rewrite would show.
      await Future<void>.delayed(const Duration(milliseconds: 1100));
      expect(await resolveIfUnresolved(root.path), isNull);
      expect(config.lastModifiedSync(), stamp);
      expect(File(p.join(root.path, 'pubspec.lock')).lastModifiedSync(), lock);
    });
  });
}
