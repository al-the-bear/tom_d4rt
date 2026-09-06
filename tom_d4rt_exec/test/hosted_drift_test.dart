/// Tests for `tool/hosted_drift.dart` — the hosted-vs-worktree drift reporter.
///
/// The tool answers one question that nothing else in this repo can: for a given
/// consumer, which files of its *published* interpreter differ from the working
/// tree beside it. Getting that answer wrong is worse than not having it, so the
/// cases below concentrate on the ways a report can be confidently false rather
/// than on the happy path.
///
/// The load-bearing one is F-SCC66-8. A tool that walks a directory and finds
/// nothing has two possible meanings — "everything matches" and "I looked in the
/// wrong place" — and the second is the one that will actually happen, because
/// the hosted path is composed from a version string parsed out of a gitignored
/// file. So an empty hosted `lib/` is a hard error, and this case pins that it
/// stays one.
///
/// Pure file I/O: no interpreter, no network, no pub cache. The one case that
/// does touch the real repo (F-SCC66-11) asserts only that the derivation still
/// lands on real directories, because the numbers it would otherwise assert
/// change with every publish.
library;

import 'dart:io';

import 'package:test/test.dart';

import '../tool/hosted_drift.dart';

void main() {
  group('parseLockfile', () {
    test('F-SCC66-1: reads name, version, source, sha256 and url '
        '[2026-09-06]', () {
      final packages = parseLockfile(_lockfileSample);

      final ast = packages['tom_d4rt_ast']!;
      expect(ast.name, equals('tom_d4rt_ast'));
      expect(ast.version, equals('0.42.0'));
      expect(ast.source, equals('hosted'));
      expect(ast.dependency, equals('direct main'));
      expect(ast.url, equals('https://pub.dev'));
      // Quoted in the sample, as pub writes it whenever the hash starts with a
      // digit. An unstripped quote would compose a cache path that cannot exist,
      // and the tool would then report the whole package as unpublished.
      expect(
        ast.sha256,
        equals(
          '499dbe4137f97999e0fe5dfba94740bce175bc3d0d26161fa82fb984d9528484',
        ),
      );
    });

    test('F-SCC66-2: keeps non-hosted sources distinguishable '
        '[2026-09-06]', () {
      final packages = parseLockfile(_lockfileSample);
      expect(packages['some_path_dep']!.source, equals('path'));
      // A path dependency already *is* the working tree, so it can never drift.
      // The tool filters on this field; if the parse lost it, every path dep
      // would be compared against a hosted archive that does not exist and the
      // survey would die on a package that is by definition in sync.
      expect(packages['tom_d4rt']!.source, equals('hosted'));
    });

    test('F-SCC66-3: ignores everything outside the packages map '
        '[2026-09-06]', () {
      final packages = parseLockfile(_lockfileSample);
      // `sdks:` is a sibling top-level map with the same two-space shape as a
      // package entry. Without the section guard, `dart` becomes a "package"
      // with no version and the survey looks for a nonexistent archive.
      expect(packages.keys, isNot(contains('dart')));
      expect(packages.keys, isNot(contains('flutter')));
    });
  });

  group('cache-path derivation', () {
    test('F-SCC66-4: PUB_CACHE wins over the HOME default '
        '[2026-09-06]', () {
      expect(
        defaultPubCacheRoot({'PUB_CACHE': '/custom/cache', 'HOME': '/home/x'}),
        equals('/custom/cache'),
      );
      expect(
        defaultPubCacheRoot({'HOME': '/home/x'}),
        equals('/home/x/.pub-cache'),
      );
      // An empty value is a shell artefact (`PUB_CACHE=` in an env file), not a
      // request to resolve the cache at the filesystem root.
      expect(
        defaultPubCacheRoot({'PUB_CACHE': '', 'HOME': '/home/x'}),
        equals('/home/x/.pub-cache'),
      );
    });

    test('F-SCC66-5: the hosted directory is keyed by repository authority '
        '[2026-09-06]', () {
      final pubDev = _hosted(url: 'https://pub.dev');
      expect(pubDev.hostedHost, equals('pub.dev'));
      expect(
        hostedPackageDir('/cache', pubDev),
        equals('/cache/hosted/pub.dev/tom_d4rt_ast-0.42.0'),
      );

      // A private pub server on a non-default port lands in its own subtree, so
      // its packages must not be looked up under pub.dev's.
      expect(
        _hosted(url: 'https://pub.example.com:8080').hostedHost,
        equals('pub.example.com%588080'),
      );
    });
  });

  group('compareLibTrees', () {
    late Directory sandbox;

    setUp(() {
      // Workspace rule: temporary files go to a ztmp folder, never the system
      // temp directory.
      sandbox = Directory(
        'ztmp/hosted_drift_test_${DateTime.now().microsecondsSinceEpoch}',
      )..createSync(recursive: true);
    });

    tearDown(() {
      if (sandbox.existsSync()) sandbox.deleteSync(recursive: true);
    });

    test('F-SCC66-6: classifies identical, differing and one-sided files '
        '[2026-09-06]', () {
      _write('${sandbox.path}/hosted/lib/src/a.dart', 'same\n');
      _write('${sandbox.path}/tree/lib/src/a.dart', 'same\n');
      _write('${sandbox.path}/hosted/lib/src/b.dart', 'old\n');
      _write('${sandbox.path}/tree/lib/src/b.dart', 'new\n');
      _write('${sandbox.path}/tree/lib/src/stdlib/c.dart', 'unreleased\n');
      _write('${sandbox.path}/hosted/lib/src/gone.dart', 'deleted since\n');

      final drift = _compare(sandbox);
      final byPath = {for (final e in drift.entries) e.path: e.drift};

      expect(byPath['src/a.dart'], equals(FileDrift.identical));
      expect(byPath['src/b.dart'], equals(FileDrift.differs));
      expect(byPath['src/stdlib/c.dart'], equals(FileDrift.onlyInTree));
      expect(byPath['src/gone.dart'], equals(FileDrift.onlyInHosted));

      expect(drift.inSync, isFalse);
      expect(drift.stranded.map((e) => e.path), isNot(contains('src/a.dart')));
    });

    test('F-SCC66-7: line endings are normalised before comparison '
        '[2026-09-06]', () {
      // On a Windows checkout the working tree stores CRLF where the published
      // archive has LF. Comparing raw bytes there reports every file as drifted
      // — a result that is wrong in the expensive direction, because it buries
      // the real drift in noise on a third of the fleet.
      _write('${sandbox.path}/hosted/lib/a.dart', 'line one\nline two\n');
      _write('${sandbox.path}/tree/lib/a.dart', 'line one\r\nline two\r\n');

      expect(_compare(sandbox).inSync, isTrue);
    });

    test('F-SCC66-8: an empty hosted lib/ is a hard error, not a clean report '
        '[2026-09-06]', () {
      // THE CASE THIS TOOL EXISTS TO NOT GET WRONG. The hosted path is composed
      // from a version parsed out of a gitignored lockfile, so pointing at a
      // directory that is not there is the expected way to be wrong. Falling
      // back to "no files on the hosted side, so everything is unreleased"
      // produces a report that is alarming, plausible and meaningless.
      Directory('${sandbox.path}/hosted/lib').createSync(recursive: true);
      _write('${sandbox.path}/tree/lib/a.dart', 'x\n');

      expect(
        () => _compare(sandbox),
        throwsA(
          isA<HostedDriftError>().having(
            (e) => e.message,
            'message',
            contains('wrong-directory'),
          ),
        ),
      );
    });

    test('F-SCC66-9: a missing hosted archive names the fix '
        '[2026-09-06]', () {
      _write('${sandbox.path}/tree/lib/a.dart', 'x\n');
      expect(
        () => _compare(sandbox),
        throwsA(
          isA<HostedDriftError>().having(
            (e) => e.message,
            'message',
            contains('dart pub get'),
          ),
        ),
      );
    });

    test('F-SCC66-10: stranded files are grouped by subsystem, largest first '
        '[2026-09-06]', () {
      // The count alone ("36 files differ") does not tell anyone what to do.
      // "the whole of src/stdlib/typed_data is unpublished" does.
      _write('${sandbox.path}/hosted/lib/src/stdlib/a.dart', 'old\n');
      _write('${sandbox.path}/tree/lib/src/stdlib/a.dart', 'new\n');
      _write('${sandbox.path}/hosted/lib/src/stdlib/b.dart', 'old\n');
      _write('${sandbox.path}/tree/lib/src/stdlib/b.dart', 'new\n');
      _write('${sandbox.path}/hosted/lib/src/c.dart', 'old\n');
      _write('${sandbox.path}/tree/lib/src/c.dart', 'new\n');
      _write('${sandbox.path}/hosted/lib/top.dart', 'old\n');
      _write('${sandbox.path}/tree/lib/top.dart', 'new\n');

      // Compared as pairs rather than as `MapEntry`s: MapEntry has no value
      // equality, so `equals([MapEntry(...)])` compares identity and can only
      // ever fail.
      expect(
        _compare(sandbox).strandedSubsystems().map((e) => [e.key, e.value]),
        equals([
          ['src/stdlib', 2],
          ['.', 1],
          ['src', 1],
        ]),
      );
    });
  });

  group('against the real repository', () {
    test('F-SCC66-11: the survey still finds the three known consumers '
        '[2026-09-06]', () {
      // Deliberately asserts membership and nothing numeric. Which files are
      // stranded changes with every publish, so a count here would be a
      // maintenance tax that pins nothing; that the derivation still resolves to
      // real packages is the property that can silently break.
      //
      // A consumer with no lockfile is reported as UNMEASURABLE rather than
      // omitted, so this holds on a fresh checkout of the twins too — which is
      // the whole reason `measured` is a separate flag from `inSync`.
      final repoRoot = Directory.current.parent.path;
      final reports = surveyRepo(
        repoRoot,
        pubCacheRoot: defaultPubCacheRoot(Platform.environment),
      );

      expect(
        reports.map((r) => r.consumer),
        containsAll(<String>[
          'tom_d4rt_exec',
          'tom_d4rt_flutter',
          'tom_d4rt_flutter_ast',
        ]),
      );
    });

    test('F-SCC66-12: the repo root is three segments above the script '
        '[2026-09-06]', () {
      expect(
        repoRootFromScript(
          Uri.file('/w/repo/tom_d4rt_exec/tool/hosted_drift.dart'),
        ),
        equals('/w/repo'),
      );
    });
  });
}

PackageDrift _compare(Directory sandbox) => compareLibTrees(
  name: 'tom_d4rt_ast',
  hostedVersion: '0.42.0',
  treeVersion: '0.52.0',
  hostedDir: '${sandbox.path}/hosted',
  treeDir: '${sandbox.path}/tree',
);

LockedPackage _hosted({required String url}) => LockedPackage(
  name: 'tom_d4rt_ast',
  version: '0.42.0',
  source: 'hosted',
  dependency: 'direct main',
  url: url,
);

void _write(String path, String content) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsStringSync(content);
}

/// A trimmed but structurally faithful `pubspec.lock`, quoting included.
const _lockfileSample = '''
# Generated by pub
# See https://dart.dev/tools/pub/glossary#lockfile
packages:
  some_path_dep:
    dependency: "direct dev"
    description:
      path: "../some_path_dep"
      relative: true
    source: path
    version: "1.0.0"
  tom_d4rt:
    dependency: "direct dev"
    description:
      name: tom_d4rt
      sha256: c4cc2c6b08e7ba82a1b9bd8586ea33a450e0d88f282de28d1f5907403aa1904a
      url: "https://pub.dev"
    source: hosted
    version: "1.53.0"
  tom_d4rt_ast:
    dependency: "direct main"
    description:
      name: tom_d4rt_ast
      sha256: "499dbe4137f97999e0fe5dfba94740bce175bc3d0d26161fa82fb984d9528484"
      url: "https://pub.dev"
    source: hosted
    version: "0.42.0"
sdks:
  dart: ">=3.10.4 <4.0.0"
  flutter: ">=3.27.0"
''';
