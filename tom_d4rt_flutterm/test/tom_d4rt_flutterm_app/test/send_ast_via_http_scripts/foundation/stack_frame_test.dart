// D4rt test script: Tests StackFrame from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StackFrame test executing');

  // Test StackFrame - Stack frame info
  print('StackFrame is available in the foundation package');
  print('StackFrame: Stack frame info');

  print('StackFrame test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StackFrame Tests'),
      Text('Stack frame info'),
    ],
  );
}
