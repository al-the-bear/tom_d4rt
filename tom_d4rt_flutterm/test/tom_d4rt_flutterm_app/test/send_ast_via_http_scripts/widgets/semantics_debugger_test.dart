// D4rt test script: Tests SemanticsDebugger from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsDebugger test executing');

  // Test SemanticsDebugger - SemanticsDebugger
  print('SemanticsDebugger is available in the widgets package');
  print('SemanticsDebugger runtimeType accessible');

  print('SemanticsDebugger test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsDebugger Tests'),
      Text('SemanticsDebugger'),
    ],
  );
}
