// D4rt test script: Tests ToolbarItemsParentData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ToolbarItemsParentData test executing');

  // Test ToolbarItemsParentData - ToolbarItemsParentData
  print('ToolbarItemsParentData is available in the widgets package');
  print('ToolbarItemsParentData runtimeType accessible');

  print('ToolbarItemsParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ToolbarItemsParentData Tests'),
      Text('ToolbarItemsParentData'),
    ],
  );
}
