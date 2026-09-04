// SCC26 — the two mirrored trees must keep formatting to the same style.
//
// THE DEFECT SHAPE
//
// `dart format` does not have one output. It has two, and it picks between them
// from the *language version* of the file it is formatting: below 3.7 the old
// style, from 3.7 the tall style (one argument per line, trailing commas,
// block-like indentation). The language version is not read from the file — it
// comes from the enclosing package's `environment.sdk` floor, by way of
// `.dart_tool/package_config.json`.
//
// So two packages holding the *same source* format it differently if their
// floors straddle 3.7. That is not a cosmetic problem here, because
// `tom_d4rt/lib/src/…` and `tom_d4rt_ast/lib/src/runtime/…` are deliberate
// mirrors: the workspace rule is that an interpreter fix must land in both, and
// the only practical way to check that it did is to diff the two files. Once
// the styles diverge, that diff is thousands of lines of re-wrapping with the
// semantic hunks buried inside it, and the check stops being performed.
//
// It was not hypothetical. `stdlib/io/socket.dart` sat at 1926 divergent lines
// across the mirror while its two copies were, token for token, the same file —
// one had been formatted at 3.10, the other at 3.5. Across the mirrored stdlib
// the figure was 5012 divergent lines, of which roughly 87% was pure layout.
//
// WHY A TEST AND NOT A NOTE IN THE GUIDELINES
//
// The prohibition ("never run `dart format` on a mirrored file") had already
// been written down once, informally, after SCB9 hit this. It did not hold —
// SCB9's own revert missed socket.dart, and the damage sat in the tree
// undetected until it was measured. An advisory rule that must be remembered by
// every future editor of 119 mirrored files, at the moment they reach for a
// reflex command, is not a control. Aligning the floors removes the failure
// mode structurally: once both packages format identically, running the
// formatter is idempotent and harmless, which is the state this file pins.
//
// WHAT IS ASSERTED
//
// F-SCC26-1  every package in the mirror declares a floor at or above 3.7, so
//            the formatter cannot choose different styles for them
// F-SCC26-2  this package's own tree is formatted, so the next `dart format`
//            is a no-op rather than a re-wrap
// F-SCC26-3  the sibling `tom_d4rt` tree is formatted too — the half of the
//            mirror this package cannot otherwise speak for
//
// F-SCC26-3 needs the sibling checkout, which exists in the workspace but not
// in a consumer's pub cache. It skips when the sibling is absent rather than
// failing, because a published copy of this package genuinely cannot answer the
// question and a red test there would be noise, not a finding.

import 'dart:io';

import 'package:test/test.dart';

/// Lowest language version that produces the tall formatter style.
const _tallStyleFloor = (major: 3, minor: 7);

/// Packages whose sources are mirrors of one another, relative to the repo root.
const _mirroredPackages = ['tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_exec'];

/// The d4rt repo root, found by walking up from the current directory.
///
/// Tests run with the package directory as cwd, but that is a guarantee of the
/// runner rather than of the layout, so this looks for a directory that holds
/// all the mirrored packages instead of counting `..` segments.
Directory? _repoRoot() {
  var dir = Directory.current.absolute;
  for (var i = 0; i < 6; i++) {
    final hasAll = _mirroredPackages.every(
      (p) => Directory('${dir.path}/$p').existsSync(),
    );
    if (hasAll) return dir;
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

/// The `environment.sdk` lower bound declared by [pubspec], as (major, minor).
///
/// Deliberately a regex rather than a YAML parse: this package has no YAML
/// dependency and must not gain one — it is the zero-dependency half of the
/// split, which is the whole reason a Flutter app can use it.
({int major, int minor})? _declaredSdkFloor(File pubspec) {
  final match = RegExp(
    r'^\s*sdk:\s*[">=^\s]*(\d+)\.(\d+)',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  if (match == null) return null;
  return (major: int.parse(match.group(1)!), minor: int.parse(match.group(2)!));
}

/// Paths under [package] that `dart format` should find nothing to do in.
List<String> _formattedRoots(Directory package) => [
  'lib',
  'test',
].where((d) => Directory('${package.path}/$d').existsSync()).toList();

/// Runs the formatter in check mode and returns the files it would rewrite.
List<String> _unformattedFiles(Directory package) {
  final roots = _formattedRoots(package);
  if (roots.isEmpty) return const [];
  final result = Process.runSync('dart', [
    'format',
    '--output=none',
    '--set-exit-if-changed',
    ...roots,
  ], workingDirectory: package.path);
  if (result.exitCode == 0) return const [];
  return (result.stdout as String)
      .split('\n')
      .where((l) => l.startsWith('Changed '))
      .map((l) => l.substring('Changed '.length))
      .toList();
}

void main() {
  final root = _repoRoot();

  group('SCC26: the mirrored trees format to one style', () {
    test('F-SCC26-1: every mirrored package declares a floor at or above 3.7 '
        '[2026-09-04]', () {
      expect(root, isNotNull, reason: 'd4rt repo root not found from cwd');

      for (final name in _mirroredPackages) {
        final floor = _declaredSdkFloor(
          File('${root!.path}/$name/pubspec.yaml'),
        );
        expect(floor, isNotNull, reason: '$name declares no sdk constraint');
        final isTall =
            floor!.major > _tallStyleFloor.major ||
            (floor.major == _tallStyleFloor.major &&
                floor.minor >= _tallStyleFloor.minor);
        expect(
          isTall,
          isTrue,
          reason:
              '$name declares sdk ${floor.major}.${floor.minor}, below the '
              '3.7 tall-style boundary. `dart format` will produce a '
              'different layout here than in its mirror twin, and the diff '
              'that checks the mirror stops being readable.',
        );
      }
    });

    test('F-SCC26-2: this package is formatted [2026-09-04]', () {
      final changed = _unformattedFiles(Directory.current);
      expect(
        changed,
        isEmpty,
        reason:
            'these files are not formatted, so the next `dart format` will '
            'rewrite them and bury whatever real edit lands alongside it',
      );
    });

    test('F-SCC26-3: the sibling tom_d4rt tree is formatted [2026-09-04]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not found — sibling not reachable');
        return;
      }
      final sibling = Directory('${root.path}/tom_d4rt');
      if (!sibling.existsSync()) {
        markTestSkipped('tom_d4rt not checked out beside this package');
        return;
      }
      expect(_unformattedFiles(sibling), isEmpty);
    });
  });
}
