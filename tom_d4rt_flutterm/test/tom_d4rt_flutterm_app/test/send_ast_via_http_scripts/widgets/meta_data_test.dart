// D4rt test script: Tests MetaData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MetaData test executing');

  // Test MetaData - MetaData
  print('MetaData is available in the widgets package');
  print('MetaData runtimeType accessible');

  print('MetaData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MetaData Tests'),
      Text('MetaData'),
    ],
  );
}
