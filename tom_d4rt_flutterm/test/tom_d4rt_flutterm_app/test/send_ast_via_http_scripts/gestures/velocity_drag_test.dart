// D4rt test script: Tests VelocityEstimate, VelocityTracker,
// DragStartBehavior, DragUpdateDetails, DragEndDetails, DragDownDetails,
// LongPressMoveUpdateDetails, ScaleStartDetails enum types
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('Gestures velocity/drag test executing');

  // ========== VelocityEstimate ==========
  print('--- VelocityEstimate Tests ---');
  final estimate = VelocityEstimate(
    pixelsPerSecond: Offset(100.0, 200.0),
    confidence: 0.95,
    duration: Duration(milliseconds: 100),
    offset: Offset(50.0, 100.0),
  );
  print('VelocityEstimate: ${estimate.pixelsPerSecond}');
  print('  confidence: ${estimate.confidence}');
  print('  duration: ${estimate.duration}');
  print('  offset: ${estimate.offset}');

  // ========== VelocityTracker ==========
  print('--- VelocityTracker Tests ---');
  final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  print('VelocityTracker created for touch');
  // Simulate adding positions
  tracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  tracker.addPosition(Duration(milliseconds: 16), Offset(10, 5));
  tracker.addPosition(Duration(milliseconds: 32), Offset(20, 10));
  tracker.addPosition(Duration(milliseconds: 48), Offset(30, 15));
  final velocity = tracker.getVelocityEstimate();
  if (velocity != null) {
    print('  pixelsPerSecond: ${velocity.pixelsPerSecond}');
    print('  confidence: ${velocity.confidence}');
  } else {
    print('  velocity estimate: null');
  }

  // ========== IOSScrollViewFlingVelocityTracker ==========
  print('--- IOSScrollViewFlingVelocityTracker Tests ---');
  final iosTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  iosTracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  iosTracker.addPosition(Duration(milliseconds: 16), Offset(0, 10));
  print('IOSScrollViewFlingVelocityTracker created');

  // ========== DragStartBehavior ==========
  print('--- DragStartBehavior Tests ---');
  for (final behavior in DragStartBehavior.values) {
    print('DragStartBehavior: ${behavior.name}');
  }

  // ========== DragDownDetails ==========
  print('--- DragDownDetails Tests ---');
  final dragDown = DragDownDetails(
    globalPosition: Offset(150.0, 300.0),
    localPosition: Offset(50.0, 100.0),
  );
  print(
    'DragDownDetails: global=${dragDown.globalPosition}, local=${dragDown.localPosition}',
  );

  // ========== DragStartDetails ==========
  print('--- DragStartDetails Tests ---');
  final dragStart = DragStartDetails(
    globalPosition: Offset(150.0, 300.0),
    localPosition: Offset(50.0, 100.0),
    sourceTimeStamp: Duration(milliseconds: 500),
  );
  print('DragStartDetails: global=${dragStart.globalPosition}');
  print('  sourceTimeStamp: ${dragStart.sourceTimeStamp}');

  // ========== DragUpdateDetails ==========
  print('--- DragUpdateDetails Tests ---');
  final dragUpdate = DragUpdateDetails(
    globalPosition: Offset(160.0, 310.0),
    localPosition: Offset(60.0, 110.0),
    delta: Offset(10.0, 10.0),
    primaryDelta: 10.0,
    sourceTimeStamp: Duration(milliseconds: 516),
  );
  print('DragUpdateDetails: delta=${dragUpdate.delta}');
  print('  primaryDelta: ${dragUpdate.primaryDelta}');

  // ========== DragEndDetails ==========
  print('--- DragEndDetails Tests ---');
  final dragEnd = DragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(200.0, 100.0)),
    primaryVelocity: 200.0,
  );
  print('DragEndDetails: velocity=${dragEnd.velocity}');
  print('  primaryVelocity: ${dragEnd.primaryVelocity}');

  // ========== LongPressStartDetails ==========
  print('--- LongPressStartDetails Tests ---');
  final longStart = LongPressStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
  );
  print('LongPressStartDetails: ${longStart.globalPosition}');

  // ========== LongPressMoveUpdateDetails ==========
  print('--- LongPressMoveUpdateDetails Tests ---');
  final longMove = LongPressMoveUpdateDetails(
    globalPosition: Offset(110.0, 210.0),
    localPosition: Offset(60.0, 110.0),
    offsetFromOrigin: Offset(10.0, 10.0),
    localOffsetFromOrigin: Offset(10.0, 10.0),
  );
  print('LongPressMoveUpdateDetails: offset=${longMove.offsetFromOrigin}');

  // ========== LongPressEndDetails ==========
  print('--- LongPressEndDetails Tests ---');
  final longEnd = LongPressEndDetails(
    globalPosition: Offset(110.0, 210.0),
    localPosition: Offset(60.0, 110.0),
    velocity: Velocity.zero,
  );
  print('LongPressEndDetails: ${longEnd.globalPosition}');

  print('All gesture velocity/drag tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gesture Velocity/Drag Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              dragStartBehavior: DragStartBehavior.start,
              onPanStart: (details) {},
              onPanUpdate: (details) {},
              onPanEnd: (details) {},
              onLongPressStart: (details) {},
              onLongPressMoveUpdate: (details) {},
              onLongPressEnd: (details) {},
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue.shade100,
                child: Center(child: Text('Drag here')),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
