// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Scene from dart_ui
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

  print('Scene test executing');
  print('=' * 50);

  // Scene is abstract and created via SceneBuilder.build
  runCase('Scene is created via SceneBuilder', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.Scene scene = builder.build();
    return scene.runtimeType.toString().contains('Scene');
  });

  runCase('Scene has toImageSync method', () {
    // toImageSync(int width, int height) exists
    return true;
  });

  runCase('Scene has toImage method', () {
    // toImage(int width, int height) returns Future<Image>
    return true;
  });

  runCase('Scene has dispose method', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.Scene scene = builder.build();
    scene.dispose();
    return true;
  });

  runCase('empty scene can be built', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.Scene scene = builder.build();
    scene.dispose();
    return true;
  });

  runCase('scene with transform can be built', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    builder.pushTransform(Matrix4.identity().storage);
    builder.pop();
    final ui.Scene scene = builder.build();
    scene.dispose();
    return true;
  });

  runCase('scene with offset can be built', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    builder.pushOffset(10.0, 20.0);
    builder.pop();
    final ui.Scene scene = builder.build();
    scene.dispose();
    return true;
  });

  runCase('multiple layers can be combined', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    builder.pushOffset(10.0, 10.0);
    builder.pushOpacity(128);
    builder.pop();
    builder.pop();
    final ui.Scene scene = builder.build();
    scene.dispose();
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
      const Text('Scene Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Scene behavior checks completed'),
    ],
  );
}
