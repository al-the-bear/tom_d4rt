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


class _KeepAliveParentData extends ParentData with KeepAliveParentDataMixin {
  @override
  bool get keptAlive => keepAlive;
}

class _SliverKeepAliveProbe extends RenderSliver with RenderSliverWithKeepAliveMixin {
  @override
  void performLayout() {
    geometry = const SliverGeometry(scrollExtent: 0, paintExtent: 0, maxPaintExtent: 0);
  }
}

dynamic build(BuildContext context) {
  print('RenderSliverWithKeepAliveMixin comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final probe = _SliverKeepAliveProbe();
  _check(logs: logs, label: 'probe instantiated', condition: probe is RenderSliverWithKeepAliveMixin);

  final child = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 10, height: 10));
  child.parentData = _KeepAliveParentData()..keepAlive = true;

  probe.setupParentData(child);
  _check(logs: logs, label: 'setupParentData accepts KeepAlive parentData', condition: child.parentData is KeepAliveParentDataMixin);

  final pd = child.parentData! as KeepAliveParentDataMixin;
  _check(logs: logs, label: 'keepAlive flag is true', condition: pd.keepAlive);
  _check(logs: logs, label: 'keptAlive getter works', condition: pd.keptAlive);

  pd.keepAlive = false;
  _check(logs: logs, label: 'keepAlive flag toggles', condition: !pd.keepAlive);

  final second = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 2, height: 2));
  second.parentData = _KeepAliveParentData();
  probe.setupParentData(second);
  _check(logs: logs, label: 'second child setup succeeds', condition: second.parentData is KeepAliveParentDataMixin);

  probe.layout(const SliverConstraints(
    axisDirection: AxisDirection.down,
    growthDirection: GrowthDirection.forward,
    userScrollDirection: ScrollDirection.idle,
    scrollOffset: 0,
    precedingScrollExtent: 0,
    overlap: 0,
    remainingPaintExtent: 100,
    crossAxisExtent: 100,
    crossAxisDirection: AxisDirection.right,
    viewportMainAxisExtent: 100,
    remainingCacheExtent: 100,
    cacheOrigin: 0,
  ));
  _check(logs: logs, label: 'layout with sliver constraints succeeds', condition: probe.geometry != null);

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('RenderSliverWithKeepAliveMixin comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'RenderSliverWithKeepAliveMixin Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}
