/// The attribution header the corpus runners write at the top of `metrics.txt`.
///
/// A `testlog/` folder used to be a pass/skip/fail triple with no provenance.
/// Two facts made that a reproducibility hole rather than an inconvenience:
/// both twins **gitignore `pubspec.lock`**, so the resolved interpreter is
/// machine-local and appears in no diff, no review and no commit; and the
/// runners recorded only per-file results. Two fleet hosts could therefore run
/// the same corpus against different published interpreters and produce two
/// incomparable result sets that look identical in shape, and a folder kept
/// across a `pub upgrade` silently changed meaning.
///
/// The quest's cluster-fix protocol ends in "run the corpus serially", so this
/// is the attribution step for its primary evidence artifact. The trace that
/// already existed — the resolved-version table in each `Verification runs`
/// entry of `doc/interpreter_issues.md` — is hand-written, and exactly as
/// reliable as whoever remembered to fill it in. With the header, that table
/// becomes a transcription of a measured value.
///
/// EVERY HOSTED `tom_` PACKAGE IS RECORDED, NOT A CHOSEN THREE. The obvious
/// design is to name `tom_d4rt`, `tom_d4rt_ast` and `tom_d4rt_generator`,
/// which is what the `Verification runs` table happens to carry today. A
/// hand-written list of the interesting names is the failure mode this
/// repository keeps re-finding: the next package that matters presents as one
/// the record quietly does not mention. Reading them all costs nothing and
/// cannot go stale, and it is the same set
/// `companionResolutionMismatches` already compares.
///
/// THE HEADER IS WRITTEN AFTER THE COMPANION APP IS RESOLVED, on purpose. The
/// app's lock is re-resolved by the runner at start-up; a header taken before
/// that would attribute the run to versions it did not use.
///
/// The Dart/Flutter SDK version is deliberately ABSENT. The header is written
/// by whichever `dart` is on PATH, which is not necessarily the SDK bundled
/// with the `flutter` that runs the tests — and a version field that is
/// sometimes about a different toolchain is worse than no field.
///
/// This file is identical in both flutter twins (`test/run_attribution.dart`);
/// `test/scd164_run_attribution_test.dart` fails when the copies differ.
library;

import 'dart:convert';
import 'dart:io';

import 'companion_app_resolution.dart';

/// The prefix every attribution line carries, so a parser can separate the
/// header from the per-file result lines that follow it without counting.
const String attributionPrefix = '# ';

/// One `<prefix>: <name> <version> (<source>)` line per package [packageDir]
/// resolves that is either `tom_`-named or [alsoInclude], sorted by name.
///
/// [alsoInclude] is the twin's own package name, and it is not decoration: the
/// companion app resolves its twin by PATH, and that entry is what says whether
/// the app is wired to this working tree or to a published copy — the same
/// question `companionResolutionMismatches` asks first, before it applies any
/// `tom_` filter. Selecting purely on the `tom_` prefix gets the right answer
/// here only because both twins happen to be `tom_`-named, which is a property
/// of today's names rather than of the thing being recorded.
///
/// Returns a single `NONE — <reason>` line when there is nothing to report, so
/// that "asked and found none" is distinguishable from "never asked" (which
/// shows as no line with this prefix at all). An empty diagnostic that cannot
/// tell those apart is the shape of diagnostic this corpus keeps being misled
/// by.
List<String> _resolvedLines(
  String prefix,
  String packageDir, {
  String? alsoInclude,
}) {
  final lock = File('$packageDir/pubspec.lock');
  if (!lock.existsSync()) {
    return [
      '$attributionPrefix$prefix: NONE — $packageDir has no pubspec.lock',
    ];
  }
  final recorded = [
    for (final entry in readLockedPackages(packageDir).values)
      if (entry.name.startsWith('tom_') || entry.name == alsoInclude) entry,
  ]..sort((a, b) => a.name.compareTo(b.name));
  if (recorded.isEmpty) {
    return [
      '$attributionPrefix$prefix: NONE — no tom_ package in '
          '$packageDir/pubspec.lock',
    ];
  }
  return [
    for (final entry in recorded)
      '$attributionPrefix$prefix: ${entry.name} ${entry.version} '
          '(${entry.source})',
  ];
}

/// One `tree: <name> <resolved> vs <sibling> <verdict>` line per hosted `tom_`
/// package [packageDir] resolves that also has a sibling working tree.
///
/// WHY THIS IS ANNOUNCED AND NOT ENFORCED, which is the one thing that does
/// NOT port from exec's F-SCC80-3. That case FAILS when the resolved
/// `tom_d4rt_ast` differs from the working tree, because exec is a migration
/// target and a run certifying an interpreter nobody is editing is a wasted
/// run. Here the same gap is DELIBERATE: the twins resolve the interpreter
/// from pub.dev so their corpora certify what a consumer actually gets, and
/// the quest accepts the cost knowingly — nothing downstream can gate an
/// interpreter fix before it ships. A check that refused to start would refuse
/// every legitimate run, and would be switched off within a week.
///
/// What was missing is not a gate but a RECORD. Both twins gitignore
/// `pubspec.lock`, so which interpreter a sweep measured is machine-local and
/// appears in no diff; the resolved-version table in `Verification runs` is
/// hand-written from whatever the author remembered. The header already fixed
/// half of that by recording what was resolved. This is the other half: how
/// far behind the working tree that resolution is, measured rather than
/// recalled, so an entry can say "31 minors behind" from the log.
///
/// SAME VERSION IS STILL COMPARED, and that is not redundant. A sibling whose
/// `pubspec.yaml` says 0.1.7 while the published 0.1.7 holds different bytes
/// is a package edited without a bump, and it reads as "in step" to every
/// version-based check. The contents are diffed only in that case — when the
/// versions already differ, so do the files, and walking them proves nothing.
List<String> _workingTreeLines(String prefix, String packageDir) {
  // NORMALISE BEFORE TAKING THE PARENT. The runners pass `.`, whose absolute
  // form ends `/.` — so `parent.parent` happened to land on the sibling root
  // and would have climbed one level too high for any caller passing a real
  // path. Normalising makes the answer the same for both.
  final siblingRoot = Directory(
    Directory(packageDir).absolute.uri.normalizePath().toFilePath(),
  ).parent;
  final recorded = [
    for (final entry in readLockedPackages(packageDir).values)
      if (entry.name.startsWith('tom_') && entry.source == 'hosted') entry,
  ]..sort((a, b) => a.name.compareTo(b.name));
  final lines = <String>[];
  for (final entry in recorded) {
    final sibling = Directory('${siblingRoot.path}/${entry.name}');
    if (!sibling.existsSync()) continue;
    final tree = readPubspecIdentity(sibling.path).version;
    if (tree == null) continue;
    final verdict = tree == entry.version
        ? _sameVersionVerdict(packageDir, entry, sibling)
        : 'TREE AHEAD — this run measures the published copy, not the tree';
    lines.add(
      '$attributionPrefix$prefix: ${entry.name} resolved ${entry.version}, '
      'tree $tree — $verdict',
    );
  }
  if (lines.isEmpty) {
    return [
      '$attributionPrefix$prefix: NONE — no hosted tom_ package this package '
          'resolves has a sibling working tree beside it',
    ];
  }
  return lines;
}

/// Where [package] is actually loaded from, per [packageDir]'s package config.
///
/// The CONFIG rather than a guess at the pub-cache layout: `PUB_CACHE` moves,
/// and a path dependency or an override changes what is loaded without
/// changing the lock's version at all — which is the case this line exists to
/// notice. Returns null when the config is missing or does not name it, and
/// the caller says NOT COMPARED rather than reporting a zero it did not
/// establish.
String? _resolvedRoot(String packageDir, String package) {
  final config = File('$packageDir/.dart_tool/package_config.json');
  if (!config.existsSync()) return null;
  final Map<String, dynamic> decoded;
  try {
    decoded = jsonDecode(config.readAsStringSync()) as Map<String, dynamic>;
  } on FormatException {
    return null;
  }
  for (final entry in (decoded['packages'] as List? ?? const [])) {
    final p = entry as Map<String, dynamic>;
    if (p['name'] != package) continue;
    final rootUri = Uri.parse(p['rootUri'] as String);
    if (rootUri.hasScheme) return Directory.fromUri(rootUri).path;
    return Directory('$packageDir/.dart_tool/${p['rootUri']}').absolute.path;
  }
  return null;
}

/// Whether a resolved package and its equally-numbered sibling hold the same
/// `lib/`, and how confidently that could be established.
String _sameVersionVerdict(
  String packageDir,
  LockedPackage entry,
  Directory sibling,
) {
  final root = _resolvedRoot(packageDir, entry.name);
  if (root == null) {
    return 'in step by version (lib/ NOT COMPARED — the package config does '
        'not name ${entry.name})';
  }
  final resolved = Directory('$root/lib');
  final tree = Directory('${sibling.path}/lib');
  if (!resolved.existsSync() || !tree.existsSync()) {
    return 'in step by version (lib/ NOT COMPARED — one side is absent)';
  }
  final differing = _differingFiles(resolved, tree);
  if (differing == 0) return 'in step';
  return 'SAME VERSION, $differing FILE(S) DIFFER — the sibling was edited '
      'without a version bump, so every version-based check reads it as in '
      'step';
}

/// The number of files under [a] and [b] that differ or exist on one side.
int _differingFiles(Directory a, Directory b) {
  Map<String, File> index(Directory root) {
    final prefix = '${root.path}${Platform.pathSeparator}';
    return {
      for (final f in root.listSync(recursive: true).whereType<File>())
        if (f.path.startsWith(prefix)) f.path.substring(prefix.length): f,
    };
  }

  final left = index(a);
  final right = index(b);
  var differing = 0;
  for (final path in {...left.keys, ...right.keys}) {
    final x = left[path];
    final y = right[path];
    if (x == null || y == null) {
      differing++;
      continue;
    }
    if (x.readAsBytesSync().length != y.readAsBytesSync().length ||
        x.readAsStringSync() != y.readAsStringSync()) {
      differing++;
    }
  }
  return differing;
}

/// The attribution header for one corpus run, one line per fact.
///
/// [parentDir] is the twin being run and [appDir] its companion app, both as
/// the runner sees them (the runner `cd`s to the package root first).
List<String> runAttributionLines({
  required String parentDir,
  required String appDir,
  required String runId,
  required DateTime startedAt,
}) {
  final identity = readPubspecIdentity(parentDir);
  return [
    '${attributionPrefix}run: $runId',
    // Seconds precision: a corpus run takes minutes, and the microseconds
    // `toIso8601String` emits only make two headers harder to compare by eye.
    '${attributionPrefix}started: '
        '${startedAt.toIso8601String().split('.').first}',
    '${attributionPrefix}package: ${identity.name ?? '<unnamed>'} '
        '${identity.version ?? '<unversioned>'}',
    '${attributionPrefix}app: $appDir',
    ..._resolvedLines('resolved', parentDir),
    ..._resolvedLines('app-resolved', appDir, alsoInclude: identity.name),
    ..._workingTreeLines('tree', parentDir),
  ];
}

/// Writes the notable working-tree lines to STDERR, so a sweep says out loud
/// which interpreter it is about to certify.
///
/// STDERR SPECIFICALLY, and that is the whole mechanism. Every runner — six
/// shell scripts and six PowerShell ones across the two twins — redirects only
/// this program's STDOUT into `metrics.txt`. Writing the summary to stderr
/// therefore reaches the console of all twelve without editing any of them,
/// and keeps the header in the file byte-for-byte what it was, which is what
/// `scd164_run_attribution_test.dart` and the `Verification runs` table read.
///
/// Only DRIFT is announced. A sweep whose resolutions are all in step prints
/// nothing here, because a banner that appears every run is one nobody reads
/// by the third time — and the recorded header still carries the full picture
/// for anyone who wants it.
void _announceDrift(List<String> lines) {
  final drifted = [
    for (final line in lines)
      if (line.startsWith('${attributionPrefix}tree: ') &&
          !line.endsWith('— in step'))
        line.substring(attributionPrefix.length),
  ];
  if (drifted.isEmpty) return;
  stderr.writeln(
    'ATTRIBUTION: this run does NOT measure the working tree for '
    '${drifted.length} package(s):',
  );
  for (final line in drifted) {
    stderr.writeln('  $line');
  }
  stderr.writeln(
    '  This is expected — the twins resolve the interpreter from pub.dev so '
    'the corpus certifies what a consumer gets. Quote these versions in the '
    '`Verification runs` entry rather than recalling them.',
  );
}

/// Prints the header for `<parentDir> <appDir> <runId>`.
///
/// Never exits non-zero and never throws: a run whose attribution failed is
/// still a run worth having, and the failure is recorded in the header itself
/// rather than aborting sixteen minutes of corpus.
void main(List<String> args) {
  try {
    if (args.length < 3) {
      stdout.writeln(
        '${attributionPrefix}attribution: FAILED — expected '
        '<parentDir> <appDir> <runId>, got ${args.length} argument(s)',
      );
      return;
    }
    final lines = runAttributionLines(
      parentDir: args[0],
      appDir: args[1],
      runId: args[2],
      startedAt: DateTime.now(),
    );
    stdout.writeAll(lines, '\n');
    stdout.writeln();
    _announceDrift(lines);
  } catch (e) {
    stdout.writeln('${attributionPrefix}attribution: FAILED — $e');
  }
}
