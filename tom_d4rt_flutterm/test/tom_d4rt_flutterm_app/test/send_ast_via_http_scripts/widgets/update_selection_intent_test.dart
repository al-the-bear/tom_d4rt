// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UpdateSelectionIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('UpdateSelectionIntent test executing');
  print('=' * 50);

  // UpdateSelectionIntent changes text selection
  print('UpdateSelectionIntent overview:');
  print('  - Extends Intent');
  print('  - Updates text selection');
  print('  - Has 3 required properties');
  print('  - Used by text editing actions');

  // Create intent
  print('\nCreating intent:');
  final intent = UpdateSelectionIntent(
    TextEditingValue(text: 'Hello', selection: TextSelection.collapsed(offset: 5)),
    TextSelection.collapsed(offset: 0),
    SelectionChangedCause.keyboard,
  );
  print('  Created: $intent');
  print('  currentValue: ${intent.currentTextEditingValue}');
  print('  newSelection: ${intent.newSelection}');
  print('  cause: ${intent.cause}');

  // currentTextEditingValue property
  print('\ncurrentTextEditingValue:');
  print('  - Current text editing state');
  print('  - Includes text and selection');
  print('  - Includes composing region');
  print('  - Read before update');

  // newSelection property
  print('\nnewSelection:');
  print('  - Target TextSelection');
  print('  - Can be collapsed (cursor)');
  print('  - Can be range (highlight)');
  print('  - Applied to text');

  // SelectionChangedCause
  print('\ncause values:');
  print('  - tap: user tapped');
  print('  - doubleTap: word selection');
  print('  - longPress: context menu');
  print('  - keyboard: arrow keys, etc.');
  print('  - drag: dragging selection');
  print('  - forcePress: 3D touch');

  // Usage patterns
  print('\nUsage patterns:');
  print('  - Keyboard navigation');
  print('  - Shift+Arrow for selection extend');
  print('  - Home/End for line start/end');
  print('  - Ctrl+A for select all');

  // Action handling
  print('\nAction handling:');
  print('  - EditableText provides action');
  print('  - Updates controller.value');
  print('  - Triggers selection change callback');
  print('  - May affect scroll position');

  // Implementation
  print('\nImplementation:');
  print('  - const constructor');
  print('  - All 3 properties required');
  print('  - Properties are final');
  print('  - Immutable intent');

  print('\n' + '=' * 50);
  print('UpdateSelectionIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UpdateSelectionIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Intent subclass'),
      Text('Props: currentTextEditingValue, newSelection, cause'),
      Text('Use: Text selection changes'),
    ],
  );
}
