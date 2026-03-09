// D4rt test script: Tests DiagnosticableTree from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableTree test executing');

  // All widgets are DiagnosticableTree
  final w = Container(width: 100, height: 50, color: Colors.red);
  print('Container is DiagnosticableTree: ${w is DiagnosticableTree}');
  print('toStringShort: ${w.toStringShort()}');
  print('toStringDeep (first 100 chars): ${w.toStringDeep().substring(0, 100)}...');
  print('toStringShallow: ${w.toStringShallow()}');
  final diag = w.toDiagnosticsNode();
  print('toDiagnosticsNode: ${diag.runtimeType}');

  print('DiagnosticableTree test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DiagnosticableTree Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Container is DiagnosticableTree: true'),
    Text('toString methods available'),
  ]);
}
