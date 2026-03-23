// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyHelper from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyHelper test executing');
  print('=' * 50);

  // Create KeyHelper
  final gtkHelper = KeyHelper('gtk');
  print('\nKeyHelper created:');
  print('runtimeType: ${gtkHelper.runtimeType}');
  print('toolkit: gtk');

  // Toolkit variants
  print('\nKeyHelper toolkit variants:');
  print('- gtk: GTK toolkit (GNOME)');
  print('- glfw: GLFW library');
  print('Used on Linux desktop');

  // KeyHelper methods
  print('\nKeyHelper methods:');
  print('getModifierSide(modifierMask):');
  print('  - Returns left, right, or both');
  print('  - For modifier keys (Shift, Ctrl, etc.)');
  print('');
  print('debugToolkit: String getter');

  // Usage in RawKeyEventDataLinux
  print('\nUsage in RawKeyEventDataLinux:');
  print('final data = RawKeyEventDataLinux(');
  print('  keyHelper: KeyHelper("gtk"),');
  print('  unicodeScalarValues: 97,');
  print('  keyCode: 38,');
  print('  scanCode: 38,');
  print('  modifiers: 0,');
  print('  isDown: true,');
  print('  specifiedLogicalKey: null,');
  print(');');

  // Modifier detection
  print('\nModifier detection:');
  print('- Determines which Shift/Ctrl/Alt');
  print('- Left vs Right modifier');
  print('- Uses X11/GDK modifier masks');

  // Linux keyboard handling
  print('\nLinux keyboard handling:');
  print('- GDK key event processing');
  print('- X11 key symbol mapping');
  print('- evdev scan codes');

  // GLFWKeyHelper
  print('\nGLFWKeyHelper (glfw):');
  print('- Used with GLFW-based apps');
  print('- Different modifier mask handling');
  print('- Used by Flutter Linux (GLFW backend)');

  // Type hierarchy
  print('\nType hierarchy:');
  print('KeyHelper (base class)');
  print('  \u251c\u2500 GtkKeyHelper (toolkit: gtk)');
  print('  \u2514\u2500 GLFWKeyHelper (toolkit: glfw)');

  // Explain purpose
  print('\nKeyHelper purpose:');
  print('- Linux keyboard toolkit abstraction');
  print('- Maps toolkit-specific key codes');
  print('- Detects modifier key sides');
  print('- Used with RawKeyEventDataLinux');
  print('- Supports GTK and GLFW');

  print('\n' + '=' * 50);
  print('KeyHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyHelper Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${gtkHelper.runtimeType}'),
      Text('Toolkits: gtk, glfw'),
      Text('Platform: Linux'),
      Text('Purpose: Keyboard toolkit helper'),
    ],
  );
}
