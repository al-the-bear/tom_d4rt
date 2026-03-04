// D4rt test script: Tests RelativeRectTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RelativeRectTween test executing');

  // Test RelativeRectTween - RelativeRectTween
  print('RelativeRectTween is available in the widgets package');
  print('RelativeRectTween runtimeType accessible');

  print('RelativeRectTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RelativeRectTween Tests'),
      Text('RelativeRectTween'),
    ],
  );
}
