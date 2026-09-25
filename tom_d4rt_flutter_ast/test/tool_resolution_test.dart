// RUNNER BUCKET: guard — run_guard_tests.sh
/// The corpus harness's tool lookup, pinned to what Windows actually prints.
///
/// The Windows branch of `tool_resolution.dart` only executes on
/// legiondary01, and nothing ran there for as long as the harness asked
/// `which`. These cases replay the `where` output measured on that host, so a
/// regression in the Windows behaviour fails on any machine.
library;

import 'package:flutter_test/flutter_test.dart';

import 'tool_resolution.dart';

void main() {
  group('pickFromPathLookup', () {
    test('TR-01: Windows skips the extensionless bash script `where` lists '
        'first [2026-09-25] (PASS)', () {
      // Verbatim from `where flutter` on legiondary01, Flutter 3.44.6.
      const lines = [
        r'C:\flutter-sdk\flutter\bin\flutter',
        r'C:\flutter-sdk\flutter\bin\flutter.bat',
        '',
      ];
      expect(
        pickFromPathLookup(lines, windows: true),
        r'C:\flutter-sdk\flutter\bin\flutter.bat',
      );
    });

    test('TR-02: Windows prefers the first runnable entry, whatever its '
        'extension [2026-09-25] (PASS)', () {
      expect(
        pickFromPathLookup([
          r'C:\tools\dart',
          r'C:\tools\DART.EXE',
          r'C:\sdk\dart.bat',
        ], windows: true),
        r'C:\tools\DART.EXE',
      );
    });

    test('TR-03: Windows returns null when nothing listed is runnable '
        '[2026-09-25] (PASS)', () {
      expect(
        pickFromPathLookup([
          r'C:\flutter-sdk\flutter\bin\flutter',
        ], windows: true),
        isNull,
      );
    });

    test('TR-04: elsewhere the first line is the answer, as `which` gives it '
        '[2026-09-25] (PASS)', () {
      expect(
        pickFromPathLookup(['/opt/flutter/bin/flutter', ''], windows: false),
        '/opt/flutter/bin/flutter',
      );
      expect(pickFromPathLookup(['', '  '], windows: false), isNull);
    });
  });

  test('TR-05: dart beside flutter is dart.bat on Windows [2026-09-25] '
      '(PASS)', () {
    expect(siblingToolName('dart', windows: true), 'dart.bat');
    expect(siblingToolName('dart', windows: false), 'dart');
  });
}
