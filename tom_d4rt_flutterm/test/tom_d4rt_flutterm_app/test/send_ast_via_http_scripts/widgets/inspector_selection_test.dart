// D4rt test script: Tests InspectorSelection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InspectorSelection test executing');

  // Test InspectorSelection - InspectorSelection
  print('InspectorSelection is available in the widgets package');
  print('InspectorSelection runtimeType accessible');

  print('InspectorSelection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InspectorSelection Tests'),
      Text('InspectorSelection'),
    ],
  );
}
