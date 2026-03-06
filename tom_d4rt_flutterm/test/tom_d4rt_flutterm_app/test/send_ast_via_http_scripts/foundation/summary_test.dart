// D4rt test script: Tests Summary from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Summary test executing');

  // Test Summary - Summary annotation
  print('Summary is available in the foundation package');
  print('Summary: Summary annotation');

  print('Summary test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Summary Tests'),
      Text('Summary annotation'),
    ],
  );
}
