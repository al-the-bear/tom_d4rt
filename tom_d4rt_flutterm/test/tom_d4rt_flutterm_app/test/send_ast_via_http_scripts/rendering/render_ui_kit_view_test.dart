// ignore_for_file: avoid_print
// D4rt test script: Tests RenderUiKitView from rendering
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderUiKitView test executing');
  print('=' * 50);

  // RenderUiKitView for iOS UIKit views
  print('\nRenderUiKitView:');
  print('RenderObject for iOS UIKit view embedding');
  print('iOS-specific platform view rendering');

  // Purpose
  print('\nPurpose:');
  print('- Render iOS UIKit views in Flutter');
  print('- Handle platform view compositing');
  print('- Manage native iOS view lifecycle');

  // Constructor parameters
  print('\nConstructor parameters:');
  print('- viewController: UiKitViewController');
  print('- hitTestBehavior: PlatformViewHitTestBehavior');
  print('- gestureRecognizers: Set<Factory>');

  // PlatformViewHitTestBehavior
  print('\nPlatformViewHitTestBehavior:');
  print('- opaque: Platform view handles all hits');
  print('- translucent: Tries Flutter, then platform');
  print('- transparent: Flutter handles all hits');

  // Used by
  print('\nUsed by:');
  print('- UiKitView widget');
  print('- iOS platform views');
  print('- Native iOS component embedding');

  // Example usage
  print('\nExample usage:');
  print('UiKitView(');
  print('  viewType: "my-ios-view",');
  print('  onPlatformViewCreated: (id) {');
  print('    print("Platform view created: \$id");');
  print('  },');
  print('  gestureRecognizers: <Factory<');
  print('      OneSequenceGestureRecognizer>>{},');
  print(');');

  // iOS only
  print('\niOS platform only:');
  print('- Uses UIKit framework');
  print('- iOS native view embedding');
  print('- Not available on other platforms');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderObject');
  print('  \u2514\u2500 RenderBox');
  print('       \u2514\u2500 RenderUiKitView');

  // Explain purpose
  print('\nRenderUiKitView purpose:');
  print('- iOS UIKit view rendering');
  print('- Platform view compositing');
  print('- Native iOS embedding');
  print('- Hit test behavior control');
  print('- Gesture recognizer handling');

  print('\n${'=' * 50}');
  print('RenderUiKitView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderUiKitView Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Platform: iOS only'),
      Text('Framework: UIKit'),
      Text('Widget: UiKitView'),
      Text('Purpose: Native iOS views'),
    ],
  );
}
