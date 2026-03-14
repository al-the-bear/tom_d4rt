// D4rt test script: Tests DirectionallyExtendSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DirectionallyExtendSelectionEvent test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');
  
  // DirectionallyExtendSelectionEvent is used for text selection
  final event = DirectionallyExtendSelectionEvent(
    dx: 10.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );
  print('Created DirectionallyExtendSelectionEvent');
  print('dx: ${event.dx}');
  print('isEnd: ${event.isEnd}');
  print('direction: ${event.direction}');
  results.add('Created with dx=${event.dx}, isEnd=${event.isEnd}');
  
  // ========== Section 2: Forward Direction ==========
  print('--- Section 2: Forward Direction ---');
  
  final forwardEvent = DirectionallyExtendSelectionEvent(
    dx: 20.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );
  print('Forward direction: ${forwardEvent.direction}');
  print('Is forward: ${forwardEvent.direction == SelectionExtendDirection.forward}');
  results.add('Forward: ${forwardEvent.direction == SelectionExtendDirection.forward}');
  
  // ========== Section 3: Backward Direction ==========
  print('--- Section 3: Backward Direction ---');
  
  final backwardEvent = DirectionallyExtendSelectionEvent(
    dx: -15.0,
    isEnd: false,
    direction: SelectionExtendDirection.backward,
  );
  print('Backward direction: ${backwardEvent.direction}');
  print('Is backward: ${backwardEvent.direction == SelectionExtendDirection.backward}');
  print('dx (negative): ${backwardEvent.dx}');
  results.add('Backward: dx=${backwardEvent.dx}');
  
  // ========== Section 4: Previous/Next Word ==========
  print('--- Section 4: Previous/Next Word ---');
  
  final previousWord = DirectionallyExtendSelectionEvent(
    dx: 0.0,
    isEnd: true,
    direction: SelectionExtendDirection.previousLine,
  );
  print('Previous line direction: ${previousWord.direction}');
  
  final nextWord = DirectionallyExtendSelectionEvent(
    dx: 0.0,
    isEnd: true,
    direction: SelectionExtendDirection.nextLine,
  );
  print('Next line direction: ${nextWord.direction}');
  results.add('Line directions: prev=${previousWord.direction}, next=${nextWord.direction}');
  
  // ========== Section 5: isEnd Property ==========
  print('--- Section 5: isEnd Property ---');
  
  final endEvent = DirectionallyExtendSelectionEvent(
    dx: 5.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );
  
  final startEvent = DirectionallyExtendSelectionEvent(
    dx: 5.0,
    isEnd: false,
    direction: SelectionExtendDirection.forward,
  );
  
  print('End event isEnd: ${endEvent.isEnd}');
  print('Start event isEnd: ${startEvent.isEnd}');
  results.add('isEnd: end=${endEvent.isEnd}, start=${startEvent.isEnd}');
  
  // ========== Section 6: Different dx Values ==========
  print('--- Section 6: Different dx Values ---');
  
  final dxValues = [0.0, 10.0, 50.0, 100.0, -25.0];
  for (final dx in dxValues) {
    final dxEvent = DirectionallyExtendSelectionEvent(
      dx: dx,
      isEnd: true,
      direction: SelectionExtendDirection.forward,
    );
    print('Event with dx=$dx created, dx=${dxEvent.dx}');
  }
  results.add('Tested ${dxValues.length} dx values');
  
  // ========== Section 7: All Directions ==========
  print('--- Section 7: All Directions ---');
  
  final directions = SelectionExtendDirection.values;
  print('Available directions: ${directions.length}');
  for (final dir in directions) {
    final dirEvent = DirectionallyExtendSelectionEvent(
      dx: 1.0,
      isEnd: true,
      direction: dir,
    );
    print('  Direction: ${dirEvent.direction}');
  }
  results.add('All directions count: ${directions.length}');
  
  // ========== Section 8: Event Type Check ==========
  print('--- Section 8: Event Type Check ---');
  
  final typeEvent = DirectionallyExtendSelectionEvent(
    dx: 30.0,
    isEnd: false,
    direction: SelectionExtendDirection.backward,
  );
  
  // Check inheritance
  print('Is SelectionEvent: ${typeEvent is SelectionEvent}');
  print('Runtime type: ${typeEvent.runtimeType}');
  results.add('Is SelectionEvent: ${typeEvent is SelectionEvent}');
  
  // ========== Section 9: Zero dx ==========
  print('--- Section 9: Zero dx ---');
  
  final zeroDx = DirectionallyExtendSelectionEvent(
    dx: 0.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );
  print('Zero dx: ${zeroDx.dx}');
  print('Is zero: ${zeroDx.dx == 0.0}');
  results.add('Zero dx: ${zeroDx.dx == 0.0}');
  
  // ========== Section 10: Large dx ==========
  print('--- Section 10: Large dx ---');
  
  final largeDx = DirectionallyExtendSelectionEvent(
    dx: 10000.0,
    isEnd: true,
    direction: SelectionExtendDirection.forward,
  );
  print('Large dx: ${largeDx.dx}');
  results.add('Large dx: ${largeDx.dx}');

  print('DirectionallyExtendSelectionEvent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('DirectionallyExtendSelectionEvent Tests',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
