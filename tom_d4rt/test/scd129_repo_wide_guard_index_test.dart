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
// THE TODO SAID THREE; IT IS TWENTY-SEVEN, ACROSS SIX PACKAGES. Measured
// 2026-09-15: 15 in `tom_d4rt`, 3 in `tom_d4rt_ast`, 4 in `tom_d4rt_exec`, 2 in
// `tom_d4rt_generator`, 2 in `tom_d4rt_flutter_ast`, 1 in `tom_d4rt_flutter`.
// The premise that they all live in `tom_d4rt_ast` was true when it was written
// and is not now — which is precisely the failure mode a hand-maintained list
// has, and the reason this file exists instead of one.
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
// solve what a convention plus a grep solves for free. Revisit if the set stops
// fitting in one grep.

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
final List<RegExp> _reachSignals = [
  RegExp(r"\.\./tom_\w+"),
  RegExp(r"Directory\('\.\.'\)"),
  RegExp(r'rev-parse'),
  RegExp(r'_repoRoot\b'),
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

    setUp(() {
      reaching = <String>[];
      unannounced = <String>[];
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

    test('F-SCD129-2 (control): the scan finds the set it is asserting over '
        '[2026-09-15]', () {
      // A source scan that matches nothing passes every assertion built on it.
      // This file's own subject makes that failure especially quiet: an empty
      // scan reads as "no repo-wide guards exist", which is the state SCD129
      // was filed about. 27 were measured; the floor is set below that so a
      // legitimate removal does not fail, and far enough above zero that a
      // broken detector cannot pass.
      expect(
        reaching.length,
        greaterThanOrEqualTo(20),
        reason:
            'The reach detector found ${reaching.length} files where 27 were '
            'measured on 2026-09-15. Either a large number of guards were '
            'removed — in which case lower this floor deliberately — or the '
            'detector stopped matching, in which case F-SCD129-1 above is '
            'passing over nothing.\n${reaching.join('\n')}',
      );
    });
  });
}
