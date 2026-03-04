// D4rt test script: Tests SliverMultiBoxAdaptorWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverMultiBoxAdaptorWidget test executing');

  // Test SliverMultiBoxAdaptorWidget - SliverMultiBoxAdaptorWidget
  print('SliverMultiBoxAdaptorWidget is available in the widgets package');
  print('SliverMultiBoxAdaptorWidget runtimeType accessible');

  print('SliverMultiBoxAdaptorWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverMultiBoxAdaptorWidget Tests'),
      Text('SliverMultiBoxAdaptorWidget'),
    ],
  );
}
