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

  print('GLFWKeyHelper test executing');
  print('=' * 50);

  runCase('GLFWKeyHelper symbol exists', () {
    final Type t = GLFWKeyHelper;
    return t.toString().contains('GLFWKeyHelper');
  });

  runCase('GtkKeyHelper symbol exists', () {
    final Type t = GtkKeyHelper;
    return t.toString().contains('GtkKeyHelper');
  });

  runCase('RawKeyEventDataLinux symbol exists', () {
    final Type t = RawKeyEventDataLinux;
    return t.toString().contains('RawKeyEventDataLinux');
  });

  runCase('LogicalKeyboardKey.enter has label', () {
    return LogicalKeyboardKey.enter.keyLabel.isNotEmpty;
  });

  runCase('PhysicalKeyboardKey.keyA has usage', () {
    return PhysicalKeyboardKey.keyA.usbHidUsage > 0;
  });

  runCase('ModifierKey enum includes controlModifier', () {
    return ModifierKey.values.contains(ModifierKey.controlModifier);
  });

  runCase('KeyboardSide enum includes all', () {
    return KeyboardSide.values.contains(KeyboardSide.all);
  });

  runCase('summary string formed', () {
    final String s = 'glfw-helper:${passed.length + failed.length}';
    return s.startsWith('glfw-helper:');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('GLFWKeyHelper Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: GLFWKeyHelper symbol resolved'),
      const Text('Check: RawKeyEventDataLinux symbol resolved'),
      const Text('Desktop key-helper and keyboard primitive checks done'),
    ],
  );
}
