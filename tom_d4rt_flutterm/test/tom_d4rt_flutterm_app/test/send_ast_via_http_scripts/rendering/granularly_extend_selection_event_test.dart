// D4rt test script: Tests GranularlyExtendSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GranularlyExtendSelectionEvent test executing');

  // ========== Basic GranularlyExtendSelectionEvent creation ==========
  print('--- Basic GranularlyExtendSelectionEvent ---');
  final event1 = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.character,
  );
  print('  created: ${event1.runtimeType}');
  print('  isEnd: ${event1.isEnd}');
  print('  forward: ${event1.forward}');
  print('  granularity: ${event1.granularity}');

  // ========== Forward vs Backward events ==========
  print('--- Forward vs Backward ---');
  final forwardEvent = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.word,
  );
  print('  forward event');
  print('    forward: ${forwardEvent.forward}');
  print('    isEnd: ${forwardEvent.isEnd}');
  print('    granularity: ${forwardEvent.granularity}');

  final backwardEvent = GranularlyExtendSelectionEvent.backward(
    isEnd: false,
    granularity: TextGranularity.word,
  );
  print('  backward event');
  print('    forward: ${backwardEvent.forward}');
  print('    isEnd: ${backwardEvent.isEnd}');
  print('    granularity: ${backwardEvent.granularity}');

  // ========== Different TextGranularity values ==========
  print('--- Different TextGranularity ---');
  final charEvent = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.character,
  );
  print('  character granularity: ${charEvent.granularity}');

  final wordEvent = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.word,
  );
  print('  word granularity: ${wordEvent.granularity}');

  final lineEvent = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.line,
  );
  print('  line granularity: ${lineEvent.granularity}');

  final documentEvent = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.document,
  );
  print('  document granularity: ${documentEvent.granularity}');

  // ========== isEnd variations ==========
  print('--- isEnd variations ---');
  final endTrue = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.character,
  );
  print('  isEnd=true: ${endTrue.isEnd}');

  final endFalse = GranularlyExtendSelectionEvent.forward(
    isEnd: false,
    granularity: TextGranularity.character,
  );
  print('  isEnd=false: ${endFalse.isEnd}');

  // ========== SelectionEvent type ==========
  print('--- SelectionEvent type ---');
  print('  event1 is SelectionEvent: ${event1 is SelectionEvent}');
  print('  event1.type: ${event1.type}');

  // ========== Comparing events ==========
  print('--- Comparing events ---');
  final eventA = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.word,
  );
  final eventB = GranularlyExtendSelectionEvent.forward(
    isEnd: true,
    granularity: TextGranularity.word,
  );
  print('  eventA.forward: ${eventA.forward}');
  print('  eventB.forward: ${eventB.forward}');
  print(
    '  eventA.granularity == eventB.granularity: ${eventA.granularity == eventB.granularity}',
  );

  print('GranularlyExtendSelectionEvent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'GranularlyExtendSelectionEvent Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Event type: ${event1.runtimeType}'),
          Text('Forward event: ${forwardEvent.forward}'),
          Text('Backward event: ${backwardEvent.forward}'),
          SizedBox(height: 8.0),
          Text('TextGranularity values:'),
          Text('  - character'),
          Text('  - word'),
          Text('  - line'),
          Text('  - document'),
        ],
      ),
    ),
  );
}
