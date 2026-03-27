// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionControls from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionControls test executing');
  print('=' * 50);

  // TextSelectionControls overview
  print('TextSelectionControls overview:');
  print('  - Abstract class');
  print('  - Builds selection handles and toolbar');
  print('  - Platform-specific implementations');
  print('  - Base for Material/Cupertino controls');

  // Abstract methods
  print('\nAbstract methods (required):');
  print('  - buildHandle(context, type, textLineHeight, [onTap])');
  print('  - getHandleAnchor(type, textLineHeight)');
  print('  - buildToolbar(...) [deprecated]');
  print('  - getHandleSize(textLineHeight)');

  // Handle types
  print('\nTextSelectionHandleType values:');
  for (final type in TextSelectionHandleType.values) {
    print('  - ${type.name}');
  }

  // Deprecated methods with defaults
  print('\nDeprecated methods (with defaults):');
  print('  - canCut(delegate): checks cutEnabled && !selection.isCollapsed');
  print('  - canCopy(delegate): checks copyEnabled && !selection.isCollapsed');
  print('  - canPaste(delegate): checks pasteEnabled');
  print('  - canSelectAll(delegate): checks selectAllEnabled');
  print('  - handleCut(delegate): calls delegate.cutSelection');
  print('  - handleCopy(delegate): calls delegate.copySelection');
  print('  - handlePaste(delegate): calls delegate.pasteText');
  print('  - handleSelectAll(delegate): calls delegate.selectAll');

  // Platform implementations
  print('\nPlatform implementations:');
  print('  - MaterialTextSelectionControls (Material Design)');
  print('  - CupertinoTextSelectionControls (iOS style)');
  print('  - DesktopTextSelectionControls');
  print('  - emptyTextSelectionControls (no controls)');

  // Migration to contextMenuBuilder
  print('\nMigration note:');
  print('  - buildToolbar is deprecated');
  print('  - Use contextMenuBuilder instead');
  print('  - See TextSelectionHandleControls mixin');

  // Constants available
  print('\nGlobal constants:');
  print('  - materialTextSelectionControls');
  print('  - cupertinoTextSelectionControls');
  print('  - emptyTextSelectionControls');

  // Handle appearance
  print('\nHandle appearance controlled by:');
  print('  - buildHandle: creates the visual widget');
  print('  - getHandleAnchor: alignment point on handle');
  print('  - getHandleSize: dimensions for layout');

  print('\n' + '=' * 50);
  print('TextSelectionControls test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextSelectionControls Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Abstract class'),
      Text('Purpose: Selection handles and toolbar'),
      Text('Deprecated: buildToolbar (use contextMenuBuilder)'),
    ],
  );
}
