// ghissues43 — no test in this package changes the process working directory.
//
// `Directory.current` is process-wide, and `dart test` runs the test files of
// a package concurrently in isolates of ONE process. A file that assigns it -
// across an await or between two synchronous statements, since the isolates
// run in parallel threads - moves the working directory of every other file
// running at that moment. Measured 2026-11-11: sce42_source_header_test set
// `Directory.current = pkg` and awaited a generation, and
// `perf/d4rt_perf_test.dart`'s setUpAll, resolving its scripts directory from
// the working directory, failed in the full suite and passed alone. A test that
// needs another working directory runs the code in a subprocess with
// `workingDirectory:`.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// `Directory.current =`, `io.Directory.current =`, but not `==`.
final RegExp _assignment = RegExp(r'\bDirectory\.current\s*=(?!=)');

void main() {
  test('GHI43-1: no file under test/ assigns Directory.current '
      '[2026-11-12]', () {
    final testDir = Directory(p.join(Directory.current.path, 'test'));
    expect(testDir.existsSync(), isTrue, reason: 'run from the package root');

    final offenders = <String>[];
    var scanned = 0;
    for (final entity in testDir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      scanned++;
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        final code = lines[i].split('//').first;
        if (_assignment.hasMatch(code)) {
          offenders.add(
            '${p.relative(entity.path, from: Directory.current.path)}:${i + 1}',
          );
        }
      }
    }

    expect(scanned, greaterThan(50), reason: 'the scan found the test files');
    expect(
      offenders,
      isEmpty,
      reason:
          'these lines move the working directory of every test file '
          'running in this process; run the code in a subprocess with '
          '`workingDirectory:` instead:\n  ${offenders.join('\n  ')}',
    );
  });
}
