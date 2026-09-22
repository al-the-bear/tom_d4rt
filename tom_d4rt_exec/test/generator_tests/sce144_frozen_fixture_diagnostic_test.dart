/// SCE144: `ExecTestSetup`'s broken fixture must say which versions it resolved.
///
/// THE SAME DEFECT SCD127 FIXED IN THE SIBLING COPY, in the copy that was left.
/// There are three implementations of one `prepareBridges` pipeline — generate,
/// post-process, `dart compile exe`, return a bool — and each drives a fixture
/// package with its own gitignored lock while path-resolving a sibling from the
/// working tree. Each can therefore FREEZE: `example/d4` did, at `tom_d4rt_ast`
/// 0.19.0, whose exports lacked four symbols HEAD referenced.
///
/// What the reader saw was
///
///     418 passing, 2 failing — d4rt_coverage_test.dart (setUpAll),
///                              d4rt_tester_test.dart (setUpAll)
///
/// with the two failures standing in for 122 withheld tests, and nothing in the
/// output naming the versions. Twenty minutes of bisection for one line of data
/// the helper had in reach the whole time.
///
/// WHY A FIXTURE AND NOT A REAL FREEZE. Reproducing the incident end to end
/// needs a fixture that cannot compile, which costs a `dart compile exe` per
/// run to prove something the compiler is not the authority on. What has to be
/// true is narrower and exactly checkable: given a frozen lock, the diagnostic
/// names the frozen version. So the lock beside this file IS the frozen
/// fixture — hand-written, never resolved, recording the incident's versions.
///
/// F-SCE144-4 is the one that matters most and is the easiest to leave out.
/// This helper runs on a path that has ALREADY failed, so if it can throw it
/// replaces the real diagnosis with its own and the reader is worse off than
/// before the diagnostic existed.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'exec_test_setup.dart';

void main() {
  final fixture = p.join(
    Directory.current.path,
    'test',
    'generator_tests',
    'sce144_frozen_fixture',
  );

  group("SCE144: the failure names the fixture's resolved versions", () {
    test('F-SCE144-2: a frozen lock is reported with its versions and sources '
        '[2026-09-22]', () {
      final summary = ExecTestSetup.resolvedInterpreterVersions(fixture);
      // The incident's own numbers: the frozen hosted interpreter, and the
      // path-resolved package it was frozen against. BOTH halves matter —
      // "hosted 0.19.0 while path-resolving the working tree" is the whole
      // shape of the failure, and a summary naming only one of them would not
      // have ended the investigation.
      expect(summary, contains('tom_d4rt_ast 0.19.0 (hosted)'));
      expect(summary, contains('tom_d4rt_exec 1.25.0 (path)'));
    });

    test('F-SCE144-3 (control): it reports the tom_* packages and not the '
        'whole lock [2026-09-22]', () {
      // A summary printing every package would be a wall of text on a failure
      // path and the reader would skim it — the same defect as printing
      // nothing, reached from the other side. The fixture lock carries `path`
      // precisely so this case has something to exclude.
      final summary = ExecTestSetup.resolvedInterpreterVersions(fixture);
      expect(summary, isNot(contains('path 1.9.0')));
    });

    test('F-SCE144-4 (control): a missing lock degrades to a note, it does not '
        'throw [2026-09-22]', () {
      final summary = ExecTestSetup.resolvedInterpreterVersions(
        p.join(fixture, 'no_such_directory'),
      );
      expect(summary, contains('no pubspec.lock'));
    });
  });
}
