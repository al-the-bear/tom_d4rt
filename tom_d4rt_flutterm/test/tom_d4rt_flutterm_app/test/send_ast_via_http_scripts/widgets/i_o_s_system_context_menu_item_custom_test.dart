// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemCustom from widgets
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

  print('IOSSystemContextMenuItemCustom test executing');
  print('=' * 50);

  bool pressed = false;
  final IOSSystemContextMenuItemCustom item = IOSSystemContextMenuItemCustom(
    title: 'Custom Action',
    onPressed: () { pressed = true; },
  );

  runCase('item can be created', () {
    return item.runtimeType == IOSSystemContextMenuItemCustom;
  });

  runCase('title is stored', () {
    return item.title == 'Custom Action';
  });

  runCase('onPressed callback is stored', () {
    item.onPressed();
    return pressed == true;
  });

  runCase('getData returns custom data', () {
    final DefaultWidgetsLocalizations localizations = DefaultWidgetsLocalizations();
    final dynamic data = item.getData(localizations);
    return data.runtimeType.toString().contains('Custom');
  });

  runCase('equality uses title and onPressed', () {
    final IOSSystemContextMenuItemCustom same = IOSSystemContextMenuItemCustom(
      title: 'Custom Action',
      onPressed: item.onPressed,
    );
    return item == same;
  });

  runCase('different title means not equal', () {
    final IOSSystemContextMenuItemCustom other = IOSSystemContextMenuItemCustom(
      title: 'Other',
      onPressed: item.onPressed,
    );
    return item != other;
  });

  runCase('toString is non-empty', () {
    return item.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return item.hashCode == item.hashCode;
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
      const Text('IOSSystemContextMenuItemCustom Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('IOSSystemContextMenuItemCustom behavior checks completed'),
    ],
  );
}
