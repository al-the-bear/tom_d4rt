// D4rt test script: Tests SelectionEdgeUpdateEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionEdgeUpdateEvent test executing');

  // ========== Basic SelectionEdgeUpdateEvent creation ==========
  print('--- Basic SelectionEdgeUpdateEvent ---');
  final event1 = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 200.0),
  );
  print('  created: ${event1.runtimeType}');
  print('  type: ${event1.type}');
  print('  globalPosition: ${event1.globalPosition}');

  // ========== ForStart factory ==========
  print('--- ForStart factory ---');
  final startEvent = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(50.0, 75.0),
  );
  print('  startEvent created');
  print('  globalPosition: ${startEvent.globalPosition}');
  print('  type: ${startEvent.type}');

  // ========== ForEnd factory ==========
  print('--- ForEnd factory ---');
  final endEvent = SelectionEdgeUpdateEvent.forEnd(
    globalPosition: Offset(250.0, 300.0),
  );
  print('  endEvent created');
  print('  globalPosition: ${endEvent.globalPosition}');
  print('  type: ${endEvent.type}');

  // ========== Granularity options ==========
  print('--- Granularity options ---');
  final eventWithCharGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.character,
  );
  final eventWithWordGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.word,
  );
  final eventWithLineGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.line,
  );
  final eventWithDocGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.document,
  );
  print('  character granularity: ${eventWithCharGranularity.granularity}');
  print('  word granularity: ${eventWithWordGranularity.granularity}');
  print('  line granularity: ${eventWithLineGranularity.granularity}');
  print('  document granularity: ${eventWithDocGranularity.granularity}');

  // ========== TextGranularity enumeration ==========
  print('--- TextGranularity values ---');
  for (final granularity in TextGranularity.values) {
    print('  ${granularity.name}: ${granularity.index}');
  }
  print('  Total granularity values: ${TextGranularity.values.length}');

  // ========== Different positions ==========
  print('--- Different positions ---');
  final zeroPos = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset.zero,
  );
  final negativePos = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(-50.0, -50.0),
  );
  final largePos = SelectionEdgeUpdateEvent.forEnd(
    globalPosition: Offset(10000.0, 20000.0),
  );
  print('  zero position: ${zeroPos.globalPosition}');
  print('  negative position: ${negativePos.globalPosition}');
  print('  large position: ${largePos.globalPosition}');

  // ========== Event type verification ==========
  print('--- Event type ---');
  print('  event1.type: ${event1.type}');
  print(
    '  is startEdgeUpdate: ${event1.type == SelectionEventType.startEdgeUpdate}',
  );
  print(
    '  is endEdgeUpdate: ${event1.type == SelectionEventType.endEdgeUpdate}',
  );

  // ========== Multiple events ==========
  print('--- Multiple events ---');
  final events = <SelectionEdgeUpdateEvent>[
    SelectionEdgeUpdateEvent.forStart(globalPosition: Offset(0.0, 0.0)),
    SelectionEdgeUpdateEvent.forStart(globalPosition: Offset(50.0, 50.0)),
    SelectionEdgeUpdateEvent.forEnd(globalPosition: Offset(100.0, 100.0)),
    SelectionEdgeUpdateEvent.forEnd(globalPosition: Offset(150.0, 150.0)),
  ];
  print('  Created ${events.length} events');
  for (var i = 0; i < events.length; i++) {
    print('  [$i] type: ${events[i].type}, pos: ${events[i].globalPosition}');
  }

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final eventA = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
  );
  final eventB = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
  );
  print('  eventA == eventA: ${eventA == eventA}');
  print('  eventA == eventB: ${eventA == eventB}');
  print(
    '  eventA.globalPosition == eventB.globalPosition: ${eventA.globalPosition == eventB.globalPosition}',
  );

  // ========== ToString ==========
  print('--- ToString ---');
  print('  event1.toString(): ${event1.toString()}');

  print('SelectionEdgeUpdateEvent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionEdgeUpdateEvent Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Start event position: ${startEvent.globalPosition}'),
          Text('End event position: ${endEvent.globalPosition}'),
          Text('Granularity types: ${TextGranularity.values.length}'),
          Text('Events created: ${events.length}'),
        ],
      ),
    ),
  );
}
