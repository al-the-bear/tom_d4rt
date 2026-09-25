/// Where a structural guard's subject is, and a loud failure when it is not
/// there.
///
/// SCE191, the copy of `tom_d4rt/test/sibling_trees.dart` for `tom_d4rt_ast` — see
/// that file for SCD158's full reasoning. A test here that reads a SIBLING
/// package builds its paths relative to the package it runs in, so a copy of it
/// in another package does not error: it resolves the same relative paths from
/// somewhere else and measures a different tree, and an emptiness check over
/// the wrong tree passes. [requirePackage], the first statement of every such
/// test's `main()`, turns that into an abort at load time;
/// `sce191_structural_guard_anchoring_test.dart` is what makes every such test
/// call it.
///
/// A COPY PER PACKAGE, deliberately. A cross-package relative import is a
/// compile-time dependency on a sibling checkout (SCD153 ruled it out for the
/// same reason), and a test-only package to share thirty lines would be far
/// more machinery than the copies. The only census of which files are
/// single-copy lives in `tom_d4rt_exec`, which has a porting corpus to keep
/// one of; nothing ports into this package, so only the abort transfers.
library;

import 'dart:io';

/// The `name:` of the package the suite is running in, or null when there is no
/// readable pubspec beside the working directory.
String? currentPackage() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) return null;
  for (final line in pubspec.readAsLinesSync()) {
    if (line.startsWith('name:')) {
      return line.substring('name:'.length).trim();
    }
  }
  return null;
}

/// Aborts unless the suite is running inside the package named [expected].
///
/// Throws rather than skipping, deliberately. A skip is what a test does when
/// its PRECONDITIONS are absent and the question is still meaningful elsewhere;
/// here the question has silently become a different question, and a quiet skip
/// in a ported copy would leave the census believing the file was covered.
void requirePackage(String expected, {String? subject}) {
  final actual = currentPackage();
  if (actual == expected) return;
  throw StateError(
    'This guard resolves its subject RELATIVE to the package it runs in, and '
    'it is running in ${actual ?? '<no pubspec beside the working directory>'} '
    'rather than $expected.\n'
    '${subject == null ? '' : 'Its subject is $subject.\n'}'
    'Paths like `lib/src/stdlib` therefore point somewhere this guard was '
    'never written about — it would walk an unrelated file set and report on '
    'it, which for an emptiness check means passing over nothing.\n'
    'If this is a port: it should not exist. A structurally single-copy file '
    'belongs in one package alone; see SCD158 and SCE191.',
  );
}
