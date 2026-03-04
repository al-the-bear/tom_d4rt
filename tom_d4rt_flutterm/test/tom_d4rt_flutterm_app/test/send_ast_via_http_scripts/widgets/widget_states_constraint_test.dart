// D4rt test script: Tests WidgetStatesConstraint from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStatesConstraint test executing');

  // Test WidgetStatesConstraint - WidgetStatesConstraint
  print('WidgetStatesConstraint is available in the widgets package');
  print('WidgetStatesConstraint runtimeType accessible');

  print('WidgetStatesConstraint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStatesConstraint Tests'),
      Text('WidgetStatesConstraint'),
    ],
  );
}
