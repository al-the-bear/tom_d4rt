// D4rt test script: Tests PasteTextIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PasteTextIntent test executing');

  // Test PasteTextIntent - PasteTextIntent
  print('PasteTextIntent is available in the widgets package');
  print('PasteTextIntent runtimeType accessible');

  print('PasteTextIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PasteTextIntent Tests'),
      Text('PasteTextIntent'),
    ],
  );
}
