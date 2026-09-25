// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every test here that reads a sibling tree declares which package it must run in.
//
// Bannered for the reason scd158 is: its detector is written about sibling
// paths, so SCD129's index reads it as reaching outside. Its SUBJECT is this
// package's own test/ directory.
//
// SCE191.
//
// The copy of `tom_d4rt/test/scd158_structural_guard_anchoring_test.dart` for
// `tom_d4rt_flutter_ast`; the reasoning is there. A test that resolves paths into a SIBLING
// package decides its subject by where it runs: copied into another package it
// does not error, it measures a different tree, and an emptiness check over the
// wrong tree passes. `requirePackage` (in `sibling_trees.dart`) turns that into
// an abort at load time. This file is what stops the call being forgotten: the
// CATEGORY is derived from the code — a test whose source, comments stripped,
// names `../tom_d4rt*` or `../tom_ast*` — and every member must carry the
// DECLARATION.
//
// ONLY THE ABORT TRANSFERS, NOT THE CENSUS. `tom_d4rt_exec`'s F-SCC6-2
// subtracts anchored reference files from a missing-port census because exec
// has a porting corpus to keep one of. Nothing here needs that derivation.
//
// THE FLUTTER PAIR IS WHERE A WRONG COPY CAN ACTUALLY ARISE. `tom_d4rt_flutter`
// carries hand-duplicated copies of most of this package's `test/` files, so a
// guard copied between the twins resolves `../tom_d4rt_flutter` from inside
// `tom_d4rt_flutter` — itself — and measures one tree twice. Measured
// 2026-09-25: none of the anchored files here has a same-named copy in the
// other twin, so each is structurally single-copy in fact as well as by
// declaration, and a hand-copy of one now aborts at load in the twin instead
// of passing over the wrong tree. The shared SCRIPT corpus (SCD141) is a
// different arrangement — one corpus, read through `send_test_runner.dart` by
// design — and is not what this file is about.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'sibling_trees.dart';

/// A path segment naming a sibling package in this repo, written so that this
/// file's own source does not match it.
final RegExp _siblingPath = RegExp(r'\.\./tom_(d4rt|ast)');

/// The declaration a structural guard makes about where it must run.
final RegExp _anchorCall = RegExp(r"requirePackage\(\s*'tom_d4rt_flutter_ast'");

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
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: "this package's own test/ directory",
  );

  final reading = <String>[];
  final unanchored = <String>[];
  final bare = <String>[];
  for (final entity in Directory('test').listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('_test.dart')) continue;
    final raw = entity.readAsStringSync();
    final code = _stripComments(raw);
    if (!_siblingPath.hasMatch(code)) continue;
    reading.add(entity.path);
    final call = RegExp(
      r"requirePackage\(\s*'tom_d4rt_flutter_ast'\s*(,\s*subject:\s*(.*?))?\)",
      dotAll: true,
    ).firstMatch(code);
    if (call == null || !_anchorCall.hasMatch(raw)) {
      unanchored.add(entity.path);
      continue;
    }
    final subject = call.group(2)?.trim().replaceAll(',', '');
    if (subject == null ||
        subject.isEmpty ||
        subject == "''" ||
        subject == '""') {
      bare.add(entity.path);
    }
  }
  reading.sort();
  unanchored.sort();
  bare.sort();

  group('SCE191: a guard that reads a sibling tree says where it must run', () {
    test('F-SCE191-1: every test reading a sibling tree calls requirePackage '
        '[2026-09-25]', () {
      expect(
        unanchored,
        isEmpty,
        reason:
            'These tests resolve paths into a sibling package, so their subject '
            'is decided by WHERE THEY RUN. Copied anywhere else they do not '
            'error — they measure a different tree. Add the declaration as the '
            'first statement of `main()`:\n\n'
            "    requirePackage('tom_d4rt_flutter_ast', subject: '<what it reads>');\n"
            '\n${unanchored.join('\n')}',
      );
    });

    test('F-SCE191-2: every anchor says what it is about [2026-09-25]', () {
      expect(
        bare,
        isEmpty,
        reason:
            'These anchors do not say what the test reads; the subject is the '
            'only per-file record of why the file is single-copy.\n'
            '${bare.join('\n')}',
      );
    });

    test('F-SCE191-3 (control): the scan found the files it asserts over '
        '[2026-09-25]', () {
      // Zero unanchored files is also what a detector that stopped matching
      // reports. Measured 2026-09-25: 13.
      expect(
        reading.length,
        greaterThanOrEqualTo(10),
        reason:
            'Found ${reading.length} tests reading a sibling tree where '
            '13 were measured; the scan has probably stopped matching.',
      );
    });
  });
}
