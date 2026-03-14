// D4rt test script: Tests KeyEventManager from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyEventManager test executing');
  print('=' * 50);

  // KeyEventManager - internal key event routing
  print('\nKeyEventManager:');
  print('Internal class for managing key event routing');
  print('Part of keyboard event dispatch system');

  // Key event flow
  print('\nKey event flow:');
  print('1. Platform sends key event');
  print('2. KeyEventManager receives event');
  print('3. HardwareKeyboard state updated');
  print('4. Events dispatched to handlers');
  print('5. Focus system routes to widgets');

  // HardwareKeyboard relationship
  print('\nHardwareKeyboard relationship:');
  print('HardwareKeyboard.instance');
  print('  \u251c\u2500 .addHandler(handler)');
  print('  \u251c\u2500 .removeHandler(handler)');
  print('  \u2514\u2500 Uses KeyEventManager internally');

  // Event types handled
  print('\nEvent types handled:');
  print('- KeyDownEvent: Key pressed');
  print('- KeyUpEvent: Key released');
  print('- KeyRepeatEvent: Key held down');

  // Handler registration
  print('\nHandler registration:');
  print('bool keyHandler(KeyEvent event) {');
  print('  if (event is KeyDownEvent) {');
  print('    // Handle key down');
  print('    return true; // Consumed');
  print('  }');
  print('  return false; // Not consumed');
  print('}');
  print('HardwareKeyboard.instance.addHandler(keyHandler);');

  // Focus-based routing
  print('\nFocus-based routing:');
  print('- FocusNode.onKeyEvent');
  print('- Focus widget KeyboardListener');
  print('- Shortcuts widget');
  print('- Events bubble up focus tree');

  // Platform channel
  print('\nPlatform channel:');
  print('SystemChannels.keyEvent');
  print('Receives raw platform key events');

  // Thread safety
  print('\nThread safety:');
  print('- Events processed on UI thread');
  print('- Synchronous dispatch');
  print('- Handler returns bool (consumed)');

  // Type hierarchy
  print('\nType hierarchy:');
  print('KeyEventManager (internal)');
  print('  \u2514\u2500 Used by HardwareKeyboard');

  // Explain purpose
  print('\nKeyEventManager purpose:');
  print('- Routes key events internally');
  print('- Updates HardwareKeyboard state');
  print('- Dispatches to registered handlers');
  print('- Part of new KeyEvent system');
  print('- Replaces deprecated RawKeyboard');

  print('\n' + '=' * 50);
  print('KeyEventManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyEventManager Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: internal event router'),
      Text('Events: Down, Up, Repeat'),
      Text('Access: HardwareKeyboard'),
      Text('Purpose: Key event dispatch'),
    ],
  );
}
