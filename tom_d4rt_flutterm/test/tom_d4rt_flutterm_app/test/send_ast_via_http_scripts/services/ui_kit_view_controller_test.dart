// ignore_for_file: avoid_print
// D4rt test script: Tests UiKitViewController from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UiKitViewController test executing');
  print('=' * 50);

  // UiKitViewController for iOS UIKit views
  print('\nUiKitViewController:');
  print('Platform view controller for iOS UIKit views');
  print('Embeds native UIView in Flutter');

  // Extends DarwinPlatformViewController
  print('\nExtends DarwinPlatformViewController:');
  print('Darwin-specific platform view handling');
  print('iOS UIKit integration');

  // Properties and lifecycle
  print('\nProperties:');
  print('viewId: Unique view identifier');
  print('awaitingCreation: View creation pending');

  // Lifecycle methods
  print('\nLifecycle methods:');
  print('create(): Initialize UIView');
  print('  - Called when widget builds');
  print('  - Allocates native view');
  print('');
  print('dispose(): Cleanup');
  print('  - Release native resources');
  print('  - Remove from view hierarchy');

  // Event handling
  print('\nEvent handling:');
  print('dispatchPointerEvent(event):');
  print('  - Forwards touch events to UIView');
  print('  - Translates Flutter events to UIKit');
  print('');
  print('clearFocus():');
  print('  - Removes focus from native view');
  print('  - Resignes first responder');

  // UiKitView widget
  print('\nUiKitView widget usage:');
  print('UiKitView(');
  print('  viewType: "native-view-type",');
  print('  onPlatformViewCreated: (id) {');
  print('    // View created with id');
  print('  },');
  print('  creationParams: <String, dynamic>{},');
  print('  creationParamsCodec: StandardMessageCodec(),');
  print(');');

  // Common use cases
  print('\nCommon use cases:');
  print('- WKWebView integration');
  print('- MKMapView (Apple Maps)');
  print('- AVPlayer video views');
  print('- Camera preview');
  print('- Third-party SDKs');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PlatformViewController');
  print('  \u2514\u2500 DarwinPlatformViewController');
  print('      \u2514\u2500 UiKitViewController');

  // Explain purpose
  print('\nUiKitViewController purpose:');
  print('- iOS UIKit view hosting');
  print('- Native UIView embedding');
  print('- Lifecycle management');
  print('- Event dispatching');
  print('- Focus handling');

  print('\n' + '=' * 50);
  print('UiKitViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UiKitViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: DarwinPlatformViewController'),
      Text('Platform: iOS'),
      Text('Widget: UiKitView'),
      Text('Purpose: iOS native view hosting'),
    ],
  );
}
