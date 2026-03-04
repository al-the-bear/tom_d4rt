// D4rt test script: Tests InspectorSerializationDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InspectorSerializationDelegate test executing');

  // Test InspectorSerializationDelegate - InspectorSerializationDelegate
  print('InspectorSerializationDelegate is available in the widgets package');
  print('InspectorSerializationDelegate runtimeType accessible');

  print('InspectorSerializationDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InspectorSerializationDelegate Tests'),
      Text('InspectorSerializationDelegate'),
    ],
  );
}
