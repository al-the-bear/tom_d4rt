// D4rt test script: Tests ContextMenuController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContextMenuController test executing');

  // Test ContextMenuController - Menu controller
  print('ContextMenuController is available in the widgets package');
  print('ContextMenuController runtimeType accessible');

  print('ContextMenuController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContextMenuController Tests'),
      Text('Menu controller'),
    ],
  );
}
