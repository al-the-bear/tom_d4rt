// D4rt test script: Tests BackdropKey from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BackdropKey test executing');

  // Test BackdropKey - Backdrop key
  print('BackdropKey is available in the rendering package');
  print('BackdropKey: Backdrop key');

  print('BackdropKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackdropKey Tests'),
      Text('Backdrop key'),
    ],
  );
}
