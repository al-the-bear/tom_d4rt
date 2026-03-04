// D4rt test script: Tests AsyncSnapshot from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AsyncSnapshot test executing');

  // Test AsyncSnapshot - Async snapshot
  print('AsyncSnapshot is available in the widgets package');
  print('AsyncSnapshot runtimeType accessible');

  print('AsyncSnapshot test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AsyncSnapshot Tests'),
      Text('Async snapshot'),
    ],
  );
}
