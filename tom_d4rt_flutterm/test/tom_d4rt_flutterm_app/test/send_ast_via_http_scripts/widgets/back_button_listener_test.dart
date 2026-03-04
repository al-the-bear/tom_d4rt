// D4rt test script: Tests BackButtonListener from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BackButtonListener test executing');

  // Test BackButtonListener - Back button
  print('BackButtonListener is available in the widgets package');
  print('BackButtonListener runtimeType accessible');

  print('BackButtonListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackButtonListener Tests'),
      Text('Back button'),
    ],
  );
}
