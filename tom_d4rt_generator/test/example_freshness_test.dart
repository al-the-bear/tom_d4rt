// The helpers behind a package's example-bridge ratchet: discovery of d4rtgen
// projects, and the verdict for one project's freshness report.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

BridgeFreshness report({
  List<String> checked = const ['lib/a.b.dart'],
  List<StaleBridge> stale = const [],
  List<String> errors = const [],
}) => BridgeFreshness(checked: checked, stale: stale, errors: errors);

const staleBridge = StaleBridge('lib/a.b.dart', StaleReason.differs);

void main() {
  group('freshnessRatchetViolation', () {
    test('G-RATCHET-01: an unlisted fresh project passes '
        '[2026-09-11] (PASS)', () {
      expect(
        freshnessRatchetViolation('x', report(), knownStale: false),
        isNull,
      );
    });

    test('G-RATCHET-02: an unlisted stale project fails, naming the file '
        '[2026-09-11] (PASS)', () {
      expect(
        freshnessRatchetViolation(
          'x',
          report(stale: [staleBridge]),
          knownStale: false,
        ),
        contains('lib/a.b.dart'),
      );
    });

    test('G-RATCHET-03: a listed stale project passes [2026-09-11] (PASS)', () {
      expect(
        freshnessRatchetViolation(
          'x',
          report(stale: [staleBridge]),
          knownStale: true,
        ),
        isNull,
      );
    });

    test('G-RATCHET-04: a listed project that became fresh fails until its '
        'entry is deleted [2026-09-11] (PASS)', () {
      expect(
        freshnessRatchetViolation('x', report(), knownStale: true),
        contains('delete it from the known-stale list'),
      );
    });

    test('G-RATCHET-05: generation errors fail even for a listed project '
        '[2026-09-11] (PASS)', () {
      expect(
        freshnessRatchetViolation(
          'x',
          report(errors: ['boom']),
          knownStale: true,
        ),
        contains('boom'),
      );
    });

    test('G-RATCHET-06: a run that checked nothing fails '
        '[2026-09-11] (PASS)', () {
      expect(
        freshnessRatchetViolation('x', report(checked: []), knownStale: true),
        contains('nothing was compared'),
      );
    });
  });

  group('findD4rtgenProjects', () {
    late Directory root;

    setUp(() {
      root = Directory(
        p.join(
          Directory.current.path,
          '.dart_tool',
          'test_fixtures',
          'discovery_${pid}_${DateTime.now().microsecondsSinceEpoch}',
        ),
      )..createSync(recursive: true);
      void config(String dir, String content) {
        Directory(p.join(root.path, dir)).createSync(recursive: true);
        File(
          p.join(root.path, dir, 'buildkit.yaml'),
        ).writeAsStringSync(content);
      }

      config('plain', 'd4rtgen:\n  name: plain\n');
      config('outer/nested', 'versioner: {}\nd4rtgen:\n  name: nested\n');
      config('no_generator', 'versioner: {}\n');
      config('plain/.dart_tool/copy', 'd4rtgen:\n  name: copy\n');
      config('plain/build/copy', 'd4rtgen:\n  name: copy\n');
    });

    tearDown(() => root.deleteSync(recursive: true));

    test('G-RATCHET-07: finds d4rtgen projects at any depth, relative and '
        'sorted, skipping .dart_tool and build trees [2026-09-11] (PASS)', () {
      expect(findD4rtgenProjects(root.path), ['outer/nested', 'plain']);
    });

    test(
      'G-RATCHET-08: a missing root has no projects [2026-09-11] (PASS)',
      () {
        expect(findD4rtgenProjects(p.join(root.path, 'absent')), isEmpty);
      },
    );
  });

  test('G-RATCHET-09: resolveIfUnresolved leaves a resolved package alone '
      '[2026-09-11] (PASS)', () async {
    // This package is resolved — the test is running in it.
    expect(await resolveIfUnresolved(Directory.current.path), isNull);
  });
}
