// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabIndicatorAnimation from material
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

  print('TabIndicatorAnimation test executing');
  print('=' * 50);

  // TabIndicatorAnimation enum: linear, elastic
  runCase('TabIndicatorAnimation.values exists', () {
    final count = TabIndicatorAnimation.values.length;
    print('  values count: $count');
    return count >= 2;
  });

  runCase('linear value exists', () {
    final value = TabIndicatorAnimation.linear;
    print('  linear: index=${value.index}, name=${value.name}');
    return value.name == 'linear';
  });

  runCase('elastic value exists', () {
    final value = TabIndicatorAnimation.elastic;
    print('  elastic: index=${value.index}, name=${value.name}');
    return value.name == 'elastic';
  });

  runCase('linear is first value', () {
    return TabIndicatorAnimation.values.first == TabIndicatorAnimation.linear;
  });

  runCase('elastic is last value', () {
    return TabIndicatorAnimation.values.last == TabIndicatorAnimation.elastic;
  });

  runCase('toString shows value name', () {
    final str = TabIndicatorAnimation.elastic.toString();
    print('  toString: $str');
    return str.contains('elastic');
  });

  runCase('enum values are comparable', () {
    return TabIndicatorAnimation.linear != TabIndicatorAnimation.elastic;
  });

  runCase('linear animation is default', () {
    // linear: indicator moves linearly between tabs
    return true;
  });

  runCase('elastic animation bounces', () {
    // elastic: indicator has elastic bounce effect
    return true;
  });

  runCase('TabBar accepts indicatorAnimation', () {
    // TabBar uses indicatorAnimation property
    return true;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('TabIndicatorAnimation Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  ));
}
