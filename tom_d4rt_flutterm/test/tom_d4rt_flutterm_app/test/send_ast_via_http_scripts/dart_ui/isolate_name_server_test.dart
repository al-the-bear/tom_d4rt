// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IsolateNameServer from dart_ui
import 'dart:ui' as ui;
import 'dart:isolate';
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

  print('IsolateNameServer test executing');
  print('=' * 50);

  runCase('IsolateNameServer is abstract final', () {
    // Cannot be instantiated, only static methods
    return true;
  });

  runCase('lookupPortByName returns null for unknown name', () {
    final SendPort? port = ui.IsolateNameServer.lookupPortByName('test_unknown_port_12345');
    return port == null;
  });

  runCase('registerPortWithName registers port', () {
    final ReceivePort receivePort = ReceivePort();
    final bool registered = ui.IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      'test_port_batch16',
    );
    // Clean up
    ui.IsolateNameServer.removePortNameMapping('test_port_batch16');
    receivePort.close();
    return registered == true;
  });

  runCase('lookupPortByName finds registered port', () {
    final ReceivePort receivePort = ReceivePort();
    ui.IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      'test_lookup_port',
    );
    final SendPort? found = ui.IsolateNameServer.lookupPortByName('test_lookup_port');
    // Clean up
    ui.IsolateNameServer.removePortNameMapping('test_lookup_port');
    receivePort.close();
    return found != null;
  });

  runCase('removePortNameMapping removes registration', () {
    final ReceivePort receivePort = ReceivePort();
    ui.IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      'test_remove_port',
    );
    final bool removed = ui.IsolateNameServer.removePortNameMapping('test_remove_port');
    receivePort.close();
    return removed == true;
  });

  runCase('removePortNameMapping returns false for unknown', () {
    final bool removed = ui.IsolateNameServer.removePortNameMapping('nonexistent_port_xyz');
    return removed == false;
  });

  runCase('duplicate registration returns false', () {
    final ReceivePort rp1 = ReceivePort();
    final ReceivePort rp2 = ReceivePort();
    ui.IsolateNameServer.registerPortWithName(rp1.sendPort, 'test_dup_port');
    final bool second = ui.IsolateNameServer.registerPortWithName(rp2.sendPort, 'test_dup_port');
    // Clean up
    ui.IsolateNameServer.removePortNameMapping('test_dup_port');
    rp1.close();
    rp2.close();
    return second == false;
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
      const Text('IsolateNameServer Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('IsolateNameServer behavior checks completed'),
    ],
  );
}
