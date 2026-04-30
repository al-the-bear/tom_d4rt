// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Listener and MouseRegion from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Listener test executing');

  // Test Listener with onPointerDown
  final listener1 = Listener(
    onPointerDown: (event) {
      print('Pointer down at: ${event.position}');
    },
    child: Container(
      width: 150.0,
      height: 80.0,
      color: Colors.blue,
      child: Center(
        child: Text('Tap me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Listener(onPointerDown) created');

  // Test Listener with onPointerUp
  final listener2 = Listener(
    onPointerUp: (event) {
      print('Pointer up at: ${event.position}');
    },
    child: Container(
      width: 150.0,
      height: 80.0,
      color: Colors.green,
      child: Center(
        child: Text('Release me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Listener(onPointerUp) created');

  // Test Listener with onPointerMove
  final listener3 = Listener(
    onPointerMove: (event) {
      print('Pointer move at: ${event.position}');
    },
    child: Container(
      width: 150.0,
      height: 80.0,
      color: Colors.orange,
      child: Center(
        child: Text('Move over me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Listener(onPointerMove) created');

  // Test Listener with multiple event handlers
  final listener4 = Listener(
    onPointerDown: (event) => print('Multi: down'),
    onPointerUp: (event) => print('Multi: up'),
    onPointerMove: (event) => print('Multi: move'),
    child: Container(
      width: 150.0,
      height: 80.0,
      color: Colors.purple,
      child: Center(
        child: Text('All events', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Listener with onPointerDown+onPointerUp+onPointerMove created');

  // Test Listener with HitTestBehavior
  final listener5 = Listener(
    behavior: HitTestBehavior.opaque,
    onPointerDown: (event) => print('Opaque hit'),
    child: Container(
      width: 150.0,
      height: 80.0,
      color: Colors.teal,
      child: Center(
        child: Text('Opaque', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Listener(behavior: HitTestBehavior.opaque) created');

  // Test MouseRegion
  final mouseRegion1 = MouseRegion(
    onEnter: (event) => print('Mouse entered'),
    onExit: (event) => print('Mouse exited'),
    onHover: (event) => print('Mouse hover at: ${event.position}'),
    child: Container(
      width: 150.0,
      height: 80.0,
      color: Colors.red,
      child: Center(
        child: Text('Mouse Region', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('MouseRegion(onEnter, onExit, onHover) created');

  // Test MouseRegion with cursor
  final mouseRegion2 = MouseRegion(
    cursor: SystemMouseCursors.click,
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.amber,
      child: Center(child: Text('Click cursor')),
    ),
  );
  print('MouseRegion(cursor: SystemMouseCursors.click) created');

  // Test MouseRegion with opaque
  final mouseRegion3 = MouseRegion(
    opaque: false,
    onEnter: (event) => print('Transparent mouse enter'),
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.cyan,
      child: Center(child: Text('Non-opaque')),
    ),
  );
  print('MouseRegion(opaque: false) created');

  print('Listener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Listener / MouseRegion Tests'),
      SizedBox(height: 8.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [listener1, listener2, listener3],
      ),
      SizedBox(height: 8.0),
      Wrap(spacing: 8.0, runSpacing: 8.0, children: [listener4, listener5]),
      SizedBox(height: 8.0),
      Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [mouseRegion1, mouseRegion2, mouseRegion3],
      ),
    ],
  );
}
