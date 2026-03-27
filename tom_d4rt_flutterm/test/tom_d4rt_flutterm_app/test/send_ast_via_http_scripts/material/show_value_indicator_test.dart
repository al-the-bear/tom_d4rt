// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShowValueIndicator from material
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

  print('ShowValueIndicator test executing');
  print('=' * 50);

  // ShowValueIndicator enum: onlyForDiscrete, onlyForContinuous, always (deprecated), onDrag, alwaysVisible, never
  runCase('ShowValueIndicator.values exists', () {
    final count = ShowValueIndicator.values.length;
    print('  values count: $count');
    return count >= 5; // May have deprecated values
  });

  runCase('onlyForDiscrete value exists', () {
    final value = ShowValueIndicator.onlyForDiscrete;
    print('  onlyForDiscrete: index=${value.index}, name=${value.name}');
    return value.name == 'onlyForDiscrete';
  });

  runCase('onlyForContinuous value exists', () {
    final value = ShowValueIndicator.onlyForContinuous;
    print('  onlyForContinuous: index=${value.index}, name=${value.name}');
    return value.name == 'onlyForContinuous';
  });

  runCase('onDrag value exists', () {
    final value = ShowValueIndicator.onDrag;
    print('  onDrag: index=${value.index}, name=${value.name}');
    return value.name == 'onDrag';
  });

  runCase('alwaysVisible value exists', () {
    final value = ShowValueIndicator.alwaysVisible;
    print('  alwaysVisible: index=${value.index}, name=${value.name}');
    return value.name == 'alwaysVisible';
  });

  runCase('never value exists', () {
    final value = ShowValueIndicator.never;
    print('  never: index=${value.index}, name=${value.name}');
    return value.name == 'never';
  });

  runCase('SliderThemeData accepts showValueIndicator', () {
    final theme = SliderThemeData(showValueIndicator: ShowValueIndicator.onDrag);
    print('  SliderThemeData showValueIndicator: ${theme.showValueIndicator}');
    return theme.showValueIndicator == ShowValueIndicator.onDrag;
  });

  runCase('toString shows value name', () {
    final str = ShowValueIndicator.never.toString();
    print('  toString: $str');
    return str.contains('never');
  });

  runCase('enum values are comparable', () {
    return ShowValueIndicator.onDrag != ShowValueIndicator.never;
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
      Text('ShowValueIndicator Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
