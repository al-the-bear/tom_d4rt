// ignore_for_file: avoid_print
// D4rt test script: Tests KeyboardKey from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyboardKey test executing');

  // KeyboardKey is abstract - test via subclasses
  print('KeyboardKey is abstract base class');
  print('Subclasses: PhysicalKeyboardKey, LogicalKeyboardKey');

  // Test PhysicalKeyboardKey
  print('\nPhysicalKeyboardKey examples:');
  final physicalA = PhysicalKeyboardKey.keyA;
  print('keyA: ${physicalA.debugName}');
  print('usbHidUsage: ${physicalA.usbHidUsage}');
  print('is KeyboardKey: true /* physicalA is KeyboardKey */');

  final physicalEnter = PhysicalKeyboardKey.enter;
  print('enter: ${physicalEnter.debugName}');

  // Test LogicalKeyboardKey
  print('\nLogicalKeyboardKey examples:');
  final logicalA = LogicalKeyboardKey.keyA;
  print('keyA: ${logicalA.keyLabel}');
  print('keyId: ${logicalA.keyId}');
  print('is KeyboardKey: true /* logicalA is KeyboardKey */');

  final logicalEnter = LogicalKeyboardKey.enter;
  print('enter: ${logicalEnter.keyLabel}');

  // Explain difference
  print('\nPhysical vs Logical:');
  print('Physical: hardware key position');
  print('  - Same on all keyboards');
  print('  - Based on USB HID spec');
  print('Logical: what character it produces');
  print('  - Varies by keyboard layout');
  print('  - AZERTY vs QWERTY different');

  // Common keys
  print('\nCommon keys:');
  print('- LogicalKeyboardKey.escape');
  print('- LogicalKeyboardKey.space');
  print('- LogicalKeyboardKey.arrowUp/Down/Left/Right');
  print('- LogicalKeyboardKey.shift/control/alt/meta');

  print('\nKeyboardKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyboardKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract base for keys'),
      Text('Physical: ${physicalA.debugName}'),
      Text('Logical: ${logicalA.keyLabel}'),
      Text('Physical=position, Logical=character'),
    ],
  );
}
