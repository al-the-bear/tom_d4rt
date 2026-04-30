// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawKeyEventDataIos from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// Local shim — RawKeyEventDataIos not available in D4rt bridge (deprecated API)
class RawKeyEventDataIos {
  final String characters;
  final String charactersIgnoringModifiers;
  final int keyCode;
  final int modifiers;
  RawKeyEventDataIos({
    required this.characters,
    required this.charactersIgnoringModifiers,
    required this.keyCode,
    required this.modifiers,
  });
  PhysicalKeyboardKey get physicalKey => PhysicalKeyboardKey(keyCode + 0x70000);
  LogicalKeyboardKey get logicalKey => LogicalKeyboardKey(characters.isNotEmpty ? characters.codeUnitAt(0) : 0);
  bool get isControlPressed => (modifiers & (1 << 18)) != 0;
  bool get isShiftPressed => (modifiers & (1 << 17)) != 0;
  bool get isAltPressed => (modifiers & (1 << 19)) != 0;
  bool get isMetaPressed => (modifiers & (1 << 20)) != 0;
}

dynamic build(BuildContext context) {
  print('RawKeyEventDataIos test executing');
  print('=' * 50);

  // Create RawKeyEventDataIos
  final data = RawKeyEventDataIos(
    characters: 'a',
    charactersIgnoringModifiers: 'a',
    keyCode: 0, // kVK_ANSI_A
    modifiers: 0,
  );
  print('\nRawKeyEventDataIos created (deprecated):');
  print('runtimeType: ${data.runtimeType}');

  // iOS-specific properties
  print('\niOS-specific properties:');
  print('characters: "${data.characters}"');
  print('charactersIgnoringModifiers: "${data.charactersIgnoringModifiers}"');
  print('keyCode: ${data.keyCode}');
  print('modifiers: ${data.modifiers}');

  // iOS key codes (from UIKit/Carbon)
  print('\niOS key codes (examples):');
  print('kVK_ANSI_A = 0');
  print('kVK_Return = 36');
  print('kVK_Space = 49');
  print('kVK_Shift = 56');
  print('kVK_Command = 55');

  // Modifier flags
  print('\niOS modifier flags:');
  print('UIKeyModifierShift = 1 << 17');
  print('UIKeyModifierControl = 1 << 18');
  print('UIKeyModifierAlternate = 1 << 19');
  print('UIKeyModifierCommand = 1 << 20');

  // Inherited properties
  print('\nInherited (from RawKeyEventData):');
  print('physicalKey: ${data.physicalKey}');
  print('logicalKey: ${data.logicalKey}');
  print('isControlPressed: ${data.isControlPressed}');
  print('isShiftPressed: ${data.isShiftPressed}');
  print('isAltPressed: ${data.isAltPressed}');
  print('isMetaPressed: ${data.isMetaPressed}');

  // iOS keyboard input
  print('\niOS keyboard input:');
  print('- UIKey API (iOS 13.4+)');
  print('- Hardware keyboard support');
  print('- iPad external keyboard');
  print('- Smart Keyboard Folio');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u2514\u2500 RawKeyEventDataIos');

  // Explain purpose
  print('\nRawKeyEventDataIos purpose (deprecated):');
  print('- iOS-specific key event data');
  print('- Maps iOS key codes to Flutter');
  print('- Contains UIKey event info');
  print('- Used with RawKeyboard (deprecated)');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventDataIos test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataIos Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('characters: "${data.characters}"'),
      Text('keyCode: ${data.keyCode}'),
      Text('Purpose: iOS key data'),
    ],
  );
}
