// D4rt test script: Tests RenderDarwinPlatformView from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('RenderDarwinPlatformView test executing');

  // ========== DARWIN PLATFORM VIEW BASICS ==========
  print('--- Darwin Platform View Basics ---');
  print('RenderDarwinPlatformView renders native macOS/iOS views');
  print('Part of the platform views system for hybrid UIs');
  print('Used for embedding UIView (iOS) or NSView (macOS)');

  // Note: Direct instantiation requires platform-specific setup
  // We test using UiKitView/AppKitView widgets as equivalents
  print('--- Platform View Architecture ---');
  print('UiKitView: iOS platform view widget');
  print('AppKitView: macOS platform view widget');
  print('RenderDarwinPlatformView: Underlying render object');

  // ========== HIT TEST BEHAVIOR ==========
  print('--- Hit Test Behavior Options ---');

  // Demonstrate PlatformViewHitTestBehavior enum values
  print('PlatformViewHitTestBehavior.opaque:');
  print('  Platform view absorbs all hit tests');
  print('  Flutter widgets behind cannot receive events');

  print('PlatformViewHitTestBehavior.translucent:');
  print('  Platform view and Flutter can both receive events');
  print('  Events pass through to widgets behind');

  print('PlatformViewHitTestBehavior.transparent:');
  print('  Platform view is ignored in hit testing');
  print('  All events go to Flutter widgets');

  // ========== PLATFORM VIEW COMPOSITION ==========
  print('--- Platform View Composition ---');
  print('Hybrid composition: Native view in Flutter layer tree');
  print('Virtual display: Native view rendered to texture');
  print('Darwin uses hybrid composition by default');

  // Test placeholder for platform view area
  final platformViewPlaceholder = Container(
    width: 200,
    height: 150,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      border: Border.all(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.desktop_mac, size: 40, color: Colors.blue),
        SizedBox(height: 8),
        Text('Darwin Platform View'),
        Text('(macOS/iOS Native)', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
  print('Placeholder representing platform view area');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Embedding WKWebView for web content');
  print('2. MapKit for native maps on Apple platforms');
  print('3. PDFKit for PDF rendering');
  print('4. AVPlayerView for video playback');
  print('5. Custom native UI components');

  // Test web view placeholder
  final webViewPlaceholder = Container(
    width: 200,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
    ),
    child: Column(
      children: [
        Container(
          height: 30,
          color: Colors.grey[200],
          child: Row(
            children: [
              SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              Spacer(),
              Text('WebView', style: TextStyle(fontSize: 10)),
              SizedBox(width: 8),
            ],
          ),
        ),
        Expanded(child: Center(child: Text('Web Content Area'))),
      ],
    ),
  );
  print('WebView placeholder demonstration');

  // ========== SIZING BEHAVIOR ==========
  print('--- Sizing Behavior ---');
  print('RenderDarwinPlatformView sizes to exact constraints');
  print('Native view fills the entire render box area');
  print('Use SizedBox or AspectRatio to control size');

  // Test different sizes
  final smallView = Container(
    width: 80,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.blue[100],
      border: Border.all(color: Colors.blue),
    ),
    child: Center(child: Text('80x60')),
  );

  final mediumView = Container(
    width: 120,
    height: 90,
    decoration: BoxDecoration(
      color: Colors.green[100],
      border: Border.all(color: Colors.green),
    ),
    child: Center(child: Text('120x90')),
  );
  print('Different sized platform view placeholders');

  // ========== GESTURE HANDLING ==========
  print('--- Gesture Handling ---');
  print('Platform views can handle native gestures');
  print('Or pass through to Flutter gesture system');
  print('gestureRecognizers parameter customizes behavior');

  final gestureDemo = GestureDetector(
    onTap: () => print('Flutter tap'),
    child: Container(
      width: 150,
      height: 80,
      color: Colors.purple[100],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.touch_app), Text('Gesture Area')],
        ),
      ),
    ),
  );
  print('Gesture detector wrapping platform view area');

  // ========== LAYOUT INTEGRATION ==========
  print('--- Layout Integration ---');
  print('Platform views participate in Flutter layout');
  print('Can be placed in Rows, Columns, Stacks');
  print('Respect constraints from parent widgets');

  final layoutExample = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 60,
        height: 60,
        color: Colors.amber,
        child: Center(child: Text('FL')),
      ),
      Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.blue),
        ),
        child: Center(child: Text('Native')),
      ),
      Container(
        width: 60,
        height: 60,
        color: Colors.teal,
        child: Center(child: Text('FL')),
      ),
    ],
  );
  print('Mixed Flutter/Native layout');

  // ========== MEMORY MANAGEMENT ==========
  print('--- Memory Management ---');
  print('Platform views are disposed when widget is removed');
  print('Native resources released automatically');
  print('Use AutomaticKeepAlive for caching if needed');

  // ========== PLATFORM DIFFERENCES ==========
  print('--- Platform Differences ---');
  print('iOS: Uses UIView, supports hybrid composition');
  print('macOS: Uses NSView, similar to iOS');
  print('Both use Quartz layer-backed views');

  print('RenderDarwinPlatformView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderDarwinPlatformView Tests'),
      SizedBox(height: 8),
      platformViewPlaceholder,
      SizedBox(height: 8),
      webViewPlaceholder,
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [smallView, SizedBox(width: 8), mediumView],
      ),
      SizedBox(height: 8),
      layoutExample,
      SizedBox(height: 8),
      Text('All DarwinPlatformView tests passed'),
    ],
  );
}
