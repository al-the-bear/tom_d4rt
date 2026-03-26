// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
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

  print('ComponentElement test executing');
  print('=' * 50);

  final StatefulElement stateful = StatefulElement(_HarnessWidget());

  runCase('StatefulElement is a ComponentElement', () {
    return stateful is ComponentElement;
  });

  runCase('StatefulElement is also an Element', () {
    return stateful is Element;
  });

  runCase('widget reference is preserved', () {
    return stateful.widget is StatefulWidget;
  });

  runCase('dirty flag defaults to true before mount', () {
    return stateful.dirty;
  });

  runCase('toString references element type', () {
    return stateful.toString().contains('StatefulElement');
  });

  runCase('BuildContext contract holds', () {
    return stateful is BuildContext;
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
      const Text('ComponentElement Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ComponentElement behavior checks completed'),
    ],
  );
}

class _HarnessWidget extends StatefulWidget {
  @override
  State<_HarnessWidget> createState() => _HarnessState();
}

class _HarnessState extends State<_HarnessWidget> {
  @override
  Widget build(BuildContext context) => const SizedBox();
}
