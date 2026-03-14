// D4rt test script: Tests RawKeyEventDataAndroid from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataAndroid test executing');
  print('=' * 50);

  // Create RawKeyEventDataAndroid
  final data = RawKeyEventDataAndroid(
    flags: 0,
    codePoint: 65, // 'A'
    keyCode: 29, // KEYCODE_A
    scanCode: 30,
    metaState: 0,
  );
  print('\nRawKeyEventDataAndroid created (deprecated):');
  print('runtimeType: ${data.runtimeType}');

  // Android-specific properties
  print('\nAndroid-specific properties:');
  print('flags: ${data.flags}');
  print('codePoint: ${data.codePoint}');
  print('keyCode: ${data.keyCode}');
  print('scanCode: ${data.scanCode}');
  print('metaState: ${data.metaState}');

  // Key code constants (some examples)
  print('\nAndroid key codes (examples):');
  print('KEYCODE_A = 29');
  print('KEYCODE_ENTER = 66');
  print('KEYCODE_SPACE = 62');
  print('KEYCODE_SHIFT_LEFT = 59');
  print('KEYCODE_CTRL_LEFT = 113');

  // Meta state flags
  print('\nMeta state flags:');
  print('META_SHIFT_ON = 1');
  print('META_ALT_ON = 2');
  print('META_CTRL_ON = 4096');
  print('META_META_ON = 65536');

  // Inherited properties
  print('\nInherited (from RawKeyEventData):');
  print('physicalKey: ${data.physicalKey}');
  print('logicalKey: ${data.logicalKey}');
  print('isControlPressed: ${data.isControlPressed}');
  print('isShiftPressed: ${data.isShiftPressed}');
  print('isAltPressed: ${data.isAltPressed}');
  print('isMetaPressed: ${data.isMetaPressed}');

  // Device type
  print('\nAndroid event source:');
  print('- SOURCE_KEYBOARD = 257');
  print('- SOURCE_DPAD = 513');
  print('- SOURCE_GAMEPAD = 1025');
  print('Supported since Android 4.0');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u2514\u2500 RawKeyEventDataAndroid');

  // Explain purpose
  print('\nRawKeyEventDataAndroid purpose (deprecated):');
  print('- Android-specific key event data');
  print('- Maps Android key codes to Flutter');
  print('- Contains raw Android event info');
  print('- Used with RawKeyboard (deprecated)');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventDataAndroid test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataAndroid Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('keyCode: ${data.keyCode}'),
      Text('scanCode: ${data.scanCode}'),
      Text('Purpose: Android key data'),
    ],
  );
}
