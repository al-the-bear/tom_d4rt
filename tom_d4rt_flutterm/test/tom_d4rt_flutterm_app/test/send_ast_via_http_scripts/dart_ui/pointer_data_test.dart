// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PointerData from dart_ui
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

  print('PointerData test executing');
  print('=' * 50);

  const ui.PointerData data = ui.PointerData(
    timeStamp: Duration(milliseconds: 100),
    change: ui.PointerChange.move,
    kind: ui.PointerDeviceKind.touch,
    physicalX: 100.0,
    physicalY: 200.0,
  );

  runCase('PointerData can be created', () {
    return data.runtimeType == ui.PointerData;
  });

  runCase('timeStamp is stored', () {
    return data.timeStamp == const Duration(milliseconds: 100);
  });

  runCase('change is stored', () {
    return data.change == ui.PointerChange.move;
  });

  runCase('kind is stored', () {
    return data.kind == ui.PointerDeviceKind.touch;
  });

  runCase('physicalX is stored', () {
    return data.physicalX == 100.0;
  });

  runCase('physicalY is stored', () {
    return data.physicalY == 200.0;
  });

  runCase('defaults are applied', () {
    return data.device == 0 &&
        data.buttons == 0 &&
        data.obscured == false &&
        data.pressure == 0.0;
  });

  runCase('viewId defaults to 0', () {
    return data.viewId == 0;
  });

  runCase('synthesized defaults to false', () {
    return data.synthesized == false;
  });

  runCase('custom values can be set', () {
    const ui.PointerData custom = ui.PointerData(
      buttons: 1,
      pressure: 0.5,
      tilt: 0.1,
    );
    return custom.buttons == 1 && custom.pressure == 0.5;
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
      const Text('PointerData Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('PointerData behavior checks completed'),
    ],
  );
}
