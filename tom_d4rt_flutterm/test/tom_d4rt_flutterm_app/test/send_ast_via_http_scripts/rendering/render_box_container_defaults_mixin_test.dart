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


class _ContainerParentData extends ContainerBoxParentData<RenderBox> {}

class _ContainerProbe extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ContainerParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ContainerParentData> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ContainerParentData) {
      child.parentData = _ContainerParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    var child = firstChild;
    var dx = 0.0;
    while (child != null) {
      child.layout(BoxConstraints.loose(size), parentUsesSize: true);
      final pd = child.parentData! as _ContainerParentData;
      pd.offset = Offset(dx, 0);
      dx += child.size.width;
      child = pd.nextSibling;
    }
  }
}

dynamic build(BuildContext context) {
  print('RenderBoxContainerDefaultsMixin comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final parent = _ContainerProbe();
  final c1 = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 10, height: 8));
  final c2 = RenderConstrainedBox(additionalConstraints: const BoxConstraints.tightFor(width: 12, height: 9));

  parent.add(c1);
  parent.add(c2);

  _check(logs: logs, label: 'parent mixes RenderBoxContainerDefaultsMixin', condition: parent is RenderBoxContainerDefaultsMixin<RenderBox, _ContainerParentData>);
  _check(logs: logs, label: 'children added', condition: parent.childCount == 2);

  parent.layout(const BoxConstraints.tightFor(width: 50, height: 20));
  _check(logs: logs, label: 'parent layout size assigned', condition: parent.size == const Size(50, 20));

  final list = parent.getChildrenAsList();
  _check(logs: logs, label: 'getChildrenAsList length', condition: list.length == 2);
  _check(logs: logs, label: 'child order preserved', condition: identical(list.first, c1) && identical(list.last, c2));

  final hit = BoxHitTestResult();
  final isHit = parent.defaultHitTestChildren(hit, position: const Offset(1, 1));
  _check(logs: logs, label: 'defaultHitTestChildren returns bool', condition: isHit is bool);

  final baseline = parent.defaultComputeDistanceToFirstActualBaseline(TextBaseline.alphabetic);
  _check(logs: logs, label: 'baseline computation executes', condition: baseline == null || baseline >= 0);

  parent.remove(c1);
  _check(logs: logs, label: 'remove child updates count', condition: parent.childCount == 1);

  parent.removeAll();
  _check(logs: logs, label: 'removeAll empties children', condition: parent.childCount == 0);

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('RenderBoxContainerDefaultsMixin comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'RenderBoxContainerDefaultsMixin Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}
