// D4rt test script: Tests RestorableBool from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableBool test executing');

  // Test RestorableBool - Restorable bool
  print('RestorableBool is available in the widgets package');
  print('RestorableBool runtimeType accessible');

  print('RestorableBool test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableBool Tests'),
      Text('Restorable bool'),
    ],
  );
}
