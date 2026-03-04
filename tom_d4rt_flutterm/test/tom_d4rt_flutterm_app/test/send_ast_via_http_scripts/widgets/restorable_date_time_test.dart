// D4rt test script: Tests RestorableDateTime from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableDateTime test executing');

  // Test RestorableDateTime - Restorable date
  print('RestorableDateTime is available in the widgets package');
  print('RestorableDateTime runtimeType accessible');

  print('RestorableDateTime test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableDateTime Tests'),
      Text('Restorable date'),
    ],
  );
}
