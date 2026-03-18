// D4rt test script: Tests DarwinPlatformViewController from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DarwinPlatformViewController test executing');
  print('=' * 50);

  // DarwinPlatformViewController for macOS/iOS views
  print('\nDarwinPlatformViewController:');
  print('Platform view controller for Darwin platforms');
  print('macOS (AppKit) and iOS (UIKit) native views');

  // Extends PlatformViewController
  print('\nExtends PlatformViewController:');
  print('Base controller for platform views');
  print('Darwin-specific implementation');

  // Platform support
  print('\nPlatform support:');
  print('- macOS: AppKit NSView hosting');
  print('- iOS: UIKit UIView hosting');
  print('- Not for Android or other platforms');

  // Lifecycle methods
  print('\nLifecycle methods:');
  print('create(): Create native view');
  print('clearFocus(): Remove focus from view');
  print('dispatchPointerEvent(): Forward pointer events');
  print('dispose(): Clean up resources');

  // View ID
  print('\nView identification:');
  print('viewId: Unique identifier for this view');
  print('Used for platform channel routing');

  // macOS specifics
  print('\nmacOS specifics:');
  print('- NSView-based embedding');
  print('- Responder chain integration');
  print('- Focus management');
  print('- Layer-backed or buffer-backed');

  // iOS specifics
  print('\niOS specifics:');
  print('- UIView-based embedding');
  print('- Touch event forwarding');
  print('- Gesture recognizers');
  print('- Safe area handling');

  // Usage context
  print('\nUsage context:');
  print('UiKitView (iOS):');
  print('  - Creates UIView in Flutter');
  print('  - Uses this controller internally');
  print('');
  print('AppKitView (macOS):');
  print('  - Creates NSView in Flutter');
  print('  - Uses this controller internally');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PlatformViewController');
  print('  \u2514\u2500 DarwinPlatformViewController');

  // Explain purpose
  print('\nDarwinPlatformViewController purpose:');
  print('- Darwin platform view management');
  print('- macOS AppKit integration');
  print('- iOS UIKit integration');
  print('- Native view lifecycle control');
  print('- Event dispatching to native views');

  print('\n' + '=' * 50);
  print('DarwinPlatformViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DarwinPlatformViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: PlatformViewController'),
      Text('Platforms: macOS, iOS'),
      Text('Views: NSView, UIView'),
      Text('Purpose: Darwin platform views'),
    ],
  );
}
