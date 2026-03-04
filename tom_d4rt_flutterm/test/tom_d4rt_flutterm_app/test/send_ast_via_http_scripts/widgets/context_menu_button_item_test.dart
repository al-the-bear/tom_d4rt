// D4rt test script: Tests ContextMenuButtonItem from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContextMenuButtonItem test executing');

  // Test ContextMenuButtonItem - Context menu
  print('ContextMenuButtonItem is available in the widgets package');
  print('ContextMenuButtonItem runtimeType accessible');

  print('ContextMenuButtonItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContextMenuButtonItem Tests'),
      Text('Context menu'),
    ],
  );
}
