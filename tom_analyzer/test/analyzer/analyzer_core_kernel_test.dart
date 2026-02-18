import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../support/analyzer_comparison.dart';

void main() {
  group('TomAnalyzer', () {
    group('core kernel analysis json', () {
      test('should contain all analyzer elements from core kernel', () async {
        final workspaceRoot = _findWorkspaceRoot();
        final rootPath = p.join(workspaceRoot, 'core', 'tom_core_kernel');
        final barrelPath = p.join(rootPath, 'lib', 'tom_core_kernel.dart');
        final jsonPath = p.join(rootPath, 'doc', 'analyzer_analysis.json');

        await compareAnalyzerToJson(
          rootPath: rootPath,
          barrelPath: barrelPath,
          jsonPath: jsonPath,
          packageName: 'tom_core_kernel',
        );
      });
    });
  });
}

String _findWorkspaceRoot() {
  var current = Directory.current;
  while (true) {
    final candidate = File(p.join(current.path, 'tom_workspace.yaml'));
    if (candidate.existsSync()) {
      return current.path;
    }
    final parent = current.parent;
    if (parent.path == current.path) {
      throw StateError('Unable to locate workspace root containing tom_workspace.yaml');
    }
    current = parent;
  }
}
