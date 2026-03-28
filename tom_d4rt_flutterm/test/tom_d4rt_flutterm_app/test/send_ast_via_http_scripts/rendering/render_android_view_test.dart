// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderAndroidView from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAndroidView test executing');
  print('=' * 50);

  // RenderAndroidView class overview
  print('RenderAndroidView class overview:');
  print('  - Extends PlatformViewRenderBox');
  print('  - Renders Android native views');
  print('  - Platform view integration');

  // Constructor parameters
  print('\nConstructor parameters:');
  print('  AndroidViewController viewController');
  print('    - Required controller');
  print('  PlatformViewHitTestBehavior hitTestBehavior');
  print('    - How hit testing works');
  print('  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers');
  print('    - Gesture handling');
  print('  Clip clipBehavior');
  print('    - How to clip view');

  // Key properties
  print('\nKey properties:');
  print('  viewController: AndroidViewController');
  print('  hitTestBehavior: PlatformViewHitTestBehavior');
  print('  gestureRecognizers: Set<Factory>');

  // Hit test behaviors
  print('\nHit test behaviors:');
  print('  PlatformViewHitTestBehavior.opaque');
  print('    - View absorbs all hits');
  print('  PlatformViewHitTestBehavior.translucent');
  print('    - Hits go through');
  print('  PlatformViewHitTestBehavior.transparent');
  print('    - No hit testing');

  // Android view types
  print('\nAndroid view types:');
  print('  TextureAndroidViewController');
  print('    - Texture-based rendering');
  print('  SurfaceAndroidViewController');
  print('    - Surface-based rendering');
  print('  ExpensiveAndroidViewController');
  print('    - For expensive views');

  // Rendering modes
  print('\nRendering modes:');
  print('  Texture: Copy view to texture');
  print('  Hybrid: Mix native and Flutter');
  print('  Virtual display: Separate display');

  // Usage context
  print('\nUsage context:');
  print('  AndroidView widget uses this');
  print('  Maps, WebView, ads');
  print('  Any native Android UI');

  // Platform specific
  print('\nPlatform specific:');
  print('  Android only');
  print('  Other platforms use different');
  print('  RenderUiKitView for iOS');

  print('\n' + '=' * 50);
  print('RenderAndroidView test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAndroidView Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: PlatformViewRenderBox'),
      Text('Key: viewController, hitTestBehavior'),
      Text('Purpose: Android platform views'),
    ],
  );
}
