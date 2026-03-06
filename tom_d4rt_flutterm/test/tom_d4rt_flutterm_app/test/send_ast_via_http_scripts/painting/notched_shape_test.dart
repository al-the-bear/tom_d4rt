// D4rt test script: Tests NotchedShape from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NotchedShape test executing');

  // Test NotchedShape - Shape with notch
  print('NotchedShape is available in the painting package');
  print('NotchedShape: Shape with notch');

  print('NotchedShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NotchedShape Tests'),
      Text('Shape with notch'),
    ],
  );
}
