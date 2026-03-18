// D4rt test script: Tests GtkKeyHelper from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GtkKeyHelper test executing');

  // GtkKeyHelper is Linux-specific
  print('GtkKeyHelper: Linux GTK key handling');
  print('Internal helper for keyboard events');

  // Purpose
  print('\nGtkKeyHelper purpose:');
  print('- Maps GTK key codes to Flutter keys');
  print('- Handles Linux keyboard specifics');
  print('- Used internally by Flutter engine');
  print('- Part of KeyEventManager');

  // Key mapping
  print('\nKey mapping responsibilities:');
  print('- GTK keyval -> LogicalKeyboardKey');
  print('- GTK hardware keycode -> PhysicalKeyboardKey');
  print('- Modifier state translation');

  // Linux keyboard stack
  print('\nLinux keyboard stack:');
  print('1. GTK receives key from X11/Wayland');
  print('2. GtkKeyHelper translates');
  print('3. KeyEvent created');
  print('4. Dispatched to Flutter widgets');

  // Related helpers
  print('\nRelated platform helpers:');
  print('- GtkKeyHelper: Linux GTK');
  print('- GlfwKeyHelper: Linux GLFW');
  print('- KeyHelper (macOS, Windows)');
  print('- All internal implementation');

  // Developer note
  print('\nDeveloper note:');
  print('- Not typically used directly');
  print('- Use KeyEvent API instead');
  print('- Platform-agnostic code preferred');

  // Example
  print('\nPreferred approach:');
  print('Focus(');
  print('  onKeyEvent: (node, event) {');
  print('    // Works on all platforms');
  print('    return KeyEventResult.ignored;');
  print('  },');
  print(')');

  print('\nGtkKeyHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'GtkKeyHelper Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Linux GTK key translation'),
      Text('Platform: Linux only'),
      Text('Internal: Flutter engine'),
      Text('Use: KeyEvent API instead'),
    ],
  );
}
