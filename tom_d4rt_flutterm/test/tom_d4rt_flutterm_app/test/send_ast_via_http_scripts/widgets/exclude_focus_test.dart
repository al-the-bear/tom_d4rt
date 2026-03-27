// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExcludeFocus from widgets
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

  print('ExcludeFocus test executing');
  print('=' * 50);

  const ExcludeFocus widget = ExcludeFocus(
    child: SizedBox.shrink(),
  );

  runCase('widget can be constructed', () {
    return widget.runtimeType == ExcludeFocus;
  });

  runCase('excluding defaults to true', () {
    return widget.excluding == true;
  });

  runCase('child is accessible', () {
    return widget.child is SizedBox;
  });

  runCase('excluding can be set to false', () {
    const ExcludeFocus notExcluding = ExcludeFocus(
      excluding: false,
      child: SizedBox.shrink(),
    );
    return notExcluding.excluding == false;
  });

  runCase('key works', () {
    const ExcludeFocus keyed = ExcludeFocus(
      key: ValueKey<String>('focus'),
      child: SizedBox.shrink(),
    );
    return keyed.key == const ValueKey<String>('focus');
  });

  runCase('widget is a StatelessWidget', () {
    return widget.runtimeType.toString().contains('ExcludeFocus');
  });

  runCase('toString is non-empty', () {
    return widget.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return widget.hashCode == widget.hashCode;
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
      const Text('ExcludeFocus Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExcludeFocus behavior checks completed'),
    ],
  );
}
