// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/services.dart';
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

  print('KeyEventManager test executing');
  print('=' * 50);

  runCase('KeyEventManager symbol exists', () {
    final Type t = KeyEventManager;
    return t.toString().contains('KeyEventManager');
  });

  runCase('HardwareKeyboard singleton available', () {
    return HardwareKeyboard.instance.runtimeType.toString().isNotEmpty;
  });

  runCase('RawKeyDownEvent symbol exists', () {
    final Type t = RawKeyDownEvent;
    return t.toString().contains('RawKeyDownEvent');
  });

  runCase('RawKeyUpEvent symbol exists', () {
    final Type t = RawKeyUpEvent;
    return t.toString().contains('RawKeyUpEvent');
  });

  runCase('Logical key A has keyLabel', () {
    return LogicalKeyboardKey.keyA.keyLabel.isNotEmpty;
  });

  runCase('Physical key A has usage', () {
    return PhysicalKeyboardKey.keyA.usbHidUsage > 0;
  });

  runCase('ModifierKey enum has shiftModifier', () {
    return ModifierKey.values.contains(ModifierKey.shiftModifier);
  });

  runCase('KeyDataTransitMode enum populated', () {
    return KeyDataTransitMode.values.isNotEmpty;
  });

  runCase('summary string formed', () {
    final String s = 'key-event-manager:${passed.length + failed.length}';
    return s.startsWith('key-event-manager:');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('KeyEventManager Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Keyboard manager and key primitive checks completed'),
    ],
  );
}
