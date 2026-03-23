// ignore_for_file: avoid_print
// D4rt test script: Tests PlatformDispatcher from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformDispatcher test executing');

  // Singleton instance
  final pd = ui.PlatformDispatcher.instance;
  print('PlatformDispatcher type: ${pd.runtimeType}');

  // Display & view info
  print('displays: ${pd.displays.length}');
  print('views: ${pd.views.length}');
  print('implicitView: ${pd.implicitView != null ? "available" : "null"}');

  // Locale info
  print('locale: ${pd.locale}');
  print('locales: ${pd.locales.length} locale(s)');
  if (pd.locales.isNotEmpty) {
    print('first locale: ${pd.locales.first}');
  }

  // Platform settings
  print('textScaleFactor: ${pd.textScaleFactor}');
  print('platformBrightness: ${pd.platformBrightness}');
  print('alwaysUse24HourFormat: ${pd.alwaysUse24HourFormat}');
  print('semanticsEnabled: ${pd.semanticsEnabled}');
  print('defaultRouteName: ${pd.defaultRouteName}');

  // Accessibility
  final af = pd.accessibilityFeatures;
  print('accessibilityFeatures: ${af.runtimeType}');

  // Frame data
  final fd = pd.frameData;
  print('frameData.frameNumber: ${fd.frameNumber}');

  // SpellCheck / context menu support
  print('nativeSpellCheckServiceDefined: ${pd.nativeSpellCheckServiceDefined}');
  print('supportsShowingSystemContextMenu: ${pd.supportsShowingSystemContextMenu}');
  print('brieflyShowPassword: ${pd.brieflyShowPassword}');

  // System font
  print('systemFontFamily: ${pd.systemFontFamily}');

  // scaleFontSize
  final scaled = pd.scaleFontSize(16.0);
  print('scaleFontSize(16): $scaled');
  final scaled2 = pd.scaleFontSize(24.0);
  print('scaleFontSize(24): $scaled2');

  print('PlatformDispatcher test completed');
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PlatformDispatcher Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('locale: ${pd.locale}'),
            Text('brightness: ${pd.platformBrightness}'),
            Text('textScaleFactor: ${pd.textScaleFactor}'),
            Text('displays: ${pd.displays.length}'),
            Text('views: ${pd.views.length}'),
            Text('semanticsEnabled: ${pd.semanticsEnabled}'),
          ],
        ),
      ),
    ),
  );
}
