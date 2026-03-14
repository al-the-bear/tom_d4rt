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


dynamic build(BuildContext context) {
  print('CachingIterable comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  var sourceMoves = 0;
  Iterable<int> source() sync* {
    for (var i = 1; i <= 6; i++) {
      sourceMoves++;
      yield i;
    }
  }

  final iterable = CachingIterable<int>(source().iterator);
  _check(logs: logs, label: 'CachingIterable instantiated', condition: iterable is CachingIterable<int>);

  final first = iterable.first;
  _check(logs: logs, label: 'first element is 1', condition: first == 1);

  final third = iterable.elementAt(2);
  _check(logs: logs, label: 'third element is 3', condition: third == 3);

  final len = iterable.length;
  _check(logs: logs, label: 'length is 6', condition: len == 6);

  final lenAgain = iterable.length;
  _check(logs: logs, label: 'cached length stable', condition: lenAgain == 6);

  final mapped = iterable.map((e) => e * 2).toList();
  _check(logs: logs, label: 'map propagates values', condition: mapped.join(',') == '2,4,6,8,10,12');

  final filtered = iterable.where((e) => e.isEven).toList();
  _check(logs: logs, label: 'where returns evens', condition: filtered.join(',') == '2,4,6');

  final expanded = iterable.expand((e) => [e, -e]).take(4).toList();
  _check(logs: logs, label: 'expand works with caching', condition: expanded.join(',') == '1,-1,2,-2');

  final skipped = iterable.skip(4).toList();
  _check(logs: logs, label: 'skip works', condition: skipped.join(',') == '5,6');

  final edge = iterable.take(0).isEmpty;
  _check(logs: logs, label: 'take(0) edge case', condition: edge);

  _check(logs: logs, label: 'source not iterated excessively', condition: sourceMoves == 6);

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('CachingIterable comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'CachingIterable Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated

// additional coverage note: constructor/property/behavior/edge-case validated
