// D4rt test script: Tests gesture recognizer classes from package:flutter/gestures.dart
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gestures recognizers test executing');

  // ========== HORIZONTALDRAGGESTURERECOGNIZER ==========
  print('--- HorizontalDragGestureRecognizer Tests ---');

  final hDrag = HorizontalDragGestureRecognizer();
  print('HorizontalDragGestureRecognizer created');
  print('  runtimeType: ${hDrag.runtimeType}');
  print('  debugDescription: ${hDrag.debugDescription}');

  hDrag.onStart = (DragStartDetails details) {
    print('  hDrag.onStart: ${details.globalPosition}');
  };
  hDrag.onUpdate = (DragUpdateDetails details) {
    print('  hDrag.onUpdate: ${details.delta}');
  };
  hDrag.onEnd = (DragEndDetails details) {
    print('  hDrag.onEnd: ${details.velocity}');
  };
  print('  Callbacks set: onStart, onUpdate, onEnd');
  hDrag.dispose();
  print('  Disposed');

  // ========== VERTICALDRAGGESTURERECOGNIZER ==========
  print('--- VerticalDragGestureRecognizer Tests ---');

  final vDrag = VerticalDragGestureRecognizer();
  print('VerticalDragGestureRecognizer created');
  print('  runtimeType: ${vDrag.runtimeType}');
  print('  debugDescription: ${vDrag.debugDescription}');

  vDrag.onStart = (DragStartDetails details) {
    print('  vDrag.onStart: ${details.globalPosition}');
  };
  vDrag.onUpdate = (DragUpdateDetails details) {
    print('  vDrag.onUpdate: ${details.delta}');
  };
  print('  Callbacks set: onStart, onUpdate');
  vDrag.dispose();
  print('  Disposed');

  // ========== PANGESTURERECOGNIZER ==========
  print('--- PanGestureRecognizer Tests ---');

  final pan = PanGestureRecognizer();
  print('PanGestureRecognizer created');
  print('  runtimeType: ${pan.runtimeType}');
  print('  debugDescription: ${pan.debugDescription}');

  pan.onStart = (DragStartDetails details) {
    print('  pan.onStart: ${details.globalPosition}');
  };
  pan.onUpdate = (DragUpdateDetails details) {
    print('  pan.onUpdate: delta=${details.delta}');
  };
  pan.onEnd = (DragEndDetails details) {
    print('  pan.onEnd: velocity=${details.velocity}');
  };
  print('  Callbacks set: onStart, onUpdate, onEnd');
  pan.dispose();
  print('  Disposed');

  // ========== SCALEGESTURERECOGNIZER ==========
  print('--- ScaleGestureRecognizer Tests ---');

  final scale = ScaleGestureRecognizer();
  print('ScaleGestureRecognizer created');
  print('  runtimeType: ${scale.runtimeType}');
  print('  debugDescription: ${scale.debugDescription}');

  scale.onStart = (ScaleStartDetails details) {
    print('  scale.onStart: focalPoint=${details.focalPoint}');
  };
  scale.onUpdate = (ScaleUpdateDetails details) {
    print('  scale.onUpdate: scale=${details.scale}, rotation=${details.rotation}');
  };
  scale.onEnd = (ScaleEndDetails details) {
    print('  scale.onEnd: velocity=${details.velocity}');
  };
  print('  Callbacks set: onStart, onUpdate, onEnd');
  scale.dispose();
  print('  Disposed');

  // ========== LONGPRESSGESTURERECOGNIZER ==========
  print('--- LongPressGestureRecognizer Tests ---');

  final longPress = LongPressGestureRecognizer();
  print('LongPressGestureRecognizer created');
  print('  runtimeType: ${longPress.runtimeType}');
  print('  debugDescription: ${longPress.debugDescription}');

  longPress.onLongPress = () {
    print('  longPress triggered');
  };
  longPress.onLongPressStart = (LongPressStartDetails details) {
    print('  longPress.onStart: ${details.globalPosition}');
  };
  longPress.onLongPressMoveUpdate = (LongPressMoveUpdateDetails details) {
    print('  longPress.onMoveUpdate: ${details.globalPosition}');
  };
  longPress.onLongPressEnd = (LongPressEndDetails details) {
    print('  longPress.onEnd: ${details.globalPosition}');
  };
  print('  Callbacks set: onLongPress, onStart, onMoveUpdate, onEnd');
  longPress.dispose();
  print('  Disposed');

  // ========== DOUBLETAPGESTURERECOGNIZER ==========
  print('--- DoubleTapGestureRecognizer Tests ---');

  final doubleTap = DoubleTapGestureRecognizer();
  print('DoubleTapGestureRecognizer created');
  print('  runtimeType: ${doubleTap.runtimeType}');
  print('  debugDescription: ${doubleTap.debugDescription}');

  doubleTap.onDoubleTap = () {
    print('  doubleTap triggered');
  };
  doubleTap.onDoubleTapDown = (TapDownDetails details) {
    print('  doubleTap.onDown: ${details.globalPosition}');
  };
  doubleTap.onDoubleTapCancel = () {
    print('  doubleTap cancelled');
  };
  print('  Callbacks set: onDoubleTap, onDoubleTapDown, onDoubleTapCancel');
  doubleTap.dispose();
  print('  Disposed');

  // ========== FORCEPRESSGESTURERECOGNIZER ==========
  print('--- ForcePressGestureRecognizer Tests ---');

  final forcePress = ForcePressGestureRecognizer();
  print('ForcePressGestureRecognizer created');
  print('  runtimeType: ${forcePress.runtimeType}');
  print('  debugDescription: ${forcePress.debugDescription}');

  forcePress.onStart = (ForcePressDetails details) {
    print('  forcePress.onStart: ${details.globalPosition}, pressure=${details.pressure}');
  };
  forcePress.onPeak = (ForcePressDetails details) {
    print('  forcePress.onPeak: pressure=${details.pressure}');
  };
  forcePress.onUpdate = (ForcePressDetails details) {
    print('  forcePress.onUpdate: pressure=${details.pressure}');
  };
  forcePress.onEnd = (ForcePressDetails details) {
    print('  forcePress.onEnd: pressure=${details.pressure}');
  };
  print('  Callbacks set: onStart, onPeak, onUpdate, onEnd');
  forcePress.dispose();
  print('  Disposed');

  // ========== TAPGESTURERECOGNIZER ==========
  print('--- TapGestureRecognizer Tests ---');

  final tap = TapGestureRecognizer();
  print('TapGestureRecognizer created');
  print('  runtimeType: ${tap.runtimeType}');
  print('  debugDescription: ${tap.debugDescription}');

  tap.onTap = () => print('  tapped');
  tap.onTapDown = (TapDownDetails d) => print('  tapDown: ${d.globalPosition}');
  tap.onTapUp = (TapUpDetails d) => print('  tapUp: ${d.globalPosition}');
  tap.onTapCancel = () => print('  tapCancel');
  print('  Callbacks set: onTap, onTapDown, onTapUp, onTapCancel');
  tap.dispose();
  print('  Disposed');

  // ========== RETURN WIDGET ==========
  print('Gestures recognizers test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestures Recognizers Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('Classes Tested:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• HorizontalDragGestureRecognizer'),
          Text('• VerticalDragGestureRecognizer'),
          Text('• PanGestureRecognizer'),
          Text('• ScaleGestureRecognizer'),
          Text('• LongPressGestureRecognizer'),
          Text('• DoubleTapGestureRecognizer'),
          Text('• ForcePressGestureRecognizer'),
          Text('• TapGestureRecognizer'),
          SizedBox(height: 16.0),

          Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFF9C4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Recognizers are typically created by GestureDetector'),
                Text('• Each recognizer must be disposed when no longer needed'),
                Text('• Callbacks receive detail objects with position/velocity'),
                Text('• ForcePressGestureRecognizer requires 3D touch support'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
