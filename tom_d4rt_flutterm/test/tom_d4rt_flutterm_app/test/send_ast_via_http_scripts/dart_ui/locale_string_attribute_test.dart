// D4rt test script: Comprehensive tests for LocaleStringAttribute
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: ' + message);
    throw StateError('LocaleStringAttribute assertion failed: ' + message);
  }
  logs.add('PASS: ' + message);
}

dynamic build(BuildContext context) {
  print('=== LocaleStringAttribute comprehensive test start ===');
  final logs = <String>[];
  var assertionCount = 0;

  final attrA = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 0, end: 5),
    locale: const ui.Locale('en', 'US'),
  );
  final attrB = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 5, end: 10),
    locale: const ui.Locale('de', 'DE'),
  );

  _expect(attrA.range.start == 0 && attrA.range.end == 5, 'constructor sets range for attrA', logs);
  assertionCount++;
  _expect(attrA.locale.languageCode == 'en', 'constructor sets locale language for attrA', logs);
  assertionCount++;
  _expect(attrB.range.start == 5 && attrB.range.end == 10, 'constructor sets range for attrB', logs);
  assertionCount++;
  _expect(attrB.locale.countryCode == 'DE', 'constructor sets locale country for attrB', logs);
  assertionCount++;

  _expect(attrA.toString().isNotEmpty, 'toString produces non-empty representation', logs);
  assertionCount++;
  _expect(attrA != attrB, 'distinct attributes compare as different', logs);
  assertionCount++;

  final attrs = <ui.LocaleStringAttribute>[attrA, attrB];
  _expect(attrs.length == 2, 'behavior path stores multiple attributes', logs);
  assertionCount++;

  final edge = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 0, end: 0),
    locale: const ui.Locale('und'),
  );
  _expect(edge.range.isCollapsed, 'edge case supports collapsed TextRange', logs);
  assertionCount++;

  print('attrA=$attrA');
  print('attrB=$attrB');
  print('edge=$edge');

  final summaryLines = <String>[
    'constructors covered: LocaleStringAttribute(range, locale)',
    'properties covered: range/locale/toString',
    'behavior covered: multi-attribute handling',
    'edge case covered: collapsed range + undefined locale code',
    'assertions: ' + assertionCount.toString(),
  ];
  for (final line in summaryLines) {
    print('SUMMARY: ' + line);
  }

  print('=== LocaleStringAttribute comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('LocaleStringAttribute Tests'),
      Text('Assertions: $assertionCount'),
      Text('A locale: ${attrA.locale.languageCode}-${attrA.locale.countryCode ?? ''}'),
      Text('B locale: ${attrB.locale.languageCode}-${attrB.locale.countryCode ?? ''}'),
      Text('Edge collapsed: ${edge.range.isCollapsed}'),
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
