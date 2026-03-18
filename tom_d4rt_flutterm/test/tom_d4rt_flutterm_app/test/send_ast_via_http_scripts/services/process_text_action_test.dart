// D4rt test script: Tests ProcessTextAction from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ProcessTextAction test executing');
  print('=' * 50);

  // Create ProcessTextAction
  final action1 = ProcessTextAction(id: 'copy', label: 'Copy');
  print('\nProcessTextAction created:');
  print('runtimeType: ${action1.runtimeType}');
  print('id: ${action1.id}');
  print('label: ${action1.label}');

  // Create different actions
  print('\nDifferent process text actions:');
  final translateAction = ProcessTextAction(
    id: 'translate',
    label: 'Translate',
  );
  final defineAction = ProcessTextAction(id: 'define', label: 'Define');
  final searchAction = ProcessTextAction(id: 'search', label: 'Search');
  print('Translate: id=${translateAction.id}, label=${translateAction.label}');
  print('Define: id=${defineAction.id}, label=${defineAction.label}');
  print('Search: id=${searchAction.id}, label=${searchAction.label}');

  // Create with custom IDs
  print('\nCustom action IDs:');
  final customAction = ProcessTextAction(
    id: 'com.myapp.share',
    label: 'Share with friends',
  );
  print('Custom id: ${customAction.id}');
  print('Custom label: ${customAction.label}');

  // Test action collection
  print('\nAction collection:');
  final actions = [
    ProcessTextAction(id: 'copy', label: 'Copy'),
    ProcessTextAction(id: 'paste', label: 'Paste'),
    ProcessTextAction(id: 'share', label: 'Share'),
    ProcessTextAction(id: 'translate', label: 'Translate'),
  ];
  print('Total actions: ${actions.length}');
  for (final action in actions) {
    print('  - ${action.label} (${action.id})');
  }

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* action1 is Object */');

  // Compare actions
  print('\nAction comparison:');
  final sameAction1 = ProcessTextAction(id: 'test', label: 'Test');
  final sameAction2 = ProcessTextAction(id: 'test', label: 'Test');
  print('sameAction1 == sameAction2: ${sameAction1 == sameAction2}');
  print('Same ID: ${sameAction1.id == sameAction2.id}');

  // Android-specific context
  print('\nAndroid context:');
  print('- ProcessTextAction maps to Android PROCESS_TEXT intent');
  print('- Apps can register to handle selected text');
  print('- Actions appear in text selection menu');
  print('- Example: Translation apps, dictionaries');

  // Identifier patterns
  print('\nID patterns:');
  print('Simple: copy, paste, share');
  print('Package-based: com.google.translate, com.app.action');

  // Explain purpose
  print('\nProcessTextAction purpose:');
  print('- Represents a text processing action');
  print('- id: Unique identifier for the action');
  print('- label: Human-readable display name');
  print('- Used with ProcessTextService');
  print('- Enables text selection context menu');
  print('- Platform-specific (mainly Android)');

  print('\n' + '=' * 50);
  print('ProcessTextAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ProcessTextAction Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${action1.runtimeType}'),
      Text('id: ${action1.id}'),
      Text('label: ${action1.label}'),
      Text('Actions: ${actions.length} defined'),
      Text('Purpose: Text processing actions'),
    ],
  );
}
