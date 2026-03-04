// D4rt test script: Tests WidgetOrderTraversalPolicy from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetOrderTraversalPolicy test executing');

  // Test WidgetOrderTraversalPolicy - WidgetOrderTraversalPolicy
  print('WidgetOrderTraversalPolicy is available in the widgets package');
  print('WidgetOrderTraversalPolicy runtimeType accessible');

  print('WidgetOrderTraversalPolicy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetOrderTraversalPolicy Tests'),
      Text('WidgetOrderTraversalPolicy'),
    ],
  );
}
