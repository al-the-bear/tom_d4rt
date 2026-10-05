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
// F-SCC26-4  every mirrored PAIR declares the same SDK floor (SCE222): the
//            lower floor of a pair caps what both trees may bridge
// F-SCC26-5  no recorded floor straddle outlives its cause
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
  // them the guard is hygiene rather than a correctness aid. Their floors are
  // well above the tall-style boundary F-SCC26-1 checks; whether each MIRRORED
  // PAIR declares the same floor is F-SCC26-4's question, over [_mirroredPairs].
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

/// Mirrored PAIRS, which must declare the same SDK floor (SCE222).
///
/// A flat package list cannot say "these two must agree", and the pair is the
/// unit that matters: a guard such as `scc73_sdk_member_completeness_test`
/// skips SDK members `@Since` a version above the READING package's floor, so
/// the lower floor of a pair silently caps what the pair may bridge. That held
/// `tom_d4rt_ast` back from `Future.syncValue` for months (scd186), and three
/// Flutter-side pairs still straddled when this was written — each with the
/// analyzer-free member lower, the one that ships inside apps. Includes the
/// companion apps and the demo apps, which are twins of the same kind even
/// though they are not formatted mirrors.
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

/// File names that are GENERATOR OUTPUT and are therefore excluded everywhere.
///
/// `version.g.dart` is the versioner's second output (the shared header
/// `// Generated by versioner at …` identifies it). A fresh one is NOT
/// format-clean: measured 2026-10-03 with BuildKit 1.11.0, `dart format`
/// rewrites it in `tom_d4rt_dcli` and `tom_dcli_exec`, the only packages that
/// have one. Every copy is gitignored, so excluding it cannot bury an edit: it
/// never reaches a commit.
///
/// `version.versioner.dart`, the stamp a tool prints as its `--version` banner,
/// is NOT excluded. It used to be (SCD82), because the `buildkit` installed in
/// 2026-09 was 1.7.1 and emitted the two long getters unwrapped. The 1.11.0
/// template writes them pre-wrapped. Measured 2026-10-03 on all four stamp
/// packages (`tom_d4rt_dcli`, `tom_dcli_exec`, `tom_d4rt_generator`,
/// `tom_ast_generator`): a stamp freshly regenerated by BuildKit 1.11.0 is
/// `dart format`-clean. A stamp that fails here was written by a stale
/// `buildkit`; rebuild or pull the binary rather than formatting the stamp by
/// hand (the `version_stamp_test.dart` guards say the same). F-DFIN1-1 holds
/// that every committed stamp is a format target.
const _generatedFileNames = {'version.g.dart'};

/// The packages whose formatted surface is `lib/` only.
///
/// Their `lib/` includes the generator's output. `tom_d4rt_generator` 1.51.0
/// formats every `*.b.dart` it writes, at the receiving package's language
/// version (`formatGeneratedDart`, SCG5), and SCH3 regenerated both twins with
/// it. So the bridges are checked like hand-written code: a bridge that
/// `dart format` would rewrite now means it was written by an older generator,
/// or edited by hand, and both are worth a red test.
///
/// `test/` is excluded for these two for a different reason: the
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

/// The full `major.minor.patch` of the declared SDK floor, or null.
String? _declaredSdkVersion(File pubspec) {
  final match = RegExp(
    r'^\s*sdk:\s*[">=^\s]*(\d+\.\d+\.\d+)',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  return match?.group(1);
}

/// Paths under [package] that `dart format` should find nothing to do in.
///
/// Two shapes, because the two kinds of package have different surfaces. For the
/// interpreter trees it is whole directories, which is what makes the check
/// total. For the Flutter twins it is an explicit FILE list, derived rather than
/// recorded: every `.dart` under `lib`, generated bridges included. A recorded list
/// would go stale the first time somebody adds a file and would then pass by
/// omission — which is the failure mode this whole suite exists to prevent.
List<String> _formatTargets(Directory package) {
  final name = _lastSegment(package.path);

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
      targets.add(_relativeTo(package, path));
    }
  }
  return targets..sort();
}

/// Every version stamp under [package] — the only generated files still
/// excluded, because the versioner (not the bridge generator) writes them.
List<String> _generatedFiles(Directory package) {
  final out = <String>[];
  for (final dir in const ['lib', 'test', 'bin', 'tool']) {
    final root = Directory('${package.path}/$dir');
    if (!root.existsSync()) continue;
    for (final file in root.listSync(recursive: true).whereType<File>()) {
      final last = _lastSegment(file.path);
      if (_generatedFileNames.contains(last)) {
        out.add(file.path);
      }
    }
  }
  return out;
}

/// The last segment of [path], whichever separator it uses.
///
/// SCF30. Paths here are built by interpolation with `/` and then extended by
/// `listSync`, which uses the PLATFORM separator — so on Windows one path
/// holds both. Splitting on `Platform.pathSeparator` alone turned
/// `…\d4rt/tom_d4rt_flutter` into the name `d4rt/tom_d4rt_flutter`, which
/// matched no entry in [_generatedOutputPackages]; the twins' `test/` corpus
/// was then formatted as code and failed F-SCD81-1 on Windows only.
String _lastSegment(String path) => path.split(RegExp(r'[/\\]')).last;

/// [path] relative to [package], or [path] unchanged when it is not inside.
///
/// Relative on purpose: the targets become the formatter's command line, and
/// absolute paths are what pushed it past Windows' length limit (SCF30).
String _relativeTo(Directory package, String path) {
  final base = package.path;
  if (!path.startsWith(base) || path.length == base.length) return path;
  final sep = path[base.length];
  return sep == '/' || sep == r'\' ? path.substring(base.length + 1) : path;
}

/// The `--language-version` the formatter is run at: [package]'s DECLARED
/// floor, as `major.minor`, or null when it declares none.
///
/// SCF30. Without the flag the formatter reads the version from
/// `.dart_tool/package_config.json`, which is the floor as of the LAST
/// `pub get`, not as declared. bomber's `tom_d4rt` config was two months old
/// and still said 3.5, so the formatter chose the pre-3.7 style there and
/// reported every file in the package as unformatted — while the same tree
/// passed on mbp. This suite's claim is about the declared floor
/// (F-SCC26-1 checks it), so that is the version to format at; a stale
/// resolution is a machine's state, not the tree's.
String? _formatLanguageVersion(Directory package) {
  final floor = _declaredSdkFloor(File('${package.path}/pubspec.yaml'));
  return floor == null ? null : '${floor.major}.${floor.minor}';
}

/// Upper bound on the characters of paths passed to one formatter run.
///
/// Windows caps a command line at 32 767 characters; this stays well under it
/// whatever the working-directory prefix, and costs a handful of extra
/// processes on the one package (a Flutter twin's enumerated `lib/`) that
/// needs more than one batch.
const _maxBatchChars = 8000;

/// [targets] split into runs whose joined length stays under [maxChars].
List<List<String>> _batches(
  List<String> targets, {
  int maxChars = _maxBatchChars,
}) {
  final out = <List<String>>[];
  var current = <String>[];
  var length = 0;
  for (final target in targets) {
    if (current.isNotEmpty && length + target.length + 1 > maxChars) {
      out.add(current);
      current = <String>[];
      length = 0;
    }
    current.add(target);
    length += target.length + 1;
  }
  if (current.isNotEmpty) out.add(current);
  return out;
}

/// Runs the formatter in check mode and returns the files it would rewrite.
List<String> _unformattedFiles(Directory package) {
  final roots = _formatTargets(package);
  if (roots.isEmpty) return const [];
  final version = _formatLanguageVersion(package);
  final changed = <String>[];
  for (final batch in _batches(roots)) {
    final result = Process.runSync('dart', [
      'format',
      '--output=none',
      '--set-exit-if-changed',
      if (version != null) '--language-version=$version',
      ...batch,
    ], workingDirectory: package.path);
    if (result.exitCode == 0) continue;
    final names = (result.stdout as String)
        .split('\n')
        .where((l) => l.startsWith('Changed '))
        .map((l) => l.substring('Changed '.length).trimRight())
        .toList();
    // A non-zero exit with no `Changed` line is the formatter failing, not a
    // finding — report it as such rather than as a clean package.
    if (names.isEmpty) {
      throw StateError(
        'dart format exited ${result.exitCode} in ${package.path} without '
        'naming a file:\n${result.stderr}',
      );
    }
    changed.addAll(names);
  }
  return changed;
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

    test('F-SCD81-1: the Flutter twins are formatted, generated bridges '
        'included [2026-09-13]', () {
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

        // Anti-vacuity, because this is the one case here whose subject is
        // DERIVED rather than named. An empty target list would pass by
        // checking nothing, and a list without the bridges would mean they had
        // moved — the files most likely to regress, since a generator older
        // than 1.51.0 writes them unformatted (SCH3).
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
              'no `*.b.dart` found in $name — either the bridges moved or they '
              'are gone, and either way the target list needs rereading',
        );
        expect(
          targets.where((t) => t.endsWith('.b.dart')).length,
          generated,
          reason:
              'every generated bridge must be a format target — tom_d4rt_generator '
              '1.51.0 writes them formatted (SCH3)',
        );
        expect(
          targets.any((t) => _generatedFileNames.contains(_lastSegment(t))),
          isFalse,
          reason:
              'version.g.dart is versioner output that is not format-clean and '
              'is gitignored, so it is never a format target',
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
      final here = _lastSegment(Directory.current.absolute.path);
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

  group('DFIN1: the version stamps are format-checked', () {
    test('F-DFIN1-1: every committed version.versioner.dart is a format target '
        '[2026-10-03]', () {
      // Anti-vacuity for the exclusion's removal: the stamps are only checked
      // if `_formatTargets` reaches them, either as a file or under a
      // directory it lists.
      if (root == null) {
        markTestSkipped('d4rt repo root not found — siblings not reachable');
        return;
      }
      var stamps = 0;
      for (final name in _mirroredPackages) {
        final package = Directory('${root.path}/$name');
        final stamp = File('${package.path}/lib/src/version.versioner.dart');
        if (!stamp.existsSync()) continue;
        stamps++;
        final targets = _formatTargets(package);
        final covered = targets.any(
          (t) =>
              t == 'lib/src/version.versioner.dart' ||
              t == r'lib\src\version.versioner.dart' ||
              t == 'lib',
        );
        expect(
          covered,
          isTrue,
          reason: '$name/lib/src/version.versioner.dart is not a format target',
        );
      }
      expect(
        stamps,
        greaterThanOrEqualTo(4),
        reason: 'the four stamp packages were not all found',
      );
    });
  });

  // SCF30 — the guard measured the MACHINE on two hosts, not the tree. Each
  // case pins one of the causes against a platform that does not show it, so
  // a regression is caught on mbp rather than on the next Windows run.
  group('SCF30: the guard measures the tree, not the host', () {
    test('F-SCF30-1: a package name is found whichever separator a path uses '
        '[2026-09-29] (PASS)', () {
      expect(
        _lastSegment(r'C:\Code\d4rt/tom_d4rt_flutter'),
        'tom_d4rt_flutter',
      );
      expect(_lastSegment('/srv/d4rt/tom_d4rt_flutter'), 'tom_d4rt_flutter');
      expect(_lastSegment(r'd4rt/tom_d4rt_flutter/lib\src\x.dart'), 'x.dart');
    });

    test('F-SCF30-2: targets are relative to the package on either separator '
        '[2026-09-29] (PASS)', () {
      final package = Directory(r'C:\r\d4rt/tom_d4rt_flutter');
      expect(
        _relativeTo(package, r'C:\r\d4rt/tom_d4rt_flutter/lib\src\x.dart'),
        r'lib\src\x.dart',
      );
      expect(
        _relativeTo(package, r'C:\r\d4rt/tom_d4rt_flutter\lib\a.dart'),
        r'lib\a.dart',
      );
      // A sibling whose name merely STARTS with the package name is outside.
      expect(
        _relativeTo(package, r'C:\r\d4rt/tom_d4rt_flutter_ast/lib/a.dart'),
        r'C:\r\d4rt/tom_d4rt_flutter_ast/lib/a.dart',
      );
    });

    test('F-SCF30-3: the formatter runs at the DECLARED floor, not the '
        'resolved one [2026-09-29] (PASS)', () {
      expect(root, isNotNull, reason: 'd4rt repo root not found from cwd');
      for (final name in _mirroredPackages) {
        final package = Directory('${root!.path}/$name');
        final floor = _declaredSdkFloor(File('${package.path}/pubspec.yaml'))!;
        expect(
          _formatLanguageVersion(package),
          '${floor.major}.${floor.minor}',
          reason: name,
        );
      }
    });

    test('F-SCF30-4: batches cover every target in order and stay under the '
        'bound [2026-09-29] (PASS)', () {
      final targets = [for (var i = 0; i < 500; i++) 'lib/src/file_$i.dart'];
      final batches = _batches(targets, maxChars: 1000);
      expect(batches.length, greaterThan(1));
      expect(batches.expand((b) => b).toList(), targets);
      for (final batch in batches) {
        expect(
          batch.fold<int>(0, (n, t) => n + t.length + 1),
          lessThanOrEqualTo(1000),
        );
      }
      expect(_batches(const []), isEmpty);
      // One target longer than the bound still gets a batch of its own rather
      // than being dropped.
      expect(_batches(['x' * 50], maxChars: 10), [
        ['x' * 50],
      ]);
    });
  });
}
