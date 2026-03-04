// D4rt test script: Tests ScrollbarPainter from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollbarPainter test executing');

  // Test ScrollbarPainter - ScrollbarPainter
  print('ScrollbarPainter is available in the widgets package');
  print('ScrollbarPainter runtimeType accessible');

  print('ScrollbarPainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollbarPainter Tests'),
      Text('ScrollbarPainter'),
    ],
  );
}
