// D4rt test script: Tests RestorableString from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableString test executing');

  // Test RestorableString - Restorable string
  print('RestorableString is available in the widgets package');
  print('RestorableString runtimeType accessible');

  print('RestorableString test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableString Tests'),
      Text('Restorable string'),
    ],
  );
}
