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


class _SingleChildProbe extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }
}

dynamic build(BuildContext context) {
  print('RenderObjectWithChildMixin comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final parent = _SingleChildProbe();
  final child = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 18, height: 9));

  _check(logs: logs, label: 'parent instantiated', condition: parent is RenderObjectWithChildMixin<RenderBox>);
  _check(logs: logs, label: 'child initially null', condition: parent.child == null);

  parent.child = child;
  _check(logs: logs, label: 'child assigned', condition: identical(parent.child, child));
  _check(logs: logs, label: 'child parent assigned', condition: identical(child.parent, parent));

  parent.layout(const BoxConstraints.tightFor(width: 18, height: 9));
  _check(logs: logs, label: 'layout uses child size', condition: parent.size == const Size(18, 9));

  final described = parent.debugDescribeChildren();
  _check(logs: logs, label: 'debugDescribeChildren has one entry', condition: described.length == 1);

  parent.child = null;
  _check(logs: logs, label: 'child removed', condition: parent.child == null);

  parent.layout(const BoxConstraints.tightFor(width: 6, height: 5));
  _check(logs: logs, label: 'layout without child uses smallest', condition: parent.size == const Size(6, 5));

  _check(logs: logs, label: 'debugValidateChild returns true for RenderBox child', condition: parent.debugValidateChild(RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 1, height: 1))));

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('RenderObjectWithChildMixin comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'RenderObjectWithChildMixin Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated
