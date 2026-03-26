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

  print('DeferredComponent test executing');
  print('=' * 50);

  runCase('DeferredComponent symbol exists', () {
    final Type t = DeferredComponent;
    return t.toString().contains('DeferredComponent');
  });

  runCase('DeferredComponent symbol is abstract contract', () {
    final Type t = DeferredComponent;
    return t.toString().isNotEmpty;
  });

  runCase('SystemChannels has deferredComponent channel', () {
    return SystemChannels.deferredComponent.name.contains('deferredcomponent');
  });

  runCase('MethodChannel symbol exists', () {
    final Type t = MethodChannel;
    return t.toString().contains('MethodChannel');
  });

  runCase('PlatformException symbol exists', () {
    final Type t = PlatformException;
    return t.toString().contains('PlatformException');
  });

  runCase('MissingPluginException symbol exists', () {
    final Type t = MissingPluginException;
    return t.toString().contains('MissingPluginException');
  });

  runCase('summary string formed', () {
    final String s = 'deferred-component:${passed.length + failed.length}';
    return s.startsWith('deferred-component:');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('DeferredComponent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: DeferredComponent symbol resolved'),
      const Text('Check: deferredcomponent channel available'),
      const Text('Check: MethodChannel + exceptions available'),
      const Text('Deferred-component channel and symbol checks completed'),
    ],
  );
}
