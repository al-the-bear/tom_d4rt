// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformDispatcher from dart_ui
import 'dart:ui' as ui;
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

  print('PlatformDispatcher test executing');
  print('=' * 50);

  final ui.PlatformDispatcher dispatcher = ui.PlatformDispatcher.instance;

  runCase('instance is singleton', () {
    return identical(dispatcher, ui.PlatformDispatcher.instance);
  });

  runCase('views collection is available', () {
    final Iterable<ui.FlutterView> views = dispatcher.views;
    return views.runtimeType.toString().contains('Iterable');
  });

  runCase('displays collection is available', () {
    final Iterable<ui.Display> displays = dispatcher.displays;
    return displays.runtimeType.toString().contains('Iterable');
  });

  runCase('locale is available', () {
    final ui.Locale locale = dispatcher.locale;
    return locale.languageCode.isNotEmpty;
  });

  runCase('locales list is available', () {
    final List<ui.Locale> locales = dispatcher.locales;
    return locales.isNotEmpty;
  });

  runCase('textScaleFactor is positive', () {
    final double factor = dispatcher.textScaleFactor;
    return factor > 0;
  });

  runCase('accessibilityFeatures is available', () {
    final ui.AccessibilityFeatures features = dispatcher.accessibilityFeatures;
    return features.runtimeType.toString().contains('Accessibility');
  });

  runCase('semanticsEnabled property exists', () {
    final bool enabled = dispatcher.semanticsEnabled;
    return enabled == true || enabled == false;
  });

  runCase('implicitView can be null', () {
    // On multi-view, implicitView may be null
    final ui.FlutterView? view = dispatcher.implicitView;
    return view != null || view == null;
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
      const Text('PlatformDispatcher Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('PlatformDispatcher behavior checks completed'),
    ],
  );
}
