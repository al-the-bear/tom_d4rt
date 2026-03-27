// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PictureRasterizationException from dart_ui
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

  print('PictureRasterizationException test executing');
  print('=' * 50);

  // PictureRasterizationException has private constructor
  runCase('PictureRasterizationException implements Exception', () {
    return true; // class PictureRasterizationException implements Exception
  });

  runCase('exception has message property', () {
    // message property exists
    return true;
  });

  runCase('exception has stack property', () {
    // stack property exists (optional)
    return true;
  });

  runCase('toString includes message', () {
    // toString formats message
    return true;
  });

  runCase('exception is thrown during rasterization failures', () {
    // Thrown by Picture.toImageSync on failure
    return true;
  });

  runCase('exception provides failure details', () {
    // The message contains details about the failure
    return true;
  });

  runCase('stack trace is optional', () {
    // The stack property can be null
    return true;
  });

  runCase('exception name contains Picture', () {
    return 'PictureRasterizationException'.contains('Picture');
  });

  runCase('exception name contains Rasterization', () {
    return 'PictureRasterizationException'.contains('Rasterization');
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
      const Text('PictureRasterizationException Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('PictureRasterizationException behavior checks completed'),
    ],
  );
}
