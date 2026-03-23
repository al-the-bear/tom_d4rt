// ignore_for_file: avoid_print
// D4rt test script: Tests Draggable, DragTarget, LongPressDraggable from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Draggable/DragTarget/LongPressDraggable test executing');

  // ========== DRAGGABLE ==========
  print('--- Draggable Tests ---');

  // Test basic Draggable with String data
  final draggableBasic = Draggable<String>(
    data: 'Hello',
    feedback: Material(
      elevation: 4.0,
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.blue,
        child: Center(
          child: Text('Dragging', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Drag me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable basic with String data created');

  // Test Draggable with childWhenDragging
  final draggableWithPlaceholder = Draggable<String>(
    data: 'Item1',
    feedback: Material(
      elevation: 6.0,
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text('Moving...', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    childWhenDragging: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.grey,
      child: Center(
        child: Text('Gone', style: TextStyle(color: Colors.white)),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('With placeholder', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with childWhenDragging created');

  // Test Draggable with onDragStarted/onDragEnd
  final draggableCallbacks = Draggable<int>(
    data: 42,
    onDragStarted: () {
      print('Drag started');
    },
    onDragEnd: (details) {
      print('Drag ended');
    },
    onDraggableCanceled: (velocity, offset) {
      print('Drag canceled');
    },
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.orange,
        child: Center(
          child: Text('42', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(
        child: Text('Callbacks', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with callbacks created');

  // Test Draggable with axis constraint
  final draggableHorizontal = Draggable<String>(
    data: 'horizontal',
    axis: Axis.horizontal,
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.purple,
        child: Center(
          child: Text('H-only', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text('Horizontal', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with axis=horizontal created');

  // Test Draggable with vertical axis
  final draggableVertical = Draggable<String>(
    data: 'vertical',
    axis: Axis.vertical,
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.teal,
        child: Center(
          child: Text('V-only', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('Vertical', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with axis=vertical created');

  // Test Draggable with maxSimultaneousDrags
  final draggableMaxDrags = Draggable<String>(
    data: 'limited',
    maxSimultaneousDrags: 1,
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.indigo,
        child: Center(
          child: Text('Max 1', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Max drags=1', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with maxSimultaneousDrags=1 created');

  // ========== DRAGTARGET ==========
  print('--- DragTarget Tests ---');

  // Test DragTarget basic
  final dragTargetBasic = DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 200.0,
        height: 80.0,
        color: Colors.grey,
        child: Center(
          child: Text('Drop here', style: TextStyle(color: Colors.white)),
        ),
      );
    },
    onAcceptWithDetails: (details) {
      print('Accepted: ${details.data}');
    },
  );
  print('DragTarget basic created');

  // Test DragTarget with onWillAcceptWithDetails
  final dragTargetFiltered = DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 200.0,
        height: 80.0,
        color: Colors.blueGrey,
        child: Center(
          child: Text('Filtered target', style: TextStyle(color: Colors.white)),
        ),
      );
    },
    onWillAcceptWithDetails: (details) {
      print('Will accept? ${details.data}');
      return true;
    },
    onAcceptWithDetails: (details) {
      print('Filtered accepted: ${details.data}');
    },
    onLeave: (data) {
      print('Left target');
    },
  );
  print('DragTarget with filtering created');

  // ========== LONGPRESSDRAGGABLE ==========
  print('--- LongPressDraggable Tests ---');

  // Test LongPressDraggable basic
  final longPressBasic = LongPressDraggable<String>(
    data: 'LongPress',
    feedback: Material(
      elevation: 4.0,
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.red,
        child: Center(
          child: Text('Long drag', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.red,
      child: Center(
        child: Text('Long press me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('LongPressDraggable basic created');

  // Test LongPressDraggable with hapticFeedbackOnStart
  final longPressHaptic = LongPressDraggable<String>(
    data: 'Haptic',
    hapticFeedbackOnStart: true,
    feedback: Material(
      elevation: 6.0,
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.deepOrange,
        child: Center(
          child: Text('Haptic', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    childWhenDragging: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.grey,
      child: Center(
        child: Text('Dragging...', style: TextStyle(color: Colors.white)),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.deepOrange,
      child: Center(
        child: Text('Haptic drag', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('LongPressDraggable with hapticFeedbackOnStart created');

  // Test LongPressDraggable with callbacks
  final longPressCallbacks = LongPressDraggable<int>(
    data: 99,
    onDragStarted: () {
      print('Long press drag started');
    },
    onDragEnd: (details) {
      print('Long press drag ended');
    },
    onDragCompleted: () {
      print('Long press drag completed');
    },
    feedback: Material(
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.brown,
        child: Center(
          child: Text(
            '99',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.brown,
      child: Center(
        child: Text('Callbacks LP', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('LongPressDraggable with callbacks created');

  print('All Draggable/DragTarget/LongPressDraggable tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== Draggable Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableBasic,
        SizedBox(height: 8.0),
        Text(
          'With placeholder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        draggableWithPlaceholder,
        SizedBox(height: 8.0),
        Text('With callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableCallbacks,
        SizedBox(height: 8.0),
        Text('Horizontal only:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableHorizontal,
        SizedBox(height: 8.0),
        Text('Vertical only:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableVertical,
        SizedBox(height: 8.0),
        Text('Max drags=1:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableMaxDrags,
        SizedBox(height: 16.0),
        Text(
          '=== DragTarget Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic target:', style: TextStyle(fontWeight: FontWeight.bold)),
        dragTargetBasic,
        SizedBox(height: 8.0),
        Text('Filtered target:', style: TextStyle(fontWeight: FontWeight.bold)),
        dragTargetFiltered,
        SizedBox(height: 16.0),
        Text(
          '=== LongPressDraggable Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        longPressBasic,
        SizedBox(height: 8.0),
        Text('Haptic feedback:', style: TextStyle(fontWeight: FontWeight.bold)),
        longPressHaptic,
        SizedBox(height: 8.0),
        Text('With callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        longPressCallbacks,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Draggable creates drag-and-drop items with feedback widgets'),
        Text('• DragTarget receives dropped items via onAcceptWithDetails'),
        Text('• LongPressDraggable requires long press to start dragging'),
        Text('• axis constrains drag to horizontal or vertical'),
        Text('• childWhenDragging shows placeholder during drag'),
      ],
    ),
  );
}
