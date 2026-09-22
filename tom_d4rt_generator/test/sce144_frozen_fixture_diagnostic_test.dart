/// SCE144: `D4rtTester`'s broken fixture must say which versions it resolved.
///
/// THE PUBLISHED COPY of a pipeline that exists three times — generate,
/// post-process, `dart compile exe`, return a bool — each driving a fixture
/// package with its own gitignored lock while path-resolving a sibling from the
/// working tree. Each can therefore FREEZE: `example/d4` did, at `tom_d4rt_ast`
/// 0.19.0, whose exports lacked four symbols HEAD referenced. What the reader
/// saw was two `(setUpAll)` failures standing in for 122 withheld tests, with
/// nothing naming the versions — twenty minutes of bisection for one line of
/// data the helper had in reach the whole time.
///
/// THIS COPY IS THE ONE WHOSE ERRORS ACCESSOR ALREADY EXISTED, so the
/// diagnostic belongs INSIDE `lastGenerationErrors` rather than beside it and
/// every caller gets it without changing. F-SCE144-8 is the case that pins that
/// wiring: the other three check the reader, and a reader nobody calls is worth
/// nothing.
///
/// WHY A FIXTURE AND NOT A REAL FREEZE. Reproducing the incident end to end
/// needs a fixture that cannot compile, which costs a `dart compile exe` per
/// run to prove something the compiler is not the authority on. What has to be
/// true is narrower and exactly checkable: given a frozen lock, the diagnostic
/// names the frozen version. So the lock beside this file IS the frozen
/// fixture — hand-written, never resolved, recording the incident's versions.
///
/// F-SCE144-7 is the one that matters most and is the easiest to leave out.
/// This helper runs on a path that has ALREADY failed, so if it can throw it
/// replaces the real diagnosis with its own and the reader is worse off than
/// before the diagnostic existed.
// F-SCE144-8 calls `prepareBridges`, which is one of the calls
// `generation_tag_coverage_test.dart` scans for. It aborts at step zero and
// never reaches the generator, but the scan is textual by design and the tag
// costs nothing — see that file's own note on the limit.
@Tags(['generation'])
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

void main() {
  final fixture = p.join(
    Directory.current.path,
    'test',
    'sce144_frozen_fixture',
  );

  group("SCE144: the failure names the fixture's resolved versions", () {
    test('F-SCE144-5: a frozen lock is reported with its versions and sources '
        '[2026-09-22]', () {
      final summary = D4rtTester.resolvedFixtureVersions(fixture);
      // The incident's own numbers. BOTH halves matter — "hosted 0.19.0 while
      // path-resolving the working tree" is the whole shape of the failure, and
      // a summary naming only one of them would not have ended it.
      expect(summary, contains('tom_d4rt_ast 0.19.0 (hosted)'));
      expect(summary, contains('tom_d4rt_exec 1.25.0 (path)'));
    });

    test('F-SCE144-6 (control): it reports the tom_* packages and not the '
        'whole lock [2026-09-22]', () {
      final summary = D4rtTester.resolvedFixtureVersions(fixture);
      expect(summary, isNot(contains('path 1.9.0')));
    });

    test('F-SCE144-7 (control): a missing lock degrades to a note, it does not '
        'throw [2026-09-22]', () {
      final summary = D4rtTester.resolvedFixtureVersions(
        p.join(fixture, 'no_such_directory'),
      );
      expect(summary, contains('no pubspec.lock'));
    });

    test('F-SCE144-8: prepareBridges puts the line in lastGenerationErrors, '
        'FIRST [2026-09-22]', () async {
      // The wiring, end to end and without a compile. A project path that does
      // not exist fails at step zero — `resolveIfUnresolved` — which is the
      // cheapest of the three failure routes and goes through the same
      // `_withFixtureContext` as the other two.
      //
      // FIRST is asserted, not merely present: a reader scanning a wall of
      // compiler output stops at the top, and the whole point of SCD127's
      // measurement was that the line which ends the investigation has to be
      // where the eye lands.
      final tester = D4rtTester(
        projectPath: p.join(fixture, 'no_such_project'),
      );
      const config = BridgeConfig(name: 'sce144_probe', modules: []);
      final ok = await tester.prepareBridges(config);
      expect(ok, isFalse, reason: 'a missing project cannot prepare bridges');
      expect(tester.lastGenerationErrors, isNotNull);
      expect(
        tester.lastGenerationErrors!.first,
        startsWith('fixture resolved:'),
      );
      expect(
        tester.lastGenerationErrors!.join('\n'),
        contains('dart pub upgrade'),
        reason: 'the remedy travels with the diagnosis',
      );
    });
  });
}
