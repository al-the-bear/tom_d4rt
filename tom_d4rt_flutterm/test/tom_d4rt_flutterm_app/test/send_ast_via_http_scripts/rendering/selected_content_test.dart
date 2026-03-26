// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectedContent from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectedContent test executing');
  print('=' * 50);

  // SelectedContent holds the text content of a selection
  print('\nSelectedContent:');
  print('Mixes in: Diagnosticable');
  print('Purpose: Stores the plain text of a selection');
  print('Returned by SelectionHandler.getSelectedContent()');

  // Create an instance
  const content = SelectedContent(plainText: 'Hello, World!');
  print('\nCreated SelectedContent:');
  print('  runtimeType: ${content.runtimeType}');
  print('  plainText: ${content.plainText}');

  // Empty content
  const emptyContent = SelectedContent(plainText: '');
  print('\nEmpty SelectedContent:');
  print('  plainText: "${emptyContent.plainText}"');
  print('  plainText.isEmpty: ${emptyContent.plainText.isEmpty}');

  // Multi-line content
  const multiLine = SelectedContent(
    plainText: 'Line 1\nLine 2\nLine 3',
  );
  print('\nMulti-line SelectedContent:');
  print('  plainText: ${multiLine.plainText}');
  print('  lines: ${multiLine.plainText.split('\n').length}');

  // Special characters
  const special = SelectedContent(
    plainText: 'Tabs\tand\tspaces   and\nnewlines',
  );
  print('\nSpecial characters:');
  print('  plainText: ${special.plainText}');

  // Diagnosticable
  print('\nDiagnosticable support:');
  print('  toString: $content');
  print('  Provides debugFillProperties for DevTools');

  // Usage context
  print('\nUsage context:');
  print('  SelectionHandler.getSelectedContent() -> SelectedContent?');
  print('  Contains only plain text representation');
  print('  Null when nothing is selected');
  print('  Paired with SelectedContentRange for offset info');

  // Selection flow
  print('\nSelection retrieval flow:');
  print('  1. User selects text in a Selectable');
  print('  2. Call handler.getSelectedContent()');
  print('  3. Returns SelectedContent with plainText');
  print('  4. Call handler.getSelection() for range info');

  // Null handling
  print('\nNull handling:');
  print('  getSelectedContent() returns null when nothing is selected');
  print('  Always check for null before accessing plainText');

  print('\n==================================================');
  print('SelectedContent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectedContent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable value class'),
      Text('plainText: ${content.plainText}'),
      Text('Supports diagnostics'),
      Text('Purpose: Selected text content'),
    ],
  );
}
