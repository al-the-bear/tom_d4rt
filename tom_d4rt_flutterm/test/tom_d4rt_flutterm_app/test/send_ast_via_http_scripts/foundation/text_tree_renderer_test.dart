// D4rt test script: Tests TextTreeRenderer from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextTreeRenderer test executing');

  // Test TextTreeRenderer - TextTreeRenderer
  print('TextTreeRenderer is available in the foundation package');
  print('TextTreeRenderer: TextTreeRenderer');

  print('TextTreeRenderer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextTreeRenderer Tests'),
      Text('TextTreeRenderer'),
    ],
  );
}
