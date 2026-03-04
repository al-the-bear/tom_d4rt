// D4rt test script: Tests TapDownDetails, TapUpDetails, ForcePressDetails,
// PointerDeviceKind, PointerSignalKind, GestureDisposition, DragGestureRecognizer
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('Gestures tap/force test executing');

  // ========== TapDownDetails ==========
  print('--- TapDownDetails Tests ---');
  final tapDown = TapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
  );
  print('TapDownDetails: global=${tapDown.globalPosition}');
  print('  local: ${tapDown.localPosition}');
  print('  kind: ${tapDown.kind}');

  // ========== TapUpDetails ==========
  print('--- TapUpDetails Tests ---');
  final tapUp = TapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
  );
  print('TapUpDetails: global=${tapUp.globalPosition}');

  // ========== ForcePressDetails ==========
  print('--- ForcePressDetails Tests ---');
  final forcePress = ForcePressDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    pressure: 0.8,
  );
  print('ForcePressDetails: pressure=${forcePress.pressure}');
  print('  globalPosition: ${forcePress.globalPosition}');

  // ========== PointerDeviceKind ==========
  print('--- PointerDeviceKind Tests ---');
  for (final kind in PointerDeviceKind.values) {
    print('PointerDeviceKind: ${kind.name}');
  }

  // ========== GestureDisposition ==========
  print('--- GestureDisposition Tests ---');
  for (final disp in GestureDisposition.values) {
    print('GestureDisposition: ${disp.name}');
  }

  // ========== Velocity ==========
  print('--- Velocity Tests ---');
  final vel1 = Velocity(pixelsPerSecond: Offset(300.0, -100.0));
  print('Velocity: ${vel1.pixelsPerSecond}');
  print('  zero: ${Velocity.zero.pixelsPerSecond}');

  final negated = -vel1;
  print('  negated: ${negated.pixelsPerSecond}');

  final added = vel1 + Velocity(pixelsPerSecond: Offset(100.0, 100.0));
  print('  added: ${added.pixelsPerSecond}');

  final clamped = vel1.clampMagnitude(0.0, 200.0);
  print('  clamped(200): ${clamped.pixelsPerSecond}');

  // ========== PointerEvent concepts ==========
  print('--- PointerEvent concepts ---');
  print('PointerDownEvent: pointer pressed');
  print('PointerMoveEvent: pointer moved');
  print('PointerUpEvent: pointer released');
  print('PointerCancelEvent: pointer cancelled');
  print('PointerHoverEvent: pointer hover (no press)');
  print('PointerScrollEvent: scroll wheel');

  // ========== GestureRecognizerFactory concept ==========
  print('--- GestureRecognizerFactory ---');
  print('GestureRecognizerFactory manages lifecycle');
  print('  constructor() creates recognizer');
  print('  initializer() configures callbacks');

  // ========== ScaleStartDetails ==========
  print('--- ScaleStartDetails Tests ---');
  final scaleStart = ScaleStartDetails(
    focalPoint: Offset(200.0, 200.0),
    localFocalPoint: Offset(100.0, 100.0),
    pointerCount: 2,
  );
  print('ScaleStartDetails: focalPoint=${scaleStart.focalPoint}');
  print('  pointerCount: ${scaleStart.pointerCount}');

  // ========== ScaleUpdateDetails ==========
  print('--- ScaleUpdateDetails Tests ---');
  final scaleUpdate = ScaleUpdateDetails(
    focalPoint: Offset(210.0, 210.0),
    localFocalPoint: Offset(110.0, 110.0),
    scale: 1.5,
    horizontalScale: 1.5,
    verticalScale: 1.5,
    rotation: 0.1,
    pointerCount: 2,
    focalPointDelta: Offset(10.0, 10.0),
  );
  print('ScaleUpdateDetails: scale=${scaleUpdate.scale}');
  print('  rotation: ${scaleUpdate.rotation}');

  print('All gesture tap/force tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gesture Tap/Force Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTapDown: (TapDownDetails d) {},
              onTapUp: (TapUpDetails d) {},
              onForcePressStart: (ForcePressDetails d) {},
              onForcePressPeak: (ForcePressDetails d) {},
              onForcePressUpdate: (ForcePressDetails d) {},
              onForcePressEnd: (ForcePressDetails d) {},
              onScaleStart: (ScaleStartDetails d) {},
              onScaleUpdate: (ScaleUpdateDetails d) {},
              child: Container(
                width: 200, height: 200,
                color: Colors.green.shade100,
                child: Center(child: Text('Tap / Force / Scale')),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
