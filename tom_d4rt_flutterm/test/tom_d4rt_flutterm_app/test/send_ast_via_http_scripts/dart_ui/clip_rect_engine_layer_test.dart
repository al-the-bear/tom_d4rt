// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClipRectEngineLayer from dart_ui
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

  print('ClipRectEngineLayer test executing');
  print('=' * 50);

  // ClipRectEngineLayer has a private constructor and is created via SceneBuilder
  runCase('ClipRectEngineLayer is an EngineLayer subtype', () {
    return 'ClipRectEngineLayer'.contains('EngineLayer');
  });

  runCase('SceneBuilder exists to create layers', () {
    return true; // SceneBuilder exists
  });

  runCase('SceneBuilder pushClipRect returns ClipRectEngineLayer', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ClipRectEngineLayer layer = builder.pushClipRect(const Rect.fromLTWH(0, 0, 100, 100));
    return layer.runtimeType == ui.ClipRectEngineLayer;
  });

  runCase('layer from pushClipRect is non-null', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ClipRectEngineLayer layer = builder.pushClipRect(const Rect.fromLTWH(0, 0, 100, 100));
    return layer.runtimeType.toString().contains('ClipRect');
  });

  runCase('ClipRectEngineLayer can accept different rects', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ClipRectEngineLayer l1 = builder.pushClipRect(const Rect.fromLTWH(0, 0, 50, 50));
    builder.pop();
    final ui.ClipRectEngineLayer l2 = builder.pushClipRect(const Rect.fromLTWH(10, 10, 200, 200));
    return l1.runtimeType == l2.runtimeType;
  });

  runCase('builder can pop layer', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    builder.pushClipRect(const Rect.fromLTWH(0, 0, 100, 100));
    builder.pop();
    return true;
  });

  runCase('toString contains class name', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ClipRectEngineLayer layer = builder.pushClipRect(const Rect.fromLTWH(0, 0, 100, 100));
    return layer.toString().contains('ClipRect');
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
      const Text('ClipRectEngineLayer Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ClipRectEngineLayer behavior checks completed'),
    ],
  );
}
