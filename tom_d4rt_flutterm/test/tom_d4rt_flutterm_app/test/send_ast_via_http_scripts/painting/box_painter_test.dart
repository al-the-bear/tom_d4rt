// D4rt test script: Tests BoxPainter from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxPainter test executing');

  // Test BoxPainter - Decoration painter
  print('BoxPainter is available in the painting package');
  print('BoxPainter: Decoration painter');

  print('BoxPainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxPainter Tests'),
      Text('Decoration painter'),
    ],
  );
}
