// sce41: the d4 runner is compiled once per `dart test` invocation, and a
// stale binary can never be reused.
//
// `d4rt_tester_test.dart` and `d4rt_coverage_test.dart` prepare the SAME
// `example/d4` project, so the package's two heaviest CPU consumers were doing
// the same generation and the same `dart compile exe` twice — roughly a minute
// of the suite's two. They keep DISTINCT binary names on purpose (Cluster M
// #34): compiling to a shared name races against a peer suite executing it,
// and the symptom is ETXTBSY. So the COMPILE is shared and the binary is not:
// one compilation, copied to each suite's own name.
//
// WHAT IS TESTED HERE, AND WHY IT IS THE KEY RATHER THAN THE BINARY. Reuse is
// gated on a content key over the runner source and every generated bridge
// file; the shared binary is rebuilt whenever that key changes. Asserting on
// the shared binary itself would mean asserting on state that another suite in
// the same run is entitled to rebuild at any moment — a guard that fails when
// the machine is busy, which is the exact failure mode sce40 had just finished
// removing from these suites. The key is deterministic, so it is what gets
// pinned; that the compile is skipped when the key matches is one `if` in
// `_ensureSuiteBinary`, directly above it.
//
// It carries `@Tags(['generation'])` even though it runs nothing of the sort —
// it builds plain files in a temp directory and finishes in milliseconds. The
// tag is required because G-GENTAG-1 scans for the TEXT `D4rtTester(`, which
// this file names when it constructs one. That scan is deliberately textual
// and conservative: a spurious tag costs a longer timeout budget and nothing
// else, whereas a missed one reintroduces the flake scd9 removed. Conforming
// is cheaper than carving out an exception that would weaken the rule.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

void main() {
  late Directory tmp;
  late D4rtTester tester;

  setUp(() {
    tmp = Directory.systemTemp.createTempSync('sce41_');
    tester = D4rtTester(projectPath: tmp.path);
  });

  tearDown(() {
    try {
      tmp.deleteSync(recursive: true);
    } catch (_) {}
  });

  /// Writes [name] with [content] and returns its absolute path.
  String write(String name, String content) {
    final file = File(p.join(tmp.path, name))
      ..createSync(recursive: true)
      ..writeAsStringSync(content);
    return file.path;
  }

  String keyOf(String runner, List<String> generated) =>
      tester.artifactKeyForTesting(runner, generated);

  group('SCE41: the shared runner is keyed by its inputs', () {
    test('G-SCE41-1: identical inputs give the same key, so the compile is '
        'skipped [2026-09-18] (PASS)', () {
      final runner = write('bin/runner.dart', 'void main() {}\n');
      final bridge = write('lib/a.b.dart', 'class A {}\n');

      expect(keyOf(runner, [bridge]), keyOf(runner, [bridge]));
    });

    test('G-SCE41-2: a changed bridge file changes the key, so a stale binary '
        'is not reused [2026-09-18] (PASS)', () {
      final runner = write('bin/runner.dart', 'void main() {}\n');
      final bridge = write('lib/a.b.dart', 'class A {}\n');
      final before = keyOf(runner, [bridge]);

      write('lib/a.b.dart', 'class A { int x = 1; }\n');

      expect(
        keyOf(runner, [bridge]),
        isNot(before),
        reason:
            'this is the whole guarantee: regenerate, and the binary '
            'built from the old bridges is no longer a candidate',
      );
    });

    test(
      'G-SCE41-3: a changed runner source changes the key [2026-09-18] (PASS)',
      () {
        final runner = write('bin/runner.dart', 'void main() {}\n');
        final bridge = write('lib/a.b.dart', 'class A {}\n');
        final before = keyOf(runner, [bridge]);

        write('bin/runner.dart', 'void main() { print("x"); }\n');

        expect(keyOf(runner, [bridge]), isNot(before));
      },
    );

    test('G-SCE41-4: the `// Generated:` line does NOT change the key '
        '[2026-09-18] (PASS)', () {
      // Anti-vacuity for the cache itself. That line carries a timestamp and
      // is rewritten on every generation, so counting it would make the key
      // differ every time and the artifact would be rebuilt twice exactly as
      // before — the tests above would still pass while the todo's purpose
      // was quietly defeated.
      final runner = write('bin/runner.dart', 'void main() {}\n');
      final bridge = write(
        'lib/a.b.dart',
        '// Generated: 2026-09-18T10:00:00 by tom_d4rt_generator 1.32.0\n'
            'class A {}\n',
      );
      final before = keyOf(runner, [bridge]);

      write(
        'lib/a.b.dart',
        '// Generated: 2026-09-18T23:59:59 by tom_d4rt_generator 1.33.0\n'
            'class A {}\n',
      );

      expect(keyOf(runner, [bridge]), before);
    });

    test('G-SCE41-5: a missing generated file is distinguishable from an empty '
        'one [2026-09-18] (PASS)', () {
      final runner = write('bin/runner.dart', 'void main() {}\n');
      final absent = p.join(tmp.path, 'lib', 'gone.b.dart');
      final keyAbsent = keyOf(runner, [absent]);

      write('lib/gone.b.dart', '');

      expect(
        keyOf(runner, [absent]),
        isNot(keyAbsent),
        reason:
            'a generator that stopped emitting a file has changed its '
            'output, and the binary must be rebuilt',
      );
    });

    test('G-SCE41-6: the set of generated files is part of the key '
        '[2026-09-18] (PASS)', () {
      final runner = write('bin/runner.dart', 'void main() {}\n');
      final a = write('lib/a.b.dart', 'class A {}\n');
      final b = write('lib/b.b.dart', 'class B {}\n');

      expect(
        keyOf(runner, [a]),
        isNot(keyOf(runner, [a, b])),
        reason: 'a newly emitted bridge changes what the binary contains',
      );
    });

    test('G-SCE41-7: file identity is part of the key, not just content '
        '[2026-09-18] (PASS)', () {
      // Two files with identical bodies under different names are different
      // generator output; hashing only the concatenated contents would make
      // a rename invisible.
      final runner = write('bin/runner.dart', 'void main() {}\n');
      final a = write('lib/a.b.dart', 'class Same {}\n');
      final renamed = write('lib/renamed.b.dart', 'class Same {}\n');

      expect(keyOf(runner, [a]), isNot(keyOf(runner, [renamed])));
    });
  });
}
