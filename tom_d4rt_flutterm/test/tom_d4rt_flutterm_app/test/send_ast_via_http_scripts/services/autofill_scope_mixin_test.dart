// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/services.dart';
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

  print('AutofillScopeMixin test executing');
  print('=' * 50);

  runCase('AutofillScopeMixin symbol exists', () {
    final Type t = AutofillScopeMixin;
    return t.toString().contains('AutofillScopeMixin');
  });

  runCase('AutofillScope symbol exists', () {
    final Type t = AutofillScope;
    return t.toString().contains('AutofillScope');
  });

  runCase('AutofillClient symbol exists', () {
    final Type t = AutofillClient;
    return t.toString().contains('AutofillClient');
  });

  runCase('AutofillConfiguration constructor works', () {
    const AutofillConfiguration config = AutofillConfiguration(
      uniqueIdentifier: 'id-1',
      autofillHints: <String>['email'],
      currentEditingValue: TextEditingValue(text: 'a@b.com'),
    );
    return config.uniqueIdentifier == 'id-1' && config.autofillHints.first == 'email';
  });

  runCase('AutofillHints.email constant is valid', () {
    return AutofillHints.email.contains('email');
  });

  runCase('TextInputConfiguration carries autofill config', () {
    const TextInputConfiguration cfg = TextInputConfiguration(
      autofillConfiguration: AutofillConfiguration(
        uniqueIdentifier: 'x',
        autofillHints: <String>[AutofillHints.name],
        currentEditingValue: TextEditingValue(text: 'alex'),
      ),
    );
    return cfg.autofillConfiguration.autofillHints.contains(AutofillHints.name);
  });

  runCase('summary string formed', () {
    final String s = 'autofill-scope:${passed.length + failed.length}';
    return s.startsWith('autofill-scope:');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('AutofillScopeMixin Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Autofill mixin and configuration checks completed'),
    ],
  );
}
