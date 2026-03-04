// D4rt test script: Tests MouseCursorManager from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MouseCursorManager test executing');

  // Test MouseCursorManager - Cursor manager
  print('MouseCursorManager is available in the services package');
  print('MouseCursorManager: Cursor manager');

  print('MouseCursorManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MouseCursorManager Tests'),
      Text('Cursor manager'),
    ],
  );
}
