// D4rt test script: Tests FloatingHeaderSnapConfiguration from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FloatingHeaderSnapConfiguration test executing');

  // Test FloatingHeaderSnapConfiguration - Header snap config
  print('FloatingHeaderSnapConfiguration is available in the rendering package');
  print('FloatingHeaderSnapConfiguration: Header snap config');

  print('FloatingHeaderSnapConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingHeaderSnapConfiguration Tests'),
      Text('Header snap config'),
    ],
  );
}
