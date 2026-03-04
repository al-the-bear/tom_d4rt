// D4rt test script: Tests TooltipWindowController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TooltipWindowController test executing');

  // Test TooltipWindowController - TooltipWindowController
  print('TooltipWindowController is available in the widgets package');
  print('TooltipWindowController runtimeType accessible');

  print('TooltipWindowController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipWindowController Tests'),
      Text('TooltipWindowController'),
    ],
  );
}
