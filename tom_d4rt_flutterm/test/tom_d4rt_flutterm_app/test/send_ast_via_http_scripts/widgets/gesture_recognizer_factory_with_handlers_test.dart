// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests GestureRecognizerFactoryWithHandlers from widgets
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

  print('GestureRecognizerFactoryWithHandlers test executing');
  print('=' * 50);

  bool initializerCalled = false;
  final GestureRecognizerFactoryWithHandlers<TapGestureRecognizer> factory =
      GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
    (TapGestureRecognizer instance) {
      initializerCalled = true;
    },
  );

  runCase('factory can be created', () {
    return factory.runtimeType.toString().contains('GestureRecognizerFactoryWithHandlers');
  });

  runCase('constructor callback creates recognizer', () {
    final TapGestureRecognizer r = factory.constructor();
    final bool result = r.runtimeType == TapGestureRecognizer;
    r.dispose();
    return result;
  });

  runCase('initializer callback is invoked', () {
    final TapGestureRecognizer r = factory.constructor();
    factory.initializer(r);
    r.dispose();
    return initializerCalled == true;
  });

  runCase('different type parameter works', () {
    final GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer> dtf =
        GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
      () => DoubleTapGestureRecognizer(),
      (DoubleTapGestureRecognizer instance) {},
    );
    final DoubleTapGestureRecognizer r = dtf.constructor();
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
      const Text('GestureRecognizerFactoryWithHandlers Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('GestureRecognizerFactoryWithHandlers behavior checks completed'),
    ],
  );
}
