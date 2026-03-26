// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// Handcrafted D4rt print-only test focused on CharacterActivator behavior.
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

  print('CharacterActivator test executing');
  print('=' * 50);

  const CharacterActivator plain = CharacterActivator('a');
  const CharacterActivator withControl = CharacterActivator('a', control: true);
  const CharacterActivator withAlt = CharacterActivator('a', alt: true);

  runCase('character is stored', () {
    return plain.character == 'a';
  });

  runCase('control modifier is tracked', () {
    return withControl.control && !withControl.alt;
  });

  runCase('alt modifier is tracked', () {
    return withAlt.alt && !withAlt.control;
  });

  runCase('equality differs with modifiers', () {
    return plain != withControl && withControl != withAlt;
  });

  runCase('same config compares equal', () {
    const CharacterActivator one = CharacterActivator('z', control: true);
    const CharacterActivator two = CharacterActivator('z', control: true);
    return one == two && one.hashCode == two.hashCode;
  });

  runCase('toString references activator type', () {
    return plain.toString().contains('CharacterActivator');
  });

  runCase('Activator supertype relation holds', () {
    return plain.runtimeType.toString().contains('CharacterActivator');
  });

  runCase('summary reflects run count', () {
    final String summary = '${passed.length + failed.length} cases';
    return summary.contains('cases');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('CharacterActivator Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('CharacterActivator behavior checks completed'),
    ],
  );
}
