// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformViewLink from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformViewLink test executing');
  print('=' * 50);

  // === Test PlatformViewLink class ===
  print('\nPlatformViewLink embeds platform views in Flutter');

  // Describe the class
  print('\n--- Understanding PlatformViewLink ---');
  print('StatefulWidget for platform view embedding');
  print('Links native view to Flutter widget tree');
  print('Handles lifecycle and focus management');

  // Key parameters
  print('\n--- Key parameters ---');
  print('viewType: registered platform view type');
  print('onCreatePlatformView: factory callback');
  print('surfaceFactory: builds Flutter surface');

  // viewType property
  print('\n--- Testing viewType ---');
  print('String identifier for view type');
  print('Must be registered on platform side');
  print('Examples: "webview", "mapview"');

  // onCreatePlatformView callback
  print('\n--- onCreatePlatformView callback ---');
  print('CreatePlatformViewCallback type');
  print('Returns PlatformViewController');
  print('Receives PlatformViewCreationParams');

  // surfaceFactory callback
  print('\n--- surfaceFactory callback ---');
  print('PlatformViewSurfaceFactory type');
  print('Builds widget to render platform view');
  print('Usually returns PlatformViewSurface');

  // Lifecycle
  print('\n--- Lifecycle ---');
  print('1. initState: creates controller');
  print('2. build: returns placeholder or surface');
  print('3. dispose: cleans up controller');

  // Example structure
  print('\n--- Example structure ---');
  print('PlatformViewLink(');
  print('  viewType: "my-view",');
  print('  onCreatePlatformView: (params) {');
  print('    return MyPlatformViewController(params);');
  print('  },');
  print('  surfaceFactory: (ctx, controller) {');
  print('    return PlatformViewSurface(');
  print('      controller: controller,');
  print('      hitTestBehavior: ...,');
  print('      gestureRecognizers: ...,');
  print('    );');
  print('  },');
  print(')');

  // Related classes
  print('\n--- Related classes ---');
  print('PlatformViewSurface: renders view');
  print('PlatformViewController: controls view');
  print('AndroidView/UiKitView: convenience widgets');

  print('\n' + '=' * 50);
  print('PlatformViewLink test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformViewLink Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: StatefulWidget'),
      Text('viewType: platform view identifier'),
      Text('Purpose: embed native views'),
    ],
  );
}
