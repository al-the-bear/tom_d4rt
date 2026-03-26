// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionEdgeUpdateEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionEdgeUpdateEvent test executing');
  print('=' * 50);

  // SelectionEdgeUpdateEvent moves a selection edge
  print('\nSelectionEdgeUpdateEvent:');
  print('Extends: SelectionEvent');
  print('Purpose: Updates start or end edge of a selection');
  print('Carries a global position and optional granularity');

  // Create start edge event
  final startEvent = SelectionEdgeUpdateEvent.forStart(
    globalPosition: const Offset(100.0, 200.0),
  );
  print('\nStart edge event:');
  print('  runtimeType: ${startEvent.runtimeType}');
  print('  type: ${startEvent.type}');
  print('  globalPosition: ${startEvent.globalPosition}');
  print('  granularity: ${startEvent.granularity}');

  // Create end edge event
  final endEvent = SelectionEdgeUpdateEvent.forEnd(
    globalPosition: const Offset(300.0, 250.0),
  );
  print('\nEnd edge event:');
  print('  type: ${endEvent.type}');
  print('  globalPosition: ${endEvent.globalPosition}');
  print('  granularity: ${endEvent.granularity}');

  // With word granularity
  final wordEvent = SelectionEdgeUpdateEvent.forStart(
    globalPosition: const Offset(50.0, 100.0),
    granularity: TextGranularity.word,
  );
  print('\nWord granularity event:');
  print('  granularity: ${wordEvent.granularity}');

  // TextGranularity enum
  print('\nTextGranularity values:');
  for (final g in TextGranularity.values) {
    print('  ${g.name}');
  }

  // Type discrimination
  print('\nType discrimination:');
  print('  startEvent.type == SelectionEventType.startEdgeUpdate: ${startEvent.type == SelectionEventType.startEdgeUpdate}');
  print('  endEvent.type == SelectionEventType.endEdgeUpdate: ${endEvent.type == SelectionEventType.endEdgeUpdate}');

  // Selection flow with edges
  print('\nSelection edge flow:');
  print('  1. User tap-drags to start selection');
  print('  2. forStart event sent with initial position');
  print('  3. User drags to extend selection');
  print('  4. forEnd event sent with drag position');
  print('  5. Handler updates SelectionGeometry');

  // Granularity options
  print('\nGranularity effect on selection:');
  print('  character: selects character-by-character (default)');
  print('  word: snaps selection to word boundaries');
  print('  paragraph: snaps to paragraph boundaries');
  print('  line: snaps to line boundaries');

  print('\n==================================================');
  print('SelectionEdgeUpdateEvent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionEdgeUpdateEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: SelectionEvent'),
      Text('Constructors: forStart, forEnd'),
      Text('Default granularity: character'),
    ],
  );
}
