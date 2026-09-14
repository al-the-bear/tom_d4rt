// REPO-WIDE GUARD (tom_d4rt_ast) — every mirrored package in the repo is dart-format clean.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt_ast's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
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
const _mirroredPackages = [
  'tom_d4rt',
  'tom_d4rt_ast',
  'tom_d4rt_exec',
  // SCD82 — the rest of the repo. `tom_d4rt_dcli` and `tom_dcli_exec` are twins
  // in the sense this suite cares about (the same REPL on the two interpreter
  // lines, kept in step by diffing); the other three are not mirrored, so for
  // them the guard is hygiene rather than a correctness aid. All five declare an
  // SDK floor of ^3.10.4, well above the tall-style boundary F-SCC26-1 checks.
  'tom_ast_generator',
  'tom_ast_model',
  'tom_d4rt_dcli',
  'tom_d4rt_generator',
  'tom_dcli_exec',
  // SCD81 — the Flutter twins are the same kind of pair one layer up: 18
  // generated bridge files each plus the shared `d4rt_user_bridges/` set that
  // `tom_d4rt_flutter_ast/tool/sync_shared_user_bridges.dart` derives by
  // rewriting one import line. That tool compares TEXT and a mirror diff is how
  // anyone checks it did the right thing, so the same layout noise defeats the
  // same check.
  'tom_d4rt_flutter',
  'tom_d4rt_flutter_ast',
];

/// File names that are GENERATOR OUTPUT and are therefore excluded everywhere.
///
/// SCD82 — `version.versioner.dart` is what `buildkit :versioner` writes and what
/// a tool prints as its `--version` banner. It is emitted unformatted, so
/// including it would start the same fight the bridges would: format, regenerate
/// at the next version bump, and the diff is back. Measured, not assumed: after
/// regenerating the four stamps this pass had to refresh, `dart format` found
/// exactly those four files and nothing else.
///
/// Fixing it belongs in the versioner, which lives outside this repo, so unlike
/// the bridges (sce123_aimn) it is not this quest's to close — sce124_aimn
/// records it.
const _generatedFileNames = {'version.versioner.dart'};

/// The packages whose formatted surface is `lib/` MINUS the generator's output.
///
/// SCD81 checked the thing that could have invalidated the whole approach, and
/// it did invalidate half of it: `tom_d4rt_generator` emits `*.b.dart` by string
/// concatenation and depends on no formatter at all, so `dart format` rewrites
/// all 18 in each twin. Formatting them would start a permanent fight — format,
/// regenerate, and the diff is back — which is why the generated files are
/// excluded here rather than reformatted. Teaching the generator to format its
/// own output is sce123_aimn, and it has to come with a workspace-wide
/// regeneration because every consumer's freshness guard reads committed output.
///
/// `test/` is excluded for these two as well, and for a different reason: the
/// ~2080-script cluster corpus under `test/tom_d4rt_flutter_ast_app/test/` is
/// D4rt FIXTURES driven over HTTP against a live companion app, not code.
/// Reformatting them changes what the corpus feeds the interpreter.
const _generatedOutputPackages = {'tom_d4rt_flutter', 'tom_d4rt_flutter_ast'};

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
///
/// Two shapes, because the two kinds of package have different surfaces. For the
/// interpreter trees it is whole directories, which is what makes the check
/// total. For the Flutter twins it is an explicit FILE list, derived rather than
/// recorded: every `.dart` under `lib` that is not `*.b.dart`. A recorded list
/// would go stale the first time somebody adds a file and would then pass by
/// omission — which is the failure mode this whole suite exists to prevent.
List<String> _formatTargets(Directory package) {
  final name = package.path.split(Platform.pathSeparator).last;

  // Whole directories where that is possible, because a directory check cannot
  // pass by omission. SCD82 widened the set from `lib test` to include `bin` and
  // `tool`, which had left a measured hole: four packages passed this guard while
  // nine files under those two still rewrote wholesale on the first format.
  const roots = ['lib', 'test', 'bin', 'tool'];
  final excluded = _generatedFiles(package);
  if (!_generatedOutputPackages.contains(name) && excluded.isEmpty) {
    return roots
        .where((d) => Directory('${package.path}/$d').existsSync())
        .toList();
  }

  // Enumerated only where an exclusion is needed, because `dart format` takes
  // paths and has no exclude flag. Both exclusions are name-based and re-derived
  // on every run, so a file added to the package is covered automatically.
  final prefix = '${package.path}${Platform.pathSeparator}';
  final targets = <String>[];
  for (final dir in roots) {
    final root = Directory('${package.path}/$dir');
    if (!root.existsSync()) continue;
    // The Flutter twins' `test/` is the ~2080-script cluster corpus: D4rt
    // fixtures driven over HTTP, not code. Reformatting them changes what the
    // corpus feeds the interpreter.
    if (_generatedOutputPackages.contains(name) && dir != 'lib') continue;
    for (final file in root.listSync(recursive: true).whereType<File>()) {
      final path = file.path;
      if (!path.endsWith('.dart')) continue;
      if (excluded.contains(path)) continue;
      targets.add(
        path.startsWith(prefix) ? path.substring(prefix.length) : path,
      );
    }
  }
  return targets..sort();
}

/// Every generated file under [package]: the bridges and the version stamp.
List<String> _generatedFiles(Directory package) {
  final out = <String>[];
  for (final dir in const ['lib', 'test', 'bin', 'tool']) {
    final root = Directory('${package.path}/$dir');
    if (!root.existsSync()) continue;
    for (final file in root.listSync(recursive: true).whereType<File>()) {
      final last = file.path.split(Platform.pathSeparator).last;
      if (last.endsWith('.b.dart') || _generatedFileNames.contains(last)) {
        out.add(file.path);
      }
    }
  }
  return out;
}

/// Runs the formatter in check mode and returns the files it would rewrite.
List<String> _unformattedFiles(Directory package) {
  final roots = _formatTargets(package);
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

    test('F-SCD81-1: the Flutter twins are formatted where they are not '
        'generator output [2026-09-13]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not found — twins not reachable');
        return;
      }
      for (final name in _generatedOutputPackages) {
        final twin = Directory('${root.path}/$name');
        if (!twin.existsSync()) {
          markTestSkipped('$name not checked out beside this package');
          continue;
        }

        // Anti-vacuity, in both directions, because this is the one case here
        // whose subject is DERIVED rather than named. An empty target list would
        // pass by checking nothing; a list with no exclusions would mean the
        // `.b.dart` files had vanished — in which case the exclusion is stale
        // and someone should know, rather than the check quietly widening.
        final targets = _formatTargets(twin);
        expect(
          targets.length,
          greaterThanOrEqualTo(5),
          reason:
              '$name yielded only ${targets.length} format targets, so this is '
              'not a measurement of it',
        );
        final generated = Directory('${twin.path}/lib')
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.b.dart'))
            .length;
        expect(
          generated,
          greaterThan(0),
          reason:
              'no `*.b.dart` found in $name, so the exclusion above is '
              'excluding nothing — either the bridges moved or they are gone, '
              'and either way the target list needs rereading',
        );
        expect(
          targets.any((t) => t.endsWith('.b.dart')),
          isFalse,
          reason:
              'generator output must not be in the target list — sce123_aimn',
        );
        expect(
          targets.any(
            (t) => _generatedFileNames.contains(
              t.split(Platform.pathSeparator).last,
            ),
          ),
          isFalse,
          reason:
              'the version stamp is generator output too, and unformatted for '
              'the same reason — sce124_aimn',
        );

        expect(
          _unformattedFiles(twin),
          isEmpty,
          reason:
              'hand-written code in $name is not formatted, so the next '
              '`dart format` will rewrite it and bury whatever real edit lands '
              'alongside — and in these two packages that edit is usually a '
              'mirror change, which is checked by diffing the twins against '
              'each other',
        );
      }
    });

    test('F-SCD82-1: every mirrored package is formatted [2026-09-13]', () {
      // The general case, and it exists because adding five packages to
      // `_mirroredPackages` exposed what that list did NOT buy. F-SCC26-2 checks
      // this package, F-SCC26-3 names `tom_d4rt`, F-SCD81-1 covers the two
      // Flutter twins — and nothing checked the rest. `tom_d4rt_exec` had been
      // in the list since SCC26 with no case asserting its layout at all. A list
      // that looks like coverage and is not is the failure this suite was
      // written about, one level up from the formatting itself.
      //
      // The two named cases are kept rather than folded in: F-SCC26-3 carries
      // the mirror argument for the reference tree, and F-SCD81-1 also asserts
      // the generated-output exclusion is non-vacuous, which this case does not
      // ask about. Overlapping guards are cheap; a silent gap is not.
      if (root == null) {
        markTestSkipped('d4rt repo root not found — siblings not reachable');
        return;
      }
      final here = Directory.current.absolute.path
          .split(Platform.pathSeparator)
          .last;
      final unformatted = <String, List<String>>{};
      var checked = 0;
      for (final name in _mirroredPackages) {
        if (name == here) continue; // F-SCC26-2 owns this one.
        final package = Directory('${root.path}/$name');
        if (!package.existsSync()) continue;
        checked++;
        final changed = _unformattedFiles(package);
        if (changed.isNotEmpty) unformatted[name] = changed;
      }

      expect(
        checked,
        greaterThanOrEqualTo(_mirroredPackages.length - 1),
        reason:
            'only $checked of ${_mirroredPackages.length} mirrored packages were '
            'reachable, so this is not a measurement of the repo',
      );
      expect(
        unformatted,
        isEmpty,
        reason:
            'these packages have unformatted files, so the next `dart format` '
            'will rewrite them and bury whatever real edit lands alongside:\n'
            '${unformatted.entries.map((e) => '${e.key}: ${e.value.join(', ')}').join('\n')}',
      );
    });
  });
}
