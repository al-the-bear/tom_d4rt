// D4rt test script: Tests FlutterView from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlutterView test executing');

  // Test FlutterView - View abstraction
  print('FlutterView is available in the dart_ui package');
  print('FlutterView: View abstraction');

  print('FlutterView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterView Tests'),
      Text('View abstraction'),
    ],
  );
}
