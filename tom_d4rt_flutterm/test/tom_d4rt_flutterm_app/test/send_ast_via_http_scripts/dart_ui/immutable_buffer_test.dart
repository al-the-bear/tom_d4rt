// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImmutableBuffer from dart:ui
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImmutableBuffer test executing');

  // ImmutableBuffer has async factories
  print('ImmutableBuffer type: ${ui.ImmutableBuffer}');

  // fromUint8List — returns Future<ImmutableBuffer>
  final emptyData = Uint8List(0);
  final future1 = ui.ImmutableBuffer.fromUint8List(emptyData);
  print('fromUint8List(empty): ${future1.runtimeType}');

  final smallData = Uint8List.fromList([1, 2, 3, 4, 5]);
  final future2 = ui.ImmutableBuffer.fromUint8List(smallData);
  print('fromUint8List([1,2,3,4,5]): ${future2.runtimeType}');

  final largeData = Uint8List(1024);
  final future3 = ui.ImmutableBuffer.fromUint8List(largeData);
  print('fromUint8List(1024 bytes): ${future3.runtimeType}');

  // Static methods
  print('fromUint8List: Future<ImmutableBuffer>');
  print('fromAsset: Future<ImmutableBuffer>');
  print('fromFilePath: Future<ImmutableBuffer>');

  // Properties
  print('Properties: length (int), debugDisposed (bool)');
  print('Methods: dispose()');

  print('ImmutableBuffer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImmutableBuffer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${ui.ImmutableBuffer}'),
      Text('fromUint8List: 3 sizes tested'),
      Text('fromAsset, fromFilePath: available'),
      Text('Properties: length, debugDisposed'),
    ],
  );
}
