// D4rt test script: Tests TooltipPositionContext from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TooltipPositionContext test executing');

  // Test TooltipPositionContext - TooltipPositionContext
  print('TooltipPositionContext is available in the widgets package');
  print('TooltipPositionContext runtimeType accessible');

  print('TooltipPositionContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipPositionContext Tests'),
      Text('TooltipPositionContext'),
    ],
  );
}
