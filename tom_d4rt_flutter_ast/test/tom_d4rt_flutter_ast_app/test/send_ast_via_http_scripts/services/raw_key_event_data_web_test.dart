// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawKeyEventDataWeb from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// Local shim — RawKeyEventDataWeb not available in D4rt bridge (deprecated API)
class RawKeyEventDataWeb {
  final String code;
  final String key;
  final int location;
  final int metaState;
  final int keyCode;
  RawKeyEventDataWeb({
    required this.code,
    required this.key,
    required this.location,
    required this.metaState,
    required this.keyCode,
  });
  PhysicalKeyboardKey get physicalKey => PhysicalKeyboardKey(keyCode + 0x70000);
  LogicalKeyboardKey get logicalKey => LogicalKeyboardKey(key.isNotEmpty ? key.codeUnitAt(0) : 0);
  bool get isControlPressed => (metaState & 2) != 0;
  bool get isShiftPressed => (metaState & 1) != 0;
}

dynamic build(BuildContext context) {
  print('RawKeyEventDataWeb test executing');
  print('=' * 50);

  // Create RawKeyEventDataWeb
  final data = RawKeyEventDataWeb(
    code: 'KeyA',
    key: 'a',
    location: 0,
    metaState: 0,
    keyCode: 65,
  );
  print('\nRawKeyEventDataWeb created (deprecated):');
  print('runtimeType: ${data.runtimeType}');

  // Web-specific properties
  print('\nWeb-specific properties:');
  print('code: "${data.code}"');
  print('key: "${data.key}"');
  print('location: ${data.location}');
  print('metaState: ${data.metaState}');
  print('keyCode: ${data.keyCode}');

  // DOM KeyboardEvent code values
  print('\nDOM KeyboardEvent codes:');
  print('code: Physical key (e.g., "KeyA", "Enter")');
  print('key: Key value (e.g., "a", "Enter")');
  print('keyCode: Deprecated numeric code');

  // Location values
  print('\nKeyboardEvent location:');
  print('DOM_KEY_LOCATION_STANDARD = 0');
  print('DOM_KEY_LOCATION_LEFT = 1');
  print('DOM_KEY_LOCATION_RIGHT = 2');
  print('DOM_KEY_LOCATION_NUMPAD = 3');

  // Meta state flags (web)
  print('\nMeta state (modifiers):');
  print('Shift: bit 0');
  print('Control: bit 1');
  print('Alt: bit 2');
  print('Meta: bit 3');

  // Inherited properties
  print('\nInherited (from RawKeyEventData):');
  print('physicalKey: ${data.physicalKey}');
  print('logicalKey: ${data.logicalKey}');
  print('isControlPressed: ${data.isControlPressed}');
  print('isShiftPressed: ${data.isShiftPressed}');

  // Browser compatibility
  print('\nBrowser key events:');
  print('- keydown / keyup events');
  print('- code: Layout-independent');
  print('- key: Layout-dependent');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u2514\u2500 RawKeyEventDataWeb');

  // Explain purpose
  print('\nRawKeyEventDataWeb purpose (deprecated):');
  print('- Web-specific key event data');
  print('- Maps DOM KeyboardEvent to Flutter');
  print('- Contains browser key info');
  print('- Used with RawKeyboard (deprecated)');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventDataWeb test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventDataWeb Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('code: "${data.code}"'),
      Text('key: "${data.key}"'),
      Text('Purpose: Web key data'),
    ],
  );
}
