/// Which `pubspec.lock` files in this repo resolve a `tom_*` package older
/// than one the pub cache already holds — the one definition, used by the
/// guard that reports it and by the tool that clears it.
///
/// SCD206. `F-SCC45-2` in `scc45_resolution_guard_test.dart` finds these and
/// says "run `dart pub upgrade` (or `flutter pub upgrade`) in the …", and
/// stops there. Clearing it once meant forty-one findings across twenty-nine
/// packages, split by hand between `dart` and `flutter` by reading each path
/// back to its kind. `pubspec.lock` is gitignored repo-wide (DGUC10), so that
/// is per-machine work that recurs on every fleet machine after every publish
/// — and a check whose remedy is that expensive is one people switch off
/// rather than act on.
///
/// TWO CALLERS, ONE COMPARISON, deliberately. The guard and
/// `upgrade_stale_locks.dart` have to agree about what "behind" means or the
/// tool clears a red the guard still reports, which is worse than either alone.
/// The todo that asked for the tool asked for this factoring in the same
/// breath.
///
/// ZERO DEPENDENCIES, like the guard it came from. The lock is parsed by hand
/// rather than with `package:yaml`: `tom_d4rt_ast` ships to Flutter apps and
/// gains no dev-dependency it does not need. A lock is machine-written and its
/// shape is fixed, so indentation is a reliable key — package names sit at two
/// spaces, their fields at four.
library;

import 'dart:io';

/// Packages whose presence identifies the d4rt repo root.
const repoMarkers = ['tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_exec'];

/// Prefix identifying the packages this cares about.
///
/// Third-party dependencies are out of scope: they are not published by this
/// workspace, so an unpropagated publish cannot happen to them.
const ownedPrefix = 'tom_';

/// A single dependency as recorded in a `pubspec.lock`.
class Resolution {
  const Resolution(this.name, this.source, this.version);

  final String name;

  /// `hosted`, `path`, `sdk`, or `git`.
  final String source;
  final String version;
}

/// One lock entry that is behind what the cache holds.
class StaleLock {
  const StaleLock(this.package, this.dependency, this.locked, this.cached);

  /// Repo-relative path of the package whose lock is stale.
  final String package;
  final String dependency;
  final String locked;
  final String cached;

  @override
  String toString() =>
      '$package locks $dependency $locked while $cached is already in the '
      'pub cache';
}

/// The d4rt repo root, found by walking up from [from].
///
/// Looks for a directory holding all the marker packages rather than counting
/// `..` segments, so it survives being run from a nested fixture.
Directory? repoRoot({Directory? from}) {
  var dir = (from ?? Directory.current).absolute;
  for (var i = 0; i < 6; i++) {
    if (repoMarkers.every((p) => Directory('${dir.path}/$p').existsSync())) {
      return dir;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

/// Every directory beneath [root] that holds both a pubspec and a lock.
///
/// `.dart_tool`, `build` and `node_modules` are pruned: pub materialises
/// package skeletons under them that are not packages anyone maintains.
List<Directory> packagesUnder(Directory root) {
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
List<Resolution> lockedTomPackages(Directory package) {
  final lockFile = File('${package.path}/pubspec.lock');
  if (!lockFile.existsSync()) return const [];
  final namePattern = RegExp(r'^  ([A-Za-z0-9_]+):\s*$');
  final fieldPattern = RegExp(r'^    (source|version):\s*"?([^"]*)"?\s*$');

  final out = <Resolution>[];
  String? current;
  String? source;
  String? version;

  void flush() {
    if (current != null &&
        current!.startsWith(ownedPrefix) &&
        source != null &&
        version != null) {
      out.add(Resolution(current!, source!, version!));
    }
    current = null;
    source = null;
    version = null;
  }

  for (final line in lockFile.readAsLinesSync()) {
    final name = namePattern.firstMatch(line);
    if (name != null) {
      flush();
      current = name.group(1);
      continue;
    }
    final field = fieldPattern.firstMatch(line);
    if (field == null || current == null) continue;
    if (field.group(1) == 'source') {
      source = field.group(2);
    } else {
      version = field.group(2);
    }
  }
  flush();
  return out;
}

/// `-1`, `0` or `1` comparing [a] and [b] by major.minor.patch.
///
/// Pre-release and build metadata are dropped rather than ordered: a cache
/// holding `2.9.0-dev` is not evidence that `2.9.0` exists, and
/// [newestCachedVersion] filters them out before this is reached.
int compareVersions(String a, String b) {
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

/// Every version of [name] in this machine's hosted pub cache.
List<String> cachedVersions(String name) {
  final home =
      Platform.environment['PUB_CACHE'] ??
      '${Platform.environment['HOME'] ?? ''}/.pub-cache';
  final dir = Directory('$home/hosted/pub.dev');
  if (!dir.existsSync()) return const [];
  final prefix = '$name-';
  return dir
      .listSync()
      .whereType<Directory>()
      .map((d) => d.path.split(Platform.pathSeparator).last)
      .where((n) => n.startsWith(prefix))
      .map((n) => n.substring(prefix.length))
      .toList();
}

/// The newest STABLE version of [name] in the cache, or null.
String? newestCachedVersion(String name) {
  final stable = cachedVersions(name).where((v) => !v.contains('-')).toList();
  if (stable.isEmpty) return null;
  stable.sort(compareVersions);
  return stable.last;
}

/// [root]-relative path of [dir], always `/`-separated.
String relativeTo(Directory root, Directory dir) {
  final path = dir.path.startsWith(root.path)
      ? dir.path.substring(root.path.length + 1)
      : dir.path;
  return path.replaceAll(r'\', '/');
}

/// Every lock under [root] resolving a hosted `tom_*` older than the cache
/// holds, skipping packages whose top-level owner is in [exceptions].
///
/// THE CACHE IS THE DISCRIMINATOR, and the inference is one-directional on
/// purpose. Comparing a lock against a sibling's `pubspec.yaml` cannot tell a
/// frozen lock from an UNPUBLISHED sibling — both present as "the lock is
/// behind". A newer version sitting in the cache proves pub HAD it available
/// and did not take it. The cost is that a cold cache under-reports, so every
/// count this returns is a floor rather than a total.
List<StaleLock> staleLocks(
  Directory root, {
  Map<String, String> exceptions = const {},
}) {
  final out = <StaleLock>[];
  for (final package in packagesUnder(root)) {
    final rel = relativeTo(root, package);
    // Keyed on the owning top-level package, so an exception covers a
    // companion app nested under its `test/` too.
    if (exceptions.containsKey(rel.split('/').first)) continue;
    for (final res in lockedTomPackages(package)) {
      if (res.source != 'hosted') continue;
      final newest = newestCachedVersion(res.name);
      if (newest == null) continue;
      if (compareVersions(res.version, newest) < 0) {
        out.add(StaleLock(rel, res.name, res.version, newest));
      }
    }
  }
  return out;
}

/// The `name:` [package]'s pubspec declares, or null.
String? packageName(Directory package) {
  final pubspec = File('${package.path}/pubspec.yaml');
  if (!pubspec.existsSync()) return null;
  final match = RegExp(
    r'^name:\s*([A-Za-z0-9_]+)\s*$',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  return match?.group(1);
}

/// Packages under [root] that reach one of [moved] by `path:`.
///
/// UPGRADING A PACKAGE DE-SYNCS ITS PATH-LINKED FIXTURES, and this is the half
/// that is easy to miss because the fixtures hold no stale `tom_*` entry of
/// their own. A fixture reaching its host by `path:` inherits the host's
/// SOURCE but resolves its own DEPENDENCIES: move the host to `archive` 4.3.0
/// and the fixture goes on compiling the host's current `lib/` against 4.2.0.
/// `G-PARITY-EX` in the three generator packages reports exactly that, and
/// SCD206's first sweep created one — clearing one guard's red by creating
/// another's is not a remedy.
///
/// [moved] is a set of PACKAGE NAMES. Returns every walked package other than
/// those, whose lock holds a `path` entry naming one of them.
List<Directory> pathLinkedDependents(Directory root, Set<String> moved) {
  final out = <Directory>[];
  for (final package in packagesUnder(root)) {
    if (moved.contains(packageName(package))) continue;
    final linked = lockedTomPackages(
      package,
    ).any((r) => r.source == 'path' && moved.contains(r.name));
    if (linked) out.add(package);
  }
  return out;
}

/// Whether [package] declares the Flutter SDK, and so needs `flutter pub`.
///
/// The ONLY distinction that matters when choosing the upgrade command, and it
/// is readable from the pubspec rather than guessed from the path — a
/// companion app nested under a twin's `test/` is a Flutter package whose path
/// says nothing about it.
bool isFlutterPackage(Directory package) {
  final pubspec = File('${package.path}/pubspec.yaml');
  if (!pubspec.existsSync()) return false;
  return RegExp(
    r'^\s{2,}flutter:\s*$\n\s{4,}sdk:\s*flutter\s*$',
    multiLine: true,
  ).hasMatch(pubspec.readAsStringSync());
}
