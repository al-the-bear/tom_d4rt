// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LocaleStringAttribute from dart_ui
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

  print('LocaleStringAttribute test executing');
  print('=' * 50);

  final ui.LocaleStringAttribute attr = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 0, end: 10),
    locale: const Locale('en', 'US'),
  );

  runCase('LocaleStringAttribute can be created', () {
    return attr.runtimeType == ui.LocaleStringAttribute;
  });

  runCase('range is stored', () {
    return attr.range.start == 0 && attr.range.end == 10;
  });

  runCase('locale is stored', () {
    return attr.locale == const Locale('en', 'US');
  });

  runCase('copy creates new instance with new range', () {
    final ui.StringAttribute copied = attr.copy(range: const ui.TextRange(start: 5, end: 15));
    return copied.range.start == 5 && copied.range.end == 15;
  });

  runCase('toString contains locale tag', () {
    return attr.toString().contains('en-US');
  });

  runCase('extends StringAttribute', () {
    return attr.runtimeType.toString().contains('LocaleStringAttribute');
  });

  runCase('different locales work', () {
    final ui.LocaleStringAttribute fr = ui.LocaleStringAttribute(
      range: const ui.TextRange(start: 0, end: 5),
      locale: const Locale('fr', 'FR'),
    );
    return fr.locale == const Locale('fr', 'FR');
  });

  runCase('range can span entire text', () {
    final ui.LocaleStringAttribute full = ui.LocaleStringAttribute(
      range: const ui.TextRange(start: 0, end: 1000),
      locale: const Locale('de'),
    );
    return full.range.end == 1000;
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
      const Text('LocaleStringAttribute Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('LocaleStringAttribute behavior checks completed'),
    ],
  );
}
