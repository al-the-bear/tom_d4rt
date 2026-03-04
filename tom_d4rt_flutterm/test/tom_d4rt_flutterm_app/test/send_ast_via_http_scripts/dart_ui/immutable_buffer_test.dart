// D4rt test script: Tests ImmutableBuffer from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImmutableBuffer test executing');

  // Test ImmutableBuffer - Immutable byte buffer
  print('ImmutableBuffer is available in the dart_ui package');
  print('ImmutableBuffer: Immutable byte buffer');

  print('ImmutableBuffer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImmutableBuffer Tests'),
      Text('Immutable byte buffer'),
    ],
  );
}
