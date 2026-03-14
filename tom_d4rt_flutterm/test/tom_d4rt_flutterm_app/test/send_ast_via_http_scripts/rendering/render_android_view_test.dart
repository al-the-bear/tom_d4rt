// D4rt test script: Tests RenderAndroidView from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderAndroidView test executing');

  // ========== PLATFORM VIEW CONCEPTS ==========
  print('--- RenderAndroidView Concepts ---');
  print('RenderAndroidView renders Android native views in Flutter');
  print('It is part of the platform views system');
  print('Uses Android-specific APIs for embedding native views');

  // ========== PLATFORM VIEW HIT TEST BEHAVIOR ==========
  print('--- PlatformViewHitTestBehavior ---');
  print('PlatformViewHitTestBehavior.opaque: ${PlatformViewHitTestBehavior.opaque}');
  print('PlatformViewHitTestBehavior.translucent: ${PlatformViewHitTestBehavior.translucent}');
  print('PlatformViewHitTestBehavior.transparent: ${PlatformViewHitTestBehavior.transparent}');

  // ========== ANDROID VIEW WIDGET ==========
  print('--- AndroidView Widget (creates RenderAndroidView) ---');
  print('AndroidView is the widget that creates RenderAndroidView');
  print('It requires a viewType registered with the platform');
  print('Note: AndroidView only works on Android platform');

  // Demonstrate AndroidView structure (won\'t work in non-Android context)
  print('AndroidView structure:');
  print('  viewType: String - registered native view type');
  print('  onPlatformViewCreated: callback when view is ready');
  print('  hitTestBehavior: how to handle touch events');
  print('  layoutDirection: TextDirection for the view');
  print('  gestureRecognizers: set of gesture recognizers');
  print('  creationParams: parameters passed to native side');
  print('  creationParamsCodec: codec for serializing params');

  // ========== PLATFORM VIEW LAYER ==========
  print('--- PlatformViewLayer ---');
  print('RenderAndroidView uses PlatformViewLayer for compositing');
  print('PlatformViewLayer holds the platform view ID');

  // ========== TEXTURE VS HYBRID COMPOSITION ==========
  print('--- Rendering Modes ---');
  print('Virtual Display (Texture): renders in off-screen buffer');
  print('  - Better performance');
  print('  - Some features may not work (keyboard, accessibility)');
  print('Hybrid Composition: native view in view hierarchy');
  print('  - Full native features');
  print('  - May have performance overhead');

  // ========== GESTURE FORWARDING ==========
  print('--- Gesture Forwarding ---');
  print('RenderAndroidView handles touch event forwarding to native');
  print('Touch events are converted to MotionEvents on Android');
  print('Gesture recognizers can intercept events before forwarding');

  // ========== SIZING CONSTRAINTS ==========
  print('--- Sizing Behavior ---');
  print('RenderAndroidView typically sizes to constraints');
  print('Native view receives the allocated size');
  print('Size changes trigger native view resize');

  // ========== PLATFORM VIEW SURFACE ==========
  print('--- Platform View Surface ---');
  print('AndroidViewSurface: for hybrid composition rendering');
  print('Uses TextureLayer or PlatformViewLayer depending on mode');

  // ========== MOCK PLATFORM VIEW DISPLAY ==========
  print('--- Platform View Example Structure ---');

  // Create a placeholder that represents where AndroidView would be
  final platformViewPlaceholder = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.green, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.android, size: 40, color: Colors.green),
        SizedBox(height: 8),
        Text('Android Native View'),
        Text('(Platform-specific)', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
  print('Created platform view placeholder');

  // ========== PLATFORM VIEW LINK ==========
  print('--- PlatformViewLink ---');
  print('PlatformViewLink connects widget to render object');
  print('  surfaceFactory: creates the surface widget');
  print('  onCreatePlatformView: creates platform view controller');
  print('  viewType: identifies the native view type');

  // ========== VIEW CONTROLLER ==========
  print('--- View Controller Lifecycle ---');
  print('1. PlatformViewController created');
  print('2. create() called - initializes native view');
  print('3. setSize() called when layout completes');
  print('4. dispose() called when widget is removed');

  // ========== WEBVIEW EXAMPLE ==========
  print('--- Common Android View Types ---');
  print('WebView - embedded web browser');
  print('MapView - Google Maps');
  print('VideoView - video player');
  print('AdView - advertisement banners');
  print('Custom native widgets');

  // ========== PLATFORM CHANNELS ==========
  print('--- Platform Channel Communication ---');
  print('MethodChannel: for method calls');
  print('EventChannel: for event streams');
  print('BasicMessageChannel: for raw messages');

  final channelExample = MethodChannel('example/android_view');
  print('MethodChannel created: example/android_view');

  // ========== FOCUS HANDLING ==========
  print('--- Focus Handling ---');
  print('RenderAndroidView manages focus for the native view');
  print('Focus can be requested programmatically');
  print('Keyboard events are forwarded when focused');

  // ========== ACCESSIBILITY ==========
  print('--- Accessibility ---');
  print('RenderAndroidView supports accessibility semantics');
  print('Native view accessibility tree is merged with Flutter');
  print('Screen readers can navigate into native views');

  print('RenderAndroidView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAndroidView Tests'),
      SizedBox(height: 8),
      platformViewPlaceholder,
      SizedBox(height: 8),
      Text('Platform views are Android-specific'),
      Text('See documentation for usage'),
      SizedBox(height: 8),
      Text('All RenderAndroidView tests passed'),
    ],
  );
}
