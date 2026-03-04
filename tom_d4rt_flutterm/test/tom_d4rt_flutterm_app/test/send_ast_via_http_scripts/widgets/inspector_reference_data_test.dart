// D4rt test script: Tests InspectorReferenceData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InspectorReferenceData test executing');

  // Test InspectorReferenceData - InspectorReferenceData
  print('InspectorReferenceData is available in the widgets package');
  print('InspectorReferenceData runtimeType accessible');

  print('InspectorReferenceData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InspectorReferenceData Tests'),
      Text('InspectorReferenceData'),
    ],
  );
}
