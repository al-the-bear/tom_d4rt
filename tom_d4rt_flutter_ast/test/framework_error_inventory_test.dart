// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — the inventory tool reads the format
// that BOTH twins' corpus harness prints.
//
// Its subject reaches OUTSIDE this package (the sibling twin's
// send_test_runner.dart), so it runs only when tom_d4rt_flutter_ast's suite
// runs. SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
/// `tool/framework_error_inventory.dart`, pinned two ways.
///
/// The parser, against a fixture in the exact shape the harness prints —
/// including the awkward parts: a METRIC line BEFORE its block, CRLF endings
/// from a Windows run, an error whose message continues on unindented lines,
/// and a block that disagrees with its METRIC count.
///
/// The coupling, against the harness itself. The tool reads a print format
/// that lives in two other files; if either twin's `send_test_runner.dart`
/// changed it, the tool would go on printing a plausible inventory with the
/// error texts silently missing. The METRIC half fails loudly on its own (no
/// `[METRIC]` line means exit 65); the block half would not, which is why it is
/// pinned here.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/framework_error_inventory.dart';
import 'sibling_trees.dart';

/// Two log files in run order, in the harness's shape.
const _fileA =
    '00:01 +0: loading test/flutter_extended_01_test.dart\n'
    '[METRIC] script=widgets/a_test.dart testFile=flutter_extended_01_test.dart '
    'sourceChars=10 status=success outputLines=1 frameworkErrors=0 appBodyMs=0\n'
    '00:02 +1: widgets/ b_test.dart\n'
    '[METRIC] script=widgets/b_test.dart testFile=flutter_extended_01_test.dart '
    'sourceChars=10 status=success outputLines=1 frameworkErrors=2 appBodyMs=0\n'
    '\n'
    '  ⚠️  FRAMEWORK ERROR in widgets/b_test.dart (2 error(s)):\n'
    "       type 'dynamic Function(double)' is not a subtype of type 'ValueChanged' of 'onChanged'\n"
    '       A RenderFlex overflowed by 12.5 pixels on the right.\n'
    'The relevant error-causing widget was: Row\n'
    '00:03 +2: widgets/ c_test.dart\n';

const _fileB =
    '[METRIC] script=widgets/c_test.dart testFile=flutter_extended_02_test.dart '
    'status=success frameworkErrors=3 appBodyMs=0\r\n'
    '\r\n'
    '  ⚠️  FRAMEWORK ERROR in widgets/c_test.dart (2 error(s)):\r\n'
    "       type 'dynamic Function(double)' is not a subtype of type 'ValueChanged' of 'onChanged'\r\n"
    '       A RenderFlex overflowed by 3 pixels on the right.\r\n'
    '[METRIC] script=widgets/d_test.dart testFile=flutter_extended_02_test.dart '
    'status=success frameworkErrors=1\r\n'
    '\r\n'
    '  ⚠️  FRAMEWORK ERROR in widgets/d_test.dart (1 error(s)):\r\n'
    "       type 'dynamic Function()' is not a subtype of type 'VoidCallback' of 'onTap'\r\n";

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: 'the inventory tool reads the format',
  );

  final inv = parseLogs({
    'flutter_extended_01_test.log.txt': _fileA,
    'flutter_extended_02_test.log.txt': _fileB,
  });

  group('parseLogs', () {
    test('FEI-01: every METRIC line is a script, in run order, across files '
        '[2026-09-25] (PASS)', () {
      expect(inv.scripts.map((s) => s.script), [
        'widgets/a_test.dart',
        'widgets/b_test.dart',
        'widgets/c_test.dart',
        'widgets/d_test.dart',
      ]);
      expect(inv.scripts.map((s) => s.position), [0, 1, 2, 3]);
      expect(inv.scripts.map((s) => s.count), [0, 2, 3, 1]);
      expect(inv.scripts[2].testFile, 'flutter_extended_02_test.dart');
    });

    test('FEI-02: the counts come from METRIC; the total ignores clean scripts '
        '[2026-09-25] (PASS)', () {
      expect(inv.raising.length, 3);
      expect(inv.total, 6);
    });

    test('FEI-03: a block\'s texts are its first lines only — a continuation '
        'line is not an error [2026-09-25] (PASS)', () {
      expect(inv.scripts[1].texts, [
        "type 'dynamic Function(double)' is not a subtype of type "
            "'ValueChanged' of 'onChanged'",
        'A RenderFlex overflowed by 12.5 pixels on the right.',
      ]);
    });

    test('FEI-04: CRLF from a Windows run parses the same as LF '
        '[2026-09-25] (PASS)', () {
      expect(inv.scripts[3].texts, [
        "type 'dynamic Function()' is not a subtype of type 'VoidCallback' "
            "of 'onTap'",
      ]);
      expect(inv.scripts[3].blockCount, 1);
    });

    test('FEI-05: a block that disagrees with its METRIC count is reported '
        '[2026-09-25] (PASS)', () {
      expect(inv.disagreeing.map((s) => s.script), ['widgets/c_test.dart']);
      expect(
        render(inv, folder: 'x'),
        contains('widgets/c_test.dart: metric=3 block=2'),
      );
    });
  });

  group('render', () {
    test('FEI-06: most-first by default, run order on request '
        '[2026-09-25] (PASS)', () {
      final most = render(inv, folder: 'x');
      final run = render(inv, folder: 'x', runOrder: true);
      expect(
        most.indexOf('widgets/c_test.dart'),
        lessThan(most.indexOf('widgets/b_test.dart')),
      );
      expect(
        run.indexOf('widgets/b_test.dart'),
        lessThan(run.indexOf('widgets/c_test.dart')),
      );
      expect(run, contains('#1      2  widgets/b_test.dart'));
    });

    test('FEI-07: signatures group texts that differ only in numbers, counting '
        'scripts and occurrences [2026-09-25] (PASS)', () {
      final out = render(inv, folder: 'x');
      expect(
        out,
        contains('    2      2  A RenderFlex overflowed by # pixels'),
      );
      expect(
        out,
        contains(
          "    2      2  type 'dynamic Function(double)' is not a subtype",
        ),
      );
      expect(
        out,
        contains('total: 6 error(s) in 3 script(s), 3 distinct signature(s)'),
      );
    });

    test('FEI-08: a clean run says so rather than printing an empty table '
        '[2026-09-25] (PASS)', () {
      final clean = parseLogs({
        'a.log.txt': _fileA.split('\n').take(2).join('\n'),
      });
      expect(render(clean, folder: 'x'), contains('no framework errors'));
    });
  });

  group('the harness still prints what the tool reads', () {
    // The anchors, verbatim from send_test_runner.dart. Each is one token of
    // the format the parser's three regular expressions match.
    const anchors = <String, String>{
      'METRIC line opens with script= then testFile=':
          r"'[METRIC] script=$scriptPath testFile=",
      'METRIC line carries frameworkErrors=':
          r'frameworkErrors=$frameworkErrorCount',
      'block header names the script':
          r"'\n  ⚠️  FRAMEWORK ERROR in $scriptPath '",
      'block header declares its count':
          r"'(${frameworkErrors.length} error(s)):'",
      'each error is indented seven spaces': r"print('       $short')",
    };

    for (final twin in const ['.', '../tom_d4rt_flutter']) {
      test('FEI-09 ($twin): send_test_runner.dart prints every anchor '
          '[2026-09-25] (PASS)', () {
        final source = File(
          '$twin/test/send_test_runner.dart',
        ).readAsStringSync();
        final missing = [
          for (final entry in anchors.entries)
            if (!source.contains(entry.value)) entry.key,
        ];
        expect(
          missing,
          isEmpty,
          reason:
              '$twin/test/send_test_runner.dart no longer prints part of the '
              'format tool/framework_error_inventory.dart reads. Update the '
              "tool's regular expressions and this list together:\n  "
              '${missing.join('\n  ')}',
        );
      });
    }
  });
}
