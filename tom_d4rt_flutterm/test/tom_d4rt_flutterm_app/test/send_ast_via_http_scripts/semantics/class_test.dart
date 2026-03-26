// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/semantics.dart';
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

  print('Semantics class aggregate test executing');
  print('=' * 50);

  runCase('SemanticsAction enum contains tap', () {
    return SemanticsAction.values.contains(SemanticsAction.tap);
  });

  runCase('SemanticsFlag enum contains isButton', () {
    return SemanticsFlag.values.contains(SemanticsFlag.isButton);
  });

  runCase('SemanticsRole enum has members', () {
    return SemanticsRole.values.isNotEmpty;
  });

  runCase('SemanticsConfiguration label set/get', () {
    final SemanticsConfiguration c = SemanticsConfiguration();
    c.label = 'submit';
    return c.label == 'submit';
  });

  runCase('CustomSemanticsAction has label', () {
    final CustomSemanticsAction a = CustomSemanticsAction(label: 'Do it');
    return a.label == 'Do it';
  });

  runCase('StringAttribute type available', () {
    final Type t = StringAttribute;
    return t.toString().contains('StringAttribute');
  });

  runCase('TextDirection available from semantics usage', () {
    return TextDirection.values.contains(TextDirection.ltr);
  });

  runCase('SemanticsValidationResult has expected size', () {
    return SemanticsValidationResult.values.length >= 2;
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('Semantics Class Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Semantics class coverage checks complete'),
    ],
  );
}
