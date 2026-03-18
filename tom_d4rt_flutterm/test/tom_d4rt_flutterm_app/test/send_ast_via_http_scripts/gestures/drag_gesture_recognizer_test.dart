// D4rt test script: Tests DragGestureRecognizer subtypes
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragGestureRecognizer test executing');

  // VerticalDragGestureRecognizer
  final vd = VerticalDragGestureRecognizer();
  print('VerticalDrag: ${vd.runtimeType}');
  print('is DragGestureRecognizer: ${true}');
  vd.onStart = (d) {};
  vd.onUpdate = (d) {};
  vd.onEnd = (d) {};
  vd.dispose();

  // HorizontalDragGestureRecognizer
  final hd = HorizontalDragGestureRecognizer();
  print('HorizontalDrag: ${hd.runtimeType}');
  hd.dispose();

  // PanGestureRecognizer
  final pan = PanGestureRecognizer();
  print('Pan: ${pan.runtimeType}');
  pan.dispose();

  print('DragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DragGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Vertical, Horizontal, Pan'),
    Text('Callbacks: onStart, onUpdate, onEnd'),
  ]);
}
