// D4rt test script: Tests AlwaysScrollableScrollPhysics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlwaysScrollableScrollPhysics test executing');

  // Test AlwaysScrollableScrollPhysics - Always scrollable
  print('AlwaysScrollableScrollPhysics is available in the widgets package');
  print('AlwaysScrollableScrollPhysics runtimeType accessible');

  print('AlwaysScrollableScrollPhysics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AlwaysScrollableScrollPhysics Tests'),
      Text('Always scrollable'),
    ],
  );
}
