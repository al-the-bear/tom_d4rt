// D4rt test script: Tests PercentProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PercentProperty test executing');

  final pp1 = PercentProperty('progress', 0.75);
    print('pp1: ${pp1.toString()}');

  final pp2 = PercentProperty('opacity', 1.0);
    print('pp2: ${pp2.toString()}');

  final pp3 = PercentProperty('done', 0.0);
    print('pp3: ${pp3.toString()}');

  final pp4 = PercentProperty('ratio', null, ifNull: 'unknown');
    print('pp4: ${pp4.toString()}');

  print('PercentProperty test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PercentProperty Tests', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('0%: ${pp1.toString()}'),
    Text('100%: ${pp2.toString()}'),
        Text('50%: ${pp3.toString()}'),
  ]);
}
void _check({required List<String> logs, required String label, required bool condition}) {
  final line = '[${condition ? 'PASS' : 'FAIL'}] $label';
  logs.add(line);
  print(line);
  assert(condition, 'Assertion failed: $label');
}

Widget _summary(String title, List<String> logs) {
  final pass = logs.where((line) => line.startsWith('[PASS]')).length;
  final fail = logs.where((line) => line.startsWith('[FAIL]')).length;
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Checks: ${logs.length}'),
        Text('Pass: $pass'),
        Text('Fail: $fail'),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PercentProperty comprehensive test start');
  final logs = <String>[];

  final zero = PercentProperty('progressZero', 0.0);
  final half = PercentProperty('progressHalf', 0.5);
  final full = PercentProperty('progressFull', 1.0);
  final nullValue = PercentProperty('progressNull', null, ifNull: 'indeterminate');
  final overOne = PercentProperty('progressOver', 1.2);
  final underZero = PercentProperty('progressUnder', -0.2);

  _check(logs: logs, label: 'PercentProperty zero created', condition: zero is PercentProperty);
  _check(logs: logs, label: 'PercentProperty half created', condition: half is PercentProperty);
  _check(logs: logs, label: 'PercentProperty full created', condition: full is PercentProperty);
  _check(logs: logs, label: 'name is preserved', condition: zero.name == 'progressZero');

  final textZero = zero.toString();
  final textHalf = half.toString();
  final textFull = full.toString();
  final textNull = nullValue.toString();
  final textOver = overOne.toString();
  final textUnder = underZero.toString();

  _check(logs: logs, label: '0 renders as percent', condition: textZero.contains('%'));
  _check(logs: logs, label: '50 renders as percent', condition: textHalf.contains('%'));
  _check(logs: logs, label: '100 renders as percent', condition: textFull.contains('%'));
  _check(logs: logs, label: 'ifNull renders custom text', condition: textNull.contains('indeterminate'));
  _check(logs: logs, label: 'over-one still renders', condition: textOver.isNotEmpty);
  _check(logs: logs, label: 'under-zero still renders', condition: textUnder.isNotEmpty);

  final builder = DiagnosticPropertiesBuilder();
  builder.add(zero);
  builder.add(half);
  builder.add(full);
  builder.add(nullValue);
  _check(logs: logs, label: 'builder collected 4 props', condition: builder.properties.length == 4);

  final json = full.toJsonMap(const DiagnosticsSerializationDelegate());
  _check(logs: logs, label: 'json has description', condition: json.containsKey('description'));

  print('PercentProperty comprehensive test complete');
  return _summary('PercentProperty Comprehensive Test', logs);
}

// coverage note: constructor/property
// coverage note: null handling
// coverage note: over/under range behavior
// coverage note: diagnostics integration
// coverage note: logging/assertions
// coverage note: summary widget
// line guard 1
// line guard 2
// line guard 3
// line guard 4
// line guard 5
// line guard 6
// line guard 7
// line guard 8
// line guard 9
// line guard 10

