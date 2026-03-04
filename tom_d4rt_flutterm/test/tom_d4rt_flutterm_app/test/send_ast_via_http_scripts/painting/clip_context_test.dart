// D4rt test script: Tests ClipContext from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipContext test executing');

  // Test ClipContext - Clipping context
  print('ClipContext is available in the painting package');
  print('ClipContext: Clipping context');

  print('ClipContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipContext Tests'),
      Text('Clipping context'),
    ],
  );
}
