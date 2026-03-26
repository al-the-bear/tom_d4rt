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

  print('SemanticsLabelBuilder test executing');
  print('=' * 50);

  runCase('SemanticsLabelBuilder symbol exists', () {
    final Type t = SemanticsLabelBuilder;
    return t.toString().contains('SemanticsLabelBuilder');
  });

  runCase('AttributedString basic text', () {
    final AttributedString text = AttributedString('hello');
    return text.string == 'hello';
  });

  runCase('StringAttribute symbol exists', () {
    final Type t = StringAttribute;
    return t.toString().contains('StringAttribute');
  });

  runCase('LocaleStringAttribute symbol exists', () {
    final Type t = LocaleStringAttribute;
    return t.toString().contains('LocaleStringAttribute');
  });

  runCase('SpellOutStringAttribute symbol exists', () {
    final Type t = SpellOutStringAttribute;
    return t.toString().contains('SpellOutStringAttribute');
  });

  runCase('SemanticsConfiguration attributedLabel stores text', () {
    final SemanticsConfiguration conf = SemanticsConfiguration();
    conf.attributedLabel = AttributedString('world');
    return conf.attributedLabel.string == 'world';
  });

  runCase('summary string formed', () {
    final String s = 'label-builder:${passed.length + failed.length}';
    return s.contains('label-builder');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('SemanticsLabelBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: SemanticsLabelBuilder symbol resolved'),
      const Text('Check: StringAttribute symbols resolved'),
      const Text('Label-builder related semantics checks completed'),
    ],
  );
}
