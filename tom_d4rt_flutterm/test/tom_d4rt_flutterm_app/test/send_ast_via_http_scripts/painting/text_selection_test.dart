// ignore_for_file: avoid_print
// D4rt test script: Tests TextSelection, TextPosition, TextRange
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionTest test executing');

  // TextPosition
  final position1 = TextPosition(offset: 5);
  print('TextPosition offset: ${position1.offset}');
  print('TextPosition affinity: ${position1.affinity}');

  final position2 = TextPosition(offset: 10, affinity: TextAffinity.upstream);
  print('TextPosition(10, upstream) offset: ${position2.offset}');
  print('TextPosition(10, upstream) affinity: ${position2.affinity}');

  // TextRange
  final range1 = TextRange(start: 0, end: 5);
  print('TextRange start: ${range1.start}');
  print('TextRange end: ${range1.end}');
  print('TextRange isValid: ${range1.isValid}');
  print('TextRange isNormalized: ${range1.isNormalized}');
  print('TextRange isCollapsed: ${range1.isCollapsed}');

  // TextRange.empty
  final emptyRange = TextRange.empty;
  print('TextRange.empty start: ${emptyRange.start}');
  print('TextRange.empty end: ${emptyRange.end}');
  print('TextRange.empty isCollapsed: ${emptyRange.isCollapsed}');

  // TextRange.collapsed
  final collapsedRange = TextRange.collapsed(3);
  print('TextRange.collapsed(3) start: ${collapsedRange.start}');
  print('TextRange.collapsed(3) end: ${collapsedRange.end}');
  print('TextRange.collapsed(3) isCollapsed: ${collapsedRange.isCollapsed}');

  // TextRange textBefore/textAfter/textInside
  final sampleText = 'Hello, World!';
  print('textBefore: "${range1.textBefore(sampleText)}"');
  print('textAfter: "${range1.textAfter(sampleText)}"');
  print('textInside: "${range1.textInside(sampleText)}"');

  // TextSelection
  final selection1 = TextSelection(baseOffset: 0, extentOffset: 5);
  print('TextSelection baseOffset: ${selection1.baseOffset}');
  print('TextSelection extentOffset: ${selection1.extentOffset}');
  print('TextSelection isCollapsed: ${selection1.isCollapsed}');
  print('TextSelection isDirectional: ${selection1.isDirectional}');

  // TextSelection.collapsed
  final collapsedSel = TextSelection.collapsed(offset: 7);
  print('TextSelection.collapsed(7) baseOffset: ${collapsedSel.baseOffset}');
  print(
    'TextSelection.collapsed(7) extentOffset: ${collapsedSel.extentOffset}',
  );
  print('TextSelection.collapsed(7) isCollapsed: ${collapsedSel.isCollapsed}');

  // TextSelection with affinity
  final selWithAffinity = TextSelection(
    baseOffset: 3,
    extentOffset: 10,
    affinity: TextAffinity.upstream,
  );
  print('TextSelection(3,10) affinity: ${selWithAffinity.affinity}');
  print('TextSelection(3,10) start: ${selWithAffinity.start}');
  print('TextSelection(3,10) end: ${selWithAffinity.end}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Sample: "$sampleText"',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextRange(0,5) inside: "${range1.textInside(sampleText)}"',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextRange(0,5) before: "${range1.textBefore(sampleText)}"',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextRange(0,5) after: "${range1.textAfter(sampleText)}"',
        style: TextStyle(fontSize: 13.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextSelection(0,5) collapsed: ${selection1.isCollapsed}',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextSelection.collapsed(7) collapsed: ${collapsedSel.isCollapsed}',
        style: TextStyle(fontSize: 13.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextPosition(5) affinity: ${position1.affinity}',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextPosition(10) affinity: ${position2.affinity}',
        style: TextStyle(fontSize: 13.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextRange.empty collapsed: ${emptyRange.isCollapsed}',
        style: TextStyle(fontSize: 13.0, color: Colors.grey),
      ),
      Text(
        'TextRange.collapsed(3) collapsed: ${collapsedRange.isCollapsed}',
        style: TextStyle(fontSize: 13.0, color: Colors.grey),
      ),
    ],
  );
}
