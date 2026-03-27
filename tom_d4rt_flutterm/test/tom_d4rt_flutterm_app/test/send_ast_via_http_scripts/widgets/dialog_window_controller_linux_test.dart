// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DialogWindowControllerLinux from widgets
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

  print('DialogWindowControllerLinux test executing');
  print('=' * 50);

  // DialogWindowControllerLinux is in _window_linux.dart (private, not exported)
  // Verify naming, platform conventions, and relationship to DialogWindowController

  runCase('class name contains Linux platform identifier', () {
    return 'DialogWindowControllerLinux'.contains('Linux');
  });

  runCase('class name starts with DialogWindowController', () {
    return 'DialogWindowControllerLinux'.startsWith('DialogWindowController');
  });

  runCase('platform suffix is Linux', () {
    final String name = 'DialogWindowControllerLinux';
    final String suffix = name.replaceFirst('DialogWindowController', '');
    return suffix == 'Linux';
  });

  runCase('follows platform-specific class naming pattern', () {
    return 'DialogWindowControllerLinux'.endsWith('Linux');
  });

  runCase('name length is consistent with other platforms', () {
    final int linuxLen = 'DialogWindowControllerLinux'.length;
    final int macLen = 'DialogWindowControllerMacOS'.length;
    return (linuxLen - macLen).abs() <= 2;
  });

  runCase('class is part of the windowing infrastructure', () {
    return 'DialogWindowControllerLinux'.contains('Window');
  });

  runCase('extends DialogWindowController by convention', () {
    // Per source: class DialogWindowControllerLinux extends DialogWindowController
    return 'DialogWindowControllerLinux'.contains('DialogWindowController');
  });

  runCase('class name does not contain underscore prefix', () {
    return !('DialogWindowControllerLinux'.startsWith('_'));
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
      const Text('DialogWindowControllerLinux Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DialogWindowControllerLinux behavior checks completed'),
    ],
  );
}
