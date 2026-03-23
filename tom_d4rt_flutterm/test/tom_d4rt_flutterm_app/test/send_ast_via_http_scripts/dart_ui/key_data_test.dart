// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyData from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyData test executing');

  // KeyData with key down event
  final kd1 = ui.KeyData(
    timeStamp: Duration(milliseconds: 100),
    type: ui.KeyEventType.down,
    physical: 0x00070004,
    logical: 0x00000061,
    character: 'a',
    synthesized: false,
  );
  print('KeyData created: ${kd1.runtimeType}');
  print('timeStamp: ${kd1.timeStamp}');
  print('type: ${kd1.type}');
  print('physical: ${kd1.physical}');
  print('logical: ${kd1.logical}');
  print('character: ${kd1.character}');
  print('synthesized: ${kd1.synthesized}');
  print('deviceType: ${kd1.deviceType}');

  // KeyData with key up event
  final kd2 = ui.KeyData(
    timeStamp: Duration(milliseconds: 200),
    type: ui.KeyEventType.up,
    physical: 0x00070004,
    logical: 0x00000061,
    character: null,
    synthesized: false,
  );
  print('KeyData up: type=${kd2.type}, character=${kd2.character}');

  // KeyData with repeat
  final kd3 = ui.KeyData(
    timeStamp: Duration(milliseconds: 150),
    type: ui.KeyEventType.repeat,
    physical: 0x00070004,
    logical: 0x00000061,
    character: 'a',
    synthesized: true,
    deviceType: ui.KeyEventDeviceType.keyboard,
  );
  print('KeyData repeat: type=${kd3.type}, synthesized=${kd3.synthesized}');
  print('deviceType: ${kd3.deviceType}');

  // toString
  print('toString: ${kd1.toString()}');
  print('toStringFull: ${kd1.toStringFull()}');

  // KeyEventType values
  for (final t in ui.KeyEventType.values) {
    print('KeyEventType: ${t.name}');
  }

  // KeyEventDeviceType values
  for (final d in ui.KeyEventDeviceType.values) {
    print('KeyEventDeviceType: ${d.name}');
  }

  print('KeyData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyData Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Down: type=${kd1.type}, char=${kd1.character}'),
      Text('Up: type=${kd2.type}, char=${kd2.character}'),
      Text('Repeat: synthesized=${kd3.synthesized}'),
      Text('KeyEventType: ${ui.KeyEventType.values.length} values'),
    ],
  );
}
