// ignore_for_file: avoid_print
// D4rt test script: Tests RawKeyEventDataFuchsia from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataFuchsia test executing');
  print('=' * 50);

  // Create RawKeyEventDataFuchsia
  final data = RawKeyEventDataFuchsia(
    hidUsage: 0x04, // USB HID Usage for 'A'
    codePoint: 97, // 'a'
    modifiers: 0,
  );
  print('\nRawKeyEventDataFuchsia created (deprecated):');
  print('runtimeType: ${data.runtimeType}');

  // Fuchsia-specific properties
  print('\nFuchsia-specific properties:');
  print('hidUsage: ${data.hidUsage}');
  print('codePoint: ${data.codePoint}');
  print('modifiers: ${data.modifiers}');

  // HID usage pages
  print('\nUSB HID usage (keyboard page 0x07):');
  print('Usage 0x04 = A');
  print('Usage 0x05 = B');
  print('Usage 0x28 = Enter');
  print('Usage 0x2C = Space');
  print('Usage 0xE1 = Left Shift');
  print('Usage 0xE0 = Left Control');

  // Modifier flags (Fuchsia)
  print('\nFuchsia modifier flags:');
  print('SHIFT = 1');
  print('LEFT_SHIFT = 2');
  print('RIGHT_SHIFT = 4');
  print('CTRL = 8');
  print('ALT = 64');
  print('META = 512');

  // Inherited properties
  print('\nInherited (from RawKeyEventData):');
  print('physicalKey: ${data.physicalKey}');
  print('logicalKey: ${data.logicalKey}');
  print('isControlPressed: ${data.isControlPressed}');
  print('isShiftPressed: ${data.isShiftPressed}');
  print('isAltPressed: ${data.isAltPressed}');

  // Fuchsia OS
  print('\nFuchsia OS:');
  print('- Google\'s next-gen operating system');
  print('- Zircon microkernel');
  print('- Uses USB HID standard for keys');
  print('- Cross-device OS platform');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u2514\u2500 RawKeyEventDataFuchsia');

  // Explain purpose
  print('\nRawKeyEventDataFuchsia purpose (deprecated):');
  print('- Fuchsia-specific key event data');
  print('- Uses USB HID usage codes');
  print('- Contains Fuchsia input info');
  print('- Used with RawKeyboard (deprecated)');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventDataFuchsia test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataFuchsia Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('hidUsage: ${data.hidUsage}'),
      Text('codePoint: ${data.codePoint}'),
      Text('Purpose: Fuchsia key data'),
    ],
  );
}
