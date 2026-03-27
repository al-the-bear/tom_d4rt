// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliderInteraction from material
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

  print('SliderInteraction test executing');
  print('=' * 50);

  // SliderInteraction enum: tapAndSlide, tapOnly, slideOnly, slideThumb
  runCase('SliderInteraction.values has 4 entries', () {
    return SliderInteraction.values.length == 4;
  });

  runCase('tapAndSlide value exists', () {
    final value = SliderInteraction.tapAndSlide;
    print('  tapAndSlide: index=${value.index}, name=${value.name}');
    return value.index == 0 && value.name == 'tapAndSlide';
  });

  runCase('tapOnly value exists', () {
    final value = SliderInteraction.tapOnly;
    print('  tapOnly: index=${value.index}, name=${value.name}');
    return value.index == 1 && value.name == 'tapOnly';
  });

  runCase('slideOnly value exists', () {
    final value = SliderInteraction.slideOnly;
    print('  slideOnly: index=${value.index}, name=${value.name}');
    return value.index == 2 && value.name == 'slideOnly';
  });

  runCase('slideThumb value exists', () {
    final value = SliderInteraction.slideThumb;
    print('  slideThumb: index=${value.index}, name=${value.name}');
    return value.index == 3 && value.name == 'slideThumb';
  });

  runCase('tapAndSlide is first value', () {
    return SliderInteraction.values.first == SliderInteraction.tapAndSlide;
  });

  runCase('slideThumb is last value', () {
    return SliderInteraction.values.last == SliderInteraction.slideThumb;
  });

  runCase('toString shows value name', () {
    final str = SliderInteraction.slideOnly.toString();
    print('  toString: $str');
    return str.contains('slideOnly');
  });

  runCase('enum values are comparable', () {
    return SliderInteraction.tapAndSlide != SliderInteraction.slideThumb;
  });

  runCase('SliderThemeData accepts allowedInteraction', () {
    final theme = SliderThemeData(allowedInteraction: SliderInteraction.slideThumb);
    print('  SliderThemeData allowedInteraction: ${theme.allowedInteraction}');
    return theme.allowedInteraction == SliderInteraction.slideThumb;
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
      Text('SliderInteraction Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
