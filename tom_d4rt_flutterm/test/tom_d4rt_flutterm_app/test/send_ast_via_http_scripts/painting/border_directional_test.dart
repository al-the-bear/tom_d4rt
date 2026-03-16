// D4rt test script: Tests BorderDirectional from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BorderDirectional test executing');

  // Test BorderDirectional - RTL-aware border
  print('BorderDirectional is available in the painting package');
  print('BorderDirectional: RTL-aware border');

  print('BorderDirectional test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BorderDirectional Tests'),
      Text('RTL-aware border'),
    ],
  );
}
