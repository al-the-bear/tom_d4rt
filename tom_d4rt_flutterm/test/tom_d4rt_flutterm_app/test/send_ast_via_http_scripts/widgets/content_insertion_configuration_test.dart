// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:typed_data';

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

  print('ContentInsertionConfiguration test executing');
  print('=' * 50);

  final ContentInsertionConfiguration config = ContentInsertionConfiguration(
    onContentInserted: (KeyboardInsertedContent data) {},
  );

  runCase('configuration can be constructed', () {
    return config.runtimeType.toString().contains('ContentInsertionConfiguration');
  });

  runCase('onContentInserted callback is present', () {
    return config.onContentInserted.runtimeType.toString().contains('KeyboardInsertedContent');
  });

  runCase('second config has independent callback', () {
    final ContentInsertionConfiguration second = ContentInsertionConfiguration(
      onContentInserted: (KeyboardInsertedContent data) {},
    );
    return !identical(second.onContentInserted, config.onContentInserted);
  });

  runCase('callbacks can be invoked without error', () {
    config.onContentInserted(
      KeyboardInsertedContent(
        mimeType: 'text/plain',
        data: Uint8List(0),
        uri: 'https://example.com/inserted',
      ),
    );
    return true;
  });

  runCase('toString references class name', () {
    return config.toString().contains('ContentInsertionConfiguration');
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
      const Text('ContentInsertionConfiguration Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ContentInsertionConfiguration behavior checks completed'),
    ],
  );
}
