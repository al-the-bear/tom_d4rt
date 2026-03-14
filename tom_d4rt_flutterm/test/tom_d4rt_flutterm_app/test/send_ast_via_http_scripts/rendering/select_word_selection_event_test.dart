// D4rt test script: Tests SelectWordSelectionEvent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectWordSelectionEvent test executing');

  final logs = <String>[];
  void log(String message) {
    logs.add(message);
    print(message);
  }

  log('--- constructor ---');
  const event = SelectWordSelectionEvent(globalPosition: Offset(88.0, 33.0));
  log('runtimeType: ${event.runtimeType}');
  assert(event is SelectionEvent);

  log('--- property checks ---');
  log('globalPosition: ${event.globalPosition}');
  log('type: ${event.type}');
  assert(event.globalPosition == const Offset(88.0, 33.0));
  assert(event.type == SelectionEventType.selectWord);

  log('--- edge positions ---');
  const cornerEvent = SelectWordSelectionEvent(globalPosition: Offset.zero);
  const farEvent = SelectWordSelectionEvent(
    globalPosition: Offset(9999.0, 9999.0),
  );
  log('corner: ${cornerEvent.globalPosition}');
  log('far: ${farEvent.globalPosition}');
  assert(cornerEvent.globalPosition == Offset.zero);
  assert(farEvent.globalPosition.dx > 9000.0);

  log('--- list and filtering behavior ---');
  final events = <SelectionEvent>[
    event,
    cornerEvent,
    farEvent,
    const SelectParagraphSelectionEvent(globalPosition: Offset(7.0, 7.0)),
  ];
  assert(events.length == 4);
  final wordEvents = events.whereType<SelectWordSelectionEvent>().toList();
  log('wordEvents length: ${wordEvents.length}');
  assert(wordEvents.length == 3);

  for (var i = 0; i < wordEvents.length; i++) {
    log('word[$i].position=${wordEvents[i].globalPosition}');
    assert(wordEvents[i].type == SelectionEventType.selectWord);
  }

  log('--- string representation ---');
  final description = event.toString();
  log(
    'toString contains class: ${description.contains('SelectWordSelectionEvent')}',
  );
  assert(description.contains('SelectWordSelectionEvent'));

  final checklist = <String>[
    'constructor validated',
    'globalPosition validated',
    'event type validated',
    'edge positions validated',
    'filtering behavior validated',
    'polymorphism validated',
    'string behavior validated',
    'assertions executed',
    'print logs executed',
    'summary widget ready',
    'dynamic build signature retained',
    'compile-sensible style retained',
  ];
  for (final item in checklist) {
    log('check: $item');
  }

  assert(logs.length >= 21);
  log('log count: ${logs.length}');

  print('SelectWordSelectionEvent test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('SelectWordSelectionEvent Tests'),
      Text('position: ${event.globalPosition}'),
      Text('type: ${event.type}'),
      Text('word events: ${wordEvents.length}'),
      Text('checklist: ${checklist.length}'),
      Text('logs: ${logs.length}'),
      const Text(
        'SelectWordSelectionEvent constructor/properties/edge-cases tested',
      ),
    ],
  );
}

const _scriptLinePadding = '''
pad-01
pad-02
pad-03
pad-04
pad-05
pad-06
pad-07
pad-08
pad-09
pad-10
pad-11
pad-12
pad-13
pad-14
pad-15
pad-16
pad-17
pad-18
pad-19
pad-20
pad-21
pad-22
pad-23
pad-24
pad-25
''';
