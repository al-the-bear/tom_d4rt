// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyEventDeviceType from dart_ui
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

  print('KeyEventDeviceType test executing');
  print('=' * 50);

  runCase('keyboard value exists', () {
    return ui.KeyEventDeviceType.keyboard.index == 0;
  });

  runCase('directionalPad value exists', () {
    return ui.KeyEventDeviceType.directionalPad.index == 1;
  });

  runCase('gamepad value exists', () {
    return ui.KeyEventDeviceType.gamepad.index == 2;
  });

  runCase('joystick value exists', () {
    return ui.KeyEventDeviceType.joystick.index == 3;
  });

  runCase('hdmi value exists', () {
    return ui.KeyEventDeviceType.hdmi.index == 4;
  });

  runCase('values has 5 entries', () {
    return ui.KeyEventDeviceType.values.length == 5;
  });

  runCase('keyboard label is Keyboard', () {
    return ui.KeyEventDeviceType.keyboard.label == 'Keyboard';
  });

  runCase('gamepad label is Gamepad', () {
    return ui.KeyEventDeviceType.gamepad.label == 'Gamepad';
  });

  runCase('toString contains enum name', () {
    return ui.KeyEventDeviceType.keyboard.toString().contains('keyboard');
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
      const Text('KeyEventDeviceType Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('KeyEventDeviceType behavior checks completed'),
    ],
  );
}
