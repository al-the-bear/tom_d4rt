// SCC45 / DGUC10 — what a package RESOLVES must match what it DECLARES.
//
// THE DEFECT FAMILY
//
// Three separate incidents in this repo share one root: a suite ran green
// against an interpreter nobody had checked, because `pubspec.lock` is
// gitignored repo-wide (`tom_ai/d4rt/.gitignore:72`) and no test output names
// a resolved version. The lock is pure per-machine state — never reviewed,
// never diffed, never synced across the four fleet machines.
//
//   DGUC6   we develop HEAD but measure the PUBLISHED package. The sibling
//           working tree is ahead of pub.dev, so a consumer that resolves
//           correctly still cannot see the change under test.
//   DGUC10  we claim to measure the published package but actually measure
//           HEAD. `tom_d4rt_flutter`'s pubspec dropped its path overrides in
//           0e46fa778; nothing re-resolved the lock, so for months it went on
//           resolving `tom_d4rt` from `../tom_d4rt` while advertising a hosted
//           floor.
//   SCC45   the source is correctly `hosted` and the version is merely
//           ancient. `pub get` is LOCK-PRESERVING: a lower-bound-only
//           constraint such as `>=0.4.1` ADMITS 0.40.0 but never SELECTS it
//           once a lock exists. `tom_d4rt_flutter_ast` sat at exactly 0.4.1
//           for ten minor versions. Only `pub upgrade`, deleting the lock, or
//           raising the lower bound above the locked version moves it.
//
// DGUC10 and SCC45 are mechanically checkable from files already on disk, and
// that is what this file does. DGUC6 is not — proving the sibling is ahead of
// pub.dev needs the network, and a test that reaches the network is a test
// that gets disabled the first week it flakes.
//
// THE PUB-CACHE DISCRIMINATOR
//
// Detecting SCC45 looks like it needs the network too, and the obvious offline
// substitute — compare the lock against the local sibling's `pubspec.yaml`
// version — does not work. That comparison cannot tell a frozen lock (bad)
// from an unpublished sibling (DGUC6, a different finding with a different
// remedy), because both present as "lock is behind the sibling".
//
// `~/.pub-cache/hosted/pub.dev/<pkg>-<ver>/` settles it. The cache lists every
// version this machine has ever downloaded. If a version NEWER than the locked
// one is sitting in the cache, then pub demonstrably had that version
// available and did not take it — which is the definition of a frozen lock.
// The inference is one-directional and that is deliberate: a machine with a
// cold cache under-reports rather than accusing an innocent package. For a
// ratchet, false negatives are the safe direction.
//
// WHAT IS ASSERTED
//
// F-SCC45-1  no package resolves a `tom_*` dependency from `path` unless its
//            own pubspec declares that path dependency (or a
//            `pubspec_overrides.yaml` sits beside it) — DGUC10
// F-SCC45-2  no package's lock is behind a `tom_*` version already present in
//            this machine's pub cache — SCC45
// F-SCC45-3  every entry in F-SCC45-2's exception list is still load-bearing,
//            so the list cannot outlive its reasons
// F-SCC45-4  no example, sample or demo-app pubspec DECLARES a hosted
//            interpreter floor below a version already in the pub cache
//
// F-SCC45-4 is about the pubspec, not the lock. An example's floor is not a
// requirement anyone measured; it is what a new project copies, so it should
// claim the release the example is actually run against — the current one.
// Libraries are excluded on purpose: their floors ARE requirement claims, and
// raising one without a reason is its own defect. The copy surfaces once went
// nineteen minors stale (`>=1.11.0` against 1.30.0) because nothing connected
// a publish to them; this is that connection, through the same pub-cache
// discriminator as F-SCC45-2.
//
// Both walk EVERY package under the repo root, not just the top-level ones.
// DGUC10 recorded the reason: the eight fixture packages under
// `tom_d4rt_exec/example/*/` each carry their own gitignored lock, and while
// exec's own lock was correct at 0.40.0 all eight were still pinned at 0.20.1,
// so the binaries the generator suites compiled resolved something else
// entirely. A guard that inspects only the package under test reports green
// through that.
//
// Both skip when the repo root is not reachable: a consumer holding a
// published copy of this package has no siblings and no repo to check, and a
// red test there would be noise rather than a finding.

import 'dart:io';

import 'package:test/test.dart';

/// Packages whose presence identifies the d4rt repo root.
const _repoMarkers = ['tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_exec'];

/// Prefix identifying the packages this guard cares about.
///
/// Third-party dependencies are out of scope: they are not published by this
/// workspace, so neither a stale path resolution nor an unpropagated publish
/// can happen to them.
const _ownedPrefix = 'tom_';

/// Packages exempted from [F_SCC45_2], each naming the todo that owns the
/// unfreeze.
///
/// AN EXCEPTION WITHOUT AN OWNER IS A LEAK. SCC44 found a divergence register
/// that had quietly absorbed six months of unrelated drift because its entries
/// carried no reason anyone could check. Every entry here names the todo that
/// will delete it; if you add one and cannot name that todo, file it first.
///
/// The list is currently EMPTY, and that is the intended resting state. It held
/// three entries once — the flutter-corpus twins, frozen deliberately so their
/// upgrade would happen inside SCC46 immediately before its corpus run rather
/// than days earlier, which would have recreated the very defect SCC46 was
/// filed about. SCC46 ran, and F-SCC45-3 named all three the moment they
/// stopped being frozen. That is the mechanism working; an empty map is the
/// receipt.
///
/// Keep the map rather than deleting it. An exemption is occasionally the right
/// answer for a lock whose unfreeze is genuinely owned by scheduled work, and
/// re-deriving the shape under time pressure is how one gets added without an
/// owner.
const Map<String, String> _frozenLockExceptions = <String, String>{};

/// A single dependency as recorded in a `pubspec.lock`.
class _Resolution {
  _Resolution(this.name, this.source, this.version);

  final String name;

  /// `hosted`, `path`, `sdk`, or `git`.
  final String source;
  final String version;
}

/// The d4rt repo root, found by walking up from the current directory.
///
/// Looks for a directory holding all the marker packages rather than counting
/// `..` segments, so it survives being run from a nested fixture.
Directory? _repoRoot() {
  var dir = Directory.current.absolute;
  for (var i = 0; i < 6; i++) {
    final hasAll = _repoMarkers.every(
      (p) => Directory('${dir.path}/$p').existsSync(),
    );
    if (hasAll) return dir;
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

/// Every directory beneath [root] that holds both a pubspec and a lock.
///
/// `.dart_tool`, `build` and `.git` are pruned: pub materialises package
/// skeletons under them that are not packages anyone maintains.
List<Directory> _packagesUnder(Directory root) {
  final found = <Directory>[];
  void walk(Directory dir, int depth) {
    if (depth > 5) return;
    final name = dir.path.split(Platform.pathSeparator).last;
    if (name.startsWith('.') || name == 'build' || name == 'node_modules') {
      return;
    }
    if (File('${dir.path}/pubspec.yaml').existsSync() &&
        File('${dir.path}/pubspec.lock').existsSync()) {
      found.add(dir);
    }
    for (final child in dir.listSync().whereType<Directory>()) {
      walk(child, depth + 1);
    }
  }

  walk(root, 0);
  return found;
}

/// The `tom_*` entries of [package]'s `pubspec.lock`.
///
/// Hand-rolled rather than parsed with a YAML package: this is the
/// zero-dependency half of the split, and gaining a `yaml` dev-dependency here
/// would put one more thing between a Flutter app and using it. The lock's
/// shape is fixed and machine-written, so indentation is a reliable key —
/// package names sit at two spaces, their fields at four.
List<_Resolution> _lockedTomPackages(Directory package) {
  final lines = File('${package.path}/pubspec.lock').readAsLinesSync();
  final namePattern = RegExp(r'^  ([A-Za-z0-9_]+):\s*$');
  final fieldPattern = RegExp(r'^    (source|version):\s*"?([^"]*)"?\s*$');

  final out = <_Resolution>[];
  String? current;
  String? source;
  String? version;

  void flush() {
    if (current != null &&
        current!.startsWith(_ownedPrefix) &&
        source != null &&
        version != null) {
      out.add(_Resolution(current!, source!, version!));
    }
    current = null;
    source = null;
    version = null;
  }

  for (final line in lines) {
    if (namePattern.firstMatch(line) case final m?) {
      flush();
      current = m.group(1);
      continue;
    }
    if (current == null) continue;
    if (fieldPattern.firstMatch(line) case final m?) {
      if (m.group(1) == 'source') {
        source = m.group(2);
      } else {
        version = m.group(2);
      }
    }
  }
  flush();
  return out;
}

/// Names of dependencies [package]'s pubspec declares with a `path:` key.
///
/// A path resolution is only legitimate when the pubspec asks for one. The
/// scan is indentation-relative: a dependency key at indent N owns every
/// following line indented deeper than N, and `path:` appearing in that block
/// is the declaration.
Set<String> _declaredPathDependencies(Directory package) {
  final lines = File('${package.path}/pubspec.yaml').readAsLinesSync();
  final keyPattern = RegExp(r'^(\s+)([A-Za-z0-9_]+):\s*$');

  final declared = <String>{};
  String? openKey;
  var openIndent = 0;

  for (final raw in lines) {
    final line = raw.split('#').first;
    if (line.trim().isEmpty) continue;
    final indent = line.length - line.trimLeft().length;

    if (openKey != null) {
      if (indent > openIndent) {
        if (line.trimLeft().startsWith('path:')) declared.add(openKey);
        continue;
      }
      openKey = null;
    }
    if (keyPattern.firstMatch(line) case final m?) {
      openKey = m.group(2);
      openIndent = m.group(1)!.length;
    }
  }
  return declared;
}

/// Versions of [name] present in this machine's pub.dev cache.
List<String> _cachedVersions(String name) {
  final home =
      Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
  if (home == null) return const [];
  final cache = Directory('$home/.pub-cache/hosted/pub.dev');
  if (!cache.existsSync()) return const [];

  final prefix = '$name-';
  return cache
      .listSync()
      .whereType<Directory>()
      .map((d) => d.path.split(Platform.pathSeparator).last)
      .where((d) => d.startsWith(prefix))
      .map((d) => d.substring(prefix.length))
      .toList();
}

/// Compares two dotted numeric versions, ignoring any pre-release suffix.
///
/// Pre-release versions are treated as their release counterpart and then
/// discarded by the caller: a `-dev` build in the cache is not evidence that a
/// stable release was passed over.
int _compareVersions(String a, String b) {
  List<int> parts(String v) => v
      .split(RegExp(r'[-+]'))
      .first
      .split('.')
      .map((p) => int.tryParse(p) ?? 0)
      .toList();
  final pa = parts(a);
  final pb = parts(b);
  for (var i = 0; i < 3; i++) {
    final x = i < pa.length ? pa[i] : 0;
    final y = i < pb.length ? pb[i] : 0;
    if (x != y) return x.compareTo(y);
  }
  return 0;
}

/// The newest stable version of [name] in the cache, or null.
String? _newestCached(String name) {
  final stable = _cachedVersions(name).where((v) => !v.contains('-')).toList();
  if (stable.isEmpty) return null;
  stable.sort(_compareVersions);
  return stable.last;
}

/// The interpreter packages whose floors F-SCC45-4 holds to the current
/// release. Tool dependencies such as `tom_d4rt_generator` are left out: an
/// example demonstrates running ON the interpreter, and chasing every tool
/// release through every example is churn that buys no truth.
const _interpreterPackages = {'tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_exec'};

/// Top-level projects that are copy surfaces although no path segment says so:
/// the standalone demo apps a new user starts from.
const _demoApps = {'tom_d4rt_flutter_test', 'tom_d4rt_flutter_ast_test'};

/// Whether the package at repo-relative [rel] is an example, a sample or a
/// demo app — something a user copies — rather than a library.
bool _isCopySurface(String rel) {
  final segments = rel.split('/');
  return segments.contains('example') ||
      segments.first == 'tom_d4rt_samples' ||
      _demoApps.contains(rel);
}

/// Every directory beneath [root] holding a `pubspec.yaml`, resolved or not —
/// a floor is a claim in the pubspec whether or not anyone ran `pub get`.
List<Directory> _pubspecsUnder(Directory root) {
  final found = <Directory>[];
  void walk(Directory dir, int depth) {
    if (depth > 5) return;
    final name = dir.path.split(Platform.pathSeparator).last;
    if (name.startsWith('.') || name == 'build' || name == 'node_modules') {
      return;
    }
    if (File('${dir.path}/pubspec.yaml').existsSync()) found.add(dir);
    for (final child in dir.listSync().whereType<Directory>()) {
      walk(child, depth + 1);
    }
  }

  walk(root, 0);
  return found;
}

/// Interpreter dependencies [package] declares with a version constraint, as
/// name -> constraint text. Path, git and sdk dependencies carry no constraint
/// and are skipped; F-SCC45-1 owns path resolutions.
///
/// Hand-rolled for the same reason as [_lockedTomPackages]. A dependency with
/// an inline constraint sits at two spaces under `dependencies:` or
/// `dev_dependencies:`, which the scan tracks by the last top-level key.
Map<String, String> _declaredInterpreterConstraints(Directory package) {
  final lines = File('${package.path}/pubspec.yaml').readAsLinesSync();
  final sectionPattern = RegExp(r'^([A-Za-z_]+):');
  final depPattern = RegExp(r'''^  ([A-Za-z0-9_]+):\s*(.*)$''');

  final declared = <String, String>{};
  String? section;
  for (final line in lines) {
    if (sectionPattern.firstMatch(line) case final m?) {
      section = m.group(1);
      continue;
    }
    if (section != 'dependencies' && section != 'dev_dependencies') continue;
    final m = depPattern.firstMatch(line);
    if (m == null || !_interpreterPackages.contains(m.group(1))) continue;
    final constraint = m
        .group(2)!
        .split('#')
        .first
        .trim()
        .replaceAll('"', '')
        .replaceAll("'", '');
    if (constraint.isEmpty) continue; // a `path:` or `git:` block follows
    declared[m.group(1)!] = constraint;
  }
  return declared;
}

/// The lower bound of a pub version [constraint], or null when it has none
/// (`any`, `<2.0.0`).
String? _lowerBound(String constraint) {
  final c = constraint.trim();
  final caret = RegExp(r'^\^(\S+)').firstMatch(c);
  if (caret != null) return caret.group(1);
  final atLeast = RegExp(r'>=?\s*([0-9][^\s<]*)').firstMatch(c);
  if (atLeast != null) return atLeast.group(1);
  if (RegExp(r'^[0-9]+\.[0-9]+\.[0-9]+').hasMatch(c)) return c;
  return null;
}

/// [dir] relative to [root], for readable failure messages.
///
/// Always `/`-separated, so the exception list can be keyed on a path segment
/// without the entries silently ceasing to match on Windows.
String _rel(Directory root, Directory dir) {
  final path = dir.path.startsWith(root.path)
      ? dir.path.substring(root.path.length + 1)
      : dir.path;
  return path.replaceAll(r'\', '/');
}

void main() {
  final root = _repoRoot();

  group('SCC45/DGUC10: resolutions match declarations', () {
    late List<Directory> packages;

    setUpAll(() {
      packages = root == null ? const [] : _packagesUnder(root);
    });

    test('F-SCC45-1: no undeclared path resolution [2026-09-05]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      final offenders = <String>[];
      for (final package in packages) {
        if (File('${package.path}/pubspec_overrides.yaml').existsSync()) {
          continue;
        }
        final declared = _declaredPathDependencies(package);
        for (final res in _lockedTomPackages(package)) {
          if (res.source == 'path' && !declared.contains(res.name)) {
            offenders.add(
              '${_rel(root, package)} resolves ${res.name} from path '
              '(${res.version}) but declares no path dependency on it',
            );
          }
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'DGUC10: these packages test against a local working tree while '
            'their pubspec advertises a published version, so a green suite '
            'says nothing about the release consumers get. Run `pub get` in '
            'each — pub discards a path resolution the pubspec no longer '
            'declares, but only when someone runs it.\n'
            '${offenders.join('\n')}',
      );
    });

    test('F-SCC45-2: no lock is behind a version already in the pub cache '
        '[2026-09-05]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      final offenders = <String>[];
      for (final package in packages) {
        // Keyed on the owning top-level package, so an exception covers the
        // companion app nested under its `test/` too — those share the
        // corpus run that owns the unfreeze.
        final owningPackage = _rel(root, package).split('/').first;
        if (_frozenLockExceptions.containsKey(owningPackage)) continue;

        for (final res in _lockedTomPackages(package)) {
          if (res.source != 'hosted') continue;
          final newest = _newestCached(res.name);
          if (newest == null) continue;
          if (_compareVersions(res.version, newest) < 0) {
            offenders.add(
              '${_rel(root, package)} locks ${res.name} ${res.version} '
              'while $newest is already in the pub cache',
            );
          }
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'SCC45: `pub get` is lock-preserving, so a lower-bound-only '
            'constraint admits a newer version without ever selecting it. '
            'These locks were passed over by a resolution that had the newer '
            'version on hand.\n'
            'REMEDY: run `dart pub upgrade` (or `flutter pub upgrade`) in the '
            'package — and in every nested fixture package under it, which '
            'carry their own ignored locks. If the upgrade does NOT move the '
            'version, the cause is the other one: the sibling working tree '
            'has unpublished work (DGUC6) and the fix is to publish it, not '
            'to re-resolve.\n'
            '${offenders.join('\n')}',
      );
    });

    test('F-SCC45-3: every exception is still load-bearing [2026-09-05]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      final stillFrozen = <String>{};
      for (final package in packages) {
        for (final res in _lockedTomPackages(package)) {
          if (res.source != 'hosted') continue;
          final newest = _newestCached(res.name);
          if (newest == null) continue;
          if (_compareVersions(res.version, newest) < 0) {
            stillFrozen.add(_rel(root, package).split('/').first);
          }
        }
      }

      final obsolete = _frozenLockExceptions.keys.toSet().difference(
        stillFrozen,
      );
      expect(
        obsolete,
        isEmpty,
        reason:
            'These packages are exempted from F-SCC45-2 but are no longer '
            'frozen, so the exemption grants them nothing except the right to '
            'freeze again unnoticed. Delete the entries.\n'
            'This assertion is the whole reason the exception list is safe to '
            'have: without it, the list outlives its reasons, and the next '
            'reader inherits a set of names nobody can justify but nobody '
            'dares remove.\n'
            '${obsolete.join(', ')}',
      );
    });

    test('F-SCC45-4: no copy surface declares an interpreter floor below a '
        'version already in the pub cache [2026-09-11]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      final surfaces = _pubspecsUnder(
        root,
      ).where((package) => _isCopySurface(_rel(root, package))).toList();
      expect(
        surfaces.map((package) => _rel(root, package)),
        containsAll(['tom_d4rt_samples/d4rt_advanced_sample', ..._demoApps]),
        reason: 'the copy-surface discovery found too little to be trusted',
      );

      // Guards the guard: a parser that silently reads nothing reports every
      // copy surface clean. The advanced sample is known to declare one.
      final advanced = surfaces.firstWhere(
        (package) =>
            _rel(root, package) == 'tom_d4rt_samples/d4rt_advanced_sample',
      );
      expect(
        _declaredInterpreterConstraints(advanced),
        contains('tom_d4rt'),
        reason: 'the pubspec scan read no constraint where one is declared',
      );

      final offenders = <String>[];
      for (final package in surfaces) {
        final constraints = _declaredInterpreterConstraints(package);
        for (final MapEntry(key: name, value: constraint)
            in constraints.entries) {
          final floor = _lowerBound(constraint);
          final newest = _newestCached(name);
          if (floor == null) {
            offenders.add(
              '${_rel(root, package)} declares $name "$constraint", which has '
              'no floor at all',
            );
          } else if (newest != null && _compareVersions(floor, newest) < 0) {
            offenders.add(
              '${_rel(root, package)} declares $name "$constraint" while '
              '$newest is already in the pub cache',
            );
          }
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'An example, sample or demo app is what a new project copies, so '
            'its interpreter floor should name the release it is run against: '
            'the current one. These still name an older one, which nobody has '
            'measured them against.\n'
            'REMEDY: raise the floor to the newest published version, run '
            '`dart pub upgrade` (or `flutter pub upgrade`) in the package, and '
            'run its smoke check. If it no longer works on the current '
            'interpreter, that is the bug this guard exists to surface — fix '
            'the example, do not lower the floor.\n'
            '${offenders.join('\n')}',
      );
    });
  });
}
