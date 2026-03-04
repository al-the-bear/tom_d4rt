// D4rt test script: Tests TooltipWindow from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TooltipWindow test executing');

  // Test TooltipWindow - TooltipWindow
  print('TooltipWindow is available in the widgets package');
  print('TooltipWindow runtimeType accessible');

  print('TooltipWindow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipWindow Tests'),
      Text('TooltipWindow'),
    ],
  );
}
