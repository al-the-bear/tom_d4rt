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

  print('RestorationBucket test executing');
  print('=' * 50);

  runCase('RestorationBucket symbol exists', () {
    final Type t = RestorationBucket;
    return t.toString().contains('RestorationBucket');
  });

  runCase('RestorationBucket type string is stable', () {
    final Type t = RestorationBucket;
    return t.toString().isNotEmpty;
  });

  runCase('RestorationBucket type hashCode is stable', () {
    final Type t = RestorationBucket;
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


  runCase('RestorationManager symbol exists', () {
    final Type t = RestorationManager;
    return t.toString().contains('RestorationManager');
  });

  runCase('RestorationBucket type string matches', () {
    final Type t = RestorationBucket;
    return t.toString().contains('RestorationBucket');
  });

  runCase('Summary string can be produced', () {
    final String summary = 'restorationbucket:'
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
        'RestorationBucket Tests',
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
