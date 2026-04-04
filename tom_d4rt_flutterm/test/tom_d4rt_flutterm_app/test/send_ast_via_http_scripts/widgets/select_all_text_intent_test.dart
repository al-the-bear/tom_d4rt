// ignore_for_file: avoid_print, always_declare_return_types
import 'package:flutter/widgets.dart';

/// Print-only test for SelectAllTextIntent.
///
/// SelectAllTextIntent is an Intent to select all text in a text field.
/// It carries a cause that indicates what triggered the selection.
///
/// Key properties:
/// - cause: The SelectionChangedCause that triggered the intent
///
/// Common triggers:
/// - Keyboard shortcut (Ctrl/Cmd+A)
/// - Menu selection
dynamic build(BuildContext context) {
  print('=== SelectAllTextIntent Test ===');
  print('');
  
  // Class details
  print('SelectAllTextIntent:');
  print('  Extends: Intent');
  print('  Package: flutter/src/widgets/text_editing_intents.dart');
  print('  Purpose: Select all text in field');
  print('');
  
  // Constructor
  print('Constructor:');
  print('  const SelectAllTextIntent(SelectionChangedCause cause)');
  print('');
  
  // Cause property
  print('cause Property (SelectionChangedCause):');
  print('  - SelectionChangedCause.tap');
  print('  - SelectionChangedCause.doubleTap');
  print('  - SelectionChangedCause.longPress');
  print('  - SelectionChangedCause.forcePress');
  print('  - SelectionChangedCause.keyboard');
  print('  - SelectionChangedCause.toolbar');
  print('  - SelectionChangedCause.drag');
  print('  - SelectionChangedCause.scribble');
  print('');
  
  // Keyboard shortcuts
  print('Default Keyboard Shortcuts:');
  print('  Windows/Linux: Ctrl+A');
  print('  macOS: Cmd+A');
  print('  Cause: SelectionChangedCause.keyboard');
  print('');
  
  // Action handling
  print('Action Handling:');
  print('  - Handled by _SelectAllAction in EditableText');
  print('  - Selects text from start to end');
  print('  - Updates selection state');
  print('  - Triggers onSelectionChanged callback');
  print('');
  
  // Usage in custom widget
  print('Custom Usage:');
  print('  Actions(');
  print('    actions: {');
  print('      SelectAllTextIntent: CallbackAction(');
  print('        onInvoke: (intent) => selectAllText(),');
  print('      ),');
  print('    },');
  print('    child: Shortcuts(');
  print('      shortcuts: {');
  print('        SingleActivator(');
  print('          LogicalKeyboardKey.keyA,');
  print('          control: true,');
  print('        ): const SelectAllTextIntent(');
  print('          SelectionChangedCause.keyboard,');
  print('        ),');
  print('      },');
  print('      child: ...,');
  print('    ),');
  print('  )');
  print('');
  
  // Related intents
  print('Related Text Editing Intents:');
  print('  - CopySelectionTextIntent: Copy selected text');
  print('  - PasteTextIntent: Paste from clipboard');
  print('  - DeleteCharacterIntent: Delete characters');
  print('');
  
  print('Test completed.');
  return const SizedBox.shrink();
}
