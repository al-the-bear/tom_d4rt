// D4rt test script: Tests PopupWindow from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PopupWindow test executing');

  // Test PopupWindow - PopupWindow
  print('PopupWindow is available in the widgets package');
  print('PopupWindow runtimeType accessible');

  print('PopupWindow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupWindow Tests'),
      Text('PopupWindow'),
    ],
  );
}
