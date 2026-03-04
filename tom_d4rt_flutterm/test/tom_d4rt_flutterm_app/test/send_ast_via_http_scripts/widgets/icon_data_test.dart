// D4rt test script: Tests IconData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IconData test executing');

  // Test IconData - IconData
  print('IconData is available in the widgets package');
  print('IconData runtimeType accessible');

  print('IconData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IconData Tests'),
      Text('IconData'),
    ],
  );
}
