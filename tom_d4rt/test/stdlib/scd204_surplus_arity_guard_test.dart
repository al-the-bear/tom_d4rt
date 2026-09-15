// REPO-WIDE GUARD (tom_d4rt) — the stdlib adapters SCD204 closed stay closed, in both interpreter trees.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's
// suite runs and a session working elsewhere in the repo reaches none of it.
// SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD204 — a surplus argument is discarded in silence, and what a guard is.
//
// THE DEFECT. A hand-written stdlib adapter reads `positionalArgs[0]`,
// `positionalArgs[1]`, … and returns. Pass one argument too many and the
// surplus is DISCARDED: `list.skip(2, 3)` runs `skip(2)` and the script author
// is told nothing. SCC85 closed 443 adapters across 49 files with
// `D4.checkArity(positionalArgs, 'Class.member', atMost: N)`, and left a
// residue of 23 across three files it deliberately did not guess at. SCD204
// closed those three: 49 adapters per tree, and 13 typed-data bridges now pass
// their own name through `inheritedListMethods`, because a helper shared by
// thirteen classes has none to report at the point an adapter is written.
//
// WHAT THIS FILE ASSERTS, and the restraint is the point. It checks that every
// argument-reading adapter in those three files carries an EXPLICIT
// `D4.checkArity(…, atMost:)` bound. It does NOT try to decide, for the rest of
// the stdlib, whether an adapter is guarded — because that question is harder
// than it looks and BOTH obvious answers are wrong. Each was written, run over
// the corpus, and rejected here:
//
//   "contains a length test that can REJECT"  — SCC85's applier rule.
//       Counts `if (positionalArgs.length < 2) throw …` as a guard. That
//       rejects a too-FEW call; it cannot fire on a surplus. This is why the
//       residue was recorded as 23.
//
//   "contains a length comparison that fires ABOVE the index read"
//       Counts `positionalArgs.length > 1 ? positionalArgs[1] : Endian.big`
//       as a guard. That is optional-argument handling — it yields a value,
//       it does not reject, and the adapter still discards a third argument.
//       Measured: this rule reported `typed_data/byte_data.dart` as entirely
//       clean when all 16 of its argument-reading adapters drop a surplus.
//
// A correct answer has to establish BOTH that the condition can be true when
// the length exceeds the highest index read AND that the branch it selects
// throws — a reachability question over an arbitrary condition. Answering it
// is sce245; answering it WRONGLY is worse than not answering, because the
// number it produces is then quoted as a residue.
//
// SO THE CEILING BELOW IS A CEILING AND SAYS SO. 566 adapters per tree read an
// index without an explicit bound. Some of them are correctly guarded by a
// hand-written test this scan cannot recognise. What the number is good for is
// NOT GROWING: an adapter written today without a bound is a failure here
// rather than an increment nobody sees.
//
// WHY `atMost` AND NOT `exactly`. An `atMost` bound cannot fire on a too-few
// call, so the generic `D4.describeArityError` diagnostic keeps that half —
// which is what let SCC85 land 526 guards per tree without repointing a single
// SCB28 case. F-SCC85-4 pins the property.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                             | Fires |
//   | ----------------------------------------------------------- | ----- |
//   | a bound deleted from `set_algebra_methods.dart`              | 2     |
//   | the same deleted from the TWIN's copy only                   | 2     |
//   | a new unguarded adapter added outside the three files        | 3     |
//   | the twin's stdlib root pointed at a path that is not there   | 1     |
//
// THE SECOND ROW IS WHY F-SCD204-2 NAMES THE PACKAGE. A bound present in one
// tree and missing in the other is the mirror rule broken; SCD49 reports the
// same thing as a token divergence, which is harder to read back to a cause.

import 'dart:io';

import 'package:test/test.dart';

import '../sibling_trees.dart';

/// The two stdlib roots, keyed by the package they belong to.
const _stdlibRoots = <String, String>{
  'tom_d4rt': 'lib/src/stdlib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
};

/// The files SCD204 closed, relative to each stdlib root.
const _closedFiles = <String>[
  'typed_data/inherited_list_methods.dart',
  'collection/set_algebra_methods.dart',
  'io/socket.dart',
];

/// Argument-reading adapters elsewhere with no explicit bound, per tree, on
/// 2026-09-15.
///
/// A CEILING, not a residue: an adapter counted here may still be correctly
/// guarded by a hand-written test (see the header). Lowering it is good news
/// and has to be recorded in the commit that earns it.
const _noExplicitBoundCeiling = 566;

/// A floor on the adapters examined, so an emptiness assertion over a walk
/// that found nothing cannot read as a pass.
const _minAdaptersScanned = 900;

/// The signature of a bridge adapter closure.
///
/// Instance adapters take `target`; STATIC adapters do not. Missing the second
/// shape reported `io/socket.dart` as holding two unguarded adapters when it
/// held nineteen — the static ones were invisible.
final _adapterSignature = RegExp(
  r'\(\s*visitor\s*,\s*(?:target\s*,\s*)?positionalArgs\s*,\s*namedArgs\s*,'
  r'\s*_\s*\)\s*(?:async\s*)?\{',
);

final _indexRead = RegExp(r'positionalArgs\[(\d+)\]');

final _explicitBound = RegExp(
  r'D4\.checkArity\([^;]*\b(?:atMost|exactly):',
  dotAll: true,
);

/// `(argumentReadingAdapters, thoseWithoutAnExplicitBound)` for one source.
(int, int) _scan(String source) {
  var adapters = 0;
  var unbounded = 0;
  for (final match in _adapterSignature.allMatches(source)) {
    var depth = 1;
    var i = match.end;
    while (i < source.length && depth > 0) {
      if (source[i] == '{') {
        depth++;
      } else if (source[i] == '}') {
        depth--;
      }
      i++;
    }
    final body = source.substring(match.end, i - 1);
    if (!_indexRead.hasMatch(body)) continue;
    adapters++;
    if (!_explicitBound.hasMatch(body)) unbounded++;
  }
  return (adapters, unbounded);
}

List<File> _dartFilesUnder(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it runs
  // in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt',
    subject: 'the hand-written stdlib adapters in both interpreter trees',
  );

  /// `package -> (adapters, unbounded)` over everything outside [_closedFiles].
  final elsewhere = <String, (int, int)>{};

  /// `package -> file -> adapters without a bound`, for the three closed files.
  final closed = <String, Map<String, int>>{};

  for (final MapEntry(key: package, value: root) in _stdlibRoots.entries) {
    var adapters = 0;
    var unbounded = 0;
    closed[package] = <String, int>{};
    for (final file in _dartFilesUnder(root)) {
      final rel = file.path.substring(root.length + 1);
      final counts = _scan(file.readAsStringSync());
      if (_closedFiles.contains(rel)) {
        if (counts.$2 > 0) closed[package]![rel] = counts.$2;
        continue;
      }
      adapters += counts.$1;
      unbounded += counts.$2;
    }
    elsewhere[package] = (adapters, unbounded);
  }

  test('F-SCD204-1: both stdlib trees were found and walked [2026-09-15] '
      '(PASS)', () {
    // Ordered first, and nothing below means anything until it passes: what
    // follows is an emptiness check and a ceiling, and a walk that found no
    // files satisfies the first while making the second a statement about
    // zero.
    for (final MapEntry(key: package, value: counts) in elsewhere.entries) {
      expect(
        counts.$1,
        greaterThanOrEqualTo(_minAdaptersScanned),
        reason:
            'Only ${counts.$1} argument-reading adapters were found in '
            "$package's stdlib (${_stdlibRoots[package]}). That is not a "
            'finding about the bridges — the walk did not run. The twin is a '
            'sibling checkout in the same `tom_d4rt` repository, and tests are '
            'expected to run with the package root as the working directory.',
      );
    }
  });

  test('F-SCD204-2: every argument-reading adapter in the three files SCD204 '
      'closed carries an explicit bound, in both trees [2026-09-15] '
      '(PASS)', () {
    final offenders = <String>[];
    for (final MapEntry(key: package, value: files) in closed.entries) {
      for (final MapEntry(key: rel, value: count) in files.entries) {
        offenders.add('  $package: $rel — $count without a bound');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason:
          'An adapter in one of these files reads positionalArgs[N] with no '
          'D4.checkArity bound:\n${offenders.join('\n')}\n\n'
          'These three were SCC85\'s residue and SCD204 closed them. Add '
          '`D4.checkArity(positionalArgs, \'Class.member\', atMost: N)` as the '
          'first statement, where N is one past the highest index the adapter '
          'reads. In the two shared-helper files the class arrives as the '
          '`className` parameter and the label is built as '
          '`\'\$className.member\'`, because a helper reused by thirteen '
          'bridges has no single class to name where the adapter is written.\n\n'
          'A `positionalArgs.length > N ? … : …` already in the body is NOT a '
          'bound — that is optional-argument handling, and the adapter behind '
          'it still discards argument N + 1 in silence.',
    );
  });

  test('F-SCD204-3: the stdlib elsewhere has not gained adapters without a '
      'bound [2026-09-15] (PASS)', () {
    for (final MapEntry(key: package, value: counts) in elsewhere.entries) {
      expect(
        counts.$2,
        lessThanOrEqualTo(_noExplicitBoundCeiling),
        reason:
            '$package\'s stdlib has ${counts.$2} argument-reading adapters '
            'with no explicit D4.checkArity bound, against a recorded ceiling '
            'of $_noExplicitBoundCeiling.\n\n'
            'An adapter was written, or edited, without one. Add '
            '`D4.checkArity(positionalArgs, \'Class.member\', atMost: N)`.\n\n'
            'READ THE HEADER BEFORE LOWERING THIS. The number is a CEILING, '
            'not a residue: some of the adapters it counts are correctly '
            'guarded by a hand-written length test this scan does not try to '
            'recognise, because both obvious ways of recognising one are '
            'wrong. Lower it in the commit that earns it, never to make a red '
            'go away.',
      );
    }
  });
}
