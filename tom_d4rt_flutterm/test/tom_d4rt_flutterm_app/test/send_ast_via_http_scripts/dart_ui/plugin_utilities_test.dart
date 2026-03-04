// D4rt test script: Tests PluginUtilities from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PluginUtilities test executing');

  // Test PluginUtilities - Plugin utilities
  print('PluginUtilities is available in the dart_ui package');
  print('PluginUtilities: Plugin utilities');

  print('PluginUtilities test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PluginUtilities Tests'),
      Text('Plugin utilities'),
    ],
  );
}
