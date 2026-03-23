// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AppKitViewController from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppKitViewController test executing');

  // AppKitViewController is for macOS platform views
  print('AppKitViewController: macOS platform views');
  print('Part of PlatformViewController hierarchy');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PlatformViewController (abstract)');
  print('  └── AppKitViewController (macOS)');
  print('  └── UiKitViewController (iOS)');
  print('  └── AndroidViewController (Android)');

  // Cannot instantiate directly
  print('\nCannot instantiate directly:');
  print('- Requires platform channel setup');
  print('- Created by UiKitView widget');
  print('- Or: PlatformViewsService');

  // Usage via UiKitView (similar concept)
  print('\nUsage on macOS:');
  print('// In pubspec.yaml macOS section');
  print('// Register native view factory');
  print('');
  print('UiKitView('); // Note: macOS uses AppKitView
  print('  viewType: "my-native-view",');
  print('  onPlatformViewCreated: (id) { },');
  print(')');

  // AppKitViewController properties
  print('\nAppKitViewController properties:');
  print('- viewId: unique identifier');
  print('- awaitingCreation: creation state');

  // Methods
  print('\nMethods:');
  print('- dispose(): cleanup native view');
  print('- setSize(): resize the view');
  print('- acceptGesture(): gesture handling');
  print('- rejectGesture(): reject gesture');

  // Platform view usage
  print('\nPlatform view use cases:');
  print('- Embed NSView in Flutter');
  print('- Google Maps native');
  print('- WebView');
  print('- Video player');

  print('\nAppKitViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AppKitViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('macOS platform view controller'),
      Text('Platform: macOS only'),
      Text('Embeds: NSView in Flutter'),
      Text('Created by: UiKitView'),
    ],
  );
}
