// D4rt test script: Tests OffsetPair from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OffsetPair test executing');

  final op1 = OffsetPair(local: Offset(10, 20), global: Offset(100, 200));
  print('OffsetPair: local=${op1.local}, global=${op1.global}');

  // fromEventPosition/fromEventDelta require PointerEvent, test via constructor
  final op2 = OffsetPair(local: Offset(150, 250), global: Offset(150, 250));
  print('OffsetPair(150,250): local=${op2.local}, global=${op2.global}');

  final op3 = OffsetPair(local: Offset(5, 10), global: Offset(5, 10));
  print('OffsetPair(5,10): local=${op3.local}, global=${op3.global}');

  // Operators
  final added = op1 + op3;
  print('op1+op3: local=${added.local}, global=${added.global}');

  final subtracted = op1 - op3;
  print('op1-op3: local=${subtracted.local}, global=${subtracted.global}');

  // zero
  print('zero: ${OffsetPair.zero.local}');

  print('OffsetPair test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('OffsetPair Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('local=${op1.local}, global=${op1.global}'),
    Text('Operators: +, -'),
    Text('zero: ${OffsetPair.zero.local}'),
  ]);
}
