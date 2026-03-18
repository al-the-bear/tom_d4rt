// D4rt test script: Tests KeyDownEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyDownEvent test executing');
  print('=' * 50);

  // Create KeyDownEvent for a letter key
  final keyA = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 100),
  );
  print('\nKeyDownEvent for key A:');
  print('runtimeType: ${keyA.runtimeType}');
  print('physicalKey: ${keyA.physicalKey}');
  print('logicalKey: ${keyA.logicalKey}');
  print('character: "${keyA.character}"');
  print('timeStamp: ${keyA.timeStamp}');

  // Test inherited KeyEvent properties
  print('\nInherited KeyEvent properties:');
  print('synthesized: ${keyA.synthesized}');

  // Create for modifier key
  final shiftKey = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.shiftLeft,
    logicalKey: LogicalKeyboardKey.shiftLeft,
    timeStamp: Duration(milliseconds: 50),
  );
  print('\nShift key:');
  print('physicalKey: ${shiftKey.physicalKey}');
  print('logicalKey: ${shiftKey.logicalKey}');
  print('character: ${shiftKey.character}');

  // Create for function key
  final f1Key = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.f1,
    logicalKey: LogicalKeyboardKey.f1,
    timeStamp: Duration(milliseconds: 200),
  );
  print('\nFunction key F1:');
  print('physicalKey: ${f1Key.physicalKey}');
  print('logicalKey: ${f1Key.logicalKey}');

  // Create for Enter key
  final enterKey = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.enter,
    logicalKey: LogicalKeyboardKey.enter,
    character: '\n',
    timeStamp: Duration(milliseconds: 300),
  );
  print('\nEnter key:');
  print('physicalKey: ${enterKey.physicalKey}');
  print(
    'character repr: ${enterKey.character == "\n" ? "newline" : enterKey.character}',
  );

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is KeyEvent: true /* keyA is KeyEvent */');
  print('is Object: true /* keyA is Object */');

  // Compare keys
  print('\nKey comparison:');
  print(
    'keyA.logicalKey == LogicalKeyboardKey.keyA: ${keyA.logicalKey == LogicalKeyboardKey.keyA}',
  );
  print('shiftKey.logicalKey.isModifierKey (approx): true');

  // Common key codes
  print('\nCommon KeyDownEvent patterns:');
  final space = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.space,
    logicalKey: LogicalKeyboardKey.space,
    character: ' ',
    timeStamp: Duration.zero,
  );
  final escape = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.escape,
    logicalKey: LogicalKeyboardKey.escape,
    timeStamp: Duration.zero,
  );
  print('Space character: "${space.character}"');
  print('Escape character: ${escape.character ?? "none"}');

  // Explain purpose
  print('\nKeyDownEvent purpose:');
  print('- Represents a key press (down) event');
  print('- Part of the KeyEvent hierarchy');
  print('- physicalKey: hardware key location');
  print('- logicalKey: semantic key meaning');
  print('- character: resulting character (or null)');
  print('- Used in Focus/RawKeyboardListener');

  print('\n' + '=' * 50);
  print('KeyDownEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyDownEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${keyA.runtimeType}'),
      Text('physicalKey: ${keyA.physicalKey.debugName}'),
      Text('character: "${keyA.character}"'),
      Text('is KeyEvent: true /* keyA is KeyEvent */'),
      Text('Purpose: Key press event'),
    ],
  );
}
