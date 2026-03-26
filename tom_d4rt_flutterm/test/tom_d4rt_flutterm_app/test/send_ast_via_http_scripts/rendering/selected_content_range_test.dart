// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectedContentRange from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectedContentRange test executing');
  print('=' * 50);

  // SelectedContentRange stores selection range with offsets
  print('\nSelectedContentRange:');
  print('Mixes in: Diagnosticable');
  print('Purpose: Stores the start and end offset of a selection');
  print('Returned by SelectionHandler.getSelection()');

  // Create an instance
  const range = SelectedContentRange(
    startOffset: 0,
    endOffset: 10,
  );
  print('\nCreated SelectedContentRange:');
  print('  runtimeType: ${range.runtimeType}');
  print('  startOffset: ${range.startOffset}');
  print('  endOffset: ${range.endOffset}');

  // Test different ranges
  const singleChar = SelectedContentRange(
    startOffset: 5,
    endOffset: 6,
  );
  print('\nSingle character range:');
  print('  startOffset: ${singleChar.startOffset}');
  print('  endOffset: ${singleChar.endOffset}');

  const fullRange = SelectedContentRange(
    startOffset: 0,
    endOffset: 100,
  );
  print('\nFull document range:');
  print('  startOffset: ${fullRange.startOffset}');
  print('  endOffset: ${fullRange.endOffset}');

  // Equality
  const range2 = SelectedContentRange(
    startOffset: 0,
    endOffset: 10,
  );
  print('\nEquality test:');
  print('  range == range2: ${range == range2}');
  print('  range.hashCode == range2.hashCode: ${range.hashCode == range2.hashCode}');

  // Diagnosticable
  print('\nDiagnosticable support:');
  print('  toString: $range');
  print('  Supports debugFillProperties for DevTools inspection');

  // Context
  print('\nUsage context:');
  print('  Used with SelectionHandler.getSelection()');
  print('  Often paired with SelectedContent.plainText');
  print('  Offsets are relative to the content of the Selectable');

  print('\n==================================================');
  print('SelectedContentRange test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectedContentRange Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable value class'),
      Text('start: ${range.startOffset}, end: ${range.endOffset}'),
      Text('Supports equality and diagnostics'),
      Text('Purpose: Selection offset range'),
    ],
  );
}
