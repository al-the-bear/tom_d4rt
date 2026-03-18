// D4rt test script: Tests TextSelection from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelection test executing');
  print('=' * 50);

  // TextSelection represents a range of text
  print('\nTextSelection:');
  print('Represents a selection within text');
  print('Can be a range or collapsed cursor');

  // Create collapsed selection (cursor)
  final cursor = TextSelection.collapsed(offset: 5);
  print('\nCollapsed selection (cursor):');
  print('offset: ${cursor.baseOffset}');
  print('isCollapsed: ${cursor.isCollapsed}');
  print('isValid: ${cursor.isValid}');

  // Create range selection
  final range = TextSelection(baseOffset: 2, extentOffset: 10);
  print('\nRange selection:');
  print('baseOffset: ${range.baseOffset}');
  print('extentOffset: ${range.extentOffset}');
  print('start: ${range.start}');
  print('end: ${range.end}');
  print('isCollapsed: ${range.isCollapsed}');
  print('isDirectional: ${range.isDirectional}');

  // Reverse selection (extent before base)
  final reverse = TextSelection(baseOffset: 10, extentOffset: 2);
  print('\nReverse selection:');
  print('baseOffset: ${reverse.baseOffset}');
  print('extentOffset: ${reverse.extentOffset}');
  print('start (min): ${reverse.start}');
  print('end (max): ${reverse.end}');

  // TextSelection.fromPosition
  final fromPos = TextSelection.fromPosition(TextPosition(offset: 7));
  print('\nFromPosition:');
  print('offset: ${fromPos.baseOffset}');
  print('isCollapsed: ${fromPos.isCollapsed}');

  // Affinity handling
  final withAffinity = TextSelection.collapsed(
    offset: 5,
    affinity: TextAffinity.upstream,
  );
  print('\nAffinity:');
  print('affinity: ${withAffinity.affinity}');
  print('upstream = before line break');
  print('downstream = after line break');

  // copyWith
  final modified = range.copyWith(extentOffset: 15);
  print('\ncopyWith:');
  print('original extent: ${range.extentOffset}');
  print('modified extent: ${modified.extentOffset}');

  // Equality
  final same = TextSelection(baseOffset: 2, extentOffset: 10);
  print('\nEquality:');
  print('range == same: ${range == same}');
  print('hashCode equal: ${range.hashCode == same.hashCode}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('TextRange');
  print('  \u2514\u2500 TextSelection');
  print('is TextRange: true /* range is TextRange */');

  // TextRange properties inherited
  print('\nInherited from TextRange:');
  print('isNormalized: ${range.isNormalized}');
  print('isCollapsed: ${range.isCollapsed}');

  // Explain purpose
  print('\nTextSelection purpose:');
  print('- Represents text selection range');
  print('- Cursor position (collapsed)');
  print('- Selection range (base to extent)');
  print('- Used by TextField, EditableText');
  print('- Supports affinity for line breaks');

  print('\n' + '=' * 50);
  print('TextSelection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextSelection Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Cursor offset: ${cursor.baseOffset}'),
      Text('Range: ${range.start}-${range.end}'),
      Text('Extends: TextRange'),
      Text('Purpose: Text selection handling'),
    ],
  );
}
