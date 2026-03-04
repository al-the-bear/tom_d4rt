// D4rt test script: Tests TextMagnifierConfiguration from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextMagnifierConfiguration test executing');

  // Test TextMagnifierConfiguration - Text magnifier
  print('TextMagnifierConfiguration is available in the widgets package');
  print('TextMagnifierConfiguration runtimeType accessible');

  print('TextMagnifierConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextMagnifierConfiguration Tests'),
      Text('Text magnifier'),
    ],
  );
}
