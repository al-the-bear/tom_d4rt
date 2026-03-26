// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/rendering.dart';
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

  print('viewport test executing');
  print('=' * 50);

  runCase('Viewport symbol exists', () {
    final Type t = Viewport;
    return t.toString().contains('Viewport');
  });

  runCase('ViewportOffset.zero starts at 0', () {
    final ViewportOffset o = ViewportOffset.zero();
    return o.pixels == 0.0;
  });

  runCase('AxisDirection has down', () => AxisDirection.values.contains(AxisDirection.down));
  runCase('GrowthDirection has forward', () => GrowthDirection.values.contains(GrowthDirection.forward));
  runCase('ScrollDirection has idle', () => ScrollDirection.values.contains(ScrollDirection.idle));
  runCase('CacheExtentStyle enum is populated', () => CacheExtentStyle.values.isNotEmpty);

  runCase('RenderViewport symbol exists', () {
    final Type t = RenderViewport;
    return t.toString().contains('RenderViewport');
  });

  runCase('Viewport widget can be created', () {
    final Viewport vp = Viewport(
      offset: ViewportOffset.zero(),
      slivers: const <Widget>[SliverToBoxAdapter(child: SizedBox(height: 10))],
    );
    return vp.runtimeType.toString().contains('Viewport');
  });

  runCase('summary string formed', () {
    final String s = 'viewport:${passed.length + failed.length}';
    return s.startsWith('viewport:');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('viewport Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: AxisDirection values resolved'),
      const Text('Check: GrowthDirection values resolved'),
      const Text('Check: ScrollDirection values resolved'),
      const Text('Check: CacheExtentStyle values resolved'),
      const Text('Viewport and rendering enum checks executed'),
    ],
  );
}
