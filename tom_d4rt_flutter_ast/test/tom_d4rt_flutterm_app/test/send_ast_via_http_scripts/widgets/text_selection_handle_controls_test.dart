// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionHandleControls from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionHandleControls test executing');
  print('=' * 50);

  // Overview
  print('TextSelectionHandleControls overview:');
  print('  - Mixin on TextSelectionControls');
  print('  - Disables built-in toolbar');
  print('  - Leaves toolbar to contextMenuBuilder');
  print('  - Handle-only version of controls');

  // Mixin declaration
  print('\nMixin declaration:');
  print('  mixin TextSelectionHandleControls on TextSelectionControls');

  // Methods overridden (disabled)
  print('\nMethods overridden (disabled):');
  print('  - buildToolbar: returns SizedBox.shrink()');
  print('  - canCut: returns false');
  print('  - canCopy: returns false');
  print('  - canPaste: returns false');
  print('  - canSelectAll: returns false');
  print('  - handleCut: no-op');
  print('  - handleCopy: no-op');
  print('  - handlePaste: no-op');
  print('  - handleSelectAll: no-op');

  // Purpose
  print('\nPurpose:');
  print('  - Supports contextMenuBuilder migration');
  print('  - Keeps handles, removes toolbar');
  print('  - Used when contextMenuBuilder handles context menu');

  // Usage pattern
  print('\nUsage pattern:');
  print('  class MaterialTextSelectionHandleControls');
  print('      extends MaterialTextSelectionControls');
  print('      with TextSelectionHandleControls {}');

  // Available implementations
  print('\nAvailable implementations using this mixin:');
  print('  - MaterialTextSelectionHandleControls');
  print('  - CupertinoTextSelectionHandleControls');
  print('  - DesktopTextSelectionHandleControls');

  // Constants using this mixin
  print('\nGlobal constants:');
  print('  - materialTextSelectionHandleControls');
  print('  - cupertinoTextSelectionHandleControls');
  print('  - desktopTextSelectionHandleControls');

  // Why this mixin exists
  print('\nWhy this mixin:');
  print('  - buildToolbar is deprecated');
  print('  - New approach: contextMenuBuilder');
  print('  - Mixin provides clean separation');
  print('  - Handles stay, toolbar customized separately');

  // Deprecation note
  print('\nDeprecation note:');
  print('  - Will be deprecated when buildToolbar removed');
  print('  - Users migrate to TextSelectionControls.buildHandle');
  print('  - Part of Flutter 3.3+ context menu refactor');

  // Check runtime behavior
  print('\nRuntime behavior verification:');
  final controls = materialTextSelectionHandleControls;
  print('  materialTextSelectionHandleControls runtimeType: ${controls.runtimeType}');

  print('\n' + '=' * 50);
  print('TextSelectionHandleControls test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextSelectionHandleControls Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin on TextSelectionControls'),
      Text('Purpose: Handle-only (no toolbar)'),
      Text('Use with: contextMenuBuilder'),
    ],
  );
}
