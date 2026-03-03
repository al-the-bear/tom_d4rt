// D4rt test script: Tests Overlay and OverlayEntry from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Overlay test executing');

  // Test OverlayEntry creation
  final entry1 = OverlayEntry(
    builder: (ctx) {
      return Positioned(
        top: 50.0,
        left: 50.0,
        child: Container(
          width: 100.0,
          height: 60.0,
          color: Colors.blue,
          child: Center(
            child: Text('Overlay 1', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    },
  );
  print('OverlayEntry 1 created');
  print('OverlayEntry opaque: ${entry1.opaque}');
  print('OverlayEntry maintainState: ${entry1.maintainState}');

  // Test OverlayEntry with opaque=true
  final entry2 = OverlayEntry(
    opaque: true,
    builder: (ctx) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Text(
            'Opaque Overlay',
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
        ),
      );
    },
  );
  print('OverlayEntry(opaque: true) created');
  print('OverlayEntry opaque: ${entry2.opaque}');

  // Test OverlayEntry with maintainState=true
  final entry3 = OverlayEntry(
    maintainState: true,
    builder: (ctx) {
      return Positioned(
        bottom: 20.0,
        right: 20.0,
        child: Container(
          width: 80.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(child: Text('Maintain')),
        ),
      );
    },
  );
  print('OverlayEntry(maintainState: true) created');
  print('OverlayEntry maintainState: ${entry3.maintainState}');

  // Overlay.of requires a valid overlay in the widget tree
  // In a MaterialApp/Scaffold context, Overlay is always present
  try {
    final overlay = Overlay.of(context);
    print('Overlay.of(context) accessed successfully');
  } catch (e) {
    print('Overlay.of(context) not available in test context: $e');
  }

  // Show concept: Stack simulates overlay behavior
  final overlaySimulation = Stack(
    children: [
      Container(
        width: 200.0,
        height: 150.0,
        color: Colors.grey,
        child: Center(child: Text('Background')),
      ),
      Positioned(
        top: 10.0,
        left: 10.0,
        child: Container(
          width: 80.0,
          height: 50.0,
          color: Colors.blue,
          child: Center(
            child: Text('Entry 1', style: TextStyle(color: Colors.white, fontSize: 12.0)),
          ),
        ),
      ),
      Positioned(
        bottom: 10.0,
        right: 10.0,
        child: Container(
          width: 80.0,
          height: 50.0,
          color: Colors.green,
          child: Center(
            child: Text('Entry 2', style: TextStyle(color: Colors.white, fontSize: 12.0)),
          ),
        ),
      ),
    ],
  );
  print('Stack simulating Overlay behavior created');

  print('Overlay test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Overlay / OverlayEntry Tests'),
      SizedBox(height: 8.0),
      overlaySimulation,
    ],
  );
}
