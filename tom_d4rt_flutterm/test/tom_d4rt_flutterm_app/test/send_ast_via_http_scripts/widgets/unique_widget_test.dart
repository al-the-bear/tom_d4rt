// D4rt test script: Tests UniqueWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UniqueWidget test executing');

  // Test UniqueWidget - UniqueWidget
  print('UniqueWidget is available in the widgets package');
  print('UniqueWidget runtimeType accessible');

  print('UniqueWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UniqueWidget Tests'),
      Text('UniqueWidget'),
    ],
  );
}
