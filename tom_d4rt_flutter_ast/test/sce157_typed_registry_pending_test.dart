// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — both twins' scd133 reach the registry
// through `dynamic`, and that stops being allowed at a known version.
//
// Its subject reaches OUTSIDE this package (the sibling twin's scd133 and its
// pubspec), so it runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made
// that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE157 — the deferral in `scd133_registry_enum_resolution_test.dart` has an
// expiry, and this is it.
//
// Both twins' scd133 look up a registered enum as `final dynamic bridgedEnum =
// env.get(name)`. The reason is recorded there: `tom_d4rt/d4rt.dart` gained its
// `BridgedEnum` export in 1.109.0, both twins resolve their interpreter from
// pub.dev (DGUC6), and `tom_d4rt_flutter` still declares `^1.77.0`. The AST twin
// COULD name the type today — `tom_d4rt_ast` has exported it since 0.65.0 — and
// deliberately does not, because the pair's whole value is that the two files
// differ only in how the throwaway script reaches the interpreter. Typing one
// alone would spend that for nothing.
//
// WHY THIS IS A TEST AND NOT A NOTE. The condition that releases the deferral is
// a version floor moving in a file nobody edits for this reason — it moves
// because some other change needed a newer interpreter. A note in scd133 is read
// by whoever opens scd133; the floor is raised by whoever is doing something
// else entirely. So the obligation is attached to the floor rather than to the
// file it will change, and it arrives as a red test in the same commit that
// makes it actionable.
//
// The trigger is the DECLARED constraint in the tracked pubspec, not the
// resolved version in `pubspec.lock`. Both twins gitignore their locks, so a
// lock-based trigger would fire on one machine and not the next; the declared
// floor is the same for everyone and is exactly what step one of the tightening
// raises.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The release of `tom_d4rt` whose barrel first exported `BridgedEnum`.
const _exportedFrom = (major: 1, minor: 109, patch: 0);

/// The lookup both twins must stop using once the floor allows the type.
const _dynamicHop = 'final dynamic bridgedEnum = env.get(name);';

const _astScd133 = 'test/scd133_registry_enum_resolution_test.dart';
const _sourceScd133 =
    '../tom_d4rt_flutter/test/scd133_registry_enum_resolution_test.dart';
const _sourcePubspec = '../tom_d4rt_flutter/pubspec.yaml';

/// The `tom_d4rt:` floor `tom_d4rt_flutter` declares, as (major, minor, patch).
///
/// Accepts the caret and range forms pub allows; the LOWER bound is what
/// decides whether the type is nameable, because that is the oldest release
/// the package promises to work with.
({int major, int minor, int patch}) _declaredFloor() {
  final file = File(_sourcePubspec);
  expect(
    file.existsSync(),
    isTrue,
    reason:
        'the sibling twin is not where this guard expects it ($_sourcePubspec). '
        'Without it the version comparison below silently has no subject',
  );

  for (final line in file.readAsLinesSync()) {
    final match = RegExp(
      r'''^\s*tom_d4rt:\s*["']?[\^>=]*\s*(\d+)\.(\d+)\.(\d+)''',
    ).firstMatch(line);
    if (match != null) {
      return (
        major: int.parse(match.group(1)!),
        minor: int.parse(match.group(2)!),
        patch: int.parse(match.group(3)!),
      );
    }
  }
  fail(
    'no `tom_d4rt:` constraint with a parseable lower bound in $_sourcePubspec. '
    'If the dependency moved or the syntax changed, this guard cannot decide '
    'anything and must be repaired rather than left green',
  );
}

bool _atLeastExportRelease(({int major, int minor, int patch}) floor) {
  if (floor.major != _exportedFrom.major) {
    return floor.major > _exportedFrom.major;
  }
  if (floor.minor != _exportedFrom.minor) {
    return floor.minor > _exportedFrom.minor;
  }
  return floor.patch >= _exportedFrom.patch;
}

void main() {
  late ({int major, int minor, int patch}) floor;
  late String astSource;
  late String sourceSource;

  setUpAll(() {
    floor = _declaredFloor();
    astSource = File(_astScd133).readAsStringSync();
    sourceSource = File(_sourceScd133).readAsStringSync();
  });

  group('SCE157: the scd133 `dynamic` deferral expires with the floor', () {
    test('F-SCE157-1: below the export release both twins still defer; at or '
        'above it, neither may', () {
      final floorText = '${floor.major}.${floor.minor}.${floor.patch}';
      final deferring = <String>[
        if (astSource.contains(_dynamicHop)) 'tom_d4rt_flutter_ast',
        if (sourceSource.contains(_dynamicHop)) 'tom_d4rt_flutter',
      ];

      if (!_atLeastExportRelease(floor)) {
        expect(
          deferring,
          hasLength(2),
          reason:
              'tom_d4rt_flutter still declares a floor of $floorText, below the '
              '1.109.0 that exports `BridgedEnum`, so NEITHER twin can name the '
              'type — and the pair must stay in lockstep, because a file that '
              'differs from its twin for a reason unrelated to what it asserts '
              'is the cost this deferral exists to avoid. Currently deferring: '
              '${deferring.isEmpty ? '<neither>' : deferring.join(' and ')}',
        );
        return;
      }

      expect(
        deferring,
        isEmpty,
        reason:
            'tom_d4rt_flutter now declares a floor of $floorText, at or past '
            'the 1.109.0 that exports `BridgedEnum`. The deferral recorded in '
            'scd133 is over: replace `$_dynamicHop` with a typed lookup in '
            'BOTH twins, drop the paragraph in `_collectEnums` that points '
            'here, and delete this file. Still deferring: '
            '${deferring.join(' and ')}',
      );
    });

    test(
      'F-SCE157-2 (control): the floor was parsed and both files were read',
      () {
        expect(
          floor.major,
          greaterThan(0),
          reason: 'a zero floor means the regex matched something unintended',
        );
        for (final (label, source) in <(String, String)>[
          (_astScd133, astSource),
          (_sourceScd133, sourceSource),
        ]) {
          expect(
            source,
            contains('F-SCD133-3'),
            reason:
                '$label does not look like scd133, so F-SCE157-1 above is '
                'asking its question of the wrong file',
          );
        }
        expect(
          _atLeastExportRelease((major: 1, minor: 109, patch: 0)),
          isTrue,
          reason:
              'the version comparison must accept the export release itself',
        );
        expect(
          _atLeastExportRelease((major: 1, minor: 108, patch: 99)),
          isFalse,
          reason:
              'and must reject the release before it, patch notwithstanding',
        );
        expect(
          _atLeastExportRelease((major: 2, minor: 0, patch: 0)),
          isTrue,
          reason: 'a later major is past it',
        );
      },
    );
  });
}
