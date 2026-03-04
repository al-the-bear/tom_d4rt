// D4rt test script: Tests GestureScaleEndCallback, GestureLongPressCallback, GestureLongPressStartCallback, GestureLongPressMoveUpdateCallback, GestureLongPressEndCallback, VelocityEstimator (IOSScrollViewFlingVelocityTracker), MacOSScrollViewFlingVelocityTracker, MultiTouchDragStrategy
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Advanced gesture callbacks and velocity tracking tests executing');

  // ========== GestureScaleEndCallback ==========
  print('--- GestureScaleEndCallback Tests ---');
  // GestureScaleEndCallback = void Function(ScaleEndDetails)
  final GestureScaleEndCallback scaleEndCallback = (ScaleEndDetails details) {
    print('Scale ended with velocity: ${details.velocity}');
  };
  print('GestureScaleEndCallback type: ${scaleEndCallback.runtimeType}');

  // ========== GestureLongPressCallback ==========
  print('--- GestureLongPressCallback Tests ---');
  // GestureLongPressCallback = void Function()
  final GestureLongPressCallback longPressCallback = () {
    print('Long press detected');
  };
  print('GestureLongPressCallback type: ${longPressCallback.runtimeType}');

  // ========== GestureLongPressStartCallback ==========
  print('--- GestureLongPressStartCallback Tests ---');
  // GestureLongPressStartCallback = void Function(LongPressStartDetails)
  final GestureLongPressStartCallback longPressStartCallback = (LongPressStartDetails details) {
    print('Long press started at: ${details.globalPosition}');
  };
  print('GestureLongPressStartCallback type: ${longPressStartCallback.runtimeType}');

  // ========== GestureLongPressMoveUpdateCallback ==========
  print('--- GestureLongPressMoveUpdateCallback Tests ---');
  // GestureLongPressMoveUpdateCallback = void Function(LongPressMoveUpdateDetails)
  final GestureLongPressMoveUpdateCallback longPressMoveCallback = (LongPressMoveUpdateDetails details) {
    print('Long press move to: ${details.globalPosition}');
  };
  print('GestureLongPressMoveUpdateCallback type: ${longPressMoveCallback.runtimeType}');

  // ========== GestureLongPressEndCallback ==========
  print('--- GestureLongPressEndCallback Tests ---');
  // GestureLongPressEndCallback = void Function(LongPressEndDetails)
  final GestureLongPressEndCallback longPressEndCallback = (LongPressEndDetails details) {
    print('Long press ended at: ${details.globalPosition}');
  };
  print('GestureLongPressEndCallback type: ${longPressEndCallback.runtimeType}');

  // Verify long press callbacks with GestureDetector
  final longPressDetector = GestureDetector(
    onLongPress: longPressCallback,
    onLongPressStart: longPressStartCallback,
    onLongPressMoveUpdate: longPressMoveCallback,
    onLongPressEnd: longPressEndCallback,
    child: Container(),
  );
  print('GestureDetector with long press callbacks: ${longPressDetector.runtimeType}');

  // Verify scale end callback with GestureDetector
  final scaleDetector = GestureDetector(
    onScaleEnd: scaleEndCallback,
    child: Container(),
  );
  print('GestureDetector with scale end callback: ${scaleDetector.runtimeType}');

  // ========== VelocityEstimator / IOSScrollViewFlingVelocityTracker ==========
  print('--- VelocityEstimator / IOSScrollViewFlingVelocityTracker Tests ---');
  // IOSScrollViewFlingVelocityTracker is a VelocityTracker subclass for iOS-style fling
  final iosTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('IOSScrollViewFlingVelocityTracker type: ${iosTracker.runtimeType}');
  print('IOSScrollViewFlingVelocityTracker kind: touch');

  // ========== MacOSScrollViewFlingVelocityTracker ==========
  print('--- MacOSScrollViewFlingVelocityTracker Tests ---');
  final macosTracker = MacOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('MacOSScrollViewFlingVelocityTracker type: ${macosTracker.runtimeType}');
  print('MacOSScrollViewFlingVelocityTracker kind: touch');

  // Both are VelocityTracker subclasses
  final standardTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  print('Standard VelocityTracker type: ${standardTracker.runtimeType}');
  print('iosTracker is VelocityTracker: ${iosTracker is VelocityTracker}');
  print('macosTracker is VelocityTracker: ${macosTracker is VelocityTracker}');

  // ========== MultitouchDragStrategy ==========
  print('--- MultitouchDragStrategy Tests ---');
  // MultitouchDragStrategy is an enum (note: lowercase 't' in 'touch')
  print('MultitouchDragStrategy values: ${MultitouchDragStrategy.values}');
  for (final strategy in MultitouchDragStrategy.values) {
    print('MultitouchDragStrategy.${strategy.name}: ${strategy.index}');
  }
  print('MultitouchDragStrategy.latestPointer: ${MultitouchDragStrategy.latestPointer}');
  print('MultitouchDragStrategy.averageBoundaryPointers: ${MultitouchDragStrategy.averageBoundaryPointers}');

  print('All advanced gesture callback tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gesture Callbacks Adv Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('GestureScaleEndCallback: defined'),
            Text('GestureLongPressCallback: defined'),
            Text('GestureLongPressStartCallback: defined'),
            Text('GestureLongPressMoveUpdateCallback: defined'),
            Text('GestureLongPressEndCallback: defined'),
            Text('IOSScrollViewFlingVelocityTracker: ${iosTracker.runtimeType}'),
            Text('MacOSScrollViewFlingVelocityTracker: ${macosTracker.runtimeType}'),
            Text('MultitouchDragStrategy: ${MultitouchDragStrategy.values.length} values'),
          ],
        ),
      ),
    ),
  );
}
