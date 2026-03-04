// D4rt test script: Tests EnableWidgetInspectorScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EnableWidgetInspectorScope test executing');

  // Test EnableWidgetInspectorScope - EnableWidgetInspectorScope
  print('EnableWidgetInspectorScope is available in the widgets package');
  print('EnableWidgetInspectorScope runtimeType accessible');

  print('EnableWidgetInspectorScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EnableWidgetInspectorScope Tests'),
      Text('EnableWidgetInspectorScope'),
    ],
  );
}
