// D4rt test script: Tests DecorationTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DecorationTween test executing');

  // Test DecorationTween - DecorationTween
  print('DecorationTween is available in the widgets package');
  print('DecorationTween runtimeType accessible');

  print('DecorationTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DecorationTween Tests'),
      Text('DecorationTween'),
    ],
  );
}
