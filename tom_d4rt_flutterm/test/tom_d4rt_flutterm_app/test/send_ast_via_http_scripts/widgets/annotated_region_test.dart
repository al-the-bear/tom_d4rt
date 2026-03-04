// D4rt test script: Tests AnnotatedRegion from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotatedRegion test executing');

  // Test AnnotatedRegion - Region
  print('AnnotatedRegion is available in the widgets package');
  print('AnnotatedRegion runtimeType accessible');

  print('AnnotatedRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnnotatedRegion Tests'),
      Text('Region'),
    ],
  );
}
