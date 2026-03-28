// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetsServiceExtensions from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetsServiceExtensions test executing');
  print('=' * 50);

  // WidgetsServiceExtensions mixin for service extensions
  print('WidgetsServiceExtensions overview:');
  print('  - Mixin on BindingBase');
  print('  - Registers widget-layer service extensions');
  print('  - For debugging and dev tools');

  // Service extensions registered
  print('\nService extensions registered:');
  print('  - ext.flutter.debugDumpApp');
  print('  - ext.flutter.debugDumpRenderTree');
  print('  - ext.flutter.debugDumpLayerTree');
  print('  - ext.flutter.debugDumpFocusTree');
  print('  - ext.flutter.debugDumpSemanticsTree');
  print('  - ext.flutter.showPerformanceOverlay');
  print('  - ext.flutter.didSendFirstFrameEvent');
  print('  - ext.flutter.didSendFirstFrameRasterizedEvent');
  print('  - ext.flutter.fastReassemble');
  print('  - ext.flutter.profileWidgetBuilds');
  print('  - ext.flutter.debugAllowBanner');

  // How they are used
  print('\nUsed via:');
  print('  - Flutter DevTools');
  print('  - flutter attach');
  print('  - IDE debugger integration');
  print('  - vm_service protocol');

  // Debug mode only
  print('\nAvailability:');
  print('  - Most only in debug/profile mode');
  print('  - Stripped in release builds');
  print('  - Some need --enable-asserts');

  // Manual invocation (dev tools)
  print('\nDevTools usage:');
  print('  1. Connect to running app');
  print('  2. Inspector tab');
  print('  3. "Dump App" button calls debugDumpApp');
  print('  4. Widget tree shown in output');

  // showPerformanceOverlay
  print('\nshowPerformanceOverlay:');
  print('  - Toggle performance overlay');
  print('  - Shows GPU/UI thread timing');
  print('  - Available via DevTools');

  // debugDumpApp example
  print('\ndebugDumpApp output includes:');
  print('  - Widget tree structure');
  print('  - RenderObject tree');
  print('  - Parent-child relationships');
  print('  - Key information');

  // fastReassemble
  print('\nfastReassemble:');
  print('  - For hot reload');
  print('  - Quickly updates widget tree');
  print('  - Preserves state when possible');

  print('\n' + '=' * 50);
  print('WidgetsServiceExtensions test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetsServiceExtensions Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin on BindingBase'),
      Text('Purpose: Debug service extensions'),
      Text('Key: debugDumpApp, showPerformanceOverlay'),
    ],
  );
}
