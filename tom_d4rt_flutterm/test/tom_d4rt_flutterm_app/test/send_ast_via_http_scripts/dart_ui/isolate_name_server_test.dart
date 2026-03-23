// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IsolateNameServer from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IsolateNameServer test executing');

  // IsolateNameServer has only static methods, no constructor
  print('IsolateNameServer type: ${ui.IsolateNameServer}');

  // lookupPortByName — returns null if not registered
  final port1 = ui.IsolateNameServer.lookupPortByName('nonexistent_port');
  print('lookupPortByName(nonexistent): $port1');

  final port2 = ui.IsolateNameServer.lookupPortByName('test_service');
  print('lookupPortByName(test_service): $port2');

  // removePortNameMapping — returns false if not found
  final removed1 = ui.IsolateNameServer.removePortNameMapping('nonexistent_port');
  print('removePortNameMapping(nonexistent): $removed1');

  final removed2 = ui.IsolateNameServer.removePortNameMapping('test_service');
  print('removePortNameMapping(test_service): $removed2');

  print('IsolateNameServer API:');
  print('  lookupPortByName(String name) -> SendPort?');
  print('  registerPortWithName(SendPort port, String name) -> bool');
  print('  removePortNameMapping(String name) -> bool');

  print('IsolateNameServer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IsolateNameServer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Static-only class (no constructor)'),
      Text('lookupPortByName: returns null if not found'),
      Text('removePortNameMapping: returns false if not found'),
    ],
  );
}
