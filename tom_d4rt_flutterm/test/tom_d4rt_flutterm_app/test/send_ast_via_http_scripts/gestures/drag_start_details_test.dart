// D4rt test script: Tests DragStartDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragStartDetails test executing');

  final d1 = DragStartDetails(
    globalPosition: Offset(100.0, 150.0),
    sourceTimeStamp: Duration(milliseconds: 500),
  );
  print('globalPosition: ${d1.globalPosition}');
  print('localPosition: ${d1.localPosition}');
  print('sourceTimeStamp: ${d1.sourceTimeStamp}');
  print('kind: ${d1.kind}');

  final d2 = DragStartDetails(
    globalPosition: Offset(0, 0),
    localPosition: Offset(0, 0),
    kind: PointerDeviceKind.touch,
  );
  print('d2 kind: ${d2.kind}');

  print('DragStartDetails test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DragStartDetails Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('global: ${d1.globalPosition}'),
    Text('sourceTimeStamp: ${d1.sourceTimeStamp}'),
  ]);
}
