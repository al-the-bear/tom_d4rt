// D4rt test script: Tests DragDownDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragDownDetails test executing');

  final d1 = DragDownDetails(globalPosition: Offset(100.0, 200.0));
  print('globalPosition: ${d1.globalPosition}');
  print('localPosition: ${d1.localPosition}');

  final d2 = DragDownDetails(
    globalPosition: Offset(50.0, 80.0),
    localPosition: Offset(10.0, 20.0),
  );
  print('d2 global: ${d2.globalPosition}');
  print('d2 local: ${d2.localPosition}');
  print('toString: ${d1.toString()}');

  print('DragDownDetails test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DragDownDetails Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('global: ${d1.globalPosition}'),
    Text('local: ${d1.localPosition}'),
  ]);
}
