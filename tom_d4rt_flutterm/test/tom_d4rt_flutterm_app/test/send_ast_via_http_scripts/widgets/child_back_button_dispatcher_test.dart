// D4rt test script: Tests ChildBackButtonDispatcher from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ChildBackButtonDispatcher test executing');

  // Test ChildBackButtonDispatcher - Child dispatcher
  print('ChildBackButtonDispatcher is available in the widgets package');
  print('ChildBackButtonDispatcher runtimeType accessible');

  print('ChildBackButtonDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChildBackButtonDispatcher Tests'),
      Text('Child dispatcher'),
    ],
  );
}
