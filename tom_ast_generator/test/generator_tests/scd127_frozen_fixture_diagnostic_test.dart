/// SCD127: a broken fixture must say which versions it resolved.
///
/// WHAT WENT WRONG. `example/d4` is its own package with its own gitignored
/// lock, frozen at `tom_d4rt_ast` 0.19.0 while it path-resolves
/// `tom_d4rt_exec` from the working tree. HEAD's `ModuleLoader` referenced four
/// symbols 0.19.0 does not export, `dart compile exe` failed,
/// `AstgenTestSetup.prepareBridges` returned false, and the suite reported
///
///     418 passing, 2 failing — d4rt_coverage_test.dart (setUpAll),
///                              d4rt_tester_test.dart (setUpAll)
///
/// THE TWO FAILURES WERE STANDING IN FOR 122 TESTS, and nothing in the output
/// said so. The diagnosis took twenty minutes of bisection to reach one line of
/// data — the fixture's resolved versions — which `prepareBridges` had in reach
/// the whole time and never put in the message the caller asserts on.
///
/// WHY A FIXTURE AND NOT A REAL FREEZE. Reproducing the incident end to end
/// means a fixture that cannot compile, which costs a `dart compile exe` per
/// run to prove something the compiler is not the authority on. What has to be
/// true is narrower and exactly checkable: given a frozen lock, the diagnostic
/// names the frozen version. So the lock beside this file IS the frozen
/// fixture — hand-written, never resolved, recording the versions of the
/// 2026-09-05 incident.
///
/// F-SCD127-5 is the one that matters most and is easy to leave out. This
/// helper runs on a path that has ALREADY failed, so if it can throw it
/// replaces the real diagnosis with its own, and the reader is worse off than
/// before the diagnostic existed.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'astgen_test_setup.dart';

void main() {
  final fixture = p.join(
    Directory.current.path,
    'test',
    'generator_tests',
    'scd127_frozen_fixture',
  );

  group('SCD127: the failure names the fixture\'s resolved versions', () {
    test('F-SCD127-3: a frozen lock is reported with its versions and sources '
        '[2026-09-15]', () {
      final summary = AstgenTestSetup.resolvedInterpreterVersions(fixture);
      // The incident's own numbers: the frozen hosted interpreter, and the
      // path-resolved package it was frozen against. Both halves matter —
      // "hosted 0.19.0 while path-resolving the working tree" is the whole
      // shape of the failure, and a summary naming only one of them would not
      // have ended the investigation.
      expect(summary, contains('tom_d4rt_ast 0.19.0 (hosted)'));
      expect(summary, contains('tom_d4rt_exec 1.25.0 (path)'));
    });

    test('F-SCD127-4 (control): it reports the tom_* packages and not the '
        'whole lock [2026-09-15]', () {
      // A summary that printed every package would be a wall of text on a
      // failure path, and the reader would skim it — which is the same defect
      // as printing nothing, arrived at from the other side. The fixture lock
      // carries `path` precisely so this case has something to exclude.
      final summary = AstgenTestSetup.resolvedInterpreterVersions(fixture);
      expect(summary, isNot(contains('path 1.9.0')));
    });

    test('F-SCD127-5 (control): a missing lock degrades to a note, it does '
        'not throw [2026-09-15]', () {
      // This helper only ever runs after something else has already failed. A
      // throw here would replace the real diagnosis with an exception from the
      // diagnostic, which is strictly worse than the silence it replaced.
      final summary = AstgenTestSetup.resolvedInterpreterVersions(
        p.join(fixture, 'no_such_directory'),
      );
      expect(summary, contains('no pubspec.lock'));
    });
  });
}
