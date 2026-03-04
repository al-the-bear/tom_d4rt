// D4rt test script: Tests MediaQueryData, MediaQuery, ViewPadding,
// DeviceGestureSettings, FlexibleSpaceBarSettings, Orientation,
// NavigatorState
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MediaQuery advanced test executing');

  // ========== MediaQueryData ==========
  print('--- MediaQueryData Tests ---');
  final mqData = MediaQueryData(
    size: Size(412.0, 892.0),
    devicePixelRatio: 2.75,
    textScaler: TextScaler.linear(1.0),
    platformBrightness: Brightness.light,
    padding: EdgeInsets.only(top: 24.0, bottom: 34.0),
    viewPadding: EdgeInsets.only(top: 24.0, bottom: 34.0),
    viewInsets: EdgeInsets.zero,
    systemGestureInsets: EdgeInsets.only(left: 20.0, right: 20.0),
    alwaysUse24HourFormat: false,
    accessibleNavigation: false,
    invertColors: false,
    highContrast: false,
    onOffSwitchLabels: false,
    disableAnimations: false,
    boldText: false,
    navigationMode: NavigationMode.traditional,
    gestureSettings: DeviceGestureSettings(touchSlop: 18.0),
    displayFeatures: [],
  );
  print('MediaQueryData created');
  print('  size: ${mqData.size}');
  print('  devicePixelRatio: ${mqData.devicePixelRatio}');
  print('  padding: ${mqData.padding}');
  print('  viewInsets: ${mqData.viewInsets}');
  print('  platformBrightness: ${mqData.platformBrightness}');
  print('  navigationMode: ${mqData.navigationMode}');

  // ========== MediaQueryData.copyWith ==========
  print('--- MediaQueryData copyWith ---');
  final copied = mqData.copyWith(
    size: Size(800, 600),
    platformBrightness: Brightness.dark,
  );
  print('Copied: size=${copied.size}, brightness=${copied.platformBrightness}');

  // ========== NavigationMode ==========
  print('--- NavigationMode Tests ---');
  for (final mode in NavigationMode.values) {
    print('  NavigationMode: $mode');
  }

  // ========== DeviceGestureSettings ==========
  print('--- DeviceGestureSettings Tests ---');
  final gestureSettings = DeviceGestureSettings(touchSlop: 18.0);
  print('DeviceGestureSettings created: touchSlop=${gestureSettings.touchSlop}');

  final gestureSettingsPan = DeviceGestureSettings(touchSlop: 36.0);
  print('DeviceGestureSettings pan: touchSlop=${gestureSettingsPan.touchSlop}');

  // ========== Orientation ==========
  print('--- Orientation Tests ---');
  for (final o in Orientation.values) {
    print('  Orientation: $o');
  }

  // ========== MediaQuery widget ==========
  print('--- MediaQuery Widget Tests ---');
  final mediaQuery = MediaQuery(
    data: mqData,
    child: Text('Media Query'),
  );
  print('MediaQuery widget created');

  final removeViewPaddingQuery = MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: Text('No top padding'),
  );
  print('MediaQuery.removePadding created');

  final removeViewInsetsQuery = MediaQuery.removeViewInsets(
    context: context,
    removeBottom: true,
    child: Text('No bottom insets'),
  );
  print('MediaQuery.removeViewInsets created');

  // ========== FlexibleSpaceBarSettings ==========
  print('--- FlexibleSpaceBarSettings Tests ---');
  final flexSettings = FlexibleSpaceBarSettings(
    toolbarOpacity: 0.8,
    minExtent: 56.0,
    maxExtent: 200.0,
    currentExtent: 150.0,
    child: Text('FlexSpace'),
  );
  print('FlexibleSpaceBarSettings created');
  print('  toolbarOpacity: ${flexSettings.toolbarOpacity}');
  print('  minExtent: ${flexSettings.minExtent}');
  print('  maxExtent: ${flexSettings.maxExtent}');
  print('  currentExtent: ${flexSettings.currentExtent}');

  print('All media query tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: mediaQuery,
    ),
  );
}
