// D4rt test script: Tests ReadBuffer from foundation
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReadBuffer test executing');

  // Build some data
  final wd = WriteBuffer();
  wd.putUint8(42);
  wd.putInt32(1234567);
  wd.putFloat64(3.14159);
  final bytes = wd.done();

  final rb = ReadBuffer(bytes);
  print('ReadBuffer created');
  print('hasRemaining: ${rb.hasRemaining}');

  final v1 = rb.getUint8();
  print('getUint8: $v1');
  final v2 = rb.getInt32();
  print('getInt32: $v2');
  final v3 = rb.getFloat64();
  print('getFloat64: ${v3.toStringAsFixed(5)}');
  print('hasRemaining after: ${rb.hasRemaining}');

  print('ReadBuffer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ReadBuffer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('uint8: $v1, int32: $v2'),
    Text('float64: ${v3.toStringAsFixed(5)}'),
  ]);
}
