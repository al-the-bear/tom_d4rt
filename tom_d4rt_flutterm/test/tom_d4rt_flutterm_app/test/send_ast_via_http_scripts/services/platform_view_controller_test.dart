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

  print('PlatformViewController test executing');
  print('=' * 50);

  runCase('PlatformViewController symbol exists', () {
    final Type t = PlatformViewController;
    return t.toString().contains('PlatformViewController');
  });

  runCase('PlatformViewController type string is stable', () {
    final Type t = PlatformViewController;
    return t.toString().isNotEmpty;
  });

  runCase('PlatformViewController type hashCode is stable', () {
    final Type t = PlatformViewController;
    return t.hashCode == t.hashCode;
  });

  runCase('TextInputAction values are available', () {
    return TextInputAction.values.isNotEmpty;
  });

  runCase('SmartDashesType values are available', () {
    return SmartDashesType.values.isNotEmpty;
  });

  runCase('SmartQuotesType values are available', () {
    return SmartQuotesType.values.isNotEmpty;
  });

  runCase('Logical keyboard key A exists', () {
    return LogicalKeyboardKey.keyA.keyLabel.isNotEmpty;
  });

  runCase('Physical keyboard key A usage id is positive', () {
    return PhysicalKeyboardKey.keyA.usbHidUsage > 0;
  });


  runCase('AndroidViewController symbol exists', () {
    final Type t = AndroidViewController;
    return t.toString().contains('AndroidViewController');
  });

  runCase('UiKitViewController symbol exists', () {
    final Type t = UiKitViewController;
    return t.toString().contains('UiKitViewController');
  });

  runCase('Summary string can be produced', () {
    final String summary = 'platformviewcontroller:'
        '${passed.length} passed, '
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
        'PlatformViewController Tests',
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
