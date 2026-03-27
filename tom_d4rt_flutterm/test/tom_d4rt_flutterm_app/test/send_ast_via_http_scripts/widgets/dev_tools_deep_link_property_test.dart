// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DevToolsDeepLinkProperty from widgets
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

  print('DevToolsDeepLinkProperty test executing');
  print('=' * 50);

  final DevToolsDeepLinkProperty prop =
      DevToolsDeepLinkProperty('Test description', 'https://devtools.example.com/inspector');

  runCase('property value is the URL string', () {
    return prop.value == 'https://devtools.example.com/inspector';
  });

  runCase('description is stored', () {
    return prop.toString().contains('Test description');
  });

  runCase('level is info', () {
    return prop.level == DiagnosticLevel.info;
  });

  runCase('runtime type is correct', () {
    return prop.runtimeType.toString().contains('DevToolsDeepLinkProperty');
  });

  runCase('name is empty string', () {
    return prop.name == '';
  });

  runCase('different URL creates different property', () {
    final DevToolsDeepLinkProperty other =
        DevToolsDeepLinkProperty('Other', 'https://other.example.com');
    return other.value != prop.value;
  });

  runCase('toString is non-empty', () {
    return prop.toString().isNotEmpty;
  });

  runCase('toDescription returns meaningful text', () {
    return prop.toDescription().isNotEmpty;
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
      const Text('DevToolsDeepLinkProperty Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DevToolsDeepLinkProperty behavior checks completed'),
    ],
  );
}
