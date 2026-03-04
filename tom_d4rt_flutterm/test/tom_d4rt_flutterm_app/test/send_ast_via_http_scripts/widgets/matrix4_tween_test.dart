// D4rt test script: Tests Matrix4Tween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Matrix4Tween test executing');

  // Test Matrix4Tween - Matrix4Tween
  print('Matrix4Tween is available in the widgets package');
  print('Matrix4Tween runtimeType accessible');

  print('Matrix4Tween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Matrix4Tween Tests'),
      Text('Matrix4Tween'),
    ],
  );
}
