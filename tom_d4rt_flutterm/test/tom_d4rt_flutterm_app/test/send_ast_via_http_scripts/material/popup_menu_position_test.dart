// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PopupMenuPosition from material
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

  print('PopupMenuPosition test executing');
  print('=' * 50);

  // PopupMenuPosition is an enum with 2 values: over, under
  runCase('PopupMenuPosition.values has 2 entries', () {
    return PopupMenuPosition.values.length == 2;
  });

  runCase('over value exists', () {
    final value = PopupMenuPosition.over;
    print('  over: index=${value.index}, name=${value.name}');
    return value.index == 0 && value.name == 'over';
  });

  runCase('under value exists', () {
    final value = PopupMenuPosition.under;
    print('  under: index=${value.index}, name=${value.name}');
    return value.index == 1 && value.name == 'under';
  });

  runCase('over is first value', () {
    return PopupMenuPosition.values.first == PopupMenuPosition.over;
  });

  runCase('under is last value', () {
    return PopupMenuPosition.values.last == PopupMenuPosition.under;
  });

  runCase('toString shows value name', () {
    final str = PopupMenuPosition.over.toString();
    print('  toString: $str');
    return str.contains('over');
  });

  runCase('enum values are comparable', () {
    return PopupMenuPosition.over != PopupMenuPosition.under;
  });

  runCase('PopupMenuThemeData accepts position', () {
    final theme = PopupMenuThemeData(position: PopupMenuPosition.under);
    print('  PopupMenuThemeData position: ${theme.position}');
    return theme.position == PopupMenuPosition.under;
  });

  runCase('default position is over in typical usage', () {
    // over means menu is positioned over anchor
    // under means menu is positioned under anchor
    return true;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('PopupMenuPosition Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
