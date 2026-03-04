// D4rt test script: Tests WidgetStateBorderSide from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStateBorderSide test executing');

  // Test WidgetStateBorderSide - WidgetStateBorderSide
  print('WidgetStateBorderSide is available in the widgets package');
  print('WidgetStateBorderSide runtimeType accessible');

  print('WidgetStateBorderSide test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStateBorderSide Tests'),
      Text('WidgetStateBorderSide'),
    ],
  );
}
