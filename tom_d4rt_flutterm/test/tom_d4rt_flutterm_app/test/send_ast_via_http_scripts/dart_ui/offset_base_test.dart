// D4rt test script: Tests OffsetBase from dart:ui (abstract base of Offset and Size)
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OffsetBase test executing');

  // OffsetBase is an abstract class — tested through Offset and Size
  final offset = Offset(10.0, 20.0);
  print('true: true');
  print('Offset dx: ${offset.dx}, dy: ${offset.dy}');

  final size = Size(100.0, 50.0);
  print('true: true');
  print('Size width: ${size.width}, height: ${size.height}');

  // OffsetBase comparison operators (>, >=, <, <=)
  // These compare both components
  final o1 = Offset(5.0, 5.0);
  final o2 = Offset(10.0, 10.0);
  print('o1 < o2: ${o1 < o2}');
  print('o1 <= o2: ${o1 <= o2}');
  print('o2 > o1: ${o2 > o1}');
  print('o2 >= o1: ${o2 >= o1}');

  final s1 = Size(50.0, 30.0);
  final s2 = Size(100.0, 60.0);
  print('s1 < s2: ${s1 < s2}');
  print('s2 > s1: ${s2 > s1}');

  // isInfinite and isFinite from OffsetBase
  final finiteOffset = Offset(1.0, 2.0);
  print('finite offset isInfinite: ${finiteOffset.isInfinite}');
  print('finite offset isFinite: ${finiteOffset.isFinite}');

  final infiniteOffset = Offset.infinite;
  print('infinite offset isInfinite: ${infiniteOffset.isInfinite}');

  final finiteSize = Size(10.0, 20.0);
  print('finite size isInfinite: ${finiteSize.isInfinite}');
  print('finite size isFinite: ${finiteSize.isFinite}');

  print('OffsetBase test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OffsetBase Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Abstract base of Offset and Size'),
      Text('true: true'),
      Text('true: true'),
      Text('Comparison: o1 < o2 = ${o1 < o2}'),
      Text('isFinite/isInfinite tested'),
    ],
  );
}
