/// Reports, per file, where a consumer's *resolved* (pub.dev-hosted) copy of a
/// workspace package differs from the working tree beside it.
///
/// ## Why this exists
///
/// `tom_d4rt_exec` and both `tom_d4rt_flutter*` twins depend on the interpreter
/// **from pub.dev**, not by path. That is deliberate policy, not
/// misconfiguration: their suites are meant to certify what a consumer actually
/// gets. The cost is that an interpreter fix in the working tree is invisible to
/// them until it is published — so a test in those packages can fail for two
/// opposite reasons:
///
///   * the analyzer-free interpreter has a genuine bug, or
///   * the test is measuring a version that predates the fix.
///
/// Those call for opposite responses, and until now they were told apart by
/// reading todo titles and remembering which fix shipped when. Memory is not an
/// instrument. This tool asks the only authority that can answer — the bytes in
/// the pub cache next to the bytes in `lib/` — and answers per file.
///
/// The intended use is *before* a port or a conformance census: start from
/// "these N files test code that is actually published, these M do not" instead
/// of from a guess.
///
/// ## What it measures, and what it deliberately does not
///
/// It compares `lib/` of the resolved hosted archive against `lib/` of the
/// sibling working-tree package, file by file, and groups the differing files by
/// their containing directory to name the *stranded subsystems* — the parts of
/// the package whose working-tree behaviour no consumer suite can currently see.
///
/// It says nothing about whether a difference matters. A reformat and a
/// semantic fix both read as `differs`. The point is to bound the question:
/// files reported `identical` cannot be the explanation for a failure, and that
/// eliminates most of the search space for free.
///
/// ## Everything is derived
///
/// No list of consumers, dependencies or versions is written down here. The tool
/// walks the repository for packages that have a `pubspec.lock`, and for each
/// one reports the hosted dependencies that also exist as a working-tree sibling.
/// A new consumer, or a new package pair, is picked up with no edit — which is
/// the only way a membership list can notice its own omissions.
///
/// ## Failure is loud
///
/// The worst outcome for a tool like this is a clean bill of health produced by
/// looking in the wrong place. So a missing lockfile, a missing hosted archive,
/// a missing working tree, or a hosted archive with no `lib/` files at all is a
/// hard error — never an empty, reassuring report.
///
/// `pubspec.lock` is gitignored in the Flutter twins, so the resolved version is
/// per-machine and invisible in any diff. A consumer with no lockfile is
/// reported as UNMEASURABLE rather than skipped: "I could not tell" and "there
/// is no drift" must not look the same.
///
/// Run:
///
/// ```sh
/// # From anywhere in the repo — surveys every consumer it finds.
/// dart run tom_d4rt_exec/tool/hosted_drift.dart
///
/// # One consumer only, full per-file listing, machine-readable.
/// dart run tom_d4rt_exec/tool/hosted_drift.dart --consumer tom_d4rt_exec --files
/// dart run tom_d4rt_exec/tool/hosted_drift.dart --json
///
/// # Guard mode: exit 2 when any consumer's resolution has drifted.
/// dart run tom_d4rt_exec/tool/hosted_drift.dart --check
/// ```
///
/// Exit codes: `0` measured successfully (and, under `--check`, everything is in
/// sync), `1` a hard error, `2` `--check` found drift.
library;

import 'dart:convert';
import 'dart:io';

// ---------------------------------------------------------------------------
// Lockfile
// ---------------------------------------------------------------------------

/// One entry of a `pubspec.lock` `packages:` map.
class LockedPackage {
  LockedPackage({
    required this.name,
    required this.version,
    required this.source,
    required this.dependency,
    this.sha256,
    this.url,
  });

  /// Package name, as resolved (the map key).
  final String name;

  /// Resolved version, e.g. `0.42.0`.
  final String version;

  /// `hosted`, `path`, `git`, `sdk`, …
  final String source;

  /// `direct main`, `direct dev`, `transitive`.
  final String dependency;

  /// Content hash of the hosted archive, when the source is hosted.
  ///
  /// Reported because it is the one identifier that survives a re-publish of the
  /// same version number — two machines showing the same version but different
  /// hashes are not running the same code.
  final String? sha256;

  /// Hosted repository URL, e.g. `https://pub.dev`.
  final String? url;

  /// Cache directory segment for [url], e.g. `pub.dev`.
  ///
  /// The pub cache keys hosted packages by the repository *authority*, so a
  /// package from a private pub server lands in its own subtree.
  String get hostedHost {
    final raw = url;
    if (raw == null || raw.isEmpty) return 'pub.dev';
    final parsed = Uri.tryParse(raw);
    if (parsed == null || parsed.host.isEmpty) return raw;
    // A non-default port is part of the identity of the repository, and pub
    // percent-encodes the colon so the result is a legal directory name.
    return parsed.hasPort ? '${parsed.host}%58${parsed.port}' : parsed.host;
  }
}

/// Parse the `packages:` section of a `pubspec.lock`.
///
/// Hand-rolled rather than pulled from `package:yaml` on purpose: this tool must
/// run with `dart run <path>` from *any* package in the repo, including ones
/// that do not depend on it and ones whose own resolution is the thing under
/// investigation. Zero package dependencies is what makes that safe.
///
/// The grammar it relies on is the one `pub` writes and is stable: two-space
/// indent for the package name, four for its fields, six for `description:`
/// members.
Map<String, LockedPackage> parseLockfile(String text) {
  final result = <String, LockedPackage>{};

  var inPackages = false;
  String? current;
  final fields = <String, String>{};

  void flush() {
    final name = current;
    if (name == null) return;
    result[name] = LockedPackage(
      name: fields['name'] ?? name,
      version: fields['version'] ?? '',
      source: fields['source'] ?? '',
      dependency: fields['dependency'] ?? '',
      sha256: fields['sha256'],
      url: fields['url'],
    );
    current = null;
    fields.clear();
  }

  for (final rawLine in const LineSplitter().convert(text)) {
    if (rawLine.trim().isEmpty || rawLine.trimLeft().startsWith('#')) continue;

    final indent = rawLine.length - rawLine.trimLeft().length;
    if (indent == 0) {
      flush();
      inPackages = rawLine.trim() == 'packages:';
      continue;
    }
    if (!inPackages) continue;

    final line = rawLine.trim();
    if (indent == 2) {
      flush();
      current = _unquote(
        line.endsWith(':') ? line.substring(0, line.length - 1) : line,
      );
      continue;
    }
    if (current == null) continue;

    final colon = line.indexOf(':');
    if (colon <= 0) continue;
    final key = _unquote(line.substring(0, colon));
    final value = _unquote(line.substring(colon + 1).trim());
    if (value.isEmpty) continue; // `description:` itself, a nesting header
    fields[key] = value;
  }
  flush();

  return result;
}

String _unquote(String value) {
  final trimmed = value.trim();
  if (trimmed.length >= 2) {
    final first = trimmed[0];
    if ((first == '"' || first == "'") && trimmed.endsWith(first)) {
      return trimmed.substring(1, trimmed.length - 1);
    }
  }
  return trimmed;
}

// ---------------------------------------------------------------------------
// Pub cache
// ---------------------------------------------------------------------------

/// Root of the pub cache, honouring `PUB_CACHE`.
///
/// [env] is a parameter rather than a read of [Platform.environment] so the
/// derivation can be tested without mutating the process environment.
String defaultPubCacheRoot(Map<String, String> env) {
  final explicit = env['PUB_CACHE'];
  if (explicit != null && explicit.isNotEmpty) return explicit;
  if (Platform.isWindows) {
    final localAppData = env['LOCALAPPDATA'];
    if (localAppData != null && localAppData.isNotEmpty) {
      return '$localAppData\\Pub\\Cache';
    }
    final appData = env['APPDATA'];
    if (appData != null && appData.isNotEmpty) return '$appData\\Pub\\Cache';
  }
  final home = env['HOME'] ?? '';
  return '$home/.pub-cache';
}

/// Directory holding the unpacked hosted archive for [package].
String hostedPackageDir(String pubCacheRoot, LockedPackage package) =>
    '$pubCacheRoot/hosted/${package.hostedHost}/'
    '${package.name}-${package.version}';

// ---------------------------------------------------------------------------
// Working tree
// ---------------------------------------------------------------------------

/// Map of package name to directory for every package directly under [repoRoot].
///
/// Derived from the `pubspec.yaml` files on disk, so the tool never carries a
/// list of the repo's packages that could fall behind the repo.
Map<String, String> worktreePackages(String repoRoot) {
  final root = Directory(repoRoot);
  if (!root.existsSync()) {
    throw HostedDriftError('repository root does not exist: $repoRoot');
  }
  final result = <String, String>{};
  for (final entity in root.listSync().whereType<Directory>()) {
    final pubspec = File('${entity.path}/pubspec.yaml');
    if (!pubspec.existsSync()) continue;
    final name = pubspecField(pubspec.readAsStringSync(), 'name');
    if (name != null) result[name] = entity.path;
  }
  return result;
}

/// Read a top-level scalar field from a `pubspec.yaml`.
String? pubspecField(String text, String key) {
  for (final line in const LineSplitter().convert(text)) {
    if (line.startsWith('$key:')) {
      return _unquote(line.substring(key.length + 1));
    }
  }
  return null;
}

// ---------------------------------------------------------------------------
// Comparison
// ---------------------------------------------------------------------------

/// How one file of a package's `lib/` compares between hosted and working tree.
enum FileDrift {
  /// Byte-identical (modulo line endings — see [compareLibTrees]).
  identical,

  /// Present on both sides with different content.
  differs,

  /// In the working tree but not in the published archive: unreleased code.
  onlyInTree,

  /// In the published archive but not in the working tree: deleted since.
  onlyInHosted,
}

/// The verdict for one file, keyed by its path relative to `lib/`.
class DriftEntry {
  DriftEntry(this.path, this.drift);

  /// Path relative to the package's `lib/`, always with `/` separators.
  final String path;

  final FileDrift drift;

  /// Directory this file lives in, relative to `lib/` — the "subsystem".
  String get subsystem {
    final slash = path.lastIndexOf('/');
    return slash < 0 ? '.' : path.substring(0, slash);
  }
}

/// Drift of one hosted dependency against its working-tree sibling.
class PackageDrift {
  PackageDrift({
    required this.name,
    required this.hostedVersion,
    required this.treeVersion,
    required this.hostedDir,
    required this.treeDir,
    required this.entries,
    this.sha256,
  });

  final String name;
  final String hostedVersion;
  final String treeVersion;
  final String hostedDir;
  final String treeDir;
  final String? sha256;
  final List<DriftEntry> entries;

  /// Files whose working-tree content no consumer suite can currently observe.
  List<DriftEntry> get stranded => entries
      .where((e) => e.drift != FileDrift.identical)
      .toList(growable: false);

  bool get inSync => stranded.isEmpty;

  int countOf(FileDrift drift) => entries.where((e) => e.drift == drift).length;

  /// Stranded file count per subsystem, highest first.
  ///
  /// This is the summary line the census actually wants: not "142 files differ"
  /// but "the whole of `src/runtime/stdlib` is unpublished".
  List<MapEntry<String, int>> strandedSubsystems() {
    final counts = <String, int>{};
    for (final entry in stranded) {
      counts[entry.subsystem] = (counts[entry.subsystem] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) {
        final byCount = b.value.compareTo(a.value);
        return byCount != 0 ? byCount : a.key.compareTo(b.key);
      });
    return sorted;
  }
}

/// Raised for every condition that would otherwise produce a falsely clean report.
class HostedDriftError implements Exception {
  HostedDriftError(this.message);
  final String message;
  @override
  String toString() => 'HostedDriftError: $message';
}

/// Compare `lib/` of a hosted archive against `lib/` of a working-tree package.
///
/// Line endings are normalised before comparison. A Windows checkout stores
/// `\r\n` where the published archive has `\n`, and without this every single
/// file would read as drifted on one third of the fleet — a report that is
/// wrong in the most expensive direction, since it hides the real drift in
/// noise.
///
/// Throws [HostedDriftError] if either `lib/` is missing, or if the hosted
/// `lib/` is empty. An empty hosted tree means the archive was not found where
/// it was expected; reporting every working-tree file as "unreleased" would be
/// technically true of the directory examined and useless.
PackageDrift compareLibTrees({
  required String name,
  required String hostedVersion,
  required String treeVersion,
  required String hostedDir,
  required String treeDir,
  String? sha256,
}) {
  final hostedLib = Directory('$hostedDir/lib');
  final treeLib = Directory('$treeDir/lib');

  if (!hostedLib.existsSync()) {
    throw HostedDriftError(
      'no hosted archive for $name $hostedVersion at $hostedDir — run '
      '`dart pub get` in the consumer so the cache is populated',
    );
  }
  if (!treeLib.existsSync()) {
    throw HostedDriftError('no working-tree lib/ for $name at $treeDir');
  }

  final hostedFiles = _dartFilesUnder(hostedLib);
  if (hostedFiles.isEmpty) {
    throw HostedDriftError(
      'the hosted archive for $name $hostedVersion contains no lib/ files '
      '($hostedDir) — this is a wrong-directory result, not a clean one',
    );
  }
  final treeFiles = _dartFilesUnder(treeLib);

  final allPaths = <String>{...hostedFiles.keys, ...treeFiles.keys}.toList()
    ..sort();

  final entries = <DriftEntry>[];
  for (final path in allPaths) {
    final hosted = hostedFiles[path];
    final tree = treeFiles[path];
    if (hosted == null) {
      entries.add(DriftEntry(path, FileDrift.onlyInTree));
    } else if (tree == null) {
      entries.add(DriftEntry(path, FileDrift.onlyInHosted));
    } else {
      final same =
          _normalise(File(hosted).readAsStringSync()) ==
          _normalise(File(tree).readAsStringSync());
      entries.add(
        DriftEntry(path, same ? FileDrift.identical : FileDrift.differs),
      );
    }
  }

  return PackageDrift(
    name: name,
    hostedVersion: hostedVersion,
    treeVersion: treeVersion,
    hostedDir: hostedDir,
    treeDir: treeDir,
    sha256: sha256,
    entries: entries,
  );
}

String _normalise(String text) => text.replaceAll('\r\n', '\n');

/// Map of `lib/`-relative path to absolute path for every `.dart` file below [dir].
Map<String, String> _dartFilesUnder(Directory dir) {
  final prefix = '${dir.path}/'.replaceAll(r'\', '/');
  final result = <String, String>{};
  for (final file in dir.listSync(recursive: true).whereType<File>()) {
    final normalised = file.path.replaceAll(r'\', '/');
    if (!normalised.endsWith('.dart')) continue;
    result[normalised.substring(prefix.length)] = file.path;
  }
  return result;
}

// ---------------------------------------------------------------------------
// Survey
// ---------------------------------------------------------------------------

/// What one consumer package resolves, and how far that is from the tree.
class ConsumerReport {
  ConsumerReport({
    required this.consumer,
    required this.consumerDir,
    this.packages = const [],
    this.unmeasurable,
  });

  final String consumer;
  final String consumerDir;
  final List<PackageDrift> packages;

  /// Why this consumer could not be measured, if it could not.
  ///
  /// Never collapsed into "no drift": `pubspec.lock` is gitignored in the
  /// Flutter twins, so an unmeasurable consumer is the common case on a fresh
  /// checkout and must be visibly distinct from a converged one.
  final String? unmeasurable;

  bool get measured => unmeasurable == null;
  bool get inSync => measured && packages.every((p) => p.inSync);
}

/// Survey every package under [repoRoot] that has a lockfile.
///
/// [only] restricts the survey to one consumer by name; it exists for focused
/// runs, not to shrink the default scope.
List<ConsumerReport> surveyRepo(
  String repoRoot, {
  required String pubCacheRoot,
  String? only,
}) {
  final packages = worktreePackages(repoRoot);
  if (packages.isEmpty) {
    throw HostedDriftError('no packages found under $repoRoot');
  }
  if (only != null && !packages.containsKey(only)) {
    throw HostedDriftError(
      'no package named $only under $repoRoot (found: '
      '${(packages.keys.toList()..sort()).join(', ')})',
    );
  }

  final reports = <ConsumerReport>[];
  final names = packages.keys.toList()..sort();
  for (final consumer in names) {
    if (only != null && consumer != only) continue;
    final dir = packages[consumer]!;
    final lockFile = File('$dir/pubspec.lock');

    if (!lockFile.existsSync()) {
      // Only worth reporting if this package could in principle depend on a
      // sibling; a leaf with no lockfile is simply not a consumer.
      final pubspec = File('$dir/pubspec.yaml').readAsStringSync();
      final mentionsSibling = packages.keys.any(
        (p) => p != consumer && pubspec.contains('$p:'),
      );
      if (!mentionsSibling) continue;
      reports.add(
        ConsumerReport(
          consumer: consumer,
          consumerDir: dir,
          unmeasurable:
              'no pubspec.lock (gitignored here) — run `dart pub get` / '
              '`flutter pub get` in $consumer before trusting any suite it runs',
        ),
      );
      continue;
    }

    final locked = parseLockfile(lockFile.readAsStringSync());
    final drifts = <PackageDrift>[];
    for (final entry in locked.entries) {
      final dep = entry.value;
      if (dep.source != 'hosted') continue;
      final treeDir = packages[dep.name];
      if (treeDir == null || dep.name == consumer) continue;

      final treeVersion =
          pubspecField(
            File('$treeDir/pubspec.yaml').readAsStringSync(),
            'version',
          ) ??
          '?';
      drifts.add(
        compareLibTrees(
          name: dep.name,
          hostedVersion: dep.version,
          treeVersion: treeVersion,
          hostedDir: hostedPackageDir(pubCacheRoot, dep),
          treeDir: treeDir,
          sha256: dep.sha256,
        ),
      );
    }
    if (drifts.isEmpty) continue;
    drifts.sort((a, b) => a.name.compareTo(b.name));
    reports.add(
      ConsumerReport(consumer: consumer, consumerDir: dir, packages: drifts),
    );
  }

  if (reports.isEmpty) {
    throw HostedDriftError(
      'no consumer resolves a workspace package from pub.dev under $repoRoot — '
      'that is not a clean result, it means the survey looked in the wrong place',
    );
  }
  return reports;
}

// ---------------------------------------------------------------------------
// Rendering
// ---------------------------------------------------------------------------

/// Human-readable report. [showFiles] adds the per-file listing.
String renderText(List<ConsumerReport> reports, {bool showFiles = false}) {
  final out = StringBuffer();
  out.writeln('Hosted-vs-worktree drift');
  out.writeln('=' * 72);

  for (final report in reports) {
    out.writeln();
    out.writeln('${report.consumer}  (${report.consumerDir})');
    if (!report.measured) {
      out.writeln('  UNMEASURABLE: ${report.unmeasurable}');
      continue;
    }
    for (final pkg in report.packages) {
      final verdict = pkg.inSync
          ? 'IN SYNC'
          : '${pkg.stranded.length} of ${pkg.entries.length} files stranded';
      out.writeln(
        '  ${pkg.name}: resolved ${pkg.hostedVersion} vs tree '
        '${pkg.treeVersion}  ->  $verdict',
      );
      if (pkg.sha256 != null) {
        out.writeln('    sha256 ${pkg.sha256!.substring(0, 12)}…');
      }
      if (pkg.inSync) continue;
      out.writeln(
        '    differs ${pkg.countOf(FileDrift.differs)}   '
        'only-in-tree ${pkg.countOf(FileDrift.onlyInTree)}   '
        'only-in-hosted ${pkg.countOf(FileDrift.onlyInHosted)}',
      );
      out.writeln('    stranded subsystems:');
      for (final subsystem in pkg.strandedSubsystems()) {
        out.writeln(
          '      ${subsystem.value.toString().padLeft(4)}  ${subsystem.key}',
        );
      }
      if (showFiles) {
        out.writeln('    files:');
        for (final entry in pkg.stranded) {
          out.writeln('      ${entry.drift.name.padRight(14)} ${entry.path}');
        }
      }
    }
  }

  out.writeln();
  out.writeln('-' * 72);
  final unmeasured = reports.where((r) => !r.measured).length;
  final drifted = reports.where((r) => r.measured && !r.inSync).length;
  out.writeln(
    'consumers ${reports.length}   drifted $drifted   unmeasurable $unmeasured',
  );
  return out.toString();
}

/// Machine-readable report, so a census can record the measurement verbatim.
Map<String, Object?> toJsonReport(List<ConsumerReport> reports) => {
  'generated': DateTime.now().toIso8601String(),
  'consumers': [
    for (final report in reports)
      {
        'consumer': report.consumer,
        'dir': report.consumerDir,
        if (!report.measured) 'unmeasurable': report.unmeasurable,
        if (report.measured)
          'packages': [
            for (final pkg in report.packages)
              {
                'package': pkg.name,
                'resolved': pkg.hostedVersion,
                'tree': pkg.treeVersion,
                'sha256': pkg.sha256,
                'files': pkg.entries.length,
                'identical': pkg.countOf(FileDrift.identical),
                'differs': pkg.countOf(FileDrift.differs),
                'onlyInTree': pkg.countOf(FileDrift.onlyInTree),
                'onlyInHosted': pkg.countOf(FileDrift.onlyInHosted),
                'strandedSubsystems': {
                  for (final s in pkg.strandedSubsystems()) s.key: s.value,
                },
                'stranded': [
                  for (final e in pkg.stranded)
                    {'path': e.path, 'drift': e.drift.name},
                ],
              },
          ],
      },
  ],
};

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

/// Repository root, derived from this script's own location.
///
/// The script lives at `<repo>/tom_d4rt_exec/tool/hosted_drift.dart`, so it can
/// find the repo without being told and without depending on the caller's CWD.
String repoRootFromScript(Uri scriptUri) {
  final segments = scriptUri.toFilePath().replaceAll(r'\', '/').split('/');
  // …/<repo>/<package>/tool/hosted_drift.dart -> drop three trailing segments.
  return segments.sublist(0, segments.length - 3).join('/');
}

void main(List<String> args) {
  final asJson = args.contains('--json');
  final checkOnly = args.contains('--check');
  final showFiles = args.contains('--files');

  String? only;
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--consumer' && i + 1 < args.length) only = args[i + 1];
    if (args[i].startsWith('--consumer=')) {
      only = args[i].substring('--consumer='.length);
    }
  }

  try {
    final repoRoot = repoRootFromScript(Platform.script);
    final reports = surveyRepo(
      repoRoot,
      pubCacheRoot: defaultPubCacheRoot(Platform.environment),
      only: only,
    );

    stdout.write(
      asJson
          ? '${const JsonEncoder.withIndent('  ').convert(toJsonReport(reports))}\n'
          : renderText(reports, showFiles: showFiles),
    );

    if (checkOnly && reports.any((r) => !r.measured || !r.inSync)) {
      stderr.writeln(
        'FAIL: at least one consumer resolves a stale or unmeasurable copy of a '
        'workspace package. Any suite it runs certifies that copy, not the tree.',
      );
      exitCode = 2;
    }
  } on HostedDriftError catch (error) {
    stderr.writeln(error.message);
    exitCode = 1;
  }
}
