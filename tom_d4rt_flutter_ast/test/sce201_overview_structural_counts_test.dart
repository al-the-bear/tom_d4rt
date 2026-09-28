// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — the quest overview's structural bridge counts match both twins' trees.
//
// Its subject reaches OUTSIDE this package (the source twin's lib/ and the
// quest overview under _ai/), so it runs only when this package's suite runs.
//
// SCE201. SCD165 removed every version and line count from the overview and
// kept the STRUCTURAL ones — "18 generated bridge files", "4 hand-written
// `D4UserBridge` overrides", "one AST-only user bridge" — because they change
// only when the design does. The overview then says so, in as many words: a
// count that appears is one a reader wants flagged. That is a promise, and a
// nineteenth bridge would have broken it silently, in a sentence that had
// just invited the reader to trust it.
//
// This counts the files in both twins and checks every such statement in the
// overview. It fires almost never, which is what makes it cheap; when it does,
// the design moved and the overview should say so.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'sibling_trees.dart';

const _overview = '../../../_ai/quests/d4rt/overview.d4rt.md';

Set<String> _names(String dir, bool Function(String) keep) => {
  for (final e in Directory(dir).listSync())
    if (e is File && keep(e.uri.pathSegments.last)) e.uri.pathSegments.last,
};

const _words = {'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5};

int _number(String token) => _words[token.toLowerCase()] ?? int.parse(token);

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: "the overview's bridge counts against both twins' lib/",
  );

  final overviewFile = File(_overview);
  final skip = overviewFile.existsSync()
      ? null
      : 'no quest overview at $_overview — this checkout has no _ai mount';

  test('F-SCE201-1: every bridge count the overview states matches both '
      'twins [2026-09-28]', () {
    final text = overviewFile.readAsStringSync().replaceAll(
      RegExp(r'\s+'),
      ' ',
    );
    bool isBridge(String n) => n.endsWith('.b.dart');
    bool isDart(String n) => n.endsWith('.dart');
    final astBridges = _names('lib/src/bridges', isBridge);
    final srcBridges = _names('../tom_d4rt_flutter/lib/src/bridges', isBridge);
    final astUser = _names('lib/src/d4rt_user_bridges', isDart);
    final srcUser = _names(
      '../tom_d4rt_flutter/lib/src/d4rt_user_bridges',
      isDart,
    );

    final wrong = <String>[];
    void claim(String pattern, int actual, String what) {
      final matches = RegExp(pattern).allMatches(text).toList();
      if (matches.isEmpty) {
        wrong.add('no statement matching /$pattern/ ($what) was found');
      }
      for (final m in matches) {
        final stated = _number(m.group(1)!);
        if (stated != actual) {
          wrong.add(
            '"${m.group(0)}" states $stated, the tree has $actual '
            '($what)',
          );
        }
      }
    }

    expect(
      astBridges.length,
      srcBridges.length,
      reason:
          'the twins no longer carry the same number of generated '
          'bridges, so no single count in the overview can describe both: '
          'AST ${astBridges.length}, source ${srcBridges.length}',
    );
    claim(
      r'(\d+) generated bridge',
      astBridges.length,
      'generated `*.b.dart` files per twin',
    );
    claim(
      r'— (\d+) files each',
      astBridges.length,
      'generated `*.b.dart` files per twin',
    );
    claim(
      r'\((\d+) hand-written `D4UserBridge`',
      srcUser.length,
      "the source twin's user bridges",
    );
    claim(
      r'plus (\w+) AST-only user bridge',
      astUser.difference(srcUser).length,
      'user bridges only the AST twin has',
    );

    expect(
      wrong,
      isEmpty,
      reason:
          'The quest overview states a structural count that no longer '
          'matches the tree — $_overview. A structural count moves only when '
          'the design does, which is exactly what a reader should be told: '
          'update the sentence, and say what changed.\n  ${wrong.join('\n  ')}',
    );
  }, skip: skip);
}
