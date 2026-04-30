// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  final files = Directory.current
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.result.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  print('| Project | Total | Passed | Failed | Skipped | Errors |');
  print('|---|---:|---:|---:|---:|---:|');
  int gPass = 0, gFail = 0, gSkip = 0, gErr = 0, gTot = 0;
  for (final f in files) {
    final name =
        f.uri.pathSegments.last.replaceAll('.result.json', '');
    int total = 0, passed = 0, failed = 0, skipped = 0, errors = 0;
    final tests = <int, _T>{};
    try {
      final lines = f.readAsLinesSync();
      for (final line in lines) {
        if (line.isEmpty) continue;
        try {
          final j = jsonDecode(line) as Map<String, dynamic>;
          final type = j['type'] as String?;
          if (type == 'testStart') {
            final t = j['test'] as Map<String, dynamic>;
            final id = t['id'] as int;
            final tname = t['name'] as String? ?? '';
            // Skip group/setup/teardown synthetic tests
            if (tname.startsWith('loading ')) continue;
            tests[id] = _T(tname);
            total++;
          } else if (type == 'testDone') {
            final id = j['testID'] as int;
            final t = tests[id];
            if (t == null) continue;
            final res = j['result'] as String?; // success | failure | error
            final hidden = j['hidden'] as bool? ?? false;
            final skipped0 = j['skipped'] as bool? ?? false;
            if (hidden) {
              total--;
              continue;
            }
            if (skipped0) {
              skipped++;
            } else if (res == 'success') {
              passed++;
            } else if (res == 'failure') {
              failed++;
            } else if (res == 'error') {
              errors++;
            }
          }
        } catch (_) {}
      }
    } catch (_) {}
    print('| $name | $total | $passed | $failed | $skipped | $errors |');
    gTot += total;
    gPass += passed;
    gFail += failed;
    gSkip += skipped;
    gErr += errors;
  }
  print('| **TOTAL** | **$gTot** | **$gPass** | **$gFail** | **$gSkip** | **$gErr** |');
}

class _T {
  final String name;
  _T(this.name);
}
