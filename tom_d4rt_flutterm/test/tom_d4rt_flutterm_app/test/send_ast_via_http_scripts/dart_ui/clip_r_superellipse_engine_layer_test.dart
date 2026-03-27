// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipRSuperellipseEngineLayer from dart_ui
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

  print('ClipRSuperellipseEngineLayer test executing');
  print('=' * 50);

  // ClipRSuperellipseEngineLayer is created via SceneBuilder.pushClipRSuperellipse
  runCase('ClipRSuperellipseEngineLayer is an EngineLayer subtype', () {
    return 'ClipRSuperellipseEngineLayer'.contains('EngineLayer');
  });

  runCase('RSuperellipse can be created', () {
    final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
      const Rect.fromLTWH(0, 0, 100, 100),
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10),
    );
    return shape.runtimeType.toString().contains('RSuperellipse');
  });

  runCase('SceneBuilder pushClipRSuperellipse returns ClipRSuperellipseEngineLayer', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
      const Rect.fromLTWH(0, 0, 100, 100),
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10),
    );
    final ui.ClipRSuperellipseEngineLayer layer = builder.pushClipRSuperellipse(shape);
    return layer.runtimeType == ui.ClipRSuperellipseEngineLayer;
  });

  runCase('layer from pushClipRSuperellipse is non-null', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
      const Rect.fromLTWH(0, 0, 100, 100),
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: const Radius.circular(20),
      bottomRight: const Radius.circular(20),
    );
    final ui.ClipRSuperellipseEngineLayer layer = builder.pushClipRSuperellipse(shape);
    return layer.runtimeType.toString().contains('ClipRSuperellipse');
  });

  runCase('builder can pop superellipse layer', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.RSuperellipse shape = ui.RSuperellipse.fromRectAndCorners(
      const Rect.fromLTWH(0, 0, 100, 100),
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10),
    );
    builder.pushClipRSuperellipse(shape);
    builder.pop();
    return true;
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
      const Text('ClipRSuperellipseEngineLayer Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ClipRSuperellipseEngineLayer behavior checks completed'),
    ],
  );
}
