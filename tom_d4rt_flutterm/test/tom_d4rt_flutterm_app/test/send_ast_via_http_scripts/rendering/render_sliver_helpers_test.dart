// Comprehensive D4rt test script
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void _check({
  required List<String> logs,
  required String label,
  required bool condition,
}) {
  final status = condition ? 'PASS' : 'FAIL';
  final line = '[$status] $label';
  logs.add(line);
  print(line);
  assert(condition, 'Assertion failed: $label');
}

Widget _summaryWidget({
  required String title,
  required List<String> logs,
  required int passCount,
  required int failCount,
}) {
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Checks: ${logs.length}'),
        Text('Pass: $passCount'),
        Text('Fail: $failCount'),
        const SizedBox(height: 6),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}


class _SliverHelpersProbe extends RenderSliver with RenderSliverHelpers {
  @override
  void performLayout() {
    geometry = SliverGeometry(
      scrollExtent: 200,
      paintExtent: calculatePaintOffset(constraints, from: 0, to: 80),
      maxPaintExtent: 200,
      cacheExtent: calculateCacheOffset(constraints, from: 0, to: 120),
      hitTestExtent: 80,
      hasVisualOverflow: true,
    );
  }
}

dynamic build(BuildContext context) {
  print('RenderSliverHelpers comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final probe = _SliverHelpersProbe();
  final constraints = const SliverConstraints(
    axisDirection: AxisDirection.down,
    growthDirection: GrowthDirection.forward,
    userScrollDirection: ScrollDirection.idle,
    scrollOffset: 10,
    precedingScrollExtent: 0,
    overlap: 0,
    remainingPaintExtent: 100,
    crossAxisExtent: 80,
    crossAxisDirection: AxisDirection.right,
    viewportMainAxisExtent: 100,
    remainingCacheExtent: 140,
    cacheOrigin: -20,
  );

  probe.layout(constraints);
  _check(logs: logs, label: 'probe instantiated with RenderSliverHelpers', condition: probe is RenderSliverHelpers);
  _check(logs: logs, label: 'geometry assigned after layout', condition: probe.geometry != null);

  final paint = probe.calculatePaintOffset(constraints, from: 0, to: 200);
  final cache = probe.calculateCacheOffset(constraints, from: 0, to: 200);
  _check(logs: logs, label: 'calculatePaintOffset within bounds', condition: paint >= 0 && paint <= constraints.remainingPaintExtent);
  _check(logs: logs, label: 'calculateCacheOffset within bounds', condition: cache >= 0 && cache <= constraints.remainingCacheExtent);

  final fromAfter = probe.calculatePaintOffset(constraints, from: 120, to: 100);
  _check(logs: logs, label: 'edge from>to clamps to zero', condition: fromAfter == 0);

  final overlap = probe.calculatePaintOffset(constraints, from: 0, to: 15);
  _check(logs: logs, label: 'partial overlap computes positive paint', condition: overlap > 0);

  final cachePartial = probe.calculateCacheOffset(constraints, from: 150, to: 160);
  _check(logs: logs, label: 'partial cache overlap computed', condition: cachePartial >= 0);

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('RenderSliverHelpers comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'RenderSliverHelpers Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}
