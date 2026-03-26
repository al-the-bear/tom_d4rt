// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SingletonFlutterWindow from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SingletonFlutterWindow test executing');
  print('=' * 50);

  // SingletonFlutterWindow overview
  print('\nSingletonFlutterWindow overview:');
  print('Purpose: Deprecated singleton representing the main window');
  print('Access: WidgetsBinding.instance.window (deprecated)');
  print('Replacement: Use View.of(context) or PlatformDispatcher');

  // Access the deprecated window
  try {
    final window = WidgetsBinding.instance.window;
    print('\nWindow accessed via WidgetsBinding.instance.window');
    print('runtimeType: ${window.runtimeType}');

    // Physical properties
    print('\nPhysical properties:');
    print('devicePixelRatio: ${window.devicePixelRatio}');
    print('physicalSize: ${window.physicalSize}');
    print('viewInsets: ${window.viewInsets}');
    print('viewPadding: ${window.viewPadding}');
    print('padding: ${window.padding}');
    print('systemGestureInsets: ${window.systemGestureInsets}');

    // Display features
    print('\nDisplay features:');
    print('displayFeatures: ${window.displayFeatures.length} features');

    // Platform dispatcher properties
    print('\nPlatform dispatcher:');
    print('platformDispatcher: ${window.platformDispatcher.runtimeType}');
    print('locale: ${window.locale}');
    print('locales: ${window.locales.length} locales');
    print('textScaleFactor: ${window.textScaleFactor}');
    print('alwaysUse24HourFormat: ${window.alwaysUse24HourFormat}');
    print('semanticsEnabled: ${window.semanticsEnabled}');
    print('accessibilityFeatures: ${window.accessibilityFeatures}');
  } catch (e) {
    print('Window access error: $e');
  }

  // Modern alternative: View.of(context)
  print('\n--- Modern alternative: View.of(context) ---');
  try {
    final view = View.of(context);
    print('View obtained from context');
    print('runtimeType: ${view.runtimeType}');
    print('devicePixelRatio: ${view.devicePixelRatio}');
    print('physicalSize: ${view.physicalSize}');
    print('viewInsets: ${view.viewInsets}');
    print('viewPadding: ${view.viewPadding}');
    print('padding: ${view.padding}');
  } catch (e) {
    print('View.of(context) error: $e');
  }

  // PlatformDispatcher
  print('\n--- PlatformDispatcher ---');
  final dispatcher = ui.PlatformDispatcher.instance;
  print('PlatformDispatcher.instance obtained');
  print('locale: ${dispatcher.locale}');
  print('locales: ${dispatcher.locales.length} locales');
  print('semanticsEnabled: ${dispatcher.semanticsEnabled}');
  print('views: ${dispatcher.views.length} views');

  print('\n' + '=' * 50);
  print('SingletonFlutterWindow test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SingletonFlutterWindow Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Deprecated window: accessed'),
      Text('View.of(context): modern alternative'),
      Text('PlatformDispatcher: ${dispatcher.locale}'),
      Text('Status: Use View.of(context) instead'),
    ],
  );
}
