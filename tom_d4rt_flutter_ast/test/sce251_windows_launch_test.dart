// RUNNER BUCKET: guard — run_guard_tests.sh
/// SCE251: `tool/prepublish_overrides.dart` must be able to launch `flutter` on
/// Windows.
///
/// On Windows `flutter` is `flutter.bat`, and `Process.run` cannot launch a
/// batch file without a shell. Every Flutter package in the repo then fails
/// with "The system cannot find the file specified", while the Dart packages
/// (`dart` is a real `.exe`) go on working and hide it. No fleet host this
/// suite normally runs on is Windows, so the tool itself cannot be exercised
/// there from here; this pins the property in the source instead.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The argument text of every `Process.run(` / `Process.start(` call in
/// [source], from the opening parenthesis to its match.
List<String> processCalls(String source) {
  final calls = <String>[];
  final start = RegExp(r'Process\.(run|start)\(');
  for (final m in start.allMatches(source)) {
    var depth = 1;
    var i = m.end;
    while (i < source.length && depth > 0) {
      final c = source[i];
      if (c == '(') depth++;
      if (c == ')') depth--;
      i++;
    }
    calls.add(source.substring(m.start, i));
  }
  return calls;
}

void main() {
  test('F-SCE251-1: every process the pre-publish pass starts can launch a .bat '
      'on Windows [2026-09-29] (PASS)', () {
    final calls = processCalls(
      File('tool/prepublish_overrides.dart').readAsStringSync(),
    );
    expect(calls, isNotEmpty, reason: 'nothing measured');
    expect(
      [
        for (final c in calls)
          if (!c.contains('runInShell')) c,
      ],
      isEmpty,
      reason:
          'Pass `runInShell: Platform.isWindows` — without it `flutter` (flutter.bat) '
          'cannot be launched on Windows.',
    );
  });

  test('F-SCE251-2: the scanner sees a call without the flag '
      '[2026-09-29] (PASS)', () {
    final calls = processCalls(
      "await Process.run(cmd, ['pub', 'get'], workingDirectory: d);",
    );
    expect(calls.single.contains('runInShell'), isFalse);
  });
}
