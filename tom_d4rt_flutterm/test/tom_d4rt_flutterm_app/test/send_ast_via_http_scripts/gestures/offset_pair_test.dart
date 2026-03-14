import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('OffsetPair test failed: $message');
  }
  logs.add('PASS: $message');
}

dynamic build(BuildContext context) {
  print('=== OffsetPair comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final pairA = OffsetPair(
    local: const Offset(10, 20),
    global: const Offset(100, 200),
  );
  final pairB = OffsetPair(
    local: const Offset(-3, 5),
    global: const Offset(40, 80),
  );
  final zero = OffsetPair.zero;

  _expectCondition(
    pairA.local == const Offset(10, 20),
    'constructor sets local on pairA',
    logs,
  );
  assertionCount++;
  _expectCondition(
    pairA.global == const Offset(100, 200),
    'constructor sets global on pairA',
    logs,
  );
  assertionCount++;

  _expectCondition(
    pairB.local == const Offset(-3, 5),
    'constructor sets local on pairB',
    logs,
  );
  assertionCount++;
  _expectCondition(
    pairB.global == const Offset(40, 80),
    'constructor sets global on pairB',
    logs,
  );
  assertionCount++;

  _expectCondition(
    zero.local == Offset.zero,
    'OffsetPair.zero has zero local',
    logs,
  );
  assertionCount++;
  _expectCondition(
    zero.global == Offset.zero,
    'OffsetPair.zero has zero global',
    logs,
  );
  assertionCount++;

  final added = pairA + pairB;
  final subtracted = pairA - pairB;

  _expectCondition(
    added.local == const Offset(7, 25),
    'operator + combines local offsets',
    logs,
  );
  assertionCount++;
  _expectCondition(
    added.global == const Offset(140, 280),
    'operator + combines global offsets',
    logs,
  );
  assertionCount++;

  _expectCondition(
    subtracted.local == const Offset(13, 15),
    'operator - subtracts local offsets',
    logs,
  );
  assertionCount++;
  _expectCondition(
    subtracted.global == const Offset(60, 120),
    'operator - subtracts global offsets',
    logs,
  );
  assertionCount++;

  final transformed = pairA * 2.0;
  _expectCondition(
    transformed.local == const Offset(20, 40),
    'operator * scales local offsets',
    logs,
  );
  assertionCount++;
  _expectCondition(
    transformed.global == const Offset(200, 400),
    'operator * scales global offsets',
    logs,
  );
  assertionCount++;

  final event = PointerMoveEvent(
    position: const Offset(55, 66),
    localPosition: const Offset(5, 6),
    delta: const Offset(2, 3),
    localDelta: const Offset(1, 1),
  );

  final fromPosition = OffsetPair.fromEventPosition(event);
  final fromDelta = OffsetPair.fromEventDelta(event);

  _expectCondition(
    fromPosition.local == const Offset(5, 6),
    'fromEventPosition captures local position',
    logs,
  );
  assertionCount++;
  _expectCondition(
    fromPosition.global == const Offset(55, 66),
    'fromEventPosition captures global position',
    logs,
  );
  assertionCount++;

  _expectCondition(
    fromDelta.local == const Offset(1, 1),
    'fromEventDelta captures local delta',
    logs,
  );
  assertionCount++;
  _expectCondition(
    fromDelta.global == const Offset(2, 3),
    'fromEventDelta captures global delta',
    logs,
  );
  assertionCount++;

  print('pairA: local=${pairA.local}, global=${pairA.global}');
  print('pairB: local=${pairB.local}, global=${pairB.global}');
  print('added: local=${added.local}, global=${added.global}');
  print('subtracted: local=${subtracted.local}, global=${subtracted.global}');
  print('scaled: local=${transformed.local}, global=${transformed.global}');
  print(
    'fromPosition: local=${fromPosition.local}, global=${fromPosition.global}',
  );
  print('fromDelta: local=${fromDelta.local}, global=${fromDelta.global}');

  final summary = <String>[
    'constructors covered: named + zero + factory constructors',
    'properties covered: local/global fields',
    'behavior covered: +, -, * operators',
    'edge cases covered: negative components and pointer event factories',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== OffsetPair comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('OffsetPair Tests'),
      Text('Assertions: $assertionCount'),
      Text('pairA: ${pairA.local} / ${pairA.global}'),
      Text('Added: ${added.local} / ${added.global}'),
      Text('Subtracted: ${subtracted.local} / ${subtracted.global}'),
      Text('From delta: ${fromDelta.local} / ${fromDelta.global}'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
