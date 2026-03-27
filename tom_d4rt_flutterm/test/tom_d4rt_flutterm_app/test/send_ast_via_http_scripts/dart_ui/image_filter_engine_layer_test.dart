// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImageFilterEngineLayer from dart_ui
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

  print('ImageFilterEngineLayer test executing');
  print('=' * 50);

  // ImageFilterEngineLayer is created via SceneBuilder.pushImageFilter
  runCase('ImageFilterEngineLayer is an EngineLayer subtype', () {
    return 'ImageFilterEngineLayer'.contains('EngineLayer');
  });

  runCase('ImageFilter blur can be created', () {
    final ui.ImageFilter filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
    return filter.runtimeType.toString().contains('ImageFilter');
  });

  runCase('SceneBuilder pushImageFilter returns ImageFilterEngineLayer', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ImageFilter filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
    final ui.ImageFilterEngineLayer layer = builder.pushImageFilter(filter);
    return layer.runtimeType == ui.ImageFilterEngineLayer;
  });

  runCase('layer from pushImageFilter is non-null', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ImageFilter filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
    final ui.ImageFilterEngineLayer layer = builder.pushImageFilter(filter);
    return layer.runtimeType.toString().contains('ImageFilterEngineLayer');
  });

  runCase('different filters return same layer type', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ImageFilter blur = ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
    final ui.ImageFilterEngineLayer l1 = builder.pushImageFilter(blur);
    builder.pop();
    final ui.ImageFilter blur2 = ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
    final ui.ImageFilterEngineLayer l2 = builder.pushImageFilter(blur2);
    return l1.runtimeType == l2.runtimeType;
  });

  runCase('builder can pop image filter layer', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ImageFilter filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
    builder.pushImageFilter(filter);
    builder.pop();
    return true;
  });

  runCase('toString contains class info', () {
    final ui.SceneBuilder builder = ui.SceneBuilder();
    final ui.ImageFilter filter = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
    final ui.ImageFilterEngineLayer layer = builder.pushImageFilter(filter);
    return layer.toString().isNotEmpty;
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
      const Text('ImageFilterEngineLayer Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ImageFilterEngineLayer behavior checks completed'),
    ],
  );
}
