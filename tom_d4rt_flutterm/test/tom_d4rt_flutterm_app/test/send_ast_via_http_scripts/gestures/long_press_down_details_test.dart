// ignore_for_file: avoid_print
// D4rt test script: Tests LongPressDownDetails from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LongPressDownDetails test executing');

  final d1 = LongPressDownDetails(
    globalPosition: Offset(150.0, 300.0),
    kind: PointerDeviceKind.touch,
  );
  print('globalPosition: ${d1.globalPosition}');
  print('localPosition: ${d1.localPosition}');
  print('kind: ${d1.kind}');

  final d2 = LongPressDownDetails(
    globalPosition: Offset(0, 0),
    localPosition: Offset(0, 0),
  );
  print('d2 global: ${d2.globalPosition}');

  print('LongPressDownDetails test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('LongPressDownDetails Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('global: ${d1.globalPosition}'),
    Text('kind: ${d1.kind}'),
  ]);
}
