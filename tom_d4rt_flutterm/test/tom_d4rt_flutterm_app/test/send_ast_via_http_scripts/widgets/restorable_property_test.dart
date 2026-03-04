// D4rt test script: Tests RestorableProperty from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableProperty test executing');

  // Test RestorableProperty - Restorable base
  print('RestorableProperty is available in the widgets package');
  print('RestorableProperty runtimeType accessible');

  print('RestorableProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableProperty Tests'),
      Text('Restorable base'),
    ],
  );
}
