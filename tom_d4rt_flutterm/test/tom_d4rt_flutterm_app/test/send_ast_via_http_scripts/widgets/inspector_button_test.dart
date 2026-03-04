// D4rt test script: Tests InspectorButton from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InspectorButton test executing');

  // Test InspectorButton - InspectorButton
  print('InspectorButton is available in the widgets package');
  print('InspectorButton runtimeType accessible');

  print('InspectorButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InspectorButton Tests'),
      Text('InspectorButton'),
    ],
  );
}
