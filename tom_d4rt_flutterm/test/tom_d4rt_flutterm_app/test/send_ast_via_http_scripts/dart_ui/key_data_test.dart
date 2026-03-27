// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyData from dart_ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('KeyData test executing');
  print('=' * 50);

  final ui.KeyData keyData = ui.KeyData(
    timeStamp: const Duration(milliseconds: 100),
    type: ui.KeyEventType.down,
    physical: 0x00070004,
    logical: 0x00000000061,
    character: 'a',
    synthesized: false,
  );

  runCase('KeyData can be created', () {
    return keyData.runtimeType == ui.KeyData;
  });

  runCase('timeStamp is stored', () {
    return keyData.timeStamp == const Duration(milliseconds: 100);
  });

  runCase('type is stored', () {
    return keyData.type == ui.KeyEventType.down;
  });

  runCase('physical key is stored', () {
    return keyData.physical == 0x00070004;
  });

  runCase('logical key is stored', () {
    return keyData.logical == 0x00000000061;
  });

  runCase('character is stored', () {
    return keyData.character == 'a';
  });

  runCase('synthesized is stored', () {
    return keyData.synthesized == false;
  });

  runCase('deviceType defaults to keyboard', () {
    return keyData.deviceType == ui.KeyEventDeviceType.keyboard;
  });

  runCase('custom deviceType is stored', () {
    final ui.KeyData k = ui.KeyData(
      timeStamp: Duration.zero,
      type: ui.KeyEventType.up,
      physical: 0,
      logical: 0,
      character: null,
      synthesized: false,
      deviceType: ui.KeyEventDeviceType.gamepad,
    );
    return k.deviceType == ui.KeyEventDeviceType.gamepad;
  });

  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('KeyData Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('KeyData behavior checks completed'),
    ],
  );
}
