// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SingletonFlutterWindow (deprecated, via PlatformDispatcher)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SingletonFlutterWindow test executing');

  // SingletonFlutterWindow is deprecated — use PlatformDispatcher
  final pd = ui.PlatformDispatcher.instance;
  final view = pd.implicitView;
  print('PlatformDispatcher.implicitView: ${view != null}');
  if (view != null) {
    print('viewId: ${view.viewId}');
    print('devicePixelRatio: ${view.devicePixelRatio}');
    print('physicalSize: ${view.physicalSize}');
  }

  // WidgetsBinding window access
  final binding = WidgetsBinding.instance;
  print('binding type: ${binding.runtimeType}');

  print('SingletonFlutterWindow test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('SingletonFlutterWindow Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Deprecated — use PlatformDispatcher'),
    if (view != null) Text('viewId: ${view.viewId}'),
    if (view != null) Text('DPR: ${view.devicePixelRatio}'),
  ]);
}
