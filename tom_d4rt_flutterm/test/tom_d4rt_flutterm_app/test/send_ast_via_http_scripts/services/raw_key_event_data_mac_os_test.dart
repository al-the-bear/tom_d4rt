// ignore_for_file: avoid_print
// D4rt test script: Tests RawKeyEventDataMacOs from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataMacOs test executing');

  // RawKeyEventData is deprecated - explain migration
  print('RawKeyEventDataMacOs is DEPRECATED');
  print('Part of old RawKeyEvent system');
  print('Use new KeyEvent API instead');

  // Old vs new
  print('\nOld API (deprecated):');
  print('- RawKeyEvent');
  print('- RawKeyEventDataMacOs');
  print('- RawKeyEventDataLinux');
  print('- RawKeyEventDataWindows');
  print('- RawKeyEventDataAndroid');
  print('- RawKeyEventDataIos');
  print('- RawKeyEventDataWeb');

  print('\nNew API (recommended):');
  print('- KeyEvent');
  print('- KeyDownEvent');
  print('- KeyUpEvent');
  print('- KeyRepeatEvent');
  print('- HardwareKeyboard');

  // Migration
  print('\nMigration guide:');
  print('Old: RawKeyboardListener');
  print('New: KeyboardListener or Focus.onKeyEvent');
  print('');
  print('Old: RawKeyboard.instance');
  print('New: HardwareKeyboard.instance');

  // macOS specific
  print('\nmacOS specific info:');
  print('- charactersIgnoringModifiers');
  print('- keyCode: virtual key code');
  print('- modifiers: modifier flags');

  // Focus example
  print('\nNew API example:');
  print('Focus(');
  print('  onKeyEvent: (node, event) {');
  print('    // platform-agnostic');
  print('    return KeyEventResult.ignored;');
  print('  },');
  print('  child: widget,');
  print(')');

  print('\nRawKeyEventDataMacOs test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataMacOs Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('DEPRECATED - macOS key data'),
      Text('Old: RawKeyEvent system'),
      Text('New: KeyEvent system'),
      Text('Migration: Focus.onKeyEvent'),
    ],
  );
}
