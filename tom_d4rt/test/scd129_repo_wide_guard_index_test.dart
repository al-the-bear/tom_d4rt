// REPO-WIDE GUARD (tom_d4rt) — every test whose subject reaches outside its own
// package announces itself, so the set can be found by grep instead of by
// having added the last one.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's
// suite runs. That is the same limitation it documents, and it is deliberate:
// see "WHY THIS LIVES HERE" below.
//
// ─────────────────────────────────────────────────────────────────────────────
//
// SCD129. This repo has accumulated guards whose subject is the REPOSITORY
// rather than the package they sit in — formatting across both mirrored trees,
// resolution across every package and nested fixture, the stdlib twins' code
// identity, whether `doc/` holds runner output. Each was put where it was for a
// good local reason. What was missing is that the arrangement was never written
// down, so it was invisible to everyone except whoever added the last file.
//
// WHY IT MATTERS, in the words of the evidence. SCC45's guard found 17 frozen
// resolutions across 11 packages in 200 ms that a careful manual scan earlier in
// the same session had missed entirely. A guard with that yield which runs only
// by coincidence of which directory you happened to be in is worth its yield
// times the probability somebody was in the right place.
//
// THE TODO SAID THREE; IT WAS TWENTY-SEVEN; IT IS FIFTY-FIVE. The premise that
// they all live in `tom_d4rt_ast` was true when it was written and was already
// false by 2026-09-15 — which is the failure mode a hand-maintained list has,
// and the reason this file exists instead of one.
//
// THE NUMBER DOUBLED IN A WEEK AND NOTHING WENT RED, which is the finding
// SCE146 came back with. The only quantitative check here was a floor of 20
// that a HALVING would still have passed, so it could never see growth — and
// growth is exactly what decides the question SCD129 deferred ("revisit if the
// set keeps growing"). `_bannerCensus` below is one number per package and
// fails on any move in either direction; the counts live there rather than in
// this paragraph, because a figure in prose is what went stale.
//
// FOUR OF THE TWENTY-SEVEN WERE FOUND BY THIS FILE'S FIRST RUN, not by the
// sweep that preceded it: the Flutter twins were outside the set I had thought
// to look in. That is the argument for the convention in one line — a hand
// search finds what it thought to search.
//
// SO THE INDEX IS A CONVENTION, NOT A LIST. Every such file carries a
// `REPO-WIDE GUARD (<package>)` banner in its first lines, and the index is
//
//     grep -rn 'REPO-WIDE GUARD' */test
//
// run from the repo root. Nothing here enumerates them, because an enumeration
// is the thing that goes stale. This file only asserts that the convention
// holds, so a guard added tomorrow is either discoverable or red.
//
// WHY THIS LIVES HERE. `tom_d4rt` is the reference line, so it is the package
// most sessions have open — the todo's own argument for why `tom_d4rt_ast` was
// the wrong sole home. It does not fix the underlying limitation: a session that
// runs no suite at all still reaches nothing. What it fixes is discoverability,
// which is what a documented gate can do and a relocation cannot.
//
// WHAT WAS DELIBERATELY NOT DONE. Not duplicated into the sibling trees: these
// walk the repo root, so two copies would report identically on every run, and
// `mirror_maintenance.md` exists to keep the twins diffable — a file that is
// deliberately identical in both is noise in every future diff. Not moved to a
// repo-level test package either: that costs a package and an entry point to
// solve what a convention plus a grep solves for free.
//
// SCE146 REVISITED THE MOVE AND MEASURED IT CLOSED. Of the 55, only TEN read
// nothing but files off disk. Fifteen import their host package's library —
// `scc24_native_name_coverage` reaches nine private `src/` libraries, which a
// move would have to make public — and thirty-nine import a relative test
// helper (`sibling_trees.dart`, `interpreter_test.dart`,
// `mirror_normalisation.dart`, `port_recipe.dart`, `../tool/*.dart`). So 48 of
// 55 would need a real dependency or a moved helper, and thirteen of them are
// in Flutter packages a plain Dart test package cannot run at all. The move is
// not mechanical, which was the todo's own stated condition for it being
// right. The full reasoning is in the quest overview beside the standing gate.

@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// Ways a test file reaches outside the package it lives in.
///
/// Deliberately syntactic and deliberately incomplete. A reach this misses is a
/// guard that stays untagged, which is a false negative — the safe direction for
/// a ratchet, and the same choice SCC45 made with its pub-cache discriminator.
/// A reach it invents would demand a banner on a file that does not need one,
/// which is how a convention gets switched off.
/// SCE146 widened `_repoRoot\b` to `repoRoot\b`, which is the same signal
/// reaching one file more: `tom_d4rt_exec/test/hosted_drift_test.dart` calls the
/// PUBLIC `repoRoot()` and the private-only pattern could not see it.
///
/// AND MEASURED ONE THAT LOOKED OBVIOUS AND IS WRONG, recorded because the next
/// reader will have the same idea. Importing `sibling_trees.dart` looks like a
/// reach signal — it is the helper that finds sibling trees — and adding it
/// finds five more files. Two of those five are
/// `stdlib/io/sce87_permission_gate_null_handle_test.dart` and
/// `stdlib/stdlib_d4_boundary_test.dart`, which import it ONLY for
/// `requirePackage`, SCD158's anchor. That call says "this test inspects THIS
/// package's own tree and must run here" — the exact opposite of reaching. The
/// signal would have demanded a banner on two files whose banner would be a
/// false statement, which is the failure this list's second paragraph names.
final List<RegExp> _reachSignals = [
  RegExp(r"\.\./tom_\w+"),
  RegExp(r"Directory\('\.\.'\)"),
  RegExp(r'rev-parse'),
  RegExp(r'repoRoot\b'),
];

/// The banner a reaching file must carry, capturing the package it claims.
final RegExp _banner = RegExp(
  r'^// REPO-WIDE GUARD \((\w+)\)',
  multiLine: true,
);

/// How many lines of the file the banner must appear in.
///
/// Twelve rather than "anywhere": a banner buried at line 200 is not an
/// announcement. All of them are written as the file's opening lines.
const int _bannerWindow = 12;

/// How many BANNERED guards each package carries, measured 2026-09-22 (SCE146).
///
/// WHY THE BANNER AND NOT THE DETECTOR is the whole point of this register.
/// `_reachSignals` is syntactic and deliberately incomplete, and the gap is not
/// small: 44 files trip it and **55 carry the banner**. The twelve it cannot see
/// reach by SUBJECT rather than by a path literal — `scd195_registry_collision`
/// in both Flutter twins asserts about a shared registry through an ordinary
/// import; `scc24_native_name_coverage` reaches through nine `package:` URIs.
/// Their authors announced them correctly and no syntactic detector will ever
/// find them. So the detector answers "is an obvious reacher unannounced?" and
/// the banner answers "how many guards are there?", and only the second is a
/// census.
///
/// WHY A COUNT AT ALL, when this file's own header argues against enumerations.
/// It still does — this is not a list of names, which is the thing that goes
/// stale; it is one number per package, and the failure message says to update
/// it. The argument FOR it is measured: SCD129 recorded 27 on 2026-09-15 and
/// there are 55 a week later. The set doubled with nothing noticing, while the
/// only quantitative check in this file was a floor of 20 that a halving would
/// still have passed. A floor cannot see growth, and growth is what decides the
/// question SCD129 deferred.
///
/// UPDATING IT IS THE POINT, not a chore. Adding a guard whose subject is the
/// whole repository is a deliberate act with a cost — it runs only when its
/// package's suite runs — so it should cost one line here.
const Map<String, int> _bannerCensus = {
  'tom_d4rt': 29,
  'tom_d4rt_ast': 6,
  'tom_d4rt_exec': 5,
  'tom_d4rt_flutter': 3,
  'tom_d4rt_flutter_ast': 11,
  'tom_d4rt_generator': 3,
};

/// Sibling packages of `tom_d4rt`, which is this suite's working directory.
List<Directory> _packages() {
  final root = Directory('..');
  if (!root.existsSync()) return const [];
  return [
    for (final entry in root.listSync().whereType<Directory>())
      if (File('${entry.path}/pubspec.yaml').existsSync() &&
          Directory('${entry.path}/test').existsSync())
        entry,
  ];
}

String _name(Directory package) =>
    package.uri.pathSegments.where((s) => s.isNotEmpty).last;

void main() {
  // SCD158: this guard walks THIS repository's sibling packages, so a copy in
  // another one would either find nothing or index a different repository.
  // SCD200: it is also what removes the file from tom_d4rt_exec's conformance
  // census — a port there would index the same repository a second time, which
  // is duplication rather than coverage.
  requirePackage(
    'tom_d4rt',
    subject: 'every test in this repository that reaches outside its package',
  );

  if (!Directory('..').existsSync()) {
    test('SCD129: skipped — no sibling packages reachable', () {}, skip: true);
    return;
  }

  group('SCD129: a repo-wide guard announces itself', () {
    late List<String> reaching;
    late List<String> unannounced;
    late Map<String, int> bannered;

    setUp(() {
      reaching = <String>[];
      unannounced = <String>[];
      bannered = <String, int>{};
      for (final package in _packages()) {
        final packageName = _name(package);
        final tests = Directory('${package.path}/test');
        for (final entity in tests.listSync(recursive: true)) {
          if (entity is! File || !entity.path.endsWith('_test.dart')) continue;
          // A companion app or fixture nested under `test/` is its own package
          // and its tests are not this repo's guards.
          if (entity.path.contains('/test/') &&
              File('${entity.parent.path}/../pubspec.yaml').existsSync() !=
                  false &&
              entity.path.split('/test/').length > 2) {
            continue;
          }
          final source = entity.readAsStringSync();
          if (_banner.hasMatch(
            source.split('\n').take(_bannerWindow).join('\n'),
          )) {
            bannered[packageName] = (bannered[packageName] ?? 0) + 1;
          }
          if (!_reachSignals.any((r) => r.hasMatch(source))) continue;
          final relative =
              '$packageName/test/${entity.path.split('/test/').last}';
          reaching.add(relative);

          final head = source.split('\n').take(_bannerWindow).join('\n');
          final match = _banner.firstMatch(head);
          if (match == null) {
            unannounced.add('$relative: no REPO-WIDE GUARD banner');
          } else if (match.group(1) != packageName) {
            unannounced.add(
              '$relative: banner says (${match.group(1)}), file lives in '
              '$packageName',
            );
          }
        }
      }
    });

    test('F-SCD129-1: every test reaching outside its package carries the '
        'banner, naming its own package [2026-09-15]', () {
      expect(
        unannounced,
        isEmpty,
        reason:
            'These tests assert something about code they do not live beside, '
            'and nothing says so. A reader in another package has no way to '
            'learn they exist, and they run only when this one package\'s '
            'suite runs. Add the banner as the file\'s opening lines:\n\n'
            '    // REPO-WIDE GUARD (<package>) — <what it asserts>.\n\n'
            'If the file does NOT belong in the set — it merely mentions a '
            'sibling path in prose — that is a finding about the detector, not '
            'about the file: narrow `_reachSignals` rather than adding a '
            'banner that claims something untrue.\n'
            '${unannounced.join('\n')}',
      );
    });

    test('F-SCE146-1: the banner census still matches the repository '
        '[2026-09-22]', () {
      // WHAT REPLACED A FLOOR, and why. F-SCD129-2 below asserted only that the
      // detector found at least 20 files against 27 measured — which cannot see
      // GROWTH, and growth is what happened: 55 bannered guards a week later,
      // more than double, with nothing red at any point. The question SCD129
      // deferred ("revisit if the set keeps growing") had its trigger fire
      // twice over before anyone looked, because nothing was counting.
      expect(
        bannered,
        equals(_bannerCensus),
        reason:
            'The repo-wide guard census has moved. Update _bannerCensus, and '
            'read the number before you do: a guard added here runs ONLY when '
            'its own package suite runs, so each one widens the gap between '
            'what this repository checks and what any one session reaches. '
            'That is the cost the count exists to keep visible.\n'
            'measured: $bannered\nrecorded: $_bannerCensus',
      );
    });

    test('F-SCD129-2 (control): the scan finds the set it is asserting over '
        '[2026-09-15]', () {
      // A source scan that matches nothing passes every assertion built on it.
      // This file's own subject makes that failure especially quiet: an empty
      // scan reads as "no repo-wide guards exist", which is the state SCD129
      // was filed about.
      //
      // SCE146 kept this as the DETECTOR's control and moved the census to
      // F-SCE146-1. The two measure different things and the gap between them
      // is large — 44 detected against 55 bannered — so one number cannot be
      // both. The floor stays slack on purpose: its job is to catch a detector
      // that stopped matching, not to track the set.
      expect(
        reaching.length,
        greaterThanOrEqualTo(20),
        reason:
            'The reach detector found ${reaching.length} files where 44 were '
            'measured on 2026-09-22. Either a large number of guards were '
            'removed — in which case lower this floor deliberately — or the '
            'detector stopped matching, in which case F-SCD129-1 above is '
            'passing over nothing.\n${reaching.join('\n')}',
      );
    });
  });
}
