// D4rt test script: Tests SelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionEvent test executing');

  // ========== SelectionEvent is abstract - test via concrete types ==========
  print('--- SelectionEvent hierarchy ---');
  print('  SelectionEvent is an abstract base class');
  print('  Concrete implementations include:');
  print('    - SelectAllSelectionEvent');
  print('    - SelectWordSelectionEvent');
  print('    - SelectionEdgeUpdateEvent');
  print('    - ClearSelectionEvent');
  print('    - GranularlyExtendSelectionEvent');
  print('    - DirectionallyExtendSelectionEvent');

  // ========== SelectAllSelectionEvent ==========
  print('--- SelectAllSelectionEvent ---');
  final selectAll = SelectAllSelectionEvent();
  print('  type: ${selectAll.type}');
  print('  is SelectionEvent: ${selectAll is SelectionEvent}');
  print('  runtimeType: ${selectAll.runtimeType}');

  // ========== SelectWordSelectionEvent ==========
  print('--- SelectWordSelectionEvent ---');
  final selectWord = SelectWordSelectionEvent(
    globalPosition: Offset(100.0, 100.0),
  );
  print('  type: ${selectWord.type}');
  print('  globalPosition: ${selectWord.globalPosition}');
  print('  is SelectionEvent: ${selectWord is SelectionEvent}');

  // ========== ClearSelectionEvent ==========
  print('--- ClearSelectionEvent ---');
  final clearSelection = ClearSelectionEvent();
  print('  type: ${clearSelection.type}');
  print('  is SelectionEvent: ${clearSelection is SelectionEvent}');
  print('  runtimeType: ${clearSelection.runtimeType}');

  // ========== SelectionEdgeUpdateEvent forStart ==========
  print('--- SelectionEdgeUpdateEvent.forStart ---');
  final startEdge = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(50.0, 75.0),
  );
  print('  type: ${startEdge.type}');
  print('  globalPosition: ${startEdge.globalPosition}');
  print('  is SelectionEvent: ${startEdge is SelectionEvent}');

  // ========== SelectionEdgeUpdateEvent forEnd ==========
  print('--- SelectionEdgeUpdateEvent.forEnd ---');
  final endEdge = SelectionEdgeUpdateEvent.forEnd(
    globalPosition: Offset(200.0, 300.0),
  );
  print('  type: ${endEdge.type}');
  print('  globalPosition: ${endEdge.globalPosition}');
  print('  is SelectionEvent: ${endEdge is SelectionEvent}');

  // ========== SelectionEventType enumeration ==========
  print('--- SelectionEventType values ---');
  for (final eventType in SelectionEventType.values) {
    print('  ${eventType.name}: ${eventType.index}');
  }
  print('  Total event types: ${SelectionEventType.values.length}');

  // ========== Collect all events in list ==========
  print('--- All events in list ---');
  final events = <SelectionEvent>[
    selectAll,
    selectWord,
    clearSelection,
    startEdge,
    endEdge,
  ];
  print('  Total events: ${events.length}');
  for (var i = 0; i < events.length; i++) {
    print(
      '  [$i] type: ${events[i].type}, runtimeType: ${events[i].runtimeType}',
    );
  }

  // ========== Type checking ==========
  print('--- Type checking ---');
  for (final event in events) {
    print('  ${event.runtimeType}:');
    print(
      '    is SelectAllSelectionEvent: ${event is SelectAllSelectionEvent}',
    );
    print(
      '    is SelectWordSelectionEvent: ${event is SelectWordSelectionEvent}',
    );
    print('    is ClearSelectionEvent: ${event is ClearSelectionEvent}');
    print(
      '    is SelectionEdgeUpdateEvent: ${event is SelectionEdgeUpdateEvent}',
    );
  }

  // ========== Event type comparison ==========
  print('--- Event type comparison ---');
  print(
    '  selectAll.type == selectWord.type: ${selectAll.type == selectWord.type}',
  );
  print(
    '  selectAll.type == clearSelection.type: ${selectAll.type == clearSelection.type}',
  );
  print('  startEdge.type == endEdge.type: ${startEdge.type == endEdge.type}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  selectAll.toString(): ${selectAll.toString()}');
  print('  selectWord.toString(): ${selectWord.toString()}');
  print('  clearSelection.toString(): ${clearSelection.toString()}');

  print('SelectionEvent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionEvent Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('SelectionEvent is abstract base class'),
          Text('Concrete types tested: 5'),
          Text('SelectAllSelectionEvent type: ${selectAll.type}'),
          Text('SelectWordSelectionEvent type: ${selectWord.type}'),
          Text('ClearSelectionEvent type: ${clearSelection.type}'),
          Text('StartEdge type: ${startEdge.type}'),
          Text('EndEdge type: ${endEdge.type}'),
          Text('Total event types: ${SelectionEventType.values.length}'),
        ],
      ),
    ),
  );
}
