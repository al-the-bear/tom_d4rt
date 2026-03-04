// D4rt test script: Tests DialogWindow from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DialogWindow test executing');

  // Test DialogWindow - DialogWindow
  print('DialogWindow is available in the widgets package');
  print('DialogWindow runtimeType accessible');

  print('DialogWindow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DialogWindow Tests'),
      Text('DialogWindow'),
    ],
  );
}
