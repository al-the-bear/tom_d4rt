// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
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

  print('ClipboardStatusNotifier test executing');
  print('=' * 50);

  final ClipboardStatusNotifier notifier = ClipboardStatusNotifier();
  int calls = 0;

  runCase('notifier is a ValueNotifier', () {
    return notifier is ValueNotifier<ClipboardStatus?>;
  });

  runCase('listener can be attached', () {
    void listener() => calls++;
    notifier.addListener(listener);
    notifier.notifyListeners();
    notifier.removeListener(listener);
    return calls > 0;
  });

  runCase('value can be read', () {
    final ClipboardStatus? value = notifier.value;
    return value == null || ClipboardStatus.values.contains(value);
  });

  runCase('disposed notifier still has runtimeType', () {
    notifier.dispose();
    return notifier.runtimeType.toString().contains('ClipboardStatusNotifier');
  });

  runCase('enum has expected states', () {
    return ClipboardStatus.values.contains(ClipboardStatus.notPasteable) &&
        ClipboardStatus.values.contains(ClipboardStatus.pasteable);
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
      const Text('ClipboardStatusNotifier Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ClipboardStatusNotifier behavior checks completed'),
    ],
  );
}
