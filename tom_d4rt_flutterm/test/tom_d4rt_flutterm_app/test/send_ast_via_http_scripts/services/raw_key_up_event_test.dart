// D4rt test script: Tests RawKeyUpEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyUpEvent test executing');
  print('=' * 50);

  // RawKeyUpEvent - deprecated, use KeyUpEvent
  print('\nRawKeyUpEvent (deprecated):');
  print('Use KeyUpEvent instead');
  print('Part of deprecated RawKeyboard system');

  // Event structure
  print('\nRawKeyUpEvent structure:');
  print('- data: Platform-specific RawKeyEventData');
  print('- No character property (key release)');
  print('- Extends RawKeyEvent');

  // Properties (inherited from RawKeyEvent)
  print('\nRawKeyEvent properties:');
  print('- physicalKey: Physical key location');
  print('- logicalKey: Key meaning');
  print('- repeat: Always false for up events');
  print('- isControlPressed: Ctrl held');
  print('- isShiftPressed: Shift held');
  print('- isAltPressed: Alt held');
  print('- isMetaPressed: Meta/Cmd held');

  // Key up vs key down
  print('\nKey up vs key down:');
  print('RawKeyDownEvent: Key pressed');
  print('RawKeyUpEvent: Key released');
  print('Both contain same key identification');

  // Platform considerations
  print('\nPlatform considerations:');
  print('- Some platforms may not guarantee up events');
  print('- Focus loss may skip up events');
  print('- Use keysPressed for current state');

  // Migration to KeyUpEvent
  print('\nMigration to KeyUpEvent:');
  print('// Deprecated:');
  print('if (event is RawKeyUpEvent) { ... }');
  print('// New:');
  print('if (event is KeyUpEvent) { ... }');

  // Usage pattern
  print('\nUsage in listener:');
  print('RawKeyboard.instance.addListener((event) {');
  print('  if (event is RawKeyUpEvent) {');
  print('    final key = event.logicalKey;');
  print('    // Handle key release');
  print('  }');
  print('});');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEvent (abstract, deprecated)');
  print('  \u251c\u2500 RawKeyDownEvent');
  print('  \u2514\u2500 RawKeyUpEvent');

  // Explain purpose
  print('\nRawKeyUpEvent purpose (deprecated):');
  print('- Represents physical key release');
  print('- Contains platform-specific data');
  print('- Matches earlier RawKeyDownEvent');
  print('- Used for toggle/hold detection');
  print('- Migrate to KeyUpEvent');

  print('\n' + '=' * 50);
  print('RawKeyUpEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyUpEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('Use: KeyUpEvent instead'),
      Text('Parent: RawKeyEvent'),
      Text('Purpose: Key release event'),
    ],
  );
}
