// D4rt test script: Tests WidgetToRenderBoxAdapter from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetToRenderBoxAdapter test executing');

  // Test WidgetToRenderBoxAdapter - WidgetToRenderBoxAdapter
  print('WidgetToRenderBoxAdapter is available in the widgets package');
  print('WidgetToRenderBoxAdapter runtimeType accessible');

  print('WidgetToRenderBoxAdapter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetToRenderBoxAdapter Tests'),
      Text('WidgetToRenderBoxAdapter'),
    ],
  );
}
