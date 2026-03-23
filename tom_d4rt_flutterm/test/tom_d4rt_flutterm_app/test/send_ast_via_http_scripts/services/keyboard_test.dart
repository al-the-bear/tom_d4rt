// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LogicalKeyboardKey, PhysicalKeyboardKey, HardwareKeyboard from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services keyboard test executing');

  // ========== LOGICALKEYBOARDKEY ==========
  print('--- LogicalKeyboardKey Tests ---');

  // Common keys
  final space = LogicalKeyboardKey.space;
  print('LogicalKeyboardKey.space:');
  print('  keyId: ${space.keyId}');
  print('  keyLabel: "${space.keyLabel}"');
  print('  debugName: ${space.debugName}');
  print('  runtimeType: ${space.runtimeType}');

  final enter = LogicalKeyboardKey.enter;
  print('LogicalKeyboardKey.enter:');
  print('  keyId: ${enter.keyId}');
  print('  keyLabel: "${enter.keyLabel}"');
  print('  debugName: ${enter.debugName}');

  final escape = LogicalKeyboardKey.escape;
  print('LogicalKeyboardKey.escape:');
  print('  keyId: ${escape.keyId}');
  print('  keyLabel: "${escape.keyLabel}"');
  print('  debugName: ${escape.debugName}');

  final tab = LogicalKeyboardKey.tab;
  print('LogicalKeyboardKey.tab:');
  print('  keyId: ${tab.keyId}');
  print('  debugName: ${tab.debugName}');

  final backspace = LogicalKeyboardKey.backspace;
  print('LogicalKeyboardKey.backspace:');
  print('  keyId: ${backspace.keyId}');
  print('  debugName: ${backspace.debugName}');

  // Letter keys
  final keyA = LogicalKeyboardKey.keyA;
  print('LogicalKeyboardKey.keyA:');
  print('  keyId: ${keyA.keyId}');
  print('  keyLabel: "${keyA.keyLabel}"');

  final keyZ = LogicalKeyboardKey.keyZ;
  print('LogicalKeyboardKey.keyZ:');
  print('  keyId: ${keyZ.keyId}');
  print('  keyLabel: "${keyZ.keyLabel}"');

  // Number keys
  final digit0 = LogicalKeyboardKey.digit0;
  print('LogicalKeyboardKey.digit0:');
  print('  keyId: ${digit0.keyId}');
  print('  keyLabel: "${digit0.keyLabel}"');

  final digit9 = LogicalKeyboardKey.digit9;
  print('LogicalKeyboardKey.digit9:');
  print('  keyId: ${digit9.keyId}');
  print('  keyLabel: "${digit9.keyLabel}"');

  // Modifier keys
  final shiftLeft = LogicalKeyboardKey.shiftLeft;
  print('LogicalKeyboardKey.shiftLeft:');
  print('  keyId: ${shiftLeft.keyId}');
  print('  debugName: ${shiftLeft.debugName}');

  final controlLeft = LogicalKeyboardKey.controlLeft;
  print('LogicalKeyboardKey.controlLeft:');
  print('  keyId: ${controlLeft.keyId}');
  print('  debugName: ${controlLeft.debugName}');

  final altLeft = LogicalKeyboardKey.altLeft;
  print('LogicalKeyboardKey.altLeft:');
  print('  keyId: ${altLeft.keyId}');
  print('  debugName: ${altLeft.debugName}');

  final metaLeft = LogicalKeyboardKey.metaLeft;
  print('LogicalKeyboardKey.metaLeft:');
  print('  keyId: ${metaLeft.keyId}');
  print('  debugName: ${metaLeft.debugName}');

  // Function keys
  final f1 = LogicalKeyboardKey.f1;
  print('LogicalKeyboardKey.f1:');
  print('  keyId: ${f1.keyId}');
  print('  debugName: ${f1.debugName}');

  final f12 = LogicalKeyboardKey.f12;
  print('LogicalKeyboardKey.f12:');
  print('  keyId: ${f12.keyId}');
  print('  debugName: ${f12.debugName}');

  // Arrow keys
  final arrowUp = LogicalKeyboardKey.arrowUp;
  final arrowDown = LogicalKeyboardKey.arrowDown;
  final arrowLeft = LogicalKeyboardKey.arrowLeft;
  final arrowRight = LogicalKeyboardKey.arrowRight;
  print(
    'Arrow keys: up=${arrowUp.debugName}, down=${arrowDown.debugName}, left=${arrowLeft.debugName}, right=${arrowRight.debugName}',
  );

  // ========== PHYSICALKEYBOARDKEY ==========
  print('--- PhysicalKeyboardKey Tests ---');

  final physKeyA = PhysicalKeyboardKey.keyA;
  print('PhysicalKeyboardKey.keyA:');
  print('  usbHidUsage: ${physKeyA.usbHidUsage}');
  print('  debugName: ${physKeyA.debugName}');
  print('  runtimeType: ${physKeyA.runtimeType}');

  final physSpace = PhysicalKeyboardKey.space;
  print('PhysicalKeyboardKey.space:');
  print('  usbHidUsage: ${physSpace.usbHidUsage}');
  print('  debugName: ${physSpace.debugName}');

  final physEnter = PhysicalKeyboardKey.enter;
  print('PhysicalKeyboardKey.enter:');
  print('  usbHidUsage: ${physEnter.usbHidUsage}');
  print('  debugName: ${physEnter.debugName}');

  final physShiftLeft = PhysicalKeyboardKey.shiftLeft;
  print('PhysicalKeyboardKey.shiftLeft:');
  print('  usbHidUsage: ${physShiftLeft.usbHidUsage}');
  print('  debugName: ${physShiftLeft.debugName}');

  // ========== HARDWAREKEYBOARD ==========
  print('--- HardwareKeyboard Tests ---');

  final hwKeyboard = HardwareKeyboard.instance;
  print('HardwareKeyboard.instance:');
  print('  runtimeType: ${hwKeyboard.runtimeType}');
  print('  physicalKeysPressed: ${hwKeyboard.physicalKeysPressed}');
  print('  logicalKeysPressed: ${hwKeyboard.logicalKeysPressed}');
  print('  lockModesEnabled: ${hwKeyboard.lockModesEnabled}');

  // ========== RETURN WIDGET ==========
  print('Services keyboard test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Keyboard Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• LogicalKeyboardKey - logical key identifiers'),
          Text('• PhysicalKeyboardKey - physical key codes'),
          Text('• HardwareKeyboard - keyboard state'),
          SizedBox(height: 16.0),

          Text('Sample Keys:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFF8E1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Logical: space=${space.keyId}, enter=${enter.keyId}'),
                Text('  escape=${escape.keyId}, tab=${tab.keyId}'),
                Text('  keyA="${keyA.keyLabel}", digit0="${digit0.keyLabel}"'),
                SizedBox(height: 8.0),
                Text('Physical: keyA=${physKeyA.usbHidUsage}'),
                Text('  space=${physSpace.usbHidUsage}'),
                Text('  enter=${physEnter.usbHidUsage}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
