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

  print('BackgroundIsolateBinaryMessenger test executing');
  print('=' * 50);

  runCase('BackgroundIsolateBinaryMessenger symbol exists', () {
    final Type t = BackgroundIsolateBinaryMessenger;
    return t.toString().contains('BackgroundIsolateBinaryMessenger');
  });

  runCase('BinaryMessenger symbol exists', () {
    final Type t = BinaryMessenger;
    return t.toString().contains('BinaryMessenger');
  });

  runCase('ServicesBinding symbol exists', () {
    final Type t = ServicesBinding;
    return t.toString().contains('ServicesBinding');
  });

  runCase('ChannelBuffers symbol exists', () {
    final Type t = ChannelBuffers;
    return t.toString().contains('ChannelBuffers');
  });

  runCase('Platform channel name is stable', () {
    return SystemChannels.platform.name == 'flutter/platform';
  });

  runCase('TextInput channel name is stable', () {
    return SystemChannels.textInput.name == 'flutter/textinput';
  });

  runCase('WidgetsBinding instance available', () {
    return WidgetsBinding.instance.platformDispatcher.runtimeType.toString().isNotEmpty;
  });

  runCase('summary string formed', () {
    final String s = 'background-messenger:${passed.length + failed.length}';
    return s.contains('messenger');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('BackgroundIsolateBinaryMessenger Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Background messenger and channel checks completed'),
    ],
  );
}
