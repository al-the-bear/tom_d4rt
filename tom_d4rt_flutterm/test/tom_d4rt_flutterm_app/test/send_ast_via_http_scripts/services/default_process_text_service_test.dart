// D4rt test script: Tests DefaultProcessTextService from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DefaultProcessTextService test executing');
  print('=' * 50);

  // DefaultProcessTextService - default implementation
  print('\nDefaultProcessTextService:');
  print('Default implementation of ProcessTextService');
  print('Uses platform channel for text actions');

  // Create instance
  final service = DefaultProcessTextService();
  print('\nInstance created:');
  print('runtimeType: ${service.runtimeType}');

  // Implements ProcessTextService
  print('\nImplements ProcessTextService:');
  print('is ProcessTextService: ${service is ProcessTextService}');

  // Methods
  print('\nMethods:');
  print('queryTextActions():');
  print('  - Queries platform for available actions');
  print('  - Returns List<ProcessTextAction>');
  print('');
  print('processTextAction(id, text, readOnly):');
  print('  - Sends text to platform action');
  print('  - Returns processed result');

  // Platform channel
  print('\nPlatform channel:');
  print('Uses MethodChannel for communication');
  print('Android: ACTION_PROCESS_TEXT intent');

  // Android implementation
  print('\nAndroid implementation:');
  print('1. Query PackageManager for handlers');
  print('2. List apps with PROCESS_TEXT filter');
  print('3. Create ProcessTextAction for each');
  print('4. Send intent to selected action');

  // Usage example
  print('\nUsage example:');
  print('final service = DefaultProcessTextService();');
  print('');
  print('// Get available actions');
  print('final actions = await service.queryTextActions();');
  print('');
  print('// Process selected text');
  print('final result = await service.processTextAction(');
  print('  actions.first.id,');
  print('  selectedText,');
  print('  true,');
  print(');');

  // Error handling
  print('\nError handling:');
  print('- Returns empty list if no actions');
  print('- Returns null if processing fails');
  print('- Handles platform exceptions');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ProcessTextService (abstract)');
  print('  \u2514\u2500 DefaultProcessTextService');

  // Explain purpose
  print('\nDefaultProcessTextService purpose:');
  print('- Default ProcessTextService implementation');
  print('- Platform channel communication');
  print('- Android PROCESS_TEXT integration');
  print('- Query and execute text actions');
  print('- Used by text selection system');

  print('\n' + '=' * 50);
  print('DefaultProcessTextService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DefaultProcessTextService Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${service.runtimeType}'),
      Text('Implements: ProcessTextService'),
      Text('Platform: Android primarily'),
      Text('Purpose: Default text processing'),
    ],
  );
}
