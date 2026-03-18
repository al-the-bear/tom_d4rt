// D4rt test script: Tests Drag interface from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Drag test executing');

  // Drag is an interface — tested via GestureDetector callbacks
  print('Drag interface: update(DragUpdateDetails), end(DragEndDetails), cancel()');

  // DragUpdateDetails
  final dud = DragUpdateDetails(
    globalPosition: Offset(100, 200),
    delta: Offset(5, 10),
    sourceTimeStamp: Duration(milliseconds: 100),
  );
  print('DragUpdateDetails: delta=${dud.delta}, pos=${dud.globalPosition}');
  print('primaryDelta: ${dud.primaryDelta}');

  // DragEndDetails
  final ded = DragEndDetails(velocity: Velocity(pixelsPerSecond: Offset(500, 0)));
  print('DragEndDetails: velocity=${ded.velocity}');
  print('primaryVelocity: ${ded.primaryVelocity}');

  print('Drag test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('Drag Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Update delta: ${dud.delta}'),
    Text('End velocity: ${ded.velocity}'),
  ]);
}
