// REPO-WIDE GUARD (tom_d4rt) — every test that reads a sibling tree declares which package it must run in.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
// SCD158. A test that asserts something about the interpreter SOURCE builds its
// paths relative to the package it runs in. Copied into `tom_d4rt_exec/test`,
// `lib/src/stdlib` resolves to exec's own `lib` — a parsing front end with no
// stdlib adapters — and the test walks an unrelated file set without erroring.
// SCC22's three cases happened to FAIL that way, which is how the category was
// found; that was luck. A guard shaped as "no file under this root does X"
// passes VACUOUSLY over an empty set, and a green vacuous guard is
// indistinguishable from a green real one.
//
// `requirePackage` (in `sibling_trees.dart`) turns that into an abort at load
// time. This file is what stops it being forgotten: the abort only helps a file
// that calls it, and calling it is a line somebody has to remember.
//
// THE TWO RULES INTERLOCK RATHER THAN DUPLICATE. This file derives the CATEGORY
// from the code — a test whose source, comments stripped, names `../tom_d4rt` —
// and requires each member to carry the DECLARATION. `conformance_drift_test`'s
// F-SCC6-2 then derives the category from the declaration instead, and subtracts
// it from the missing-port census. So the census reads a marker a file put there
// on purpose rather than inferring intent from a path literal, and this file is
// what guarantees the marker is present. Neither rule is a copy of the other,
// and a file that gains a sibling path without the call turns THIS red rather
// than quietly re-entering the census.
//
// COMMENTS ARE STRIPPED BEFORE SCANNING. It makes no difference today —
// measured 2026-09-15, thirteen files either way — and it is insurance against
// the failure SCD140 and SCD151 both hit: a detector that reads prose reports
// the paragraph explaining the rule as an instance of breaking it.
//
// THE RULE IS "NAMES A SIBLING TREE", NOT "IS POSITION-DEPENDENT", and the gap
// between those is deliberate. A test that reads its OWN package relative to the
// working directory — `Directory('lib')`, `File('pubspec.yaml')` — is equally
// decided by where it runs. Measured 2026-09-15 there are four such files that
// name no sibling, and reading them is what settled the boundary — not one is a
// defect. `doc/doc_anchors_test.dart` asks "does THIS package's doc match its
// anchors", a question worth asking of whichever package you are in, and its
// exec port answers it correctly there. `scc24_native_name_coverage_test.dart`
// only uses `File('pubspec.yaml')` as a sample NATIVE OBJECT to bridge, which
// is not a structural read at all. `scc73` is unportable for an unrelated
// reason already recorded. And this file is the fourth.
//
// So whether an own-tree reader should be single-copy is a judgement per file,
// and the evidence says the judgement usually goes the other way; whether a
// sibling-tree reader should be is not a judgement at all.
//
// This file is therefore not in its own set — it scans `test/`, names no
// sibling, and matches nothing. It calls `requirePackage` anyway, because the
// judgement for THIS one is clear.
@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// A path segment naming a sibling package in this repo.
final RegExp _siblingPath = RegExp(r'\.\./tom_d4rt');

/// The declaration a structural guard makes about where it must run.
final RegExp _anchorCall = RegExp(r"requirePackage\(\s*'tom_d4rt'");

/// Blanks out comment bodies, preserving offsets and newlines. String literals
/// are skipped so a `//` inside one is not mistaken for a comment.
String _stripComments(String src) {
  final out = src.split('');
  var i = 0;
  while (i < src.length) {
    final c = src[i];
    if (c == "'" || c == '"') {
      final quote = c;
      i++;
      while (i < src.length && src[i] != quote) {
        if (src[i] == r'\') i++;
        i++;
      }
      i++;
    } else if (src.startsWith('//', i)) {
      while (i < src.length && src[i] != '\n') {
        out[i] = ' ';
        i++;
      }
    } else if (src.startsWith('/*', i)) {
      while (i < src.length && !src.startsWith('*/', i)) {
        if (src[i] != '\n') out[i] = ' ';
        i++;
      }
      i += 2;
    } else {
      i++;
    }
  }
  return out.join();
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage('tom_d4rt', subject: "this tree's own test/ directory");

  final reading = <String>[];
  final unanchored = <String>[];
  for (final entity in Directory('test').listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('_test.dart')) continue;
    final raw = entity.readAsStringSync();
    if (!_siblingPath.hasMatch(_stripComments(raw))) continue;
    reading.add(entity.path);
    if (!_anchorCall.hasMatch(raw)) unanchored.add(entity.path);
  }
  reading.sort();
  unanchored.sort();

  group('SCD158: a guard that reads a sibling tree says where it must run', () {
    test('F-SCD158-1: every test reading a sibling tree calls requirePackage '
        '[2026-09-15]', () {
      expect(
        unanchored,
        isEmpty,
        reason:
            'These tests resolve paths into a sibling package, so their subject '
            'is decided by WHERE THEY RUN. Copied anywhere else they do not '
            'error — they measure a different tree, and an emptiness check over '
            'the wrong tree passes.\n\n'
            'Add the declaration as the first statement of `main()`:\n\n'
            "    requirePackage('tom_d4rt', subject: '<what it reads>');\n\n"
            'It is also what `conformance_drift_test`\'s F-SCC6-2 reads to '
            'derive the structurally single-copy set, so a file without it '
            're-enters the missing-port census as an unexplained '
            'gap.\n${unanchored.join('\n')}',
      );
    });

    test('F-SCD158-2 (control): the scan found the files it asserts over '
        '[2026-09-15]', () {
      // A scan that matches nothing passes F-SCD158-1 over an empty list, and
      // this file's subject makes that especially quiet: zero unanchored files
      // is also what a broken detector reports. Measured 2026-09-15: thirteen,
      // and the floor sits below that so a legitimate convergence does not fail
      // while a detector that stopped matching cannot pass.
      expect(
        reading.length,
        greaterThanOrEqualTo(10),
        reason:
            'Found ${reading.length} tests reading a sibling tree where 13 were '
            'measured. Either a great many converged — lower this floor '
            'deliberately — or `_siblingPath` stopped matching, in which case '
            'F-SCD158-1 above is asserting over nothing.',
      );
      expect(
        reading,
        contains('test/scc22_error_handler_site_guard_test.dart'),
        reason:
            'The file SCD157 split out precisely because it reads both stdlib '
            'trees is not in the scan. The walk is not reaching the directory '
            'it thinks it is, or the pattern no longer matches the form those '
            'paths are written in.',
      );
    });
  });
}
