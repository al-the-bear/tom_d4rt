// D4rt test script: Tests SelectAllSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectAllSelectionEvent test executing');

  // ========== Basic SelectAllSelectionEvent creation ==========
  print('--- Basic SelectAllSelectionEvent ---');
  final event1 = SelectAllSelectionEvent();
  print('  created: ${event1.runtimeType}');
  print('  type: ${event1.type}');

  // ========== SelectionEventType for SelectAll ==========
  print('--- SelectionEventType ---');
  print('  event type: ${event1.type}');
  print('  type name: ${event1.type.name}');
  print(
    '  type == SelectionEventType.selectAll: ${event1.type == SelectionEventType.selectAll}',
  );

  // ========== Multiple SelectAllSelectionEvent instances ==========
  print('--- Multiple instances ---');
  final event2 = SelectAllSelectionEvent();
  final event3 = SelectAllSelectionEvent();
  print('  event1.type: ${event1.type}');
  print('  event2.type: ${event2.type}');
  print('  event3.type: ${event3.type}');
  print(
    '  All have same type: ${event1.type == event2.type && event2.type == event3.type}',
  );

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  print('  event1 == event1: ${event1 == event1}');
  print('  event1 == event2: ${event1 == event2}');
  print('  event1.hashCode: ${event1.hashCode}');
  print('  event2.hashCode: ${event2.hashCode}');

  // ========== Runtime type check ==========
  print('--- Runtime type check ---');
  print('  event1 is SelectionEvent: ${event1 is SelectionEvent}');
  print(
    '  event1 is SelectAllSelectionEvent: ${event1 is SelectAllSelectionEvent}',
  );
  print('  event1.runtimeType: ${event1.runtimeType}');

  // ========== SelectionEventType enumeration ==========
  print('--- All SelectionEventType values ---');
  for (final eventType in SelectionEventType.values) {
    print('  ${eventType.name}: ${eventType.index}');
  }
  print('  Total event types: ${SelectionEventType.values.length}');

  // ========== Compare with other event types ==========
  print('--- Compare event types ---');
  print('  selectAll index: ${SelectionEventType.selectAll.index}');
  print('  selectWord index: ${SelectionEventType.selectWord.index}');
  print('  selectParagraph index: ${SelectionEventType.selectParagraph.index}');
  print(
    '  granularlyExtendSelection index: ${SelectionEventType.granularlyExtendSelection.index}',
  );
  print(
    '  directionallyExtendSelection index: ${SelectionEventType.directionallyExtendSelection.index}',
  );

  // ========== ToString ==========
  print('--- ToString ---');
  print('  event1.toString(): ${event1.toString()}');

  // ========== Event in list ==========
  print('--- Events in list ---');
  final events = <SelectionEvent>[event1, event2, event3];
  print('  events.length: ${events.length}');
  for (var i = 0; i < events.length; i++) {
    print('  events[$i].type: ${events[i].type}');
  }

  print('SelectAllSelectionEvent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectAllSelectionEvent Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Event type: ${event1.type}'),
          Text('Is SelectionEvent: ${event1 is SelectionEvent}'),
          Text(
            'Type == selectAll: ${event1.type == SelectionEventType.selectAll}',
          ),
          Text('Total event types: ${SelectionEventType.values.length}'),
          Text('Events created: 3'),
        ],
      ),
    ),
  );
}
