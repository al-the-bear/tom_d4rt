// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawKeyEventDataLinux from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataLinux test executing');
  print('=' * 50);

  // Create RawKeyEventDataLinux (using GTK toolkit)
  final data = RawKeyEventDataLinux(
    keyHelper: KeyHelper('gtk'),
    unicodeScalarValues: 97, // 'a'
    keyCode: 38, // KEY_A on QWERTY
    scanCode: 38,
    modifiers: 0,
    isDown: true,
    specifiedLogicalKey: null,
  );
  print('\nRawKeyEventDataLinux created (deprecated):');
  print('runtimeType: ${data.runtimeType}');

  // Linux-specific properties
  print('\nLinux-specific properties:');
  print('unicodeScalarValues: ${data.unicodeScalarValues}');
  print('keyCode: ${data.keyCode}');
  print('scanCode: ${data.scanCode}');
  print('modifiers: ${data.modifiers}');
  print('isDown: ${data.isDown}');

  // Linux toolkit variants
  print('\nLinux toolkits:');
  print('- GTK (GNOME)');
  print('- GLFW');
  print('Shared key code space');

  // Key codes (X11/evdev)
  print('\nLinux key codes (evdev):');
  print('KEY_A = 38');
  print('KEY_ENTER = 36');
  print('KEY_SPACE = 65');
  print('KEY_LEFTSHIFT = 50');
  print('KEY_LEFTCTRL = 37');

  // Modifier flags
  print('\nLinux modifier flags (GDK):');
  print('GDK_SHIFT_MASK = 1');
  print('GDK_LOCK_MASK = 2');
  print('GDK_CONTROL_MASK = 4');
  print('GDK_MOD1_MASK (Alt) = 8');
  print('GDK_SUPER_MASK = 67108864');

  // Inherited properties
  print('\nInherited (from RawKeyEventData):');
  print('physicalKey: ${data.physicalKey}');
  print('logicalKey: ${data.logicalKey}');
  print('isControlPressed: ${data.isControlPressed}');
  print('isShiftPressed: ${data.isShiftPressed}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u2514\u2500 RawKeyEventDataLinux');

  // Explain purpose
  print('\nRawKeyEventDataLinux purpose (deprecated):');
  print('- Linux-specific key event data');
  print('- Maps X11/evdev codes to Flutter');
  print('- Supports GTK and GLFW');
  print('- Used with RawKeyboard (deprecated)');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventDataLinux test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataLinux Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('keyCode: ${data.keyCode}'),
      Text('scanCode: ${data.scanCode}'),
      Text('Purpose: Linux key data'),
    ],
  );
}
