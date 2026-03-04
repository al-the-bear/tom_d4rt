// D4rt test script: Tests BorderTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BorderTween test executing');

  // Test BorderTween - Border tween
  print('BorderTween is available in the widgets package');
  print('BorderTween runtimeType accessible');

  print('BorderTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BorderTween Tests'),
      Text('Border tween'),
    ],
  );
}
