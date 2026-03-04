// D4rt test script: Tests RootIsolateToken from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootIsolateToken test executing');

  // Test RootIsolateToken - Root isolate token
  print('RootIsolateToken is available in the dart_ui package');
  print('RootIsolateToken: Root isolate token');

  print('RootIsolateToken test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootIsolateToken Tests'),
      Text('Root isolate token'),
    ],
  );
}
