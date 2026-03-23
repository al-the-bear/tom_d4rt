// ignore_for_file: avoid_print
// D4rt test script: Tests RawKeyEventDataWindows from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataWindows test executing');
  print('=' * 50);

  // Create RawKeyEventDataWindows
  final data = RawKeyEventDataWindows(
    keyCode: 65, // VK_A
    scanCode: 30,
    characterCodePoint: 97, // 'a'
    modifiers: 0,
  );
  print('\nRawKeyEventDataWindows created (deprecated):');
  print('runtimeType: ${data.runtimeType}');

  // Windows-specific properties
  print('\nWindows-specific properties:');
  print('keyCode: ${data.keyCode}');
  print('scanCode: ${data.scanCode}');
  print('characterCodePoint: ${data.characterCodePoint}');
  print('modifiers: ${data.modifiers}');

  // Virtual key codes (WinUser.h)
  print('\nWindows virtual key codes:');
  print('VK_A = 65');
  print('VK_RETURN = 13');
  print('VK_SPACE = 32');
  print('VK_SHIFT = 16');
  print('VK_CONTROL = 17');
  print('VK_MENU (Alt) = 18');
  print('VK_LWIN = 91');

  // Modifier flags
  print('\nWindows modifier flags:');
  print('MOD_SHIFT = 0x04');
  print('MOD_CONTROL = 0x08');
  print('MOD_ALT = 0x10');
  print('MOD_WIN = 0x20');

  // Scan codes vs virtual keys
  print('\nScan codes vs virtual keys:');
  print('scanCode: Hardware key position');
  print('keyCode: Virtual key (layout-dependent)');
  print('Example: QWERTY A vs AZERTY Q');

  // Inherited properties
  print('\nInherited (from RawKeyEventData):');
  print('physicalKey: ${data.physicalKey}');
  print('logicalKey: ${data.logicalKey}');
  print('isControlPressed: ${data.isControlPressed}');
  print('isShiftPressed: ${data.isShiftPressed}');
  print('isAltPressed: ${data.isAltPressed}');

  // Windows keyboard handling
  print('\nWindows keyboard handling:');
  print('- WM_KEYDOWN / WM_KEYUP messages');
  print('- GetKeyState for modifiers');
  print('- ToUnicode for character mapping');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u2514\u2500 RawKeyEventDataWindows');

  // Explain purpose
  print('\nRawKeyEventDataWindows purpose (deprecated):');
  print('- Windows-specific key event data');
  print('- Maps Windows VK codes to Flutter');
  print('- Contains WinAPI key info');
  print('- Used with RawKeyboard (deprecated)');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventDataWindows test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataWindows Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('keyCode (VK): ${data.keyCode}'),
      Text('scanCode: ${data.scanCode}'),
      Text('Purpose: Windows key data'),
    ],
  );
}
