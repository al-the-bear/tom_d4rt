// The bridge freshness gate, and the scratch overlay it runs inside.
//
// `checkBridgeFreshness` answers one question — do a package's committed
// `*.b.dart` files match what the generator produces now? — without writing to
// the package. Both halves are pinned here: the answer (fresh, stale, not
// committed, timestamp-insensitive) and the side-effect freedom, which every
// gate test asserts by snapshotting the fixture before and after.
//
// Fixtures live under this package's own `.dart_tool/`, which is gitignored and
// per-package, and are deleted afterwards.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/scratch_overlay.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

Directory _fixtureRoot(String tag) => Directory(
  p.join(
    Directory.current.path,
    '.dart_tool',
    'test_fixtures',
    '${tag}_${pid}_${DateTime.now().microsecondsSinceEpoch}',
  ),
)..createSync(recursive: true);

/// Every file and directory under [root] with its content, as one string, so
/// that any write, deletion or new directory changes it. The package's own
/// `.dart_tool/` is left out — the gate's scratch tree lives there — and the
/// test is made RELATIVE to [root] because the fixture itself sits under this
/// package's `.dart_tool/`: filtering absolute paths would drop everything and
/// make every comparison vacuously equal.
String _snapshot(Directory root) {
  final entries =
      root
          .listSync(recursive: true)
          .where(
            (e) => !p
                .split(p.relative(e.path, from: root.path))
                .contains('.dart_tool'),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  return entries
      .map(
        (e) =>
            e is File ? 'F ${e.path}\n${e.readAsStringSync()}' : 'D ${e.path}',
      )
      .join('\n');
}

void main() {
  group('scratch overlay', () {
    late Directory package;
    late String scratch;

    setUp(() {
      package = _fixtureRoot('overlay');
      scratch = p.join(package.path, '.dart_tool', 'scratch');
      Directory(p.join(package.path, 'lib', 'src')).createSync(recursive: true);
      File(
        p.join(package.path, 'lib', 'src', 'x.b.dart'),
      ).writeAsStringSync('committed');
      File(
        p.join(package.path, 'lib', 'source.dart'),
      ).writeAsStringSync('source');
    });

    tearDown(() => package.deleteSync(recursive: true));

    Future<T> overlaid<T>(Future<T> Function() body) => runWithScratchOverlay(
      packageRoot: package.path,
      scratchRoot: scratch,
      body: body,
    );

    test('G-OVL-01: a write to a package .b.dart lands in the scratch tree '
        '[2026-09-11] (PASS)', () async {
      final target = p.join(package.path, 'lib', 'src', 'x.b.dart');
      await overlaid(() => File(target).writeAsString('fresh'));
      expect(File(target).readAsStringSync(), 'committed');
      expect(
        File(p.join(scratch, 'lib', 'src', 'x.b.dart')).readAsStringSync(),
        'fresh',
      );
    });

    test('G-OVL-02: a read sees the committed file until this run writes it, '
        'then the fresh one [2026-09-11] (PASS)', () async {
      final target = p.join(package.path, 'lib', 'src', 'x.b.dart');
      final reads = await overlaid(() async {
        final before = File(target).readAsStringSync();
        await File(target).writeAsString('fresh');
        return [before, File(target).readAsStringSync()];
      });
      expect(reads, ['committed', 'fresh']);
    });

    test('G-OVL-03: a redirected file keeps its package path, so URIs derived '
        'from it match an in-place run [2026-09-11] (PASS)', () async {
      final target = p.join(package.path, 'lib', 'src', 'x.b.dart');
      final path = await overlaid(() async => File(target).path);
      expect(path, target);
    });

    test('G-OVL-04: files that are not .b.dart are neither redirected nor '
        'overlaid [2026-09-11] (PASS)', () async {
      final source = p.join(package.path, 'lib', 'source.dart');
      await overlaid(() => File(source).writeAsString('edited'));
      expect(File(source).readAsStringSync(), 'edited');
      expect(File(p.join(scratch, 'lib', 'source.dart')).existsSync(), isFalse);
    });

    test('G-OVL-05: a mutation that is not a write is refused, not applied to '
        'the package [2026-09-11] (PASS)', () async {
      final target = p.join(package.path, 'lib', 'src', 'x.b.dart');
      await expectLater(
        overlaid(() async => File(target).deleteSync()),
        throwsUnsupportedError,
      );
      expect(File(target).existsSync(), isTrue);
    });

    test('G-OVL-06: a directory the package lacks is created in the scratch '
        'tree [2026-09-11] (PASS)', () async {
      final newDir = p.join(package.path, 'bin', 'nested');
      final target = p.join(newDir, 'runner.b.dart');
      final seen = await overlaid(() async {
        Directory(newDir).createSync(recursive: true);
        await File(target).writeAsString('runner');
        return [Directory(newDir).existsSync(), File(target).existsSync()];
      });
      expect(seen, [true, true]);
      expect(Directory(p.join(package.path, 'bin')).existsSync(), isFalse);
      expect(
        File(p.join(scratch, 'bin', 'nested', 'runner.b.dart')).existsSync(),
        isTrue,
      );
    });

    test(
      'G-OVL-07: listing a package directory still shows its sources after a '
      'write created the scratch counterpart [2026-09-11] (PASS)',
      () async {
        final listed = await overlaid(() async {
          await File(
            p.join(package.path, 'lib', 'src', 'x.b.dart'),
          ).writeAsString('fresh');
          return Directory(
            p.join(package.path, 'lib'),
          ).listSync().map((e) => p.basename(e.path)).toSet();
        });
        expect(listed, containsAll(['source.dart', 'src']));
      },
    );
  });

  group('checkBridgeFreshness', () {
    late Directory package;
    late String bridgePath;

    // One committed, freshly generated fixture per test. Generation is what
    // the gate compares against, so each test starts from the generator's own
    // output and then departs from it in exactly one way.
    setUp(() async {
      package = _fixtureRoot('freshness');
      final root = package.path;
      File(p.join(root, 'pubspec.yaml')).writeAsStringSync(
        'name: zom_fresh\n'
        'environment:\n'
        "  sdk: '>=3.0.0 <4.0.0'\n",
      );
      Directory(p.join(root, '.dart_tool')).createSync();
      File(p.join(root, '.dart_tool', 'package_config.json')).writeAsStringSync(
        '{"configVersion": 2, "packages": [{"name": "zom_fresh", '
        '"rootUri": "../", "packageUri": "lib/", "languageVersion": "3.0"}]}',
      );
      Directory(p.join(root, 'lib', 'src')).createSync(recursive: true);
      File(
        p.join(root, 'lib', 'zom_fresh.dart'),
      ).writeAsStringSync("export 'src/greeter.dart';\n");
      File(p.join(root, 'lib', 'src', 'greeter.dart')).writeAsStringSync(
        'class Greeter {\n'
        '  Greeter(this.name);\n'
        '  final String name;\n'
        "  String greet() => 'Hello, \$name';\n"
        '}\n',
      );
      File(p.join(root, 'buildkit.yaml')).writeAsStringSync(
        'd4rtgen:\n'
        '  name: zom_fresh\n'
        '  modules:\n'
        '    - name: zom_fresh\n'
        '      barrelFiles:\n'
        '        - lib/zom_fresh.dart\n'
        '      outputPath: lib/src/d4rt_bridges/zom_fresh_bridges.b.dart\n'
        '  generateBarrel: true\n'
        '  barrelPath: lib/d4rt_bridges.b.dart\n'
        '  generateTestRunner: true\n'
        '  testRunnerPath: bin/d4rtrun.b.dart\n',
      );
      final generated = await generateBridges(
        configPath: p.join(root, 'buildkit.yaml'),
      );
      expect(generated.errors, isEmpty, reason: 'fixture generation failed');
      bridgePath = p.join(
        root,
        'lib',
        'src',
        'd4rt_bridges',
        'zom_fresh_bridges.b.dart',
      );
      expect(File(bridgePath).existsSync(), isTrue);
    });

    tearDown(() => package.deleteSync(recursive: true));

    Future<BridgeFreshness> check() async {
      final before = _snapshot(package);
      final result = await checkBridgeFreshness(package.path);
      expect(
        _snapshot(package),
        before,
        reason: 'the gate must not write to the package it checks',
      );
      expect(result.errors, isEmpty);
      expect(before, contains('zom_fresh_bridges.b.dart'), reason: 'vacuous');
      return result;
    }

    test('G-FRESH-01: a freshly generated package is fresh, and every output '
        'is checked [2026-09-11] (PASS)', () async {
      final result = await check();
      expect(result.isFresh, isTrue, reason: '${result.stale}');
      expect(
        result.checked,
        containsAll([
          'lib/src/d4rt_bridges/zom_fresh_bridges.b.dart',
          'lib/d4rt_bridges.b.dart',
          'bin/d4rtrun.b.dart',
        ]),
      );
    });

    test('G-FRESH-02: a hand-edited bridge is reported as differing, and only '
        'that file [2026-09-11] (PASS)', () async {
      File(bridgePath).writeAsStringSync(
        '${File(bridgePath).readAsStringSync()}\n// hand edit\n',
      );
      final result = await check();
      expect(result.isFresh, isFalse);
      expect(result.stale.map((s) => (s.path, s.reason)), [
        ('lib/src/d4rt_bridges/zom_fresh_bridges.b.dart', StaleReason.differs),
      ]);
    });

    test('G-FRESH-03: a difference confined to the // Generated: timestamp is '
        'not staleness [2026-09-11] (PASS)', () async {
      final content = File(bridgePath).readAsStringSync();
      expect(content, contains('// Generated:'));
      File(bridgePath).writeAsStringSync(
        content.replaceFirst(
          RegExp(r'// Generated:.*'),
          '// Generated: 1999-01-01T00:00:00.000',
        ),
      );
      expect((await check()).isFresh, isTrue);
    });

    test('G-FRESH-04: an output the package lacks is reported as not '
        'committed, and is not created [2026-09-11] (PASS)', () async {
      Directory(p.join(package.path, 'bin')).deleteSync(recursive: true);
      final result = await check();
      expect(result.stale.map((s) => (s.path, s.reason)), [
        ('bin/d4rtrun.b.dart', StaleReason.notCommitted),
      ]);
      expect(Directory(p.join(package.path, 'bin')).existsSync(), isFalse);
    });

    test('G-FRESH-05: a source change the bridges were not regenerated for is '
        'stale [2026-09-11] (PASS)', () async {
      final greeter = File(p.join(package.path, 'lib', 'src', 'greeter.dart'));
      greeter.writeAsStringSync(
        greeter.readAsStringSync().replaceFirst(
          '}\n',
          "  String farewell() => 'Bye, \$name';\n}\n",
        ),
      );
      final result = await check();
      expect(
        result.stale.map((s) => s.path),
        contains('lib/src/d4rt_bridges/zom_fresh_bridges.b.dart'),
      );
    });
  });

  test('G-FRESH-07: an unresolved package is refused rather than resolved in '
      'place [2026-09-11] (PASS)', () async {
    final package = _fixtureRoot('unresolved');
    addTearDown(() => package.deleteSync(recursive: true));
    File(p.join(package.path, 'pubspec.yaml')).writeAsStringSync(
      'name: zom_unresolved\n'
      'environment:\n'
      "  sdk: '>=3.0.0 <4.0.0'\n",
    );
    File(p.join(package.path, 'buildkit.yaml')).writeAsStringSync(
      'd4rtgen:\n'
      '  name: zom_unresolved\n'
      '  modules:\n'
      '    - name: zom_unresolved\n'
      '      barrelFiles:\n'
      '        - lib/zom_unresolved.dart\n'
      '      outputPath: lib/src/zom_unresolved_bridges.b.dart\n',
    );
    final result = await checkBridgeFreshness(package.path);
    expect(result.isFresh, isFalse);
    expect(result.errors.single, contains('not resolved'));
    expect(File(p.join(package.path, 'pubspec.lock')).existsSync(), isFalse);
    expect(Directory(p.join(package.path, '.dart_tool')).existsSync(), isFalse);
  });

  test('G-FRESH-06: normaliseGeneratedContent drops only the timestamp line '
      '[2026-09-11] (PASS)', () {
    expect(
      normaliseGeneratedContent('a\n// Generated: now\nb\n  // Generated: x'),
      'a\nb',
    );
    expect(
      normaliseGeneratedContent('// Not generated\n'),
      '// Not generated\n',
    );
  });
}
