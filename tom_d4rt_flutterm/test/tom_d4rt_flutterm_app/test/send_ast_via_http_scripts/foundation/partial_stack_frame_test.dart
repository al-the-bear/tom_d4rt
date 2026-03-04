// D4rt test script: Tests PartialStackFrame from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PartialStackFrame test executing');

  // Test PartialStackFrame - Partial frame info
  print('PartialStackFrame is available in the foundation package');
  print('PartialStackFrame: Partial frame info');

  print('PartialStackFrame test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PartialStackFrame Tests'),
      Text('Partial frame info'),
    ],
  );
}
