// D4rt test script: Tests RawKeyboard from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyboard test executing');
  print('=' * 50);

  // RawKeyboard singleton - deprecated, use HardwareKeyboard
  print('\nRawKeyboard (deprecated):');
  print('Use HardwareKeyboard instead');
  print('RawKeyboard.instance provides singleton');

  // Access singleton
  final keyboard = RawKeyboard.instance;
  print('\nRawKeyboard.instance:');
  print('runtimeType: ${keyboard.runtimeType}');

  // Current state
  print('\nCurrent keyboard state:');
  print('keysPressed: ${keyboard.keysPressed}');

  // Modifiers
  print('\nModifier key queries:');
  print('- physicalKeysPressed: Physical keys held');
  print('- keysPressed: Logical keys held');

  // Event handling
  print('\nEvent handling:');
  print('addListener(callback) - Add key listener');
  print('removeListener(callback) - Remove listener');
  print('Callback receives RawKeyEvent');

  // RawKeyEvent types
  print('\nRawKeyEvent types:');
  print('- RawKeyDownEvent: Key pressed');
  print('- RawKeyUpEvent: Key released');

  // RawKeyEventData variants
  print('\nRawKeyEventData (platform-specific):');
  print('- RawKeyEventDataAndroid');
  print('- RawKeyEventDataIos');
  print('- RawKeyEventDataLinux');
  print('- RawKeyEventDataMacOs');
  print('- RawKeyEventDataWindows');
  print('- RawKeyEventDataWeb');
  print('- RawKeyEventDataFuchsia');

  // Migration to HardwareKeyboard
  print('\nMigration to HardwareKeyboard:');
  print('// Old (deprecated):');
  print('RawKeyboard.instance.addListener(handler);');
  print('// New (recommended):');
  print('HardwareKeyboard.instance.addHandler(handler);');

  // Key identification
  print('\nKey identification:');
  print('- physicalKey: Hardware position');
  print('- logicalKey: Key meaning');
  print('- character: Resulting character');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyboard (singleton service)');
  print('RawKeyEvent (abstract)');
  print('  \u251c\u2500 RawKeyDownEvent');
  print('  \u2514\u2500 RawKeyUpEvent');

  // Explain purpose
  print('\nRawKeyboard purpose (deprecated):');
  print('- Low-level keyboard access');
  print('- Lists currently pressed keys');
  print('- Platform-specific event data');
  print('- Use HardwareKeyboard instead');
  print('- Legacy keyboard handling');

  print('\n' + '=' * 50);
  print('RawKeyboard test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyboard Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('Use: HardwareKeyboard instead'),
      Text('keysPressed: ${keyboard.keysPressed.length}'),
      Text('Purpose: Low-level keyboard'),
    ],
  );
}
