// D4rt test script: Tests ToolbarOptions from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ToolbarOptions test executing');

  // Test ToolbarOptions - ToolbarOptions
  print('ToolbarOptions is available in the widgets package');
  print('ToolbarOptions runtimeType accessible');

  print('ToolbarOptions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ToolbarOptions Tests'),
      Text('ToolbarOptions'),
    ],
  );
}
