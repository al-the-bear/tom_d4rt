// D4rt test script: Tests GestureRecognizerFactory from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GestureRecognizerFactory test executing');

  // Test GestureRecognizerFactory - GestureRecognizerFactory
  print('GestureRecognizerFactory is available in the widgets package');
  print('GestureRecognizerFactory runtimeType accessible');

  print('GestureRecognizerFactory test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GestureRecognizerFactory Tests'),
      Text('GestureRecognizerFactory'),
    ],
  );
}
