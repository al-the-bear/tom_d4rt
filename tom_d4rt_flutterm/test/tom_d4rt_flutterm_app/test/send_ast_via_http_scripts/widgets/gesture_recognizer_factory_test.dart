// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests GestureRecognizerFactory from widgets
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

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

  print('GestureRecognizerFactory test executing');
  print('=' * 50);

  // GestureRecognizerFactory is abstract; test via GestureRecognizerFactoryWithHandlers
  final GestureRecognizerFactoryWithHandlers<TapGestureRecognizer> factory =
      GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
    (TapGestureRecognizer instance) {},
  );

  runCase('factory can be created', () {
    return factory.runtimeType.toString().contains('GestureRecognizerFactory');
  });

  runCase('constructor returns a TapGestureRecognizer', () {
    final TapGestureRecognizer recognizer = factory.constructor();
    final bool result = recognizer.runtimeType == TapGestureRecognizer;
    recognizer.dispose();
    return result;
  });

  runCase('initializer can be called', () {
    final TapGestureRecognizer recognizer = factory.constructor();
    factory.initializer(recognizer);
    recognizer.dispose();
    return true;
  });

  runCase('factory with LongPressGestureRecognizer works', () {
    final GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer> lpf =
        GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
      () => LongPressGestureRecognizer(),
      (LongPressGestureRecognizer instance) {},
    );
    final LongPressGestureRecognizer r = lpf.constructor();
    r.dispose();
    return true;
  });

  runCase('toString is non-empty', () {
    return factory.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return factory.hashCode == factory.hashCode;
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
      const Text('GestureRecognizerFactory Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('GestureRecognizerFactory behavior checks completed'),
    ],
  );
}
