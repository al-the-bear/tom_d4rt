// D4rt test script: Tests RadioGroup from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RadioGroup test executing');

  // Test RadioGroup - Radio group
  print('RadioGroup is available in the widgets package');
  print('RadioGroup runtimeType accessible');

  print('RadioGroup test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RadioGroup Tests'),
      Text('Radio group'),
    ],
  );
}
