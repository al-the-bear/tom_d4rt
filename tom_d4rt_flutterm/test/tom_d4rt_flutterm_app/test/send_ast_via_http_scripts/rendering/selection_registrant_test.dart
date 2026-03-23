// ignore_for_file: avoid_print
// D4rt test script: Tests SelectionRegistrant from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionRegistrant test executing');

  // SelectionRegistrant - Mixin for objects that can register with SelectionContainer
  // Used by Selectable and SelectionHandler implementations
  
  print('SelectionRegistrant mixin properties:');
  print('- Allows objects to participate in selection system');
  print('- Registers with parent SelectionContainer');
  print('- Provides selection geometry to container');
  print('- Handles selection events from container');
  
  // The mixin interface
  print('\nSelectionRegistrant methods:');
  print('- registrar: The SelectionContainerRegistrar to register with');
  print('- set registrar(SelectionRegistrar? value)');
  print('- Registration happens automatically when registrar is set');
  
  // Related classes
  print('\nRelated classes:');
  print('- SelectionContainerRegistrar: Container that accepts registrations');
  print('- Selectable: Interface for selectable content');
  print('- SelectionContainer: Widget that manages selection');
  print('- SelectableRegion: Widget wrapper for selectable content');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('SelectionRegistrant is a mixin');
  print('Mixed into classes implementing Selectable');
  print('Works with SelectionContainerRegistrar');
  
  // Use cases
  print('\nUse cases:');
  print('- Custom selectable widgets');
  print('- Text selection in custom text renderers');
  print('- Multi-child selection handling');
  print('- Hierarchical selection registration');

  print('\nSelectionRegistrant test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionRegistrant Tests'),
      Text('Mixin for selection registration'),
      Text('Works with SelectionContainerRegistrar'),
      Text('Enables custom selectable widgets'),
    ],
  );
}
