// REPO-WIDE GUARD (tom_d4rt_ast) — every mirrored pair in the repo declares the same SDK floor.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt_ast's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE222 — the two halves of a mirrored pair declare the same SDK floor.
//
// The pair is the unit that matters: a guard such as
// `scc73_sdk_member_completeness_test` skips SDK members `@Since` a version
// above the READING package's floor, and the stdlib member audit leaves out
// members newer than `auditSdkFloor` (DART313B1). So the lower floor of a pair
// silently caps what the pair may bridge. That held `tom_d4rt_ast` back from
// `Future.syncValue` for months (scd186).
//
// WHAT IS ASSERTED
//
// F-SCC26-4  every mirrored PAIR declares the same SDK floor
// F-SCC26-5  no recorded floor straddle outlives its cause
//
// The ids are kept from the file these two came from
// (`scc26_format_alignment_test.dart`), whose formatting checks were removed by
// the user's decision on sdkfmt1: formatting is not guarded. A file is
// formatted when it is first committed, with the formatter current then, and
// later edits follow its existing layout.

import 'dart:io';

import 'package:test/test.dart';

/// Mirrored PAIRS, which must declare the same SDK floor (SCE222).
///
/// Includes the companion apps and the demo apps, which are twins of the same
/// kind: each pair runs the same scripts on the two interpreter lines.
const _mirroredPairs = <(String, String)>[
  ('tom_d4rt', 'tom_d4rt_ast'),
  ('tom_d4rt', 'tom_d4rt_exec'),
  ('tom_d4rt_dcli', 'tom_dcli_exec'),
  ('tom_d4rt_flutter', 'tom_d4rt_flutter_ast'),
  (
    'tom_d4rt_flutter/test/tom_d4rt_flutter_test_app',
    'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app',
  ),
  ('tom_d4rt_flutter_test', 'tom_d4rt_flutter_ast_test'),
];

/// Pairs allowed to declare different floors, with the reason. EMPTY: every
/// straddle found by SCE222 was resolved by raising the lower side. An entry
/// here is a permission, and F-SCC26-5 fails once its cause is gone.
const _floorStraddles = <(String, String), String>{};

/// The d4rt repo root, found by walking up from the current directory to the
/// first directory that holds every package the pairs name.
Directory? _repoRoot() {
  final packages = {
    for (final pair in _mirroredPairs) ...[pair.$1, pair.$2],
  };
  var dir = Directory.current.absolute;
  for (var i = 0; i < 6; i++) {
    final hasAll = packages.every(
      (p) => Directory('${dir.path}/$p').existsSync(),
    );
    if (hasAll) return dir;
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

/// The full `major.minor.patch` of the SDK floor [pubspec] declares, or null.
///
/// A regex rather than a YAML parse: this package has no YAML dependency and
/// must not gain one — it is the zero-dependency half of the split.
String? _declaredSdkVersion(File pubspec) {
  final match = RegExp(
    r'^\s*sdk:\s*[">=^\s]*(\d+\.\d+\.\d+)',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  return match?.group(1);
}

void main() {
  final root = _repoRoot();

  group('SCE222: mirrored pairs declare the same SDK floor', () {
    test('F-SCC26-4: every mirrored pair declares the same SDK floor '
        '[2026-09-29]', () {
      expect(root, isNotNull, reason: 'd4rt repo root not found from cwd');
      // Anti-vacuity first: this is an equality assertion over a derived set,
      // so a pair list that resolved to nothing would pass it perfectly.
      final floors = <(String, String), (String?, String?)>{
        for (final pair in _mirroredPairs)
          pair: (
            _declaredSdkVersion(File('${root!.path}/${pair.$1}/pubspec.yaml')),
            _declaredSdkVersion(File('${root.path}/${pair.$2}/pubspec.yaml')),
          ),
      };
      final read = floors.values.where((f) => f.$1 != null && f.$2 != null);
      expect(
        read.length,
        _mirroredPairs.length,
        reason: 'a pubspec of a mirrored pair declares no readable sdk floor',
      );
      expect(_mirroredPairs.length, 6, reason: 'the pair census moved');

      final straddles = [
        for (final e in floors.entries)
          if (e.value.$1 != e.value.$2 && !_floorStraddles.containsKey(e.key))
            '${e.key.$1} ^${e.value.$1}  vs  ${e.key.$2} ^${e.value.$2}',
      ];
      expect(
        straddles,
        isEmpty,
        reason:
            'These mirrored pairs declare different SDK floors. The lower one '
            'caps the pair: a member gated @Since above it is skipped for BOTH '
            'trees (scd186 lost Future.syncValue this way). Raise the lower '
            'floor, or record the pair in _floorStraddles with the reason it '
            'cannot be raised.',
      );
    });

    test('F-SCC26-5: no floor straddle permission outlives its cause '
        '[2026-09-29]', () {
      final stale = [
        for (final pair in _floorStraddles.keys)
          if (_declaredSdkVersion(
                File('${root!.path}/${pair.$1}/pubspec.yaml'),
              ) ==
              _declaredSdkVersion(File('${root.path}/${pair.$2}/pubspec.yaml')))
            '${pair.$1} / ${pair.$2}',
      ];
      expect(stale, isEmpty, reason: 'these pairs agree now; delete the entry');
    });
  });
}
