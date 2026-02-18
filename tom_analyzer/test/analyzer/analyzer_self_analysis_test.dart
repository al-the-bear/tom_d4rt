import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/analyzer_comparison.dart';

void main() {
  group('TomAnalyzer', () {
    group('self analysis json', () {
      test('should contain all analyzer elements from the package', () async {
        final rootPath = _findTomAnalyzerRoot();
        final barrelPath = p.join(rootPath, 'lib', 'tom_analyzer.dart');
        final jsonPath = p.join(rootPath, 'doc', 'analyzer_analysis.json');

        await compareAnalyzerToJson(
          rootPath: rootPath,
          barrelPath: barrelPath,
          jsonPath: jsonPath,
          packageName: 'tom_analyzer',
        );
      });
    });
  });
}

String _findTomAnalyzerRoot() {
  final cwd = Directory.current;
  final direct = File(p.join(cwd.path, 'pubspec.yaml'));
  if (direct.existsSync() && direct.readAsStringSync().contains('name: tom_analyzer')) {
    return cwd.path;
  }
  final nested = Directory(p.join(cwd.path, 'tom_analyzer'));
  if (nested.existsSync()) {
    return nested.path;
  }
  var current = cwd;
  while (true) {
    final candidate = File(p.join(current.path, 'tom_analyzer', 'pubspec.yaml'));
    if (candidate.existsSync()) {
      return p.dirname(candidate.path);
    }
    final parent = current.parent;
    if (parent.path == current.path) {
      throw StateError('Unable to locate tom_analyzer package root.');
    }
    current = parent;
  }
}
