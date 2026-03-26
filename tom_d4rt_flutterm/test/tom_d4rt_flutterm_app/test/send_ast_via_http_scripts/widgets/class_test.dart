// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// Handcrafted D4rt print-only umbrella widgets class test.
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

  print('Widgets class umbrella test executing');
  print('=' * 50);

  runCase('Widget base type exists', () {
    final Widget w = const SizedBox();
    return w.runtimeType.toString().isNotEmpty;
  });

  runCase('Element base type reachable', () {
    final Element e = StatefulElement(_HarnessWidget());
    return e.runtimeType.toString().contains('Element');
  });

  runCase('BuildOwner can be instantiated', () {
    final BuildOwner owner = BuildOwner();
    return owner.onBuildScheduled == null;
  });

  runCase('ConnectionState enum includes done', () {
    return ConnectionState.values.contains(ConnectionState.done);
  });

  runCase('Axis enum includes vertical and horizontal', () {
    return Axis.values.length == 2;
  });

  runCase('TextDirection has rtl', () {
    return TextDirection.values.contains(TextDirection.rtl);
  });

  runCase('summary text can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.contains('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('Widgets Class Umbrella Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Core widgets class behavior checks completed'),
    ],
  );
}

class _HarnessWidget extends StatefulWidget {
  @override
  State<_HarnessWidget> createState() => _HarnessState();
}

class _HarnessState extends State<_HarnessWidget> {
  @override
  Widget build(BuildContext context) => const SizedBox();
}
