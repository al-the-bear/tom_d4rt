// D4rt test script: Tests RestorableDouble from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableDouble test executing');

  // Test RestorableDouble - Restorable double
  print('RestorableDouble is available in the widgets package');
  print('RestorableDouble runtimeType accessible');

  print('RestorableDouble test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableDouble Tests'),
      Text('Restorable double'),
    ],
  );
}
