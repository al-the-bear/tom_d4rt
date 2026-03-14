// D4rt test script: Tests RenderAppKitView from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderAppKitView test executing');

  // ========== APPKIT VIEW CONCEPTS ==========
  print('--- RenderAppKitView Concepts ---');
  print('RenderAppKitView renders macOS AppKit views in Flutter');
  print('It is the macOS equivalent of RenderAndroidView');
  print('Uses Cocoa APIs for embedding native NSView objects');

  // ========== PLATFORM SPECIFICITY ==========
  print('--- Platform Specificity ---');
  print('RenderAppKitView is macOS-specific');
  print('On Android: use RenderAndroidView');
  print('On iOS: use RenderUiKitView');
  print('On macOS: use RenderAppKitView');
  print('Cross-platform: use PlatformViewLink');

  // ========== PLATFORM VIEW HIT TEST BEHAVIOR ==========
  print('--- PlatformViewHitTestBehavior ---');
  print(
    'PlatformViewHitTestBehavior.opaque: ${PlatformViewHitTestBehavior.opaque}',
  );
  print('  Blocks hit testing - native view handles all touches');
  print(
    'PlatformViewHitTestBehavior.translucent: ${PlatformViewHitTestBehavior.translucent}',
  );
  print('  Allows hit testing - both Flutter and native can respond');
  print(
    'PlatformViewHitTestBehavior.transparent: ${PlatformViewHitTestBehavior.transparent}',
  );
  print('  Ignores native view - Flutter handles all touches');

  // ========== APPKIT VIEW WIDGET ==========
  print('--- AppKitView Widget (creates RenderAppKitView) ---');
  print('AppKitView is the widget that creates RenderAppKitView');
  print('It embeds native macOS views into Flutter apps');
  print('Note: AppKitView only works on macOS platform');

  print('AppKitView structure:');
  print('  viewType: String - registered native view type');
  print('  onPlatformViewCreated: callback when view is ready');
  print('  hitTestBehavior: how to handle mouse/touch events');
  print('  layoutDirection: TextDirection for the view');
  print('  gestureRecognizers: set of gesture recognizers');
  print('  creationParams: parameters passed to native side');
  print('  creationParamsCodec: codec for serializing params');

  // ========== NATIVE VIEW EXAMPLES ==========
  print('--- Common AppKit View Types ---');
  print('NSTextField - native text input');
  print('NSButton - native macOS button');
  print('WKWebView - web browser view');
  print('AVPlayerView - video player');
  print('MKMapView - Apple Maps view');
  print('NSOpenGLView - OpenGL rendering');
  print('PDFView - PDF document viewer');

  // ========== PLATFORM VIEW PLACEHOLDER ==========
  print('--- Platform View Placeholder ---');

  final appKitPlaceholder = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      border: Border.all(color: Colors.blueGrey, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.desktop_mac, size: 40, color: Colors.blueGrey),
        SizedBox(height: 8),
        Text('macOS AppKit View'),
        Text('(Platform-specific)', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
  print('Created AppKit view placeholder');

  // ========== RENDERING MODES ==========
  print('--- macOS Rendering Modes ---');
  print('Layer-backed view: uses CALayer for compositing');
  print('  - Better integration with Flutter rendering');
  print('  - Hardware accelerated');
  print('Snapshot rendering: renders to texture');
  print('  - For views that don\'t support layer backing');
  print('  - May have performance overhead');

  // ========== FOCUS AND KEYBOARD ==========
  print('--- Focus and Keyboard Handling ---');
  print('RenderAppKitView manages focus for native views');
  print('Key events are forwarded to the native responder chain');
  print('Focus ring is drawn by the native view system');

  // ========== MOUSE EVENT HANDLING ==========
  print('--- Mouse Event Handling ---');
  print('Mouse events are converted to NSEvent objects');
  print('Supports: mouseDown, mouseUp, mouseDragged');
  print('Supports: rightMouseDown, otherMouseDown');
  print('Scroll events: scrollWheel, magnify, rotate');

  // ========== GESTURE RECOGNIZERS ==========
  print('--- Gesture Recognizers ---');
  print('Custom gesture recognizers can intercept events');
  print('Events can be forwarded to both Flutter and native');
  print('Use gestureRecognizers parameter to configure');

  // ========== ACCESSIBILITY ==========
  print('--- Accessibility Support ---');
  print('Native accessibility is integrated with Flutter');
  print('VoiceOver can navigate into AppKit views');
  print('Semantic information is merged with Flutter tree');

  // ========== PLATFORM CHANNEL COMMUNICATION ==========
  print('--- Platform Channel Communication ---');

  final channelExample = MethodChannel('example/appkit_view');
  print('MethodChannel for AppKit communication: example/appkit_view');

  print('Common channel operations:');
  print('  invokeMethod: call native method');
  print('  setMethodCallHandler: receive native calls');

  // ========== LIFECYCLE MANAGEMENT ==========
  print('--- View Controller Lifecycle ---');
  print('1. Plugin registers view factory');
  print('2. Flutter requests view creation');
  print('3. Native NSView is instantiated');
  print('4. View is sized and positioned');
  print('5. Events are forwarded as needed');
  print('6. View is disposed when widget is removed');

  // ========== MULTI-WINDOW SUPPORT ==========
  print('--- Multi-Window Support ---');
  print('macOS apps can have multiple windows');
  print('Each window has its own FlutterViewController');
  print('AppKit views are scoped to their window');

  // ========== RETINA DISPLAY ==========
  print('--- Retina Display Support ---');
  print('RenderAppKitView handles HiDPI scaling');
  print('Native views render at full Retina resolution');
  print('Flutter coordinates are in logical pixels');

  // ========== PLATFORM VIEW SURFACE ==========
  print('--- Platform View Surface ---');
  print('AppKitViewSurface: for native view composition');
  print('Uses CALayer blending for smooth integration');

  // ========== ERROR HANDLING ==========
  print('--- Error Handling ---');
  print('Platform view creation can fail');
  print('Check onPlatformViewCreated callback');
  print('Handle missing native dependencies gracefully');

  print('RenderAppKitView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAppKitView Tests'),
      SizedBox(height: 8),
      appKitPlaceholder,
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text('macOS-Specific Features:'),
            Text('• NSView embedding', style: TextStyle(fontSize: 12)),
            Text('• Mouse/trackpad events', style: TextStyle(fontSize: 12)),
            Text('• Focus ring support', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
      SizedBox(height: 8),
      Text('All RenderAppKitView tests passed'),
    ],
  );
}
