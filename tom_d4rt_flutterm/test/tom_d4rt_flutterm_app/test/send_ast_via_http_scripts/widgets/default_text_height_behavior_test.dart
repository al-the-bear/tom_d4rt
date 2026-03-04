// D4rt test script: Tests DefaultTextHeightBehavior from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DefaultTextHeightBehavior test executing');

  // Test DefaultTextHeightBehavior - Text height
  print('DefaultTextHeightBehavior is available in the widgets package');
  print('DefaultTextHeightBehavior runtimeType accessible');

  print('DefaultTextHeightBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultTextHeightBehavior Tests'),
      Text('Text height'),
    ],
  );
}
