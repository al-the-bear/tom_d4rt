/// Where a structural guard's subject is, and a loud failure when it is not
/// there.
///
/// SCD158. A guard that asserts something about the interpreter SOURCE — that
/// every error-handler adapter routes through one helper, that the two stdlib
/// trees declare the same sites, that no bridge hand-rolls a wrapper trio —
/// builds its paths relative to the package it is running in. `lib/src/stdlib`
/// means `tom_d4rt`'s stdlib when the suite runs in `tom_d4rt`, and it means
/// something else entirely anywhere else.
///
/// COPIED INTO `tom_d4rt_exec/test`, the identical code resolves `lib/src` to
/// EXEC's `lib`, which holds a parsing front end and no stdlib adapters at all.
/// The guard does not error. It walks an unrelated file set and evaluates
/// against it. SCC22's three cases happened to fail that way, which is how the
/// category was noticed — but the failure was luck: a guard shaped as "no file
/// under this root does X" passes VACUOUSLY over an empty set, and a green
/// vacuous guard is indistinguishable from a green real one.
///
/// So the subject is made explicit instead of positional. [requirePackage] is
/// the first line of every such guard's `main()`, and it turns "silently
/// measuring the wrong tree" into "this guard's subject is not here", at the
/// moment the wrong copy first runs rather than whenever somebody next reads
/// the results.
///
/// IT IS NOT A SUBSTITUTE FOR THE CENSUS, and the two are wired together.
/// `conformance_drift_test.dart` DERIVES the set of structurally single-copy
/// files — those whose source names a sibling tree — and
/// `scd158_structural_guard_anchoring_test.dart` asserts every file in that
/// derived set calls this function. Neither the category nor the discipline is
/// a list anybody maintains.
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
    'belongs in the reference tree alone; see SCD158 and '
    '`conformance_drift_test.dart`\'s derived single-copy set.',
  );
}
