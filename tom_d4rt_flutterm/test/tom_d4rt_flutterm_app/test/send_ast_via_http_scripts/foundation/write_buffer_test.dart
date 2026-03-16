// D4rt test script: Tests WriteBuffer from foundation
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WriteBuffer test executing');

  final wb = WriteBuffer();
  wb.putUint8(255);
  wb.putUint16(65535);
  wb.putUint32(4294967295);
  wb.putInt32(-12345);
  wb.putInt64(9876543210);
  wb.putFloat64(2.71828);
  wb.putUint8List(Uint8List.fromList([1, 2, 3]));
  final result = wb.done();
  print('WriteBuffer done');

  final rb = ReadBuffer(result);
  final v1 = rb.getUint8();
  print('uint8: $v1');
  final v2 = rb.getUint16();
  print('uint16: $v2');
  final v3 = rb.getUint32();
  print('uint32: $v3');
  final v4 = rb.getInt32();
  print('int32: $v4');
  final v5 = rb.getInt64();
  print('int64: $v5');
  final v6 = rb.getFloat64();
  print('float64: ${v6.toStringAsFixed(5)}');
  final list = rb.getUint8List(3);
  print('uint8List: $list');

  print('WriteBuffer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('WriteBuffer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Wrote and read back all types'),
    Text('uint8/16/32, int32/64, float64, list'),
  ]);
}
