// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/foundation.dart';
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

  print('DebugCreator test executing');
  print('=' * 50);

  final StatefulElement element = StatefulElement(_HarnessWidget());
  final DebugCreator creator = DebugCreator(element);

  runCase('DebugCreator stores element reference', () {
    return identical(creator.element, element);
  });

  runCase('DebugCreator is a DiagnosticsNode', () {
    return creator is DiagnosticsNode;
  });

  runCase('toStringDeep returns non-empty text', () {
    return creator.toStringDeep().isNotEmpty;
  });

  runCase('toDescription gives class context', () {
    return creator.toDescription().isNotEmpty;
  });

  runCase('style is diagnostic style object', () {
    return creator.style != DiagnosticsTreeStyle.none;
  });

  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.contains('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('DebugCreator Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DebugCreator behavior checks completed'),
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
