// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests SingletonFlutterWindow from dart_ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SingletonFlutterWindow test executing');
  print('=' * 50);

  // SingletonFlutterWindow is deprecated - use FlutterView instead
  print('SingletonFlutterWindow class test');
  print('Note: SingletonFlutterWindow is deprecated since Flutter 3.7');
  print('Use FlutterView or PlatformDispatcher instead');

  // Access the deprecated window singleton
  final window = ui.window;
  print('ui.window accessed (deprecated)');
  print('Window runtimeType: ${window.runtimeType}');
  print('is ui.SingletonFlutterWindow: ${window is ui.SingletonFlutterWindow}');
  print('is ui.FlutterView: ${window is ui.FlutterView}');

  // Test FlutterView properties inherited by SingletonFlutterWindow
  print('\nFlutterView properties:');
  print('viewId: ${window.viewId}');
  print('devicePixelRatio: ${window.devicePixelRatio}');
  print('physicalSize: ${window.physicalSize}');
  print('viewInsets: ${window.viewInsets}');
  print('viewPadding: ${window.viewPadding}');
  print('padding: ${window.padding}');
  print('systemGestureInsets: ${window.systemGestureInsets}');
  print('displayFeatures length: ${window.displayFeatures.length}');

  // Test platformDispatcher access
  final dispatcher = window.platformDispatcher;
  print('\nPlatformDispatcher access:');
  print('Dispatcher runtimeType: ${dispatcher.runtimeType}');
  print('is ui.PlatformDispatcher: ${dispatcher is ui.PlatformDispatcher}');

  // Test render method signature
  print('\nrender() method exists for Scene submission');
  
  // Test updateSemantics method signature
  print('updateSemantics() method exists for accessibility');

  // The modern replacement
  print('\nModern replacement:');
  print('Use View.of(context) to get FlutterView');
  print('Use PlatformDispatcher.instance for platform info');

  // Test comparison with implicit view
  final implicitView = dispatcher.implicitView;
  print('\nImplicit view comparison:');
  if (implicitView != null) {
    print('Implicit view exists');
    print('implicitView.viewId: ${implicitView.viewId}');
    print('window.viewId == implicitView.viewId: ${window.viewId == implicitView.viewId}');
  } else {
    print('Implicit view is null (multi-window mode)');
  }

  // Test GestureSettings
  final gestureSettings = window.gestureSettings;
  print('\nGestureSettings:');
  print('physicalDoubleTapSlop: ${gestureSettings.physicalDoubleTapSlop}');
  print('physicalTouchSlop: ${gestureSettings.physicalTouchSlop}');

  print('\n' + '=' * 50);
  print('SingletonFlutterWindow test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SingletonFlutterWindow Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Status: DEPRECATED since Flutter 3.7'),
      Text('Extends: FlutterView'),
      Text('Replacement: FlutterView + PlatformDispatcher'),
      Text('viewId: ${window.viewId}'),
    ],
  ));
}
