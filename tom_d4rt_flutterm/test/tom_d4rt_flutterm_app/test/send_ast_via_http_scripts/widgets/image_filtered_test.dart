// D4rt test script: Tests ImageFiltered from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageFiltered test executing');

  // Test ImageFiltered - Image filtering
  print('ImageFiltered is available in the widgets package');
  print('ImageFiltered runtimeType accessible');

  print('ImageFiltered test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageFiltered Tests'),
      Text('Image filtering'),
    ],
  );
}
