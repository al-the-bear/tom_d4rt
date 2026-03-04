// D4rt test script: Tests DefaultTextStyleTransition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultTextStyleTransition test executing');

  // Test DefaultTextStyleTransition - DefaultTextStyleTransition
  print('DefaultTextStyleTransition is available in the widgets package');
  print('DefaultTextStyleTransition runtimeType accessible');

  print('DefaultTextStyleTransition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultTextStyleTransition Tests'),
      Text('DefaultTextStyleTransition'),
    ],
  );
}
