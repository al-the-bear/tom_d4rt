// D4rt test script: Tests RawKeyEventData from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventData test executing');
  print('=' * 50);

  // RawKeyEventData - deprecated abstract base
  print('\nRawKeyEventData (deprecated):');
  print('Abstract base for platform-specific key data');
  print('Part of deprecated RawKeyboard system');

  // Platform-specific subclasses
  print('\nPlatform-specific subclasses:');
  print('- RawKeyEventDataAndroid');
  print('- RawKeyEventDataIos');
  print('- RawKeyEventDataMacOs');
  print('- RawKeyEventDataWindows');
  print('- RawKeyEventDataLinux');
  print('- RawKeyEventDataWeb');
  print('- RawKeyEventDataFuchsia');

  // Common properties
  print('\nCommon properties:');
  print('- physicalKey: PhysicalKeyboardKey');
  print('- logicalKey: LogicalKeyboardKey');
  print('- keyLabel: String (printable character)');

  // Modifier state
  print('\nModifier state properties:');
  print('- isControlPressed: bool');
  print('- isShiftPressed: bool');
  print('- isAltPressed: bool');
  print('- isMetaPressed: bool');
  print('- modifiersPressed: Map of modifiers');

  // Android-specific data
  print('\nAndroid-specific (RawKeyEventDataAndroid):');
  print('- flags: Android event flags');
  print('- codePoint: Unicode code point');
  print('- keyCode: Android key code');
  print('- scanCode: Hardware scan code');
  print('- metaState: Meta key state mask');

  // iOS-specific data
  print('\niOS-specific (RawKeyEventDataIos):');
  print('- characters: UIKey characters');
  print('- charactersIgnoringModifiers');
  print('- keyCode: UIKey key code');
  print('- modifiers: UIKeyModifierFlags');

  // Access from RawKeyEvent
  print('\nAccess from RawKeyEvent:');
  print('final event = RawKeyDownEvent(...);');
  print('final data = event.data;');
  print('if (data is RawKeyEventDataAndroid) {');
  print('  final keyCode = data.keyCode;');
  print('}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RawKeyEventData (abstract, deprecated)');
  print('  \u251c\u2500 RawKeyEventDataAndroid');
  print('  \u251c\u2500 RawKeyEventDataIos');
  print('  \u251c\u2500 RawKeyEventDataMacOs');
  print('  \u251c\u2500 RawKeyEventDataWindows');
  print('  \u251c\u2500 RawKeyEventDataLinux');
  print('  \u251c\u2500 RawKeyEventDataWeb');
  print('  \u2514\u2500 RawKeyEventDataFuchsia');

  // Explain purpose
  print('\nRawKeyEventData purpose (deprecated):');
  print('- Platform-specific key event details');
  print('- Contains raw platform key codes');
  print('- Maps to Flutter key identifiers');
  print('- Part of RawKeyEvent.data');
  print('- Migrate to KeyEvent system');

  print('\n' + '=' * 50);
  print('RawKeyEventData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawKeyEventData Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: DEPRECATED'),
      Text('Type: abstract base class'),
      Text('Impls: Android, iOS, macOS, etc.'),
      Text('Purpose: Platform key data'),
    ],
  );
}
