// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

void main() {
  final files = Directory.current
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.result.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  for (final f in files) {
    final name =
        f.uri.pathSegments.last.replaceAll('.result.json', '');
    final tests = <int, _T>{};
    final fails = <_T>[];
    final errors = <_T>[];
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
            if (tname.startsWith('loading ')) continue;
            tests[id] = _T(tname, t['url'] as String?);
          } else if (type == 'testDone') {
            final id = j['testID'] as int;
            final t = tests[id];
            if (t == null) continue;
            final res = j['result'] as String?;
            final hidden = j['hidden'] as bool? ?? false;
            if (hidden) continue;
            if (res == 'failure') fails.add(t);
            if (res == 'error') errors.add(t);
          } else if (type == 'error') {
            final id = j['testID'] as int?;
            final t = id != null ? tests[id] : null;
            if (t != null) {
              t.errMsg ??= (j['error'] as String?) ?? '';
            }
          }
        } catch (_) {}
      }
    } catch (_) {}
    if (fails.isEmpty && errors.isEmpty) continue;
    print('### $name');
    if (fails.isNotEmpty) {
      print('Failures (${fails.length}):');
      for (final t in fails) {
        final src = t.url == null ? '' : ' [${t.url!.split('/').last}]';
        print('  - ${t.name}$src');
      }
    }
    if (errors.isNotEmpty) {
      print('Errors (${errors.length}):');
      for (final t in errors) {
        final src = t.url == null ? '' : ' [${t.url!.split('/').last}]';
        print('  - ${t.name}$src');
      }
    }
    print('');
  }
}

class _T {
  final String name;
  final String? url;
  String? errMsg;
  _T(this.name, this.url);
}
