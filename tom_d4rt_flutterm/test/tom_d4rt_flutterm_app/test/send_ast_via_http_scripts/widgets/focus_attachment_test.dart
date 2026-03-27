// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusAttachment from widgets
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

  print('FocusAttachment test executing');
  print('=' * 50);

  final FocusNode node = FocusNode(debugLabel: 'test-attach');
  final FocusAttachment attachment = node.attach(context);

  runCase('attachment is not null', () {
    return attachment.runtimeType == FocusAttachment;
  });

  runCase('isAttached is true after attach', () {
    return attachment.isAttached == true;
  });

  runCase('detach sets isAttached to false', () {
    final FocusNode n2 = FocusNode(debugLabel: 'test-detach');
    final FocusAttachment a2 = n2.attach(context);
    a2.detach();
    final bool result = a2.isAttached == false;
    n2.dispose();
    return result;
  });

  runCase('reparent can be called when attached', () {
    attachment.reparent();
    return true;
  });

  runCase('second attach replaces first', () {
    final FocusNode n3 = FocusNode(debugLabel: 'test-replace');
    final FocusAttachment first = n3.attach(context);
    final FocusAttachment second = n3.attach(context);
    final bool result = first.isAttached == false && second.isAttached == true;
    second.detach();
    n3.dispose();
    return result;
  });

  runCase('toString is non-empty', () {
    return attachment.toString().isNotEmpty;
  });

  // Clean up
  attachment.detach();
  node.dispose();

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
      const Text('FocusAttachment Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FocusAttachment behavior checks completed'),
    ],
  );
}
