// D4rt test script: Tests gesture detail classes
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gestures detail test executing');

  // ========== TAP DETAILS ==========
  print('--- TapDownDetails Tests ---');

  final tapDownDetails = TapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    kind: PointerDeviceKind.touch,
  );
  print('TapDownDetails:');
  print('  globalPosition: ${tapDownDetails.globalPosition}');
  print('  localPosition: ${tapDownDetails.localPosition}');
  print('  kind: ${tapDownDetails.kind}');

  // Test with default localPosition
  final tapDownGlobalOnly = TapDownDetails(
    globalPosition: Offset(150.0, 250.0),
  );
  print('TapDownDetails (global only): ${tapDownGlobalOnly.globalPosition}');
  print('  local defaults to global: ${tapDownGlobalOnly.localPosition}');

  // Test different pointer kinds
  final tapDownMouse = TapDownDetails(
    globalPosition: Offset(100.0, 100.0),
    kind: PointerDeviceKind.mouse,
  );
  print('TapDownDetails with mouse: ${tapDownMouse.kind}');

  final tapDownStylus = TapDownDetails(
    globalPosition: Offset(100.0, 100.0),
    kind: PointerDeviceKind.stylus,
  );
  print('TapDownDetails with stylus: ${tapDownStylus.kind}');

  print('--- TapUpDetails Tests ---');

  final tapUpDetails = TapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    kind: PointerDeviceKind.touch,
  );
  print('TapUpDetails:');
  print('  globalPosition: ${tapUpDetails.globalPosition}');
  print('  localPosition: ${tapUpDetails.localPosition}');
  print('  kind: ${tapUpDetails.kind}');

  // ========== DRAG DETAILS ==========
  print('--- DragStartDetails Tests ---');

  final dragStartDetails = DragStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    sourceTimeStamp: Duration(milliseconds: 1000),
    kind: PointerDeviceKind.touch,
  );
  print('DragStartDetails:');
  print('  globalPosition: ${dragStartDetails.globalPosition}');
  print('  localPosition: ${dragStartDetails.localPosition}');
  print('  sourceTimeStamp: ${dragStartDetails.sourceTimeStamp}');
  print('  kind: ${dragStartDetails.kind}');

  print('--- DragUpdateDetails Tests ---');

  final dragUpdateDetails = DragUpdateDetails(
    globalPosition: Offset(150.0, 250.0),
    localPosition: Offset(100.0, 130.0),
    delta: Offset(0.0, 15.0),
    primaryDelta: 15.0,
    sourceTimeStamp: Duration(milliseconds: 1100),
  );
  print('DragUpdateDetails:');
  print('  globalPosition: ${dragUpdateDetails.globalPosition}');
  print('  localPosition: ${dragUpdateDetails.localPosition}');
  print('  delta: ${dragUpdateDetails.delta}');
  print('  primaryDelta: ${dragUpdateDetails.primaryDelta}');
  print('  sourceTimeStamp: ${dragUpdateDetails.sourceTimeStamp}');

  // Test with just required params
  final dragUpdateMinimal = DragUpdateDetails(
    globalPosition: Offset(200.0, 300.0),
  );
  print(
    'DragUpdateDetails minimal: global=${dragUpdateMinimal.globalPosition}',
  );

  print('--- DragEndDetails Tests ---');

  final dragEndDetails = DragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(0.0, 300.0)),
    primaryVelocity: 300.0,
  );
  print('DragEndDetails:');
  print('  velocity: ${dragEndDetails.velocity}');
  print('  primaryVelocity: ${dragEndDetails.primaryVelocity}');

  // Test with zero velocity
  final dragEndStopped = DragEndDetails(velocity: Velocity.zero);
  print('DragEndDetails stopped: velocity=${dragEndStopped.velocity}');

  // ========== VELOCITY ==========
  print('--- Velocity Tests ---');

  final velocity = Velocity(pixelsPerSecond: Offset(100.0, 200.0));
  print('Velocity: ${velocity.pixelsPerSecond}');

  final velocityZero = Velocity.zero;
  print('Velocity.zero: ${velocityZero.pixelsPerSecond}');

  // Test velocity operations
  final negatedVelocity = -velocity;
  print('Negated velocity: ${negatedVelocity.pixelsPerSecond}');

  final addedVelocity =
      velocity + Velocity(pixelsPerSecond: Offset(50.0, 50.0));
  print('Added velocity: ${addedVelocity.pixelsPerSecond}');

  final subtractedVelocity =
      velocity - Velocity(pixelsPerSecond: Offset(50.0, 50.0));
  print('Subtracted velocity: ${subtractedVelocity.pixelsPerSecond}');

  // Test clampMagnitude
  final fastVelocity = Velocity(pixelsPerSecond: Offset(1000.0, 1000.0));
  final clampedVelocity = fastVelocity.clampMagnitude(100.0, 500.0);
  print('Clamped velocity (max 500): ${clampedVelocity.pixelsPerSecond}');

  // ========== LONG PRESS DETAILS ==========
  print('--- LongPressStartDetails Tests ---');

  final longPressStartDetails = LongPressStartDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
  );
  print('LongPressStartDetails:');
  print('  globalPosition: ${longPressStartDetails.globalPosition}');
  print('  localPosition: ${longPressStartDetails.localPosition}');

  print('--- LongPressMoveUpdateDetails Tests ---');

  final longPressMoveDetails = LongPressMoveUpdateDetails(
    globalPosition: Offset(120.0, 220.0),
    localPosition: Offset(70.0, 100.0),
    offsetFromOrigin: Offset(20.0, 20.0),
    localOffsetFromOrigin: Offset(20.0, 20.0),
  );
  print('LongPressMoveUpdateDetails:');
  print('  globalPosition: ${longPressMoveDetails.globalPosition}');
  print('  offsetFromOrigin: ${longPressMoveDetails.offsetFromOrigin}');

  print('--- LongPressEndDetails Tests ---');

  final longPressEndDetails = LongPressEndDetails(
    globalPosition: Offset(130.0, 230.0),
    localPosition: Offset(80.0, 110.0),
    velocity: Velocity(pixelsPerSecond: Offset(100.0, 50.0)),
  );
  print('LongPressEndDetails:');
  print('  globalPosition: ${longPressEndDetails.globalPosition}');
  print('  velocity: ${longPressEndDetails.velocity}');

  // ========== SCALE DETAILS ==========
  print('--- ScaleStartDetails Tests ---');

  final scaleStartDetails = ScaleStartDetails(
    focalPoint: Offset(150.0, 150.0),
    localFocalPoint: Offset(75.0, 75.0),
    pointerCount: 2,
  );
  print('ScaleStartDetails:');
  print('  focalPoint: ${scaleStartDetails.focalPoint}');
  print('  localFocalPoint: ${scaleStartDetails.localFocalPoint}');
  print('  pointerCount: ${scaleStartDetails.pointerCount}');

  print('--- ScaleUpdateDetails Tests ---');

  final scaleUpdateDetails = ScaleUpdateDetails(
    focalPoint: Offset(160.0, 160.0),
    localFocalPoint: Offset(80.0, 80.0),
    scale: 1.5,
    horizontalScale: 1.5,
    verticalScale: 1.5,
    rotation: 0.785, // 45 degrees
    pointerCount: 2,
    focalPointDelta: Offset(10.0, 10.0),
  );
  print('ScaleUpdateDetails:');
  print('  focalPoint: ${scaleUpdateDetails.focalPoint}');
  print('  scale: ${scaleUpdateDetails.scale}');
  print('  horizontalScale: ${scaleUpdateDetails.horizontalScale}');
  print('  verticalScale: ${scaleUpdateDetails.verticalScale}');
  print('  rotation: ${scaleUpdateDetails.rotation}');
  print('  pointerCount: ${scaleUpdateDetails.pointerCount}');
  print('  focalPointDelta: ${scaleUpdateDetails.focalPointDelta}');

  print('--- ScaleEndDetails Tests ---');

  final scaleEndDetails = ScaleEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(200.0, 100.0)),
    scaleVelocity: 0.5,
    pointerCount: 0,
  );
  print('ScaleEndDetails:');
  print('  velocity: ${scaleEndDetails.velocity}');
  print('  scaleVelocity: ${scaleEndDetails.scaleVelocity}');
  print('  pointerCount: ${scaleEndDetails.pointerCount}');

  // ========== FORCE PRESS DETAILS ==========
  print('--- ForcePressDetails Tests ---');

  final forcePressDetails = ForcePressDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    pressure: 0.8,
  );
  print('ForcePressDetails:');
  print('  globalPosition: ${forcePressDetails.globalPosition}');
  print('  localPosition: ${forcePressDetails.localPosition}');
  print('  pressure: ${forcePressDetails.pressure}');

  // ========== OFFSET PAIR ==========
  print('--- OffsetPair Tests ---');

  final offsetPair = OffsetPair(
    local: Offset(50.0, 80.0),
    global: Offset(100.0, 200.0),
  );
  print('OffsetPair:');
  print('  local: ${offsetPair.local}');
  print('  global: ${offsetPair.global}');

  final zeroOffsetPair = OffsetPair.zero;
  print(
    'OffsetPair.zero: local=${zeroOffsetPair.local}, global=${zeroOffsetPair.global}',
  );

  // Test from event globals using PointerDownEvent
  final pointerEvent = PointerDownEvent(
    position: Offset(100.0, 200.0),
  );
  final fromGlobals = OffsetPair.fromEventPosition(pointerEvent);
  print('OffsetPair.fromEventPosition: local=${fromGlobals.local}, global=${fromGlobals.global}');

  // Test operations
  final addedPair =
      offsetPair +
      OffsetPair(local: Offset(10.0, 10.0), global: Offset(20.0, 20.0));
  print(
    'Added OffsetPair: local=${addedPair.local}, global=${addedPair.global}',
  );

  final subtractedPair =
      offsetPair -
      OffsetPair(local: Offset(10.0, 10.0), global: Offset(20.0, 20.0));
  print(
    'Subtracted OffsetPair: local=${subtractedPair.local}, global=${subtractedPair.global}',
  );

  print('Gestures detail test completed');

  // Return a visual representation with interactive gestures
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gesture Details Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Tap Gestures:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                GestureDetector(
                  onTapDown: (details) =>
                      print('TapDown: ${details.globalPosition}'),
                  onTapUp: (details) =>
                      print('TapUp: ${details.globalPosition}'),
                  onTap: () => print('Tap'),
                  child: Container(
                    width: 80.0,
                    height: 60.0,
                    color: Color(0xFF2196F3),
                    child: Center(
                      child: Text(
                        'Tap',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onDoubleTap: () => print('DoubleTap'),
                  child: Container(
                    width: 80.0,
                    height: 60.0,
                    color: Color(0xFF4CAF50),
                    child: Center(
                      child: Text(
                        'Double',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Drag Gestures:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                GestureDetector(
                  onHorizontalDragStart: (d) =>
                      print('HorizDrag: ${d.globalPosition}'),
                  onHorizontalDragUpdate: (d) => print('HorizMove: ${d.delta}'),
                  onHorizontalDragEnd: (d) => print('HorizEnd: ${d.velocity}'),
                  child: Container(
                    width: 100.0,
                    height: 60.0,
                    color: Color(0xFFFF9800),
                    child: Center(
                      child: Text(
                        'H-Drag',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                GestureDetector(
                  onVerticalDragStart: (d) =>
                      print('VertDrag: ${d.globalPosition}'),
                  onVerticalDragUpdate: (d) => print('VertMove: ${d.delta}'),
                  onVerticalDragEnd: (d) => print('VertEnd: ${d.velocity}'),
                  child: Container(
                    width: 100.0,
                    height: 60.0,
                    color: Color(0xFFE53935),
                    child: Center(
                      child: Text(
                        'V-Drag',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Long Press:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            GestureDetector(
              onLongPressStart: (d) => print('LongPress: ${d.globalPosition}'),
              onLongPressMoveUpdate: (d) =>
                  print('LongMove: ${d.offsetFromOrigin}'),
              onLongPressEnd: (d) => print('LongEnd: ${d.velocity}'),
              child: Container(
                width: 120.0,
                height: 60.0,
                color: Color(0xFF9C27B0),
                child: Center(
                  child: Text(
                    'Long Press',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            Text('Scale/Pinch:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            GestureDetector(
              onScaleStart: (d) => print('ScaleStart: ${d.focalPoint}'),
              onScaleUpdate: (d) => print(
                'ScaleUpdate: scale=${d.scale}, rotation=${d.rotation}',
              ),
              onScaleEnd: (d) => print('ScaleEnd: ${d.velocity}'),
              child: Container(
                width: 150.0,
                height: 80.0,
                color: Color(0xFF607D8B),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scale/Rotate',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                      Text(
                        '(pinch gesture)',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Detail Classes Summary:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• TapDownDetails - position, kind',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• TapUpDetails - position, kind',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• DragStartDetails - position, timestamp',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• DragUpdateDetails - delta, position',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• DragEndDetails - velocity',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• LongPressStartDetails - position',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• LongPressMoveUpdateDetails - offset',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• LongPressEndDetails - velocity',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• ScaleStartDetails - focalPoint, count',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• ScaleUpdateDetails - scale, rotation',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• ScaleEndDetails - velocity',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
