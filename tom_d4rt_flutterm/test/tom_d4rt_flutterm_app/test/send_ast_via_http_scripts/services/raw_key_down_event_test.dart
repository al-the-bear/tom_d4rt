// ignore_for_file: avoid_print
// D4rt test script: Tests RawKeyDownEvent from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyDownEvent test executing');
  print('=' * 50);

  // RawKeyDownEvent - deprecated, use KeyDownEvent
  print('\nRawKeyDownEvent (deprecated):');
  print('Use KeyDownEvent instead');
  print('Part of deprecated RawKeyboard system');

  // Event structure
  print('\nRawKeyDownEvent structure:');
  print('- data: Platform-specific RawKeyEventData');
  print('- character: Generated character');
  print('- Extends RawKeyEvent');

  // Properties (inherited from RawKeyEvent)
  print('\nRawKeyEvent properties:');
  print('- physicalKey: Physical key location');
  print('- logicalKey: Key meaning');
  print('- character: Resulting character');
  print('- repeat: Whether this is repeat event');
  print('- isControlPressed: Ctrl held');
  print('- isShiftPressed: Shift held');
  print('- isAltPressed: Alt held');
  print('- isMetaPressed: Meta/Cmd held');

  // Platform data types
  print('\nPlatform-specific data:');
  print('- RawKeyEventDataAndroid');
  print('- RawKeyEventDataIos');
  print('- RawKeyEventDataMacOs');
  print('- RawKeyEventDataWindows');
  print('- RawKeyEventDataLinux');
  print('- RawKeyEventDataWeb');

  // Migration to KeyEvent
  print('\nMigration to KeyEvent:');
  print('// Deprecated:');
  print('if (event is RawKeyDownEvent) { ... }');
  print('// New:');
  print('if (event is KeyDownEvent) { ... }');

  // Usage pattern
  print('\nUsage in listener:');
  print('RawKeyboard.instance.addListener((event) {');
  print('  if (event is RawKeyDownEvent) {');
  print('    // Handle key down');
  print('  }');
  print('});');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEvent (abstract, deprecated)');
  print('  \u251c\u2500 RawKeyDownEvent');
  print('  \u2514\u2500 RawKeyUpEvent');

  // Explain purpose
  print('\nRawKeyDownEvent purpose (deprecated):');
  print('- Represents physical key press');
  print('- Contains platform-specific data');
  print('- Provides key identification');
  print('- Includes modifier key state');
  print('- Migrate to KeyDownEvent');

  print('\n' + '=' * 50);
  print('RawKeyDownEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyDownEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('Use: KeyDownEvent instead'),
      Text('Parent: RawKeyEvent'),
      Text('Purpose: Key press event'),
    ],
  );
}
