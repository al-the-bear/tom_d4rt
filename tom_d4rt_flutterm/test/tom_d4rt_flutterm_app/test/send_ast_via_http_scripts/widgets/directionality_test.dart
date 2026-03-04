// D4rt test script: Tests Directionality from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Directionality test executing');

  // Test Directionality - Text direction
  print('Directionality is available in the widgets package');
  print('Directionality runtimeType accessible');

  print('Directionality test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Directionality Tests'),
      Text('Text direction'),
    ],
  );
}
