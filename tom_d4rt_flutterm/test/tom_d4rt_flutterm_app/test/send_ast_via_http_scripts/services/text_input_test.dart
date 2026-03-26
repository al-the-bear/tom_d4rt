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

  print('TextInput test executing');
  print('=' * 50);

  runCase('TextInput symbol check', () {
    final Type t = TextInput;
    return t.toString().contains('TextInput');
  });

  runCase('Logical keyboard key A has label', () {
    return LogicalKeyboardKey.keyA.keyLabel.isNotEmpty;
  });

  runCase('Physical keyboard key A has usage id', () {
    return PhysicalKeyboardKey.keyA.usbHidUsage > 0;
  });

  runCase('TextInputAction enum populated', () {
    return TextInputAction.values.isNotEmpty;
  });

  runCase('SmartDashesType enum populated', () {
    return SmartDashesType.values.isNotEmpty;
  });

  runCase('SmartQuotesType enum populated', () {
    return SmartQuotesType.values.isNotEmpty;
  });


  runCase('TextInputType text constant exists', () {
    return TextInputType.text.toString().isNotEmpty;
  });

  runCase('TextInputAction go is present', () {
    return TextInputAction.values.contains(TextInputAction.go);
  });

  runCase('Summary string can be created', () {
    final String summary = 'textinput:'
        '${passed.length} passed '
        '${failed.length} failed';
    return summary.contains('passed') && summary.contains('failed');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text(
        'TextInput Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Service class-focused checks completed'),
    ],
  );
}
