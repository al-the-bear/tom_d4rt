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
const _packages = <String, String>{
  'tom_d4rt': '.',
  'tom_d4rt_ast': '../tom_d4rt_ast',
  'tom_d4rt_exec': '../tom_d4rt_exec',
};

/// Path of a package's directory as git sees it, i.e. relative to the repo root.
const _gitPaths = <String, String>{
  'tom_d4rt': 'tom_d4rt',
  'tom_d4rt_ast': 'tom_d4rt_ast',
  'tom_d4rt_exec': 'tom_d4rt_exec',
};

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
List<String> _libCommitsAfterLastBump(String package, String head) {
  final anchor = _lastVersionBump(package, head);
  final log = _git([
    'log',
    '--format=%h %s',
    '$anchor..$head',
    '--',
    '${_gitPaths[package]}/lib',
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
          reason:
              'These commits changed $package/lib after the version was '
              'last set, so they belong to no version and would ship inside '
              'an already-written section — which is how SCC17 happened. '
              'Bump the version and add a section describing them:\n'
              '  ${orphans.join('\n  ')}',
        );
      }, skip: gitSkip);
    }

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
  });
}
