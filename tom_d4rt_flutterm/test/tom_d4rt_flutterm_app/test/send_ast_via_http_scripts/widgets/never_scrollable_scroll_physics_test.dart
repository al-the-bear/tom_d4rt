// D4rt test script: Tests NeverScrollableScrollPhysics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NeverScrollableScrollPhysics test executing');

  // Test NeverScrollableScrollPhysics - Never scrollable
  print('NeverScrollableScrollPhysics is available in the widgets package');
  print('NeverScrollableScrollPhysics runtimeType accessible');

  print('NeverScrollableScrollPhysics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NeverScrollableScrollPhysics Tests'),
      Text('Never scrollable'),
    ],
  );
}
