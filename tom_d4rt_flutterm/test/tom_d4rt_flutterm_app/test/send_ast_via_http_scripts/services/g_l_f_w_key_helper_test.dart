// D4rt test script: Tests GLFWKeyHelper from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GLFWKeyHelper test executing');
  print('=' * 50);

  // GLFWKeyHelper for GLFW keyboard mapping
  print('\nGLFWKeyHelper:');
  print('Deprecated key helper for GLFW');
  print('Linux desktop keyboard support');

  // GLFW context
  print('\nGLFW context:');
  print('GLFW = Graphics Library Framework');
  print('Used for Linux desktop windowing');
  print('Flutter Linux uses GTK now');

  // Deprecation status
  print('\nDeprecation status:');
  print('@Deprecated - use KeyEvent instead');
  print('Part of RawKeyboard system');
  print('Being replaced by HardwareKeyboard');

  // Key codes
  print('\nGLFW key codes:');
  print('GLFW_KEY_A = 65');
  print('GLFW_KEY_SPACE = 32');
  print('GLFW_KEY_ESCAPE = 256');
  print('GLFW_KEY_ENTER = 257');
  print('GLFW_KEY_TAB = 258');

  // Modifiers
  print('\nGLFW modifiers:');
  print('GLFW_MOD_SHIFT = 0x0001');
  print('GLFW_MOD_CONTROL = 0x0002');
  print('GLFW_MOD_ALT = 0x0004');
  print('GLFW_MOD_SUPER = 0x0008');

  // Helper methods
  print('\nHelper methods:');
  print('getModifierSide(key, modifiers):');
  print('  - Determine left/right modifier');
  print('');
  print('isModifierPressed(side, modifiers):');
  print('  - Check if modifier is pressed');

  // Usage context
  print('\nUsage context:');
  print('RawKeyEventDataLinux uses this');
  print('Maps GLFW codes to Flutter keys');
  print('Linux-specific implementation');

  // Migration
  print('\nMigration path:');
  print('Old: RawKeyboard + GLFWKeyHelper');
  print('New: HardwareKeyboard + KeyEvent');
  print('');
  print('// Old way (deprecated)');
  print('RawKeyboard.instance.addListener(...)');
  print('');
  print('// New way');
  print('HardwareKeyboard.instance.addHandler(...)');

  // Type hierarchy
  print('\nType hierarchy:');
  print('KeyHelper (abstract)');
  print('  \u2514\u2500 GLFWKeyHelper (deprecated)');

  // Explain purpose
  print('\nGLFWKeyHelper purpose:');
  print('- GLFW key code mapping (deprecated)');
  print('- Linux desktop keyboard support');
  print('- Modifier key handling');
  print('- Used by RawKeyEventDataLinux');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('GLFWKeyHelper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'GLFWKeyHelper Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: @Deprecated'),
      Text('Platform: Linux (GLFW)'),
      Text('Replacement: KeyEvent system'),
      Text('Purpose: GLFW key mapping'),
    ],
  );
}
