// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests GlobalObjectKey from widgets
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

  print('GlobalObjectKey test executing');
  print('=' * 50);

  final Object value1 = Object();
  final GlobalObjectKey<State<StatefulWidget>> key1 = GlobalObjectKey<State<StatefulWidget>>(value1);

  runCase('key can be created', () {
    return key1.runtimeType.toString().contains('GlobalObjectKey');
  });

  runCase('value is stored', () {
    return identical(key1.value, value1);
  });

  runCase('equality uses identity', () {
    final GlobalObjectKey<State<StatefulWidget>> key1b = GlobalObjectKey<State<StatefulWidget>>(value1);
    return key1 == key1b;
  });

  runCase('different objects produce unequal keys', () {
    final Object value2 = Object();
    final GlobalObjectKey<State<StatefulWidget>> key2 = GlobalObjectKey<State<StatefulWidget>>(value2);
    return key1 != key2;
  });

  runCase('hashCode uses identityHashCode', () {
    return key1.hashCode == identityHashCode(value1);
  });

  runCase('toString is non-empty', () {
    return key1.toString().isNotEmpty;
  });

  runCase('string value works', () {
    const GlobalObjectKey<State<StatefulWidget>> strKey =
        GlobalObjectKey<State<StatefulWidget>>('test-key');
    return strKey.value == 'test-key';
  });

  runCase('int value works', () {
    const GlobalObjectKey<State<StatefulWidget>> intKey =
        GlobalObjectKey<State<StatefulWidget>>(42);
    return intKey.value == 42;
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
      const Text('GlobalObjectKey Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('GlobalObjectKey behavior checks completed'),
    ],
  );
}
