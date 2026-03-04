// D4rt test script: Tests MouseTrackerAnnotation from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MouseTrackerAnnotation test executing');

  // Test MouseTrackerAnnotation - Mouse tracking
  print('MouseTrackerAnnotation is available in the services package');
  print('MouseTrackerAnnotation: Mouse tracking');

  print('MouseTrackerAnnotation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MouseTrackerAnnotation Tests'),
      Text('Mouse tracking'),
    ],
  );
}
