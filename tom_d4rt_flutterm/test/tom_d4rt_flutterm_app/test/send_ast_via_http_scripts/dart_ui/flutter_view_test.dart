// D4rt test script: Tests FlutterView from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterView test executing');

  final dispatcher = ui.PlatformDispatcher.instance;
  final view = dispatcher.implicitView;
  print('implicitView: ${view != null ? "available" : "null"}');

  if (view != null) {
    print('viewId: ${view.viewId}');
    print('devicePixelRatio: ${view.devicePixelRatio}');
    print('physicalSize: ${view.physicalSize}');
    print('physicalConstraints: ${view.physicalConstraints}');

    // ViewPadding getters
    final viewInsets = view.viewInsets;
    print('viewInsets: left=${viewInsets.left}, top=${viewInsets.top}, right=${viewInsets.right}, bottom=${viewInsets.bottom}');

    final viewPadding = view.viewPadding;
    print('viewPadding: left=${viewPadding.left}, top=${viewPadding.top}');

    final padding = view.padding;
    print('padding: left=${padding.left}, top=${padding.top}');

    final gestureInsets = view.systemGestureInsets;
    print('systemGestureInsets: left=${gestureInsets.left}, bottom=${gestureInsets.bottom}');

    // GestureSettings
    final gestures = view.gestureSettings;
    print('gestureSettings: touchSlop=${gestures.physicalTouchSlop}, doubleTapSlop=${gestures.physicalDoubleTapSlop}');

    // DisplayFeatures
    final displayFeatures = view.displayFeatures;
    print('displayFeatures count: ${displayFeatures.length}');

    // Display
    final display = view.display;
    print('display.id: ${display.id}');
    print('display.devicePixelRatio: ${display.devicePixelRatio}');
    print('display.size: ${display.size}');
    print('display.refreshRate: ${display.refreshRate}');

    // PlatformDispatcher reference
    final pd = view.platformDispatcher;
    print('platformDispatcher: ${pd.runtimeType}');
    print('toString: ${view.toString()}');
  }

  // Also check views iterable
  final views = dispatcher.views;
  print('views count: ${views.length}');

  print('FlutterView test completed');
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('FlutterView Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            if (view != null) ...[
              Text('viewId: ${view.viewId}'),
              Text('DPR: ${view.devicePixelRatio}'),
              Text('physicalSize: ${view.physicalSize}'),
              Text('display: ${view.display.size}'),
              Text('features: ${view.displayFeatures.length}'),
            ],
          ],
        ),
      ),
    ),
  );
}
