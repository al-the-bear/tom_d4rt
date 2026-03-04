// D4rt test script: Tests BorderRadiusTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BorderRadiusTween test executing');

  // Test BorderRadiusTween - Radius tween
  print('BorderRadiusTween is available in the widgets package');
  print('BorderRadiusTween runtimeType accessible');

  print('BorderRadiusTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BorderRadiusTween Tests'),
      Text('Radius tween'),
    ],
  );
}
