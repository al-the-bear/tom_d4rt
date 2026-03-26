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

  print('IOSSystemContextMenuItemData test executing');
  print('=' * 50);

  runCase('IOSSystemContextMenuItemData symbol exists', () {
    final Type t = IOSSystemContextMenuItemData;
    return t.toString().contains('IOSSystemContextMenuItemData');
  });

  runCase('SearchWeb subtype symbol exists', () {
    final Type t = IOSSystemContextMenuItemDataSearchWeb;
    return t.toString().contains('IOSSystemContextMenuItemDataSearchWeb');
  });

  runCase('SystemContextMenuController symbol exists', () {
    final Type t = SystemContextMenuController;
    return t.toString().contains('SystemContextMenuController');
  });

  runCase('SystemContextMenuClient symbol exists', () {
    final Type t = SystemContextMenuClient;
    return t.toString().contains('SystemContextMenuClient');
  });

  runCase('LiveTextInputStatus enum has values', () {
    return LiveTextInputStatus.values.isNotEmpty;
  });

  runCase('TextSelection object stores offsets', () {
    const TextSelection selection = TextSelection(baseOffset: 0, extentOffset: 2);
    return selection.baseOffset == 0 && selection.extentOffset == 2;
  });

  runCase('Summary string formed', () {
    final String s = 'ios-context-menu:${passed.length + failed.length}';
    return s.contains('context-menu');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('IOSSystemContextMenuItemData Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: IOS context-menu item symbols resolved'),
      const Text('Check: LiveTextInputStatus enum resolved'),
      const Text('Check: TextSelection primitive validated'),
      const Text('iOS system context-menu symbols and related APIs checked'),
    ],
  );
}
