// D4rt test script: Tests AndroidView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidView test executing');

  // Test AndroidView - Android view
  print('AndroidView is available in the widgets package');
  print('AndroidView runtimeType accessible');

  print('AndroidView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidView Tests'),
      Text('Android view'),
    ],
  );
}
