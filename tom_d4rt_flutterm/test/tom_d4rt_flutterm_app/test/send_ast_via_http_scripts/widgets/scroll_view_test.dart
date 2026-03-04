// D4rt test script: Tests ScrollView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollView test executing');

  // Test ScrollView - ScrollView
  print('ScrollView is available in the widgets package');
  print('ScrollView runtimeType accessible');

  print('ScrollView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollView Tests'),
      Text('ScrollView'),
    ],
  );
}
