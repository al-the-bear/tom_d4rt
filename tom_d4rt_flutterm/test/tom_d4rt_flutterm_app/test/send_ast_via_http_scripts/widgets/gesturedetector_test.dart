// D4rt test script: Tests GestureDetector widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureDetector test executing');

  // Test GestureDetector with onTap
  final tapDetector = GestureDetector(
    onTap: () {
      print('Tap detected!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Tap Me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with onTap created');

  // Test GestureDetector with onDoubleTap
  final doubleTapDetector = GestureDetector(
    onDoubleTap: () {
      print('Double tap detected!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('Double Tap', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with onDoubleTap created');

  // Test GestureDetector with onLongPress
  final longPressDetector = GestureDetector(
    onLongPress: () {
      print('Long press detected!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(
        child: Text('Long Press', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with onLongPress created');

  // Test GestureDetector with onTapDown and onTapUp
  final tapUpDownDetector = GestureDetector(
    onTapDown: (details) {
      print('Tap down at: ${details.localPosition}');
    },
    onTapUp: (details) {
      print('Tap up at: ${details.localPosition}');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'Tap Up/Down',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('GestureDetector with onTapDown and onTapUp created');

  // Test GestureDetector with drag callbacks
  final dragDetector = GestureDetector(
    onPanStart: (details) {
      print('Pan start at: ${details.localPosition}');
    },
    onPanUpdate: (details) {
      print('Pan update: ${details.delta}');
    },
    onPanEnd: (details) {
      print('Pan end with velocity: ${details.velocity}');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('Drag Me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with pan/drag callbacks created');

  // Test GestureDetector with scale callbacks
  final scaleDetector = GestureDetector(
    onScaleStart: (details) {
      print('Scale start at: ${details.focalPoint}');
    },
    onScaleUpdate: (details) {
      print('Scale: ${details.scale}');
    },
    onScaleEnd: (details) {
      print('Scale end with velocity: ${details.velocity}');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Scale', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with scale callbacks created');

  // Test GestureDetector with behavior
  final behaviorDetector = GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      print('Opaque behavior tap!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.pink,
      child: Center(
        child: Text('Opaque', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with HitTestBehavior.opaque created');

  // Test GestureDetector with excludeFromSemantics
  final excludeSemanticsDetector = GestureDetector(
    excludeFromSemantics: true,
    onTap: () {
      print('Excluded from semantics tap!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.amber,
      child: Center(
        child: Text('No A11y', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with excludeFromSemantics=true created');

  print('GestureDetector test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [tapDetector, SizedBox(width: 8.0), doubleTapDetector],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [longPressDetector, SizedBox(width: 8.0), tapUpDownDetector],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [dragDetector, SizedBox(width: 8.0), scaleDetector],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          behaviorDetector,
          SizedBox(width: 8.0),
          excludeSemanticsDetector,
        ],
      ),
    ],
  );
}
