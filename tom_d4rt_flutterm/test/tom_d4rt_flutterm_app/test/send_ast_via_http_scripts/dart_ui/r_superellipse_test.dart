// D4rt test script: Tests RSuperellipse from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RSuperellipse test executing');

  // fromRectAndCorners
  final rse1 = RSuperellipse.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 200, 100),
    topLeft: Radius.circular(20),
    topRight: Radius.circular(15),
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(25),
  );
  print('RSuperellipse: left=${rse1.left}, top=${rse1.top}, right=${rse1.right}, bottom=${rse1.bottom}');
  print('width=${rse1.width}, height=${rse1.height}');
  print('tlRadiusX=${rse1.tlRadiusX}, trRadiusX=${rse1.trRadiusX}');
  print('blRadiusX=${rse1.blRadiusX}, brRadiusX=${rse1.brRadiusX}');

  // Uniform
  final rse2 = RSuperellipse.fromRectAndCorners(
    Rect.fromLTWH(10, 20, 150, 80),
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );
  print('Uniform: width=${rse2.width}, height=${rse2.height}');
  print('isFinite: ${rse2.isFinite}');
  print('isEmpty: ${rse2.isEmpty}');

  // Contains point
  final inside = rse1.contains(Offset(100, 50));
  print('contains(100,50): $inside');
  final outside = rse1.contains(Offset(300, 300));
  print('contains(300,300): $outside');

  // Shift
  final shifted = rse1.shift(Offset(10, 20));
  print('shifted: left=${shifted.left}, top=${shifted.top}');

  // outerRect
  final outer = rse1.outerRect;
  print('outerRect: $outer');

  print('RSuperellipse test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('RSuperellipse Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Size: ${rse1.width.toInt()}x${rse1.height.toInt()}'),
    Text('Corners: ${rse1.tlRadiusX}/${rse1.trRadiusX}/${rse1.blRadiusX}/${rse1.brRadiusX}'),
    Text('Contains center: $inside'),
  ]);
}
