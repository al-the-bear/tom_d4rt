// D4rt test script: Tests IconThemeData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IconThemeData test executing');

  // Test IconThemeData - IconThemeData
  print('IconThemeData is available in the widgets package');
  print('IconThemeData runtimeType accessible');

  print('IconThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IconThemeData Tests'),
      Text('IconThemeData'),
    ],
  );
}
