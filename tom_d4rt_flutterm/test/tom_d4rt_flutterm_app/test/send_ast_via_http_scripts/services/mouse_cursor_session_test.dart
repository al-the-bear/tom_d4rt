// D4rt test script: Tests MouseCursorSession from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MouseCursorSession test executing');

  // Test MouseCursorSession - Cursor session
  print('MouseCursorSession is available in the services package');
  print('MouseCursorSession: Cursor session');

  print('MouseCursorSession test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MouseCursorSession Tests'),
      Text('Cursor session'),
    ],
  );
}
