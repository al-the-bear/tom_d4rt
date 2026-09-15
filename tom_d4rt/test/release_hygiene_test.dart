// REPO-WIDE GUARD (tom_d4rt) — every published package in the repo declares a version ahead of what has landed in its lib/.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
// SCC17: three stdlib commits landed library changes into an already-published
// version and were never written up, so the members they added shipped with no
// entry anywhere. They were found by hand, months later, by walking the log.
//
// This file is the check that walking the log by hand was standing in for.
//
// WHAT IT ACTUALLY CHECKS, AND WHY NOT THE OBVIOUS THING. The obvious guard is
// "a commit that touches lib/ must touch CHANGELOG.md". Measured against this
// repo's own history it is unusable: of the 32 commits that touched
// `tom_d4rt/lib` between the 1.22.0 release and 1.36.0, 16 did not touch the
// CHANGELOG in the same commit — and 13 of those 16 are fine, written up under
// the version bump that followed a few commits later. An 81% false-positive
// rate is a guard that gets switched off in a week.
//
// The three genuinely-undocumented commits are distinguished by something
// narrower and exactly checkable: **library code moved after the version that
// contains it was already frozen.** Once `pubspec.yaml` says 1.22.0 and 1.22.0
// has gone out, every further `lib/` commit is invisible until someone bumps.
// Batching several commits under one later bump is the house convention and is
// fine; leaving them under a version nobody will cut again is the defect.
//
// So the contract is: *the version in the pubspec must be ahead of everything
// that has landed in lib/.* Concretely — no commit may touch `<pkg>/lib` after
// the commit that last changed `<pkg>/pubspec.yaml`'s `version:` line.
//
// THAT IS A RELEASE-TIME CONTRACT, NOT A COMMIT-TIME ONE. It fires on the state
// of the branch, so the fix is always available and always the same: bump the
// version and write the section. It is green on the tree that introduced it,
// which is the only kind of guard that survives.
//
// F-SCC17-4 IS THE NEGATIVE CONTROL AND IS NOT OPTIONAL. A checker of this shape
// is trivially defanged — one wrong anchor commit and it passes forever while
// measuring nothing. So the same function is run against the historical commit
// where the defect is known to have existed, and is required to report exactly
// the three commits SCC17 was filed for. If someone breaks the checker, that
// case goes red even though the tree is clean.

import 'dart:io';

import 'package:test/test.dart';

/// The packages in this repo that are published, and their path relative to
/// `tom_d4rt/` — which is the working directory when this suite runs.
///
/// DISCOVERED, NOT LISTED (SCD60). This was a hardcoded three while the repo
/// published ten, so seven packages — including both flutter twins, which the
/// cluster campaign changes more often than anything else — were outside every
/// check here. A hardcoded list has no way of telling you it is short; that is
/// the same "nothing says when you are done" defect SCC21 names.
///
/// The rule is: a sibling directory with a `pubspec.yaml` that does NOT declare
/// `publish_to: none`. Adding a publishable package to the repo therefore
/// brings it under this guard with no edit here, which is the property that
/// makes the discovery worth the dozen lines.
final Map<String, String> _packages = _discoverPackages();

/// Path of a package's directory as git sees it, i.e. relative to the repo root.
final Map<String, String> _gitPaths = {
  for (final name in _packages.keys) name: name,
};

Map<String, String> _discoverPackages() {
  // `..` from `tom_d4rt/` is the repo root, which is where the sibling
  // packages live. The reference package itself is spelled `.` because the
  // suite's working directory IS that package.
  final root = Directory('..');
  if (!root.existsSync()) return const {};
  final found = <String, String>{};
  for (final entry in root.listSync().whereType<Directory>()) {
    final name = entry.uri.pathSegments.where((s) => s.isNotEmpty).last;
    final pubspec = File('${entry.path}/pubspec.yaml');
    if (!pubspec.existsSync()) continue;
    // A demo app or a test project says so, and is not held to release
    // hygiene — there is nothing to release.
    if (RegExp(
      r'''^publish_to:\s*['"]?none''',
      multiLine: true,
    ).hasMatch(pubspec.readAsStringSync())) {
      continue;
    }
    found[name] = name == 'tom_d4rt' ? '.' : '../$name';
  }
  return Map.fromEntries(
    found.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
  );
}

/// Versions that were declared in a pubspec and have no `## <version>` heading,
/// with the reason each is permitted.
///
/// SCD59. Two kinds, and the distinction is the whole content of this map:
///
/// PRE-CONVENTION. The three oldest entries predate anyone writing CHANGELOG
/// sections per bump. There is no commit to point at and nothing to recover.
///
/// ABSORBED BY A RENAME, which is a mechanism rather than an accident and has
/// now happened three times. A bump commit writes `## <new>`; the NEXT bump
/// renames that heading instead of adding one, so the first version's content
/// ends up under the second's number and the offset propagates forward until
/// someone adds a section rather than renaming. Each pair below was confirmed
/// by reading the renaming commit's own diff of the CHANGELOG and the pubspec
/// together:
///
///   tom_d4rt_ast 0.22.0 -> 0.23.0   (10a53c28f)
///   tom_d4rt     1.55.0 -> 1.56.0   (ab944d4a2, scc56)
///   tom_d4rt_ast 0.44.0 -> 0.45.0   (ab944d4a2, scc56)
///
/// THE VERDICT IS "ABSORBED", NOT "RESURRECT". None of the three was ever
/// published — the rename landed in the next commit, the same day in two of
/// the three cases, and none appears in this machine's pub cache. Splitting a
/// coherent section in two for a version nobody can install would leave two
/// half-sections and lose the thread of the change. The absorbing heading says
/// so in the CHANGELOG itself, because this comment is not where a reader of
/// the CHANGELOG looks.
const _versionsWithoutHeading = <String, Set<String>>{
  'tom_d4rt': {
    // Pre-convention.
    '1.8.4',
    // Absorbed into 1.56.0 by ab944d4a2 (scc56).
    '1.55.0',
  },
  'tom_d4rt_ast': {
    // Pre-convention.
    '0.1.0',
    '0.1.2',
    // Absorbed into 0.23.0 by 10a53c28f.
    '0.22.0',
    // Absorbed into 0.45.0 by ab944d4a2 (scc56).
    '0.44.0',
  },
  'tom_d4rt_exec': {},
  // SCD60 widened this guard from three packages to every publishable one,
  // which turned up three more gaps with three different causes — worth
  // separating, because only one of the three was fixable.
  'tom_d4rt_flutter': {
    // Build metadata, not a release. `1.0.0+1` was declared transiently while
    // 60f02fb4a split the library from its demo app; `## 1.0.0` is the
    // section, and a `+1` suffix does not get one of its own.
    '1.0.0+1',
  },
  'tom_d4rt_generator': {
    // Absorbed into 1.8.8 by 06eca521e, whose own message says why: "1.8.7
    // already on pub.dev". So the 1.8.7 ON pub.dev is a different build, and
    // this repository's 1.8.7 content shipped as 1.8.8 — which that section
    // now says, since a reader holding pub.dev's 1.8.7 is exactly who would
    // come looking.
    '1.8.7',
  },
};

/// Every version string this package's pubspec has ever declared.
///
/// One `git log -p` per package rather than a `git show` per commit: the same
/// answer (98 / 93 / 21 versions, measured 2026-09-12) for a fraction of the
/// process spawns.
Set<String> _declaredVersions(String package) {
  final log = Process.runSync('git', [
    'log',
    '-p',
    '--format=',
    '--',
    '${_gitPaths[package]}/pubspec.yaml',
  ], workingDirectory: _repoRoot);
  if (log.exitCode != 0) return {};
  return {
    for (final line in (log.stdout as String).split('\n'))
      if (line.startsWith('+version:')) line.substring(9).trim(),
  }..removeWhere((v) => v.isEmpty);
}

/// The `## <version>` headings a package's CHANGELOG carries.
Set<String> _changelogHeadings(String package) {
  final file = File('${_packages[package]}/CHANGELOG.md');
  if (!file.existsSync()) return {};
  return RegExp(
    r'^##\s+(\S+)',
    multiLine: true,
  ).allMatches(file.readAsStringSync()).map((m) => m.group(1)!).toSet();
}

/// Every git call runs from the repo root, so that the pathspecs above mean the
/// same thing in both kinds of call. They are repo-root-relative because that is
/// how `git show` reads the path half of a revision:path argument — but `git
/// log` resolves a pathspec against the *cwd*, so running it from `tom_d4rt/`
/// matches nothing and the checker silently measures an empty set.
String? _repoRoot;

String _git(List<String> args) {
  final result = Process.runSync('git', args, workingDirectory: _repoRoot);
  if (result.exitCode != 0) {
    throw StateError('git ${args.join(' ')} failed: ${result.stderr}');
  }
  return (result.stdout as String).trim();
}

bool _gitAvailable() {
  try {
    final result = Process.runSync('git', ['rev-parse', '--show-toplevel']);
    if (result.exitCode != 0) return false;
    _repoRoot = (result.stdout as String).trim();
    return true;
  } catch (_) {
    return false;
  }
}

/// The `version:` value in [package]'s pubspec as of [commit], or null when the
/// file did not exist there.
String? _versionAt(String package, String commit) {
  final result = Process.runSync('git', [
    'show',
    '$commit:${_gitPaths[package]}/pubspec.yaml',
  ], workingDirectory: _repoRoot);
  if (result.exitCode != 0) return null;
  for (final line in (result.stdout as String).split('\n')) {
    if (line.startsWith('version:')) {
      return line.substring('version:'.length).trim();
    }
  }
  return null;
}

/// The newest commit reachable from [head] that changed [package]'s declared
/// version — not merely its pubspec, which a dependency bump also touches.
///
/// Anchoring on "last touched pubspec.yaml" would be wrong in the direction
/// that matters: a dependency-only commit would move the anchor forward and
/// hide every lib commit behind it.
String _lastVersionBump(String package, String head) {
  final commits = _git([
    'log',
    '--format=%H',
    head,
    '--',
    '${_gitPaths[package]}/pubspec.yaml',
  ]).split('\n').where((l) => l.isNotEmpty);

  for (final commit in commits) {
    final here = _versionAt(package, commit);
    final parent = _versionAt(package, '$commit^');
    if (here != parent) return commit;
  }
  throw StateError('no version-setting commit found for $package');
}

/// Commits reachable from [head] that changed [package]'s `lib/` after the
/// version was last bumped — i.e. library changes not covered by any version.
///
/// The versioner stamp, `lib/src/version.versioner.dart`, is left out. It is
/// derived FROM the version rather than being a change behind it: writing it
/// completes a bump, and counting it would demand a new version for the act of
/// recording the current one.
List<String> _libCommitsAfterLastBump(String package, String head) {
  final anchor = _lastVersionBump(package, head);
  final log = _git([
    'log',
    '--format=%h %s',
    '$anchor..$head',
    '--',
    // LIBRARY CODE, not every file under lib/. The exclusion below already
    // said that for the versioner stamp; SCD60 made the rule general when
    // widening this guard to every publishable package turned up
    // `538c91bcf`, which untracked `tom_d4rt_dcli/lib/d4rt_bridges.g.info` —
    // a dated generator marker, gitignored, read by nothing, removed so pub's
    // publish validation would stop flagging a tracked file the package's own
    // ignore rules exclude. Demanding a release for that is asking a version
    // number to describe something no consumer can observe.
    //
    // This narrows what the guard MEANS, which is different from excusing a
    // package: it applies everywhere and there is no list to grow. A
    // per-package exemption is the thing that would make this decorative.
    '${_gitPaths[package]}/lib/*.dart',
    ':(exclude)${_gitPaths[package]}/lib/src/version.versioner.dart',
  ]);
  return log.isEmpty ? const [] : log.split('\n');
}

String _declaredVersion(String package) {
  final pubspec = File('${_packages[package]}/pubspec.yaml').readAsLinesSync();
  for (final line in pubspec) {
    if (line.startsWith('version:')) {
      return line.substring('version:'.length).trim();
    }
  }
  throw StateError('$package/pubspec.yaml declares no version');
}

/// The failure text for [F-SCC17-3], which has to distinguish two states the
/// original message conflated.
///
/// SCD150. The guard reads COMMITTED history — `_lastVersionBump` walks
/// `git log`, so a bump sitting in the working tree does not clear it. That is
/// correct (a bump nobody committed does not cover a commit) but it means the
/// same red test means two different things, wanting two different actions:
///
/// * the bump does not exist anywhere, so WRITE one; or
/// * the bump is already written on disk and simply has not landed, so COMMIT
///   it.
///
/// The second is what a mid-turn reader is usually looking at, and telling them
/// to "bump the version" when the pubspec on disk already says the new number
/// reads as the guard being broken. Naming which state it is costs one string
/// comparison.
String _orphanReason({
  required String package,
  required List<String> orphans,
  required String treeVersion,
  required String? committedVersion,
}) {
  final commits = '  ${orphans.join('\n  ')}';
  final rerun =
      'This check runs on its own in about three seconds — '
      '`dart test test/release_hygiene_test.dart` from `tom_d4rt/` — so run it '
      'after a `lib` commit rather than discovering this from the full suite a '
      'turn later.';

  if (committedVersion == null) {
    return '$package/lib has commits after the last version bump, and no '
        'committed pubspec could be read for it at HEAD. Treat this as the '
        'no-bump case: raise the version, write the CHANGELOG section, commit.\n'
        '$commits\n$rerun';
  }
  if (treeVersion != committedVersion) {
    return 'THE BUMP IS WRITTEN BUT NOT COMMITTED. $package/pubspec.yaml on '
        'disk says $treeVersion; the newest COMMITTED version is '
        '$committedVersion. This guard measures the repository, not the working '
        'tree — deliberately, because a bump nobody has committed does not '
        'cover a commit — so editing the pubspec cannot clear it. COMMIT the '
        'bump together with its CHANGELOG section and re-run. The commits it '
        'has to cover:\n$commits\n$rerun';
  }
  return 'NO BUMP EXISTS FOR THESE COMMITS. $package declares $treeVersion, '
      'which is also the newest committed version, so these commits changed '
      '$package/lib after the version was last set: they belong to no version '
      'and would ship inside an already-written section — which is how SCC17 '
      'happened. Raise the version in pubspec.yaml, add a `## <version>` '
      'CHANGELOG section describing them, and commit:\n$commits\n$rerun';
}

List<String> _changelogVersions(String package) {
  final changelog = File(
    '${_packages[package]}/CHANGELOG.md',
  ).readAsLinesSync();
  return [
    for (final line in changelog)
      if (line.startsWith('## ')) line.substring(3).trim(),
  ];
}

void main() {
  final siblings = _packages.values.every((p) => Directory(p).existsSync());
  final haveGit = siblings && _gitAvailable();

  final layoutSkip = siblings
      ? null
      : 'needs the sibling checkouts ../tom_d4rt_ast and ../tom_d4rt_exec; '
            'this guard is about the repo, not the package, and cannot run from '
            'a published tom_d4rt on its own';
  final gitSkip = haveGit
      ? null
      : (layoutSkip ?? 'needs the git history of the tom_d4rt repo');

  group('SCC17: the declared version covers everything that has landed', () {
    for (final package in _packages.keys) {
      test('F-SCC17-1/$package: the declared version has a CHANGELOG section '
          '[2026-09-04] (PASS)', () {
        final version = _declaredVersion(package);
        expect(
          _changelogVersions(package),
          contains(version),
          reason:
              'pubspec.yaml says $version and CHANGELOG.md has no '
              '`## $version` heading. Whatever the bump was for is currently '
              'undocumented — write the section before publishing.',
        );
      }, skip: layoutSkip);

      test('F-SCC17-2/$package: the declared version is the newest section '
          '[2026-09-04] (PASS)', () {
        final version = _declaredVersion(package);
        expect(
          _changelogVersions(package).first,
          version,
          reason:
              'The topmost CHANGELOG section is not the version being '
              'shipped. Either the pubspec was bumped and the section was '
              'written under the old number, or a section was added for a '
              'version the pubspec never reached.',
        );
      }, skip: layoutSkip);

      test('F-SCC17-3/$package: no library change has landed since the last '
          'version bump [2026-09-04] (PASS)', () {
        final orphans = _libCommitsAfterLastBump(package, 'HEAD');
        expect(
          orphans,
          isEmpty,
          reason: _orphanReason(
            package: package,
            orphans: orphans,
            treeVersion: _declaredVersion(package),
            committedVersion: _versionAt(package, 'HEAD'),
          ),
        );
      }, skip: gitSkip);
    }

    // SCD150. The two states above are not interchangeable advice, and the only
    // way to check that the message says which one it is, is to render it —
    // the reason string is built whether or not the expectation fails, so it is
    // reachable without manufacturing a red tree.
    test('F-SCD150-1: the failure text distinguishes an uncommitted bump from '
        'a missing one [2026-09-15]', () {
      const orphans = ['abc1234 some lib change'];
      final missing = _orphanReason(
        package: 'tom_d4rt',
        orphans: orphans,
        treeVersion: '1.113.0',
        committedVersion: '1.113.0',
      );
      final uncommitted = _orphanReason(
        package: 'tom_d4rt',
        orphans: orphans,
        treeVersion: '1.114.0',
        committedVersion: '1.113.0',
      );
      expect(
        missing,
        contains('NO BUMP EXISTS'),
        reason:
            'With the tree and HEAD at the same version there is nothing to '
            'commit, so the message must ask for a bump to be written.',
      );
      expect(
        uncommitted,
        contains('NOT COMMITTED'),
        reason:
            'With the tree ahead of HEAD the bump is already written, so '
            'telling the reader to bump the version reads as the guard being '
            'broken. It must ask for a commit.',
      );
      expect(
        uncommitted,
        contains('1.114.0'),
        reason:
            'The message has to name both versions, or the reader cannot tell '
            'which of the two the guard read.',
      );
      // Non-vacuity: a single message reused for both states would satisfy
      // neither pair of expectations above by accident, but it would satisfy
      // them if both strings happened to carry both phrases. They must differ.
      expect(
        missing,
        isNot(uncommitted),
        reason: 'One message for two states is the defect SCD150 was filed on.',
      );
      for (final text in [missing, uncommitted]) {
        expect(
          text,
          contains(orphans.single),
          reason: 'Either message is useless without the commits it is about.',
        );
        expect(
          text,
          contains('dart test test/release_hygiene_test.dart'),
          reason:
              'SCD150 part (1): the standalone invocation belongs in the '
              'message, not only in the quest overview — this is where a '
              'reader who has just hit the failure is looking.',
        );
      }
    });

    // The commit SCC17 was filed about: at this point `tom_d4rt` had said
    // 1.22.0 since f6ad794c3, 1.22.0 was already on pub.dev, and three stdlib
    // commits had landed behind it. The checker must see all three. Pinning the
    // subjects rather than the count is deliberate — a count matches by
    // accident, a subject does not.
    test('F-SCC17-4: the check reports the three commits it was written for '
        '[2026-09-04] (PASS)', () {
      final probe = Process.runSync('git', [
        'cat-file',
        '-e',
        'ccf041f82^{commit}',
      ], workingDirectory: _repoRoot);
      if (probe.exitCode != 0) {
        markTestSkipped('history does not reach ccf041f82 (shallow clone)');
        return;
      }
      final orphans = _libCommitsAfterLastBump('tom_d4rt', 'ccf041f82');
      expect(
        orphans.map((line) => line.split(' ').first).toList(),
        ['ccf041f82', '9fca5be33', '9bb876f36'],
        reason:
            'The negative control failed, so F-SCC17-3 is not measuring '
            'what it claims to. Most likely the anchor commit is being '
            'resolved wrongly — check _lastVersionBump before trusting a '
            'green run above.',
      );
    }, skip: gitSkip);

    // SCD59. F-SCC17-1 asks whether the CURRENT version has a heading and
    // F-SCC17-2 whether it is the newest. Both are satisfied at every commit
    // of a rename — that is exactly what a rename preserves — so neither can
    // see a version that shipped without one. The gap only appears walking the
    // history, which is what this does.
    //
    // IT IS NOT HYPOTHETICAL AND IT RECURRED. SCD59 was filed on 2026-09-04
    // naming one recent case (tom_d4rt_ast 0.22.0). By the time it ran, scc56
    // had done the same thing twice more in a single commit — tom_d4rt 1.55.0
    // and tom_d4rt_ast 0.44.0, both renamed rather than added. So the
    // mechanism produced three instances before anything watched for it.
    //
    // EACH ROW OBSERVED:
    //
    //   | Injected fault                              | Fires             |
    //   | -------------------------------------------- | ----------------- |
    //   | a throwaway version bumped into a pubspec     | undocumented      |
    //   | a baselined version given its own heading     | stale baseline    |
    //   | one package's pathspec broken                 | per-package floor |
    //
    // The first is the one that matters: the baseline makes a green FIRST run
    // worthless as evidence, so the only thing that shows this works is
    // watching it go red. Committing `version: 1.86.1` with no heading did,
    // naming the version.
    //
    // The third row changed the design. With an AGGREGATE floor it fired the
    // stale-baseline branch instead — breaking one package left 119 of 212
    // versions, over any aggregate floor worth writing, and the walk failing
    // showed up only as that package's baselined versions reading "never
    // declared". A side effect is not a diagnosis, so the floor is per-package
    // now and names the package that went dark.
    test('F-SCC17-5: every version ever declared has a CHANGELOG heading '
        '[2026-09-12] (PASS)', () {
      final undocumented = <String>[];
      final staleBaseline = <String>[];
      final perPackageVersions = <String, Set<String>>{};

      for (final package in _packages.keys) {
        final declared = _declaredVersions(package);
        final headings = _changelogHeadings(package);
        final permitted = _versionsWithoutHeading[package] ?? const <String>{};
        perPackageVersions[package] = declared;

        for (final version in declared.difference(headings)) {
          if (!permitted.contains(version)) {
            undocumented.add('$package $version');
          }
        }
        // The other direction, so the list cannot outlive its cause: a
        // permitted version that HAS a heading now is a resurrection somebody
        // performed, and leaving the entry would keep the next one silent.
        for (final version in permitted) {
          if (headings.contains(version)) {
            staleBaseline.add('$package $version');
          } else if (!declared.contains(version)) {
            staleBaseline.add('$package $version (never declared)');
          }
        }
      }
      undocumented.sort();
      staleBaseline.sort();

      // The floor, per package. Both checks below are emptiness assertions
      // over a git walk, and a walk that returned nothing satisfies them —
      // which is what a wrong pathspec does, silently.
      //
      // IT ASKS ONLY THAT THE WALK RETURNED SOMETHING, and arriving at that
      // took three tries, each wrong in a way the next measurement exposed:
      //
      //   * aggregate (>100) could not see ONE package going dark — breaking
      //     a pathspec left 119 of 212 versions, over any aggregate floor;
      //   * per-package (>=10) encoded an assumption about package age, and
      //     failed honestly on SCD60's widened set, where `tom_ast_model` has
      //     five versions in its whole history and `tom_d4rt_flutter_ast`
      //     four;
      //   * "the walk must contain the version the pubspec declares NOW" read
      //     well and was wrong in the other direction: it fails on an
      //     UNCOMMITTED bump, which is a normal working state, and blames the
      //     walk for it. A guard that reports a broken scan when the scan is
      //     fine sends someone to fix a thing that is not broken.
      //
      // What is left is the only claim that is true of every package in every
      // state: if the walk ran, it saw at least one version.
      final wentDark = [
        for (final package in _packages.keys)
          if ((perPackageVersions[package] ?? const <String>{}).isEmpty)
            package,
      ]..sort();
      expect(
        wentDark,
        isEmpty,
        reason:
            'The git walk returned no versions at all for these packages:\n'
            '  ${wentDark.join('\n  ')}\n\n'
            'That is not a finding about their CHANGELOGs — every version they '
            'declare then reads as documented by absence, and the checks below '
            'say nothing. Note that `git log` resolves a pathspec against the '
            'CWD, which is why these calls run from the repo root.',
      );

      expect(
        undocumented,
        isEmpty,
        reason:
            'These versions were declared in a pubspec and have no '
            '`## <version>` heading:\n  ${undocumented.join('\n  ')}\n\n'
            'The usual cause is renaming the previous bump\'s heading instead '
            'of adding a new one — which keeps F-SCC17-1 and -2 green while '
            'shifting every section up by one release. Add the heading. If the '
            'version was never published and its content genuinely belongs to '
            'the next section, record it in _versionsWithoutHeading AND say so '
            'under the absorbing heading in the CHANGELOG, where a reader '
            'looking for that version will actually be.',
      );

      expect(
        staleBaseline,
        isEmpty,
        reason:
            'These _versionsWithoutHeading entries no longer describe '
            'reality:\n  ${staleBaseline.join('\n  ')}\n\n'
            'A permitted version that has a heading now, or that no pubspec '
            'ever declared, is an exemption outliving its cause. Delete the '
            'entry — left in, it would keep the next genuinely-undocumented '
            'version silent.',
      );
    }, skip: gitSkip);
  });
}
