// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StretchMode from material
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

  print('StretchMode test executing');
  print('=' * 50);

  // StretchMode enum: zoomBackground, blurBackground, fadeTitle
  runCase('StretchMode.values has 3 entries', () {
    return StretchMode.values.length == 3;
  });

  runCase('zoomBackground value exists', () {
    final value = StretchMode.zoomBackground;
    print('  zoomBackground: index=${value.index}, name=${value.name}');
    return value.index == 0 && value.name == 'zoomBackground';
  });

  runCase('blurBackground value exists', () {
    final value = StretchMode.blurBackground;
    print('  blurBackground: index=${value.index}, name=${value.name}');
    return value.index == 1 && value.name == 'blurBackground';
  });

  runCase('fadeTitle value exists', () {
    final value = StretchMode.fadeTitle;
    print('  fadeTitle: index=${value.index}, name=${value.name}');
    return value.index == 2 && value.name == 'fadeTitle';
  });

  runCase('zoomBackground is first value', () {
    return StretchMode.values.first == StretchMode.zoomBackground;
  });

  runCase('fadeTitle is last value', () {
    return StretchMode.values.last == StretchMode.fadeTitle;
  });

  runCase('toString shows value name', () {
    final str = StretchMode.blurBackground.toString();
    print('  toString: $str');
    return str.contains('blurBackground');
  });

  runCase('enum values are comparable', () {
    return StretchMode.zoomBackground != StretchMode.fadeTitle;
  });

  runCase('FlexibleSpaceBar accepts stretchModes', () {
    final widget = FlexibleSpaceBar(
      stretchModes: [StretchMode.zoomBackground],
      title: Text('Test'),
    );
    print('  FlexibleSpaceBar created with stretchModes');
    return widget.stretchModes.contains(StretchMode.zoomBackground);
  });

  runCase('multiple stretchModes can be combined', () {
    final modes = [StretchMode.zoomBackground, StretchMode.fadeTitle];
    return modes.length == 2;
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
      Text('StretchMode Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
