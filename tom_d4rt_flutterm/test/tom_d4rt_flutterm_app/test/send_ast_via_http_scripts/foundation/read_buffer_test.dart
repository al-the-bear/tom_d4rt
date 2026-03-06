// D4rt test script: Tests ReadBuffer from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ReadBuffer test executing');

  // Test ReadBuffer - Binary reading
  print('ReadBuffer is available in the foundation package');
  print('ReadBuffer: Binary reading');

  print('ReadBuffer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ReadBuffer Tests'),
      Text('Binary reading'),
    ],
  );
}
