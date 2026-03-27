// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeSlider from material
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

  print('RangeSlider test executing');
  print('=' * 50);

  // RangeSlider - dual-thumb slider for selecting a range
  runCase('RangeSlider can be created', () {
    final slider = RangeSlider(
      values: RangeValues(0.2, 0.8),
      onChanged: null,
    );
    print('  Created: ${slider.runtimeType}');
    return slider.runtimeType.toString().contains('RangeSlider');
  });

  runCase('values property is set', () {
    final values = RangeValues(0.3, 0.7);
    final slider = RangeSlider(
      values: values,
      onChanged: (_) {},
    );
    print('  values: ${slider.values}');
    return slider.values == values;
  });

  runCase('min can be specified', () {
    final slider = RangeSlider(
      values: RangeValues(10, 90),
      min: 0,
      max: 100,
      onChanged: null,
    );
    print('  min: ${slider.min}');
    return slider.min == 0;
  });

  runCase('max can be specified', () {
    final slider = RangeSlider(
      values: RangeValues(10, 90),
      min: 0,
      max: 100,
      onChanged: null,
    );
    print('  max: ${slider.max}');
    return slider.max == 100;
  });

  runCase('divisions makes slider discrete', () {
    final slider = RangeSlider(
      values: RangeValues(0.2, 0.8),
      divisions: 10,
      onChanged: null,
    );
    print('  divisions: ${slider.divisions}');
    return slider.divisions == 10;
  });

  runCase('labels can be provided', () {
    final labels = RangeLabels('Low', 'High');
    final slider = RangeSlider(
      values: RangeValues(0.2, 0.8),
      labels: labels,
      onChanged: null,
    );
    print('  labels: ${slider.labels}');
    return slider.labels == labels;
  });

  runCase('onChanged callback is set', () {
    RangeValues? changedValues;
    final slider = RangeSlider(
      values: RangeValues(0.2, 0.8),
      onChanged: (values) => changedValues = values,
    );
    return slider.onChanged != null;
  });

  runCase('activeColor can be specified', () {
    final slider = RangeSlider(
      values: RangeValues(0.2, 0.8),
      activeColor: Colors.blue,
      onChanged: null,
    );
    return slider.activeColor == Colors.blue;
  });

  runCase('inactiveColor can be specified', () {
    final slider = RangeSlider(
      values: RangeValues(0.2, 0.8),
      inactiveColor: Colors.grey,
      onChanged: null,
    );
    return slider.inactiveColor == Colors.grey;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('RangeSlider Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
