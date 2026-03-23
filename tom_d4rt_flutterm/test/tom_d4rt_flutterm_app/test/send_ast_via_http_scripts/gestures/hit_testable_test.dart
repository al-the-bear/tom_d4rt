// ignore_for_file: avoid_print
// D4rt test script: Tests HitTestable from gestures
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HitTestable test executing');

  // HitTestable is an interface — hitTest(HitTestResult, Offset)
  print('HitTestable: interface for objects that can receive hit tests');

  // HitTestResult
  final result = HitTestResult();
  print('HitTestResult: ${result.runtimeType}');
  print('path: ${result.path.length}');

  // BoxHitTestResult
  final boxResult = BoxHitTestResult();
  print('BoxHitTestResult: ${boxResult.runtimeType}');

  print('HitTestable test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('HitTestable Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Interface for hit testing'),
    Text('HitTestResult path: ${result.path.length}'),
  ]);
}
