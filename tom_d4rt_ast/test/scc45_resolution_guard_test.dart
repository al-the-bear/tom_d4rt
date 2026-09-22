// REPO-WIDE GUARD (tom_d4rt_ast) — no package in the repo resolves a tom_* version behind one already in the pub cache.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt_ast's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
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
// THE REMEDY IS A TOOL, AND THEY SHARE ONE DEFINITION (SCD206)
//
// F-SCC45-2 used to end at "run `dart pub upgrade` (or `flutter pub upgrade`)
// in the package". Clearing it once, on this machine, was forty-one findings
// across twenty-nine packages, each classified by hand as a Dart or a Flutter
// package by reading its path back to its kind. That work is per-machine —
// the locks are gitignored — and it recurs on every fleet host after every
// publish, which this quest does often. A check whose remedy costs that much
// is one people switch off rather than act on, which is how a guard stops
// being a guard.
//
// `tool/upgrade_stale_locks.dart` now does it in one command. The walk, the
// lock parse and the version comparison moved to `tool/stale_locks.dart`,
// which this file imports: if the two disagreed about what "behind" means,
// the tool would clear a red the guard still reports, which is worse than
// either alone. That is also why the import points from `test/` into `tool/`
// rather than the reverse — one definition, read in two directions, the same
// arrangement `tom_d4rt_exec/tool/remeasure_pins.dart` uses.
//
// The shared walk now decides what gets UPGRADED and not only what gets
// reported, so F-SCC45-6 and -7 guard the two places a silent miss costs most:
// the companion apps, whose own locks are what the bridge corpus executes
// (SCD193), and the path-linked fixtures, which inherit an upgraded host's
// SOURCE while resolving their own dependencies. The tool's first sweep
// cleared F-SCC45-2 and turned `G-PARITY-EX[d4_test_scripts]` red in
// `tom_d4rt_generator` doing exactly that.
//
// EVERY ONE OF THEM HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                  | Fires          |
//   | ----------------------------------------------- | -------------- |
//   | `packagesUnder` depth limit lowered 5 → 2        | -6, walk 17    |
//   | `isFlutterPackage` guesses from the path         | -6, both apps  |
//   | `pathLinkedDependents` matches `hosted`          | -7, misses `d4`|
//   | its self-exclusion deleted                       | -7, returns d4 |
//
// THE LAST TWO ARE WHY -7 NAMES A PACKAGE RATHER THAN ASSERTING isNotEmpty.
// It was written as an emptiness check first, and NEITHER fault fired:
// `tom_ast_generator` resolves `tom_d4rt_exec` hosted, so a source-blind
// implementation still returns something, and the excluded package is absent
// from an arbitrary result for free.
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
// A PASS IS A STATEMENT ABOUT ONE MACHINE (SCD130)
//
// That one-directionality is a design virtue and also a limit on what green
// means, and the header used to say only the first half. Two facts compound:
//
//   * `pubspec.lock` is gitignored repo-wide, so every fleet host resolved
//     independently, at whatever time it last ran `pub get`. A sweep on one
//     machine touches no other, and no other machine's locks have ever been
//     inspected by anything.
//   * this guard's sensitivity is a property of the machine's CACHE. A host
//     that has downloaded little reports green while frozen, in the same words
//     as a host that is genuinely clean — and the hosts least likely to have a
//     warm cache are the same ones least likely to have re-resolved recently.
//
// So the guard is a ratchet on the machine that runs it, never a fleet
// assertion. Two things now stop a green from being read as more than it is.
// Every run PRINTS its own sensitivity — how many `tom_*` versions and packages
// the cache holds — because that number is what makes a pass interpretable and
// nobody collects it by hand. And below [_minimumCachedPackages] the two
// cache-dependent cases SKIP rather than pass, because a green from a machine
// that cannot discriminate is indistinguishable from a real one.
//
// What is still owed is the fleet itself: only mbp has ever produced this
// evidence. SCE147 carries running it on bomber, bigbeast and legiondary01.
//
// NOT FIXED BY CHECKING IN THE LOCK. That trades invisible per-machine drift
// for merge conflicts on generated files across four machines, which is what
// the workspace's generated-file merge policy exists for; DGUC10 refused it for
// the same reason. NOT FIXED BY ASKING PUB.DEV either: a test that touches the
// network is a test that gets disabled the first week it flakes, and the
// offline discriminator is what makes this one cheap enough to leave on.
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
//
// THE SCOPE IS ONE REPO, AND THAT IS NOW A DECISION RATHER THAN A DEFAULT
//
// SCD128 asked whether this guard should be generalised to the whole
// workspace, since the mechanism it guards is not d4rt-specific: every `tom_*`
// package is published to pub.dev, consumed by siblings with the same
// lower-bound-only constraints, and locked behind the same repo-wide
// `pubspec.lock` gitignore.
//
// It was measured before being decided, read-only, with
// `_bin/check_frozen_locks.py` at the workspace root — the same pub-cache
// discriminator as F-SCC45-2, applied to every package under the tree.
// 2026-09-15: **182 frozen resolutions across 117 packages in 13 repos**, and
// that is a floor rather than a count (a cold cache under-reports by
// construction). The d4rt repo's own 44 reproduce this file's current
// F-SCC45-2 output, which is what validates the script.
//
// So the answer is MANY GUARDS, NOT ONE, and not yet. A single guard would
// need one exception list spanning thirteen repos with no single owner, which
// is how an exception list rots; and a guard that lands red in thirteen repos
// is ignored in all thirteen. The order is: sweep a repo, then give that repo
// its own copy of this file with its own owner-named exception list. SCE145
// carries the campaign, and the script is how each repo's owner sees their
// share without running anything of ours.

import 'dart:io';

import 'package:test/test.dart';

// SCD206: the walk, the lock parse and the comparison live in `tool/`,
// because a TOOL now clears what this guard reports and a tool that clears
// a red the guard still reports is worse than either alone. The import
// goes this way round — test reaching into tool — for the same reason
// `tom_d4rt_exec/tool/remeasure_pins.dart` reaches into `test/`: one
// definition, read in two directions.
import '../tool/stale_locks.dart';

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

/// How much this machine's pub cache lets the discriminator see.
///
/// SCD130. F-SCC45-2 and F-SCC45-4 can only report a freeze when a version
/// NEWER than the locked one is already cached, so their sensitivity is a
/// property of the machine, not of the repo. A host that has downloaded little
/// reports green while frozen, in exactly the same words as a host that is
/// genuinely clean — and the hosts least likely to have a warm cache are the
/// same ones least likely to have re-resolved recently, so the two compound.
///
/// These numbers are printed on every run and quoted in the skip reason, so a
/// green result is a bounded claim rather than a word. Measured on mbp
/// 2026-09-15: 52 version directories, 23 distinct packages, 13 of them holding
/// more than one version.
({int versions, int packages, int multiVersion}) _cacheSensitivity() {
  // SCE147: `pubCacheRoot()` rather than a second hand-rolled `$HOME` join.
  // This one honoured neither `PUB_CACHE` nor the Windows default, so on
  // legiondary01 it reported ZERO against a cache holding 60 `tom_*` packages —
  // and the floor below then skipped the two cache-dependent cases with a
  // message telling the reader to run `dart pub get`, which would not have
  // helped. The first time this guard ran off mbp is the first time anyone
  // could have known.
  final cache = Directory('${pubCacheRoot().path}/hosted/pub.dev');
  if (!cache.existsSync()) {
    return (versions: 0, packages: 0, multiVersion: 0);
  }
  final byPackage = <String, int>{};
  for (final entry in cache.listSync().whereType<Directory>()) {
    final dir = entry.path.split(Platform.pathSeparator).last;
    if (!dir.startsWith(ownedPrefix)) continue;
    final dash = dir.lastIndexOf('-');
    if (dash <= 0) continue;
    byPackage.update(dir.substring(0, dash), (n) => n + 1, ifAbsent: () => 1);
  }
  return (
    versions: byPackage.values.fold(0, (a, b) => a + b),
    packages: byPackage.length,
    multiVersion: byPackage.values.where((n) => n > 1).length,
  );
}

/// Below this many distinct cached `tom_*` packages, a pass means nothing.
///
/// Not a guess at the right sensitivity — there is no threshold that makes a
/// cold cache informative. It separates "this machine has resolved this repo"
/// from "this machine has barely resolved anything", which is the only
/// distinction the cache can support. Far below mbp's 23, so it does not fire
/// on a host that works here; well above a fresh clone that has pulled two
/// packages.
const int _minimumCachedPackages = 5;

/// The interpreter packages whose floors F-SCC45-4 holds to the current
/// release. Tool dependencies such as `tom_d4rt_generator` are left out: an
/// example demonstrates running ON the interpreter, and chasing every tool
/// release through every example is churn that buys no truth.
/// The interpreter line, as the set every constraint check here is about.
///
/// `tom_ast_generator` and `tom_ast_model` belong in it for the same reason
/// the three runners do: exec's front end parses with the generator and hands
/// the model's nodes to the interpreter, so a package resolving an old copy of
/// either is running a different pipeline. SCD201 added them when it carreted
/// the libraries; F-SCC45-4 holds the copy surfaces to the same set.
const _interpreterPackages = {
  'tom_d4rt',
  'tom_d4rt_ast',
  'tom_d4rt_exec',
  'tom_ast_generator',
  'tom_ast_model',
};

/// Libraries permitted a non-caret interpreter constraint, keyed
/// `<repo-relative package>:<dependency>`, with the reason.
///
/// One entry, and it is the case the map exists for: a package whose
/// resolution is decided somewhere else. The second half of F-SCC45-5 deletes
/// an entry that stops describing anything.
const Map<String, String> _caretExempt = <String, String>{
  // SCD139 declared `tom_d4rt: any` here because the companion app names
  // `IsolatePermission` directly and needs the dependency visible, with the
  // reasoning that "the parent library pins the interpreter, and a second
  // constraint here would be a second thing to bump".
  //
  // That reasoning was aspirational when it was written — the parent declared
  // `>=1.66.0`, which pins nothing — and SCD201's caret makes it true: the
  // parent now admits one minor line, and `any` cannot widen it. The app is
  // additionally held to resolving exactly what its parent resolves by
  // `companion_app_resolution.dart`, which the harness runs before it launches
  // anything. So this is a deferral to a constraint that exists, not an
  // absence of one.
  'tom_d4rt_flutter/test/tom_d4rt_flutter_test_app:tom_d4rt':
      'defers to the parent library\'s caret; the companion-app resolution '
      'check enforces that they agree',
};

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
/// Hand-rolled for the same reason as [lockedTomPackages]. A dependency with
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

void main() {
  final root = repoRoot();

  group('SCC45/DGUC10: resolutions match declarations', () {
    late List<Directory> packages;

    late ({int versions, int packages, int multiVersion}) cache;

    setUpAll(() {
      packages = root == null ? const [] : packagesUnder(root);
      cache = _cacheSensitivity();
      // SCD130: printed on EVERY run, pass or fail, because the number is what
      // makes a green interpretable and nobody collects it by hand. A fleet
      // host that runs this suite now records its own sensitivity as a side
      // effect of running it.
      // ignore: avoid_print
      print(
        '[SCC45] pub-cache sensitivity on this machine: '
        '${cache.versions} tom_* version directories across '
        '${cache.packages} packages, ${cache.multiVersion} of them holding '
        'more than one version. A pass below is a statement about THIS '
        'machine: the discriminator can only see a freeze whose newer version '
        'is already cached here.',
      );

      // SCD201: the interpreter every package in the repo actually resolves,
      // printed on every run.
      //
      // The problem it answers is the one SCC80 named for tom_d4rt_exec and
      // then left as exec's alone: a suite's result is a statement about an
      // interpreter version, and that version lives in a GITIGNORED lock. It
      // appears in no diff, differs per fleet machine, and nothing said it
      // out loud — so a baseline recorded on one host could not be compared
      // with a run on another, and nobody could tell.
      //
      // ONE TABLE RATHER THAN A PRINT PER PACKAGE, deliberately. Porting
      // F-SCC80-1's printed line into each of the eight consumers would have
      // been eight near-identical files to keep in step, and the eight numbers
      // would still only ever be seen one at a time. The walk that produces
      // this table already exists here for F-SCC45-1 and -2; what it costs is
      // the print.
      //
      // WHAT IT DOES NOT DO, so the gap is stated rather than assumed: it
      // prints when THIS package's suite runs. A session working in
      // `tom_dcli_exec` and running only that suite sees nothing, and for
      // those consumers the committed caret constraint (F-SCC45-5) is the
      // record instead — it names the minor line in a file under version
      // control, which is what the lock never was.
      if (root != null) {
        final rows = <String>[];
        for (final package in packages) {
          final resolved = lockedTomPackages(
            package,
          ).where((r) => _interpreterPackages.contains(r.name)).toList();
          if (resolved.isEmpty) continue;
          rows.add(
            '  ${relativeTo(root, package)}: '
            '${resolved.map((r) => '${r.name} ${r.version} (${r.source})').join(', ')}',
          );
        }
        // ignore: avoid_print
        print(
          rows.isEmpty
              ? '[SCC45] no package in the repo resolves an interpreter — '
                    'either nothing has been `pub get`-ed or the walk found '
                    'nothing. Do not read the cases below as clean.'
              : '[SCC45] interpreter resolved per package '
                    '(${rows.length} packages):\n${rows.join('\n')}',
        );
      }
    });

    /// Whether this machine's cache is warm enough for a verdict to mean
    /// anything, recording why in the skip reason when it is not.
    bool canDiscriminate(String caseName) {
      if (cache.packages >= _minimumCachedPackages) return true;
      markTestSkipped(
        '$caseName cannot answer on this machine: its pub cache holds '
        '${cache.packages} distinct tom_* package(s), below the '
        '$_minimumCachedPackages this check needs to tell a frozen lock from a '
        'current one. A pass here would be indistinguishable from a clean '
        'repo, which is the failure SCD130 recorded — so it skips instead. '
        'Run `dart pub get` across the repo and re-run.',
      );
      return false;
    }

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
        for (final res in lockedTomPackages(package)) {
          if (res.source == 'path' && !declared.contains(res.name)) {
            offenders.add(
              '${relativeTo(root, package)} resolves ${res.name} from path '
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
      if (!canDiscriminate('F-SCC45-2')) return;

      // The walk, the parse and the comparison come from `tool/stale_locks.dart`
      // so that the tool below clears exactly what this reports. Exceptions are
      // keyed on the owning top-level package, so one covers the companion app
      // nested under its `test/` too — those share the corpus run that owns
      // the unfreeze.
      final offenders = staleLocks(
        root,
        exceptions: _frozenLockExceptions,
      ).map((s) => s.toString()).toList();

      expect(
        offenders,
        isEmpty,
        reason:
            'SCC45: `pub get` is lock-preserving, so a lower-bound-only '
            'constraint admits a newer version without ever selecting it. '
            'These locks were passed over by a resolution that had the newer '
            'version on hand.\n'
            'REMEDY, from anywhere inside the repo:\n'
            '  dart run tom_d4rt_ast/tool/upgrade_stale_locks.dart --dry-run\n'
            '  dart run tom_d4rt_ast/tool/upgrade_stale_locks.dart\n'
            'It walks every package under the repo root — nested fixtures and '
            'the companion apps included, each of which carries its own '
            'ignored lock — picks `flutter pub upgrade` or `dart pub upgrade` '
            'from the pubspec, re-measures afterwards rather than trusting '
            'exit codes, and says so on exit when it moved a lock the bridge '
            'corpus depends on. SCD206 added it because doing this by hand '
            'was forty-one findings across twenty-nine packages, and a check '
            'whose remedy costs that much is one people switch off.\n'
            'If the upgrade does NOT move a version, the cause is the other '
            'one: either a CONSTRAINT is holding it there (raise it), or the '
            'sibling working tree has unpublished work (DGUC6) and the fix is '
            'to publish it, not to re-resolve.\n'
            '${offenders.join('\n')}',
      );
    });

    test('F-SCC45-3: every exception is still load-bearing [2026-09-05]', () {
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      // Deliberately measured with NO exceptions applied: the question here is
      // which packages are still frozen, and passing the exception list in
      // would filter out precisely the ones being asked about.
      final stillFrozen = staleLocks(
        root,
      ).map((s) => s.package.split('/').first).toSet();

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
      if (!canDiscriminate('F-SCC45-4')) return;

      final surfaces = _pubspecsUnder(
        root,
      ).where((package) => _isCopySurface(relativeTo(root, package))).toList();
      expect(
        surfaces.map((package) => relativeTo(root, package)),
        containsAll(['tom_d4rt_samples/d4rt_advanced_sample', ..._demoApps]),
        reason: 'the copy-surface discovery found too little to be trusted',
      );

      // Guards the guard: a parser that silently reads nothing reports every
      // copy surface clean. The advanced sample is known to declare one.
      final advanced = surfaces.firstWhere(
        (package) =>
            relativeTo(root, package) ==
            'tom_d4rt_samples/d4rt_advanced_sample',
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
          final newest = newestCachedVersion(name);
          if (floor == null) {
            offenders.add(
              '${relativeTo(root, package)} declares $name "$constraint", which has '
              'no floor at all',
            );
          } else if (newest != null && compareVersions(floor, newest) < 0) {
            offenders.add(
              '${relativeTo(root, package)} declares $name "$constraint" while '
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

    test('F-SCC45-5: every library declares its interpreter with a caret '
        '[2026-09-15] (PASS)', () {
      // SCD201. The other half of SCC45's defect family, and the half a guard
      // can state about the REPOSITORY rather than about one machine.
      //
      // F-SCC45-2 above catches a frozen lock by comparing it against the pub
      // cache, which is the strongest evidence available but is per-machine:
      // it can only see a freeze whose newer version this host happens to have
      // downloaded, so a cold cache reports nothing and a green is a statement
      // about the machine. The constraint is different. It is committed, it is
      // diffable, and `>=0.55.0` against a published 0.65.0 is the same
      // sentence on every host: "any lock at or above 0.55.0 satisfies me
      // forever", which is exactly the licence `pub get`'s lock-preserving
      // behaviour needs to keep an ancient resolution alive.
      //
      // A caret removes the licence rather than detecting its use. `^0.65.0`
      // admits one minor line, so a lock outside it does not resolve at all
      // and `pub get` must move; and because the constraint names a version,
      // the number a run measured is readable from a file under version
      // control instead of from a gitignored lock.
      //
      // WHAT IT COSTS, stated rather than discovered later: every interpreter
      // publish now needs the consumers' constraints bumped. That is the
      // protocol the quest overview already writes for the Flutter twins —
      // "publish the interpreter, bump the twins' constraint, `pub upgrade` in
      // the twin AND its companion app, then re-run" — made true of every
      // consumer instead of two, and F-SCC45-4 imposes the same duty on the
      // copy surfaces already.
      //
      // COPY SURFACES ARE NOT IN SCOPE, and the distinction is not cosmetic.
      // An example or a sample is a file a new user copies, so what it should
      // declare is the floor a reader would write themselves — F-SCC45-4 owns
      // that and holds them to naming the current release. A library is
      // consumed by resolution, not by reading, so what matters is which
      // version it actually gets.
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      final libraries = _pubspecsUnder(
        root,
      ).where((package) => !_isCopySurface(relativeTo(root, package))).toList();

      // Anti-vacuity, in both directions. A walk that finds no libraries
      // reports every one of them compliant, and a constraint parser that
      // reads nothing does the same — so name a package known to declare one
      // rather than trusting the count alone.
      expect(
        libraries.map((package) => relativeTo(root, package)),
        containsAll(['tom_d4rt_exec', 'tom_d4rt_flutter_ast', 'tom_dcli_exec']),
        reason: 'the library discovery found too little to be trusted',
      );
      final exec = libraries.firstWhere(
        (package) => relativeTo(root, package) == 'tom_d4rt_exec',
      );
      expect(
        _declaredInterpreterConstraints(exec),
        contains('tom_d4rt_ast'),
        reason: 'the pubspec scan read no constraint where one is declared',
      );

      final offenders = <String>[];
      for (final package in libraries) {
        final rel = relativeTo(root, package);
        for (final MapEntry(key: name, value: constraint)
            in _declaredInterpreterConstraints(package).entries) {
          if (_caretExempt['$rel:$name'] != null) continue;
          if (constraint.trim().startsWith('^')) continue;
          offenders.add('$rel declares $name "$constraint"');
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'These libraries declare an interpreter with a lower bound rather '
            'than a caret, so a pre-existing lock satisfies them forever and '
            'the version actually measured is invisible in any diff:\n'
            '  ${offenders.join('\n  ')}\n\n'
            'REMEDY: set the caret to the CURRENT PUBLISHED version — not to '
            'the old floor, since `^0.55.0` does not admit 0.65.0 — and run '
            '`dart pub get` (or `flutter pub get`) in the package AND in any '
            'companion app beside it. If a package genuinely needs a range, '
            'record it in _caretExempt with the reason.',
      );

      final stale = _caretExempt.keys.where((key) {
        final parts = key.split(':');
        final package = libraries
            .where((p) => relativeTo(root, p) == parts.first)
            .firstOrNull;
        if (package == null) return true;
        final constraint = _declaredInterpreterConstraints(package)[parts.last];
        return constraint == null || constraint.trim().startsWith('^');
      }).toList();

      expect(
        stale,
        isEmpty,
        reason:
            'These caret exemptions no longer describe anything — the package '
            'is gone, the dependency is gone, or it carries a caret after '
            'all:\n  ${stale.join('\n  ')}\n\n'
            'Delete them. An exemption nobody prunes stops being an exception '
            'and becomes a hole.',
      );
    });

    test('F-SCC45-6: the walk reaches the companion apps, and knows they are '
        'Flutter packages [2026-09-15] (PASS)', () {
      // SCD206. The remedy above is now a tool, and both the guard and the
      // tool take their package list from `packagesUnder`. So this walk
      // decides what gets UPGRADED, not only what gets reported — and the
      // companion apps are the packages where being missed costs the most.
      //
      // Each twin's companion app carries its OWN lock and is what the bridge
      // corpus actually executes. SCD193 exists because upgrading a twin and
      // forgetting its app leaves the corpus measuring the old interpreter
      // while every visible signal says it was upgraded. A walk that skipped
      // them — by depth, by a `test/` prune, or by a special case — would
      // reproduce that silently and the suite would stay green.
      //
      // The Flutter classification is the second half: `dart pub upgrade` in
      // a Flutter package fails, so an app misclassified as a Dart package is
      // reported as an upgrade FAILURE rather than silently skipped. Pinning
      // it here keeps the reason readable, since the classification is read
      // from the pubspec and a path-based guess would get these two wrong —
      // nothing about `.../test/tom_d4rt_flutter_ast_app` says Flutter.
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      const apps = [
        'tom_d4rt_flutter/test/tom_d4rt_flutter_test_app',
        'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app',
      ];

      final walked = {for (final p in packages) relativeTo(root, p): p};
      expect(
        walked.keys,
        containsAll(apps),
        reason:
            'The shared walk in `tool/stale_locks.dart` did not reach a '
            'companion app. It walked ${walked.length} packages:\n'
            '  ${walked.keys.take(40).join('\n  ')}\n\n'
            'Both `upgrade_stale_locks.dart` and F-SCC45-2 take their package '
            'list from it, so an app outside the walk is an app that never '
            'gets upgraded AND never gets reported — which is exactly the '
            'state SCD193 was filed about. Check the depth limit and the '
            'pruned directory names in `packagesUnder`.',
      );

      for (final app in apps) {
        expect(
          isFlutterPackage(walked[app]!),
          isTrue,
          reason:
              '$app was not recognised as a Flutter package, so '
              '`upgrade_stale_locks.dart` would run `dart pub upgrade` in it '
              'and that fails. The classification reads `sdk: flutter` out of '
              'the pubspec — check it is still declared there.',
        );
      }
    });

    test('F-SCC45-7: the path-linked fixtures of an upgraded package are '
        'reachable [2026-09-15] (PASS)', () {
      // SCD206, second half. `upgrade_stale_locks.dart` moves a package and
      // then re-resolves the fixtures that reach it by `path:`, because a
      // fixture inherits its host's SOURCE while resolving its OWN
      // dependencies — move the host and the fixture goes on compiling the new
      // `lib/` against the old third-party versions. The tool's first sweep
      // did exactly that and turned `G-PARITY-EX[d4_test_scripts]` red in
      // `tom_d4rt_generator` while clearing F-SCC45-2 here.
      //
      // WHY THIS CASE EXISTS AT ALL: once the repo is clean the second pass
      // never runs, so nothing exercises `pathLinkedDependents` on a green
      // tree. A silently-empty result would make the pass a no-op that reads
      // as working. `tom_d4rt_exec` is the anchor because its examples reach
      // it by `path:` — the per-package print in setUpAll shows them.
      if (root == null) {
        markTestSkipped('d4rt repo root not reachable — nothing to check');
        return;
      }

      // A NON-EMPTY RESULT IS NOT ENOUGH, and two ablations proved it:
      // flipping the source test from `path` to `hosted`, and deleting the
      // self-exclusion, both left an emptiness check passing.
      // `tom_ast_generator` resolves tom_d4rt_exec as HOSTED, so a
      // source-blind implementation still returns something. The named pair
      // below is what separates them.
      final dependents = pathLinkedDependents(root, {
        'tom_d4rt_exec',
      }).map((p) => relativeTo(root, p)).toList();

      expect(
        dependents,
        contains('tom_d4rt_exec/example/d4'),
        reason:
            '`pathLinkedDependents` missed a fixture that reaches '
            'tom_d4rt_exec by `path: "../.."`, so the second pass of '
            '`upgrade_stale_locks.dart` is a no-op that reads as working — '
            'the tool would move tom_d4rt_exec and leave this fixture '
            'compiling the new lib/ against its old third-party '
            'resolutions.\n'
            'Found: '
            '${dependents.isEmpty ? '(nothing)' : dependents.join(', ')}',
      );

      expect(
        dependents,
        isNot(contains('tom_ast_generator')),
        reason:
            'tom_ast_generator resolves tom_d4rt_exec as HOSTED, not by path, '
            'so it does not inherit the working tree and needs no '
            're-resolution. Its presence means the source field is being '
            'ignored — which would make the second pass a repo-wide '
            '`pub upgrade` rather than the targeted repair it is meant to be.',
      );

      // Self-exclusion, asked so the answer cannot be yes by accident: `d4` is
      // in the moved set here AND path-links to tom_d4rt_exec, so an
      // implementation without the exclusion would return it.
      expect(
        pathLinkedDependents(root, {
          'tom_d4rt_exec',
          'd4_example',
        }).map((p) => relativeTo(root, p)),
        isNot(contains('tom_d4rt_exec/example/d4')),
        reason:
            'A package that MOVED is in its own dependent list, so the tool '
            'would upgrade it twice. The exclusion is by pubspec `name:` — '
            '`tom_d4rt_exec/example/d4` declares `name: d4_example`, which is '
            'why it cannot be done on the directory name. Check `packageName` '
            'still reads it.',
      );
    });
  });
}
