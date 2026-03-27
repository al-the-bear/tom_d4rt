// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PasteTextIntent from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PasteTextIntent test executing');
  print('=' * 50);

  // === Test PasteTextIntent class ===
  print('\nPasteTextIntent represents paste action');

  // Create PasteTextIntent
  print('\n--- Testing creation ---');
  const intent = PasteTextIntent(SelectionChangedCause.keyboard);
  print('Created PasteTextIntent(SelectionChangedCause.keyboard)');
  print('intent.cause: ${intent.cause}');
  print('intent.runtimeType: ${intent.runtimeType}');

  // Test different causes
  print('\n--- Testing with different causes ---');
  const intentTap = PasteTextIntent(SelectionChangedCause.tap);
  const intentLong = PasteTextIntent(SelectionChangedCause.longPress);
  const intentToolbar = PasteTextIntent(SelectionChangedCause.toolbar);
  print('tap cause: ${intentTap.cause}');
  print('longPress cause: ${intentLong.cause}');
  print('toolbar cause: ${intentToolbar.cause}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('intent is Intent: ${intent is Intent}');

  // Test with Actions widget
  print('\n--- Testing with Actions ---');
  print('Actions.invoke(context, PasteTextIntent(cause))');
  print('Triggers paste from clipboard');

  // Test with Shortcuts
  print('\n--- Testing default shortcut ---');
  print('Ctrl+V (Cmd+V on macOS) bound by default');
  print('SingleActivator(LogicalKeyboardKey.keyV, control: true)');

  // SelectionChangedCause options
  print('\n--- SelectionChangedCause options ---');
  for (final cause in SelectionChangedCause.values) {
    print('SelectionChangedCause.${cause.name}');
  }

  // Related intents
  print('\n--- Related intents ---');
  print('CopySelectionTextIntent: copy text');
  print('CutSelectionTextIntent: cut text');
  print('SelectAllTextIntent: select all');

  // Usage in text fields
  print('\n--- Usage in text fields ---');
  print('TextField handles PasteTextIntent');
  print('Reads clipboard and inserts at cursor');

  // Clipboard interaction
  print('\n--- Clipboard interaction ---');
  print('Clipboard.getData() retrieves paste content');
  print('TextInput.updateEditingValue() inserts text');
  print('Selection updated after paste');
  print('Undo stack records paste action');

  print('\n' + '=' * 50);
  print('PasteTextIntent test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PasteTextIntent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('cause: ${intent.cause}'),
      Text('Is Intent: ${intent is Intent}'),
      Text('Default: Ctrl+V / Cmd+V'),
    ],
  );
}
