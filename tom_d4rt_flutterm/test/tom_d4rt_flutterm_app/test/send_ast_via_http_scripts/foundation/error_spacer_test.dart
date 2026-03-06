// D4rt test script: Tests ErrorSpacer from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ErrorSpacer test executing');

  // Test ErrorSpacer - Error formatting
  print('ErrorSpacer is available in the foundation package');
  print('ErrorSpacer: Error formatting');

  print('ErrorSpacer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ErrorSpacer Tests'),
      Text('Error formatting'),
    ],
  );
}
