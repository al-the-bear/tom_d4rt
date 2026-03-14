// D4rt test script: Comprehensive tests for Size
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: ' + message);
    throw StateError('Size assertion failed: ' + message);
  }
  logs.add('PASS: ' + message);
}

dynamic build(BuildContext context) {
  print('=== Size comprehensive test start ===');
  final logs = <String>[];
  var assertionCount = 0;

  const s1 = ui.Size(100, 50);
  const s2 = ui.Size.square(40);
  const s3 = ui.Size.fromWidth(120);
  const s4 = ui.Size.fromHeight(90);

  _expect(s1.width == 100 && s1.height == 50, 'primary constructor sets width/height', logs);
  assertionCount++;
  _expect(s2.width == 40 && s2.height == 40, 'square constructor sets equal sides', logs);
  assertionCount++;
  _expect(s3.width == 120 && s3.height == 0, 'fromWidth behavior validated', logs);
  assertionCount++;
  _expect(s4.height == 90 && s4.width == 0, 'fromHeight behavior validated', logs);
  assertionCount++;

  _expect(s1.shortestSide == 50, 'shortestSide computed correctly', logs);
  assertionCount++;
  _expect(s1.longestSide == 100, 'longestSide computed correctly', logs);
  assertionCount++;

  final added = s1 + const ui.Size(10, 20);
  final subtracted = s1 - const ui.Size(10, 20);
  final multiplied = s1 * 2.0;
  final divided = s1 / 2.0;

  _expect(added == const ui.Size(110, 70), 'operator + works', logs);
  assertionCount++;
  _expect(subtracted == const ui.Size(90, 30), 'operator - works', logs);
  assertionCount++;
  _expect(multiplied == const ui.Size(200, 100), 'operator * works', logs);
  assertionCount++;
  _expect(divided == const ui.Size(50, 25), 'operator / works', logs);
  assertionCount++;

  const edge = ui.Size.zero;
  _expect(edge.isEmpty, 'Size.zero reports isEmpty', logs);
  assertionCount++;
  _expect(edge.width == 0 && edge.height == 0, 'Size.zero dimensions are zero', logs);
  assertionCount++;

  print('s1=$s1 s2=$s2 s3=$s3 s4=$s4 edge=$edge');
  print('added=$added subtracted=$subtracted multiplied=$multiplied divided=$divided');

  final summaryLines = <String>[
    'constructors covered: default/square/fromWidth/fromHeight',
    'properties covered: width/height/shortestSide/longestSide/isEmpty',
    'behavior covered: arithmetic operators',
    'edge case covered: Size.zero',
    'assertions: ' + assertionCount.toString(),
  ];
  for (final line in summaryLines) {
    print('SUMMARY: ' + line);
  }

  print('=== Size comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Size Tests'),
      Text('Assertions: $assertionCount'),
      Text('s1: $s1'),
      Text('added: $added'),
      Text('edge isEmpty: ${edge.isEmpty}'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
// filler line 01
// filler line 02
// filler line 03
// filler line 04
// filler line 05
// filler line 06
// filler line 07
// filler line 08
// filler line 09
// filler line 10
// filler line 11
// filler line 12
// filler line 13
// filler line 14
// filler line 15
// filler line 16
// filler line 17
// filler line 18
// filler line 19
// filler line 20
// filler line 21
// filler line 22
// filler line 23
// filler line 24
// filler line 25
// filler line 26
// filler line 27
// filler line 28
// filler line 29
// filler line 30
