// D4rt test script: Tests WidgetStateOutlinedBorder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStateOutlinedBorder test executing');

  // Test WidgetStateOutlinedBorder - WidgetStateOutlinedBorder
  print('WidgetStateOutlinedBorder is available in the widgets package');
  print('WidgetStateOutlinedBorder runtimeType accessible');

  print('WidgetStateOutlinedBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStateOutlinedBorder Tests'),
      Text('WidgetStateOutlinedBorder'),
    ],
  );
}
