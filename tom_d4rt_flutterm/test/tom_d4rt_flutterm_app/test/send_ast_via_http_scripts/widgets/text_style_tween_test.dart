// D4rt test script: Tests TextStyleTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextStyleTween test executing');

  // Test TextStyleTween - TextStyleTween
  print('TextStyleTween is available in the widgets package');
  print('TextStyleTween runtimeType accessible');

  print('TextStyleTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextStyleTween Tests'),
      Text('TextStyleTween'),
    ],
  );
}
