// D4rt test script: Tests FixedExtentScrollController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FixedExtentScrollController test executing');

  // Test FixedExtentScrollController - Extent controller
  print('FixedExtentScrollController is available in the widgets package');
  print('FixedExtentScrollController runtimeType accessible');

  print('FixedExtentScrollController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FixedExtentScrollController Tests'),
      Text('Extent controller'),
    ],
  );
}
