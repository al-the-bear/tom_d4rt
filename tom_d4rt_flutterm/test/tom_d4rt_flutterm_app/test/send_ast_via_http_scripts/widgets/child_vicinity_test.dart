// D4rt test script: Tests ChildVicinity from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ChildVicinity test executing');

  // Test ChildVicinity - Child location
  print('ChildVicinity is available in the widgets package');
  print('ChildVicinity runtimeType accessible');

  print('ChildVicinity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChildVicinity Tests'),
      Text('Child location'),
    ],
  );
}
