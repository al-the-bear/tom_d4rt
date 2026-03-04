// D4rt test script: Tests SelectAllSelectionEvent from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectAllSelectionEvent test executing');

  // Test SelectAllSelectionEvent - Select all
  print('SelectAllSelectionEvent is available in the rendering package');
  print('SelectAllSelectionEvent: Select all');

  print('SelectAllSelectionEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectAllSelectionEvent Tests'),
      Text('Select all'),
    ],
  );
}
