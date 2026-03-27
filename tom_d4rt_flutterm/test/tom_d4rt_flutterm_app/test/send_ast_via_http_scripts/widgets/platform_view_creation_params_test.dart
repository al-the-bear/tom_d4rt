// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformViewCreationParams from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformViewCreationParams test executing');
  print('=' * 50);

  // === Test PlatformViewCreationParams class ===
  print('\nPlatformViewCreationParams configures platform view creation');

  // Describe the class
  print('\n--- Understanding the class ---');
  print('Immutable parameters for platform view creation');
  print('Passed to CreatePlatformViewCallback');
  print('Contains id, viewType, callbacks');

  // Key properties
  print('\n--- Key properties ---');
  print('id: int - unique identifier for view');
  print('viewType: String - registered view type');
  print('onPlatformViewCreated: callback when ready');
  print('onFocusChanged: callback for focus events');

  // id property
  print('\n--- Testing id property ---');
  print('Unique identifier for this platform view');
  print('Matches PlatformViewController.viewId');
  print('Assigned by platformViewsRegistry');

  // viewType property
  print('\n--- Testing viewType property ---');
  print('Type identifier registered on platform side');
  print('Example: "webview", "maps", "ad-banner"');
  print('Must be registered before use');

  // onPlatformViewCreated callback
  print('\n--- onPlatformViewCreated callback ---');
  print('PlatformViewCreatedCallback type');
  print('Called after platform view initialized');
  print('Receives platform view id');

  // onFocusChanged callback
  print('\n--- onFocusChanged callback ---');
  print('ValueChanged<bool> type');
  print('true: platform view gained focus');
  print('false: platform view lost focus');

  // Usage in PlatformViewLink
  print('\n--- Usage in PlatformViewLink ---');
  print('PlatformViewLink(');
  print('  onCreatePlatformView: (params) {');
  print('    // params.id, params.viewType');
  print('    // params.onPlatformViewCreated');
  print('    return controller;');
  print('  },');
  print('  ...');
  print(')');

  // Platform considerations
  print('\n--- Platform considerations ---');
  print('Android: creates android.view.View');
  print('iOS: creates UIView');
  print('Web: creates HTML element');

  print('\n' + '=' * 50);
  print('PlatformViewCreationParams test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformViewCreationParams Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Properties: id, viewType'),
      Text('Callbacks: onPlatformViewCreated'),
      Text('Used by: PlatformViewLink'),
    ],
  );
}
