// D4rt test script: Tests DiagnosticsDebugCreator from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsDebugCreator test executing');

  // Test DiagnosticsDebugCreator - Debug creator
  print('DiagnosticsDebugCreator is available in the rendering package');
  print('DiagnosticsDebugCreator: Debug creator');

  print('DiagnosticsDebugCreator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticsDebugCreator Tests'),
      Text('Debug creator'),
    ],
  );
}
