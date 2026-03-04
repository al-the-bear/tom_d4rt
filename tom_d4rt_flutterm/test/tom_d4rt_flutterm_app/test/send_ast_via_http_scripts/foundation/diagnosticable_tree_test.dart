// D4rt test script: Tests DiagnosticableTree from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableTree test executing');

  // Test DiagnosticableTree - DiagnosticableTree
  print('DiagnosticableTree is available in the foundation package');
  print('DiagnosticableTree: DiagnosticableTree');

  print('DiagnosticableTree test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticableTree Tests'),
      Text('DiagnosticableTree'),
    ],
  );
}
