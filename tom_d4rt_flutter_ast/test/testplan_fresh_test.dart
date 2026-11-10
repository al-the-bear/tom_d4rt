// RUNNER BUCKET: guard — run_guard_tests.sh
/// The testplans under `_copilot_guidelines/` are what
/// `tool/testplan_report.dart` writes from the bridges and the corpus, and the
/// priority files it reads name only bridged classes (ghissues20).
///
/// The hand-written plans this replaced drifted: rows marked `scripted` for
/// classes no script used, rows citing scripts that did not exist, rows for
/// classes Flutter does not declare, and a Status column nobody updated
/// (measured 2026-11-10). A generated plan cannot drift in that way, but only
/// if a stale committed copy fails a test - which is what TESTPLAN-1 does.
/// TESTPLAN-3..5 pin what "a script uses a class" means, because that rule is
/// the whole content of the Status column.
///
/// Pure file I/O (no companion app), so safe to run on its own.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/testplan_report.dart';

void main() {
  final root = Directory.current.path;

  group('TESTPLAN: the generated testplans', () {
    late TestplanBuild build;

    setUpAll(() => build = buildTestplans(root));

    test('TESTPLAN-1: every committed plan is what the tool writes, and no '
        'plan is left that the tool does not write [2026-11-10]', () {
      expect(
        [...staleFiles(root, build), ...orphanedPlans(root, build)],
        isEmpty,
        reason:
            'run `dart run tool/testplan_report.dart` and commit what changes '
            '(after a script, a driver, a priority row or the bridges '
            'changed); delete a plan the tool no longer writes',
      );
    });

    test('TESTPLAN-2: every priority row names a bridged class of its own '
        'library, once [2026-11-10]', () {
      expect(build.findings, isEmpty);
    });

    test('TESTPLAN-2b (control): the build covers the bridge set and the '
        'corpus [2026-11-10]', () {
      // Measured 2026-11-10: 2251 names in 16 libraries, 1625 exercised. A
      // build that found almost nothing would make TESTPLAN-1 compare empty
      // files and pass; these floors catch that.
      final plans = build.files.keys
          .where((k) => k.contains('/testplan_'))
          .length;
      expect(plans, greaterThanOrEqualTo(15));
      final summary = build.files.entries
          .firstWhere((e) => e.key.endsWith('flutter_bridge_test_plan.md'))
          .value;
      final total = RegExp(
        r'\| \*\*Total\*\* \| \*\*(\d+)\*\* \| \*\*(\d+)\*\*',
      ).firstMatch(summary);
      expect(total, isNotNull);
      expect(int.parse(total!.group(1)!), greaterThan(2000));
      expect(int.parse(total.group(2)!), greaterThan(1000));
    });
  });

  group('TESTPLAN: what counts as a script using a class', () {
    BridgedName bridged(String name, String library) =>
        BridgedName(name, 'class', library, 'test:$library')
          ..key = library == 'dart_ui' ? '$name@dart_ui' : '$name@$library';
    final byName = {
      'Container': [
        BridgedName('Container', 'class', 'widgets', 'test')..key = 'Container',
      ],
      'Image': [bridged('Image', 'dart_ui'), bridged('Image', 'widgets')],
    };

    test('TESTPLAN-3: a name in a comment, a doc comment or a string does not '
        'use the class; a name in code does [2026-11-10]', () {
      expect(
        usedBridgedKeys('''
import 'package:flutter/material.dart';
/// A demo of [Container].
// Container here too
String s() => 'Container() in a string';
''', byName),
        isEmpty,
      );
      expect(
        usedBridgedKeys('''
import 'package:flutter/material.dart';
dynamic build(BuildContext context) => Container();
''', byName),
        {'Container'},
      );
    });

    test('TESTPLAN-4: a script declaring its own class of the name does not '
        'use the bridged one [2026-11-10]', () {
      expect(
        usedBridgedKeys('''
import 'package:flutter/material.dart';
class Container { const Container(); }
dynamic build(BuildContext context) => const Container();
''', byName),
        isEmpty,
      );
    });

    test('TESTPLAN-5: a name two libraries declare is attributed by how the '
        'script reaches it [2026-11-10]', () {
      expect(
        usedBridgedKeys('''
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
ui.Image? image;
dynamic build(BuildContext context) => Image.asset('a.png');
''', byName),
        {'Image@dart_ui', 'Image@widgets'},
      );
      expect(
        usedBridgedKeys('''
import 'dart:ui';
Image? image;
''', byName),
        {'Image@dart_ui'},
      );
    });
  });
}
