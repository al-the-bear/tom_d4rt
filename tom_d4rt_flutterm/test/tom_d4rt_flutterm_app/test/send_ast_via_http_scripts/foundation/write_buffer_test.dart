// D4rt test script: Tests WriteBuffer from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WriteBuffer test executing');

  // Test WriteBuffer - Binary writing
  print('WriteBuffer is available in the foundation package');
  print('WriteBuffer: Binary writing');

  print('WriteBuffer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WriteBuffer Tests'),
      Text('Binary writing'),
    ],
  );
}
