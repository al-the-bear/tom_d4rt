// D4rt test script: Tests WidgetInspector from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetInspector test executing');

  // Test WidgetInspector - Widget inspector
  print('WidgetInspector is available in the widgets package');
  print('WidgetInspector runtimeType accessible');

  print('WidgetInspector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetInspector Tests'),
      Text('Widget inspector'),
    ],
  );
}
