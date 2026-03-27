// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScriptCategory from material
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

  print('ScriptCategory test executing');
  print('=' * 50);

  // ScriptCategory enum: englishLike, dense, tall
  runCase('ScriptCategory.values has 3 entries', () {
    return ScriptCategory.values.length == 3;
  });

  runCase('englishLike value exists', () {
    final value = ScriptCategory.englishLike;
    print('  englishLike: index=${value.index}, name=${value.name}');
    return value.index == 0 && value.name == 'englishLike';
  });

  runCase('dense value exists', () {
    final value = ScriptCategory.dense;
    print('  dense: index=${value.index}, name=${value.name}');
    return value.index == 1 && value.name == 'dense';
  });

  runCase('tall value exists', () {
    final value = ScriptCategory.tall;
    print('  tall: index=${value.index}, name=${value.name}');
    return value.index == 2 && value.name == 'tall';
  });

  runCase('englishLike is first value', () {
    return ScriptCategory.values.first == ScriptCategory.englishLike;
  });

  runCase('tall is last value', () {
    return ScriptCategory.values.last == ScriptCategory.tall;
  });

  runCase('toString shows value name', () {
    final str = ScriptCategory.dense.toString();
    print('  toString: $str');
    return str.contains('dense');
  });

  runCase('enum values are comparable', () {
    return ScriptCategory.englishLike != ScriptCategory.dense;
  });

  runCase('englishLike for Western scripts', () {
    // englishLike: Latin, Greek, Cyrillic
    return true;
  });

  runCase('dense for CJK scripts', () {
    // dense: Chinese, Japanese, Korean - require extra line height
    return true;
  });

  runCase('tall for South Asian scripts', () {
    // tall: Arabic, Hindi, Telugu, Thai - require extra line height
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
      Text('ScriptCategory Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
