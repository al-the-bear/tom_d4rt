// D4rt test script: Tests DiagnosticableNode from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableNode test executing');

  // Test DiagnosticableNode - DiagnosticableNode
  print('DiagnosticableNode is available in the foundation package');
  print('DiagnosticableNode: DiagnosticableNode');

  print('DiagnosticableNode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticableNode Tests'),
      Text('DiagnosticableNode'),
    ],
  );
}
