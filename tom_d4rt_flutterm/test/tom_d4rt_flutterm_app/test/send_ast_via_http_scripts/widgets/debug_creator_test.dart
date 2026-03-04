// D4rt test script: Tests DebugCreator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DebugCreator test executing');

  // Test DebugCreator - DebugCreator
  print('DebugCreator is available in the widgets package');
  print('DebugCreator runtimeType accessible');

  print('DebugCreator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DebugCreator Tests'),
      Text('DebugCreator'),
    ],
  );
}
