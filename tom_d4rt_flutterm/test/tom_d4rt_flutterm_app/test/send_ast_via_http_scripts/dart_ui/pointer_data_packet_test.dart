// D4rt test script: Tests PointerDataPacket from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerDataPacket test executing');

  // Create with empty data
  final packet1 = ui.PointerDataPacket();
  print('Empty packet: ${packet1.runtimeType}');
  print('data length: ${packet1.data.length}');

  // Create with data list
  final pd1 = ui.PointerData(change: ui.PointerChange.add);
  final pd2 = ui.PointerData(change: ui.PointerChange.down, physicalX: 100.0, physicalY: 200.0);
  final pd3 = ui.PointerData(change: ui.PointerChange.up);
  final packet2 = ui.PointerDataPacket(data: [pd1, pd2, pd3]);
  print('Packet with 3 events: ${packet2.data.length}');
  print('First event change: ${packet2.data[0].change}');
  print('Second physicalX: ${packet2.data[1].physicalX}');
  print('Third change: ${packet2.data[2].change}');

  print('PointerDataPacket test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PointerDataPacket Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Empty: ${packet1.data.length} events'),
    Text('With data: ${packet2.data.length} events'),
  ]);
}
