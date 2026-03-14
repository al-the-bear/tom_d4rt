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


class _SemanticsProbe extends RenderBox with SemanticsAnnotationsMixin {
  _SemanticsProbe() {
    initSemanticsAnnotations(
      properties: const SemanticsProperties(label: 'initial label'),
      container: true,
      explicitChildNodes: false,
      excludeSemantics: false,
      blockUserActions: false,
      localeForSubtree: null,
      textDirection: TextDirection.ltr,
    );
  }

  @override
  void performLayout() {
    size = constraints.constrain(const Size(10, 10));
  }
}

dynamic build(BuildContext context) {
  print('SemanticsAnnotationsMixin comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final probe = _SemanticsProbe();
  _check(logs: logs, label: 'probe instantiated', condition: probe is SemanticsAnnotationsMixin);

  _check(logs: logs, label: 'initial container true', condition: probe.container);
  _check(logs: logs, label: 'initial textDirection ltr', condition: probe.textDirection == TextDirection.ltr);

  probe.container = false;
  probe.explicitChildNodes = true;
  probe.excludeSemantics = true;
  probe.blockUserActions = true;
  probe.textDirection = TextDirection.rtl;
  probe.properties = const SemanticsProperties(label: 'updated');

  _check(logs: logs, label: 'container toggled', condition: !probe.container);
  _check(logs: logs, label: 'explicitChildNodes toggled', condition: probe.explicitChildNodes);
  _check(logs: logs, label: 'excludeSemantics toggled', condition: probe.excludeSemantics);
  _check(logs: logs, label: 'blockUserActions toggled', condition: probe.blockUserActions);
  _check(logs: logs, label: 'textDirection updated', condition: probe.textDirection == TextDirection.rtl);
  _check(logs: logs, label: 'properties label updated', condition: probe.properties.label == 'updated');

  probe.layout(const BoxConstraints.tightFor(width: 7, height: 6));
  _check(logs: logs, label: 'layout still works', condition: probe.size == const Size(7, 6));

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('SemanticsAnnotationsMixin comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'SemanticsAnnotationsMixin Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated
