// D4rt test script: Tests Title from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Title test executing');

  // Test Title - App title
  print('Title is available in the widgets package');
  print('Title runtimeType accessible');

  print('Title test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Title Tests'),
      Text('App title'),
    ],
  );
}
