// D4rt test script: Tests ScaleStartDetails, ScaleUpdateDetails, ScaleEndDetails
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scale gesture details test executing');

  // ========== ScaleStartDetails ==========
  print('--- ScaleStartDetails Tests ---');

  final scaleStart = ScaleStartDetails(
    focalPoint: Offset(100.0, 200.0),
    localFocalPoint: Offset(50.0, 100.0),
    pointerCount: 2,
  );
  print('ScaleStartDetails focalPoint: ${scaleStart.focalPoint}');
  print('ScaleStartDetails localFocalPoint: ${scaleStart.localFocalPoint}');
  print('ScaleStartDetails pointerCount: ${scaleStart.pointerCount}');

  // ========== ScaleUpdateDetails ==========
  print('--- ScaleUpdateDetails Tests ---');

  final scaleUpdate = ScaleUpdateDetails(
    focalPoint: Offset(110.0, 210.0),
    localFocalPoint: Offset(60.0, 110.0),
    scale: 1.5,
    horizontalScale: 1.2,
    verticalScale: 1.8,
    rotation: 0.5,
    pointerCount: 2,
    focalPointDelta: Offset(10.0, 10.0),
  );
  print('ScaleUpdateDetails scale: ${scaleUpdate.scale}');
  print('ScaleUpdateDetails horizontalScale: ${scaleUpdate.horizontalScale}');
  print('ScaleUpdateDetails verticalScale: ${scaleUpdate.verticalScale}');
  print('ScaleUpdateDetails rotation: ${scaleUpdate.rotation}');
  print('ScaleUpdateDetails focalPointDelta: ${scaleUpdate.focalPointDelta}');

  // ========== ScaleEndDetails ==========
  print('--- ScaleEndDetails Tests ---');

  final scaleEnd = ScaleEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(100.0, 50.0)),
    pointerCount: 0,
  );
  print('ScaleEndDetails velocity: ${scaleEnd.velocity}');
  print('ScaleEndDetails pointerCount: ${scaleEnd.pointerCount}');

  // ========== LongPressStartDetails ==========
  print('--- LongPressStartDetails Tests ---');

  final longStart = LongPressStartDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
  );
  print('LongPressStartDetails globalPosition: ${longStart.globalPosition}');

  final longMoveUpdate = LongPressMoveUpdateDetails(
    globalPosition: Offset(210.0, 310.0),
    localPosition: Offset(110.0, 160.0),
    offsetFromOrigin: Offset(10.0, 10.0),
    localOffsetFromOrigin: Offset(10.0, 10.0),
  );
  print('LongPressMoveUpdateDetails offset: ${longMoveUpdate.offsetFromOrigin}');

  final longEnd = LongPressEndDetails(
    globalPosition: Offset(210.0, 310.0),
    localPosition: Offset(110.0, 160.0),
    velocity: Velocity(pixelsPerSecond: Offset(0.0, 0.0)),
  );
  print('LongPressEndDetails globalPosition: ${longEnd.globalPosition}');

  print('All scale gesture details tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Scale Gesture Details Tests',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Scale: ${scaleUpdate.scale}'),
            Text('Rotation: ${scaleUpdate.rotation}'),
            Text('LongPress globalPos: ${longStart.globalPosition}'),
          ],
        ),
      ),
    ),
  );
}
