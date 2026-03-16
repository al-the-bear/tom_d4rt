// D4rt test script: Tests GestureSettings from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureSettings test executing');

  // Default constructor (null slops)
  final gs1 = ui.GestureSettings();
  print('GestureSettings(): touchSlop=${gs1.physicalTouchSlop}, doubleTapSlop=${gs1.physicalDoubleTapSlop}');

  // With physicalTouchSlop
  final gs2 = ui.GestureSettings(physicalTouchSlop: 18.0);
  print('GestureSettings(touchSlop:18): touchSlop=${gs2.physicalTouchSlop}');

  // With both slops
  final gs3 = ui.GestureSettings(physicalTouchSlop: 20.0, physicalDoubleTapSlop: 100.0);
  print('GestureSettings(20, 100): touchSlop=${gs3.physicalTouchSlop}, doubleTapSlop=${gs3.physicalDoubleTapSlop}');

  // copyWith
  final gs4 = gs3.copyWith(physicalTouchSlop: 30.0);
  print('copyWith(touchSlop:30): touchSlop=${gs4.physicalTouchSlop}, doubleTapSlop=${gs4.physicalDoubleTapSlop}');

  final gs5 = gs3.copyWith(physicalDoubleTapSlop: 50.0);
  print('copyWith(doubleTapSlop:50): touchSlop=${gs5.physicalTouchSlop}, doubleTapSlop=${gs5.physicalDoubleTapSlop}');

  // Equality
  final gs6 = ui.GestureSettings(physicalTouchSlop: 20.0, physicalDoubleTapSlop: 100.0);
  print('gs3 == gs6 (same params): ${gs3 == gs6}');
  print('gs3 == gs2 (different): ${gs3 == gs2}');
  print('gs3.hashCode == gs6.hashCode: ${gs3.hashCode == gs6.hashCode}');

  // toString
  print('gs3 toString: ${gs3.toString()}');

  // Access from FlutterView
  final dispatcher = ui.PlatformDispatcher.instance;
  final view = dispatcher.implicitView;
  if (view != null) {
    final viewGS = view.gestureSettings;
    print('View gestureSettings: touchSlop=${viewGS.physicalTouchSlop}');
  }

  print('GestureSettings test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GestureSettings Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Default: touchSlop=${gs1.physicalTouchSlop}'),
      Text('Custom: touchSlop=${gs3.physicalTouchSlop}, dtSlop=${gs3.physicalDoubleTapSlop}'),
      Text('copyWith: touchSlop=${gs4.physicalTouchSlop}'),
      Text('Equality: ${gs3 == gs6}'),
    ],
  );
}
