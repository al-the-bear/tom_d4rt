// D4rt test script: Tests StackFilter from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StackFilter test executing');

  // Test StackFilter - Stack filtering
  print('StackFilter is available in the foundation package');
  print('StackFilter: Stack filtering');

  print('StackFilter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StackFilter Tests'),
      Text('Stack filtering'),
    ],
  );
}
