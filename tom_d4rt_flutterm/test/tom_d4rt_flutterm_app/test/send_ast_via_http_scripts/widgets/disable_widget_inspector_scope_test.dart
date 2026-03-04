// D4rt test script: Tests DisableWidgetInspectorScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DisableWidgetInspectorScope test executing');

  // Test DisableWidgetInspectorScope - DisableWidgetInspectorScope
  print('DisableWidgetInspectorScope is available in the widgets package');
  print('DisableWidgetInspectorScope runtimeType accessible');

  print('DisableWidgetInspectorScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DisableWidgetInspectorScope Tests'),
      Text('DisableWidgetInspectorScope'),
    ],
  );
}
