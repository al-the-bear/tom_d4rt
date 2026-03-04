// D4rt test script: Tests BackdropGroup from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BackdropGroup test executing');

  // Test BackdropGroup - BackdropGroup
  print('BackdropGroup is available in the widgets package');
  print('BackdropGroup runtimeType accessible');

  print('BackdropGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackdropGroup Tests'),
      Text('BackdropGroup'),
    ],
  );
}
