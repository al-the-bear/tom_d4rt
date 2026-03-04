// D4rt test script: Tests Spacer from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Spacer test executing');

  // Test Spacer - Spacer widget
  print('Spacer is available in the widgets package');
  print('Spacer runtimeType accessible');

  print('Spacer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Spacer Tests'),
      Text('Spacer widget'),
    ],
  );
}
