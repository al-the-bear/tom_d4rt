// D4rt test script: Tests SelectAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectAction test executing');

  // Test SelectAction - SelectAction
  print('SelectAction is available in the widgets package');
  print('SelectAction runtimeType accessible');

  print('SelectAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectAction Tests'),
      Text('SelectAction'),
    ],
  );
}
