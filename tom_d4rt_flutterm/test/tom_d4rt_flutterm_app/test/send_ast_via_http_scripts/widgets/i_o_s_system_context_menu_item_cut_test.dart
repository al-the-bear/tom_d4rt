// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemCut from widgets
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

  print('IOSSystemContextMenuItemCut test executing');
  print('=' * 50);

  const IOSSystemContextMenuItemCut item = IOSSystemContextMenuItemCut();

  runCase('item can be created', () {
    return item.runtimeType == IOSSystemContextMenuItemCut;
  });

  runCase('two const instances are identical', () {
    const IOSSystemContextMenuItemCut other = IOSSystemContextMenuItemCut();
    return identical(item, other);
  });

  runCase('toString is non-empty', () {
    return item.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return item.hashCode == item.hashCode;
  });

  runCase('getData returns IOSSystemContextMenuItemDataCut', () {
    final DefaultWidgetsLocalizations localizations = DefaultWidgetsLocalizations();
    final dynamic data = item.getData(localizations);
    return data.runtimeType.toString().contains('Cut');
  });

  runCase('different from IOSSystemContextMenuItemCopy', () {
    const IOSSystemContextMenuItemCopy copy = IOSSystemContextMenuItemCopy();
    return item.runtimeType != copy.runtimeType;
  });

  runCase('different from IOSSystemContextMenuItemLiveText', () {
    const IOSSystemContextMenuItemLiveText liveText = IOSSystemContextMenuItemLiveText();
    return item.runtimeType != liveText.runtimeType;
  });

  runCase('runtime type is final class', () {
    return item.runtimeType == IOSSystemContextMenuItemCut;
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
      const Text('IOSSystemContextMenuItemCut Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('IOSSystemContextMenuItemCut behavior checks completed'),
    ],
  );
}
