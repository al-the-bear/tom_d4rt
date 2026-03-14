// D4rt test script: Comprehensive tests for RSuperellipse
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: ' + message);
    throw StateError('RSuperellipse assertion failed: ' + message);
  }
  logs.add('PASS: ' + message);
}

dynamic build(BuildContext context) {
  print('=== RSuperellipse comprehensive test start ===');
  final logs = <String>[];
  var assertionCount = 0;

  final a = ui.RSuperellipse.fromLTRBXY(0, 0, 120, 80, 16, 10);
  final b = ui.RSuperellipse.fromRectAndRadius(
    const ui.Rect.fromLTWH(10, 20, 60, 40),
    const ui.Radius.circular(8),
  );
  final c = ui.RSuperellipse.fromRectAndCorners(
    const ui.Rect.fromLTWH(0, 0, 50, 30),
    topLeft: const ui.Radius.circular(4),
    topRight: const ui.Radius.circular(6),
    bottomRight: const ui.Radius.circular(8),
    bottomLeft: const ui.Radius.circular(2),
  );

  _expect(a.width == 120 && a.height == 80, 'fromLTRBXY dimensions are correct', logs);
  assertionCount++;
  _expect(!a.isEmpty && a.isFinite, 'a geometry flags are valid', logs);
  assertionCount++;
  _expect(b.outerRect.width == 60 && b.outerRect.height == 40, 'fromRectAndRadius tracks outerRect', logs);
  assertionCount++;
  _expect(c.center == const ui.Offset(25, 15), 'fromRectAndCorners center computed correctly', logs);
  assertionCount++;

  final shifted = a.shift(const ui.Offset(5, -5));
  final inflated = a.inflate(4);
  final deflated = a.deflate(4);

  _expect(shifted.left == a.left + 5, 'shift updates left coordinate', logs);
  assertionCount++;
  _expect(inflated.width > a.width, 'inflate increases width', logs);
  assertionCount++;
  _expect(deflated.width < a.width, 'deflate decreases width', logs);
  assertionCount++;

  final lerped = ui.RSuperellipse.lerp(a, b, 0.5);
  _expect(lerped != null, 'lerp returns non-null midpoint', logs);
  assertionCount++;

  final edge = ui.RSuperellipse.zero;
  _expect(edge.isEmpty, 'RSuperellipse.zero is empty', logs);
  assertionCount++;
  _expect(edge.shortestSide == 0, 'zero shortestSide is 0', logs);
  assertionCount++;

  print('a=$a b=$b c=$c shifted=$shifted inflated=$inflated deflated=$deflated lerped=$lerped edge=$edge');

  final summaryLines = <String>[
    'constructors covered: fromLTRBXY/fromRectAndRadius/fromRectAndCorners/zero',
    'properties covered: width/height/outerRect/center/isEmpty/isFinite',
    'behavior covered: shift/inflate/deflate/lerp',
    'edge case covered: RSuperellipse.zero',
    'assertions: ' + assertionCount.toString(),
  ];
  for (final line in summaryLines) {
    print('SUMMARY: ' + line);
  }

  print('=== RSuperellipse comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('RSuperellipse Tests'),
      Text('Assertions: $assertionCount'),
      Text('A size: ${a.width} x ${a.height}'),
      Text('B outerRect: ${b.outerRect}'),
      Text('Edge empty: ${edge.isEmpty}'),
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
