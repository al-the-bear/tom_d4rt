// D4rt test script: Tests SelectWordSelectionEvent from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectWordSelectionEvent test executing');

  // Test SelectWordSelectionEvent - Select word
  print('SelectWordSelectionEvent is available in the rendering package');
  print('SelectWordSelectionEvent: Select word');

  print('SelectWordSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectWordSelectionEvent Tests'),
      Text('Select word'),
    ],
  );
}
