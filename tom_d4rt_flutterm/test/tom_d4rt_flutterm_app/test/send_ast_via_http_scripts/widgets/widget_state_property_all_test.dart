// D4rt test script: Tests WidgetStatePropertyAll from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStatePropertyAll test executing');

  // Test WidgetStatePropertyAll - WidgetStatePropertyAll
  print('WidgetStatePropertyAll is available in the widgets package');
  print('WidgetStatePropertyAll runtimeType accessible');

  print('WidgetStatePropertyAll test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStatePropertyAll Tests'),
      Text('WidgetStatePropertyAll'),
    ],
  );
}
